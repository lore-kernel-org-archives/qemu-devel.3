Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE58C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7H-00050n-RW; Wed, 12 Aug 2026 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6m-0004QV-37
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6i-0000K3-5J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbbuZ3995467
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4fDABiMFaO/xaHfzA5OtIuHLV6GRct9DHYuK8AefmJ0=; b=U+EuF5Rj56xI9P+i
 UJtuIgizvkhrE3aVNHVMDCu0aqlR/p4RjYztDCpJY7qS2NvwUAnjlMn9B+yoj/tq
 9cS1sGbkufuoUP9XTOdpt+Dl1/2+ivawXVonXJiEukyDPcNWYDhXyY3tkh4PBLW/
 S2LSk0c9Cnf/BVDjaHLYnBKmxcDZBC2B9OLZAOj1/SDHMptgMNhNf0SF4tMSa4tM
 cCpPBZOEiP4cJImXHI+chdudK932iremINfFHHvOxtcMrOXeUPERWhAUpt37BLT3
 za93XVDqqo3zSreIVnarO8Xz/9AuCema9kBteSZLeGQAh+6lRVTqIqPfybLWadVJ
 PgqhDw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rj3y3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb4cdf95b5aso1728884a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549385; x=1787154185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4fDABiMFaO/xaHfzA5OtIuHLV6GRct9DHYuK8AefmJ0=;
 b=NBWNNKWKON7Y8R2D3KZCvfPn020LyejuBy+IVqmiHilIL0W9UygfsgWlu5JeAH7ItM
 KAjXWhxtq9NGHarFwnhXXgZ312R7P01ILHVo5edeSYLmg4IKIhXfomifJzoIzF3XiV4q
 tyaCtDDRDPNd+g5tbsnPRPq/+WceIl8wCaR0LYNXqld3tG9KrwEv9j+kQXYDxTgIPHXu
 JWPSd8AKqqOER8oUjL+wACewKrG03yLPBbquszSVMGWJY1jLDtMEFcqbO2DaWH/FW/pF
 bbKEyPMQkfDgIvBqmyHfglV9OIOtqtZJrUkn0Ihmu1/DrY8iKRKVk8fAqRBdKsfRvyW5
 LjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549385; x=1787154185;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4fDABiMFaO/xaHfzA5OtIuHLV6GRct9DHYuK8AefmJ0=;
 b=kFDwqcQf69RzYdJE+kQFrNTrJ0kKKW3nMzJlQGIIb/BpmDuGlNcB6w+VemXz/p9RYz
 5dpDDL3WXymBD0D7xs3LdmzU+Q0v1x9LsOiLXELQK4xdPQe6CMIIBaSAj1t+pVYB8fay
 OuKnolsXyOdnobSIlSR92XgvvhUv7u6etnV08sWlupJi61P4h1dNcSMTlfxAD629jcnN
 Ww5V7WIQSCzQOaPGIUGqdyVT17ij/YrqYXi0XDYy20F9d1id/yFKZkHzmAq0ntWxwjb5
 SIh6qGdEp2wy/Px1Qjnz5d43MJN+03X5B1tDzUYQ0RiK+fXuU5ETc6+NFPkhSyV17mxT
 vclA==
X-Gm-Message-State: AOJu0YzH93r/oHR8LJVma6SLSuGpFJso3Gwn747AAKpuFwkY4E2YmFJi
 BfBFrLSYMOhwZO3AAQrE6BFLtJnLrsdOAJofDdQKob1oCGfC6TsuNeRzzGc3ljWxe2NvA4YvpKH
 7SfDM/jwYaNZMOjdAj4PBgWDlUFLt2RMkrdQeWJDifyLia7VkkZ3eKH4vpVNTZUUcDw==
