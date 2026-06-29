Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45018C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBo6-0005jP-0N; Mon, 29 Jun 2026 09:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo4-0005fA-KM
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo2-0003H4-Su
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4tb2627852
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dY/1s85TBUfEZ6DKxNXbQLtO9YNnO553PDpX0fAztOM=; b=Qr/Qmz6u1WOBGC8f
 VJByFVm/WQRDhM4qinwLLAACO4hERrb1nQMkhMkgF7G3sNtvKmq0zsOGciv6Ii50
 qdlG67by54H9ZEgyek+ojGHDPQlUjCBqB9+0jrdAAn36XJPOv/yAFqRhdkcKV7qP
 KrzfcSPo1nkqhfECDOJsGVRW0WALhGK8Km4CCFyUMYsZm7iW6htTuQolTrhZD6zj
 fTzJAmNnobHYN6DtYjchr3sZvgK7uwYSMUox1CXdj/F/r9h8kw90i41cldACD3ez
 U0F0kdHKFJZppw9ukBfYRxIDwOOpcW/HC3ZR5d9pQf7SOSDSnpAF6xCgEYKQ7McO
 OxBAPg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgs1aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13b0686d13eso1427892c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738815; x=1783343615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY/1s85TBUfEZ6DKxNXbQLtO9YNnO553PDpX0fAztOM=;
 b=OgurDdSqai3yqObEnhCwhz3wcE9VwxgxVRskNBnKR0dEqBCdX6yKW9k0PjXmltBnJp
 ilkACj8V9j+DbyxKiusLwa4ZE3feL+9EZAsputB5BYBiH2e/C3zIkSHYHnW/gX9rzr1v
 lqd7Bps+Jh8M6sO1d8MSCCEkzs7AxY0IxT1p63+qeKMOee92JFw+LfshyX5b/zTL8QUT
 bVLR8OLLp0a2hmfyo++Qr5Y+Fm4csMtn/iO/tBb5mLcRTJsZr9kkuWzyUZv2EHgRTu12
 vtqMLPl4JrspAZHVHGhEty3SauMA8G5Yiv4YMo9qnxfYebtJma/yJPWxGrtKKQdSkDzU
 dY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738815; x=1783343615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dY/1s85TBUfEZ6DKxNXbQLtO9YNnO553PDpX0fAztOM=;
 b=Xtx9VuxiESrkgJXRr/l1hecJd+XMno7rc0wtkN+QSop50CQyBh1oIgeOWReyeOb7vT
 YgIVlRcazr+VhBAEvTQ1RHWYsXvGpQSQOEfGsUc1VMGioiPK3nHBCGYPjuefXHIw6/zE
 KsI2/7etXHQ8oqYCOX74BZaeQbbaawVuZ1kIgtqPBLWmFLAAhWZdYCW7nAX4ehsRe7qI
 BCRr/3vTV33KylI8Cx+5ikjwnG/7pP8piU9gmmOIvT23/soFa3P6Np1a6OlRps6hiGVz
 grbEuYBwQHxCfa2AkTJzxX7VLtUQef/Il7f3RQV7mvxkD2fM/+kqC5WN+VtESeqDHxw0
 VZFA==
X-Gm-Message-State: AOJu0YwRHN+5AfG1Ba2sCApuIr2/iNx+FbkQItq3T7uY8rXsTEuWfzCU
 OjzpwoL+WgBrnhb6mIydjlyVn410C8nLl0Xw7RrYzp3yS/RyrhR+QNQXYb4kjazKbtCHgYT6A+E
 JaudxLEjU560wGez1SkvgR/dypQ9nvREcGut8XpjaY8DLkdIUxM0gJXrYqyUACJzEOQ==
X-Gm-Gg: AfdE7cmrP+uQECrLujWzDRa5j4ZGAioSB6kErZQmtLE/sHV25rhB3oj54K6r/F3ZEEB
 Sk2+A1Q5vTWKUHAan5URfwA/Z6feRGmaKLx8u5fDRj/mV+63pVpXGBvOpNN6LoMry/w8KB++wIe
 OpKeHvC7J7QxvWq/gMzSyXhVofyvAng/cOTEn7nwTKht+25sRaFTjAvCY7ItjV1boLYUFW375aJ
 OMuBqQ1IGAo+B4gU59UqKI1AQeRkVS6eQm8PBTo7Oe5hFX4LIyhGOOQ6M/Oy1OLDo49hIMvTXQT
 TTZyvsH6e6ZPVmUMMov0bNAHMXZ/XmHESnTAFdnuIop41BRXDkXd6z2DrMp+STkdMWPsHygkymt
 DqiYdbqjmM/XLzT5unlQyC/8IavPeKpOD5A16HBxWsMxQxJMlMiGWahhdYcM=
