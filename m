Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFF8C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUu-0000zC-3s; Thu, 16 Jul 2026 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUs-0000xm-EV
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUq-0001Yn-Pl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGTFkv3412698
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CunPOXKSfTC
 aWhaA7nZo0IlDNiZNdo3O1C5GCRZUKPE=; b=eiPSEhXXz+GqFvlIOsZQvYwG8M0
 7o0fZM2xKxCOBgm6SOCqWbeiaBEstIYdgudEHJ8ZGOAgMA9qHceoa9PywVhA45pk
 s+nwFrpUC44ubeZflPoXSnn+abdfgV1y/8x2DqZ+iKWWKTHLU5rtFd3VSq0s2mUD
 IHBtPzbc2LUEJkwo9kCZWTcpowPePVsEcS+K3Zqr1z+XnfIc1qLz5Y5FAQ7EBuI8
 wVMVCFjqoiwCsM7gVE4DPHd93xk6h8F6cygWzspLlFOMsHvPdCH3XjwuBUldCtpx
 Oyg77HZtwWfhJ0eJtX909taNaeAPRkaSpQepDczbGwTYmbxVzd7qB9xj1cg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10arjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so10600620a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225263; x=1784830063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CunPOXKSfTCaWhaA7nZo0IlDNiZNdo3O1C5GCRZUKPE=;
 b=MngY6BK1HgL7At9MhXJMSgJ26UPbkoGvVKDpdaiibzOqfUteTcTNo3Mwg5m3YE/D6u
 QjQggNVuzyVpyMdYG/V7rxMluF3xT7Ic733ApyIrSCF4YqSTNDmAquSC8cPb8WjznzP1
 XEZe0DpDKEymQZ+4bW0YB2McRzY6EgJ3FmlVyL3n+1Ks/iU4xdSDHVXZo42v0OL8IBA8
 /TXD/LvWHLWzSyFjxJnaJJn0ttOkYWWRzWPHTiNybwfKF9uJxn206qCV4p8hMhY6fNjJ
 gZMzAIn//9tUMgyssl8iA4TduhyeDGUWbNatnFH6ocaXfFDOAm11uVZ79fR86SqkACmQ
 E3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225263; x=1784830063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CunPOXKSfTCaWhaA7nZo0IlDNiZNdo3O1C5GCRZUKPE=;
 b=kh1vYl4puLoxIkmpNW9+Gk7zbuJCMsza2/hD/amdeqA0ja2grRaw31CAG/PwMjSFgN
 bVw9wdLBgp6WAahy1UiFmyv9XGGuBLHn/6KxIeDRyr6ujra/vFZufuBsPSi+oMl/D9uC
 DzUlso0m0nc2fhVQDdtb72sB3Ho/b//gaQYbSbkxF7oJKKOYBcix7rM5PsKHKiZYzS+9
 l2y37Je4JYWbYrchFrwPfsr6abbUJDH0p17q2GmRId8riZ4xy86G+wg/yt+Xpcnj5Si3
 VDNqk+GA6NbYuBMJDjgtoetC3xrxvN4J2+tPOxBGi2rL4cIJCbdCzkYyc12ronbmnFVD
 GihA==
X-Gm-Message-State: AOJu0Yx/Y81fRdoIroCOwGi/bSvBM1oLaqINnm4jA1VM9T9n431P+FX8
 jzx3zHvpIvoQCXU6eedV9nZKHlzwnPFsWR9jWoi4AfSy9mhg8wf14O6ULPUjzEkHx4AMIMn0607
 0xWI1j8u3JCnEfEQJWQTLMFXvREdn1vnMyjOJzazjH0sHt/rsyDkaz35lnQCDlqj/qQ==
X-Gm-Gg: AfdE7ckjfoQ9BNUh0AQxcRD5t3jfYVFcDnHyNCYvUzX651zJWSSWin9rFDBJnnLvFc7
 fp3w156gnh4AXQ9BMCX3uwuZfVODMDPoVUU1s7pWaspR+Nv6SjdIyxabG09Q4YK17mLZj1Upn+I
 vyXLtATCxvH0NuA/YDjOjMbJ7nQUMnUxse5s24oexSwTluCDrjrirxJd3GI5iwwUgmSf+APpcGS
 U1B/DRnAkN0UzGx6hFgwNDbJ4sYaHtimjvVujA+8SbX2oRRRV4SvDaRm3q9Aw/E7UOrjONXC/5W
 vi5OeyuZjcbjvfCA+LXRjzgF4wymdpJVJvIBIRFxDYwmRU/JbvrxCoZVOjabG0JR8WbrSylRsTM
 08vvYwR6m31j4NJNDSM2Vzc4RxK7/uiibWWtQaVwZ9/lfi/N9Kx1HzaGE4EQKEhQ=
