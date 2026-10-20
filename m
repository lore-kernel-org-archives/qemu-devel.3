Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70D606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YZSKBAtw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bXTbUkYb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBaq-0000ez-TB; Tue, 20 Oct 2026 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBal-0000e5-2D
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBai-0005Nz-Kh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KD9sWj882008
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RMl2fanp3kKiukqBY9A5HdO8dwewASIfaa2qd584wIo=; b=YZSKBAtwmAYbxaeQ
 gQWMITH2XXVF2952M301nSwwOAFf5d1X06b0+AkIKvncri9aK9nJjviaYSD+j86m
 IZJKxS5odxDqaUgL/f83+pIXMZFwlvTP47L35ZPT2CjZM3Uvc1tvlXzE2unncqiT
 9BvtXVwcPBIj3CsXBi2zf+PVUl1TrrYO8wm34J071B1djVtrRuy1+LUVQyKWWcQL
 uo4Q4BsGKQXEdeLBPYBaOEEjz9AGQVKxebeC6bP/Mc2J2pmJgntl7E7DTqCfMt6R
 LH6Ab3FNzRvsEbMFc+yOc+MfFT/T0E7IM3cf+TwRn0UO7N1mUnebAbcMrktnXdTG
 HupaEg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n32yp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e94b4a6e8dso24158305ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792509446; x=1793114246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RMl2fanp3kKiukqBY9A5HdO8dwewASIfaa2qd584wIo=;
 b=bXTbUkYbN5BqonYCt0HUAUzXCVqRun1vuEuFltPtjzA6qbw9IGqEkOSk4HIFgFXlCT
 PCPbZc7tVleF8TwT10+ZZ9rSJSoi4bun4RfFR7n/kJRhtYqkLSdOmeTvvjrLbd9MVfzo
 2n243oNfBvmZPRI3ha08plc1S1klrnjJOg3O9s7/Xaw4PeIG1p8fNrl+xfc9S3ce0omI
 GABWywsgAegezg4ubm1XljvDjNUOFo1AoCiDWp8go23je/Goj668yuYhtMhUFzF7LrJ6
 TgoLMFZxpZqae/RabXlxaSqUxZR9InSHk75hQlgwC3lKNY27kE5HymxPNDwXNd5H2yna
 IHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509446; x=1793114246;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RMl2fanp3kKiukqBY9A5HdO8dwewASIfaa2qd584wIo=;
 b=KuLbGur0kSB4Oe8xSllxRt5dPSG4GRW4U7goKTY6C0Aqav+pF1wW2s0UKVbfiAwvSr
 5b4cm1sh8t/vI/jwl7QwOhCDbzJpePi5ng1rSfmfWO7uMw2VbmC6bBuofdGNbyLV9C/w
 UuQiZXrNBkPTRTkbftlUE/Jcyof0pvK9mvR2x3mzKLaE7MS/H5vOAQxqkraJ8RCYoF2h
 PRdMgIJ3rz22KLrVjIlXTODnhWj6vpYLFI8P/IrZfzCB24TzzIsNMyPvMxA3c8/pQCxG
 gl7JHnUiXCLAdZ3B5KPPWe5xEmHRk2Xbp5Ai0fZbAl/NML0lN8JlzDqCZWiHOefFHABL
 arIQ==
X-Gm-Message-State: AFq9FYIRDgbBkx9bw2u7AfJhIIlFV19itV8TWWlnp3fQOXytE0vNkQYf
 eGGXTp714vVgzx7qyDq616sCOqmj6bs730qY4OAd7Nn5EczdifaA7Twk98CKeqnqm/kFRBqRZ4p
 bYackKbla44njZcPWLMbmmQe/XL2dphpfguzpvg2dKinj/DdqYUGewwP0SgwkPxx1Rg==
X-Gm-Gg: AYBFou3pIDR2NmvN7i/Q2JQRadMsLcZKCwGCcINj7iNryGPE+aYA0Adzx6NzJ/xieEj
 Nk0gQbuCpeSG8dJ6hctstVzxpQUDlJEsbfVAs9b7ixY3YW2y6hABnRfV3tFXJ5hV8KkR4FZd9rR
 Lw5VHqiiWRjdXEqWN5CHujrsEpiWN8d8CqW2qyMi1sH9wT9Y9PaMzvpPXtoxtINsRUDUcz1CdS1
 kW113P64elqt1bKjGuyFX7EbkqvGxamdi4imsVDeSh4FJlpjj50cD3TNEyzo9Ky5Jw65AyuQ4YS
 ttotIJyI1r+LTeuQYAWzyGSDbGhzGpeJgVlyrKD36PF/IETGjkAGsbGcuLUGfJfp1OFXak0U+L2
 LU0b+PuGraeHUl5hNDbGLYmTqOPxEevHAiruy/QO+qejVB0U=
