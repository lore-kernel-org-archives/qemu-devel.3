Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E065DC54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaK-0002FP-K8; Sun, 17 Mar 2024 16:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaI-0002EI-76
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaG-0002bn-A6
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zbw8biRkRCNaWvBEX3kRfgYXQbqsFbG3GajvMEGhTg=;
 b=OP7p5NUeEgHANowWLTOP24vqn0HTA0qYWb0Ii0X0+1X3FgXHlsuS99Oz1v9TUM5GhI4T21
 YXzuZrl0aw5ViAHAvavhZ3GxDdZWk07zeYr3+14bQSu9cIEbLUXHOKLHrfvxbv3YuQ5PwT
 BLGsdHezPkyYLjWKESsccUgADLUSU0Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-QxcSPclsPCCA3pOj07GZRg-1; Sun, 17 Mar 2024 16:58:18 -0400
X-MC-Unique: QxcSPclsPCCA3pOj07GZRg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42f30752eb4so12381511cf.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709097; x=1711313897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Zbw8biRkRCNaWvBEX3kRfgYXQbqsFbG3GajvMEGhTg=;
 b=ZqRHp7SwVMhd3V/uOjvHaQKRzh6u/HHG5+254H1KqpU5Lo+43iEgeewIRt28DqJ/8o
 lj/Qjmu2IfBs2/UMP8Cfml287yy4ijKHcUKlq4PHzdRJZO5TLaAkfBLSaRvsYFu8Unat
 DJ+kHn4Ra6gTt/P9EbEMZL30xkZceSQJy5Z/ODxwTxJsp9BXcMxBy4gywN280LY3uLGV
 jg/gg3POLsb/Ivv3n84GFn7PtjQLlLlypkreblM0J4OcLYyU9Wh+zMG+147AEKcNP5I0
 gSqJ5PkGP2BpwSqlZkc0AxD2jJGbXYR0Mrf5IWI2kNhQV8O2gAF/v+HGYCDj4SLoafgz
 TLQA==
X-Gm-Message-State: AOJu0YyvaANCuLCHIA967cYmhns5KGs2gHBhYcH47gB53U3dT/j7yVE9
 SYGWTYujOKgRdH+MQz13tvRpMwQSZKw9tCPuAEfySAespcYCyLzEANhor2LJCqe8gcG5xoqjnRv
 J/iIHWNF+yDEGUJxgbPyxTdEd3MY6fUeD9h+aPg7aur/9NXuP1ZrTpP4Yv9eQQiQwReVsdNlVQq
 wk6it7cJwtM6HiUYrnQ8xegtjQ0wFxQQJxJA==
X-Received: by 2002:a05:6214:2d42:b0:690:a71a:d381 with SMTP id
 na2-20020a0562142d4200b00690a71ad381mr11999334qvb.6.1710709097266; 
 Sun, 17 Mar 2024 13:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUlM9mFsY1L2Q7I0bhBrBvjJxHwIfvQhOwmr0mtE19T6XD/oeuPcANkW2nQ9XgtghdTO3Yvw==
X-Received: by 2002:a05:6214:2d42:b0:690:a71a:d381 with SMTP id
 na2-20020a0562142d4200b00690a71ad381mr11999306qvb.6.1710709096758; 
 Sun, 17 Mar 2024 13:58:16 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:16 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/10] migration: cpr-reboot documentation
