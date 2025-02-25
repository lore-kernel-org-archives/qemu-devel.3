Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F9FC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL5-0002f2-9f; Tue, 25 Feb 2025 13:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ9-0008Kv-18
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ6-0002D5-Mp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so56629455e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506723; x=1741111523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y7p+aWd+dHKRzUy0HtF4GkLYr0x7T5CRvNgfUzf7AaQ=;
 b=l3O10drq4c6vAYSdeyeW02B6whuW0ofhOgONBnHTewQZDfkNZ6KsBU/vJEGil2tw2e
 J2tFqSauqMtRbfYJ2xVjPpfQU6Y3mnId9f5j0yVi3hmxUJbwAtCoCnbe5VqC6j0O0bMj
 GS7graAVdid6Nmd/miiS1U4XTqbc/YqnjNADci9wNSyJervM2zqyz2U0ESzE+mZErjNc
 yji1/lhUT0J2L3rFwRRGIQRficjC31pA4NFBI36WYYJig+NJr65sg80U26jTu+kUiZ70
 GSzAlad27f0feglEJV7uBmlwntrFKYfptjd1wn0G7EdbGkFRVf+Ozmg656lNGXnMcnEj
 meKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506723; x=1741111523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7p+aWd+dHKRzUy0HtF4GkLYr0x7T5CRvNgfUzf7AaQ=;
 b=j6sB5w0ZIHBiMyz56XQZFLJMHaRJVkHmigPqoQ/T9fbvzRf6MnmxbIQdgO44cJ2En3
 iY9aL+aiMTB+eZg+dIEnBPqvQw0ldiO3jDlAY/inCWu9azdxe3qyu/5+JdhbtCN0zxnU
 ZedLO6RzolnqGLfklr357dj+E544/dMIqJkamHZw41dutOJiLkEUR8BA3QcaqqDtG6KU
 vybjXtgFoXBSgJ5AoOBMW9JXzifoTx3zZ7vvTkb1DtZq34BBDbio/mr01iWFwNZqVCFW
 sgIQc7w945d4rWdBkfBayaPyDbhTWGPdG3S3qIfsoliqOmRFY3locaxQGYpUKMr+U9Bz
 IN5w==
X-Gm-Message-State: AOJu0YzBOg6X2TmoluShs2xXqMi7r4QI+xcTTrkEiSXAM2c9evnJnfCC
 AmD0DM5lcReKEEYDjwrDbcr5tuiH6VAJXD4sS6UBbS7cR2qJyVUqppGSDin9q61vRRPIRfDhlmL
 M
X-Gm-Gg: ASbGncvxxkQNrcTaCUfXGtUk9HWYzfKmMopfNrVyeCRtHzcWX2Lxd1EMpK3SiTdcK9W
 HN2kBdMTQMQw1YebLobKybVrdQ2tJz/DCkWLYUClpLgDSyAt53zRmj52vZs7tgCSrsm55FRKrIW
 weBXvRLIW+ibNaPUwdO2B6JW6Xo8sNIJagl/6qp7YDUcGSErsQhMCM4/ddeXKZ3SUADnGVyPnA0
 MbYrFo0i3fnxQUx/Pw6DY6GlWwcxk3ykyulDJwLZ50eSTwFYUFPBXbscC+kBASP6BhSnd0ni3i/
 30zGS+8o2cbwUQQFtrsQQnzNCVSW0i4+
X-Google-Smtp-Source: AGHT+IEghznzR2tOF+1GCIfYeqvIT6wOAC4OLGX0HM6rVpPVMZyNxOUioaJnzGpaI9lXEsonZaDRBA==
X-Received: by 2002:a05:600c:3ca1:b0:439:9595:c8e7 with SMTP id
 5b1f17b1804b1-439aea9d78bmr169642625e9.0.1740506722610; 
 Tue, 25 Feb 2025 10:05:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/43] hw/core/machine.c: Make -machine dumpdtb=file.dtb with
 no DTB an error
