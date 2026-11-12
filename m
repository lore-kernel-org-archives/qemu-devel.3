Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442F606A8B8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AHxc01W8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HXn1BXwD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZGA-0001bH-SO; Thu, 12 Nov 2026 13:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFb-0001KL-Iv
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:10:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFY-0007GX-NB
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:10:19 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZV5F1736588
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I6cWT7Mn8x4MAbwTg29BJU9C1XOGBuMHA9mfZuILgfc=; b=AHxc01W8Ok3ySguu
 fIpuLJOkSybnrfs/NEkR1pShLZNPISN1oo/xSZPQjjQBNK52V2qY+iU9nn0NVx1U
 4gFMqAKxTWTn0AX/LPnrEunwMAdBT6sVhFpsP4TLyljFHE3uTw9ytaiSlw4YJo13
 1k/DKiPd805GG0POCTiCs+p+b6SG+/Z5OVsxwv8XfKhXeFV9m7S3IqSYJzXcNSb6
 XdfQPWLuOn3krM7MnGlw2FR2Y4ob33N95pJ3nkVO4KHiUpfMudWp6yAIl4B0ec3v
 09JEzZmkwrYYz7W0OebaaKanIIA1rhLm4pygR4y57BYuU7sxmbuQLaGUSAF8acWF
 445dZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc2s3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:10:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-536778a8137so87645761cf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794507004; x=1795111804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I6cWT7Mn8x4MAbwTg29BJU9C1XOGBuMHA9mfZuILgfc=;
 b=HXn1BXwDMoc0qx8VLJYZPAl3WyzBdLTm5LaDhfR/axK3S8dnIWrTsWwhUzJNSBqxtD
 F7f/rKBCsbpNyVX5IUuLV76/UT3IH54jqY88EEzHBGpjVfXWegFSubcwJH+oCPs3YFAe
 hdqMo+AefKVFcg56cT19vZUVahMTLeIjujOezOCOf3rbNgKCFcY1G/dV3EnGVruV0rsp
 XORx6vSgp8STtzIiSPAc8BLjwiqzP9whjt4uBNdyQ1pGrIE5wSaZKyjGURiJ8vYRqF82
 4vEQsHFjbPqiKiGZTfMmd8/eZaqaV+ulMrE26O37unIePe6WSb4IRaK2ToPJCy53ld0U
 cfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794507004; x=1795111804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I6cWT7Mn8x4MAbwTg29BJU9C1XOGBuMHA9mfZuILgfc=;
 b=sh26GogU+VNGin8gLJcfICX0Kwr46gbIfQ53ckrWcF+1SEbVEKjKCigc6cwQy809v3
 baUyuHmvlVf9JaWccoFhhnCqp0equTCLgKEOLRrY9lchWxaSf+9N6RWwNLe+Qcc6o9F2
 J8cLmVOOn60LC3G4OhM2z0rDAR9nDZCeBdvPrNTY014KXajl1ogADCG4zOFXcxxppjkP
 ZrqUcDXJVR1HWEMKaqfOIbAdB5gXCvqqSQ0DeZZX7Dkw0vfxHqV+64cQYz25XEAEjVBT
 RVh9yeRHZn20K4C/nwSeVnwLVOzdZ0ZDyncwGnu4D5t4ANvTH7vjKK33vLwt8HgSTgXP
 qw6A==
X-Gm-Message-State: APuU4Z+mKQvQ5RzRF2LY0t0lNkWKLl94KVAVeRj6o8rUgdX5yEGkjCch
 1sVA1rb24Ygx1mdNivYyewQtpiW5APwshvzyRrkgKepe/UFJpHxzpC8zKYqU3qlhovh4q5lx+18
 WAJfnQsyE3DrWIclz2Xejz3ZvtwWLdaoF+MXs7/0XSBljH0cxyT8fNrcObBvVJfgHta0f
X-Gm-Gg: AYBFou2BumxcuuEdYEa0yE89BJaKLcikagwRgLegk6Wf32QsPKhxghvsl+Kw+fH5CgI
 z/es9ewzwYcNJPxGvKZ8yGPr31Ax2rGzIOW/ZmsTruw9kOw9sptYETe914OKO2zlZq5QEi6ZQSb
 /1yMoQZy9p4DB8aGhYrhqeSwBsn5jpA7IcwhjqLNWituC4QF53AeBYTMrrTuwv0mmMvZ4CvbCYn
 j0Rb5MPLyR+UUgrOGSkXTGmqpSmmOeKKPPe+SHnlVeBZM01gDdkNRnFe+JR9PxuDo0Ki9IohMyX
 NE8Hx67UI87giRWn0Ig68u0QVvNJQi8On7xtNwwp5+JVD1fyO+ujUKTL/uRlpRFckDGk0z7gIUR
 FDq8BF/g9hlPic8qZBjsAlc6WSbq/dHEzIUwdFek9WiaOsv+7oE/XGGCWoVzpNwVUWnpm51RmIC
 BJJ6vENrvQKBrqIw==
X-Received: by 2002:a05:622a:58c:b0:535:a5fb:6459 with SMTP id
 d75a77b69052e-55ac8e98474mr3058161cf.68.1794507004089; 
 Thu, 12 Nov 2026 10:10:04 -0800 (PST)
X-Received: by 2002:a05:622a:58c:b0:535:a5fb:6459 with SMTP id
 d75a77b69052e-55ac8e98474mr3057421cf.68.1794507003586; 
 Thu, 12 Nov 2026 10:10:03 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm577991f8f.45.2026.11.12.10.10.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:10:02 -0800 (PST)
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
Subject: [PATCH-for-12.0 v2 08/12] linux-user: Honor runtime byte order in ABI
 accesses
