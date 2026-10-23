Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFAD606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R2UX8JbS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M/7tmboO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKODV-0002XM-4e; Fri, 23 Oct 2026 18:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKODT-0002Wp-5v
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:58:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKODR-0004k2-Ao
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:58:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv4R53982726
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 22:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 otIqGnoRhtwE09jN124fMDxxXB2gSblXU38jbQmf9BU=; b=R2UX8JbSc4PS8/Vr
 IFvyU1zHXk80COY4fYqNoy9OiuHRJBPZ4+X0qdmUtyNj+hi9hMCmytM8icdG0F2m
 euK1biQI4B2qLf3PygVnTekfmb/sesQXA5Sh7MnIzkeVsXa6T6NIIJP43BjV8n1c
 GU9H/qhBI53EQS0Kt/Bk9nSArgGQ65MglAI24ooQOMO0sj0NxAWahmFuAmCpLqLR
 aZeJRzw70fFt0OF7EWgOxswrFC1C+pH0+ECeGIbb9P7pKjMBSB7NcMR0HB3HvtBx
 ZsKel8re9gIsMxx//lRPwvWeO8DElE6XkdaK+MZjG0Vw255SXU2xuX8GMUUhZ7Gj
 KWGF/A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart1b4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 22:58:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so1509154c88.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792796303; x=1793401103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=otIqGnoRhtwE09jN124fMDxxXB2gSblXU38jbQmf9BU=;
 b=M/7tmboOy4M8FqikQ7xvvpxgGp34gWMo6QgNydbDf+T6u2XMxv2sipqsGHCWC/fnsG
 oNmU/HI3Ep1jU5m8wR7c8k9uM6j6BJiCqhn5M7ivC3bndf6oWDlu3yEqAC40moY1+Ld4
 QWPxb162hrqAWdanFh8th+iK+Ps3e+SSXv567pzC2jcpjRIFfSMY5WhoS5ZBSnCej46u
 TCApDLk5JceVm6iVUripL0L/M80pSDzSQ13XOqrMAt/pAxoIGUJksywVBw/l3m5fdtr8
 EGV1C0G4uujCzUVMr4/EkwRIZWbvl8/IGdVAnkjHaabPUUqwFLngtnrpVFqfJ8GYsocR
 IwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792796303; x=1793401103;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=otIqGnoRhtwE09jN124fMDxxXB2gSblXU38jbQmf9BU=;
 b=Drcl9Wq0Zuvtj6NqHRL1UPGUQlXeD/Ni0guIRdIdXJXyUVNx9nlbhCgZTfSaGscA0I
 RvKYkKfa3ESCjXc3u0w21uQwVNB+ElaDWJGSQG70DkAkdwzSxI4+tr9hhmykphcHql1J
 0vLp6wWDT4585gRngmQ/XO3JH6agpgbyY0Ge9YVuTKrum6+1Sn/s26bhQpcNyEMHyXj7
 3D3VRHoG+t531VG38Qv8pqjVS74RCXSyzGamVAOjhIr6pWP8jR92CW0BGbm/My1MsW2G
 CNgsPD8dVCD1ZVMBfyvMFLlbOCJ30ijC/LrToXRubp0mz+VWlldiTue1RnukFwGNJezE
 g3BQ==
X-Gm-Message-State: AFq9FYLk8EAUtILFDg6YHb75zIS3KHGhESmh4ha6sbGo6PzkFFXM7Zb3
 /iTppJtr5qVJAO2V5hUf0ee6Y7Ya5OPEpFkIEKUpQTK8jpeVtyF7Fu71JO9qCCXnQ8GJiH5HXwI
 i+2Y+CMWPSSLGqQYlpu/PRpQ68HOk9xkxwbqJ0AtU/DYcd2fHjei/KntMKJkYgH08og==
X-Gm-Gg: AYBFou3gAIM8ei7EqQC8QWQmqY/DbcvcLTL08ZWqAJWCpZsqUC7ZwV7EM+gsmEg5hCJ
 3VoZWUYFTDEGALpSGg55Op1LK2eiqx+tbn/LvWVk3Ap8TaL/UtTHrmZfUo3+bDVTj0k4q8ma4DI
 OnqJnWCMq2W21CV6r8rXQv99O/i2wpp4NWzhib+7Rn1O9adBZ8Etzu3e2nC2+x7yoCQTQQWUmCp
 NfjlgIOifEWnwSYQGv9wUUQLKJq1TzaGxvyoClqUT7yWJQ9zUL5cNblJhYCJLl+bA/Rh3EpYP4u
 UHHZPKQfYHBY7omwEAS3JwOrTa9DIWd//F+6Iclu57BWmsL//IBL4Bd4ChJKvlWYzDfzILicaoP
 SpVGapDuCnli6hAdp28TUdCYfl15JWaFvHtmJvUdQT5mdHLM=