X-Received: by 2002:a05:7022:301:b0:139:e497:a805 with SMTP id
 a92af1059eb24-13b220da180mr430767c88.10.1782738814922; 
 Mon, 29 Jun 2026 06:13:34 -0700 (PDT)
X-Received: by 2002:a05:7022:301:b0:139:e497:a805 with SMTP id
 a92af1059eb24-13b220da180mr430745c88.10.1782738814317; 
 Mon, 29 Jun 2026 06:13:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 34/77] target/hexagon: Add implementation of cycle counters
Date: Mon, 29 Jun 2026 06:11:49 -0700
Message-Id: <20260629131232.2487780-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: VE44uFc4OnnKQ7rI_QFbTp8V7F5x6HVt
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a426f80 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Bw4caLd0n_0OF-yX4NUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX0bYG5e7d9a39
 alof2IoQKr4R+Dx9FRp5a7b7sh4k/bHfA4t9TdqQGqDiN7j+jKLkrTRFlPWpn+JYlLP00GQWyww
 P8nOwlHGSogmpZUZFU/mXfcL55zukPs=
X-Proofpoint-GUID: VE44uFc4OnnKQ7rI_QFbTp8V7F5x6HVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX1IW+D4mfJ5y0
 hAJ2CwW3xR95nQZUmIUgbKKv+eLZuW6e634AAsMOliUJ3y3k9aJ7z+sM7xEKue1Fn1YotQmT8Ce
 lCY1UKVCbkeeQZclzjgQbIjIGl0t00RTC4y24VVOnfO5ScbMRrRsGm5jpxbd2mpEp+CfSnS7rig
 eBmBUb7REmBkcA+hWnSoZ0ic7qBbxe1mG8SzM/Dm+KRn+BDjfGVSse9mY/ae3/AWO5PZM2ewAQ9
 Ty49/Q0ygcDcwHeF/JItYAnJj84n8SyfbXIK3B1l2Xw2ViPZwOjf2aHMURgWyjt1FVGLiCzurYa
 TICcI0lI/mL0RqdfWb2nSw7ZeJv3huuyeQfXEVC5HdfIOcnu5XIuEfQNaz08hkScprkcDSlXHIo
 VdBGG7RNQlUe82/mNQNYzPSwoZkqAvVUs1lEP4xqrVn6cDV2SHsOgJ4GGI76Tc7dtE1MTWQIyGn
 1yKus6IHHYDUjEmOP6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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

