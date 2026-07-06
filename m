Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554A2C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfR-0007Cl-DZ; Mon, 06 Jul 2026 09:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjf2-0006xX-8n
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjf0-0006P2-Hq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax7xc245538
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +2Y6xs+e5q7Ac5D5TaolKIfbNfpiD9x7cxSRMpKjPIs=; b=Ty410otBa6acz1m1
 l2c03wjdBA4gABAT57kUldioYMCG9iZyLTkU3uQTIIErXfSmvPywavHGJgt3+4CC
 +iVfr3e2+ut+EnWaNx9tPtSEXDkXpfqZK0yPmZQtm3uVxv2uzDMQYL5w2werLKqq
 6A5fSAN3Nrk3+AXfkgcFCePs/K7/PE+RqrarctjaQCrs3i+aiFTuOZZVhF4bZsuB
 Tt2DzEcNfPtINfffzcIqPsoqBh7o39CICzJmgvUCtwIweyzptRBQ2km0DhXcIhH4
 BWU1l8FbnHOpJuHG/vat/LxR1gh/wRfPGcgARbknT//noBnRkmgJSSOtC+KzAHZW
 +UOzqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gu95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so223330785a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345616; x=1783950416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+2Y6xs+e5q7Ac5D5TaolKIfbNfpiD9x7cxSRMpKjPIs=;
 b=D/LJwI1wUhNh/8hAifbODi4OsCTzSks2NP/1F4zBCXkF/sLsGj/PbeGCAl0f+L8A0S
 Hho6jZdOgVNUyXpq0RVjib1uSiPCIIsXyCkiPOidLUOBKUj60CmZx973zBjQeK9L4/Fg
 RZW8LKfYpBR5rS0hM4hJNA1A3GMq3kws6BmR/Rag55givw9uyJo98UOkUsLYD7kzmigM
 GtfauxsHEuyKPwJED4qSc7hdCEy3n+buvS4ANG17htyh6jAPQzS7QpnkRbPA//WZuYeV
 F6pbgBalQ2Bt9STQQxLSOQhAabfjQoSqVZS1MyUeS0c3wMQMH/fl8RT+KDoI1FEdpTyo
 JJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345616; x=1783950416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+2Y6xs+e5q7Ac5D5TaolKIfbNfpiD9x7cxSRMpKjPIs=;
 b=Bj4NFDIw0/EGoiPVzeqYY1sUwfNPE4MUVz0AeB7gK3X6nYG1NCXS+JGECvRnMVfj0e
 l11OewecgzF6GOVkO+xss+m46//aYbabJLIsOP4507arcWzj9kYBQGCdVzWKpCxhvt4M
 YxgQnGdFXHN1w2ndEFvYCuWJdOSAYKT9lqhQW4hv6YCZz+E6VPMnOltKFZUNSbNMNKz1
 TPDxuwG6TZBxMsiDNs4sSJ1qddYxxbcFTV52Lgeg4Lc9YXwIXcUhBfbQuNLvadXYtkis
 iQgUZcnd3ZSJysyiOtRiJSi33MGtlml9TSlP7u6Q8Bei07/n6JtM5TSOiBEY0HoIfpO7
 sk0A==
X-Gm-Message-State: AOJu0YxVQyZo/5YfW35NlENBQiSXpYwqYQpTjqbuBthoLowYAy/3WsnG
 xrA+hNL6/7iRg99cxrJlZBHZZLn7Z9qK3k7SuI6p9Lq2ECVmJ6ScQ7HIzXCfi05byNZaXvH7kgd
 kotDZglw3EAAV04KixAEySgpgPXA1SH9NQGcYIXE2QcEcsu29ArT6uddzs2rUUI+q5w==
X-Gm-Gg: AfdE7ckTKyzBmPwvY2xNAxMiEh/rpWNbI455vhaCgBy1W+w81yJ/uJ7JM8Tps6Zxxoy
 v2257iVD/M9qVFhsNCUcXX5EqVMEyEfrvGpc+tCguZpj3SKhh0NZNbSKHdHagoh3DBlb548/yyC
 kdlllNURMH6JoARgVqK1mGGb/y4j93WebHrnH24wrT6eUHdQ7qYW8VZiCV8OSoPeB5rOzRT1xeT
 kBXKbHjCOdCdZ6JPARXDbZZCKljpzoU9lxxSAM3bWyaXRBw9hvsqKPHdWCdT4C9tUXNYlT2Z8RU
 NKhAHnF/SGnMc8SKsrqteEgZdq6rKveRK5EYdWHEf8aG6lOPKnPaSHiYP2U6XBziAuLsoBkUyJd
 jZx8i4HK3yesPBPf9LMie7DUI3tTxDak49vdB4JCnIECMpD4EGN//30sK9Q==
