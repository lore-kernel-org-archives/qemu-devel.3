Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9083CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5FG-0000wf-Pp; Fri, 29 May 2026 17:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5FF-0000n5-HS
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5FD-0001Gg-Nv
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2LP02998031
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=Nup6pqhkab2S/AowMTOHN2ECN5lxoQEQE2PDLCMDr6E=; b=Dx
 ZRxZNW5taAu8j0XMPcwp3ZQ4/6BNtsPzVvDxWnfmixJiVKVBkNFcDg4LxdfqSXs9
 i2XGpKcG3Gt8K8o99sQOLsLLqH6NIgF1cYD9Ewznm465dZcTwh2YepdTHKgTWBXR
 Oo4X7fZ1Zzpo94cLqLnoshnuvn45Q3Ry6pwi0is4CrC+y2d+xJG09vERAWKWyYN6
 xe6VEiX0lG3C/jVxiKCImK9yPFABuuV9iXqS88Sw2r3t3ni6dOMmnAhUSghivxgV
 ucgqruupLoudRaHU6auLCyuiLk4ui2pNSjKDILiWyiYkvpTUvHL+3ZPxisz3ZeTb
 jWxbdZ0p6uafbPvGjJnw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4f0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:54 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135de949041so15170474c88.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091994; x=1780696794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nup6pqhkab2S/AowMTOHN2ECN5lxoQEQE2PDLCMDr6E=;
 b=DOIlSWZwKCy8s/RiNEdN+4w/RLtObqiyknHhD0Ak8+E/oUBCB7RaZISmaeV+a/xuyN
 ZImGBDAoGJ8FmA0dTI+5EEUutEuYD7FqSp0nFvlJp//v7EbRTO73+x+/4UHbQqFR21KV
 +0Oh0UpAUx8GTPGo8ljjEhPv3rY6kCa8jnXWaO9cQziYgC6CzPzTsoJy5p2fJOQR1nv/
 CtRxxrDn8eQzoymc5e5sG86gdzma9+1EyJedEauPaMxMjOhxVlaU4K6OG41KqzvVGlyh
 hn8CbqZGyObuba/gPlw5fBKJgbRHvr1bhp3PSgAh/0otTyHSPPqqdFQ0t38tImPm5v/+
 naKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091994; x=1780696794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nup6pqhkab2S/AowMTOHN2ECN5lxoQEQE2PDLCMDr6E=;
 b=evgj9IT3TPXSR9TmD3Relu2OBs2Grq2A0sEY45rcnbcCX949KqK6tgODjv2WmGxA1g
 YqdDMyfcOl9CnpamA59qttvMs5/piCJFNF2d1ncr7IUKaVX65KK16tDh1v/eMoJcNvhM
 BAUC3cx/Z9IdhxDZ/dG9KavFpPRr9Y18MJi5N+GYXiwLVlhdqm+hC8fEQQFNAvSCmC3M
 SYdtHo5UfvtvkgIYyW/KWdw9JynUhEYNL4d1ANp4kH1sq0mfKEPWRtq75Ybardo0Ka9u
 dsCMNYupSzqWdJe9G8OyZz3Sc//pK8iWGYd47cJ95KnSj5iB2IlZnz0L+qaFo1yNGmQM
 l1rg==
X-Gm-Message-State: AOJu0YyDa4hmY9ApL6bb/IG68YGfTWIS2eS3UuyoIjrmW/yq6+VE6E7m
 sQRPhaj5tDh28C4+VCtEEKrHN+wGS+5QCo/uUzgwT/IISUX2CcR9rGQH3sMXZCDMwCo/Sdv0BfV
 9GMZvgOiSL+8l87aO+wGiL5OQlm2UBQiB+/DXMjW/5SsU4nBI/K/eWMh57eFnnoF+vg==
