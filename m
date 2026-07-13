Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B209C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwS-0005kg-ME; Mon, 13 Jul 2026 16:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwR-0005jx-AV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwP-0006Rx-Aq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9Ygr2356009
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jYCiiKcRpdQ
 H20AltIjtrmRVswxBEeBTUec3foZP/I8=; b=RL4aUFTdn1VHErPcGdgkAjznJvG
 zhV2OEVuFVuu6TvUgNPI+Fs23vOy05RMSCN/si4bzAcq0OEFkK6z+tYiGx+iETuh
 zpqpZ1W4bQoyUOh6O2Rae8ev5FdTnPdyQPgGbtAqR2flmZN0eDJRtoATgAGe9T5f
 GMy/Cb/14LGTz9NhFfJEZqjjl8+v8cDVhbjLHoba7UBP9MQX79mg6UjVe9zHhoPR
 09ziuOG+C0uTq7QIb4Ido+iH4lh0RkK4b5Dqn2EL0F7D7EEb8OUa5vy1tbTV4Kc2
 wP1F1Wl/dEnhRQ51FsXZIGBlgesCEwYFGiGQ2Ed/EmN2GR8LlPnH10giOMA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4tcrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fca5f21b1so288167a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973257; x=1784578057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jYCiiKcRpdQH20AltIjtrmRVswxBEeBTUec3foZP/I8=;
 b=PMXGId/+3+TzN/Zm0jfcX/jlcrhoXj9ncUYhLUgTPxuH0DTJXfkp2h2QmR0CbpbKFK
 vYZ4BVcG1hDggVsqrCFZerjrGsguk75OlID1hzuCRmtf9gc0rTspe+NO3OUta+Nzg5ep
 9u6nw79hw0IAf7DIstPslQabzggUc0NtPcK04lHVZQ6NDCraUZr7sunt7PMhXAzhIuCH
 veNjsxlrgz8leHGrqsBIXST20bilbu45zZLLPG9rU9CMbyLWo++RvJ7CBellZ3ScUpb5
 TfGgz7TL8OJBj3AK63z/uHtzRyBCmGMrR2qbhwn8GuOdqlhkQ4XqxkKB1Toc6ohytbRA
 XfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973257; x=1784578057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jYCiiKcRpdQH20AltIjtrmRVswxBEeBTUec3foZP/I8=;
 b=lPy0ML4fWTEZs8NlgDbpCxSJmEtBFFSNjiVFutF+KPclvv6Ox/d+EinMP1xvvqCQBM
 YfRQwp/zsrAmP0WDHxOfAR+QGzdxKi9SJpJiEGiL7FcSK+xJUB5gOYuJD0Len/jAJoNZ
 AT7pUm6KW8SdFM66hwd+KLp8+jR7C27IsdUSaZXL/KnhOp7Fwsu/KYqoSNvCJaZfMeSh
 TbJHpF5yiYbJJI+3lDQBZm9hgOxjHfW1a9UjVadamBUQSEld4tYh5eHvlyufGU7zCXN0
 qWF7PpW8SWB286UgrontM01dcPZvRulgg6n26tZDop267dyBCXfrsbvsqI4Gp4y8pp+U
 IwEg==
X-Gm-Message-State: AOJu0Yx70RK5y6GPq8qetj41gBtgazbpILuvPymZKA/Ulrqv8i0nLAU4
 lrVtimKCzKah/j45G58F0icFPrw2t1asRBV5pnEpJOFdQXXJpW+Za3MTUDGloJlCufKNHiFYdKw
 tuuqqUaggJtfswUnM482Z/ZikdgVISWx/akWPvpcA0rMH8gjnbl4e6Bwflzf52ISvkkw/
X-Gm-Gg: AfdE7cky+sIMLoc+4+qwcJpDoNr3b1ylwHBhh4qyOaTBvdfWo+HSahk8KQJpndXHjqe
 3TCLD25ntGs3EMT4wyiSEEgjriEDr5msyD1Pm98mUZdocjnAf6KhngVBEq0lMRZY6zaJS6te5i0
 aElY9RXcn3zjVKVpYkAy4884LUqyIRi65jfqc1mIwSUHaRJbwD771Ntm9pjLDQvfMjbQuzP7z7P
 dWfmzQbeFYmckgegNYXk0A7iPFoQcOThsuyoLtHi36JrXpoDOdlPTVXNOT235MfRL7X+XOun5Y+
 VGdYE3pS1oDupTQ6SBzp44Z36IeL4gPCQgxkEJ96KPrhC6byOQ5Zc4RUhHU/leYnvoZkH/fGXp4
 Wi5P0SOZJmu0duyE+g7jX+uDtr2zIDzZjsSzwtxfpn5zwYyGmBUaaYt6HGJwwLyN4LgSbz+iN8Q
 ==
