Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B54C5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wua1L-0004u3-F0; Thu, 13 Aug 2026 14:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0z-0003Xw-NQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0w-0002Hl-KG
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DH8ecQ304580
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WkLF8awV/bRgmolBst9AuOseYgP5YAXlCZ5MmoxHNDQ=; b=QNc26D0gQLRHqQAn
 38oRtw3lbi0D02btV1plIuqbbRNmhBEOMsT+vr+5lD6EE/OS1nqiGg3v6XG2AZcq
 oy0RxoqrFL25TP1TpD28jw8KqWQ/bN6EiriQ64EZUOl1LXrpXd+pW+9Yugnb1T58
 JNOqxjWP4U5KiBQaYu1sqy1bu/Enl0u9PSz42o0D96OPMzdt0rxNf8ovRGqDZWnB
 hDOEbMDekOGhHdIVUa/jWqa1zFc4VYWnC0TJ9zZkP6LdcOYFGH3IMuGa/O7i6R9y
 ZG4dIIbP/aDlBOyTs6544uyh4SVGI1dwDckJNR3LsgnJN4Y8uAUvwuDDORNyU2wX
 K/fCDA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2nga0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf321d786so3554191cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645113; x=1787249913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WkLF8awV/bRgmolBst9AuOseYgP5YAXlCZ5MmoxHNDQ=;
 b=O2WMWt2kMSDQ4ZCjsxAqv/iGkigmHrGiooxYIAgLDgr6aeQfXF1CpUGKQ3IIm4qb7n
 9s38mzAVhlXKwi4/u8XasoRZV2s5TOCzVSyupDAUjGLrSRthSBqrrD4u4PEYWq4uOuJs
 eVj97V1LGBZgf13G7tEO0Ax/58RZKxV4+63+r8JAhD5WpwJNC4GyT+EwPWJBS/I1yeL4
 DC+k04jntuLARI+JTABEMyLERNUuWxbVp3VwBaVzM8l/swM7h9k8Yx7j6ZTtMwgsREKh
 8YWNU2j3uX3jtfjTY7WcXNc7vCh17nbfz8kKVt74iC62xj889f5tKk44WApgRGDAzu8A
 6v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645113; x=1787249913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkLF8awV/bRgmolBst9AuOseYgP5YAXlCZ5MmoxHNDQ=;
 b=TZeO4+Yfyu9FE68Q6usEcfDRn3ki7fNo+pEMdx8vyO0j9Wh6KRYutwIoG2bEcec/bq
 1P6iMaFjQJ9bEur3AXtxJKS9RbT9PliYky4BBPMSHnXzN2UT8w+eIKyir0GrMcjubYtR
 ZEJCcKEtLVVmjx4EC7wdfejXTEkmo2YmH3AA/DxY2rrtPnHoWYXq6CalQjbFPogsudCN
 uFhyqn2ZWojzG/EMc+p5jgs/QTE2Q72wkJuMAEShVMMP8B1BOx6qBj4Ia16hviamFUmH
 N1ILYikObg4lweHcjUly80y91t+1pmgTbd7MVTw4UDapP1g1OAXPxZXXDIBrTrP9kHGj
 NKGQ==
X-Gm-Message-State: AOJu0YzF3XqORjdh9eZdDbMV4YHIldrYVtgrJfUPilLXbFqh03I+94Hr
 cj4Ps1JeWwYoiGI+8JvIW70BkQ4oEzICWaP6CPJZeQJHBaG118XlIn1Q43eqRt+OqCUoCSOtjiZ
 gUlxmfYxtt3Z4Mk/GQ2pP0FOKfjgGW89PIwIYJeZlTo9wFcF8ApxBANw3ZXgfEhy2EA==
X-Gm-Gg: AR+sD10+SlTByJ+rcQhx2SA4LV2QYUnDxhoDpLbp6hYCww5Khh1ZcJa/rIrSMizN+9o
 GngIKBB+nXtkRRfOAaw93GZQB2nuc7RQt6cRJgViNqN8YG8YyotTWZ+6OWXG0HTP1LYM6Tmr1z4
 CIJ9JIgs+a7TJXDL7SWVsDqSkWuDg/Lzboihh7hs2rIg7kPvb1urqZOJXLjKULQD/exy5tEfwhZ
 j1mYLaNBtDRPZSod1KSnhwcd0vX11e2JOK5Z9IS5JPa7qRj8dYBIiPtcAD+hNSzy74/AYs/Y9BX
 zApfWIA9m73At18jiJYx+s/eH74aJXGimUmJ372Daj6AhruUSYq4qfttwD1xkLngeaTyGEBTQCN
 ob/mnIi9gaCdVsgBsMlIbxi3I/CS3yiy52HtCmliP1w==