Date: Sun, 17 Mar 2024 16:58:00 -0400
Message-ID: <20240317205803.361163-8-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1710338119-330923-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/CPR.rst      | 147 ++++++++++++++++++++++++++++++
 docs/devel/migration/features.rst |   1 +
 2 files changed, 148 insertions(+)
 create mode 100644 docs/devel/migration/CPR.rst

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
new file mode 100644
index 0000000000..63c36470cf
--- /dev/null
+++ b/docs/devel/migration/CPR.rst
@@ -0,0 +1,147 @@
+CheckPoint and Restart (CPR)
+============================
+
+CPR is the umbrella name for a set of migration modes in which the
+VM is migrated to a new QEMU instance on the same host.  It is
+intended for use when the goal is to update host software components
+that run the VM, such as QEMU or even the host kernel.  At this time,
+cpr-reboot is the only available mode.
+
+Because QEMU is restarted on the same host, with access to the same
+local devices, CPR is allowed in certain cases where normal migration
+would be blocked.  However, the user must not modify the contents of
+guest block devices between quitting old QEMU and starting new QEMU.
+
+CPR unconditionally stops VM execution before memory is saved, and
+thus does not depend on any form of dirty page tracking.
+
+cpr-reboot mode
+---------------
+
+In this mode, QEMU stops the VM, and writes VM state to the migration
+URI, which will typically be a file.  After quitting QEMU, the user
+resumes by running QEMU with the ``-incoming`` option.  Because the
+old and new QEMU instances are not active concurrently, the URI cannot
+be a type that streams data from one instance to the other.
+
+Guest RAM can be saved in place if backed by shared memory, or can be
+copied to a file.  The former is more efficient and is therefore
+preferred.
+
+After state and memory are saved, the user may update userland host
+software before restarting QEMU and resuming the VM.  Further, if
+the RAM is backed by persistent shared memory, such as a DAX device,
+then the user may reboot to a new host kernel before restarting QEMU.
+
+This mode supports VFIO devices provided the user first puts the
+guest in the suspended runstate, such as by issuing the
+``guest-suspend-ram`` command to the QEMU guest agent.  The agent
+must be pre-installed in the guest, and the guest must support
+suspend to RAM.  Beware that suspension can take a few seconds, so
+the user should poll to see the suspended state before proceeding
+with the CPR operation.
+
+Usage
+^^^^^
+
+It is recommended that guest RAM be backed with some type of shared
+memory, such as ``memory-backend-file,share=on``, and that the
+``x-ignore-shared`` capability be set.  This combination allows memory
+to be saved in place.  Otherwise, after QEMU stops the VM, all guest
+RAM is copied to the migration URI.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-reboot``.
+  * Set the ``x-ignore-shared`` capability if desired.
+  * Issue the ``migrate`` command.  It is recommended the the URI be a
+    ``file`` type, but one can use other types such as ``exec``,
+    provided the command captures all the data from the outgoing side,
+    and provides all the data to the incoming side.
+  * Quit when QEMU reaches the postmigrate state.
+
+Incoming:
+  * Start QEMU with the ``-incoming defer`` option.
+  * Set the migration mode parameter to ``cpr-reboot``.
+  * Set the ``x-ignore-shared`` capability if desired.
+  * Issue the ``migrate-incoming`` command.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Example 1
+^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
+  ...
+
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate -d file:vm.state
+  (qemu) info status
+  VM status: paused (postmigrate)
+  (qemu) quit
+
+  ### optionally update kernel and reboot
+  # systemctl kexec
+  kexec_core: Starting new kernel
+  ...
+
+  # qemu-kvm ... -incoming defer
+  (qemu) info status
+  VM status: paused (inmigrate)
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: running
+
+Example 2: VFIO
+^^^^^^^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
+  -device vfio-pci, ...
+  -chardev socket,id=qga0,path=qga.sock,server=on,wait=off
+  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
+  ...
+
+  (qemu) info status
+  VM status: running
+
+  # echo '{"execute":"guest-suspend-ram"}' | ncat --send-only -U qga.sock
+
+  (qemu) info status
+  VM status: paused (suspended)
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate -d file:vm.state
+  (qemu) info status
+  VM status: paused (postmigrate)
+  (qemu) quit
+
+  ### optionally update kernel and reboot
+  # systemctl kexec
+  kexec_core: Starting new kernel
+  ...
+
+  # qemu-kvm ... -incoming defer
+  (qemu) info status
+  VM status: paused (inmigrate)
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: paused (suspended)
+  (qemu) system_wakeup
+  (qemu) info status
+  VM status: running
+
+Caveats
+^^^^^^^
+
+cpr-reboot mode may not be used with postcopy, background-snapshot,
+or COLO.
diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 9d1abd2587..d5ca7b86d5 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -11,3 +11,4 @@ Migration has plenty of features to support different use cases.
    vfio
    virtio
    mapped-ram
+   CPR
-- 
2.44.0