X-Received: by 2002:a17:903:244d:b0:2d8:de9f:9a44 with SMTP id
 d9443c01a7336-2e9a6c1b8e6mr90447275ad.19.1792509445805; 
 Tue, 20 Oct 2026 08:17:25 -0700 (PDT)
X-Received: by 2002:a17:903:244d:b0:2d8:de9f:9a44 with SMTP id
 d9443c01a7336-2e9a6c1b8e6mr90447095ad.19.1792509445329; 
 Tue, 20 Oct 2026 08:17:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b410626sm656815ad.20.2026.10.20.08.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:17:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/3] target/hexagon: reset implicit USR write state
Date: Tue, 20 Oct 2026 08:17:19 -0700
Message-Id: <20261020151720.728888-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
References: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad78606 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfX+QIuaxp6YfHL
 7IiUeMm+niZxuqUczJPtH6JOURgF5MuhKvlOj1nmJ8jnb4Rse0m18JkvW+CJkJMfg/fAZ1q76gN
 n/+hBCW8bWOyhxgkRC3FM+rAnumiAw0=
X-Proofpoint-GUID: 0olRMgdSDV5hSqORGvR95rxKeKDPffLl
X-Proofpoint-ORIG-GUID: 0olRMgdSDV5hSqORGvR95rxKeKDPffLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfXxCemdGvzEmNw
 1vKwqxia+ylt2LILnSy7CnaJv7JGLs1uNbxNQM0msScbvwqy5PnF/tSR3IUoC/Xaq4uclbD+Kec
 AhSvRL+qxxY6/ZObkon7/nBysRqaTB7GB1pdsT45GLjIU1rHzF+P3vN3q+DCDOiKIQcPwsVMeK7
 rTmzKSjcKAiz0DMBl+SynOQlMj0/2yF3UvK4aRc6sKYO78s4uKzUmR+Koum2qaY+jsXkwAYzA6t
 mTNVdQhu7X1J/efuA75iSyqWA00VwwIChXt/RuM8kEtWZrfYp3Kwj+AZOtogrIIdOjroezCv9Qs
 tUSwwjV9YDUeW8h0HdBbKUQCgBEu44FBVBSD9eH/toEh0OBFxSDObJJ2bMWz09vpXsXsUzBaZE6
 ojl/dNofJzpGyS3ZwM28+HiqihUvBZcDEbsDgdeehAqiOShXT+HDNMYqRyQ8/QmRQPcv/I149Yn
 V1ln0hBQU05t+7PgS9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200060
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

aW1wbGljaXRfdXNyX3dyaXRlIGlzIHBlci1wYWNrZXQgREMgc3RhdGUuIEl0IHdhcyBub3QgY2xl
YXJlZCBiZWZvcmUKYW5hbHl6aW5nIHRoZSBuZXh0IHBhY2tldC4gUmVzZXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgb3RoZXIgcGVyLXBhY2tldApzdGF0ZS4KCldoZW4gcnVubmluZyBxZmxvYXRfdjgx
IHVic2FuIHJlcG9ydGVkOgoKICAgIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jOjcyNTozMjog
cnVudGltZSBlcnJvcjogbG9hZCBvZiB2YWx1ZSAxOTIsCiAgICB3aGljaCBpcyBub3QgYSB2YWxp
ZCB2YWx1ZSBmb3IgdHlwZSAnX0Jvb2wnCiAgICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYzo4
NzQ6MTI6IHJ1bnRpbWUgZXJyb3I6IGxvYWQgb2YgdmFsdWUgMTkyLAogICAgd2hpY2ggaXMgbm90
IGEgdmFsaWQgdmFsdWUgZm9yIHR5cGUgJ19Cb29sJwoKRml4ZXM6IDNlOTg0OTY2OTFlZCAoIkhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbXBsaWNpdCB3cml0ZXMgdG8gVVNSIGRvbid0IGZvcmNl
IHBhY2tldCBjb21taXQiKQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXgg
MmMxOGY1ZWViZmYuLmE0YzVlMDQzYzcyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNTY5LDYgKzU2OSw3
IEBAIHN0YXRpYyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4
LT5yZWdfbG9nX2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRP
VEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3Jl
Z3MsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUg
PSBmYWxzZTsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0t
IAoyLjM0LjEKCg==