X-Received: by 2002:a17:90b:5108:b0:385:39ac:fe4b with SMTP id
 98e67ed59e1d1-38d15c881d0mr17035075a91.17.1783973257226; 
 Mon, 13 Jul 2026 13:07:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5108:b0:385:39ac:fe4b with SMTP id
 98e67ed59e1d1-38d15c881d0mr17035056a91.17.1783973256737; 
 Mon, 13 Jul 2026 13:07:36 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:36 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/14] target/hexagon: add main arch-specific semihosting
 operations
Date: Mon, 13 Jul 2026 13:07:17 -0700
Message-Id: <45fc870a747a670c26906d18909bc31fe816bd22.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a55458a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UwY7kZyrlkj7TMZqf0EA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX+1jvKfgG/wDe
 13/+AgjBqzVo3h5W53xKLEz6Gg1d79FUrI6cdJEWraDHt5WBSD6rV77cLkZpTWsKUr3x13Aqc4B
 u9+yRucsG29fKU6KzKmN8WUrWDi7OOk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX12424cuysCoe
 UsXZG/mN3GmbrFTP8qwtPge8ZfxtNFUeTMHP6/nutYjrOwOQG9dqxaThXHxULK+Zsw6gjhKpfof
 zeXRW1vH54B6d4vLsxmoTu73Xu4TFgVsA7WXQo5MBqq/I2cBK6Cja2uZvKXxbN3SWOE6Pxh9QIy
 xrGlCx2gJ6DAOAdROevxeZMTkSKrhfibH3DjqTMUXPLP42CC3JHEtGDqUY6nxFXjsJdCRBVlzhK
 MG6mrYMWpRAHqP8pyvwYZapsYcVKfhTeS6QcegDyMVihjc/JZdqXPFf2KDESPeCiPRORoN0GAPN
 R3DGbqVdXB4gjajVcKVMJPV/KUVB48pUyeBf5MC/+lujmrOTy9292ttse7xAyurvJdH3sSL5d6X
 5YyiSCut3eS7YidnP+XWuJqI4Q5qpDKS2JXS0waxiaKhletdyi5D/8E2lCJDN7ar9yfdCo1avhX
 8tLTMmRIstuORDaZ3kw==
X-Proofpoint-ORIG-GUID: uFs65Mw8NZrAwPwJQfUEa3FPz8RJMc-c
X-Proofpoint-GUID: uFs65Mw8NZrAwPwJQfUEa3FPz8RJMc-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
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

The Hexagon semihosting ABI extends the arm-compatible set with
operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
that baremetal programs using the standard Hexagon simulator ABI can
perform file I/O when running on qemu-system-hexagon.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 include/semihosting/common-semi.h |   1 +
 semihosting/arm-compat-semi.c     |   2 +-
 target/hexagon/hexswi.c           | 293 +++++++++++++++++++++++++++++-
 3 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index a11905ef4ef..1e7699d7bbd 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,6 +34,7 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
 void common_semi_set_ret(CPUState *cs, uint64_t ret);
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index c54753f696f..b930a028649 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -229,7 +229,7 @@ static inline uint32_t get_swi_errno(CPUState *cs)
 #endif
 }
 
-static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
+void common_semi_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (err) {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index ce9c85ad6aa..2c60e4d9e9f 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -119,6 +119,14 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
     hexagon_touch_memory(env, addr, count, retaddr);
 }
 
