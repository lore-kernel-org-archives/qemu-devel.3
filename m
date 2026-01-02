Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E8FFC6160
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 20:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vblVv-00040I-FU; Fri, 02 Jan 2026 15:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVg-0003sd-4b
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVZ-0002TG-5w
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:26 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6029WEl93961332
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 20:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QBMJWAlfc7qnoPuxJDYcNqX8Vn0orrK0iCmCIBWb1Zc=; b=L6t4d+IsM33471I4
 11fRkJ4mPIIOrBeKAvj3B+RmuBP/+IfpZ4dXRVBZAXR6oR3yT2rlYz1MsSNcXiik
 PqDmuEyea5RmEfU/a8Zac6aR5PIJXfM0qCZPyxF2PicHMOIGmMts3Ht5hFyHTGho
 wVT61B0kEIN4NitTlJiGZ5hOvnojBwkhMQTJEfmzqN5eWokA3+K/4GVZLoaaetuj
 +RoPFB3KUQUI9LLEQjuf64Er2z16OcMLAIkeRKSg6CrTWD/S5TpXcQlf+BZbC/n4
 M5YX+KHFUTuLHbdnKm0tHOTC5K9mqVURgEKmp2PxMZ56/XxqLBG9ih4KAIBMSnoC
 ncTMfg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd77v49j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 20:12:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-be8c77ecc63so18903706a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767384743; x=1767989543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBMJWAlfc7qnoPuxJDYcNqX8Vn0orrK0iCmCIBWb1Zc=;
 b=Eb9faVDk/zZr4SqxNdaQrpp06JBKIxnaew8rvOaIJqtZwVccSyPNAusz8aMrR4tEBG
 WJszNfZ5q2q7cxTqgshkPIDyLICE1EFQ5IIBpBocySQe8LZVdm9rgY5o9qmGO5Owourk
 UKH+JNJJNtvkGJiXPYvt6dFgzDnA6zVE9ucA1xvuuPG4HBuD5gLwHDyVs0Y1KJX4HOZK
 NEVaUjTYfpJ7bd/mCBRW1SsIAD5rLuPkxQH2EMi5bDMSP8HWtCpLh7LcytxAWHEFPGyO
 1LWmEYNM2ed9QnFP59lfjZK9LB9RijpJVXkLNSp4SIPbfUnLCCzFTPPmGV2UTy7trCUO
 Bq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767384743; x=1767989543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBMJWAlfc7qnoPuxJDYcNqX8Vn0orrK0iCmCIBWb1Zc=;
 b=Z/0zcWUtevenQymO1XzHuWBMYnSRH/4bwcaWQVbc1ULKh8//TZrLnS6C+L7Hney4Tc
 cJympYU6gOMcegnmQEh31xuqUhAG8M26xRqU27/LXb5R3IdwZtuBDc9MmCBDn6o6LBd0
 DA+cO1Rkug2zycMcKcaawK3VUi9H1xl1jjrBI5SIMGp3weuRZTuApKDfoXNOoOmZBUci
 nT26hactEqnORF4K0ETCXZvH/wQactI5KHQBRbWBw+6/sVwDcyq/meFuByhBTcckmL7x
 rCk1joEdnDkLecDxTRWwt1twnPo4F3AblCXSkbEXzbvT3ObQhp1kG4cgQHsO/4D8Xued
 unjw==
X-Gm-Message-State: AOJu0YxZswTkMSlkwebaUZ07At1VNQ1nkjHmSUatieqq/klvG9LIReQH
 t3UTi7BtbkbSgcHk+RAT02Q6AfhIIaqT62kuBOpoa3mRn2XY1dgtzo6v1TRIj9wmokeJeVzZOa8
 zWon2Ld9VyBi4qd25i86DqUSKTBep0T4SkgRv4A4sNLvOP7vZK2HGLS/wgzUR3MlRLg==