Date: Tue, 25 Feb 2025 18:04:34 +0000
Message-ID: <20250225180510.1318207-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently if the user requests via -machine dumpdtb=file.dtb that we
dump the DTB, but the machine doesn't have a DTB, we silently ignore
the option.  This is confusing to users, and is a legacy of the old
board-specific implementation of the option, where if the execution
codepath didn't go via a call to qemu_fdt_dumpdtb() we would never
handle the option.

Now we handle the option in one place in machine.c, we can provide
the user with a useful message if they asked us to dump a DTB when
none exists.  qmp_dumpdtb() already produces this error; remove the
logic in handle_machine_dumpdtb() that was there specifically to
avoid hitting it.

While we're here, beef up the error message a bit with a hint, and
make it consistent about "an FDT" rather than "a FDT".  (In the
qmp_dumpdtb() case this needs an ERRP_GUARD to make
error_append_hint() work when the caller passes error_fatal.)

Note that the three places where we might report "doesn't have an
FDT" are hit in different situations:

(1) in handle_machine_dumpdtb(), if CONFIG_FDT is not set: this is
because the QEMU binary was built without libfdt at all. The
build system will not let you build with a machine type that
needs an FDT but no libfdt, so here we know both that the machine
doesn't use FDT and that QEMU doesn't have the support:

(2) in the device_tree-stub.c qmp_dumpdtb(): this is used when
we had libfdt at build time but the target architecture didn't
enable any machines which did "select DEVICE_TREE", so here we
know that the machine doesn't use FDT.

(3) in qmp_dumpdtb(), if current_machine->fdt is NULL all we know
is that this machine never set it. That might be because it doesn't
use FDT, or it might be because the user didn't pass an FDT
on the command line and the machine doesn't autogenerate an FDT.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2733
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250206151214.2947842-7-peter.maydell@linaro.org
---
 hw/core/machine.c         | 6 ++----
 system/device_tree-stub.c | 5 ++++-
 system/device_tree.c      | 7 ++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 61c22f723a0..b68b8b94a3c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1702,15 +1702,13 @@ static void handle_machine_dumpdtb(MachineState *ms)
     if (!ms->dumpdtb) {
         return;
     }
-    if (!ms->fdt) {
-        /* Silently ignore dumpdtb option if there is nothing to dump */
-        return;
-    }
 #ifdef CONFIG_FDT
     qmp_dumpdtb(ms->dumpdtb, &error_fatal);
     exit(0);
 #else
     error_report("This machine doesn't have an FDT");
+    error_printf("(this machine type definitely doesn't use FDT, and "
+                 "this QEMU doesn't have FDT support compiled in)\n");
     exit(1);
 #endif
 }
diff --git a/system/device_tree-stub.c b/system/device_tree-stub.c
index bddda6fa37a..428330b0fec 100644
--- a/system/device_tree-stub.c
+++ b/system/device_tree-stub.c
@@ -5,6 +5,9 @@
 #ifdef CONFIG_FDT
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
-    error_setg(errp, "This machine doesn't have a FDT");
+    ERRP_GUARD();
+
+    error_setg(errp, "This machine doesn't have an FDT");
+    error_append_hint(errp, "(this machine type definitely doesn't use FDT)\n");
 }
 #endif
diff --git a/system/device_tree.c b/system/device_tree.c
index d605ed2a217..aa3fe9516f3 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -635,11 +635,16 @@ out:
 
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
+
     g_autoptr(GError) err = NULL;
     uint32_t size;
 
     if (!current_machine->fdt) {
-        error_setg(errp, "This machine doesn't have a FDT");
+        error_setg(errp, "This machine doesn't have an FDT");
+        error_append_hint(errp,
+                          "(Perhaps it doesn't support FDT at all, or perhaps "
+                          "you need to provide an FDT with the -fdt option?)\n");
         return;
     }
 
-- 
2.43.0


