Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B692BC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0j-0000Bk-PF; Mon, 20 Jul 2026 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzl-00089F-RQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzg-0002z7-Ez
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHBrjB137362
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JUjDZ1DHGvR
 7qgizW3604RGsuA6SIWco7PEugKqVXNI=; b=mglw7ErTMbSXHHEqzQZbNo9Ygax
 3Uu4FtfQwdy5jbfcVVdUWA72qAAudK3dtCHX3usXAZCS6ld5yl1Ceyn1Z4QUolq8
 RHVeZgkf25q++D70a2swMF/lJGaLP03uv0go6uNkfwklwPQ2gTkzhurld5VIs7NF
 avlFuNan1d7l+c8uAmRFscnxFNOT9b8OFKH95eqhUFlP19AV+tu6AddcaHKIOMCa
 eF1uebwZyJxzhBTsOeDQ0i3juPnixLST0IL47m5FHRPmbqQ126x1C94MVD1WnvxV
 d6544D105H4fUDNNOW5nt1GCgBQSOHFxq4JUMYTmGxfcukGgvj931/vC9qQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5r4ae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cea6a46766so158448345ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569280; x=1785174080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUjDZ1DHGvR7qgizW3604RGsuA6SIWco7PEugKqVXNI=;
 b=AEDjXr/tBUTGrND4rLUIVSlAB/BmqbzAbsLqSoinOqMc0o5FyjOB1lJqtDqJwvjWBV
 jiIasJJak93sNcxge73oWN7OCqFNbqGf9prWmL7Ucc3zJSvMEX0VLJmM5aiyh6gaer0f
 ymy9l8uoLTDkgdhtmFlCbF54i6OPYHLw14Ua2nRJETZ5lcJwyHDUmYVjf53hWZXrS2kd
 nLNrP6fDyBD+9i/C1sW1e367p9xz3P0IjEQxElNDAKIo+ft8XKasRN9/ICIsRMsgE4mJ
 m0Q+Hc/CtYT1OUmo5g4rVbWWSHLs+Rv6pO9grIvUjtGuqCDiJQKpqHlgMvwVDg9fC7lD
 eXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569280; x=1785174080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JUjDZ1DHGvR7qgizW3604RGsuA6SIWco7PEugKqVXNI=;
 b=mVST03CdixB/NTdC9E0zzBpeadImxB1Qbe6zufPO+dP6rQOhD78sfPQJZmBqXQ0sxL
 vLxDUqyGe9yTL7q/gZa3edszAA8kyx2Oy+i0bMik9tX3oY13zJP66YqEsetqTvDB+/+d
 1Bo6tP4mAhmAVP2aCnky3S2RdvmK6BTXq9M2iS77+qf2D+fzOxLMULDVs6Cn5VUEO8/Z
 RV7QSKECW/Msk03Gf7Q3BDR7nF6WvgSrrLOxhelxSuN8cUe17RBWp3by04ULwJQNoeC5
 D5WcVcVVbi3C4afz0mQJsbAZlx0pEKJoMDkJnKIffSFYb7lWkMVUsrXz+Yr/3VhHQ/AO
 b3Fg==
X-Gm-Message-State: AOJu0YxoNJndxENu5t+yDezjkazROReYyaDtpo6ItR3854COxAOgytBE
 E9DtcbRW9+3DFVm93lQD/jwNhwBHMHd52oO6AHfh4W6QJHID/o6Y83wE0d4EhFXRchIJDC4c5LV
 HG0KcUKTCN2dc5y/zKk3028j8b/v0ogK0rnhol5/VgPoWp6/iIYL08y8mNzkX7D7Kfg==
X-Gm-Gg: AR+sD1027M7kCejwJRwDeGO1zA6Dhvc8AUh5bSENiCTapnfXUwUin9i82nYb610FXj3
 ukqH557l6jh06DuCV+Jxtm/Ksdcgd9R8x2mbk9PwvDR1fSeJpuPSStyEGNiDVFTgsePT4sTxWK3
 naOFicTedQ9aUKEPdWltUZJS9mG3G6zovVla2NsDziriQNadTHU87/EjC7i+dZluETN9PuNSyTr
 j5VHOHqFjEFmvAasntUT9S74wl6IIIOp+bclhvQd/QthCyA12HE2+lBIl267yWxUXaS/nCtdVgs
 XjXaEhHPvafbeVQeyy31dHQPXi0woGoBbtS/r2rSKYoOW0CdVJeE/wvtn9hvTsnVIS7EzR/k6mi
 +puPGXZKFGn+eLvjkYRobA7GU2dIoh4C6QM3i1NIxHzhCLv+tvfGYDj4qKiKJNB4=