QWRkIGN5Y2xlIGNvdW50aW5nIGluZnJhc3RydWN0dXJlIGZvciBzeXN0ZW0gZW11bGF0aW9uOgot
IFBDWUNMRV9FTkFCTEVEIFRCIGZsYWcgdG8gZ2F0ZSBjeWNsZSBjb3VudGluZwotIGdlbl9wY3lj
bGVfY291bnRlcnMoKSB0byBlbWl0IGN5Y2xlIGNvdW50IGluY3JlbWVudHMKLSBSZWFsIGltcGxl
bWVudGF0aW9ucyByZXBsYWNpbmcgcGN5Y2xlIHN0dWJzIGluIGNwdV9oZWxwZXIuYwotIGhleF9j
eWNsZV9jb3VudCBUQ0cgZ2xvYmFsIGZvciB0X2N5Y2xlX2NvdW50Ci0gcGN5Y2xlX2VuYWJsZWQg
Y29udGV4dCBmaWVsZCBpbiBEaXNhc0NvbnRleHQKCkFsbCBwY3ljbGUgY29kZSBpcyBndWFyZGVk
IGJ5ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWS4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNv
biA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggIHwgIDMgKysrCiB0YXJnZXQv
aGV4YWdvbi9jcHUuYyAgICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVy
LmMgfCAxNCArKysrKysrKysrKy0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBi
L3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDI1NDA0NThiMzcwLi5kZGY2ZGE3OGMxOCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgK
QEAgLTE2NCw2ICsxNjQsNyBAQCBzdHJ1Y3QgQXJjaENQVSB7CiAjaW5jbHVkZSAiY3B1X2JpdHMu
aCIKIAogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1AsIDAsIDEpCitGSUVMRChUQl9GTEFH
UywgUENZQ0xFX0VOQUJMRUQsIDQsIDEpCiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNl
X2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgK
aW5kZXggNTc3NjdhY2YwMDIuLjIwOGNmMTQxZTdlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtODUsNiAr
ODUsOSBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIFRDR3YgbmV3X3ByZWRf
dmFsdWVbTlVNX1BSRUdTXTsKICAgICBUQ0d2IGJyYW5jaF90YWtlbjsKICAgICBUQ0d2IGRjemVy
b19hZGRyOworICAgIGJvb2wgcGN5Y2xlX2VuYWJsZWQ7CisgICAgYm9vbCBwa3RfZW5kc190YjsK
KyAgICB1aW50MzJfdCBudW1fY3ljbGVzOwogfSBEaXNhc0NvbnRleHQ7CiAKIGJvb2wgaXNfZ2F0
aGVyX3N0b3JlX2luc24oRGlzYXNDb250ZXh0ICpjdHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBhMDgwODNlYTI5MC4uMDc3
M2VmOGZlNzkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0yNjgsNiArMjY4LDEwIEBAIHN0YXRpYyBUQ0dUQkNQVVN0YXRlIGhl
eGFnb25fZ2V0X3RiX2NwdV9zdGF0ZShDUFVTdGF0ZSAqY3MpCiAgICAgICAgIGhleGFnb25fcmFp
c2VfZXhjZXB0aW9uX2VycihlbnYsIEhFWF9DQVVTRV9QQ19OT1RfQUxJR05FRCwgMCk7CiAgICAg
fQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMy
KGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVELCAxKTsKKyNlbmRpZgorCiAgICAg
cmV0dXJuIChUQ0dUQkNQVVN0YXRlKXsgLnBjID0gcGMsIC5mbGFncyA9IGhleF9mbGFncyB9Owog
fQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggYTJiNDg2ZjRiYjUuLmJiOTkxYTY3MWU4IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jCkBAIC0zMywxNyArMzMsMjUgQEAgdWludDMyX3QgaGV4YWdvbl9nZXRfcG11X2Nv
dW50ZXIoQ1BVSGV4YWdvblN0YXRlICpjdXJfZW52LCBpbnQgaW5kZXgpCiAKIHVpbnQ2NF90IGhl
eGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50NjRfdCB0b3RhbCA9IDA7CisgICAgQ1BV
U3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBDUFVfRk9SRUFD
SChjcykgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSBjcHVfZW52KGNz
KTsKKyAgICAgICAgdG90YWwgKz0gdGhyZWFkX2Vudi0+dF9jeWNsZV9jb3VudDsKKyAgICB9Cisg
ICAgcmV0dXJuIHRvdGFsOwogfQogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2Nv
dW50X2hpZ2goQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICByZXR1cm4gKHVpbnQzMl90KShoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudikgPj4gMzIpOwogfQogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
X2xvdyhDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworICAgIHJldHVybiAodWludDMyX3QpKGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52
KSk7CiB9CiAKIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCB2YWwpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDk3ODQ5YWI4NjFh
Li5lZDk2ZDlhNjZiMyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTYxLDYgKzYxLDkgQEAgVENHdl9pNjQg
aGV4X3N0b3JlX3ZhbDY0W1NUT1JFU19NQVhdOwogVENHdiBoZXhfbGxzY19hZGRyOwogVENHdiBo
ZXhfbGxzY192YWw7CiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OworI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCitUQ0d2X2k2NCBoZXhfY3ljbGVfY291bnQ7CisjZW5kaWYKIFRDR3YgaGV4X3Zz
dG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIFRDR3YgaGV4X3ZzdG9yZV9zaXplW1ZTVE9SRVNfTUFY
XTsKIFRDR3YgaGV4X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKQEAgLTEyOCw2ICsxMzEs
MTUgQEAgc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCiAgICAgZ2VuX2hl
bHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihleGNwKSk7CiB9
CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgZ2VuX3BjeWNsZV9jb3Vu
dGVycyhEaXNhc0NvbnRleHQgKmN0eCkKK3sKKyAgICBpZiAoY3R4LT5wY3ljbGVfZW5hYmxlZCkg
eworICAgICAgICB0Y2dfZ2VuX2FkZGlfaTY0KGhleF9jeWNsZV9jb3VudCwgaGV4X2N5Y2xlX2Nv
dW50LCBjdHgtPm51bV9jeWNsZXMpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBn
ZW5fZXhlY19jb3VudGVycyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICB0Y2dfZ2VuX2FkZGlf
dGwoaGV4X2dwcltIRVhfUkVHX1FFTVVfUEtUX0NOVF0sCkBAIC0xMzYsNiArMTQ4LDkgQEAgc3Rh
dGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAg
ICAgICAgICAgIGhleF9ncHJbSEVYX1JFR19RRU1VX0lOU05fQ05UXSwgY3R4LT5udW1faW5zbnMp
OwogICAgIHRjZ19nZW5fYWRkaV90bChoZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhfQ05UXSwKICAg
ICAgICAgICAgICAgICAgICAgaGV4X2dwcltIRVhfUkVHX1FFTVVfSFZYX0NOVF0sIGN0eC0+bnVt
X2h2eF9pbnNucyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBnZW5fcGN5Y2xlX2Nv
dW50ZXJzKGN0eCk7CisjZW5kaWYKIH0KIAogc3RhdGljIGJvb2wgdXNlX2dvdG9fdGIoRGlzYXND
b250ZXh0ICpjdHgsIHRhcmdldF91bG9uZyBkZXN0KQpAQCAtODEwLDYgKzgyNSw4IEBAIHN0YXRp
YyB2b2lkIGdlbl9jb21taXRfaHZ4KERpc2FzQ29udGV4dCAqY3R4KQogICAgIH0KIH0KIAorI2Rl
ZmluZSBQQ1lDTEVTX1BFUl9QQUNLRVQgMQorCiBzdGF0aWMgdm9pZCB1cGRhdGVfZXhlY19jb3Vu
dGVycyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBpbnQgbnVtX3JlYWxfaW5zbnMgPSAwOwpA
QCAtODI5LDYgKzg0Niw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9leGVjX2NvdW50ZXJzKERpc2Fz
Q29udGV4dCAqY3R4KQogICAgIGN0eC0+bnVtX3BhY2tldHMrKzsKICAgICBjdHgtPm51bV9pbnNu
cyArPSBudW1fcmVhbF9pbnNuczsKICAgICBjdHgtPm51bV9odnhfaW5zbnMgKz0gbnVtX2h2eF9p
bnNuczsKKyAgICBjdHgtPm51bV9jeWNsZXMgKz0gUENZQ0xFU19QRVJfUEFDS0VUOwogfQogCiBz
dGF0aWMgdm9pZCBnZW5fY29tbWl0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKQEAgLTk3OCw2
ICs5OTYsMTAgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlz
YXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgIGN0eC0+aXNfdGlnaHRfbG9vcCA9IEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSVNfVElHSFRfTE9PUCk7CiAgICAgY3R4LT5zaG9ydF9j
aXJjdWl0ID0gaGV4X2NwdS0+c2hvcnRfY2lyY3VpdDsKICAgICBjdHgtPmhleF9kZWYgPSBIRVhB
R09OX0NQVV9HRVRfQ0xBU1MoaGV4X2NwdSktPmhleF9kZWY7CisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBjdHgtPm51bV9jeWNsZXMgPSAwOworICAgIGN0eC0+cGN5Y2xlX2VuYWJsZWQg
PSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVEKTsKKyNlbmRp
ZgogfQogCiBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX3RiX3N0YXJ0KERpc2FzQ29udGV4dEJhc2Ug
KmRiLCBDUFVTdGF0ZSAqY3B1KQpAQCAtMTEyMSw2ICsxMTQzLDEwIEBAIHZvaWQgaGV4YWdvbl90
cmFuc2xhdGVfaW5pdCh2b2lkKQogICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGxs
c2NfdmFsKSwgImxsc2NfdmFsIik7CiAgICAgaGV4X2xsc2NfdmFsX2k2NCA9IHRjZ19nbG9iYWxf
bWVtX25ld19pNjQodGNnX2VudiwKICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBs
bHNjX3ZhbF9pNjQpLCAibGxzY192YWxfaTY0Iik7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
KyAgICBoZXhfY3ljbGVfY291bnQgPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTY0KHRjZ19lbnYsCisg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgdF9jeWNsZV9jb3VudCksICJ0X2N5Y2xl
X2NvdW50Iik7CisjZW5kaWYKICAgICBmb3IgKGkgPSAwOyBpIDwgU1RPUkVTX01BWDsgaSsrKSB7
CiAgICAgICAgIHNucHJpbnRmKHN0b3JlX2FkZHJfbmFtZXNbaV0sIE5BTUVfTEVOLCAic3RvcmVf
YWRkcl8lZCIsIGkpOwogICAgICAgICBoZXhfc3RvcmVfYWRkcltpXSA9IHRjZ19nbG9iYWxfbWVt
X25ldyh0Y2dfZW52LAotLSAKMi4zNC4xCgo=

