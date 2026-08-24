Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F536C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4b-0005Fj-EK; Mon, 24 Aug 2026 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4Y-0005EZ-8D
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4V-0001n6-18
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFncW33785230
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9VP2vzmVYnR
 6y2Yhag3ZqdM+ahnS/XbdmwVSsgRHoMY=; b=WX7MVh+DNftDLD9etPKo8z2SWsc
 txub7+7sCcCLeprO8zXGpb3J6YAz5/Dqi468b7PItov3z9YuXGgkceg63Zhm2DIr
 M+jyi4Oz7G68GqSx6bBYZ8r0p7NKRYvEMF9BdarCNQFpbnwW+fIXo6sZbf5dnTk5
 ADBQ/9ERIGP/8E2t2QgGwGsHThkeiFPH77wdjkbwGJqYH6djUNOcr1IQh9xNY+nK
 iG/TU/u/GUaq1YdC3PF0QYd6njnf2OKB+LykU/8VAqtkqGJuzzrHZ0K7YGIPc3Wn
 AMzwBvifcJAt0Pd0jik0oinrAMJatwMCDbkJoYLPIyKFv3CngoawWJYRZgw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgt4tx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so9019a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587119; x=1788191919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9VP2vzmVYnR6y2Yhag3ZqdM+ahnS/XbdmwVSsgRHoMY=;
 b=dunkNEMw48ke6bhHYnuLDXmW9TilKXYOos0gixC6XoFaGE5kLSWLvFd03XfL+VM5K6
 jXkG0t9qXkt+xjzyMsaJxO2fOuZ63h+arAr8ZY6lXo72nyVsW61w1TpRR1pVG7yKGCJS
 MT44PJaT88e3Vhc7ntrQeyejulArEMGMgxBsp9UHaC3m4uwIK1Q6lIiMvkf7o3MPU/bs
 7av8XlKGssiavcyfg1pYy+b9JMczSbIY8JqBoEOe93sXCU/m+1Jzvo4j1548FgnKrIWQ
 vvFgYohkGAzcjimRa0zoNCRmwudiINz9yXROz0klM61K/8+eIYecytY4DsUaMDeeukaN
 bPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587119; x=1788191919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9VP2vzmVYnR6y2Yhag3ZqdM+ahnS/XbdmwVSsgRHoMY=;
 b=B+yGGXnXgPe1LEADKYONrfc1OGBiSS4yZWzhaahcsNA2CR3igah+56s+8Xk8MD+nbS
 4OBKBfDBTaQ3g4cPDSZjs9dBj6y/lO5Gvt6PB+6q2yeEDlo1DLhN5ZPPJfmyvhmHe1wi
 aK2rGwetD5ayTsbLhjZ6DylcVs9g2y068b2AnS4Bw3eJ6uyRXGt6jclfeP0XbhOU0LOI
 HnMpb2d0gMei2LWl9D1K9VEIgeCSd7Bh9RTJ/1IBVwbCxIFIR0Df1l5fe+JoAoSZU84d
 I1d18es5NpYWNMq55OCj2fCf9/fgBCsBeQ4DQWEugLKEOH730She0GBDjjGf9m6RWwVx
 /owg==
X-Gm-Message-State: AFuF++lkR6iPFT1dUWSy75DxeFy5mStpR3JgLbPcNf2Z7bGO95bstnLZ
 uPBSIsRw+PiFz0k6sqCWbqM+NncnYHJFZtvOUj8AdGu5yQhIK2wjEW5dYyhYaXTNZrQhglZebie
 9xsHDueB+eu5ulwkRvlOcXieokvB4AVWQd+gIbfyAtiVsIc+jhFK+J9FdGyPAu7UOF7rH
X-Gm-Gg: AR+sD13z3uAsf0wobMW8sZKqSTtqaNHP0AzRek8qoHx6TrUw4z4Y7kgPPy+vwUBL9YR
 yJ3KKbonxsYsUcikLXbDkwPUTSbjRCMpfycjKziUs4iabaLhdV+QhfdFkWRvMUQSWF7Uiq+eH9J
 cuwH62NXkIK0Dt2/A/nrZ9nWZ1xqmWvjXyP3r0ZFVGoooD3cYwkzwsQ0o+aqL5UjEATx2EzZhW3
 M25CVS6AgKXCAX6TreUgQnMh67jwJpK+pu2w4rKyTLfzINECgzvuCYSvMwA9ADJsoiz2jDoQaf0
 UDm4V63h+SOCL0H54/sRw1OQ7o21CKpy0b/UIut2EpOIiTTrBLxAo3Q6un844fkfx2Tr4WnwTb/
 aA6i/BEvwLGeRaiVhYv9KzyQrqcRGun7Ay+Jgr2UEpjP+i2EkRWFCYHq81idsDyE=