X-Received: by 2002:a05:622a:1355:b0:51c:f3e:7819 with SMTP id
 d75a77b69052e-52d73df4d17mr78564541cf.39.1786645113606; 
 Thu, 13 Aug 2026 11:18:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1355:b0:51c:f3e:7819 with SMTP id
 d75a77b69052e-52d73df4d17mr78563731cf.39.1786645112979; 
 Thu, 13 Aug 2026 11:18:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21a068sm1190899f8f.12.2026.08.13.11.18.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:18:32 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 15/16] target/arm/powerctl: Move BQL assertions to async work
 context
Date: Thu, 13 Aug 2026 20:16:38 +0200
Message-ID: <20260813181640.6537-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ApXeGu9P c=1 sm=1 tr=0 ts=6a7e0a7a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LLcwgxkfhdatqMbCiJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 1XB5_dZ8Ro0lBqNWlgtLmVbDEaifka07
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9SVfQYltvifK
 zoNMb1b4GP+YU1QvNfT+bF5pFk3RILYeG3KopGlT46msDPE1S6FRUnx+RXLG9DjUi5j9IQGyW56
 AOzwgaqxqKSSWgPb0iiREiBfqs4lAxI=
X-Proofpoint-GUID: 1XB5_dZ8Ro0lBqNWlgtLmVbDEaifka07
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX8rULpzp02/3H
 dVsQi1s67kedzFlaBPeW6bb5aGZOMr9AqXYPc4vNS3i1mYh0n9IJp3hX6JnSVQdhuF4UC9CkJm0
 6wfAw1NxJM23kBzMglh9/VhEQkoXGScdok89SM8/L2sJuTwtahXxq0p3uzczUiOKSxtrl/29KJU
 S6bwv4f/Io7lR3lmkpdKiN4yZDHeXSKJlDfd0TaJChQpwZdrJrsdQvl/4Z+S/Ml3v5vlsRB5gH2
 pcPgg4+spBi0TBpt0hzMpNT8979V+CzYAHUDuwC+lpJdLDgi+m7yx987H3JrbvhW9PhXGKLzKcV
 oRzx0T/rNy/RMcXdFnWwnPr2RfeCTc8DS744mxrvWczzQRUV5Janfq0LVyJ9824LB9b6Jv6S3Cv
 VMuGb2v7A7U0KfCO4E8BuLu1GYVyVcTTftYIBkK0WP28/Xbs3hnD26sxGBW+kq3LbH9HCLsoCrK
 1PTWsG/WH3MglmJjWXA==
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

We can not guarantees the callers of the following public API
functions hold the BQL:

 - arm_set_cpu_on()
 - arm_set_cpu_on_and_reset()
 - arm_set_cpu_off()

Move the assertion to arm_reset_cpu_async_work() where the async
context guarantees the BQL is held.

Fixes: 062ba099e01 ("target-arm/powerctl: defer cpu reset work to CPU context")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/arm-powerctl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index a06be5cc997..a938b30943c 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -88,8 +88,6 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     ARMCPU *target_cpu;
     struct CpuOnInfo *info;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_on(cpuid, target_el,
                                   target_aa64 ? "aarch64" : "aarch32",
                                   entry, context_id);
@@ -194,8 +192,6 @@ int arm_set_cpu_on_and_reset(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_on_and_reset(cpuid);
 
     /* Retrieve the cpu we are powering up */
@@ -249,8 +245,6 @@ int arm_set_cpu_off(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_off(cpuid);
 
     /* change to the cpu we are powering up */
@@ -276,6 +270,7 @@ int arm_set_cpu_off(uint64_t cpuid)
 static void arm_reset_cpu_async_work(CPUState *target_cpu_state,
                                      run_on_cpu_data data)
 {
+    assert(bql_locked());
     /* Reset the cpu */
     cpu_reset(target_cpu_state);
 }
@@ -285,8 +280,6 @@ int arm_reset_cpu(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_off(cpuid);
 
     /* change to the cpu we are resetting */
-- 
2.53.0


