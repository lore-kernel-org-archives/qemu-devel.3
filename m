Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB95606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lgUF6fSm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yegg/obc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Rq-0002ZG-0k; Thu, 22 Oct 2026 21:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RA-0001MY-6a
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4R8-0006J0-7m
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EvjZ772906
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=; b=lgUF6fSmUWxIpc9y
 XJm2UrtF+Y4/1TVaU32pO2ibIqYOFgVtaN0Sn8DoloEIxA6THOs6+31hqhESjmPO
 /ojFcI154IwuODsu+eyu3GwKMS0RKBnWd8JhQCvSl+s8fZ+NoKOukE3pmavxq8pK
 N6R/8OfLyWiQpLcWAtGqKEKqLQKIDl7NmcmJvKLFTRcRTPOmx9tfYzP8qAQtlZIm
 0FtkEYNDSN/HoPjlB6rSZJLDEYGfsvG2JfjnWzGFOjC1UB2TKz6Un7iSuZXSOvJl
 czmIjV3va99Gmht+jOpvcCr47HQweQ+cq4M8BQYifYH/6jphjhsDZ3CY8uV1N+Ki
 XaY0xg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtsbsn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so654741eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720262; x=1793325062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=Yegg/obcomgmbZZj7g9QrO4HYax0kdIN1wSsSxNxzFe8lGxizsmBqUaQXk7DMP2HFP
 iHbk/l39IRYvKgNhdgzLKZy4iEn2CU+6doZ+HcFvSYyU/coxwC5+su1ygBawxgtCCPh1
 XOBcXuk18kwzch6nmTFmy3/UaDcW/IJfQ/YYydY/1j8SD9LCHDcb5ENmcKVpkmu9cz+3
 y+oahRS70jTqAYQCcTOyfmVSSybRRETT9ORGo3sTOcrAbLBLqctesBEZ0+pdjT5P5jTn
 j8XySPUU/O2qNUC3frgLSytA6ZKW6HcD5kqrQJ31sRpXQ2QT2U0OkmohnujWwEuDFQDa
 V5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720262; x=1793325062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=wMURPII+v+ZCxM20lmM7Z9VAzstvBp0p8ErY7AaYzWJ5umhptqKWlaxc7kKqNj2GKl
 6wtWCamrw2irBgtel2Wkrn4brMRa/gBCPkkKGzTLyAsM8EPVyCJVm7BOKHNwerEfmjtt
 3bw+op5A5WbP+u0kE065sIVHXRL5Ubod/FprQZ5oSYozLYAueDchNv2fPmKVZKqZikaq
 8WZe1lFs+mVn6fN0l8ck3TRE5GnNg82lr9Gm0G+GukMFe7eArjku66vgPtMUN29RKpp+
 Q6Dad70qxoRUWvaAlRHHfOnIyvGAsB6/cZ+uiR9OCQd1DBOGP93kPDog3t599ROtdQJe
 vMAQ==
X-Gm-Message-State: AFq9FYJ1CVsuxPXx9iNxM50+PVmSvdE/FESlJHbl8uwfQtM11hQPnFqE
 A7T2HYHAnQ32r36bU9YU51HQstxhuHKD7QRhs4nIYPqokI9l6aT1x+yMTIeK7VIxCp5SAyKRu79
 81P6bFjpeTFIc1tkvNhu2ypM/1bywHj0CPCrvYnTAQHdFz2lXpyWmPlln87f8K50KDw==
X-Gm-Gg: AYBFou3RF0Ua0568FZe+g1T4PM+fLzqZsWw+RIHPfG693Cso8//k/BK7C9HMDZPxsDo
 hwkEnihQzl9XAc/A/WW/aRAgkWjqpvPC4Juz99W/hVFSw42sNVUhx9E27VnrDVpIsBlgXJfuW9l
 ZjXtlIMfq+PETgYxQ3s9apXGkD+5OQiZFk/K4YcXWpqULFO1DCRLIRYQqGJz8Ic3EFTepgLLPpM
 WvAMrZRQuIYH5GwfTN2XX62NsAkjLBlHWD3Ff/A2xEu6nOvOxYVyxp8f+dOo/24UETIt+GJYRLJ
 wC3NQl9KZyI+DSVWY631PvApB2JP40RLbONk6rLkWi796VyZ1835Rli6+HHqM7owvu6MChmJgmB
 cC8vtc/jdxRZSIV6pI8+aNqsFE/1w0fRx6LCS24SN/kikfKIj