X-Received: by 2002:a17:90b:5846:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-395c3718ee4mr53863897a91.8.1787587118783; 
 Mon, 24 Aug 2026 08:58:38 -0700 (PDT)
X-Received: by 2002:a17:90b:5846:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-395c3718ee4mr53863789a91.8.1787587118315; 
 Mon, 24 Aug 2026 08:58:38 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:37 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 12/14] target/hexagon: Add an errno mapping
Date: Mon, 24 Aug 2026 08:58:21 -0700
Message-Id: <71b686df7f3a63cf5812b3b05808b9c34e975f65.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX0TvSySUppiuR
 Y8B/mFtdy6Kph5HZ6Y5ZQtRmilnUYrJKtuq5gzqLCsILqcF2sUx9gDaLo5pnEAZocF93hsixNdB
 9o7UUSqanitV5WjoJZIoC6MKEP3YtgQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXxBsMG73fUfFB
 zjyiSm5PDGOqbgw+fkdZabrLVXPq7X/mljpPxxDT9z5zcFa+0qUrL1WkmUcsl+B3tVkZyjkHt05
 r6H3m6F3sBjjRYhoIBvm5qcDi76gZ8MbXntN7xGmCogocCGPCLkxJDZkCGTDuwKeNk0hoVWIneJ
 M9xkt5B8rmt0mdP4CQrpT4TizIl76LiTsXjX6h/cIN9Iy3RkCLXNnywD6EHPnohvssvQ+UP6nHT
 thG3F+Z1Ud7Dq5ZfckgAKTdEtgaEMeAumoA80D78puFbszFKPCybomSj5JfhgkocvDoZ0ZSxdxV
 eVRf8aRnlgOw68gJYw+PIWSIgwAwNrE6Uo1YfVKV20PzzF992pjVp3aUAbSHuayFmRL+CmT846I
 /zkN+3rqzMi5rDg67wjW/Th5NiWeJWMUpzX9Y8zn7hXmi43lzCkJG/i4R1oQhAU4SwW6DsaywXX
 XudvaEjLbIupJmm4VXw==
X-Proofpoint-ORIG-GUID: Filicwn2uhDT_U6TBx_4nwTb4zrJbBiQ
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c6a2f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=JV9Q9KcNIqeBpUAahVgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Filicwn2uhDT_U6TBx_4nwTb4zrJbBiQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
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
 target/hexagon/hexswi.c | 105 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 5e7f655a41..a50ab22554 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -154,12 +154,93 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
     hexagon_peek_memory_range(env, addr, count, retaddr);
 }
 