X-Gm-Gg: AY/fxX4D6cyWBxjZVtXOfz26NfNoNavj10jlrmRgX9QczmwgMVSrMdG2XZNzQjBBqBh
 VQjSuv5PKaKQHwCET5ty11ZiyOj/Uop5/9rkgC3dKRhrFQQRNnhlg/PpI5sD96jYDyQ1WLCPH2T
 XqoZ+z8mrhVIcoJKVg203qv4XPqm76/sDbPzM2feFVBLI/pui5V3ALVbgkbNR2rALi2lS66u/WT
 +I96GaW3OAiYZOb8JwGuRAhf2C9yVG6XlIyW6ppxI9h9iZ/UoSgnDrIxrUChrlDb7L0pSG9FTXD
 Gh0+ppWeMvKUFXBO0wSJdmfrjmfwyjonJeMrDAss/gTG8SZezJu+bKS6jRE36JNmBWML1TOvLIc
 rVShPQ7J5cJ1SHDZrf8cszwwOKv+48z7R/zGgq6h3CSMgS0FL3TDdouxiZA==
X-Received: by 2002:a05:693c:250d:b0:2b0:4e86:8155 with SMTP id
 5a478bee46e88-2b05ebb2bc7mr28901676eec.14.1767384742639; 
 Fri, 02 Jan 2026 12:12:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKYW8BxvnSZnWDRSXHHH7R9op9muNR7A/83uD2bamYHFsNWuVvwG4eQBLCcqG1Gw/UYFtqrg==
X-Received: by 2002:a05:693c:250d:b0:2b0:4e86:8155 with SMTP id
 5a478bee46e88-2b05ebb2bc7mr28901660eec.14.1767384742084; 
 Fri, 02 Jan 2026 12:12:22 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42e7esm1794621eec.22.2026.01.02.12.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 12:12:21 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PULL 4/9] Hexagon (tests/tcg/hexagon) Add test for USR changes in
 packet
Date: Fri,  2 Jan 2026 12:12:00 -0800
Message-Id: <20260102201205.2050363-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
References: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: gHJuVB96CMo-kd5z_e-UpRgZXBVXHPLB
X-Proofpoint-ORIG-GUID: gHJuVB96CMo-kd5z_e-UpRgZXBVXHPLB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MSBTYWx0ZWRfXzSNyeHfBPXnB
 gpuFcZxtlbG520K9NKH/ACXEP4nIGq2DZXoWUdxKb7KcNTTo0Nzhs3hACZgPm9oTnZ6kCQSBj8y
 +7rh2f0ys6IyH3/pSgkQQarO3F1+qko5/rmaGNHqQypT2ps56Bhohs8TiqV1B9AWdwItoNYZYF3
 ezf1hNiWNxNrCA9Sfuoo1F2AJW0RIZDMIPM06zZeUOTgDXMn7UrwuhQv0Xz7MtbvXz3isE7dTV8
 AoCsTzP1PDex+yIi1g2YY8gSOgy+kQ2msqlmJh14q08Aemfv1TCu0sR/g3YcPtUPskeLTi0IKA+
 BqiFgo32LjHCwEJHa7ygYFuRw8jM+LXYzKutysbPG17WFjE31dB0CcfkxehKTsBHoxvYj01vrhf
 etI0m2dFEdpzWtvyuqLawnqpS9dBf1qEZozseOYgiVu+5J3k5dY1dVVQxHa5Ntwv3ryfeUyyVTw
 NEwsZzbnOty0IE5rgpg==
