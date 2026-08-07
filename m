Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F51C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPQ-0000lV-36; Fri, 07 Aug 2026 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPO-0000kc-O9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPN-0006jI-BD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CgMXZ1294625
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j2Tq17a6Nx88JT8R5fCoaV+t6aHZHI82tO8YJOFApiw=; b=pLAnMu8phGEYSvl9
 XqNj8hfxK00aJfazOEccIzpsg1jKjo8J9hV5QvqzQ+vr5qXhyVeeAISdykhlHbsZ
 YlurVsgqU6S4V9t0YiwOkT6103M/xegRBhsBGPaXl/q1nTuKFWJYTPss/+SAPDpK
 6vmXcW0WvZfjVQ1KmVXSipRbbOE1J7yAjBX4O50hEH/ouB/Dt8/kgZVQMpi8zJFN
 z9+QrXJ1og4ooxFSrO78giVPzaoUnEl4l9LI4hWTN7JSzV3BbSiLyPYLNoqTmDGF
 1XugJd0zBDp6Ky14gFiw5xeSgpbmoLZCquwpMYv7r0FneN9vcFxurEyzwwbbPsrE
 4ufE6Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gvmu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cca3673560so51983785ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116171; x=1786720971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j2Tq17a6Nx88JT8R5fCoaV+t6aHZHI82tO8YJOFApiw=;
 b=BdhZeq/J60+0N7AyHjrbYW5J2WSVRI574xXHs4jUzmr/1Hp9HCB10SSy86q6mSkzFH
 dNFe9NXEL4JNllOB4KDr8ZqSpB8k8Lf6ok8O9Ph59A+Glhb+62IqjM7HSJku61zitbdL
 UdwG6FjQLn0iDknMJw9QNZzR7d64+O1AX5DYYJ8AzJLvpvBDUwu/XCGJkdnH6vdZ5tjk
 e1JtMmPbdD/HlQwGgipZUkq8ivL6BYhDcYgI2W29q0t0shnLld4380cxM1iSKnHI1XQL
 nBtvQlacwAi9cEyWJKHhR5VVbVOOcy4Aqch29kDodYiiVKw1KlgP0kdtnq49yIm1kDf6
 VOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116171; x=1786720971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j2Tq17a6Nx88JT8R5fCoaV+t6aHZHI82tO8YJOFApiw=;
 b=JiJBgfdZ64PwTVYvD656ZT6uDB8/LkjcuZa/Zs5IkzUf1G/XHtLWpEKWkM42TAYEvt
 kAG9m/vM+j2GhtQkLW44Zkn8gnASdLBzDpLOW9FsfMkAx92NR3il2IuWX2yMClckpaIh
 X1B8ItyTN7RuIka9l7RXGloW8iG8e2mUpn9Yb+8ogQ53y+vGhOnqum1AcibF1ZUZ+Gta
 ktjRq3hARQuesD91fhXQrFqCvxIWWHpzrEC0qIXAriGvwdyL1AlYvTwc9mYtt5d9s+kc
 /SH/9guWGA37iSXXHn+jv3ZWAJMty1sUm1vLy9sS5/Igv3iynOGim1lKYg6Hk+n722HT
 g6zg==
X-Gm-Message-State: AOJu0YwkM/aYcQNd/RewRX3FQRqh6TpGCs/EIZsyG/fAqji+TdK5vdGl
 DoUCL13qBBb7Cdq9vEDNcDvgNFfW+i0DggdSUqPPqhsBJI94tD0Ub397evJLyZoY84rDNJChvWn
 UbUBRQrcKNDrpBOCdjKa4Il4RI8c7ofJU9UJBvNV+3jgrUXjyoLUJfAKhvhbyXq3yqg==
