Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB87C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MvG-0003Fr-27; Wed, 23 Sep 2026 09:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MrH-0000AT-8N
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:18:08 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MrF-0006sB-Kn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:17:58 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144f47a9b57so958832c88.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169476; x=1790774276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKNecRa3tzG6HeYVTRQDuQ00e5AIYSJOroCNurGi9rk=;
 b=Nh7UGweVMK4Q24qKEB+jlxH3ioXSR1cYoSdkEXvHlOrQHWk1FiblvCh0f78Wz8DeVm
 VqsnEShxca/46/lm96kt4KR9Y84yGp6UjOBCJBn3Ik37pbXdCLG3uwsW1b+z1S6iA/Zq
 QACQTSxotYf8cVeVYwmtN5RtrxbpHfLf7ra9dh4n/YcUzOnsJF2Lw6vvnvSFr8BO7Jda
 eRukweiPKT20gAWQM1Pp4fLbKFQbq1TgTP1pqG8Va5x2jP8MiClsgYkX5EZSen6DNE/o
 dGeTr6nm+kaJhNJpODhFkEs5wuKfSuIetJXvjpnxA6tjuSpVwQP+vAGtY+WWmAsCNHBX
 m4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169476; x=1790774276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKNecRa3tzG6HeYVTRQDuQ00e5AIYSJOroCNurGi9rk=;
 b=gtRKL20KQulUUOlo8kjoFFSYIDa1GG+xJcdj4B5XL1ulFmjvYpRZLaAuSD8IP1uIKF
 2yPSdkwSOqbIetSrGqIPvwqSPWY2GS/6DtBW+jaFxNtZAHOxOM9HC1+lvSkoH0JqVFEi
 LQY2zt910x3naR7YIhHacZcauZP1OFTaGV9mit+dF+IeJTcVB4VDN6mYt05tm+FiT+wM
 Aoa+3WIpXRUAjKdPi4y92pAtKmef71PV2kao5jlbLBtAFRWISAocwqvdbkPfXaeHMw69
 cEjC86pwdTkON0JyO4ruKmr5RMKVaYSWT8YnsEDfZrkSxqz0q7StxwzFhzM5xGvstL8Z
 sEZw==
X-Gm-Message-State: AFuF++koTFh65Em+OuVcO997v+CxwlgAv4aWU+rvP2DnxTAlFwgTiUHl
 LxYR3Ert+4jIWzjBYufp5cXNoUjT66/gxtFiSTbnv3oPh76wiBAFo+drkITt5zWKsac=
X-Gm-Gg: AYBFou1BXb+N+QEc4H0ADgIwa/TJMmpo/4murBvWpLYgUPJifajQjosuoQ4iFt8tAyI
 99eu7D9Wks4tRVuRRa0ZslCXg+GMewptero8O3KuzJz42PtbNCWHKGQ8ZqFdKQZONVBL5Yj9Y/U
 /J+po66DEZxfG6xTDmul1wE6hol+iZwTCOkC5hfbR7+RRoKlz1QpHbLKgOPc3SvUMXN5T1kvAss
 5mvk3ABbIvr/UKrQB9GU2xn2vf2atUVnWFk3kimKAjLNO8dKNsJDTrIGMNAWnsjFuz0SgYwC90Y
 b4uaR37jQKkCOxEC5Sre/27DnwGJHsOv53YcplY7L4SLbuoGkzeHmMI5jLt9zw4mr97cbN1kdFp
 gCy6Z4afZR4vh401YRlw8Lsiz105BO1GW7AqfZk5PWsQRODJDPUmtzS8pMAng7OIhGWSREuSrhb
 qC5A77faSokYImJ/8vhG9jG6JWSTmGMhbNmCXOCdXyy6Azi+xI2DIzVWH/wP835nud94GR/a8dG
 y3Nr5MrFdbm9c2Rfue7ct2QxX4GYeU=
X-Received: by 2002:a05:7301:db0c:b0:33b:96b8:3818 with SMTP id
 5a478bee46e88-33e8ddbe14cmr1954620eec.32.1790169475447; 
 Wed, 23 Sep 2026 06:17:55 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:17:52 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 007/114] vl: parse early options before target-info init
Date: Wed, 23 Sep 2026 21:14:41 +0800
Message-ID: <20260923131635.1894-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the first argv pass ahead of MODULE_INIT_TARGET_INFO so later
target-info selection can use command-line options before QOM init.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 system/vl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0d52c5d0a46..dc883de8274 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2910,16 +2910,6 @@ void qemu_init(int argc, char **argv)
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
-    os_setup_limits();
-
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
-
-    module_init_info(qemu_modinfo);
-    module_allow_arch(target_name());
-
-    qemu_init_subsystems();
-
     /* first pass of option parsing */
     optind = 1;
     while (optind < argc) {
@@ -2938,6 +2928,16 @@ void qemu_init(int argc, char **argv)
         }
     }
 
+    os_setup_limits();
+
+    module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
+
+    module_init_info(qemu_modinfo);
+    module_allow_arch(target_name());
+
+    qemu_init_subsystems();
+
     machine_opts_dict = qdict_new();
     if (userconfig) {
         qemu_read_default_config_file(&error_fatal);
-- 
2.52.0.windows.1