X-Gm-Gg: Acq92OGFWkK2/IM7oy0nJJzo5I6tjD14gy1RlPFIG07iyJ2E3TToDjGTZmG5zRovqXp
 rFImy3LRBMju3ykrGQlIdoai8tVKYvt/eAAJOWIVyKIu2qPEJCE6DScHQQKHMaDnQRWyvZxsj28
 PrvTAC4pd9zkqb6wW3XWCVxIm3nvcCoV1+L4ROFc7TgGR091T5iK9H166+98eUePYG2nknh9yUm
 P1qySm9yrKhlnVWlbEbCet7aXnzZIcQL8FIRHQFkMRw+/JT/iXoWxsvcDVHCaAIFH6RvNGZSO0S
 8MAaIBJQpDO/Hrg+JGtIcfvyQGDMjvp1zJj0+EbY0vOHxAQASbkPX2ZbkqDegFaC+UB2T1OFfg5
 RBeOYlUMjwUyGVm5GG7IGYLy2S0Fe91g4uSABSVEKarGKui7moJ7ymFH2YTYB3i81UtHZGsG2Bg
 wRgGEi
X-Received: by 2002:a05:7022:45:b0:132:ac76:9772 with SMTP id
 a92af1059eb24-137d424906amr622577c88.34.1780091993775; 
 Fri, 29 May 2026 14:59:53 -0700 (PDT)
X-Received: by 2002:a05:7022:45:b0:132:ac76:9772 with SMTP id
 a92af1059eb24-137d424906amr622556c88.34.1780091993229; 
 Fri, 29 May 2026 14:59:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm2101445c88.11.2026.05.29.14.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:59:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 9/9] tests/qtest: Add hexagon boot-serial-test
Date: Fri, 29 May 2026 14:59:37 -0700
Message-Id: <20260529215937.610229-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4pNb69nLfjDY
 hPlfWwF/3ZMLeVrUIWnhK7QPCYzTKcxnzID2MZs/8GJb0wwA5qDxYcgwdo0GytshUMxX4L8/EhA
 UZgLHq3BxkpPt/2oq/FgbyrfJSJSLSgnqyFY15/DD8HRkbUvuWJcosVfpE/Vhn5zJDV+XGAxbKc
 fllj3mtF4kqsy3PWR7ILJ18L7yPPh0fOV56nlUYxZzAhWhBHR7aBEP5TmDFbSVl/IuVyhKgPYQ8
 VezBrtnLF/2qXHb+oZizeARkJoYfOA3/CugCwK+HH2S8yFKbvU+rrdsOGP0ODBCBSowocgql4TA
 vkMBaonpBKuH8qpt8nkXoYn+kudaB0OyhYydwdPgDzhEvH66/sRoYYROwYHTiigI/uMTYpLRQnp
 BwSPaquW1HuZY19K31nghVjS805wTvXZCNWeWwLIanFj9J9PChLqQuNHcRJ7WiYrUMijhAoIKPP
 kQy7xA5R6xZBD6LVwRg==
X-Proofpoint-ORIG-GUID: mf2mcLiSVW4bGhtCw0LfyQG_ErVRbGW3
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0c5a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mf2mcLiSVW4bGhtCw0LfyQG_ErVRbGW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsr
KysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5
YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQy
LDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7
CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4
MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFn
b25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyog
aW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAg
ICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAs
IDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAq
LworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4
MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7
CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwog
ICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAg
LTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAg
eyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5l
bF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAg
ICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292
ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hl
eGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApp
bmRleCA3MjhkZGU1NGIzZi4uYjZkNTExM2I4YWYgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTMsNiArMjkzLDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBjb25maWdfYWxs
X2RldmljZXMuaGFzX2tleSgnQ09ORklHX1JJU0NWX0lPTU1VJykgPwogICAgWydpb21tdS1yaXNj
di10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBbJ2Jvb3Qtc2VyaWFsLXRlc3QnXQor
CiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9zX3Rlc3Rfc3MuYWRkKAogICAnYWM5
Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