X-Received: by 2002:a05:7300:d20a:b0:35d:8c39:b314 with SMTP id
 5a478bee46e88-369d98269fdmr949862eec.37.1792720262130; 
 Thu, 22 Oct 2026 18:51:02 -0700 (PDT)
X-Received: by 2002:a05:7300:d20a:b0:35d:8c39:b314 with SMTP id
 5a478bee46e88-369d98269fdmr949839eec.37.1792720261578; 
 Thu, 22 Oct 2026 18:51:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL 11/43] target/hexagon: reject reserved L4_loadw_phys encoding
 from v83
Date: Thu, 22 Oct 2026 18:50:08 -0700
Message-Id: <20261023015040.2473105-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adabd86 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EkHQ-IOB5RTo-Ixd14sA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: xXBb6xrLB6x957Qx_sSmIZvvm7r5skbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX4UC3X1J79oxA
 iaqcwRzlMKyiOMg8GG5ldcygXbrQueZ3m7XJxfcv5kB6FRyzYWSe8GbDAfSVY4rTvMZLP/tfoYb
 j+pZtHp4lQgWhRqh8CXWEZG+Rt2bT9Te42or26LtOaJtCwXrxkoU6/ttkYfx1UVdl2YBJSY6Nyc
 xZ3a/Xr5pCDKGCx2wL57alkxMrsOwhzTwgo+iXy5BII08u4EBxGKWgkEpvN95d0SH0bwyJmKYfO
 atUx9ADmM5vTW6kz1vt6YY1Mp+CnBDx3LScQA/TjIXyR3wmNF54Y2nBDh7F+/qCLb5P7BT5CRu4
 ltq/paKnyOIzRgMytC7jzGpFwvF/j6bBc+gA2QJ/E/LjYaGx+50NS2BpyL7zfezqa2oXeA0En7i
 VINIhyUlwINjjWhFWxe3X4cCGMsVIMUjMVWbPI82SRcz9PCbv77XC2G1oksgr7ypXkS5vn/JmVM
 uTfhoKjsOl0YtPtYHEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX4msIOAreNmL4
 JpqPlfkyTK99ODi0cWuDyOMm1uV650xfcu6XZIci4HLXwLjHY5nMCHT3m3+Xz2gjZ0TydyRJbtU
 6UJir6ZudIqPcxo4iZ4GXjZtl80z3tY=
