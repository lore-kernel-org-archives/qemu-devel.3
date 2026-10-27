Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E1606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksThFNwb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NyxH3qMy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKf-0001R3-RM; Tue, 27 Oct 2026 10:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiK4-0008Bg-G1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiK2-00069D-AJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoL03858493
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q7fCPCfYMXl8XSzgcYYaGqDhxB7xE+yMsGRTK1b7d4k=; b=ksThFNwbHIg1158y
 00lIpFLtvnzJe2T4SKKCuV9G4gV8e5uLJN15rULl4xzy0wxPL0/9OUvao92vBTBc
 Lc5nVMgVO+CV5KhoLozM+vg40l3Aw5Lh4tFyJSZz59AHCcf7E792OvG92+XPtd8K
 z3eKkMood3O/9lfzvEbiCWZCV5kvQh7SxrsejEziHc+TVyqxK3uhBRR3XZXWLoDh
 8mYsWv+nKN4NjJRMMjr4J7tX9AUilEHc5g4FT9m175RZazUcPG5Ga3NuC5ZWBJjw
 MwDjfRAAnif9I2d7HJ7z3+ul7FUOsRbTblM3FwqRCDmWs8oNwQqKiCID0yE8bxXl
 N8RKSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54maw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e832c03576so78985085ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111920; x=1793716720; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q7fCPCfYMXl8XSzgcYYaGqDhxB7xE+yMsGRTK1b7d4k=;
 b=NyxH3qMyQqS6c0cehjp3lUXHIwgCXFo/6N7Z+GTrVTe5ri+5QUBC6F9vHitS1j+hxW
 xckP7Qx7coUPcm8d7eD6Vf15+ivezi9scx0G5qr0tddSFyiHRckUrKvg8bOCqFr3MJy4
 FJkGtVnsry2/yIUWn1I7x/EzoCQprWqrv0S6/BjgMrenDrMdzUtIG3U18aNhQUGKjUM8
 zxdC0Q9pNXcEOQB0qzc+uEteoUBghpImRF5LYLWUW/oQz7/egGek017US2LEa/KZGYDz
 LhDCqzwSH1DldlG6wW5Q/c7ZwxfHtoRY2UBt5WQuDnUlZ1q6R+Uj9dFU3EYwwO02IPcG
 Aa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111920; x=1793716720;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q7fCPCfYMXl8XSzgcYYaGqDhxB7xE+yMsGRTK1b7d4k=;
 b=mfN+CbfgBy8mNQJiPrcR2BChCbte/oGAD/pkpp5d5i+KJztttsllxRujxs/u6J5QMg
 ZqWdj0RxpauxM2uI07VXtsU2c8pcoO9c6Lytxwq7cX3K+99BP/w1mvPQ1x1B9k1EGgAK
 f6hx+HX4qolMealDRl5ZLQuWmdelHCYucq93BuRD2oMLOaVI4iOB27/cfdi+7dF9A1Wn
 rq0QqJgTTwDmeW8Nfrr5GMo2slry5riUckRjB75ajbBSQkQC9TI+Ww+vK1mEE/8ZWxJf
 XMC+5MaJUaovZ7T9cg2xqeJz02X6eD66YG/WdCluA+JT0mkdZgdYggmoHFxn9oQ3bWE6
 Q6ZQ==
X-Gm-Message-State: AFq9FYITC0kziGilErG8Z/5emKfJtX+AGxu7x55Jw6ORUbtwtLsL1MEY
 QLQ1BHdun32qEuQD+/L4CmqVVGltmh1suJSTympxEPgLNpjeRXoDz8X3NbSmeiI4n+S4PdTpz3O
 sogUH2a6hvqL9tA9sxV8CeOtS6V7uNu1QSROhDj62PNzWBrI3Dfc4UCX9aeQ9MFwEtw==
X-Gm-Gg: AYBFou3rt6uvQhfZFbG5mFWgoUuKECC43bccn1ea2t5uHm0Qk9L7PiHaJZLkAz478l7
 LgUEDUdxW/W4RVphPwGASWhtvYGxeasA2Axz+MlOJ59GJ7juO/0MY+gQskbMoFe0yfHDDaKyeq4
 ojxo6Q1KIeZdk+dm7ZdrKLq2CiR6Q20A1dlBwDnvYXTstsASrDR+C8J2zIXps+pg6GrVMp0fc6Z
 DdMC53P/532mqJvBkE9F3wmmbyrp9S+JAF+QiG6Ppg1csSHBAlouSVopRDBy5qtpH73eR6utaWa
 5qAgBMJO5w/X4Td6tgsAxM1wEuGcPPaBCvW2JPuHBIxDhMQ6CBl/DtuLQC2MCnYD1SrMCcBd4U6
 Ysz+ULaQqcz88hnOK/yggP8yPEDnfF++U9Gu5r25DRX9WKZY=
