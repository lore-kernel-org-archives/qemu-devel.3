Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF060A261A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=biXMSFJ0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ifKWNgHd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIr8H-0001P0-M2; Mon, 19 Oct 2026 13:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr8F-0001OW-Ku
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr8D-0000R1-VX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPBgw3115107
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 97NxrAFgVAhTxR6I/6Y5X7ZZImr6P++dbglEP9kEqAc=; b=biXMSFJ0eEyo/npK
 wHx5eG3H2M0qX8waGYVSuzVYFEk/Z/SDWcObLW4nqHwJBvh2YUqxQl27W8I9r674
 kXgS2gZYXKsoLq4RwCPNB3i3jjKRXwivDAaeBj5QFfVy04AEw22Q5ryX6WklUB+N
 GKWXEZ6GFaILrimuBP5MmwlBGt/StHwrYZt6aMKl24VJMh2NqnU656DgqBf7ihmm
 0W4Ij3jXfAvFE9jfFppMxGTExhXFQ6DK/K23w4cCuzNKAg0wGqtIQsGwNYY7ZI6v
 yenO32fY4LRU8jUPgIFYh7w14HDYPn1zH7bamVIS/CABT/bPpcI0N8we90vln1Hq
 t+gi6Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1byvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so7025129eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792430800; x=1793035600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=97NxrAFgVAhTxR6I/6Y5X7ZZImr6P++dbglEP9kEqAc=;
 b=ifKWNgHdNd9f2AkWuHQw6RLc2hS5Aw/UU2g9vdipBl9wrtqn/2J9kezAXzhnZ+kN4c
 M7R061Kk8a9nlDm0gXyRrG/ybc/YqAh7WC8xm1sR3VlStbtac845Bxwt/AqhgU5JV5kV
 LEVSfp9SiRqcAlu1DUCssQtB0vom6Qq8eejpuCmh+mZb2eRNHH4HuNXGV0PsxgCz6HEP
 l5JICb4jYrhx071wkdPYplZGS45TMTYzBsqUyfIGutYqgO5q0lxZAWuoA7pXuoC+o7Ia
 9fMHkBTfHlpIvAgujT/yyxcmgv0+uP3SILin9DMxee1unBMY7ywrQ/IEq9/JR3YIkAoC
 s7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430800; x=1793035600;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=97NxrAFgVAhTxR6I/6Y5X7ZZImr6P++dbglEP9kEqAc=;
 b=vTyR1m6AM9e4po3S2GlbOkPOxKP61jl+I4gV+CAwGiOgeeCYMEHkJ87jxJoFtlvEdY
 3IVftxRAwTMRhjCRpS0UwRWI5nS3Rf7opUU03Q36ZfpZVcxvZWXSxPRwFqX4cvrLy49m
 kWHTuDGGYOKI5PhlTkTcnasPmo0Xb8f0Yq2Rx9WsVWkSPC41SsyG752RbwfR4yYnNybQ
 LBjOvANr8Oy1be9dccrC6EZZu/op8aKRhR1ydk0JprFT81nSvBzX4zy9TEWGm4l3mt6R
 KRY8w+uluKFxFMV8fCBnBZYe6th0g2j3o3UAJo2YtTVP+we2OWzW/U9Yx1V5EiVN14fU
 dlQQ==
X-Gm-Message-State: AFq9FYKbwZVtu8VC4iPExBsTlBJAY7kp5gKCEf0vrz6bnCu9kLJWy2Om
 MGDISFUOXBu1/K6+PoGzxZMVEUxdDt1vXISHf4NJb0dZGimqDkmQQ+6E9cIemhKUbI8bwY03yIw
 E309Kw7NULOiTV/t4SJLu2XCue9YUI13l/Bcmsk27xaTJlQeuFIofUAGbVExwUY0xuw==
X-Gm-Gg: AYBFou0QzoCYr3ISdGnE0bWN+rLEHlRJQgdqIxM8yVd4ooJIb4GhKKsfDOIg0oiKfQw
 54jUe1L/80xwbh1DPeK5lolgrx3olgOCA3C/j4X7amuAV13STlkvh/ZoD6Hx7aGBQcYUMv8NWMB
 dd2GwXw7EOHoPuRPJ8Ysw0vMuosjbajkASOFEW+zySxvF3wqqGtvYRLvCnD2XNuipCZZNQ3gj0x
 qFpT2tnlM2kXYwESeRsEusBIjEewQNitJwYkNbMJNWQxdwlJi/3urG+qJDpT7uf5u6wxoV1ablT
 Ia5X5OhA+g4dboCkWD5dNe7ZN4CnRF7IC6leMT7LwRX+hdCD+305uA78Nq5xVR+11TiRE5qfTRZ
 pLgxpC+JXPP7pRj4GYmlRljjyIdfHHOQF/UvV3Mx7vUpagiQ=
