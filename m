Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A7606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mf+rVLgb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0W2hsQP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZEq-0000g4-Ci; Thu, 12 Nov 2026 13:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEo-0000f3-8z
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEm-0004Gy-Fv
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:30 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFaFF21112704
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F+yrVZEjze+e/2Of60uDFwn+N5jFGPC6Av8hbHxv1mg=; b=mf+rVLgbbTVExRuN
 UlA46+vCeplykbsJwBDLcLH94Bylng7Ka7mo1neUPLn2bd9oqyuLEQDh3XPo6woA
 mFuW0TiGfYYp7zouPlj3O+UuuwLBaNR3zNOfOaF7TC1pudyvrPIvnodgMBjNWUEP
 riSAGd7/n3M1UF6WTnYfMEJ+RAE8L9NRSHqTA2JJX5QeVp5lM7VKWY5urxErcah2
 UboZlnZHOFFeOVDHIRrryR5CuV0iM9MFS0zntznPpKSeQT451KHNSTp25OxgIneY
 97qOls6i1gWRgJcVjGJpja4QCLlcqnL5ZB0k1MrqHU3opbqkJ6T1ye0AwqRlAvAs
 zS4EuA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re2whn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:26 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d2c415bb8fso4236137.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506966; x=1795111766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+yrVZEjze+e/2Of60uDFwn+N5jFGPC6Av8hbHxv1mg=;
 b=M0W2hsQP79VESc2hbOT+LzWbn6nygTGsLxk1GdNYRwXFnlNLzV4erfsMgRHfEFCzB8
 3dqCN+iXAtQX13fVU02YfQJK21b90N9Wzt5ZOE+DEEbBZ2zL1j8TENp6pimV6CmgSevz
 nk+nZcjxroBnzINiWbw3v2YVSbvlxcn4F6807PR4aoUBrFBMlfMpBlEs2VrgXRML7nO/
 z2NGRHiMvkmVeXySbEmRiqyEhw100WCkcUu+pT6KvrwcDVG9Amk4MtndfkSXKrAPkRJb
 yxBvZLUFFq6lSTG9HqqrvESKrnmA8vCB4cSQPF4iyTTars8b/AbHXx/7JfrqxGGvXKM/
 mDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506966; x=1795111766;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+yrVZEjze+e/2Of60uDFwn+N5jFGPC6Av8hbHxv1mg=;
 b=H3g4K1LFPzzJ99CZ7bFFEgxiB3Evn7pMQP1b71NQVaI5FOzdihG2xv8A4zPkykxulm
 tsVp9WyAeoZe5iBrf5GymGPhMw85MzXYIhq82Xm9uLSamdwCcveOTWRzgK2CorqXt8gA
 3clMomQhXptUCLOcAomUK9nZb2ub4HH/IN+cRqvdoAVJumFIUMXn3EJOI37WWJOCahSw
 hTe6sX+ZmAuvpTEucWapzhQzgTDOzAp0OYg7xadOh6Q/kY8/Kuhq2oVFbb9ydtAW5Vwl
 etbmjWB5EjIe3X0Vv3aljj9s3KWRdWrP7udeY/TYvrDE9wm87vsYs0gw7J9PRUew7o3a
 x1+w==
X-Gm-Message-State: APuU4Z81tABDLfC7k42phkJij4xTSLxuJdbUOoGOxwv1c2e8G+QSzW1O
 iFLPiv2Zv01rmsU2sZZRxDn4ygINGUQV/CxkiT9dBHcwXQyEW5xUXA3iclpaiZ0O8/83DdupMGB
 AFbw8VL+QyPDc14C9yS/x22luqHmyWBgeQMehm6iAVMxuJn5oQ2dCBzY2SZ61JHDINER6
X-Gm-Gg: AYBFou14y8NZargrudQdg4+TZVzQ49SIsEceA8ywR2tHCZ/Ik9ptINT8bVDPHqrM0HQ
 FzdbX1mM7g2ZU3b/iXrgav3bcachNLyhFRzZHj42dy/BhBZJti5unYvvDqkMN4o/o5j8caQFs+X
 9JnBsXKuMogI1JrcHWGBWYodStLreQdZtt1IsLnxqOOF9R87w95fgVarWyrpUA5fzouCMoARg0i
 wvYWjM3P4Rok9eJYUbDAIm7Na/EUfC2+7wgUppEO3JsDZKrDKRK/jMh5IsMnToEsoPI4JvxPg23
 LRwOMLfgNBb9bzMDmPxklStBQWteZvcjYDmgpnqW8FizuYnItrwZ9B82NiWbxnZbtvK33TFZH4k
 Jc3QyQAo66eWaD00eDA1d7cz8oXQqzBffZBxStiD0sAeU90G+Hrum48RDbCVIuPLyw/RFQsvRj0
 WjCJ04fv30fbCRVQ==
X-Received: by 2002:a05:6102:418e:b0:7c1:6de4:9f67 with SMTP id
 ada2fe7eead31-7d64d4292f3mr30948137.2.1794506965813; 
 Thu, 12 Nov 2026 10:09:25 -0800 (PST)
X-Received: by 2002:a05:6102:418e:b0:7c1:6de4:9f67 with SMTP id
 ada2fe7eead31-7d64d4292f3mr30911137.2.1794506965024; 
 Thu, 12 Nov 2026 10:09:25 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e57504sm121226465e9.2.2026.11.12.10.09.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 03/12] linux-user/aarch64: Move ELF/vDSO endian
 checks to runtime