X-Received: by 2002:a05:7022:5e0b:b0:159:aa67:28c1 with SMTP id
 a92af1059eb24-19935be8193mr556649c88.20.1792796302880; 
 Fri, 23 Oct 2026 15:58:22 -0700 (PDT)
X-Received: by 2002:a05:7022:5e0b:b0:159:aa67:28c1 with SMTP id
 a92af1059eb24-19935be8193mr556614c88.20.1792796302260; 
 Fri, 23 Oct 2026 15:58:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm1280380c88.22.2026.10.23.15.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:58:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/4] target/hexagon: add v79 HVX vcvt2 instructions
Date: Fri, 23 Oct 2026 15:58:17 -0700
Message-Id: <20261023225820.330905-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023225820.330905-1-brian.cain@oss.qualcomm.com>
References: <20261023225820.330905-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MCBTYWx0ZWRfX81EJx+5ITfIG
 JIGif6P5xk0iMvhyqIPjgEYTCiBgtjkLGqxqc2JiF54SAynPz1WWeoLgbuX+TCTHl5owUgWnoCL
 A6tdrxVkJfodB2Qwrq3cgrjmxwJ33QgqhWSzCndcWj6pM0DUlZe/Nz2QFVxQJKG9wVDfzoANqDG
 EoBuQQ45lXCdtcvJd8NjiOpEcWNIGrOgvQxhZtn3cB9W7Bg8B1qzsXVJZDGSO7y0VfYNvxuWDpl
 XEESiWscLDB6pJ2V8EAaVrH5lZw6T4HS1os4DFTxzq0p7RqA4DsNzSoW9lJAzVtpaXclvdwZFtc
 cE2pfBrNbLbdK3VAMk+Q0nJ+ZeA4KpPlt4z1pLK8bBwBuWszwgJOLwQa8qM1x1qB+SZ7cSrv+7c
 0p9hYoEmIwxAkcT+a/CVesIvrY3h8jZOqmycYAX+4rLpv0XuRW7wQyCBwWGHscBfP9i4Z6AKhWh
 aaEZlV9VvL+XzbEeaHg==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adbe690 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5rcnURY8GYM5_4O9xYQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MCBTYWx0ZWRfX+WST/fCWpDTJ
 zAaYf4+8f5R2yWKKYwPAI30r5a9b7/IbXK62dpe7JhBZYwYngU6G7iUWp/5RMZFCnEa+0Hr68La
 uxvS5pfYplt4wg38yzNH9sZOtsMRUsI=
X-Proofpoint-ORIG-GUID: 2HN-jce5MergpE4GAAUfxO4kWpnWxRRx
X-Proofpoint-GUID: 2HN-jce5MergpE4GAAUfxO4kWpnWxRRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230090
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