X-Proofpoint-ORIG-GUID: xXBb6xrLB6x957Qx_sSmIZvvm7r5skbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qml0IDcgb2YgTDRfbG9hZHdfcGh5cyBpcyB2YWxpZCB0aHJvdWdoIHY4MSBidXQgcmVzZXJ2ZWQg
c3RhcnRpbmcKd2l0aCB2ODMuIERlY29kZSBpdCBhcyBhIGxlZ2FjeSBkb24ndC1jYXJlIGJpdCwg
dGhlbiByZWplY3QgaXQgZm9yIHY4MwphbmQgbGF0ZXIuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
TWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2RlY29kZS5oICAgIHwgIDIgKysKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgIHwg
MTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMgfCAgMyAr
Ky0KIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5oIGIvdGFyZ2V0L2hleGFnb24vZGVjb2Rl
LmgKaW5kZXggZDRiMDQ5OTYxZWQuLjFlMWUzMzliMDhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9kZWNvZGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuaApAQCAtMzEsNSArMzEs
NyBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG1heF93b3Jkcywg
Y29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAgICAgICAgICAgUGFja2V0ICpwa3QsIGJv
b2wgZGlzYXNfb25seSk7CiAKIGJvb2wgb3Bjb2RlX3N1cHBvcnRlZCh1aW50MTZfdCBvcGNvZGUs
IGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOworYm9vbCBlbmNvZGluZ19zdXBwb3J0ZWQo
dWludDE2X3Qgb3Bjb2RlLCB1aW50MzJfdCBlbmNvZGluZywKKyAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOwogCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKaW5kZXgg
YTI4YmY5Y2U5ZmUuLjM1ZDc0MWNlODY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtNjkyLDYgKzY5MiwyMiBAQCBi
b29sIG9wY29kZV9zdXBwb3J0ZWQodWludDE2X3Qgb3Bjb2RlLCBjb25zdCBIZXhhZ29uQ1BVRGVm
ICpoZXhfZGVmKQogICAgIHJldHVybiB0cnVlOwogfQogCisvKgorICogU29tZSBlbmNvZGluZ3Mg
b2YgYW4gb3RoZXJ3aXNlIHN1cHBvcnRlZCBvcGNvZGUgYXJlIHJlc2VydmVkIG9uIG5ld2VyCisg
KiB2ZXJzaW9ucy4gIEhFWF9WRVJfQU5ZICh1c2VkIHdoZW4gb25seSBkaXNhc3NlbWJsaW5nKSBh
Y2NlcHRzIGV2ZXJ5dGhpbmcuCisgKi8KK2Jvb2wgZW5jb2Rpbmdfc3VwcG9ydGVkKHVpbnQxNl90
IG9wY29kZSwgdWludDMyX3QgZW5jb2RpbmcsCisgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmKQoreworICAgIC8qIEJpdCA3IG9mIEw0X2xvYWR3X3Bo
eXMgYmVjYW1lIHJlc2VydmVkIGluIHY4My4gKi8KKyAgICBpZiAoaGV4X2RlZi0+aGV4X3ZlcnNp
b24gIT0gSEVYX1ZFUl9BTlkgJiYKKyAgICAgICAgaGV4X2RlZi0+aGV4X3ZlcnNpb24gPj0gSEVY
X1ZFUl9WODMgJiYKKyAgICAgICAgb3Bjb2RlID09IEw0X2xvYWR3X3BoeXMgJiYgKGVuY29kaW5n
ICYgMHg4MCkpIHsKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKyAgICByZXR1cm4gdHJ1
ZTsKK30KKwogLyoKICAqIGRlY29kZV9wYWNrZXQKICAqIERlY29kZXMgcGFja2V0IHdpdGggZ2l2
ZW4gd29yZHMKQEAgLTcyMiw2ICs3MzgsOSBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IG1heF93b3JkcywgY29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAg
ICAgLyogSW52YWxpZCBpbnN0cnVjdGlvbiBlbmNvZGluZyAqLwogICAgICAgICAgICAgcmV0dXJu
IDA7CiAgICAgICAgIH0KKyAgICAgICAgaWYgKCFlbmNvZGluZ19zdXBwb3J0ZWQoaW5zbi0+b3Bj
b2RlLCBlbmNvZGluZzMyLCBjdHgtPmhleF9kZWYpKSB7CisgICAgICAgICAgICByZXR1cm4gMDsK
KyAgICAgICAgfQogICAgICAgICAvKgogICAgICAgICAgKiBJZiB3ZSBzYXcgYW4gZXh0ZW5kZXIs
IG1hcmsgbmV4dCB3b3JkIGV4dGVuZGVkIHNvIGltbWVkaWF0ZQogICAgICAgICAgKiBkZWNvZGUg
d29ya3MKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jIGIvdGFyZ2V0L2hl
eGFnb24vcHJpbnRpbnNuLmMKaW5kZXggMDIzZWExMmRiYTUuLmNkYjlkY2Q3ZGU5IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9wcmludGluc24uYworKysgYi90YXJnZXQvaGV4YWdvbi9wcmlu
dGluc24uYwpAQCAtMTcxLDcgKzE3MSw4IEBAIHZvaWQgc25wcmludF9hX3BrdF9kaXNhcyhHU3Ry
aW5nICpidWYsIFBhY2tldCAqcGt0LCB1aW50MzJfdCAqd29yZHMsCiAgICAgICAgIH0KIAogICAg
ICAgICBnX3N0cmluZ19hcHBlbmQoYnVmLCAiXHQiKTsKLSAgICAgICAgaWYgKG9wY29kZV9zdXBw
b3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgY2ZnLT5oZXhfZGVmKSkgeworICAgICAgICBpZiAo
b3Bjb2RlX3N1cHBvcnRlZChwa3QtPmluc25baV0ub3Bjb2RlLCBjZmctPmhleF9kZWYpICYmCisg
ICAgICAgICAgICBlbmNvZGluZ19zdXBwb3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgd29yZHNb
aV0sIGNmZy0+aGV4X2RlZikpIHsKICAgICAgICAgICAgIHNucHJpbnRpbnNuKGJ1ZiwgJihwa3Qt
Pmluc25baV0pKTsKICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZChidWYsICI8aW52YWxpZD4iKTsKLS0gCjIuMzQuMQoK

