Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CDAC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0l-0000CR-0Y; Mon, 20 Jul 2026 13:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzm-00089I-LQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzk-0002ze-5N
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6ooW3044465
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CunPOXKSfTC
 aWhaA7nZo0IlDNiZNdo3O1C5GCRZUKPE=; b=dBWVgafj3teb2xNfyddvcov/zfB
 2wSsmtI1uy0nzuZc09oC4w1Ahkl3xBdXYuZUkOqaqb/74x8eOwrB5Hy09antrpjW
 FMVGaQrLsvyyzVhND61svRxvgE6g+8ASJdehlqr2RX1tAeBnQSqEm+Eie2rmE0QE
 CpfcYm8d50u4nJiI3p7AVL9cx3z2TI4YHyuziW5dFh+MPq8iBFXVexTOmEV7PvqU
 20H4OSxCxQnCTyU3QtdPzcHvha4D0tJdAy76sKe//RmxammS45860j5UGL6tVPz4
 3mMgSUNNgkqno0IbXOv3/SNzjVNqYX8SsNnfAZeOHsGBR4UVE15r+TaYVng==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs028qy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85798977dcso12272882a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569283; x=1785174083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CunPOXKSfTCaWhaA7nZo0IlDNiZNdo3O1C5GCRZUKPE=;
 b=Mu0D8+hFgKNsTYHkaLOtN6SMRx6iH0urNYWdFO77WvLDzKg+ELARE5Xj1dWccw25hU
 F8mEBB/Fq96s0dIK2VtsXMJBeE+HWfhnINUw43jz/iIrYhb1ZBkI7Ub/SjwVaCD/g7gH
 6uXRSgZDYmIZDG+C+j/VB/fAlaRKSPUYtiaaHBZgn1IOmgxjYR8+n097o7pzcKvthpma
 lgaFNv1phMaHwwJNdHBKrGqn+7KR/EQ++lGCzVW2Iak64sRyceCMTFHcXHyAxJaw9L09
 MxX1mmE6UiKrQPbFwD4E5c0N9aM2r3mfnCZnpD76mLuOPdc5MM4iciltGtb/xLRuQrP9
 Isig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569283; x=1785174083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CunPOXKSfTCaWhaA7nZo0IlDNiZNdo3O1C5GCRZUKPE=;
 b=KZl3eUsMghsEzWpHEaZAriHBHsDyV6f3H5HU3IbHeLGKdVqnxj2haMs4PBWaPpZpb5
 jIY2ETxBHMfoQR++/GSHq5cmzsJbtLgvBv7OpAf1qwA56mQlrfLEi8JZi+7PBq7m475E
 cVgeVEo1NlA9QmT/AclpZwycuDPy73YgTXeI7Ft3B89GgTJzOR2v7YV9kL2yrH2NWdxu
 FssdR8/NZJETERlrOHNOAF/G4yfK6KBQsniRD1AXKbWwbi8PdgpdYECPWVn0QZ+SJvKZ
 xx4knX5+dMuUjvWKNq94oR9sgcBMF7wAN+aT/PFQkvgRb2d4k1LXJpow6AZB6Hsf6ero
 6aoQ==
X-Gm-Message-State: AOJu0YwGn4xySzZgl4zGV6qI598DpBSoyKMgfV5tI2IqPKfGRVDBRuIp
 l/Y1M3ckdl4BOf5lxSifgK9350IBMXWER6EyIUrtccO2Tw2+2CXER97upDBKJqTTnnyLN92zTgC
 6BNR68XrvaQgSJ03MROtJeVweOVLPbzYW3xbfK1wkRCBFsPU/tXrXBdv8IE4RMErDRw==
X-Gm-Gg: AfdE7cnCHeZfx83vvhwaQcFm+WMkgTtf0lw/mtK+ChJ00cfJOANeGcD4givwGvdEuX2
 UUf9PCDSgC0F+fMpKamk8dONdW5Ni+aqcnlgEQJwAZ0OQYsFdegJaCZgGgeAyVGBxRQQ0PioH7u
 d3f5TZOs2oONDs/HNu3mg+XMsKT4XiJdmZoE4nIenaLdpw0XZxOCukCb4GDey4G3Pnqvmh5KA+F
 xNVpi1CIFSYodlwbqN+bZfHL0/4WFs83QSOPshXu0COPUeZ/0fyxoXt88kmSIT8r5BCA99UyMjJ
 Cte7wHf72lPjYeC06WVSH/33TQj4HEUL+NRn+4YJNsgo2XIkRBZo8sY1gaEtQZ33+sjiv7jX+Xi
 7g+A2R+FkVDkE86savHIfilK4nJmTseTUaLbKAZI0/F+LNBP1O9lCKM/lFPi6kqU=
X-Received: by 2002:a05:6a21:7a45:b0:3bf:6fb1:ce0d with SMTP id
 adf61e73a8af0-3c3ad66b702mr18554813637.21.1784569282977; 
 Mon, 20 Jul 2026 10:41:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a45:b0:3bf:6fb1:ce0d with SMTP id
 adf61e73a8af0-3c3ad66b702mr18554763637.21.1784569282420; 
 Mon, 20 Jul 2026 10:41:22 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:22 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 11/13] target/hexagon: Add an errno mapping
Date: Mon, 20 Jul 2026 10:41:07 -0700
Message-Id: <bf030fc808d220374abfbd5714154f733ce9826f.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX1aKGLP7J7FoI
 7zqYf29JtAe+nyCPPiC4glyvnc3bQCyoSe5AQGeIiclsfObJhauvcTMFiWJubt0Ymgn6qDjCAH3
 9PYvqogmdr8vNdo6Cfvw6jhGmeQbzHs=
X-Proofpoint-ORIG-GUID: 6bPchdwGTZ5ki6zdjq_v4fh2jLRnZCSK
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e5dc3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=fCHUY30PoOJQLmHUSpQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 6bPchdwGTZ5ki6zdjq_v4fh2jLRnZCSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX9hyBqRh7lPr9
 aU7NKQEEjKpFDyGHTDPfGPEGvnVeGhb0BFINgKfOoBZEAXy9jyTphPPz/GmskZFDUc2MGBnFzYo
 yhkqA0PDeMesjqIZNhJtMp2zEWzkYS7TqvA+tBRW4eyfd3pdKQ+5jDPCncBUCtvqBCt1Fdte6Z8
 l/vDgQlBhc9NZX95kFxG8KTgMgMe768YXAC+xtEsG/c32nnb3JfxcS9aYdikXu+bcoJT6c1w3Z7
 MlJRE7iGps4nCE1rANI8KLbTk5JydongxX6dMYj7OVe2ekQof36pB5gp3T+bhNuhJqCvltHiNgC
 mYorLMSXZ2y5NfcC2aUHgoOozI86n+QDh9DZb2DTCxz17daKjGWUvOM/u7gAbooRnu39W80iQQl
 2MXxaYLpxYn9GFSTolS8o5ake3HbfTcvCFyHgi6ow0DgLd7MQgpB4BykNPSYLi5596QUy3J01RU
 I5PGb9fuIOdAxYX8Ehg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


