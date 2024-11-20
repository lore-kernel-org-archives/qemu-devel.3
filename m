Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D966D743E7
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshP-0008CY-Kf; Wed, 20 Nov 2024 16:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshM-0008CK-7I
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshD-0006L0-23
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eD7+FugkD5uxWKXsl4KP6FXPPjpqepru+nhpsPr60gw=;
 b=hj3w4p9hXQzsZcBx0lh0ndPQY3oGFHxhqJXAYuKDBZU3cuc0YqTiM/MX413Ux+yByJiCu6
 9+eGckEEbdcXPhU534iDe/3wxfXImEGlUeSpM/ObogKkCsPOGfT0adg9F9An44e1lSrK1a
 jAHaCnI2CWVwJdcC7eNAh9hZzFEqJy4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-PfW5_WV8NuON98Fmp3ZC2w-1; Wed, 20 Nov 2024 16:57:08 -0500
X-MC-Unique: PfW5_WV8NuON98Fmp3ZC2w-1
X-Mimecast-MFC-AGG-ID: PfW5_WV8NuON98Fmp3ZC2w
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460dd31b4c1so3148451cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139827; x=1732744627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eD7+FugkD5uxWKXsl4KP6FXPPjpqepru+nhpsPr60gw=;
 b=ZDA78RBo69Jvnu/dwNdOBo6S+pOrlFtfMaIpCkf06YJ6/N3frSeK9Ne+5rpCHUnurQ
 qARdfig2d35Sy9F8kecDN9mWIKGFbuWRaZOEFcWOfCBLo2vvx61outvLvooJkkJCThi7
 b9zkPlkCBMDK8azLfOIbzPakZ8rKMZkr7ZFPNwmkNhbqVNfotWk9dXEai1AWJH202ePR
 nIdxJ0jJBWS8L41cgkKz2v2gHrzt5kRLd4OjH7sSTTDyZjyOesvmsAX1xhwiVhil3Oc4
 MHyhSkzhJvpKnxJiJS/E8eIQSmDBDOvsgTEv+W3xGkuHaVEwJM184TsqlPASsQR1EEq+
 wqpA==
X-Gm-Message-State: AOJu0YyapzV+LZY2b3QP7FfDAISw509wiNXyJAs5aKc6kXSvjWKshAUz
 OWk6eKY9WqgeFEAgBNRQpsK538HYw93vfqpUwI6hThjEeX5Bcq1L1CBQQTR7yYnln+3AsGoehFV
 PtvgPqMPN9kNHgFgO/q6KnFvWxhst8zkzR6QMlqfMwLqZJw3JvrnMn9o+Dbe8lUJ883dxHRRI2B
 YvBBo2Rdzg4lCDP9Cnsow1/imn+1D7sQJkxg==
X-Received: by 2002:a05:622a:1e85:b0:460:be37:7fc9 with SMTP id
 d75a77b69052e-464858aa89fmr66028721cf.56.1732139827156; 
 Wed, 20 Nov 2024 13:57:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeu17J7WVKp1JOc/cT9DM+JoKQ2Ku0L6ttWOiat91K4TOkFCroJqMJFJRNE8Ud/vusRmCf7Q==
X-Received: by 2002:a05:622a:1e85:b0:460:be37:7fc9 with SMTP id
 d75a77b69052e-464858aa89fmr66028371cf.56.1732139826810; 
 Wed, 20 Nov 2024 13:57:06 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 00/12] QOM: container_get() removal
Date: Wed, 20 Nov 2024 16:56:51 -0500
Message-ID: <20241120215703.3918445-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series is not for 9.2, but for 10.0.  It is intended to replace this
previous patchset:

  [PATCH 0/5] QOM: Enforce container_get() to operate on containers only
  https://lore.kernel.org/r/20241118221330.3480246-1-peterx@redhat.com

Since it's a different patchset, the versioning starts from v1.

The series is about container_get() and its removal.  Meanwhile after the
whole series applied, all the containers will be created explicitly.  No
lookup code will implicitly create container anymore.

In general, container_get() is a flaky interface in a few things.  Firstly,
some of the users use it without getting a container object.  Secondly, it
can implicitly create containers on the fly.

As Dan (mostly) pointed out, we don't have a super complicated container
layout.  It looks like this:

  /objects
  /chardevs
  /backend         (conditional, ui/ only)
  /dr-connector    (conditional, ppc/ only)
  /machine
    /peripheral
    /peripheral-anon
    /unattached

This series create these containers explicitly.

There's a side benefit of dropping container_get(), which is to avoid
complicated string operations, as container_get() is never used in more
than one depth.  It means switching to object_resolve_path_component()
should make existing code even tiny little faster.

To achieve this, some test needs to be fixed first.  For that, "tests: Fix
test-qdev-global-props on anonymous qdev realize()".

Comments welcomed, thanks.

Peter Xu (12):
  qom: Add TYPE_CONTAINER macro
  qom: New container_create()
  tests: Fix test-qdev-global-props on anonymous qdev realize()
  tests: Explicitly create containers in test_qom_partial_path()
  ui/console: Explicitly create "/backend" container
  hw/ppc: Explicitly create the drc container
  ppc/e500: Avoid abuse of container_get()
  qdev: Make qdev_get_machine() not use container_get()
  qdev: Add machine_get_container()
  qom: Create system containers explicitly
  qom: Add object_get_container()
  qom: Drop container_get()

 include/hw/qdev-core.h              | 10 ++++++++
 include/qom/object.h                | 25 +++++++++++++-----
 backends/cryptodev.c                |  4 +--
 chardev/char.c                      |  2 +-
 hw/arm/stellaris.c                  |  2 +-
 hw/core/gpio.c                      |  3 +--
 hw/core/machine.c                   | 19 +++++++++++---
 hw/core/qdev.c                      | 28 +++++++++++++++++---
 hw/core/sysbus.c                    |  4 +--
 hw/i386/pc.c                        |  4 +--
 hw/pci-host/ppce500.c               |  4 +--
 hw/ppc/spapr_drc.c                  | 40 +++++++++++++++++++++--------
 qom/container.c                     | 31 ++++++++--------------
 qom/object.c                        | 30 +++++++++++++++++++---
 scsi/pr-manager.c                   |  4 +--
 system/ioport.c                     |  2 +-
 system/memory.c                     |  2 +-
 system/qdev-monitor.c               |  6 ++---
 system/vl.c                         |  3 +--
 tests/unit/check-qom-proplist.c     |  2 +-
 tests/unit/test-qdev-global-props.c | 21 +++++++++++++++
 ui/console.c                        |  4 +--
 ui/dbus-chardev.c                   |  2 +-
 23 files changed, 180 insertions(+), 72 deletions(-)

-- 
2.45.0