X-Gm-Gg: AR+sD137EJ9J0mYB6ItlUe9Q3MGz0vXRQZM6D6ANkIrN2t/eSc/ozkoGmorpX28K/VM
 64pkcQ/Lz6KGTjs+eqDWsdBMbq8JaEhbPfPdgUOSf2oPo4OL1EmuVNR378S4wpt707NXoEaMrX6
 FCpY2LQBAm+PchG7TIT19Jjz4qoaO8kXzWI1k3f/KRU3vQTrsEZ+AfsObBEsS/xgOWt9fheyzRe
 FTwcS5xKC+vBh3Kv1rvxa5QrsKrOVAccNqkdMTM2/TiCGPydua/KBV6Ejn1tJx82M3nAdjqoLfr
 f2LqHk2cN/ctNG+gczOCKGh/Q3TXJSYmC9S3ucSB3pi/uM+ZfDQFSzb1ntNZTAlXKXD+yYaEoQn
 NgISVP4rkzZx2DRzNlIZzhjeerXr3XIUjjJt3QSWU3XgEUDdF
X-Received: by 2002:a17:902:ccd1:b0:2d1:1a28:10d with SMTP id
 d9443c01a7336-2d11a280465mr99089145ad.18.1786116171295; 
 Fri, 07 Aug 2026 08:22:51 -0700 (PDT)
X-Received: by 2002:a17:902:ccd1:b0:2d1:1a28:10d with SMTP id
 d9443c01a7336-2d11a280465mr99088485ad.18.1786116170829; 
 Fri, 07 Aug 2026 08:22:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 6/7] tests/tcg/hexagon: add HVX test for V6_vsubwsat
 saturation
Date: Fri,  7 Aug 2026 08:22:40 -0700
Message-Id: <20260807152241.1576334-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75f84c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KziaR8soUeEz0EukW7EA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: X-dA7gbfdEr8AzF-6btiBLbV-3S1j0PH
X-Proofpoint-GUID: X-dA7gbfdEr8AzF-6btiBLbV-3S1j0PH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX3Ob6cNjaKKbZ
 /wxk7LDtlizGfNDsU/qlb2NlWvAPTbvvcXbXGaVydOJ0Gu5CPvUA6+74knsSsjpPKraGROv/t+N
 eQa6Mc03JgqjRq5JQEemqnjOLabRHUo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX7+4RKOQxI9jF
 Xa1LCCKmcAtQ0UiH2TdyTwWgEjNo63f2wLBrvKR3/5eknlSu+kJaejtHRgzmZyl8zydeRztpMPq
 hAanqDtNpwnWfORNsoDpxpjS3e2XXOyiBKS4IBBlgoKlSycgXumfD4ZJv6b5+sGviNTDrZzugfa
 HAqbFyARc8utc8iy7AYdUkZSNH13374TelKASsrMUuZYSrBDoLIadAOU8lbCIOhq5LGIdcxtJBc
 Q56ToTgVnszwZnS4I3zTU27ARVhtRFwvwSzMxMu7PeDhuvR/vSed9nZaqngiMv4sb4iqLrX2rgF
 eavUAFOime4b0F7ZxttjnecvPmhP+FCgxrplnYtZq16vS9xFyrvcnAN4GhPdsygrYr7Entl65fq
 WYzLY+SttRUdyqWfMeH9kablADpE+KShd0C8lYJv85Hg72wnGZuZDDYBXQ5jqXJ97Je19dNvogu
 8hrjtaBhtlDYBTYJCSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0NCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBiL3Rlc3RzL3Rj
