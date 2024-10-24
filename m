Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11528CE8E97
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 16:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t418j-0003ty-Fj; Thu, 24 Oct 2024 12:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418W-0003tY-Ni
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418U-0002wH-EC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729788992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xhoeZAeAUJ0vVZG8BNDrkd5Y3damWs5M1drniCecIAY=;
 b=S+No5dZ0zbQFeMOrQU2H8qWv5zmbL0FToj9N1WMmcxSCD85ve5ja0ZkTha+b87wG91hkrO
 ixttpBPSazi6ug/XjbZkC22QvHujX6tWbii8yq9pATzgJ64SzOQLDJU1GfVOAlqKdfxqxJ
 WGoq9BaxtNIkspVpn/JyeiHavDIwSZg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-j9wF9bBsM1i2GnHzMKAzfw-1; Thu, 24 Oct 2024 12:56:31 -0400
X-MC-Unique: j9wF9bBsM1i2GnHzMKAzfw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cdf0589e8aso15306636d6.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 09:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788990; x=1730393790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhoeZAeAUJ0vVZG8BNDrkd5Y3damWs5M1drniCecIAY=;
 b=kPIPvwYDmYbtZC6xEu47Su5jqepRyCure3Yw/0yzHKWZ+hfcTU8DgNeekovJkG6zkt
 O6jwrJDLGFV3g4Yg1wSku80+L0hSf7KMO1hywlmnYMM+ZbtAzFwSnqsokmShRM9Mq0t5
 izlGKibKiPI4S7stiN0/F7XD1IaogfuqKFlQmzTLebk/Z12BEOkU7LYqS9GTyg+Cc8B4
 iXnJwKvRFwBdaFXcuGFX7mGm2TQ85Af0Yd3YJtPNotjGhpRmSwEevIWG/l8F/Y/Ajucs
 YRVgeCeavgjCK7Xp8KveXNoxJjcchngWhijAZnhyJWB8X+DYnERdJZkKux4dpobLcs+9
 V9OA==
X-Gm-Message-State: AOJu0YxsO6Mwu0x/2vO2UhYUCHYI24xYEA0IZADgKeLwWWVYwynLSc0A
 pwXvJm5QMqzXe4S9ys8K+TP9gP/UXACpGJakXCi3/LEwMWTnU0qj0Xc9tDYd1cOz/uNR+po/zo/
 JLCcQqJj2plrerMfyMWIng93ycuVTKWH9u1LZyKrdJEpz8yYmU04g+C+bArNuKsWcb8oePmr9uu
 opyWM06cxiwF7xctRWzNNXbFxZnDnKv2fy0g==
X-Received: by 2002:a05:6214:5b0d:b0:6ce:2357:8a36 with SMTP id
 6a1803df08f44-6ce34138477mr93918556d6.7.1729788990059; 
 Thu, 24 Oct 2024 09:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/7yVfaJSnJgF8yN01qn335V7pmFHlBdV+bE1WZ6MPxTxERlrArd6dxxZzGYR8BSIwz4kW8w==
X-Received: by 2002:a05:6214:5b0d:b0:6ce:2357:8a36 with SMTP id
 6a1803df08f44-6ce34138477mr93918186d6.7.1729788989631; 
 Thu, 24 Oct 2024 09:56:29 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aff31sm51871076d6.12.2024.10.24.09.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 09:56:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/4] QOM: Singleton interface
Date: Thu, 24 Oct 2024 12:56:23 -0400
Message-ID: <20241024165627.1372621-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patchset introduces the singleton interface for QOM.

The singleton interface is as simple as "this class can only create one
instance".

We used to have similar demand when working on all kinds of vIOMMUs,
because in most cases that I am aware of, vIOMMU must be a singleton as
it's closely bound to the machine and also the root PCIe systems.  We used
to have a bunch of special code guarding those, for example, X86 has
pc_machine_device_pre_plug_cb() just to detect when vIOMMU is created more
than once.

There is a similar demand raising recently (even if the problem existed
over years) when we were looking at a migration bug, that part of it was
involved with the current_migration global pointer being referenced
anywhere, even after the migration object was finalize()ed.  So far without
singleton support, there's no way to reset the variable properly.
Declaring migration object to be a singleton also just makes sense, e.g.,
dynamically creating migration objects on the fly with QMP commands doesn't
sound right..

The idea behind is pretty simple: any object that can only be created once
can now declare the TYPE_SINGLETON interface, then QOM facilities will make
sure it won't be created more than once.  For example, qom-list-properties,
device-list-properties, etc., will be smart enough to not try to create
temporary singleton objects now.  Meanwhile, we also guard device-add paths
so that it'll fail properly if it's created more than once (and iff it's a
TYPE_DEVICE first).

The 1st patch introduces the QOM interface, while I made both x86-iommu and
migration as the initial users of it, so it's really more about the 1st
patch to discuss first.  I didn't yet touch ARM/SMMU as it's also more
complicated; I also didn't yet dig anything else that may apply, but I do
feel like this can apply more than the two attached here.  Hopefully the
two use cases can be good enough to start the discussion.

Thanks,

Peter Xu (4):
  qom: TYPE_SINGLETON interface
  x86/iommu: Make x86-iommu a singleton object
  migration: Make migration object a singleton object
  migration: Reset current_migration properly

 include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
 hw/i386/x86-iommu.c             | 14 ++++++++++
 migration/migration.c           | 36 ++++++++++++++++++++++---
 qom/object.c                    |  3 +++
 qom/object_interfaces.c         | 24 +++++++++++++++++
 qom/qom-qmp-cmds.c              | 22 ++++++++++++---
 system/qdev-monitor.c           |  7 +++++
 7 files changed, 147 insertions(+), 6 deletions(-)

-- 
2.45.0


