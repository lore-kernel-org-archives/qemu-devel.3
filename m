Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B29D74942
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tZk-0002Mh-WF; Tue, 29 Oct 2024 17:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZa-0002Lg-KJ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZY-0007c6-0g
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=86RBqmSukf/9+sijE7cB2yS2uPB9cqKNvkRro1SRjh4=;
 b=FzRAXZLFeHr/euwTa/+VlCEHnGAmtMhJSqu0/pqvWA5PdTiKlPkRpS+ORf2tF6N3Wx/lOd
 wPqL+WUOvacZJ7MrPCrjWcQ3WcY4BcVYmTNZnpoqnPzeQU54vEBkqrK4aoTd3rhj2OqKWa
 nLMENnDkCzRW18uK2ZUN3pAw/7+wPUE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Iz3XicskPBe-gCSAR_01mw-1; Tue, 29 Oct 2024 17:16:12 -0400
X-MC-Unique: Iz3XicskPBe-gCSAR_01mw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460c368028eso92799341cf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236571; x=1730841371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=86RBqmSukf/9+sijE7cB2yS2uPB9cqKNvkRro1SRjh4=;
 b=vHXrym+jip53GOJ+v9wylwlMKz5kD8dmb61rsVPAwTNh+LqRDOdH9V9AM6v8lfwtZY
 1ks+rKMYbYdOl81HY4maKvl3wo8dEC/jACBQSMjhfmkXZuOSVwnky4qR8fE0hx9pMu77
 tG6MlpZK1f0kGQdjhLl8lA/HBdzBycluAc6edp/RtplfPYhKJni8tOVo7FfROC2QyoNs
 aqCeSdEb2D5onTpK/i33bXy3v6vYgHPFvdtWbXHYH4VcCtCUDT59rqkl+ywaV8vwGMib
 0NegX8kHFe4j4GSApKQC3Lk3dFv+Ilj47yTBPFnJuE+92NQJgH3tZhatR90mvNfzQhCo
 MtfA==
X-Gm-Message-State: AOJu0Yy3tnVLcEkQFY8rBzYfDptzS/lefTlM3yC2lYiVNyxz4IJ5ZiLQ
 5iK4/0BDzf04f7oDLxXqus1yQEk8k62DjetkJ+bHf9mgUofzVqrGaFzmPTrWiIpPrFb+Smy/yRv
 1aGSo9O1qsh7tJKp6AtPuFC9Qw2qKb9luf+qnvwAHL4Qt1TTeg9kNY6+38uVdI08Ad/JsqrW5nV
 3qMWa0eZMdmc4cPWYtHU8Fncyhnlz6zqiIig==
X-Received: by 2002:a05:622a:408:b0:461:6157:99d0 with SMTP id
 d75a77b69052e-4616157a277mr77540271cf.41.1730236571194; 
 Tue, 29 Oct 2024 14:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS8tl83vLhh2e2heMDhYib41L9C8qCeveEt84llZ0oVUuIYIS8WpsDbgu5KiMW84yRJk+wWQ==
X-Received: by 2002:a05:622a:408:b0:461:6157:99d0 with SMTP id
 d75a77b69052e-4616157a277mr77539791cf.41.1730236570584; 
 Tue, 29 Oct 2024 14:16:10 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 0/7] QOM: Singleton interface
Date: Tue, 29 Oct 2024 17:16:00 -0400
Message-ID: <20241029211607.2114845-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com

This patchset introduces the singleton interface for QOM.  I didn't add a
changelog because there're quite a few changes here and there, plus new
patches.  So it might just be easier to re-read, considering the patchset
isn't large.

I switched v2 into RFC, because we have reviewer concerns (Phil and Dan so
far) that it could be error prone to try to trap every attempts to create
an object.  My argument is, if we already have abstract class, meanwhile we
do not allow instantiation of abstract class, so the complexity is already
there.  I prepared patch 1 this time to collect and track all similar
random object creations; it might be helpful as a cleanup on its own to
deduplicate some similar error messages.  Said that, I'm still always open
to rejections to this proposal.

I hope v2 looks slightly cleaner by having not only object_new_allowed()
but also object_new_or_fetch().

Patch layout:

Patch 1-2:        The patches to introduce QOM singleton interface
Patch 3-5:        Add support for vIOMMU singleton, some qdev change needed
Patch 6-7:        Add support for migration singleton, fix dangle pointer

Below are copy-paste of the commit message of patch 2, that I could have
put into the cover letter too.

====8<====

The singleton interface declares an object class which can only create one
instance globally.

Backgrounds / Use Cases
=======================

There can be some existing classes that can start to benefit from it.  One
example is vIOMMU implementations.