X-Received: by 2002:a17:90b:2645:b0:3a0:9640:803a with SMTP id
 98e67ed59e1d1-3ade9b2ef4bmr8899765a91.5.1793111919814; 
 Tue, 27 Oct 2026 07:38:39 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:3a0:9640:803a with SMTP id
 98e67ed59e1d1-3ade9b2ef4bmr8899749a91.5.1793111919300; 
 Tue, 27 Oct 2026 07:38:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 28/42] hw/hexagon: add v79NA1 machine
Date: Tue, 27 Oct 2026 07:37:07 -0700
Message-Id: <20261027143721.4125584-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX5xkA71Fik9E1
 7cCP+yhxfyWQGFqrQa+X6oEm35PZLL8RTMyxShfTLKpVGU8B3fYYM94sZhDTg1YE7rRCixH77+3
 WpnW19m2iinVTWd+ollCpDgL73qnplI=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae0b770 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7BVmsqUksLU-FW-GvuIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 4JlFmn-GPSNOp6kuRnV736xYN4dISjmv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX+GZL0VQD3VyX
 flHgV3JdJjhjtM2M5XujLIOTp3B5xLO4iOuCl+1aJori0SLukUBqC+R3QqZBG/5nK8eU1n7f5hp
 oVGf9qHFoAXG/XaCnJrmWYl6ZKcyosiEP+LPmIjJbYWbR98RNEEZKHRHRfWUQ/H9juPULZg3qV7
 H+RCpMbTslCUCtGU0CYltRcksAn8dEiwz/NXvGQy/q3CWpk/y2Pl0ClRxZ1GyojyM9skOYhmWEs
 nruJ/es3Rmt4eYZLcMnFfZasPeECxKXNOKg6k2sV9jF6mlaEoFm5Ke/INqj9a9z04A4DmikVDbZ
 a6vP+3LoZ92lbHSmqUIcfbePkNQvgadYgW3SZ6umWv0smt3h1eMxczu/zpMMds2AEgTiaGc1BKq
 32wRJsr3bluvcYjEutPhhV5pqswmbzsG8jYoi+IUpXKOmwfTV29emKnjmjpprCP4oyF2I37xdSB
 J5I+CQ2HlAqLqOnoaRA==
X-Proofpoint-GUID: 4JlFmn-GPSNOp6kuRnV736xYN4dISjmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

