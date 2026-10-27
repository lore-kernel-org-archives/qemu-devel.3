Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AA606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aCyyc2ut;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HV573wAM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtJ-0002e9-HY; Mon, 26 Oct 2026 23:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXst-0002Aa-O5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXss-0008K1-7B
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2Er8R831474
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=; b=aCyyc2uttxJkf3WB
 46GsbCJfGdNwiQMbu+KhoEBAYpkw0+bVYSLZFaW+c+CkdVq4xActGTnbCSqLJFqq
 KTXt4ChOQ24G4NC5T7QH/imLqnzVGWN7uKb/dtMxHjrS8sVFgGVn183stRCM1kUt
 VJADWxeqBMXrqGt35m+yzrpT8ZalaPyJYJ14sNxnt4NQauL9d3v9sajoxj4i70Zz
 iCJBJiAQiuLHgWFbo5H3Wz4c7S3t2MoQPenI/yNjEQIQG7+81XD4cMxBCHXY4RSh
 V+WD1G3b57dB6YCMhpYiYUVijED5ZrK9eQPvWktokWMUPUiCQ8jUedO+90Lc+gSX
 7dtELw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavrvhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:57 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso6624043c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071796; x=1793676596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=HV573wAMgX9bbWBWGxMRZnJFKqPFvvTlb6y1CTxKc1DOa4K2fvCI6oqB8+884/O+wi
 6C2E65YNGsJXfiwqk/BVPGUVdOgQIVV9g4jLiuC3dQguwNE9d9DmSaB02nMmcse8gn1s
 HIfLITBsGJV/jrlRpsQqilKjBH+8eH27hXkWhjKvcfb1BHXyuXb710OMbaCBFeGn3NVi
 NEGws2O0nfQf1i5mdSheg14aeF/OyoAf8eylEU3RTusZXFnC8alXlNP2B2TGI6+VF441
 5stLoTfX5ZjBXKqsiCEFKoA22MjMz/snjxT8Mv/q43MVnaO4DTMi50zi8NWVCZ5igO6S
 MzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071796; x=1793676596;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=0W08ReXsNKlFwffMU8whXRTIZ/YeSsh4paW8T+1RNTseUAygF8XJYIf0CrefeN6FX7
 bODXFkGjkZAcRql6XZQAv7pux9Ly27isuR+9ofBdWSRnmcgCTLNlO2RtR83ag1o16z+B
 haQgPhlx2YGhjfp3ISrGslR6XUa2l/qN3LaHC1nfmDZYvXt/Ru5NNirokGDs42ZNI53q
 Byz24e7XGAat1fxcffKtkx+N4YDZOhRzG4sNwBQZvvbeTFNMbU5Nk99puiM6c/ScH+Kd
 2mhiBWXQs8ob2Pa+XtwsB57HhiuVvgoO3LYf1Bnl/YhB/q019LNxiQzO1xpoDBCJSHt4
 OLZA==
X-Gm-Message-State: AFq9FYIXak/Ay3D+g7AJH0IGGCRg+mT5F40HDmperZkQ0kbcokOoMTZ0
 /mwDZz76Xj6q0em77RzTVgfJAfXdZcLMijuAuYq5DRQ77wfcPMNJAwk1kCM6nKNvAUeVlNOlunj
 DJk+zV8YHorohzUyDNwcknNEGarU6GEZ4wcRptJGsI/kB3wg0HLhhGQ9UngMYc5OGXw==
X-Gm-Gg: AYBFou1+tdIg0plTI8U4lnRKKPQZ9gcvJUHVholVNcNj8wwo3lsU/LaqZtRjmcnya70
 xs7rEPRihTgvTWtjE2N1JOUE1FfUi9TyyiLWPfqBe/z1ssk84u+GePS2+hm/QO1CXOwIAH9xFG7
 1DAVEaRcHDl7FBjmrLioy802Nbr+sGIt3FcrkCKgtZM62YcBWtfflKBTQvqlSbK2eA73nvq1nbG
 A5T99GXs/bi/Ap60scFu3Fwer/l9KgXrEUZli+ymwCw6dTaHlOiQWn8X144cKa+29Cd2pleR0Y5
 4Wafc6XJUL60E+gEyMgl6lli+NN5Rsp2kEqv20EYiJF4q+3MfcftF80ZkZkrjP2Y/LSqkd4GNse
 0LyVn1r9oP+ZNyhOP0MFC8LF4as+JjVjokTUnwv8D2e3vrLnw7qybyR5tkDawbI6jGkr1dChLqo
 oJpccrJpTod5T0qZFzAGQy
X-Received: by 2002:a05:701b:42cd:10b0:187:ec67:2fc5 with SMTP id
 a92af1059eb24-1993702567cmr13239758c88.32.1793071796096; 
 Mon, 26 Oct 2026 20:29:56 -0700 (PDT)
X-Received: by 2002:a05:701b:42cd:10b0:187:ec67:2fc5 with SMTP id
 a92af1059eb24-1993702567cmr13239723c88.32.1793071795488; 
 Mon, 26 Oct 2026 20:29:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:29:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL v3 10/41] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
Date: Mon, 26 Oct 2026 20:28:56 -0700
Message-Id: <20261027032927.3055166-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: k1T8czwVFI8u6SDENY_-H-U-pI9Ze34F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX9bXfXlvA+mXM
 7ilezBPD9Kaj+1Tp017vWt3bnxdJojnvmsijn8KKNylCJCOq7GEHu2S+o/ySSsW+OwJoIUMtKyt
 sDgNxWJH9csdu2jst77BzfxLwlmioUQ=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae01ab5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EkHQ-IOB5RTo-Ixd14sA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: k1T8czwVFI8u6SDENY_-H-U-pI9Ze34F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX1cDzq/yHPHSr
 XdMnoW97f8Zb6jwbZ8ZMdBZI8dd1MyNXo1Mmmn87LyDMMCT/HFE50cdDnarmDpk/VxSY57PdXE6
 Gx2w8HuXZtroTQw3FbD2PLaC5OnFiAfVOlPE2brzl7XXu1WMd+PpIXp/uo96whzYDWhsDfaY1At
 eUO6k0n570lLx0xaMZ+o1ANLMatm99lQvbpDDWBLyqmiJ6yaqPcHnjR4jDn9TN5nDCuQqeC/Q4D
 sxXiHZqvf2UMScwXyhC1WlPi10OBuNzslpSQUvSph60CG3YBV75xt0xJmxRmHK3xw6p/kXDSkS6
 uiKycb7mEQNiObqsb1ZyXrGDoRPmy7bs1APOMLC3peLXZGkagMmFnLHY9zBpEm2EFeIBVB1RUH0
 QOyEeV/13BfZNiASHysZBLl3e1ALZ5fi8pcDgioCd9lZqi86+JZLDozW7GTVGhqQ4eDWlmG1gH5
 qvBci6m92mfdGsybZqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