X-Received: by 2002:a05:6300:68c9:20b0:3c3:8298:da0c with SMTP id
 adf61e73a8af0-3c382995afcmr4012104637.41.1784225262680; 
 Thu, 16 Jul 2026 11:07:42 -0700 (PDT)
X-Received: by 2002:a05:6300:68c9:20b0:3c3:8298:da0c with SMTP id
 adf61e73a8af0-3c382995afcmr4012070637.41.1784225262079; 
 Thu, 16 Jul 2026 11:07:42 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:41 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 12/14] target/hexagon: Add an errno mapping
Date: Thu, 16 Jul 2026 11:06:56 -0700
Message-Id: <24731ad7a276fd5873da7f0893d50655302ebeff.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: leRZScnTRrs0j-xNByPz2OTIAK98M0-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXyjUD7w7kJhDU
 pw8BWgYNufTb4Z5IUUjQ4AeAtLpIODrbSxc4SNnkW4zrWajdYM2a8t5rkyqH9I64ViI2cJ14wIm
 yWZgt9Li0FOUnCFXw2yHSlfCro2P7HQGHicSUv4BN2/v4Eo8RU7nWtWPR4b75dwiFkl5eT0MeTz
 vmRqnRojwQiYPD5ULVsxOFGHa+3j6Y/QAe6Up+xL91mnVOOXwN1SzuUbwZOgWvnRu/uJFdBmjBz
 vTygL4rH+97qnssihbH1K56wj1Rx3aj1zk2rPMhPUlvlPoD7s6HRluVFAkZiSrD1eshDz/I1iQL
 RLk4IzCR07nG+ZtlhUsYUBK+2NM/7Jx3ENkoSKQkElriCL04W8wxDGfZBRGwIR3LV6FekMmM3MR
 NQ4mbKVHz3Ska6wh7Oz59Jj1B0dAMwmS+RYeAeCYg+iGNePxw9y30m6h97ZNcbz/5ZoVq3b8Rzn
 tch6oIvIeSkmt8OvynQ==
X-Proofpoint-GUID: leRZScnTRrs0j-xNByPz2OTIAK98M0-X
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a591def cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=fCHUY30PoOJQLmHUSpQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX1568Jfa8D6US
 c7oexyCMEyioKb+y2ZHX1QqByWfWyRJAJZ4yRB/7MKZlNc3rNCf0bcRXAEXFLQFVAwelT2BB3o4
 tsHXsaFRmnAAIDOz9PSrb45J5MZ298U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The Hexagon semihosting ABI defines its own errno values
which may differ from the host's.  Translate host errno to
the Hexagon-specific values before returning results to the
guest so that baremetal programs see the expected error codes.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/hexswi.c | 75 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 564a11e557a..d93789e39c7 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -154,12 +154,63 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
     hexagon_peek_memory_range(env, addr, count, retaddr);
 }
 