X-Received: by 2002:a05:693c:8814:10b0:358:7bea:88d5 with SMTP id
 5a478bee46e88-361a2354271mr13248229eec.21.1792430799817; 
 Mon, 19 Oct 2026 10:26:39 -0700 (PDT)
X-Received: by 2002:a05:693c:8814:10b0:358:7bea:88d5 with SMTP id
 5a478bee46e88-361a2354271mr13248196eec.21.1792430799330; 
 Mon, 19 Oct 2026 10:26:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6791sm38243061eec.6.2026.10.19.10.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:26:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 07/11] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
Date: Mon, 19 Oct 2026 10:25:59 -0700
Message-Id: <20261019172603.2625677-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX/H/14qFOGeOr
 U56cu/fzbNMfVIAoBSntgB4i1lRLeMF08fwTxgN3QhG2YLUCcGovLW4/ANkLTfjJWOD80FSVJIe
 dGZEogVwjD3k+AgCirz2kPAyIlNiaUs=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad652d0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZPU1edz-ZL-WDSxyazgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfXzaHq0rT96bPM
 fnNrKfLbTL6qvOGEK5tSxjOxLDyiLQ2UmJtVnhRN/HrRxYZ8EYrw9M3rRBhlilmkbRn7UsxlTRd
 yFg2bLn6+MK6whu8ffoGdtkEe6DqIejTpEBSetfjOvh7RmT+Q/XXSVwy0uj26OIpH0ozqIoNO4V
 6GHrNixqB/7gzkKWn6PqZpXACE6T+IgTabGGAeZ2RCCZPbtZWKVBtFQyI8Rm0R5fYyCXHBHV+3q
 UmMykzhncsPD2G9T0u75SlAjetzXP8zWux5gIzwEiLLQekOBWnkJT02cMtHmV9RqFfaB1bWJWgI
 ZZUjgW0cMPpf3lN2G/1W7ofJ3uc5cH8gO8/XSXafM+VTfP2xh80abMtTIqCxfvQNGtWZmzLNPs5
 LsxwffPkqDf3TW4q6bXeYUPqCVe7L0zIMQYcM631NXtiU7AfX6HuZqWr6CztTzDmEH0pGUKVhnw
 KS9uxLrBP+HK9cQxmlQ==
