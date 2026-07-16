Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3B0C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUs-0000xh-B7; Thu, 16 Jul 2026 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUq-0000xP-RO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUo-0001YJ-Ov
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:44 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSsoV3172066
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zpzkIk7+bel
 lbxrc0HFZLhSl8PRNKhU6ilCHgSo3cX4=; b=Zk51dK1F5RR8vIOASEYFoMsU/Y7
 JZX631AYpc8Krx7GKno+XhRKguhjSikPq7Iygtc+/puZ82jHTp+HN8dI2ri7A3bI
 boRtAqey6AnbGZWNB+HA+Y7h8ozr5DOVkvB+gqlegO9qqF3CQqhFStgnMfi3mxHw
 Z6ZUuu4cGW7bFeIKX+vmfJoBCOMffDOkOy2iPybGML6V8wKoxWDH0bFxRw8gjIN1
 bSShvxMRFqwyOKO/UgxPb1wpKgpmqhVG8NjrCOyjvnq+ttHGzeHTFU97lw/1GhQm
 6CJ7jISSsUxAjOfiUYX+2f53vioGrBhP736tIPkU6XaxgiD8QjntqWpfpjg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv2bgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso3214637a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225261; x=1784830061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zpzkIk7+bellbxrc0HFZLhSl8PRNKhU6ilCHgSo3cX4=;
 b=hiLLyjR0T1Dw8ZYmJAiyp1oQXJY2oBLjrj5lNfrllLy7H0hTFD56HRTMZ05PEt8/j9
 mjTIC5XdFW5bcNvY65rqjJQuDOUZGleg3zhdzDLlaFNPHQkfM9Dnk2dhnx+SkKnXBDMS
 eKqzuHDhHxpLaT61gOeS51MxdXOG6VhpzEXF4046G0c/beDerxFZcrUSz8wRvF+dIQdu
 sppTQwjedWpvZW0G/bljVmDzqkYPRkfIgABt7qh8fz3zXSI6qXHK7xARCby2UUE5wb/A
 gSXMQ8UClvYkKLYGTU7nXcKuKh0nF6R0j0t+V+bmInS3MWF3f/qO/vqi5h+k9nopO6Nj
 HhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225261; x=1784830061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zpzkIk7+bellbxrc0HFZLhSl8PRNKhU6ilCHgSo3cX4=;
 b=Z+qvuJUu41TahdTzxOWguYQQR6iJuiVonfx3YbQN2f57GBxWPetF/jbXDfsPLjKDJn
 543Lar32JmPWl3SUudIBCVkOO1HTp9xvUrD5KTGEjEZrvzlOzjTwMyLVOFqc+l+w7/nk
 TzeAJvpMQ5Ou8KA/tqj7L7sBISs3lYnBNLh+zDUg12E9YIs5JH8tRy8wiLk+sNkIiOpk
 bHTB6Tsnwlabp3jDlfTwpi6qZCZf6QE9vqXbcPXieJd24xSJT+jg5KUmmLAKVyj49g97
 A8dURolMjwuum6oH2KGU8VZ41gEqmS1m1mej6ElPnb9uM59v8TYzAtdLta7ZEpkNWZjg
 wFZw==
X-Gm-Message-State: AOJu0Yw2TxoVzV3af2UvQ9/uhSlgjm6KdEFih5PynpomVZbR5Ud2JG8W
 q3ZMh/vioUgavqe5FjQqmGkMrVMyukETrlznCM40wkVjfkb2/5yyQp8FpTm80xh9XYdOzEjet8i
 mSLQ4uiJisjRVnRLvPzajDAO2jR9ThWhtDz1LaVmK7Feo0DYACxSe5J3CuPuO5riSEA==
X-Gm-Gg: AfdE7clUVX5PHyYNSlOlPboHY4K5yGhX7b8Lvol5lt2YBQJEdaQ60w4kBFfPqJop7hF
 zZc9sMLEupsJt7D15f98As3kS/CdLtthrMEAg8KAsxTi35boT5+zk9656MKTzBQpmA4so64i/cv
 yE8UkbCksQK0GPIJxcK6zOfud1ntk/hC3ymQYRW9ectTwLr04stYYImer+vzXS6JPRsOklCaUwy
 1L1EMM8EzgPHR0ZW0NCGdgBwPsf/xrYp9MjOChY6mBBXNhmXrkxKQ5MPQdogSlUzg97P0I5cikO
 44CG7vgo6YETYyOvvew7xThN9Ammlo1Dqu84Sv2UsImFzxyS42edw5+iY9xxZG7SQJ8z+VKxyLd
 YCDktAWFyHllPcBVDF7zvzeeHu8y0DRrWsYy6EbMwhYYY2S7AJnYQ41hdIRa93CQ=
X-Received: by 2002:a05:6a20:3d02:b0:3bf:c126:baf2 with SMTP id
 adf61e73a8af0-3c3a5d42a9fmr208130637.47.1784225260487; 
 Thu, 16 Jul 2026 11:07:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d02:b0:3bf:c126:baf2 with SMTP id
 adf61e73a8af0-3c3a5d42a9fmr208072637.47.1784225259776; 
 Thu, 16 Jul 2026 11:07:39 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:39 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 10/14] target/hexagon: add main arch-specific semihosting
 operations
