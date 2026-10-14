Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0510CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvZJ-0000q1-Kt; Wed, 14 Oct 2026 05:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvYB-0007Ee-Iv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:45:32 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvY7-0002WT-OW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:45:30 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so1090564c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971125; x=1792575925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y4OgtMU5Mx05ssteaqTUflD+z1U1FSvhSEKiWvjqqcY=;
 b=NoBwbN4gBHqq/aLOwNaCQqVrZ5Z60QSRCb8UIa4i8uazmvMlwRla0U+aeW9idYhPjj
 bkPuxgkCqHOataIj7IPTyPVlHarkqwRnpUsce58eDBaCbB5jIKsACpMlwQuLdhxpoepN
 onlWu0tIJp/b08CwZqniyPFZjch/0eWKPUSJ2JeOMqQzEFxKkoppHnJMF6Mh+0q5DpJf
 xg3VrlcSHj8gI5AeDUz2yYEsndSHPqPKYR0vp2ClXnFDpYvqGrAV9GjGeCr55+4AUPXt
 CyyWscQZ4W3M7LfRUwL6ugie9YBzS8762WVqwMHBlcmoFIjPBZgjopbJ/Bul2Qx2QAZ4
 qKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971125; x=1792575925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y4OgtMU5Mx05ssteaqTUflD+z1U1FSvhSEKiWvjqqcY=;
 b=yZC3SVg4XoDm5DHJ8k/uIOoD+5kgZTRL3VvnKKrE0d81P0uEE3KEZUcldYq/B4PL2v
 E8Z8SuHroJx0KNTA4HxCZwn0QBKr23r3hKB1kdHNcwoEjsLJGBplbBQKkFZU8eLfeNX3
 NCwrbzMlwuJuZuoS/tCoSUYPRQfIhlbzlikU2jwdMoGBpP4N4otzPG7H3ERXQO+UDIpR
 gez7zfhC0GL/F9z9Loa74Yy/oYPx++IFlDie+lNLPgAYWOrv1ayT3a1AEWhjQuIdx21F
 JSN68DWesxp4psZUokIRa45UR1AxXfYShcEjS+B+rDgEDsskj8eTkbsp51mGtP0H3PsQ
 J6Lg==
X-Gm-Message-State: AFq9FYLZ+tg8Smrnd0Xg/Re7Qj0xH7/Ru5H741N5VnGe+SYMIGOP1hK9
 HXmFCGR5HE77ZhzpTotDfwwM1W+zOEKbz7Z5YmHU1gzgHP2KSQ7NG8QW0TtMrUB1IXM=
X-Gm-Gg: AYBFou2U5ZuIKLWbPEToDzv+IWOBl064Wds4aJ7biu/44Ao0Q9oZi7E8inNxRJjg+j0
 rKtUSWFYsUr0XEL+NmIKyYF47aOmDSOt7HInFmSIYzkXj0MYd4aJmLoA/0u6bkb0QSTg7NGMEea
 NKPcdKfgoXYLqe+5yePsKKn3kKW6asi0BhKhbW3Ha7oTBWDJPfMdeRFr08RKR4yrfOvCD18MHP+
 LaykZZDJbwloaC7OflnhHUtI3wtb4yuVz71AnBDw5RW9FdHRCvvuroWzIqxmCBzURpZ+v2ib/gt
 sGLCR5ukdJdx4cFEDccQ0sW1oTH2o9ILqNr8jUZKULVhFcUgHvLtp8b0VvbCKpCIIB4ejy5B546
 mwWppV/UakYAAKe6yT4D7ewhGssLaIUxWLbHvIZwPP94ddzyOfjo2ajvb5pGZhIZWN0i0qjWXCX
 XPNUrZ5C+L2nrnzOZi2qVuBIw2cKqxDc5Q2Fs8CuVEKAjPKTWQDEbhcdOzjX6SuEuaTx+z6A0rw
 cXvjbQ+QkxhjFo3UkU=
X-Received: by 2002:a05:7022:7e0b:b0:149:7f69:a3ad with SMTP id
 a92af1059eb24-17ab5e9bb8bmr5881039c88.13.1791971124955; 
 Wed, 14 Oct 2026 02:45:24 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:45:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 33/34] system/vl: handle cpu/device help properly for
 multi-target qemu
Date: Wed, 14 Oct 2026 17:41:48 +0800
Message-ID: <20261014094224.1976-18-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This achieved by select the target by provided -machine $type option.
Error when anything wrong.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 system/vl.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 5d6ba08b591..bad13393f24 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1278,6 +1278,18 @@ static MachineClass *machine_target_select(GSList *machines, GSList **targets,
 
 static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
 {
+    const char *driver = qemu_opt_get(opts, "driver");
+
+    if (target_combined_binary() && driver &&
+        (is_help_option(driver) || qemu_opt_has_help_opt(opts))) {
+        const char *name = qdict_get_try_str(machine_opts_dict, "type");
+
+        g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE,
+                                                         false);
+        g_autoptr(GSList) targets = NULL;
+
+        machine_target_select(machines, &targets, name, &error_fatal);
+    }
     return qdev_device_help(opts);
 }
 
@@ -2761,9 +2773,24 @@ static void qemu_process_help_options(void)
      * Check for -cpu help and -device help before we call select_machine(),
      * which will return an error if the architecture has no default machine
      * type and the user did not specify one, so that the user doesn't need
-     * to say '-cpu help -machine something'.
+     * to say '-cpu help -machine something' in single-target binaries.
      */
     if (cpu_option && is_help_option(cpu_option)) {
+        if (target_combined_binary()) {
+            const char *name = qdict_get_try_str(machine_opts_dict, "type");
+
+            if (!name) {
+                error_report("-cpu help requires -machine "
+                             "<arch>-<machine-name> or an unambiguous "
+                             "<machine-name> in a combined binary");
+                exit(EXIT_FAILURE);
+            }
+            g_autoptr(GSList) machines =
+                object_class_get_list(TYPE_MACHINE, false);
+            g_autoptr(GSList) targets = NULL;
+
+            machine_target_select(machines, &targets, name, &error_fatal);
+        }
         list_cpus();
         exit(0);
     }
-- 
2.55.0.windows.3