X-Proofpoint-ORIG-GUID: jmFlSYtb_NKPPRdbQv2ul1SXgofdKJJA
X-Proofpoint-GUID: jmFlSYtb_NKPPRdbQv2ul1SXgofdKJJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190069
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
dGhlbiByZWplY3QgaXQgZm9yIHY4MwphbmQgbGF0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZGVj
b2RlLmggICAgfCAgMiArKwogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgICAgfCAxOSArKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9wcmludGluc24uYyB8ICAzICsrLQogMyBmaWxl
cyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vZGVjb2RlLmggYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuaAppbmRleCBk
NGIwNDk5NjFlZC4uMWUxZTMzOWIwOGEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2RlY29k
ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5oCkBAIC0zMSw1ICszMSw3IEBAIGludCBk
ZWNvZGVfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbWF4X3dvcmRzLCBjb25zdCB1aW50
MzJfdCAqd29yZHMsCiAgICAgICAgICAgICAgICAgICBQYWNrZXQgKnBrdCwgYm9vbCBkaXNhc19v
bmx5KTsKIAogYm9vbCBvcGNvZGVfc3VwcG9ydGVkKHVpbnQxNl90IG9wY29kZSwgY29uc3QgSGV4
YWdvbkNQVURlZiAqaGV4X2RlZik7Citib29sIGVuY29kaW5nX3N1cHBvcnRlZCh1aW50MTZfdCBv
cGNvZGUsIHVpbnQzMl90IGVuY29kaW5nLAorICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
SGV4YWdvbkNQVURlZiAqaGV4X2RlZik7CiAKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwppbmRleCA4OWU5NjEzMzFm
Zi4uYzFkZTYwMTk0YzAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC02OTEsNiArNjkxLDIyIEBAIGJvb2wgb3Bjb2Rl
X3N1cHBvcnRlZCh1aW50MTZfdCBvcGNvZGUsIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYp
CiAgICAgcmV0dXJuIHRydWU7CiB9CiAKKy8qCisgKiBTb21lIGVuY29kaW5ncyBvZiBhbiBvdGhl
cndpc2Ugc3VwcG9ydGVkIG9wY29kZSBhcmUgcmVzZXJ2ZWQgb24gbmV3ZXIKKyAqIHZlcnNpb25z
LiAgSEVYX1ZFUl9BTlkgKHVzZWQgd2hlbiBvbmx5IGRpc2Fzc2VtYmxpbmcpIGFjY2VwdHMgZXZl
cnl0aGluZy4KKyAqLworYm9vbCBlbmNvZGluZ19zdXBwb3J0ZWQodWludDE2X3Qgb3Bjb2RlLCB1
aW50MzJfdCBlbmNvZGluZywKKyAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IEhleGFnb25D
UFVEZWYgKmhleF9kZWYpCit7CisgICAgLyogQml0IDcgb2YgTDRfbG9hZHdfcGh5cyBiZWNhbWUg
cmVzZXJ2ZWQgaW4gdjgzLiAqLworICAgIGlmIChoZXhfZGVmLT5oZXhfdmVyc2lvbiAhPSBIRVhf
VkVSX0FOWSAmJgorICAgICAgICBoZXhfZGVmLT5oZXhfdmVyc2lvbiA+PSBIRVhfVkVSX1Y4MyAm
JgorICAgICAgICBvcGNvZGUgPT0gTDRfbG9hZHdfcGh5cyAmJiAoZW5jb2RpbmcgJiAweDgwKSkg
eworICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgfQorICAgIHJldHVybiB0cnVlOworfQorCiAv
KgogICogZGVjb2RlX3BhY2tldAogICogRGVjb2RlcyBwYWNrZXQgd2l0aCBnaXZlbiB3b3JkcwpA
QCAtNzIxLDYgKzczNyw5IEBAIGludCBkZWNvZGVfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4LCBp
bnQgbWF4X3dvcmRzLCBjb25zdCB1aW50MzJfdCAqd29yZHMsCiAgICAgICAgICAgICAvKiBJbnZh
bGlkIGluc3RydWN0aW9uIGVuY29kaW5nICovCiAgICAgICAgICAgICByZXR1cm4gMDsKICAgICAg
ICAgfQorICAgICAgICBpZiAoIWVuY29kaW5nX3N1cHBvcnRlZChpbnNuLT5vcGNvZGUsIGVuY29k
aW5nMzIsIGN0eC0+aGV4X2RlZikpIHsKKyAgICAgICAgICAgIHJldHVybiAwOworICAgICAgICB9
CiAgICAgICAgIC8qCiAgICAgICAgICAqIElmIHdlIHNhdyBhbiBleHRlbmRlciwgbWFyayBuZXh0
IHdvcmQgZXh0ZW5kZWQgc28gaW1tZWRpYXRlCiAgICAgICAgICAqIGRlY29kZSB3b3JrcwpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMgYi90YXJnZXQvaGV4YWdvbi9wcmlu
dGluc24uYwppbmRleCAwMjNlYTEyZGJhNS4uY2RiOWRjZDdkZTkgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3ByaW50aW5zbi5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jCkBA
IC0xNzEsNyArMTcxLDggQEAgdm9pZCBzbnByaW50X2FfcGt0X2Rpc2FzKEdTdHJpbmcgKmJ1Ziwg
UGFja2V0ICpwa3QsIHVpbnQzMl90ICp3b3JkcywKICAgICAgICAgfQogCiAgICAgICAgIGdfc3Ry
aW5nX2FwcGVuZChidWYsICJcdCIpOwotICAgICAgICBpZiAob3Bjb2RlX3N1cHBvcnRlZChwa3Qt
Pmluc25baV0ub3Bjb2RlLCBjZmctPmhleF9kZWYpKSB7CisgICAgICAgIGlmIChvcGNvZGVfc3Vw
cG9ydGVkKHBrdC0+aW5zbltpXS5vcGNvZGUsIGNmZy0+aGV4X2RlZikgJiYKKyAgICAgICAgICAg
IGVuY29kaW5nX3N1cHBvcnRlZChwa3QtPmluc25baV0ub3Bjb2RlLCB3b3Jkc1tpXSwgY2ZnLT5o
ZXhfZGVmKSkgewogICAgICAgICAgICAgc25wcmludGluc24oYnVmLCAmKHBrdC0+aW5zbltpXSkp
OwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgZ19zdHJpbmdfYXBwZW5kKGJ1ZiwgIjxp
bnZhbGlkPiIpOwotLSAKMi4zNC4xCgo=