QWRkIFY2X3ZjdnQyX3toZl91YixoZl9iLHViX2hmLGJfaGZ9LCB3aGljaCBkaWZmZXIgZnJvbSB2
Y3Z0IG9ubHkgaW4KZWxlbWVudCBpbnRlcmxlYXZpbmcuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdGFn
X3Jldl9pbmZvLmMuaW5jICAgICAgICAgICAgfCAgNCArKysKIHRhcmdldC9oZXhhZ29uL2ltcG9y
dGVkL21tdmVjL2VuY29kZV9leHQuZGVmIHwgIDQgKysrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9tbXZlYy9leHQuaWRlZiAgICAgICB8IDMzICsrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVz
IGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
YWdfcmV2X2luZm8uYy5pbmMgYi90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKaW5k
ZXggNDFjZTNjYjU3MmYuLjRhYjEzNWQzM2YzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90
YWdfcmV2X2luZm8uYy5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5j
CkBAIC02ODAsNiArNjgwLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRh
Z19yZXZfaW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAgICAgIC5pbnRyb2R1Y2VkID0gSEVY
X1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FCiAgICAgfSwKICAgICBbVjZfdmNvbnZf
cWYzMl9zZl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZF
Ul9OT05FIH0sCisgICAgW1Y2X3ZjdnQyX2JfaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJf
Vjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92Y3Z0Ml9oZl9iXSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAg
ICBbVjZfdmN2dDJfaGZfdWJdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92Y3Z0Ml91Yl9oZl0gPSB7IC5pbnRyb2R1Y2Vk
ID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1Y2X3ZpbG9n
Ml9oZl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9O
T05FIH0sCiAgICAgW1Y2X3ZpbG9nMl9xZjE2XSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbVjZfdmlsb2cyX3FmMzJdID0geyAu
aW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LApkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgYi90
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZgppbmRleCAzNGU2M2I4
OTc0My4uOTYwNWU4NzBhMWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21t
dmVjL2VuY29kZV9leHQuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2Vu
Y29kZV9leHQuZGVmCkBAIC04NDYsMTIgKzg0NiwxNiBAQCBERUZfRU5DKFY2X3ZjdnRfc2ZfaGYs
IjAwMDExMTEwLS0wLTAxMDBQUDF1dXV1dTEwMGRkZGRkIikKIERFRl9FTkMoVjZfdmN2dF9oZl9z
ZiwiMDAwMTExMTEwMTF2dnZ2dlBQMXV1dXV1MDAxZGRkZGQiKQogREVGX0VOQyhWNl92Y3Z0X2hm
X3ViLCIwMDAxMTExMC0tMC0wMTAwUFAxdXV1dXUwMDFkZGRkZCIpCiBERUZfRU5DKFY2X3ZjdnRf
aGZfYiwiMDAwMTExMTAtLTAtMDEwMFBQMXV1dXV1MDEwZGRkZGQiKQorREVGX0VOQyhWNl92Y3Z0
Ml9oZl91YiwiMDAwMTExMTAxMTAxMDEwMVBQMXV1dXV1MTExZGRkZGQiKQorREVGX0VOQyhWNl92
Y3Z0Ml9oZl9iLCIwMDAxMTExMDExMDEwMTAxUFAxdXV1dXUxMTBkZGRkZCIpCiBERUZfRU5DKFY2
X3ZjdnRfaGZfdWgsIjAwMDExMTEwLS0wLTAxMDBQUDF1dXV1dTEwMWRkZGRkIikKIERFRl9FTkMo
VjZfdmN2dF9oZl9oLCIwMDAxMTExMC0tMC0wMTAwUFAxdXV1dXUxMTFkZGRkZCIpCiBERUZfRU5D
KFY2X3ZjdnRfdWhfaGYsIjAwMDExMTEwLS0wLS0xMDFQUDF1dXV1dTAwMGRkZGRkIikKIERFRl9F
TkMoVjZfdmN2dF9oX2hmLCIwMDAxMTExMC0tMC0wMTEwUFAxdXV1dXUwMDBkZGRkZCIpCiBERUZf
RU5DKFY2X3ZjdnRfdWJfaGYsIjAwMDExMTExMTEwdnZ2dnZQUDF1dXV1dTEwMWRkZGRkIikKIERF
Rl9FTkMoVjZfdmN2dF9iX2hmLCIwMDAxMTExMTExMHZ2dnZ2UFAxdXV1dXUxMTBkZGRkZCIpCitE
RUZfRU5DKFY2X3ZjdnQyX3ViX2hmLCIwMDAxMTAxMDExMHZ2dnZ2UFAxdXV1dXUxMTFkZGRkZCIp
CitERUZfRU5DKFY2X3ZjdnQyX2JfaGYsIjAwMDExMDEwMTEwdnZ2dnZQUDF1dXV1dTExMGRkZGRk
IikKIAogLyogSUVFRSBGUCB2Y29udiBpbnN0cnVjdGlvbnMgKi8KIERFRl9FTkMoVjZfdmNvbnZf
c2ZfdywiMDAwMTExMTAtLTAtLTEwMVBQMXV1dXV1MDExZGRkZGQiKQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZXh0LmlkZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBv
cnRlZC9tbXZlYy9leHQuaWRlZgppbmRleCAzNTkyOTMwNzc3ZS4uYjlhNDg1OGQwYzEgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmCkBAIC0zMTAzLDYgKzMxMDMsMjUgQEAg
SVRFUkFUT1JfSU5TTl9JRUVFX0ZQX0RPVUJMRV8xNigzMiwgIHZjdnRfaGZfYiwgICJWZGQzMi5o
Zj12Y3Z0KFZ1MzIuYikiLAogICAgIFZkZFYudlsxXS5oZlsyKmldICAgPSBpbnQ2NF90b19mbG9h
dDE2X3NjYWxibihWdVYuYls0KmkrMl0sIGZsb2F0X3JvdW5kX25lYXJlc3RfZXZlbiwgMCk7CiAg
ICAgVmRkVi52WzFdLmhmWzIqaSsxXSA9IGludDY0X3RvX2Zsb2F0MTZfc2NhbGJuKFZ1Vi5iWzQq
aSszXSwgZmxvYXRfcm91bmRfbmVhcmVzdF9ldmVuLCAwKSkKIAorLyoKKyAqIFRoZSB2Y3Z0MiB2
YXJpYW50cyBkaWZmZXIgZnJvbSB2Y3Z0IG9ubHkgaW4gd2hpY2ggc291cmNlIGVsZW1lbnRzIGxh
bmQgaW4KKyAqIHdoaWNoIGhhbGYgb2YgdGhlIHJlc3VsdCBwYWlyOiB0aGUgZXZlbiBzb3VyY2Ug
Ynl0ZXMgZ28gdG8gdGhlIGZpcnN0CisgKiB2ZWN0b3IgYW5kIHRoZSBvZGQgb25lcyB0byB0aGUg
c2Vjb25kLgorICovCitJVEVSQVRPUl9JTlNOX0lFRUVfRlBfRE9VQkxFXzE2KDMyLCAgdmN2dDJf
aGZfdWIsICJWZGQzMi5oZj12Y3Z0MihWdTMyLnViKSIsCisgICAgIlZlY3RvciBJRUVFIGN2dDIg
ZnJvbSBpbnQ6IHViIHdpZGVuIHRvIGhmIiwKKyAgICBWZGRWLnZbMF0uaGZbMippXSAgID0gdWlu
dDY0X3RvX2Zsb2F0MTZfc2NhbGJuKFZ1Vi51Yls0KmldLCAwLCAmZW52LT5odnhfZnBfc3RhdHVz
KTsKKyAgICBWZGRWLnZbMF0uaGZbMippKzFdID0gdWludDY0X3RvX2Zsb2F0MTZfc2NhbGJuKFZ1
Vi51Yls0KmkrMl0sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpOworICAgIFZkZFYudlsxXS5oZlsy
KmldICAgPSB1aW50NjRfdG9fZmxvYXQxNl9zY2FsYm4oVnVWLnViWzQqaSsxXSwgMCwgJmVudi0+
aHZ4X2ZwX3N0YXR1cyk7CisgICAgVmRkVi52WzFdLmhmWzIqaSsxXSA9IHVpbnQ2NF90b19mbG9h
dDE2X3NjYWxibihWdVYudWJbNCppKzNdLCAwLCAmZW52LT5odnhfZnBfc3RhdHVzKSkKKworSVRF
UkFUT1JfSU5TTl9JRUVFX0ZQX0RPVUJMRV8xNigzMiwgIHZjdnQyX2hmX2IsICAiVmRkMzIuaGY9
dmN2dDIoVnUzMi5iKSIsCisgICAgIlZlY3RvciBJRUVFIGN2dDIgZnJvbSBpbnQ6IGIgd2lkZW4g
dG8gaGYiLAorICAgIFZkZFYudlswXS5oZlsyKmldICAgPSBpbnQ2NF90b19mbG9hdDE2X3NjYWxi
bihWdVYuYls0KmldLCAwLCAmZW52LT5odnhfZnBfc3RhdHVzKTsKKyAgICBWZGRWLnZbMF0uaGZb
MippKzFdID0gaW50NjRfdG9fZmxvYXQxNl9zY2FsYm4oVnVWLmJbNCppKzJdLCAwLCAmZW52LT5o
dnhfZnBfc3RhdHVzKTsKKyAgICBWZGRWLnZbMV0uaGZbMippXSAgID0gaW50NjRfdG9fZmxvYXQx
Nl9zY2FsYm4oVnVWLmJbNCppKzFdLCAwLCAmZW52LT5odnhfZnBfc3RhdHVzKTsKKyAgICBWZGRW
LnZbMV0uaGZbMippKzFdID0gaW50NjRfdG9fZmxvYXQxNl9zY2FsYm4oVnVWLmJbNCppKzNdLCAw
LCAmZW52LT5odnhfZnBfc3RhdHVzKSkKKwogSVRFUkFUT1JfSU5TTl9JRUVFX0ZQX0RPVUJMRV8z
MigzMiwgdmN2dF9zZl9oZiwgIlZkZDMyLnNmPXZjdnQoVnUzMi5oZikiLAogICAgICJWZWN0b3Ig
SUVFRSBjdnQ6IGhmIHdpZGVuIHRvIHNmIiwKICAgICBWZGRWLnZbMF0uc2ZbaV0gPSBmMTZfdG9f
ZjMyKFZ1Vi5oZlsyKmldKTsKQEAgLTMxMzksNiArMzE1OCwyMCBAQCBJVEVSQVRPUl9JTlNOX0lF
RUVfRlBfMTZfMzIoMzIsIHZjdnRfYl9oZiwgICJWZDMyLmI9dmN2dChWdTMyLmhmLFZ2MzIuaGYp
IiwKICAgICBWZFYuYls0KmkrMl0gPSBmbG9hdDE2X3RvX2ludDhfc2NhbGJuKFZ2Vi5oZlsyKmld
LCBmbG9hdF9yb3VuZF9uZWFyZXN0X2V2ZW4sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpOwogICAg
IFZkVi5iWzQqaSszXSA9IGZsb2F0MTZfdG9faW50OF9zY2FsYm4oVnZWLmhmWzIqaSsxXSwgZmxv
YXRfcm91bmRfbmVhcmVzdF9ldmVuLCAwLCAmZW52LT5odnhfZnBfc3RhdHVzKSkKIAorSVRFUkFU
T1JfSU5TTl9JRUVFX0ZQXzE2XzMyKDMyLCB2Y3Z0Ml91Yl9oZiwgIlZkMzIudWI9dmN2dDIoVnUz
Mi5oZixWdjMyLmhmKSIsCisgICAgIlZlY3RvciBjdnQyIHRvIGludDogaGYgbmFycm93IHRvIHVi
IiwKKyAgICBWZFYudWJbNCppXSAgID0gZmxvYXQxNl90b191aW50OF9zY2FsYm4oVnVWLmhmWzIq
aV0sIGZsb2F0X3JvdW5kX25lYXJlc3RfZXZlbiwgMCwgJmVudi0+aHZ4X2ZwX3N0YXR1cyk7Cisg
ICAgVmRWLnViWzQqaSsxXSA9IGZsb2F0MTZfdG9fdWludDhfc2NhbGJuKFZ2Vi5oZlsyKmldLCBm
bG9hdF9yb3VuZF9uZWFyZXN0X2V2ZW4sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpOworICAgIFZk
Vi51Yls0KmkrMl0gPSBmbG9hdDE2X3RvX3VpbnQ4X3NjYWxibihWdVYuaGZbMippKzFdLCBmbG9h
dF9yb3VuZF9uZWFyZXN0X2V2ZW4sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpOworICAgIFZkVi51
Yls0KmkrM10gPSBmbG9hdDE2X3RvX3VpbnQ4X3NjYWxibihWdlYuaGZbMippKzFdLCBmbG9hdF9y
b3VuZF9uZWFyZXN0X2V2ZW4sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpKQorCitJVEVSQVRPUl9J
TlNOX0lFRUVfRlBfMTZfMzIoMzIsIHZjdnQyX2JfaGYsICAiVmQzMi5iPXZjdnQyKFZ1MzIuaGYs
VnYzMi5oZikiLAorICAgICJWZWN0b3IgY3Z0MiB0byBpbnQ6IGhmIG5hcnJvdyB0byBiIiwKKyAg
ICBWZFYuYls0KmldICAgPSBmbG9hdDE2X3RvX2ludDhfc2NhbGJuKFZ1Vi5oZlsyKmldLCBmbG9h
dF9yb3VuZF9uZWFyZXN0X2V2ZW4sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpOworICAgIFZkVi5i
WzQqaSsxXSA9IGZsb2F0MTZfdG9faW50OF9zY2FsYm4oVnZWLmhmWzIqaV0sIGZsb2F0X3JvdW5k
X25lYXJlc3RfZXZlbiwgMCwgJmVudi0+aHZ4X2ZwX3N0YXR1cyk7CisgICAgVmRWLmJbNCppKzJd
ID0gZmxvYXQxNl90b19pbnQ4X3NjYWxibihWdVYuaGZbMippKzFdLCBmbG9hdF9yb3VuZF9uZWFy
ZXN0X2V2ZW4sIDAsICZlbnYtPmh2eF9mcF9zdGF0dXMpOworICAgIFZkVi5iWzQqaSszXSA9IGZs
b2F0MTZfdG9faW50OF9zY2FsYm4oVnZWLmhmWzIqaSsxXSwgZmxvYXRfcm91bmRfbmVhcmVzdF9l
dmVuLCAwLCAmZW52LT5odnhfZnBfc3RhdHVzKSkKKwogSVRFUkFUT1JfSU5TTl9TSElGVF9TTE9U
X0ZMVCgzMiwgdmNvbnZfd19zZiwiVmQzMi53PVZ1MzIuc2YiLAogICAgICJWZWN0b3IgY29udmVy
c2lvbiBvZiBzZjMyIGZvcm1hdCB0byBpbnQgdyIsCiAgICAgVmRWLndbaV0gPSBjb252X3dfc2Yo
VnVWLnNmW2ldLCAmZW52LT5odnhfZnBfc3RhdHVzKSkKLS0gCjIuMzQuMQoK

