Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEB60A3802
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y517WP+G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YhabHD1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVRz-00089g-5y; Thu, 12 Nov 2026 09:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPh-0006Yd-E4
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPf-0007UI-Qy
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:29 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9E0mZ480138
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I6cWT7Mn8x4MAbwTg29BJU9C1XOGBuMHA9mfZuILgfc=; b=Y517WP+GD61Askpv
 K6SjRnJqxc93e5kJeiJgWSdH0E5hCC9twwLKNUCDMrpjRcYxo6DR+ukcFPeHOfZc
 S/yu1hlFyksZ28W1Ng15YRqfKOa7m/SjscMfmC5cf1kSWGj85ZS10QPy10InQG9S
 kGRJknOv/2FUuzTG+l5q3itojal+v22sXtjR9xrV/cl5+pC/AqnuwW4c6C8ubOA4
 KCdrwYAAP32+b1iDrS2/45OmqeT+jl1S7cojZJT3slQjXOW42ZIbgKJ5DS5Zk5w0
 9MLDA4XMMQuKwSblvOAxale5pDMal3eaa6jfhOUVnGDtWbI+HiBxH1f1s1Jb220+
 ZQB8cA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4ry9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:26 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ee0977403bso3557335e0c.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492266; x=1795097066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I6cWT7Mn8x4MAbwTg29BJU9C1XOGBuMHA9mfZuILgfc=;
 b=YhabHD1FRS4K61gsKrOTSkk1q2sp78nMsgF5QhW9BaNsqyGwzmekHduSCkKLDbEGHO
 m7TCJM34Uv/mTPLw3iw+EvQzJi83DJwDEeLcBtgYuWuMKRwkbutfo87cv41Zy9jn6mTW
 K4ZZ7LgNJUxLMCAXQsPk15T0WOE87UX3w1iUGMMGJC6hplUVnL2YhR8WfI8D4jZPZQPo
 2C1zpwxjJrtaE/qco20z2+ZUWq7tEPbXGvmWHrQ6GRREZwttqti34b6PEXhfMIamexdX
 fyf6szAKCgLDIS+78vG998xPIpNqgGvx1/3f2fQOmQoIh/VB39JZ2hRyNpV+ba/+EWGG
 F6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492266; x=1795097066;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I6cWT7Mn8x4MAbwTg29BJU9C1XOGBuMHA9mfZuILgfc=;
 b=iyK+oXXHST/niDSQp9zW9Tp9+V19WOjWi6f/Pqv5K7+cqlPKKqh14d2ENC/Ed+QLgN
 bFQx8d5rEuK/rKdia9Mu/yuNsibal/RkM0yiIxeL/nlA+FenJZisQNPC4cM/43d2nxdv
 sbMqIf2ci/YDohQxRKn39x3LufAMc2YfkoRYkfybecegjfxzVXgmD6pRtn6AcGi6XOBZ
 QNRtQ93LVk7PPFfHHNmM+09KSuwqEedTW3vDa5FPbtEzJ9i7bZhi6NKr2RZDkJMJs00f
 RB4GoJQg1Gdb5OoLSArcP5RX+DWIhsEd0u1V6tXanS3sN7Too9TAmAygyzJdtmMRo9cF
 XxoA==
X-Gm-Message-State: APuU4Z9QsP1lKRds1hJsBVVsri7zGHNeNiZDjDloVVESpCVEwmzQR/xE
 +1AeZlIALJshsYmWWPFKVqYzjCPDdsO460iwHArWvFCfaNPS0HynI7fd2iN1jn9DOqYi5pOXfRU
 8ytSMbpYftCwuYe8CiKllhNyBn5s53pOTW5WTLSn04wMT2+51TlaZ/HItVnsFXd6qCl6f
X-Gm-Gg: AYBFou11ltSAYrtsQwKsxJAwDvgcc96WlpFe+aab1kDpPjrwRCNlQ3iJZ/BUO0mTzQs
 40c0bl32RUwKPvCUurcUiN1naXsQNePAhrKjBt0r9XqkBs0K7tAxxbHuUtLn2Coe/WOoUf1iBaU
 WDdLGqwqRmnK2feh5lDcPVn008sxOTL9KEte+uutTJTiryF3/n4oms+fOS8b9WeAn5OYeAPHplT
 NczwIZ0iwtQ/micIl0cKx5ynpm9T1n4HdgzIZQCAMlQRL9CJUbmcrVjt7TRBCOYNgZrhyTKGisI
 7BCWaULGF9KuYyrV6kdQs6pbdYd22vV9v4ervK+bR69h3CDH0VVQJRl/jKDAc/HtuLE+8ZT7Yur
 T2z6KfjvNW8ikHT9nE9BIML8ZuAY9zVmI3hZAUcyL8oa6R73BCRSftm5Bv2XNFuGTf2uDFAvDLl
 0IkMV7LGak38jexA==
X-Received: by 2002:a05:6122:3410:b0:5ea:c3bc:c567 with SMTP id
 71dfb90a1353d-5ee1c424fd7mr2624283e0c.9.1794492265829; 
 Thu, 12 Nov 2026 06:04:25 -0800 (PST)
X-Received: by 2002:a05:6122:3410:b0:5ea:c3bc:c567 with SMTP id
 71dfb90a1353d-5ee1c424fd7mr2624206e0c.9.1794492265318; 
 Thu, 12 Nov 2026 06:04:25 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm19843995f8f.47.2026.11.12.06.04.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:04:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-12.0 5/8] linux-user: Honor runtime byte order in ABI
 accesses
Date: Thu, 12 Nov 2026 15:03:40 +0100
Message-ID: <20261112140343.61634-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ENum32MhF7fjX5UEQrYr0ocxMM3uPQqN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX0JKZXJzYA3yd
 FQOEW1X1UHaUMyJWQp7iFNF7FBKx0+dqVi5ugC3NqZuHIh6zaKI6kLxuDVbCfRHIzmGHcrBfE8Q
 3GUv8XI8vzHIskhugIqu7vC7//e8Bqk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX8Pd+adNZUHqy
 VISZsj8B0b8i1x3c47OJnTA3KGuhh2zCRaEQX+fGrf46orLYAFz4fm1/DQYZ2ova8+TtoA2G0fK
 8fEBVE+r9qFBzJsbkQwXehJ0XGAVEOX43QYcD2+A4PQ+ItL+s+DpMNVGR2Hou0HiONkOWeMScO5
 OFoxSL2ARyHNJ1d1Xjxib/UXaKL3dhhnlexPJjCgMOV/iBqwRkwCOXtA4FY6iUIrm9tOaejK9Ps
 fKPLNGb/yeEz5pBcQzz41g1i34koVRO9/nt7vUOOqo4hPGycNUCmBcoMwrgh3QnWadFFe5U1iey
 iqh8t7BtQN5SqyYxJOkJcMOBRXWIRfglKKTJznBXvEEWBRWSy4vVsG/Q4hOC0sfzGG3e2VaCfGr
 cm10X2td0ncCLtIbFh8D+xxSE746V5dlf2hDV8FAmoUavT2SrR/dMTgifqbQ/WMyd0jBugITRdj
 HM4QWvmgZkjVBIJwCMA==
X-Proofpoint-ORIG-GUID: ENum32MhF7fjX5UEQrYr0ocxMM3uPQqN
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5c76a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6Dl1BFdLVJxz0x0sNX0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