X-Authority-Analysis: v=2.4 cv=ev7SD4pX c=1 sm=1 tr=0 ts=695826a7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=GHvY5Ttzp4-mifQX6oYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90
Y2cvaGV4YWdvbi91c3IuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9oZXhhZ29uL3Vzci5jIGIvdGVzdHMvdGNnL2hleGFnb24vdXNyLmMKaW5kZXggZjBi
MjNkMzEyYi4uZWYxNzg3YzY0YyAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vdXNyLmMK
KysrIGIvdGVzdHMvdGNnL2hleGFnb24vdXNyLmMKQEAgLTYwOCw2ICs2MDgsNTggQEAgVEVTVF9D
TVBfeHgodWludDMyX3QsIHVpbnQzMl90LCBGVU5DLCBTUkMxLCBTUkMyLCBSRVMsIFVTUl9SRVMp
CiAjZGVmaW5lIFRFU1RfQ01QX1BQKEZVTkMsIFNSQzEsIFNSQzIsIFJFUywgVVNSX1JFUykgXAog
VEVTVF9DTVBfeHgodWludDY0X3QsIHVpbnQ2NF90LCBGVU5DLCBTUkMxLCBTUkMyLCBSRVMsIFVT
Ul9SRVMpCiAKK3N0YXRpYyB2b2lkIHRlc3RfdXNyX3BhY2tldHModm9pZCkKK3sKKyAgICB1aW50
MzJfdCB1c3Jfb3V0OworICAgIC8qIFRlc3Qgc2V0dGluZyBVU1IgYml0cyBpbnNpZGUgYW5kIG91
dHNpZGUgcGFja2V0cyAqLworICAgIGFzbShDTEVBUl9VU1JCSVRTIFwKKyAgICAgICAgInIxMCA9
IHNhdHViKCVbdmFsXzB4ZmZmXSkgICAgICAgICAgICAgICAgICAgLyogU2V0IHVzci5PVkYgKi9c
blx0IgorICAgICAgICAie1xuXHQiCisgICAgICAgICIgICAgcjExID0gY29udmVydF91dzJzZigl
W3ZhbF8weDAxMDAyMGE1XSkgIC8qIFNldCB1c3IuRlBJTlBGICovXG5cdCIKKyAgICAgICAgIiAg
ICByMTAgPSBtZW13KCVbZXJyXSkgICAgICAgICAgICAgICAgICAgICAgLyogRm9yY2UgcGt0IGNv
bW1pdCAqL1xuXHQiCisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgIntcblx0IgorICAgICAgICAi
ICAgIHIxMSA9IHNmYWRkKCVbU0Zfb25lXSwgJVtTRl9TTmFOXSkgICAgICAvKiBTZXQgdXNyLkZQ
SU5WRiAqL1xuXHQiCisgICAgICAgICIgICAgcjEwID0gYWRkKHIxMCwgIzEpICAgICAgICAgICAg
ICAgICAgICAgIC8qIE5vIHBrdCBjb21taXQgKi9cblx0IgorICAgICAgICAifVxuXHQiCisgICAg
ICAgICIlW3Vzcl9vdXRdID0gdXNyXG5cdCIKKyAgICAgICAgOiBbdXNyX291dF0iPXIiKHVzcl9v
dXQpCisgICAgICAgIDogW3ZhbF8weGZmZl0iciIoMHhmZmYpLAorICAgICAgICAgIFtTRl9vbmVd
InIiKFNGX29uZSksIFtTRl9TTmFOXSJyIihTRl9TTmFOKSwKKyAgICAgICAgICBbdmFsXzB4MDEw
MDIwYTVdInIiKDB4MDEwMDIwYTUpLAorICAgICAgICAgIFtlcnJdIm0iKGVycikKKyAgICAgICAg
OiAicjIiLCAicjEwIiwgInIxMSIsICJ1c3IiKTsKKyAgICBjaGVjazMyKHVzcl9vdXQgJiAweDNm
LCBVU1JfT1ZGIHwgVVNSX0ZQSU5WRiB8IFVTUl9GUElOUEYpOworCisgICAgLyogVGVzdCBzZXR0
aW5nIHNldmVyYWwgVVNSIGJpdHMgaW4gdGhlIHNhbWUgcGFja2V0IChubyBwa3QgY29tbWl0KSAq
LworICAgIGFzbShDTEVBUl9VU1JCSVRTIFwKKyAgICAgICAgIntcblx0IgorICAgICAgICAiICAg
IHIxMCA9IHNhdHViKCVbdmFsXzB4ZmZmXSkgICAgICAgICAgICAgICAvKiBTZXQgdXNyLk9WRiAq
L1xuXHQiCisgICAgICAgICIgICAgcjEyID0gc2ZhZGQoJVtTRl9vbmVdLCAlW1NGX1NOYU5dKSAg
ICAgIC8qIFNldCB1c3IuRlBJTlZGICovXG5cdCIKKyAgICAgICAgIn1cblx0IgorICAgICAgICAi
JVt1c3Jfb3V0XSA9IHVzclxuXHQiCisgICAgICAgIDogW3Vzcl9vdXRdIj1yIih1c3Jfb3V0KQor
ICAgICAgICA6IFt2YWxfMHhmZmZdInIiKDB4ZmZmKSwKKyAgICAgICAgICBbU0Zfb25lXSJyIihT
Rl9vbmUpLCBbU0ZfU05hTl0iciIoU0ZfU05hTikKKyAgICAgICAgOiAicjIiLCAicjEwIiwgInIx
MSIsICJyMTIiLCAidXNyIik7CisgICAgY2hlY2szMih1c3Jfb3V0ICYgMHgzZiwgVVNSX09WRiB8
IFVTUl9GUElOVkYpOworCisgICAgLyogVGVzdCBzZXR0aW5nIHNldmVyYWwgVVNSIGJpdHMgaW4g
dGhlIHNhbWUgcGFja2V0ICh3aXRoIHBrdCBjb21taXQpICovCisgICAgYXNtKENMRUFSX1VTUkJJ
VFMgXAorICAgICAgICAie1xuXHQiCisgICAgICAgICIgICAgcjEwID0gc2F0dWIoJVt2YWxfMHhm
ZmZdKSAgICAgICAgICAgICAgIC8qIFNldCB1c3IuT1ZGICovXG5cdCIKKyAgICAgICAgIiAgICBy
MTEgPSBjb252ZXJ0X3V3MnNmKCVbdmFsXzB4MDEwMDIwYTVdKSAgLyogU2V0IHVzci5GUElOUEYg
Ki9cblx0IgorICAgICAgICAiICAgIHIxMiA9IG1lbXcoJVtlcnJdKSAgICAgICAgICAgICAgICAg
ICAgICAvKiBGb3JjZSBwa3QgY29tbWl0ICovXG5cdCIKKyAgICAgICAgIn1cblx0IgorICAgICAg
ICAiJVt1c3Jfb3V0XSA9IHVzclxuXHQiCisgICAgICAgIDogW3Vzcl9vdXRdIj1yIih1c3Jfb3V0
KQorICAgICAgICA6IFt2YWxfMHhmZmZdInIiKDB4ZmZmKSwKKyAgICAgICAgICBbdmFsXzB4MDEw
MDIwYTVdInIiKDB4MDEwMDIwYTUpLAorICAgICAgICAgIFtlcnJdIm0iKGVycikKKyAgICAgICAg
OiAicjIiLCAicjEwIiwgInIxMSIsICJyMTIiLCAidXNyIik7CisgICAgY2hlY2szMih1c3Jfb3V0
ICYgMHgzZiwgVVNSX09WRiB8IFVTUl9GUElOUEYpOworfQorCiBpbnQgbWFpbigpCiB7CiAgICAg
VEVTVF9SX09QX1Ioc2F0dWIsICAgICAgIDAsICAgICAgICAgMCwgICAgICAgICBVU1JfQ0xFQVIp
OwpAQCAtMTA5Nyw2ICsxMTQ5LDggQEAgaW50IG1haW4oKQogICAgIFRFU1RfUnBfT1BfUihzZmlu
dnNxcnRhLCBTRl9zbWFsbF9uZWcsICBTRl9IRVhfTmFOLCAgICAgICAweDAwLCBVU1JfRlBJTlZG
KTsKICAgICBURVNUX1JwX09QX1Ioc2ZpbnZzcXJ0YSwgU0ZfU05hTiwgICAgICAgU0ZfSEVYX05h
TiwgICAgICAgMHgwMCwgVVNSX0ZQSU5WRik7CiAKKyAgICB0ZXN0X3Vzcl9wYWNrZXRzKCk7CisK
ICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVycjsKIH0KLS0g
CjIuMzQuMQoK