+/* Hexagon semihosting errno values */
+#define HEX_EINVAL          22
+#define HEX_ERRNOS \
+    HEX_ERRNO(EPERM,        1) \
+    HEX_ERRNO(ENOENT,       2) \
+    HEX_ERRNO(EINTR,        4) \
+    HEX_ERRNO(EIO,          5) \
+    HEX_ERRNO(ENXIO,        6) \
+    HEX_ERRNO(EBADF,        9) \
+    HEX_ERRNO(EAGAIN,       11) \
+    HEX_ERRNO(ENOMEM,       12) \
+    HEX_ERRNO(EACCES,       13) \
+    HEX_ERRNO(EFAULT,       14) \
+    HEX_ERRNO(EBUSY,        16) \
+    HEX_ERRNO(EEXIST,       17) \
+    HEX_ERRNO(EXDEV,        18) \
+    HEX_ERRNO(ENODEV,       19) \
+    HEX_ERRNO(ENOTDIR,      20) \
+    HEX_ERRNO(EISDIR,       21) \
+    HEX_ERRNO(EINVAL,       HEX_EINVAL) \
+    HEX_ERRNO(ENFILE,       23) \
+    HEX_ERRNO(EMFILE,       24) \
+    HEX_ERRNO(ENOTTY,       25) \
+    HEX_ERRNO(ETXTBSY,      26) \
+    HEX_ERRNO(EFBIG,        27) \
+    HEX_ERRNO(ENOSPC,       28) \
+    HEX_ERRNO(ESPIPE,       29) \
+    HEX_ERRNO(EROFS,        30) \
+    HEX_ERRNO(EMLINK,       31) \
+    HEX_ERRNO(EPIPE,        32) \
+    HEX_ERRNO(ERANGE,       34) \
+    HEX_ERRNO(ENAMETOOLONG, 36) \
+    HEX_ERRNO(ENOSYS,       38) \
+    HEX_ERRNO(ELOOP,        40) \
+    HEX_ERRNO(EOVERFLOW,    75)
+
+/* Map host errno to hexagon semihosting errno */
+static void semi_cb(CPUState *cs, uint64_t ret, int err)
+{
+#define HEX_ERRNO(NAME, CODE) case NAME: err = CODE; break;
+    switch (err) {
+    case 0:
+        break;
+    HEX_ERRNOS
+    default:
+        err = HEX_EINVAL;
+        break;
+    }
+    common_semi_cb(cs, ret, err);
+}
+
 static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (err) {
         ret = -1;
     }
-    common_semi_cb(cs, ret, err);
+    semi_cb(cs, ret, err);
 }
 
 static void coredump(CPUHexagonState *env)
@@ -378,7 +429,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: filename too large (%d)\n",
                           __func__, length);
-            common_semi_cb(cs, -1, ENAMETOOLONG);
+            semi_cb(cs, -1, ENAMETOOLONG);
             break;
         }
 
@@ -395,7 +446,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: invalid OPEN mode: %u\n",
                           __func__, filemode);
-            common_semi_cb(cs, -1, EINVAL);
+            semi_cb(cs, -1, EINVAL);
             break;
         }
 
@@ -414,7 +465,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
                 ret = guestfd;
             }
         }
-        common_semi_cb(cs, ret, err);
+        semi_cb(cs, ret, err);
     }
     break;
 
@@ -433,7 +484,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
     {
         int fd;
         hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
-        common_semi_cb(cs, isatty(fd), 0);
+        semi_cb(cs, isatty(fd), 0);
     }
     break;
 
@@ -503,7 +554,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
                                  retaddr);
         }
-        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
+        semi_cb(cs, rc, rc == 0 ? 0 : err);
     }
     break;
 
@@ -513,7 +564,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         off_t size_limit;
         hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
         hexagon_read_memory(env, swi_info + 4, 8, &size_limit, retaddr);
-        semihost_sys_ftruncate(cs, common_semi_cb, fd, size_limit);
+        semihost_sys_ftruncate(cs, semi_cb, fd, size_limit);
     }
     break;
 
@@ -537,7 +588,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         hexagon_read_memory(env, swi_info + 4, 4, &BufferMode, retaddr);
 
         rc = access(filename, BufferMode);
-        common_semi_cb(cs, rc,  rc == 0 ? 0 : errno);
+        semi_cb(cs, rc,  rc == 0 ? 0 : errno);
     }
     break;
 
@@ -565,14 +616,14 @@ static void sim_handle_trap0(CPUHexagonState *env)
                 rc = BufferAddr;
             }
         }
-        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        semi_cb(cs, rc, rc != 0 ? 0 : err);
         break;
     }
 
     case HEX_SYS_EXEC:
     {
         qemu_log_mask(LOG_UNIMP, "SYS_EXEC is deprecated\n");
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
     }
     break;
 
@@ -611,7 +662,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
     case HEX_SYS_PROF_STATSRESET:
     case HEX_SYS_DUMP_PMU_STATS:
     case HEX_SYS_HEAPINFO:
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
         qemu_log_mask(LOG_UNIMP,
                       "SWI call %" PRIx32
                       " is unimplemented in QEMU\n",
@@ -622,7 +673,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "unknown swi request: 0x%" PRIx32 "\n",
                       (uint32_t)what_swi);
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
     }
 }
 
-- 
2.37.2