X-Received: by 2002:a17:903:2f87:b0:2ce:d1dc:1e1 with SMTP id
 d9443c01a7336-2cf34a49502mr163584035ad.39.1784569280006; 
 Mon, 20 Jul 2026 10:41:20 -0700 (PDT)
X-Received: by 2002:a17:903:2f87:b0:2ce:d1dc:1e1 with SMTP id
 d9443c01a7336-2cf34a49502mr163583645ad.39.1784569279513; 
 Mon, 20 Jul 2026 10:41:19 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:19 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 08/13] semihosting: add ftruncate helper (to be used for
 hexagon)
Date: Mon, 20 Jul 2026 10:41:04 -0700
Message-Id: <6bff530121c1e53b49328253c04027ebf1cc1abf.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zsln_5cKxtCWGau3Vdi52JI_EeE-JZI9
X-Proofpoint-ORIG-GUID: Zsln_5cKxtCWGau3Vdi52JI_EeE-JZI9
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e5dc0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=H7u-uynIU280lupyLLIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX0a2ccQ4r3bE7
 TqJke8IBv7z1tgOSKv9HFM8FNh/FhaPxSoa4AbS4w3pU/TdfhUbPLtqkJIozvSchmedfSU4rE52
 uOrxPRDAqVaJAmcRcwTgbsQ8FvdCV5E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX1ffASkxMVMfn
 o8wCZgvxz8hU4mf60gszqMdH45Bc1i4jV51KSRW99Z00S95cNWUf9jXGhBaJsvkHvJdHaV58Ooh
 r5+et8NH/JL/1Stj+k8xAem7l1mN8l2Iw53rg9S0P8AM2lJeGMqzy/l0Jv5Z0WAcvyCFn50SwIn
 J4TDEtgoLeBCj4s63mVPhmETI3pcP6IQaxumbnICj7vEnUzFZFs0CA20cu6TF16skLqp6YKo1/f
 cCbe56paPs/kO7KF97LH+w4TmAMs45fXj5rUkmfzdRYcQ0QC+g08IlzOolQrhyv449ya/JB21l8
 36DLErvk6hz+kYUvtN9EJnezthwiykoPIUgVY7KjlQnHrZclV7doCMW+/pDvIy5JEjzalQCrlcP
 +Dyb9wk6dS3bC3xQF+L9p9v0Akl4m9vVuMBNLK60FmzM+NX2HDJvgWLeJH/NYgjXv90o/lJ5suR
 ZQU+PNyx9Ag4n/1Bt/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
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

The common semihosting syscall layer has no ftruncate
helper, but the Hexagon semihosting ABI includes an FTRUNC
operation.  Add semihost_sys_ftruncate() so that Hexagon
can delegate to it rather than calling ftruncate directly.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 include/semihosting/syscalls.h |  2 ++
 semihosting/syscalls.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index 03aa45b7bb9..3919ab64c7c 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -75,4 +75,6 @@ void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
 void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                            int fd, GIOCondition cond, int timeout);
 
+void semihost_sys_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                            int fd, off_t len);
 #endif /* SEMIHOSTING_SYSCALLS_H */
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 20f155f869a..0456db0befb 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -8,10 +8,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
 #include "semihosting/syscalls.h"
 #include "semihosting/console.h"
+#include "semihosting/semihost.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
@@ -541,6 +543,13 @@ static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 #endif
 
+static void host_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                           GuestFD *gf, off_t len)
+{
+    int err = ftruncate(gf->hostfd, len);
+    complete(cs, err, err < 0 ? errno : 0);
+}
+
 /*
  * Static file semihosting syscall implementations.
  */
@@ -982,3 +991,23 @@ void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
     }
 }
 #endif
+
+void semihost_sys_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                            int fd, off_t len)
+{
+    GuestFD *gf = get_guestfd(fd);
+    if (!gf) {
+        complete(cs, -1, EBADF);
+        return;
+    }
+
+    switch (gf->type) {
+    case GuestFDHost:
+        host_ftruncate(cs, complete, gf, len);
+        break;
+    default:
+        error_report("ftruncate call not implemented "
+                     "for this semihosting mode.");
+        g_assert_not_reached();
+    }
+}
-- 
2.37.2


