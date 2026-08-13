Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57B6C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wua19-0003wQ-6V; Thu, 13 Aug 2026 14:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0s-00035D-Gd
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0n-0002H8-87
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DH8fUU304653
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eCWTqwclBlLHkStMtx+d8TC5Wvr713M4u6l2TBYeh3s=; b=hQBuqPujzsXhPNrS
 uAWc9ffvY5FWr5MT45GSB+SH5TWqtHiKgCTMt6ZSI4ThqcuefaLdsLMoHYwltHmw
 cBl+H6mky0H7pf22b72/ipbpsibziJ3AHjAfA3Mbjr0+m3znb6E+57sFnSuAd0AS
 5EHRT7nY6aFCiUwHbRRHRUWxfRa8utRK7ChqbLqrCkg92BdtkM3p2uJHUlAPm2r1
 tTb3rVNECxDIcg057QwM9Bjxbtsz/o9ZDwsCWIKBMW37aVxaFKYLEhkUew73phCQ
 9cCFIJgtVjvMVYAmtJYnyebQUnty87t7SoSIiuKBPGelDhT4DTV+YfeYE+zFpZx9
 ljmTCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2nga0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so2706021cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645107; x=1787249907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eCWTqwclBlLHkStMtx+d8TC5Wvr713M4u6l2TBYeh3s=;
 b=Dn9SjB9xUYWqiAomnP2k8wBxqK9R0KXs/Sz6gHTPCI005mwOncCFZ268jC1DDY/bLl
 QLj3365R84h9riJjrOefgfAW4w6GnmuilJ5D7J2Fmzo60RL5Xv9Oi/ebjZREutC3qFVC
 Cy7Jmkj/rAs+joH4DSYjCO5hTDdezRJVxce93nMX8xKphnmvHyr2wViosgrzept5Ya73
 QqNYJn5mnN37sNPXdIRzK6XZ4V8wF4Mv3qKPXkzXnNGwa+ZzPaf2VnVRePvmDwvzk0nw
 WnbZSaoVkoFdTZa7KPdrdq90l0ovfZf/AXlsyNUb8NsTrQNNIpvmBKdpWHnji8ZRW+/A
 GKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645107; x=1787249907;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eCWTqwclBlLHkStMtx+d8TC5Wvr713M4u6l2TBYeh3s=;
 b=LrObne4jyY/XJh/P4pYEugbxNWJUipabwYPU5T98HTzkBK4nDkIeUAGJlRXIYkTE/r
 P0DmpbVgSqnFtoq88ga3juqlTakrnpJqChlMsGVXWV22iGP98LU0drDjdQ8nJyJhbvw1
 1nZbCWre+DCRPjHhrvGWpB9yoBK+j6Cuwzz/OED5bE07lrgbTd5/TQ09EHKT98JsLLwW
 6wnJotLJmoWF+AEMKzKcfljsBC2aZI+IqrbBggtCTKe3U6eTkTvrvzXZ/b9WHFlQnFZ+
 Xyq0506vKJOgBZ2QTPoiMWJ09jLvNpQdjuuQHfOSo75sBGRsaYRZvGRkDfOv8WlXUnBg
 xG2A==
X-Gm-Message-State: AOJu0YwmbBNJPopXaM3vdrSbbyAl/LNFNmDSD1ZyRo7dLYe7nRJH4Jpr
 pWhl4SfzRx2cDZmBsIA8MZ2YVN+iPO0mfcmxlS6OgWwnyiM8xfbuxUzIkhzeKZmUT0VNZKJ0GtI
 d2Y+c7n1oXVu2HK2KCck2HTpbSzjUiWSVx3mT+9yggL7d16vFAgP0b6QZv/J0uBag4Q==