X-Gm-Gg: AR+sD12CvtuyzKXCzYnRLmbC8c6HvqapoYKSW2+2UDrYlbUgXjrh0vTB0hXEVwuDa5l
 IalaBVrJZt9wGlPsA3OcG7B3qCalfd/1tkqTtLkEOJ0SX1NUv3ndtUsjI+fvWdoKJ3i0MoGDbDQ
 U9qBA4pb1aLX/vCw2g12x9ibGqqEMbxP9XOBH4jnfg3yNP3TxcgWO+K5S3yMhr7pWf9KgerTCTR
 Df7P/64mZAHRt/0TwsAsFQaR/dBPg5aBwLKPwCbdAWyhpwRrjTr6qSvtCGT+Bhp9mxA8WwK6hRB
 PC4BAitYy/g2vlPQziWOTNfUzA7pOCtaVJvbnno9nnZ1C2qCdMbIxt3zWTooV5B2zdKzAMhIe7y
 qxza3dH/FrMW3D8mWS2bDUMf4ZIekTjkrNuMGp2jfBpgfKX7P
X-Received: by 2002:a05:6a20:3d1c:b0:3c0:278c:6a31 with SMTP id
 adf61e73a8af0-3cc3f5c7203mr7621924637.11.1786549385155; 
 Wed, 12 Aug 2026 08:43:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:3c0:278c:6a31 with SMTP id
 adf61e73a8af0-3cc3f5c7203mr7621862637.11.1786549384687; 
 Wed, 12 Aug 2026 08:43:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 18/41] tests/functional/hexagon: enable more arch_tests cases
Date: Wed, 12 Aug 2026 08:41:57 -0700
Message-Id: <20260812154220.1029828-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX1x5x0O4KfrP3
 rz1UdchhzXFTsByVj1UHBae791ufTbh5oxe3/fHnktZ8wjvHsCqriqLzd5GlqUI7XhZ1DMK49hk
 4ALCHQQgawjZEu8HU3KFNOKydbFTRcJkIoH7pLoMMtfYNZLy/S4BRsbm+FiEelhG7PZT/hFUNbE
 SyRiryTzktxncCKOrphbOW4eaE9ii/SAcAUCkTT2jpgRKimeFoKIEObEq82mPV4mkanBgnjaF3i
 JxdgsXBF5vdnR4SZuk4kx8L7d3OULrk9g6A6pb68puk70LjI3jKjbYjZznzhxA2tMMvx1IM2Q7n
 +g46g4ncmqo2CiuCLcdxzgzZtlCL9EOzGM5Uae9y9VuCWkBBIdFu+5pKy1e3lCgdA7b3weuiMUm
 r6DPbTA6MTPGxEimeDgT3UBvVVCHz/0ATbci40EAahzoxDK44N75lplV86FKOKnP2XSDQ/wklBz
 PBYBRUBrQAeCygaSRcQ==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c9489 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EF0Bc5xDYwCSNCb3zeEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Zc0uJP7xcOQ9v9xtblGRBaS0iqWmKLKR
X-Proofpoint-ORIG-GUID: Zc0uJP7xcOQ9v9xtblGRBaS0iqWmKLKR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX/6H4/CsHMjmF
 r2Vt45BOpTI9UgCf1kJfcobxfC2X1diLZWOKzfq/4UOIapYdqcFcry75hf0Xq4tUYCCFgpmH+m/
 ZFZn+ABuLC2BuRR1hYK3wNChMAZp2P4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QWRkIG1vcmUgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMsIGVuYWJsZWQgYnkgUVRpbWVy