Date: Thu, 12 Nov 2026 19:08:54 +0100
Message-ID: <20261112180859.85380-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x7oBfp00eBniw5ob2uarvJJ5XcPPiZYV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX+MG9+gkEXS/L
 OreH+xO965MHDIVwJlEtNIQ5lTDrf0dFoJgLFCT1SNWTz2Ghuo7LYgAxasWAjcvcu6r56HjAJlz
 8lCeemg14soFvv4T3EYhlYI3Ua9ey+I=
X-Proofpoint-GUID: x7oBfp00eBniw5ob2uarvJJ5XcPPiZYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX/Xdg5oU2d/f2
 VE49K5NpLk5M6jds8PQXmBMuU1lWoKTxMqT4/mLj4DAPZGOLtdABbjx2cMH6GKaW+eJqiEslONc
 dU2vcGUXQ6Q2Dh3fU5E9Wnn/8ExpVQBwgpnlHPKf8D+PmuSHHC75OrFNopuiP/NKjB7ZFozBYQZ
 rPk26On7Lc4fIpXXsRROfJm0kloQ7iSWcJGlMkJkAfjN6W3Q5cHS6lNc5FmH3kx8FIvDcvh+mi0
 HVBgVyKtnPMfeAmWk0L7B1eNaiodZoKNyCrXuiDGi1BarcfIAvQ967wHZgh9dJ629Wji4x/XL5k
 0ptHDTTZTpfyPSrZUPlcTLdV2YeKFukidA/mokIkcfSQ6AGmy8FTAL8znmR1NolhlBlUGtaEqcU
 JINXJorkfEfeLh5DrI7cLTzohNSwF69Rr3MwUTsJdXOumzidbGW6xpaC/cWqkz8kdwKAhkB4Oxw
 OsVrVJdt+gZcK6DwqPA==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af600fd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6Dl1BFdLVJxz0x0sNX0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
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

Use the selected ABI byte order for ELF validation and core headers,
user-memory accesses, signal masks and /proc/net/route conversion.

Retain the fixed-endian paths for targets without runtime selection.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/qemu.h         | 17 ++++++++++++++++-
 linux-user/syscall_defs.h |  7 -------
 linux-user/elfload.c      |  6 +-----
 linux-user/syscall.c      |  6 +++---
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef7aed2daec6..53567a6c0363 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -254,7 +254,22 @@ static inline bool access_ok(CPUState *cpu, int type,
     } while (0)
 
 
-#if TARGET_BIG_ENDIAN
+#ifdef TARGET_RUNTIME_ENDIAN
+# define __put_user(x, hptr) do { \
+    if (target_big_endian()) { \
+        __put_user_e(x, hptr, be); \
+    } else { \
+        __put_user_e(x, hptr, le); \
+    } \
+} while (0)
+# define __get_user(x, hptr) do { \
+    if (target_big_endian()) { \
+        __get_user_e(x, hptr, be); \
+    } else { \
+        __get_user_e(x, hptr, le); \
+    } \
+} while (0)
+#elif TARGET_BIG_ENDIAN
 # define __put_user(x, hptr)  __put_user_e(x, hptr, be)
 # define __get_user(x, hptr)  __get_user_e(x, hptr, be)
 #else
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f5831a6baddc..c9a1853c9e90 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -462,19 +462,12 @@ typedef struct {
     abi_ulong sig[TARGET_NSIG_WORDS];
 } target_sigset_t;
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static inline void tswap_sigset(target_sigset_t *d, const target_sigset_t *s)
 {
     int i;
     for(i = 0;i < TARGET_NSIG_WORDS; i++)
         d->sig[i] = tswapal(s->sig[i]);
 }
-#else
-static inline void tswap_sigset(target_sigset_t *d, const target_sigset_t *s)
-{
-    *d = *s;
-}
-#endif
 
 static inline void target_siginitset(target_sigset_t *d, abi_ulong set)
 {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c188fa03c31f..c76afb77bbdc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -102,11 +102,7 @@ int info_is_fdpic(struct image_info *info)
     return info->personality == PER_LINUX_FDPIC;
 }
 
-#if TARGET_BIG_ENDIAN
-#define ELF_DATA        ELFDATA2MSB
-#else
-#define ELF_DATA        ELFDATA2LSB
-#endif
+#define ELF_DATA (target_big_endian() ? ELFDATA2MSB : ELFDATA2LSB)
 
 #ifdef USE_UID16
 typedef abi_ushort      target_uid_t;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2fc61b3eabcc..9dec129e1d4f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8778,7 +8778,7 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code)
 
 #include "target_proc.h"
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN || \
+#if defined(TARGET_RUNTIME_ENDIAN) || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN || \
     defined(HAVE_ARCH_PROC_CPUINFO) || \
     defined(HAVE_ARCH_PROC_HARDWARE)
 static int is_proc(const char *filename, const char *entry)
@@ -8787,7 +8787,7 @@ static int is_proc(const char *filename, const char *entry)
 }
 #endif
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+#if defined(TARGET_RUNTIME_ENDIAN) || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static int open_net_route(CPUArchState *cpu_env, int fd)
 {
     FILE *fp;
@@ -8850,7 +8850,7 @@ static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
         { "stat", open_self_stat, is_proc_myself },
         { "auxv", open_self_auxv, is_proc_myself },
         { "cmdline", open_self_cmdline, is_proc_myself },
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+#if defined(TARGET_RUNTIME_ENDIAN) || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
         { "/proc/net/route", open_net_route, is_proc },
 #endif
 #if defined(HAVE_ARCH_PROC_CPUINFO)
-- 
2.55.0