Date: Thu, 12 Nov 2026 19:08:49 +0100
Message-ID: <20261112180859.85380-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R3NsklDZpgvzJ561xQr1QyzWYd29LhqJ
X-Proofpoint-GUID: R3NsklDZpgvzJ561xQr1QyzWYd29LhqJ
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af600d7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gRHuWOP3dPFJNPu9TmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX8hCWQcd3ITnU
 1erLcXLInDN+lAuKFp9C4WqkCAGrG8xzEd/7l2QGFzS+hc5Ok9zo8GprjLIDWZivgGhfYsmjLST
 WFXhlXRH7wHSF5bs09YyHJnozKMsWss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfXz5bcO4ZD1zh2
 GYs/9NeW3/OxoPMLnWMzWz//UIHcwEv/4HU9alZcUdV0qDPSxoH5DZyZLdPVQ5J4ejTtsDF43bF
 dwCKn3L8grdjCNSXCHGGXuE75EBt1nz7kJ2f0jxdTPq/mAplEgyQMYteYYQRw+erVSDyfY+Xy5/
 7EcjEOKvDQWOQ3N/ZiK6EBl4XH6COExv05z2UOBoWjPlwFSpXk/dotaenaBiqqiIFZJQUN7VeEu
 gIyD8/1msLl9l7hSsIguX8/mymNkUclshio4n9jTLBzcdva9lgrXfkSX/hQUcxrb3JdYPf+lUN1
 lQ1hGD+jwkP/JYCcsKY0cqU7b+croC0Pt9duvv2k2b4hysACkFE803YpG8MIWkPQe8Tu6URq016
 d7751GaMLwDLRXSoH2+7htJ8WdVUoU3jmWnSDU5Q8gfS9ZwAHde8+jNYIrRqaKVdjshJMqLy44i
 YErDlqVDIdpEKeR3Uvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120072
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use target_big_endian() for the platform name, uname machine,
/proc/cpuinfo suffix and vDSO selection. Give the generated
vDSOs distinct symbols so both can be included.

Preserve the behavior of the existing fixed-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/aarch64/target_elf.h     |  6 +-----
 linux-user/aarch64/target_syscall.h |  6 +-----
 linux-user/arm/target_proc.h        |  2 +-
 linux-user/aarch64/elfload.c        | 10 +++++++++-
 linux-user/aarch64/meson.build      | 10 ++++------
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 4cdeb64b0d4e..ebd23cfbceda 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -27,10 +27,6 @@ typedef struct target_elf_gregset_t {
     struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
-#if TARGET_BIG_ENDIAN
-# define VDSO_HEADER            "vdso-be.c.inc"
-#else
-# define VDSO_HEADER            "vdso-le.c.inc"
-#endif
+#define HAVE_VDSO_IMAGE_INFO    1
 
 #endif
diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index bd05f6c7fe5d..f3c570a5b2eb 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -1,11 +1,7 @@
 #ifndef AARCH64_TARGET_SYSCALL_H
 #define AARCH64_TARGET_SYSCALL_H
 
-#if TARGET_BIG_ENDIAN
-#define UNAME_MACHINE "aarch64_be"
-#else
-#define UNAME_MACHINE "aarch64"
-#endif
+#define UNAME_MACHINE (target_big_endian() ? "aarch64_be" : "aarch64")
 #define UNAME_MINIMUM_RELEASE "3.8.0"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MCL_CURRENT 1
diff --git a/linux-user/arm/target_proc.h b/linux-user/arm/target_proc.h
index 13c33d44d5ed..d3186ca655cf 100644
--- a/linux-user/arm/target_proc.h
+++ b/linux-user/arm/target_proc.h
@@ -25,7 +25,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 #endif
 
     arch = 8;
-    elf_name = "v8" END_SUFFIX;
+    elf_name = target_big_endian() ? "v8b" : "v8l";
     midr_rev = FIELD_EX32(midr, MIDR_EL1, REVISION);
     midr_part = FIELD_EX32(midr, MIDR_EL1, PARTNUM);
     midr_var = FIELD_EX32(midr, MIDR_EL1, VARIANT);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index f87f22f6903a..8e75da826e62 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -379,7 +379,15 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 const char *get_elf_platform(CPUState *cs)
 {
-    return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
+    return target_big_endian() ? "aarch64_be" : "aarch64";
+}
+
+#include "vdso-be.c.inc"
+#include "vdso-le.c.inc"
+
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
+    return target_big_endian() ? &vdso_be_image_info : &vdso_le_image_info;
 }
 
 bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
index f25a67a21ef6..a5f9a47a9a27 100644
--- a/linux-user/aarch64/meson.build
+++ b/linux-user/aarch64/meson.build
@@ -1,12 +1,10 @@
-# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
-# is always true as far as source_set.apply() is concerned.  Always build
-# both header files and include the right one via #if.
-
 vdso_be_inc = gen_vdso.process('vdso-be.so',
-                               extra_args: ['-r', '__kernel_rt_sigreturn'])
+                               extra_args: ['-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_be'])
 
 vdso_le_inc = gen_vdso.process('vdso-le.so',
-                               extra_args: ['-r', '__kernel_rt_sigreturn'])
+                               extra_args: ['-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_le'])
 
 linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
 
-- 
2.55.0