X-Received: by 2002:a05:620a:a80d:b0:92e:bbd0:3157 with SMTP id
 af79cd13be357-92ebbd033c7mr49210885a.66.1783345616024; 
 Mon, 06 Jul 2026 06:46:56 -0700 (PDT)
X-Received: by 2002:a05:620a:a80d:b0:92e:bbd0:3157 with SMTP id
 af79cd13be357-92ebbd033c7mr49206085a.66.1783345615400; 
 Mon, 06 Jul 2026 06:46:55 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm327560275e9.0.2026.07.06.06.46.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:46:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] accel/whpx: Implement missing
 AccelClass::gdbstub_supported_sstep_flags
Date: Mon,  6 Jul 2026 15:45:04 +0200
Message-ID: <20260706134527.84808-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bb1d1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=glojBnVPa3CR4aLdIrwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX82FSr788E5qU
 Ba0q/D/NOp+YWzmYx3H3nZyhQF/Yaa+0b0KCsH/CwMDDzxysFv0RnH5pZsHMj0J8aQ0gThfr6vd
 yqXXVHDmtoFwhH3D87KTGuJ6gn9eZ4iPD3nwWX/GzY4se4Z7T6EgdhGcUbHD/hWsfajjl4yKZWY
 ol98099oS6V0dNuOopIVEcHDsOOy6K5vM3oxVX478FLQtJx6jAXL7MYQYvTo5WC7jdJoqwxZnAU
 C+q/MkKkxzto5whva3mu4ch2VH6u9UjQ1NpQebXBv7AAdPd4dC9nHUvvFrL5lB4IDvOBKd6VJa3
 4NNzGLmGQP+8pLG6BiQ8aB2BcLL5/MbghGHTulK21SVx6NkWl15B3Ba9qBoD20m7pXmuQFfMxsb
 VsNtsYycqOHCGHR+bgFnrno0goknzk0LJDLIde9fTJm213aQ43UzTVKg5h6+MItIVCiieamkfu2
 wqfD4joAYzuLxL7wZCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXxOhWjn4jrfuw
 WperrJJ1fGfwtpS+w9II6asKGSyp+H3dR5JI/qowEAnT7wecpf09+FYo2sAqERZpH/KW1KAtrY4
 KH9DqPHiaeZqnzGcHFJMvmASBEhmiGY=
X-Proofpoint-GUID: E7KuPz5waCpKfioBXrjTwkNF1zvzz_8B
X-Proofpoint-ORIG-GUID: E7KuPz5waCpKfioBXrjTwkNF1zvzz_8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Correct gdbstub support requires some gdbstub_supported_sstep_flags.
Apparently missed in commit d7482ffe975 ("whpx: Added support for
breakpoints and stepping"), even with the recent 19b48084f71 ("whpx:
i386: re-enable guest debug support") fixes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-9-philmd@oss.qualcomm.com>
---
 include/system/whpx-all.h   | 1 +
 accel/whpx/whpx-common.c    | 1 +
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 4022571ffff..0e2d333e919 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -23,6 +23,7 @@ void whpx_arch_destroy_vcpu(CPUState *cpu);
 void whpx_arch_accel_class_init(ObjectClass *oc);
 
 /* called by whpx-accel-ops */
+int whpx_arch_gdbstub_sstep_flags(AccelState *as);
 bool whpx_arch_supports_guest_debug(void);
 
 #endif
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..e3f93efc61f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -527,6 +527,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = whpx_accel_init;
     ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
+    ac->gdbstub_supported_sstep_flags = whpx_arch_gdbstub_sstep_flags;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, whpx_set_kernel_irqchip,
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..5208d7e1dfe 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -295,6 +295,11 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
+int whpx_arch_gdbstub_sstep_flags(AccelState *as)
+{
+    return 0;
+}
+
 bool whpx_arch_supports_guest_debug(void) 
 {
     return false;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..f6e1636a4e0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1853,6 +1853,11 @@ void whpx_apply_breakpoints(
     }
 }
 
+int whpx_arch_gdbstub_sstep_flags(AccelState *as)
+{
+    return SSTEP_ENABLE;
+}
+
 bool whpx_arch_supports_guest_debug(void) 
 {
     return true;
-- 
2.53.0