Zy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggOTBjMzczM2RhMDcuLjY0MWNmZjU5YWJhIDEwMDY0
NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2h2eF9taXNjLmMKQEAgLTIwLDYgKzIwLDggQEAKICNpbmNsdWRlIDxzdGRib29sLmg+CiAj
aW5jbHVkZSA8c3RyaW5nLmg+CiAjaW5jbHVkZSA8bGltaXRzLmg+CisjaW5jbHVkZSA8aGV4YWdv
bl90eXBlcy5oPgorI2luY2x1ZGUgPGh2eF9oZXhhZ29uX3Byb3Rvcy5oPgogCiBpbnQgZXJyOwog
CkBAIC0zODYsNiArMzg4LDQ3IEBAIHN0YXRpYyB2b2lkIHRlc3RfdnN1YnV3c2F0X2R2KHZvaWQp
CiAgICAgY2hlY2tfb3V0cHV0X3coX19MSU5FX18sIDIpOwogfQogCitzdGF0aWMgdm9pZCB0ZXN0
X3ZzdWJ3c2F0KHZvaWQpCit7CisgICAgY29uc3QgaW50MzJfdCB4MCA9IElOVDMyX01JTjsKKyAg
ICBjb25zdCBpbnQzMl90IHkwID0gMTsKKyAgICBjb25zdCBpbnQzMl90IHgxID0gSU5UMzJfTUFY
OworICAgIGNvbnN0IGludDMyX3QgeTEgPSAtMTsKKyAgICBIVlhfVmVjdG9yIHYwOworICAgIEhW
WF9WZWN0b3IgdjE7CisgICAgSFZYX1ZlY3RvciB2cmVzOworCisgICAgLyogSU5UMzJfTUlOIC0g
MSB1bmRlcmZsb3dzIGFuZCBtdXN0IHNhdHVyYXRlIHRvIElOVDMyX01JTiAqLworICAgIG1lbXNl
dChleHBlY3QsIDB4MTIsIHNpemVvZihNTVZlY3RvcikpOworICAgIG1lbXNldChvdXRwdXQsIDB4
MzQsIHNpemVvZihNTVZlY3RvcikpOworCisgICAgdjAgPSBRNl9WX3ZzcGxhdF9SKHgwKTsKKyAg
ICB2MSA9IFE2X1ZfdnNwbGF0X1IoeTApOworICAgIHZyZXMgPSBRNl9Wd192c3ViX1Z3Vndfc2F0
KHYwLCB2MSk7CisgICAgbWVtY3B5KCZvdXRwdXRbMF0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3Ip
KTsKKworICAgIGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisr
KSB7CisgICAgICAgIGV4cGVjdFswXS53W2pdID0gSU5UMzJfTUlOOworICAgIH0KKworICAgIGNo
ZWNrX291dHB1dF93KF9fTElORV9fLCAxKTsKKworICAgIC8qIElOVDMyX01BWCAtICgtMSkgb3Zl
cmZsb3dzIGFuZCBtdXN0IHNhdHVyYXRlIHRvIElOVDMyX01BWCAqLworICAgIG1lbXNldChleHBl
Y3QsIDB4MTIsIHNpemVvZihNTVZlY3RvcikpOworICAgIG1lbXNldChvdXRwdXQsIDB4MzQsIHNp
emVvZihNTVZlY3RvcikpOworCisgICAgdjAgPSBRNl9WX3ZzcGxhdF9SKHgxKTsKKyAgICB2MSA9
IFE2X1ZfdnNwbGF0X1IoeTEpOworICAgIHZyZXMgPSBRNl9Wd192c3ViX1Z3Vndfc2F0KHYwLCB2
MSk7CisgICAgbWVtY3B5KCZvdXRwdXRbMF0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgIGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7Cisg
ICAgICAgIGV4cGVjdFswXS53W2pdID0gSU5UMzJfTUFYOworICAgIH0KKworICAgIGNoZWNrX291
dHB1dF93KF9fTElORV9fLCAxKTsKK30KKwogc3RhdGljIHZvaWQgdGVzdF9sb2FkX3RtcF9wcmVk
aWNhdGVkKHZvaWQpCiB7CiAgICAgdm9pZCAqcDAgPSBidWZmZXIwOwpAQCAtNTMwLDYgKzU3Myw3
IEBAIGludCBtYWluKCkKIAogICAgIHRlc3RfdmFkZHV3c2F0KCk7CiAgICAgdGVzdF92c3VidXdz
YXRfZHYoKTsKKyAgICB0ZXN0X3ZzdWJ3c2F0KCk7CiAKICAgICB0ZXN0X2xvYWRfdG1wX3ByZWRp
Y2F0ZWQoKTsKICAgICB0ZXN0X2xvYWRfY3VyX3ByZWRpY2F0ZWQoKTsKLS0gCjIuMzQuMQoK

