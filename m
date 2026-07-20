Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06E5C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0i-0000AA-DX; Mon, 20 Jul 2026 13:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzn-00089J-2e
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzi-0002zH-5o
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6TTf2962253
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8yGLavqPdzo
 Bm+AFfkOFjMf1alM1ifVWOczbfo/b9vk=; b=eU+hk5Jop9wimjJOUVj6VqsQGK7
 gyswszkCxZB/QtRqAF/tm2jG3e7hcVT4Wvrgvkavs1rhS67K62EhXsaMhSpp/DzE
 qC/c5BJKFwm86saBPAsIHyhv9jkvHX0DJXG5KF38oIj9TcyAeBUa6et/thUBKjgL
 ne/oCKOkgZAMONfQ5jJ5oQvKACTnq7tJGohzeENi8paUVEOBgTV9ZGJCLdIgm7Q0
 u/LuJpCsSDcbHRgeOh1KXHBBigSMDnFuSJyjDW5Yh9HUi1105jUQgHfWlikpySCx
 bv3ko+JnhLQRcskkTXSrPAlsynNods8vXSZ/wpCM+e2YCy64+wuNbPwTa6Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y2784-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so204167245ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569281; x=1785174081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8yGLavqPdzoBm+AFfkOFjMf1alM1ifVWOczbfo/b9vk=;
 b=NYcoGaI3lhnQ6zwjtMlroMSWw0HNCB++TttPC0LWNAXBi02geCVtGQpqopwBH4s1mV
 rA45iVgdaQ7rcLdLnL4xlYLuxX5mmrKQIHvsiE9uIj/gkPmvY9jdi7Jz9PfU0t1LlujD
 w60yoF1fpdzXUz9RHTQMZaQP3y10HVapcSSgIViMohWsuR/HieNGizC2M4b6KVAN5xJD
 QxFb51JXduvALyUPEjlBVsHNx1LUvuNRy1nAv//XEsUlUgJZbdH3ZGdrkp21Q46WBGej
 cdx+91u1Pkd251aCqmpLNH27Jk85fvWsxMf+l0OBmq+34cWSUFL57evQp+RFbaRvI8Vj
 ELfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569281; x=1785174081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8yGLavqPdzoBm+AFfkOFjMf1alM1ifVWOczbfo/b9vk=;
 b=aj4lx+A4xAamvwmoDRg+Ot3Ecv+68HATH3rlkoyC3KGh8hmWJr9irC/01/EHN6EqXc
 w37uFsW0uCT9t33f+g7Gaj0efA9fMIAMTy3O70jgg1gCz2XhH6l7BMkPQMGlC2WOApGk
 y6s4Ow9usJkErVp5W0DIyJ1eC54vVhXPUOGvZH02UdA5uz1PN80l8rb9Yd8LA1iKXxiQ
 Qmhmip6y1a8NcQ88nKRvqVzU2g3fPQFpdlIi4HOsZys/Qx1Fg1F2FOMk6do6riOK/gx+
 FbHR7LZNsOfHRe5trPhMvkHXmAHu9cEQAHZHmmaMfk1cLKI5/2PB5u4S44+gWCQPv0Tn
 w2aw==
X-Gm-Message-State: AOJu0YyDO2Pmr31nN3xnRRPoXVHgZO1COjvcv36aTl+4jZgE3Xg3E9PB
 IS8FtSYQMW2xTgHROIVMgt5lXndEGfMll9G3TX7gY6B8/Gfr96di1wqCiCc8GrloSjHwRbcUIKd
 az/BxV34YeKNA4elWk0l9zT2xkSPSYEfFFApuSilwKh3BwZce1K/eZQROdJn6o51f8A==
X-Gm-Gg: AfdE7clD7qupX3llnZ/2bH+Xy668eFgh6e8i95cY5EKI4BiHTUIZ93NbjBBaG/p5JzB
 beuoi79vjqgjuPqAlatdWfVfe2lu7BZOmADGTIRKpAWFmcXyF5v4LkbQKwKfJhHGrzVDwOtBW/a
 0Dpm9MZlL9ce7QLqte5NK219ZUvIyt8i89ZBuC2Iew3CbonnNoeHNATMZWbArGoWBHW62PxAtL7
 0cltoxq5XmPD3qJ0bEo41JmtdN3o+iV5PGSeFNg0iSIN3gCpzXy67gRDORJ9uAOeAKYrfz8nklL
 g9RZVXH3BKXaXjZ/JXZ9Ylsdy9WSNgy2wVfpDGN7oJUI6FibiqSO49b9FQSDOt+978eXtwLxXAL
 rriDWVWAg+oIryzeuFJmXjPIrAg87QDA81hte6G5uwOboA2NzpFXKZ2RD3PZZXgM=
X-Received: by 2002:a05:6a21:9206:b0:3b3:1c7b:ffb with SMTP id
 adf61e73a8af0-3c3ad808bc9mr15386560637.34.1784569281055; 
 Mon, 20 Jul 2026 10:41:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3b3:1c7b:ffb with SMTP id
 adf61e73a8af0-3c3ad808bc9mr15386520637.34.1784569280441; 
 Mon, 20 Jul 2026 10:41:20 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 09/13] target/hexagon: add main arch-specific semihosting
 operations
Date: Mon, 20 Jul 2026 10:41:05 -0700
Message-Id: <96776c988e48b04a59a146fb62a934389a73a4a2.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX1YQHbjAY95YG
 qpamrlIjmPJGCrvMDokSzw7qKuJRMIOQbrx7po9C3JI0RSzPeOMoK+0UEuKSsshfK1qj+4kg2BX
 3Xb1wPgrDnmLSFCkRLN0P5/qY20Vtz8=
X-Proofpoint-GUID: Fpejw1Ec0neFxa9H3DkWJmo_xvrbN0Z1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX2rT+1+/tXAkD
 U6Tzy97YrwV7D85FEa1VFAIG6j3yuRSeiHNjhtuFR0n51ZxUVxddzrDwXpC9i+f5tcrNmf4ftDV
 UAvbLSCXusxA/h4b8oaEH9pgeQZCBnXGVsalNxRjP8E7QkNyWUOZN+8n38uJ7iD930qsQWZPL2Q
 YNPcHmMvDvckgu66kzbi64IsX4UTgAWOCRefq223LeMwGh6W6OYrrgEpu69tXH10/0yUj65U2Jb
 74NfoErl/pICq3duMgQLqS0I6IqlsoYsJANzY3HXNAOCufQ45OYKnJF9szjy02Nb/gtXULbCywW
 6hU9/e/B8rgaDNP1KbMkz1Gd5zdEPePjJBR2/rGwGNx0USd11dAFWiaCz01NOddLzWkBXuOJ//Q
 Fxga1AT32VvvAYssIYV2MRhVvgXs9c+6MwRcnsMFXZPCIGVuezEOHV16aFDY8bVZuQjdeDTIvrE
 ezSEj0ObkAvBwQiFTug==
X-Proofpoint-ORIG-GUID: Fpejw1Ec0neFxa9H3DkWJmo_xvrbN0Z1
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e5dc2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=UwY7kZyrlkj7TMZqf0EA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
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

The Hexagon semihosting ABI extends the arm-compatible set with
operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
that baremetal programs using the standard Hexagon simulator ABI can
perform file I/O when running on qemu-system-hexagon.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