+static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
+{
+    if (err) {
+        ret = -1;
+    }
+    common_semi_cb(cs, ret, err);
+}
+
 static void sim_handle_trap0(CPUHexagonState *env)
 {
     target_ulong what_swi, swi_info;
@@ -174,7 +182,290 @@ static void sim_handle_trap0(CPUHexagonState *env)
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         break;
 
-    /* TODO: implement other hexagon-specific semihosting calls */
+#ifndef _WIN32
+    case HEX_SYS_OPEN:
+    {
+        char filename[BUFSIZ];
+        target_ulong physicalFilenameAddr;
+        unsigned int filemode;
+        int length;
+        int real_openmode;
+        int ret, err = 0;
+        int i = 0;
+        static const unsigned int mode_table[] = {
+            O_RDONLY,
+            O_RDONLY | O_BINARY,
+            O_RDWR,
+            O_RDWR | O_BINARY,
+            O_WRONLY | O_CREAT | O_TRUNC,
+            O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
+            O_RDWR | O_CREAT | O_TRUNC,
+            O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+            O_WRONLY | O_APPEND | O_CREAT,
+            O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
+            O_RDWR | O_APPEND | O_CREAT,
+            O_RDWR | O_APPEND | O_CREAT | O_BINARY,
+            O_RDWR | O_CREAT,
+            O_RDWR | O_CREAT | O_EXCL
+        };
+
+
+        hexagon_read_memory(env, swi_info, 4, &physicalFilenameAddr, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
+        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
+
+        if (length >= BUFSIZ) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: filename too large (%d)\n",
+                          __func__, length);
+            common_semi_cb(cs, -1, ENAMETOOLONG);
+            break;
+        }
+
+        do {
+            hexagon_read_memory(env, physicalFilenameAddr + i, 1, &filename[i],
+                                retaddr);
+            i++;
+        } while (filename[i - 1]);
+
+        /* convert ARM ANGEL filemode into host filemode */
+        if (filemode < 14) {
+            real_openmode = mode_table[filemode];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid OPEN mode: %u\n",
+                          __func__, filemode);
+            common_semi_cb(cs, -1, EINVAL);
+            break;
+        }
+
+        if (strcmp(filename, ":tt") == 0 &&
+            qemu_semihosting_console_has_chardev()) {
+            ret = alloc_guestfd();
+            console_guestfd(ret);
+        } else {
+            ret = open(filename, real_openmode | O_BINARY, 0644);
+
+            if (ret == -1) {
+                err = errno;
+            } else {
+                int guestfd = alloc_guestfd();
+                associate_guestfd(guestfd, ret);
+                ret = guestfd;
+            }
+        }
+        common_semi_cb(cs, ret, err);
+    }
+    break;
+
+    case HEX_SYS_WRITECREG:
+    {
+        char c = swi_info;
+        qemu_semihosting_console_write(&c, 1);
+    }
+    break;
+
+    /*
+     * Hexagon's SYS_ISTTY is a bit different than arm's: we do not return -1
+     * on error, neither errno. So we override with out own implementation.
+     */
+    case HEX_SYS_ISTTY:
+    {
+        int fd;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        common_semi_cb(cs, isatty(fd), 0);
+    }
+    break;
+
+    case HEX_SYS_SEEK:
+    {
+        int fd;
+        target_ulong off;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 4, &off, retaddr);
+        semihost_sys_lseek(env_cpu(env), common_semi_ftell_cb, fd, off,
+                          GDB_SEEK_SET);
+    }
+    break;
+
+    case HEX_SYS_STAT:
+    case HEX_SYS_FSTAT:
+    {
+        /*
+         * This must match the caller's definition, it would be in the
+         * caller's angel.h or equivalent header.
+         */
+        struct __SYS_STAT {
+            uint64_t dev;
+            uint64_t ino;
+            uint32_t mode;
+            uint32_t nlink;
+            uint64_t rdev;
+            uint32_t size;
+            uint32_t __pad1;
+            uint32_t atime;
+            uint32_t mtime;
+            uint32_t ctime;
+            uint32_t __pad2;
+        } sys_stat;
+        struct stat st_buf;
+        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
+        int rc, err = 0;
+        char filename[BUFSIZ];
+        target_ulong physicalFilenameAddr;
+        target_ulong statBufferAddr;
+        hexagon_read_memory(env, swi_info, 4, &physicalFilenameAddr, retaddr);
+
+        if (what_swi == HEX_SYS_STAT) {
+            int i = 0;
+            do {
+                hexagon_read_memory(env, physicalFilenameAddr + i, 1,
+                                    &filename[i], retaddr);
+                i++;
+            } while ((i < BUFSIZ) && filename[i - 1]);
+            rc = stat(filename, &st_buf);
+            err = errno;
+        } else {
+            int fd = physicalFilenameAddr;
+            GuestFD *gf = get_guestfd(fd);
+            if (!gf || gf->type != GuestFDHost) {
+                qemu_log_mask(LOG_UNIMP,
+                              "fstat semihosting only implemented"
+                              " for native mode\n");
+                g_assert_not_reached();
+            }
+            rc = fstat(gf->hostfd, &st_buf);
+            err = errno;
+        }
+        if (rc == 0) {
+            sys_stat.dev   = st_buf.st_dev;
+            sys_stat.ino   = st_buf.st_ino;
+            sys_stat.mode  = st_buf.st_mode;
+            sys_stat.nlink = (uint32_t) st_buf.st_nlink;
+            sys_stat.rdev  = st_buf.st_rdev;
+            sys_stat.size  = (uint32_t) st_buf.st_size;
+            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
+            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
+            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
+        }
+        hexagon_read_memory(env, swi_info + 4, 4, &statBufferAddr, retaddr);
+
+        for (int i = 0; i < sizeof(sys_stat); i++) {
+            hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
+                                 retaddr);
+        }
+        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
+    }
+    break;
+
+    case HEX_SYS_FTRUNC:
+    {
+        int fd;
+        off_t size_limit;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 8, &size_limit, retaddr);
+        semihost_sys_ftruncate(cs, common_semi_cb, fd, size_limit);
+    }
+    break;
+
+    case HEX_SYS_ACCESS:
+    {
+        char filename[BUFSIZ];
+        uint32_t FileNameAddr;
+        uint32_t BufferMode;
+        int rc;
+
+        int i = 0;
+
+        hexagon_read_memory(env, swi_info, 4, &FileNameAddr, retaddr);
+        do {
+            hexagon_read_memory(env, FileNameAddr + i, 1, &filename[i],
+                                retaddr);
+            i++;
+        } while ((i < BUFSIZ) && (filename[i - 1]));
+        filename[i] = 0;
+
+        hexagon_read_memory(env, swi_info + 4, 4, &BufferMode, retaddr);
+
+        rc = access(filename, BufferMode);
+        common_semi_cb(cs, rc,  rc == 0 ? 0 : errno);
+    }
+    break;
+
+    case HEX_SYS_GETCWD:
+    {
+        char cwdPtr[PATH_MAX];
+        uint32_t BufferAddr;
+        uint32_t BufferSize;
+        uint32_t rc = 0, err = 0;
+
+        hexagon_read_memory(env, swi_info, 4, &BufferAddr, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 4, &BufferSize, retaddr);
+
+        if (!getcwd(cwdPtr, PATH_MAX)) {
+            err = errno;
+        } else {
+            size_t cwd_size = strlen(cwdPtr);
+            if (cwd_size > BufferSize) {
+                err = ERANGE;
+            } else {
+                for (int i = 0; i < cwd_size; i++) {
+                    hexagon_write_memory(env, BufferAddr + i, 1,
+                                         (uint64_t)cwdPtr[i], retaddr);
+                }
+                rc = BufferAddr;
+            }
+        }
+        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        break;
+    }
+
+    case HEX_SYS_EXEC:
+    {
+        qemu_log_mask(LOG_UNIMP, "SYS_EXEC is deprecated\n");
+        common_semi_cb(cs, -1, ENOSYS);
+    }
+    break;
+
+    case HEX_SYS_FTELL:
+    {
+        int fd;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        semihost_sys_lseek(cs, common_semi_ftell_cb, fd, 0, GDB_SEEK_CUR);
+    }
+    break;
+
+    case HEX_SYS_READ_CYCLES:
+    case HEX_SYS_READ_TCYCLES:
+    case HEX_SYS_READ_ICOUNT:
+    {
+        arch_set_thread_reg(env, HEX_REG_R00, 0);
+        arch_set_thread_reg(env, HEX_REG_R01, 0);
+        break;
+    }
+
+    case HEX_SYS_READ_PCYCLES:
+    {
+        arch_set_thread_reg(env, HEX_REG_R00,
+            arch_get_system_reg(env, HEX_SREG_PCYCLELO));
+        arch_set_thread_reg(env, HEX_REG_R01,
+            arch_get_system_reg(env, HEX_SREG_PCYCLEHI));
+        break;
+    }
+
+    case HEX_SYS_PROF_ON:
+    case HEX_SYS_PROF_OFF:
+    case HEX_SYS_PROF_STATSRESET:
+    case HEX_SYS_DUMP_PMU_STATS:
+    case HEX_SYS_HEAPINFO:
+        common_semi_cb(cs, -1, ENOSYS);
+        qemu_log_mask(LOG_UNIMP,
+                      "SWI call %" PRIx32
+                      " is unimplemented in QEMU\n",
+                      (uint32_t)what_swi);
+        break;
+
+#endif /* ! _WIN32 */
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.37.2