QEMU emulated vIOMMUs are normally implemented on top of a generic device,
however it's special enough to normally only allow one instance of it for
the whole system, attached to the root complex.

These vIOMMU classes can be singletons in this case, so that QEMU can fail
or detect yet another attempt of creating such devices for more than once,
which can be fatal errors to a system.

We used to have some special code guarding it from happening.  In x86,
pc_machine_device_pre_plug_cb() has code to detect when vIOMMU is created
more than once, for instance.  With singleton class, logically we could
consider dropping the special code, but start to rely on QOM to make sure
there's only one vIOMMU for the whole system emulation.

There is a similar demand raising recently (even if the problem existed
over years) in migration.

Firstly, the migration object can currently be created randomly, even
though not wanted, e.g. during qom-list-properties QMP commands.  Ideally,
there can be cases where we want to have an object walking over the
properties, we could use the existing migration object instead of
dynamically create one.

Meanwhile, migration has a long standing issue on current_migration
pointer, where it can point to freed data after the migration object is
finalized.  It is debatable that the pointer can be cleared after the main
thread (1) join() the migration thread first, then (2) release the last
refcount for the migration object and clear the pointer.  However there's
still major challenges [1].  With singleton, we could have a slightly but
hopefully working workaround to clear the pointer during finalize().

Design
======

The idea behind is pretty simple: any object that can only be created once
can now declare the TYPE_SINGLETON interface. Then, QOM facilities will
make sure it won't be created more than once for the whole QEMU lifecycle.
Whenever possible (e.g., on object_new_allowed() checks), pretty error
message will be generated to report an error.  QOM also guards at the core
of object_new() so that any further violation of trying to create a
singleton more than once will crash QEMU as a programming error.

For example, qom-list-properties, device-list-properties, etc., will be
smart enough to not try to create temporary singleton objects if the class
is a singleton class and if there's existing instance created.  Such usages
should be rare, and this patch introduced object_new_or_fetch() just for
it, which either create a new temp object when available, or fetch the
instance if we found an existing singleton instance.  There're only two
such use cases.

Meanwhile, we also guard device-add or similar paths using the singleton
check in object_new_allowed(), so that it'll fail properly if a singleton
class instantiate more than one object.

Glib Singleton implementation
=============================

One note here to mention the Glib implementation of singletons [1].

QEMU chose not to follow Glib's implementation because Glib's version is
not thread safe on the constructor, so that two concurrent g_object_new()
on a single can race.  It's not ideal to QEMU, as QEMU has to not only
support the event-driven context which is normally lock-free, but also
the case where threads are heavily used.

It could be QEMU's desire to properly support multi-threading by default on
such new interface.  The "bad" side effect of that is, QEMU's object_new()
on singletons can assert failures if the singleton existed, but that's also
part of the design so as to forbid such from happening, taking which as a
programming error.  Meanwhile since we have pretty ways to fail elsewhere
on qdev creations, it should already guard us in a clean way, from anywhere
that the user could try to create the singleton more than once.

The current QEMU impl also guarantees object_new() always return a newly
allocated object as long as properly returned, rather than silently return
an existing object as what Glib's impl would do.  I see it a benefit, so as
to avoid unknown caller manipulate a global object, wrongly assuming it was
temporarily created.

[1] https://lore.kernel.org/qemu-devel/20190228122822.GD4970@work-vm/
[2] https://lore.kernel.org/r/ZxtqGQbd4Hq4APtm@redhat.com

Thanks,

Peter Xu (7):
  qom: Track dynamic initiations of random object class
  qom: TYPE_SINGLETON interface
  qdev: Make device_set_realized() be fully prepared with !machine
  qdev: Make qdev_get_machine() safe before machine creates
  x86/iommu: Make x86-iommu a singleton object
  migration: Make migration object a singleton object
  migration: Reset current_migration properly

 qapi/qdev.json                  |  2 +-
 qapi/qom.json                   |  2 +-
 include/qom/object.h            | 25 ++++++++++++++++
 include/qom/object_interfaces.h | 51 +++++++++++++++++++++++++++++++++
 chardev/char.c                  |  4 +--
 hw/core/cpu-common.c            | 13 ++++++---
 hw/core/qdev.c                  | 20 +++++++++++--
 hw/i386/x86-iommu.c             | 26 +++++++++++++++--
 migration/migration.c           | 36 +++++++++++++++++++++--
 qom/object.c                    | 50 ++++++++++++++++++++++++++++++--
 qom/object_interfaces.c         | 33 +++++++++++++++++++--
 qom/qom-qmp-cmds.c              |  4 +--
 system/qdev-monitor.c           |  4 +--
 13 files changed, 243 insertions(+), 27 deletions(-)

-- 
2.45.0