QWRkIHRoZSBIZXhhZ29uIFY3OU5BXzEgc2ltdWxhdG9yIG1hY2hpbmUsIHdpdGggdGhlIGNvbmZp
ZyB0YWJsZSBvZiB0aGUKdjc5IGNvcmUgYW5kIGVpZ2h0IENQVXMgYnkgZGVmYXVsdC4KClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysr
KysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYwoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbi5oCmluZGV4IGYzYWVlNGE0MmU2Li41NDgxMzVhN2RkOSAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdv
bi5oCkBAIC0yOSw2ICsyOSw3IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjczX3JldiA9IDB4OGM3
MywKICAgICB2NzNtX3JldiA9IDB4Y2M3MywKICAgICB2NzNuY18xX3JldiA9IDB4OGI3MywKKyAg
ICB2NzlfcmV2ID0gMHg4Yzc5LAogICAgIHY4MV9yZXYgPSAweDg3ODEsCiAgICAgdjgxX3NjODQ4
MHhwX3JldiA9IDB4ODA4MSwKICAgICB2ODFkZ2JfMV9yZXYgPSAweGNjODEsCmRpZmYgLS1naXQg
YS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgYi9ody9oZXhhZ29uL21hY2hp
bmVfY2ZnX3Y3OW5hXzEuaC5pbmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAuLjcwYTdhZTU4YmM1Ci0tLSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2Nm
Z192NzluYV8xLmguaW5jCkBAIC0wLDAgKzEsMzQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9t
YWNoaW5lX2NvbmZpZyB2NzluYV8xID0geworICAgIC5jZmdiYXNlID0gICAgICAgICAgICAgMHhk
ODE4MDAwMCwKKyAgICAubDJ0Y21fc2l6ZSA9ICAgICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwy
dmljX2Jhc2UgPSAgICAgICAgICAweGZjOTEwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAg
ICAgMHgwMDAwMTAwMCwKKyAgICAuY3NyX2Jhc2UgPSAgICAgICAgICAgIDB4ZmM5MDAwMDAsCisg
ICAgLnF0bXJfcmVnaW9uID0gICAgICAgICAweGZjOTIxMDAwLAorICAgIC5jZmd0YWJsZSA9IHsK
KyAgICAgICAgLmwydGNtX2Jhc2UgPSAweDAwMDBkODAwLCAuc3Vic3lzdGVtX2Jhc2UgPSAweDAw
MDAyMDAwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5LCAubDJjZmdfYmFzZSA9IDB4
MDAwMGQ4MWEsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkOTAwLCAuYXhpMl9sb3dhZGRy
ID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwZDgxZSwgLmp0
bGJfc2l6ZV9lbnRyaWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0g
MHgwMDAwMDAwZCwgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDYsCisgICAgICAgIC52dGNtX2Jh
c2UgPSAweDAwMDBkOTAwLCAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAgICAgLmwy
dGFnX3NpemUgPSAweDAwMDAwNDAwLCAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAsCisgICAg
ICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMGZmLCAubDJsaW5lX3NpemUgPSAweDAw
MDAwMDgwLAorICAgICAgICAubDJpdGNtX2Jhc2UgPSAweDAwMDBkODAwLCAuZG1hX3ZlcnNpb24g
PSAweDAwMDAwMDA2LAorICAgICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywg
LmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAw
MDAwMDIwLCAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9yZWcyID0g
MHgwMDAwMDAxMCwgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAsCisgICAgICAgIC5jb3Byb2My
X3JlZzQgPSAweDAwMDAwMDIwLCAuY29wcm9jMl9yZWc1ID0gMHgwMDAwMDAwOCwKKyAgICAgICAg
LmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsIC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA4LAor
ICAgICAgICAuYWNkX3ByZXNldCA9IDB4MDAwMDAwMDEsIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAw
MSwKKyAgICAgICAgLmwxZF9zaXplX2tiID0gMHgwMDAwMDAyMCwgLmwxaV9zaXplX2tiID0gMHgw
MDAwMDAyMCwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLCAudnRjbV9i
YW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAwMDAwMDEs
IC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAwMDAwMGEsCisgICAgICAgIC5jb25zaXN0ZW5j
eV9kb21haW4gPSAweDAwMDAwMGUwLCAuY2FwYWNpdHlfZG9tYWluID0gMHgwMDAwMDA4MCwKKyAg
ICAgICAgLmF4aTNfbG93YWRkciA9IDB4MDAwMDQwMDAsIC5jb3Byb2MyX2ludDhfc3ViY29sdW1u
cyA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3JlY2ZnX3ByZXNlbnQgPSAweDAwMDAwMDBkLCAu
Y29wcm9jMl9mcDE2X2FjY19leHAgPSAweDAwMDAwMDA3LAorICAgICAgICAuQVhJTTJfc2Vjb25k
YXJ5X2Jhc2UgPSAweDAwMDA0MDAwLCAuQVhJTV9kYXRhX3dpZHRoID0gMHgwMDAwMDEwMCwKKyAg
ICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hleGFn
b24vaGV4YWdvbl9kc3AuYwppbmRleCAwYTIzMjRhNzNiMi4uMzg1NDM0MjAxNGYgMTAwNjQ0Ci0t
LSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fZHNw
LmMKQEAgLTMxLDYgKzMxLDcgQEAKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjZnXzEwMjQuaC5p
bmMiCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jIgogI2luY2x1ZGUgIm1h
Y2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMiCisjaW5jbHVkZSAibWFjaGluZV9jZmdfdjc5bmFfMS5o
LmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYyIKICNpbmNsdWRlICJt
YWNoaW5lX2NmZ192ODFxYV8xLmguaW5jIgogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4NW5hXzEu
aC5pbmMiCkBAIC0yMjQsNiArMjI1LDIyIEBAIHN0YXRpYyB2b2lkIHY4MWRnYl8xX2NvbmZpZ19p
bml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKICAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hp
bmUsIHY4MWRnYl8xX3JldiwgJnY4MWRnYl8xKTsKIH0KIAorc3RhdGljIHZvaWQgdjc5bmFfMV9j
b25maWdfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCit7CisgICAgaGV4YWdvbl9jb21tb25f
aW5pdChtYWNoaW5lLCB2NzlfcmV2LCAmdjc5bmFfMSk7Cit9CisKK3N0YXRpYyB2b2lkIHY3OW5h
XzFfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCit7CisgICAgTWFjaGlu
ZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOworCisgICAgbWMtPmRlc2MgPSAiSGV4YWdv
biBWNzlOQV8xIjsKKyAgICBtYy0+aW5pdCA9IHY3OW5hXzFfY29uZmlnX2luaXQ7CisgICAgaW5p
dF9tYyhtYyk7CisgICAgbWMtPmRlZmF1bHRfY3B1X3R5cGUgPSBUWVBFX0hFWEFHT05fQ1BVX1Y3
OTsKKyAgICBtYy0+ZGVmYXVsdF9jcHVzID0gODsKK30KKwogc3RhdGljIHZvaWQgdjgxZGdiXzFf
aW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCiB7CiAgICAgTWFjaGluZUNs
YXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOwpAQCAtMzE2LDYgKzMzMywxMSBAQCBzdGF0aWMg
Y29uc3QgVHlwZUluZm8gaGV4YWdvbl9tYWNoaW5lX3R5cGVzW10gPSB7CiAgICAgICAgIC5wYXJl
bnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCiAgICAgICAgIC5jbGFzc19pbml0ID0gdjcz
bmNfMV9pbml0LAogICAgIH0sCisgICAgeworICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9O
QU1FKCJWNzlOQV8xIiksCisgICAgICAgIC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJ
TkUsCisgICAgICAgIC5jbGFzc19pbml0ID0gdjc5bmFfMV9pbml0LAorICAgIH0sCiAgICAgewog
ICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJWODFER0JfMSIpLAogICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FLAotLSAKMi4zNC4xCgo=