Date: Thu, 16 Jul 2026 11:06:54 -0700
Message-Id: <b66476c599c399031bb95bb6683e74835fee74ed.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXxAm+Qi5/VTQm
 GeATibf7nkRRdXTrt/LIV0h3I43XBny4+8xyTJMmXdjEY9o79FCz3AecldHWRkhpZMOZ/t+wdl1
 Za9IW2yPOaqK17c6VXSTR/+luq1U4yx6yZ6XmPzaythgIGAEUegqQEsvGqaEaDo8NSLiB+k3dQL
 FwHCx5LBDwtDQo7wOy7rKft3QbAYl93xfOJ4rSkssv4zkHdb5Mg09CEolI9SSNi7VydsKELvczM
 N+vQSyHqyBbORpsRzj3dRpAEWXRsngEexs0IlCOO1Xi4UE5u1QFcL+WWKIIa37treQGkUgFoish
 fXNFLl7DxKbnjI7sJDRu8hjzyokTA1wJkKXpYIz7zVCFA+SNNUDICeJqF9tGf9g78j67G35fTn3
 STmjPLVm+lPufHNFNJruNlHDndEZl5t15mokIcagzKpBspiPX0mj3HZE6mpQPpog4WJZHqFraai
 q36n+QGGGYbSksoOJkQ==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a591ded cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UwY7kZyrlkj7TMZqf0EA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 0KWSuWwwUCecdPbyXv2XTEEV9Nb4aJMm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX8VMXhQHAczCL
 ByiASaFPr1fF88fp8jYwcMwB4QX1fqE8gf0TCk9AwnuRvd9c0xSXEFZz0c2DxsZmvleCPSlHx+Q
 Qw9Vn0MJ0SkX0+hqxCPC4eqZm1CxMK4=
X-Proofpoint-ORIG-GUID: 0KWSuWwwUCecdPbyXv2XTEEV9Nb4aJMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
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

The Hexagon semihosting ABI extends the arm-compatible set with
operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
that baremetal programs using the standard Hexagon simulator ABI can
perform file I/O when running on qemu-system-hexagon.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 include/semihosting/common-semi.h |   1 +
 semihosting/arm-compat-semi.c     |   2 +-
 target/hexagon/hexswi.c           | 298 +++++++++++++++++++++++++++++-
 3 files changed, 299 insertions(+), 2 deletions(-)

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
index 2aedd8368e2..6efc00fedf9 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -85,6 +85,41 @@ static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
 }
 #undef DEF_SWI_FLAG
 
+static const unsigned int angel_to_host_filemode_table[] = {
+    O_RDONLY,
+    O_RDONLY | O_BINARY,
+    O_RDWR,
+    O_RDWR | O_BINARY,
+    O_WRONLY | O_CREAT | O_TRUNC,
+    O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
+    O_RDWR | O_CREAT | O_TRUNC,
+    O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+    O_WRONLY | O_APPEND | O_CREAT,
+    O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
+    O_RDWR | O_APPEND | O_CREAT,
+    O_RDWR | O_APPEND | O_CREAT | O_BINARY,
+    O_RDWR | O_CREAT,
+    O_RDWR | O_CREAT | O_EXCL
+};
+
+/*
+ * This must match the caller's definition, it would be in the
+ * caller's angel.h or equivalent header.
+ */
+struct __SYS_STAT {
+    uint64_t dev;
+    uint64_t ino;
+    uint32_t mode;
+    uint32_t nlink;
+    uint64_t rdev;
+    uint32_t size;
+    uint32_t __pad1;
+    uint32_t atime;
+    uint32_t mtime;
+    uint32_t ctime;
+    uint32_t __pad2;
+} sys_stat;
+
 static void init_semihosting_guestfds(void)
 {
     static gsize initialized;
@@ -119,10 +154,19 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
     hexagon_peek_memory_range(env, addr, count, retaddr);
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
     CPUState *cs = env_cpu(env);
+    uintptr_t retaddr = 0;
 
     g_assert(bql_locked());
     init_semihosting_guestfds();
@@ -177,7 +221,259 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
-    /* TODO: implement other hexagon-specific semihosting calls */
+    case HEX_SYS_OPEN:
+    {
+        char filename[BUFSIZ];
+        target_ulong physical_filename_addr;
+        unsigned int filemode;
+        int length;
+        int real_openmode;
+        int ret, err = 0;
+        int i = 0;
+
+        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
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
+            hexagon_read_memory(env, physical_filename_addr + i, 1, &filename[i],
+                                retaddr);
+            i++;
+        } while (filename[i - 1]);
+
+        /* convert ARM ANGEL filemode into host filemode */
+        if (filemode < ARRAY_SIZE(angel_to_host_filemode_table)) {
+            real_openmode = angel_to_host_filemode_table[filemode];
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
+     * on error, neither errno. So we override with our own implementation.
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
+        struct stat st_buf;
+        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
+        int rc, err = 0;
+        char filename[BUFSIZ];
+        target_ulong physical_filename_addr;
+        target_ulong statBufferAddr;
+        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
+
+        if (what_swi == HEX_SYS_STAT) {
+            int i = 0;
+            do {
+                hexagon_read_memory(env, physical_filename_addr + i, 1,
+                                    &filename[i], retaddr);
+                i++;
+            } while ((i < BUFSIZ) && filename[i - 1]);
+            rc = stat(filename, &st_buf);
+            err = errno;
+        } else {
+            int fd = physical_filename_addr;
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
+#if defined(__linux__)
+            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
+            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
+            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
+#elif defined(_WIN32)
+            sys_stat.atime = st_buf.st_atime;
+            sys_stat.mtime = st_buf.st_mtime;
+            sys_stat.ctime = st_buf.st_ctime;
+#endif
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
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.37.2