X-Gm-Gg: AR+sD11Ktslei7MZ0U3XDuniECTUtxWVgIopr7eKrHOKsswQDWDzdz7h9072dhwFjZY
 L9uD0SMUpSwDUGghOYhrkNaKDg3uzzGmNs8G2ODBeA74bcSXg5UrRlBX4meDMwMxMARo+D/ntUF
 cCiey6diV2nBA8pod42ykkjJHqjAhakAOZ2hf/EeqAdLusFtN/gV6C3OUcswjWpaGw4fOCC+0Vd
 7Z3+zO9QafzdWtwhdHW7hREhFdK2ZUFg0xvQFCcczV3YSRLPwQy0ppGubH6utLEaSABOQ4EtELf
 2N3BkJjZXzP8s8Y8YSeniUMmxClzlBlLv9Hn1Ug+ZzkhIhsC6/LTKPIQPeDezfUxdfwCI/VbIIa
 lfcZ3jhwWndbI4K0jCAn4YI5gDutQ+AaQZHxyL9CyyQ==
X-Received: by 2002:a05:622a:13c9:b0:52b:4f1a:5ff0 with SMTP id
 d75a77b69052e-52d73c9a46emr78211701cf.19.1786645106148; 
 Thu, 13 Aug 2026 11:18:26 -0700 (PDT)
X-Received: by 2002:a05:622a:13c9:b0:52b:4f1a:5ff0 with SMTP id
 d75a77b69052e-52d73c9a46emr78211021cf.19.1786645105711; 
 Thu, 13 Aug 2026 11:18:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f200752sm1254325f8f.1.2026.08.13.11.18.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:18:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 14/16] target/i386/hvf: Lock BQL outside of the vCPU inner
 execution loop
Date: Thu, 13 Aug 2026 20:16:37 +0200
Message-ID: <20260813181640.6537-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ApXeGu9P c=1 sm=1 tr=0 ts=6a7e0a73 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=k2pNA5m5VJBtx192dGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: V3A6b0cJiFRt2PhsUVsRmODqldMVH90v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX54y40OgsumCb
 vzJx9Nk60iidWEbrS0XsJWKc1UGEzorQXN66fYkRxAAglUg7Iz4n8Jm66dwpFAhEPwXkyr7iL72
 nL5rCMI00XBdNKuOJi0sKQKbjNfnh4k=
X-Proofpoint-GUID: V3A6b0cJiFRt2PhsUVsRmODqldMVH90v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX8NhxYCLL9g1j
 jqpcP3cgeHGqui/Ktc+ZpkFqvwx4k+bVen20UUmXFQKC7n61DE+9ZvwMF05ja/yENzS9PI9BbqJ
 gqUttgCQi/POP+YC+812rK/E9c+ruFpd+xMSoVvKIrqR0LhaqEv5nQy/2qkjozKAJp8O6Y8VOy3
 61We8nz6W//4ig5BaaTI8J2OEVEu3wr/5l5T5aP0ohyuFMEeOeyZqXAIskFpVDIVdADBgfSPgfP
 OqN9paqeoTmzn40yt52pgh6r6QBUSFoGFrbhp9upWzlf8+CIT0dUmO2xmxnQrNT9do3EzlsV73x
 Wbe2b5Q+4gvufNRR3GGfrF+hjvqM1oA6cmbCabjzXXCt+pj2x9VlPinhsc1SQuLYPGy52pZdLag
 5LjlnZwVXbNlwfac4F+TmKsCm6bAZo2ZwEwtwPtL+6Cx8gN/53nKUntphPJ/be5xD92p5BqCH2m
 PsTOK9SnLhX/F9sjOyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reduce lock contention by acquiring / releasing the BQL
outside of the entire vCPU inner loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/hvf/hvf.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0ffa3658dc5..f8bc01d38d3 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1009,6 +1009,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
+    bql_unlock();
+    cpu_exec_start(cpu);
+
     /* Inner vCPU loop */
     do {
         if (cpu->vcpu_dirty) {
@@ -1017,26 +1020,26 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
 
         if (hvf_inject_interrupts(cpu)) {
-            return EXCP_INTERRUPT;
+            ret = EXCP_INTERRUPT;
+            break;
         }
+
         vmx_update_tpr(cpu);
 
-        bql_unlock();
         if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
-            bql_lock();
-            return EXCP_HLT;
+            ret = EXCP_HLT;
+            break;
         }
 
-        cpu_exec_start(cpu);
-
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
-        cpu_exec_end(cpu);
-
         ret = hvf_handle_vmexit(cpu);
     } while (ret == 0);
 
+    cpu_exec_end(cpu);
+    bql_lock();
+
     return ret;
 }
 
-- 
2.53.0