+/* Hexagon semihosting errno values */
+enum {
+    TARGET_EPERM        =  1,
+    TARGET_ENOENT       =  2,
+    TARGET_EINTR        =  4,
+    TARGET_EIO          =  5,
+    TARGET_ENXIO        =  6,
+    TARGET_EBADF        =  9,
+    TARGET_EAGAIN       = 11,
+    TARGET_ENOMEM       = 12,
+    TARGET_EACCES       = 13,
+    TARGET_EFAULT       = 14,
+    TARGET_EBUSY        = 16,
+    TARGET_EEXIST       = 17,
+    TARGET_EXDEV        = 18,
+    TARGET_ENODEV       = 19,
+    TARGET_ENOTDIR      = 20,
+    TARGET_EISDIR       = 21,
+    TARGET_EINVAL       = 22,
+    TARGET_ENFILE       = 23,
+    TARGET_EMFILE       = 24,
+    TARGET_ENOTTY       = 25,
+    TARGET_ETXTBSY      = 26,
+    TARGET_EFBIG        = 27,
+    TARGET_ENOSPC       = 28,
+    TARGET_ESPIPE       = 29,
+    TARGET_EROFS        = 30,
+    TARGET_EMLINK       = 31,
+    TARGET_EPIPE        = 32,
+    TARGET_ERANGE       = 34,
+    TARGET_ENAMETOOLONG = 36,
+    TARGET_ENOSYS       = 38,
+    TARGET_ELOOP        = 40,
+    TARGET_EOVERFLOW    = 75,
+};
+
+/* Map host errno to hexagon semihosting errno */
+static uint32_t errno_h2g(uint32_t err) {
+    switch (err) {
+    case 0:            return 0;
+    case EPERM:        return TARGET_EPERM;
+    case ENOENT:       return TARGET_ENOENT;
+    case EINTR:        return TARGET_EINTR;
+    case EIO:          return TARGET_EIO;
+    case ENXIO:        return TARGET_ENXIO;
+    case EBADF:        return TARGET_EBADF;
+    case EAGAIN:       return TARGET_EAGAIN;
+    case ENOMEM:       return TARGET_ENOMEM;
+    case EACCES:       return TARGET_EACCES;
+    case EFAULT:       return TARGET_EFAULT;
+    case EBUSY:        return TARGET_EBUSY;
+    case EEXIST:       return TARGET_EEXIST;
+    case EXDEV:        return TARGET_EXDEV;
+    case ENODEV:       return TARGET_ENODEV;
+    case ENOTDIR:      return TARGET_ENOTDIR;
+    case EISDIR:       return TARGET_EISDIR;
+    case EINVAL:       return TARGET_EINVAL;
+    case ENFILE:       return TARGET_ENFILE;
+    case EMFILE:       return TARGET_EMFILE;
+    case ENOTTY:       return TARGET_ENOTTY;
+    case ETXTBSY:      return TARGET_ETXTBSY;
+    case EFBIG:        return TARGET_EFBIG;
+    case ENOSPC:       return TARGET_ENOSPC;
+    case ESPIPE:       return TARGET_ESPIPE;
+    case EROFS:        return TARGET_EROFS;
+    case EMLINK:       return TARGET_EMLINK;
+    case EPIPE:        return TARGET_EPIPE;
+    case ERANGE:       return TARGET_ERANGE;
+    case ENAMETOOLONG: return TARGET_ENAMETOOLONG;
+    case ENOSYS:       return TARGET_ENOSYS;
+    case ELOOP:        return TARGET_ELOOP;
+    case EOVERFLOW:    return TARGET_EOVERFLOW;
+    }
+    return TARGET_EINVAL;
+}
+
+static void semi_cb(CPUState *cs, uint64_t ret, int err)
+{
+    common_semi_cb(cs, ret, errno_h2g(err));
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
@@ -371,7 +452,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: filename too large (%d)\n",
                           __func__, length);
-            common_semi_cb(cs, -1, ENAMETOOLONG);
+            semi_cb(cs, -1, ENAMETOOLONG);
             break;
         }
 
@@ -388,7 +469,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: invalid OPEN mode: %u\n",
                           __func__, filemode);
-            common_semi_cb(cs, -1, EINVAL);
+            semi_cb(cs, -1, EINVAL);
             break;
         }
 
@@ -407,7 +488,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
                 ret = guestfd;
             }
         }
-        common_semi_cb(cs, ret, err);
+        semi_cb(cs, ret, err);
     }
     break;
 
@@ -426,7 +507,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
     {
         int fd;
         hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
-        common_semi_cb(cs, isatty(fd), 0);
+        semi_cb(cs, isatty(fd), 0);
     }
     break;
 
@@ -490,7 +571,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
                                  retaddr);
         }
-        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
+        semi_cb(cs, rc, rc == 0 ? 0 : err);
     }
     break;
 
@@ -500,7 +581,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         off_t size_limit;
         hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
         hexagon_read_memory(env, swi_info + 4, 8, &size_limit, retaddr);
-        semihost_sys_ftruncate(cs, common_semi_cb, fd, size_limit);
+        semihost_sys_ftruncate(cs, semi_cb, fd, size_limit);
     }
     break;
 
@@ -524,7 +605,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         hexagon_read_memory(env, swi_info + 4, 4, &BufferMode, retaddr);
 
         rc = access(filename, BufferMode);
-        common_semi_cb(cs, rc,  rc == 0 ? 0 : errno);
+        semi_cb(cs, rc,  rc == 0 ? 0 : errno);
     }
     break;
 
@@ -552,14 +633,14 @@ static void sim_handle_trap0(CPUHexagonState *env)
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
 
@@ -596,7 +677,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
     case HEX_SYS_PROF_STATSRESET:
     case HEX_SYS_DUMP_PMU_STATS:
     case HEX_SYS_HEAPINFO:
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
         qemu_log_mask(LOG_UNIMP,
                       "SWI call %" PRIx32
                       " is unimplemented in QEMU\n",
@@ -607,7 +688,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         qemu_log_mask(LOG_UNIMP,
                       "unknown swi request: 0x%" PRIx32 "\n",
                       (uint32_t)what_swi);
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
     }
 }
 
-- 
2.37.2