IGRldmljZS4KClRoZXNlIGV4ZXJjaXNlIGNhY2hlIG1haW50ZW5hbmNlIG9wcywgbDJ2aWMsIHRo
cmVhZCBzdGFydC9zdG9wLCB0bGIvbW11Cm9wZXJhdGlvbnMsIGFuZCB1c2VyLW1vZGUgdHJhbnNp
dGlvbnMuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBv
c3MucXVhbGNvbW0uY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzIwMjYwODA2MDQyNzIzLjM3ODUzNjktMTktYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgMzIgKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0
cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDJiYjM0ZjliOGRj
Li4wODM0Mzk4YzNiMSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
YXJjaF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5CkBAIC01OCw2ICs1OCwzOCBAQCBkZWYgdGVzdF9pbnRfc3RlZXJpbmcoc2VsZikgLT4g
Tm9uZToKICAgICAgICAgIiIiCiAgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9pbnRf
c3RlZXJpbmciKQogCisgICAgZGVmIHRlc3RfY2FjaGUoc2VsZikgLT4gTm9uZToKKyAgICAgICAg
IiIiVGVzdHMgY2FjaGUgb3BlcmF0aW9uczogZGNraWxsL2lja2lsbCwgbDJraWxsLCBkY3plcm9h
LAorICAgICAgICBkY2NsZWFuaW52YSwgY2FjaGUgZGlzYWJsZS9lbmFibGUsIGJhcnJpZXJzLCBh
bmQgZGNpbnZhL2RjY2xlYW5hLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90
ZXN0KCJ0ZXN0X2NhY2hlIikKKworICAgIGRlZiB0ZXN0X2wydmljKHNlbGYpIC0+IE5vbmU6Cisg
ICAgICAgICIiIlRlc3RzIHRoZSBMMlZJQyBpbnRlcnJ1cHQgY29udHJvbGxlcjogZW5hYmxlIHJl
YWRiYWNrLAorICAgICAgICBpbnRlcnJ1cHQgdHlwZSByZWFkYmFjaywgVklEIGNhcHR1cmUsIGFu
ZCB0aGUgZmFzdCBpbnRlcmZhY2UuCisgICAgICAgICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0
X3Rlc3QoInRlc3RfbDJ2aWMiKQorCisgICAgZGVmIHRlc3RfdGhyZWFkcyhzZWxmKSAtPiBOb25l
OgorICAgICAgICAiIiJUZXN0cyBoYXJkd2FyZSB0aHJlYWQgbWFuYWdlbWVudDogc3RhcnQvc3Rv
cCwgTU9ERUNUTCBzdGF0ZSwKKyAgICAgICAgcGVyLXRocmVhZCBIVElELCBzaGFyZWQgbWVtb3J5
LCB3YWl0L3Jlc3VtZSwgU1RJRCBwcmlvcml0eSwgYW5kCisgICAgICAgIFNDSEVEQ0ZHL0JFU1RX
QUlUIHJlYWRiYWNrLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0
ZXN0X3RocmVhZHMiKQorCisgICAgZGVmIHRlc3RfdGxiX21tdShzZWxmKSAtPiBOb25lOgorICAg
ICAgICAiIiJUZXN0cyBUTEIvTU1VIG9wZXJhdGlvbnM6IHdyaXRlL3JlYWQvcHJvYmUvaW52YWxp
ZGF0ZSwKKyAgICAgICAgZ2xvYmFsIGVudHJpZXMsIG11bHRpcGxlIGVudHJpZXMsIG92ZXJ3cml0
ZSwgQVNJRCBtYXRjaGluZywKKyAgICAgICAgYW5kIHBlcm1pc3Npb24gY2hlY2tzLgorICAgICAg
ICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3RsYl9tbXUiKQorCisgICAg
ZGVmIHRlc3RfdXNlcl9tb2RlKHNlbGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIHVzZXIg
bW9kZSAvIHByaXZpbGVnZSB0cmFuc2l0aW9uczogc3VwZXJ2aXNvciBtb2RlLAorICAgICAgICBT
U1IgVU0vSUUvWEUvQ0UvUEUgYml0cywgYW5kIHRoZSB0cmFwMCB1c2VyLW1vZGUgZXhpdCBoYW5k
bGVyLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3VzZXJf
bW9kZSIpCisKIAogaWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKICAgICBRZW11U3lzdGVtVGVz
dC5tYWluKCkKLS0gCjIuMzQuMQoK

