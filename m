Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5908C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma12-0005a0-Hc; Tue, 19 Mar 2024 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0n-0005XR-JJ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0m-00073G-7N
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyLoT4/X2VSgZE1XZV4i7NtHlsCtlGceszYE62vMHB8=;
 b=GWhRUqP75IXC3xJhgUYVxfnL+ChT14kq9jBHWRQVDIUqCE0FsS8YnGJs+E46FCe23p0+Rx
 Kdt658xbIdlR1eWPF2oJqyIYtA4+W+CjRwYQpUOk87ddI+nvHpmQfLx+WuOvIvWdLJvhCp
 hFikQWiF6fczRpryhi9MXWVZQxd82kk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-raTAmVKVPDqJRQ1jMG_oxw-1; Tue, 19 Mar 2024 10:00:12 -0400
X-MC-Unique: raTAmVKVPDqJRQ1jMG_oxw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56b9d738d09so334191a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856809; x=1711461609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyLoT4/X2VSgZE1XZV4i7NtHlsCtlGceszYE62vMHB8=;
 b=gExACt9zJT1j8CHZ3Z9INtAnu35arMhipDVsbAxwzowH+6b2bWelxR/zvhOdbPrZkY
 qBuj7qW00TPPdAQjOSUckkSD2SDb3K+6SzaDVGAgnOR4RPnj3EFwVXUt8CSwshDtG7zu
 dZOJuGIYPDjMfM40gMHFHlQPMgOYDS7vzib6p5u5dY/HrgtxHKTAhOKaqbsWF+X4AU/W
 924yT88fs5bwBKESHnOPizyCH9DYUxow83TznyJJih7CKkehxczFGEhWCBEyP+67CJFb
 zMdKublIZ9iYkv9/k4u5oGBLBBzyUwJTTgqNkbgedFYgbGWRustmrDF8SuBW/UkTr5oM
 468g==
X-Gm-Message-State: AOJu0YwcTtT8/UGGKyp2YRXCY2Rm/Q/O/SrY44zCVep1508NFQuxuZI1
 GEzHpaBt2L//+9VkaMTCFWd9+Y/gtOEdSYPFs/mVZKhGk9Tjviv41z4qEqPvEa1WJ8Noo+FQ0/G
 OlxiKiGJLfihKKIEAQV35xc+l/rZ7mgSSHQ1gP1xRezmOPb7TMcuWyoI7IcvGwHPzgxSWC0rNKO
 D1yX1C8zhKoFG7hZxOanKrcVBJ3iTFN1oOrq5h
X-Received: by 2002:a05:6402:2486:b0:566:c572:6fa0 with SMTP id
 q6-20020a056402248600b00566c5726fa0mr12535838eda.15.1710856809411; 
 Tue, 19 Mar 2024 07:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkJxPO5hyCghooEa2DxX0vp9RaVcO5TEjMwYHVK8wMEzzTb7Gn4A5TtAR6pmdwgE4lzGEnkw==
X-Received: by 2002:a05:6402:2486:b0:566:c572:6fa0 with SMTP id
 q6-20020a056402248600b00566c5726fa0mr12535811eda.15.1710856808992; 
 Tue, 19 Mar 2024 07:00:08 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 co24-20020a0564020c1800b00568c613570dsm3400577edb.79.2024.03.19.07.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 2/7] runstate: skip initial CPU reset if reset is not actually
 possible
Date: Tue, 19 Mar 2024 14:59:55 +0100
Message-ID: <20240319140000.1014247-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319140000.1014247-1-pbonzini@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Right now, the system reset is concluded by a call to
cpu_synchronize_all_post_reset() in order to sync any changes
that the machine reset callback applied to the CPU state.

However, for VMs with encrypted state such as SEV-ES guests (currently
the only case of guests with non-resettable CPUs) this cannot be done,
because guest state has already been finalized by machine-init-done notifiers.
cpu_synchronize_all_post_reset() does nothing on these guests, and actually
we would like to make it fail if called once guest has been encrypted.
So, assume that boards that support non-resettable CPUs do not touch
CPU state and that all such setup is done before, at the time of
cpu_synchronize_all_post_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index d6ab860ecaa..843e2b9853d 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -501,7 +501,20 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
     }
-    cpu_synchronize_all_post_reset();
+
+    /*
+     * Some boards us the machine reset callback to point CPUs to the firmware
+     * entry point.  Assume that this is not the case for boards that support
+     * non-resettable CPUs (currently used only for confidential guests), in
+     * which case cpu_synchronize_all_post_init() is enough because
+     * it does _more_  than cpu_synchronize_all_post_reset().
+     */
+    if (cpus_are_resettable()) {
+        cpu_synchronize_all_post_reset();
+    } else {
+        assert(runstate_check(RUN_STATE_PRELAUNCH));
+    }
+
     vm_set_suspended(false);
 }
 
-- 
2.44.0


