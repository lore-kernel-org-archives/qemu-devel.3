Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311FF1091931
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYH-0001Lu-FD; Thu, 19 Mar 2026 19:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYF-0001Kq-8n
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYC-0001OR-II
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773961990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Axexr4nRjKns5fsn4ynrhRhMuqETMedeAXqgk/hH6Hs=;
 b=SBZbsRmAbKhvHu5e3qDinltpnJZHCq/bq7u/xMcc+cKRLD7BGxdH97RcSLT3+vdf0dY1/N
 jNtPkwVioTdZnOELm6vfcCAhslW5mcJqcTo/T0Pw2XthzBuT8AOsDd0SuOrPOWxER9sZq8
 VV4R45PCAArU+XaAIraa9468dLzGP6E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-1slVfL4XO9atlxfeQN2Unw-1; Thu, 19 Mar 2026 19:13:08 -0400
X-MC-Unique: 1slVfL4XO9atlxfeQN2Unw-1
X-Mimecast-MFC-AGG-ID: 1slVfL4XO9atlxfeQN2Unw_1773961988
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5093b92f327so78101731cf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773961986; x=1774566786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Axexr4nRjKns5fsn4ynrhRhMuqETMedeAXqgk/hH6Hs=;
 b=e2MjU2eKn22xRXtcpsEP8PO3jcvscaheC3/X72kjYhBKZiWsyuIWZhMMBW1AWELCx2
 6iDKYtmQYIZetQc2Y8SLErU0bDrZe4yROhsly4UwFCB7tni5yYAMFALgox7RQWNxQONk
 nl+brdZny0cIYulVIDhM/RwHtPctiXz74U58XyDGJQLK6wDd+4p+BHiFbB89bpMDTSVp
 aGDwi7/bic2YZEicJb978gB+AiTKsPce/jpdA67qcg0ZITxS0JkTW527H9uPw+MIA0yX
 neHS2tvXM3nYCzKuhukVCd+BoYlyNmDWqNrlEV4jiyvnKGKYkVhTwDsPvH3Ac7aUlE58
 7bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773961986; x=1774566786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Axexr4nRjKns5fsn4ynrhRhMuqETMedeAXqgk/hH6Hs=;
 b=ab3O7Cn6R1pmBR/xtqBYQijX75+mvT03ubb2VN0CGNVJcOeYWbINMY1uqSLKbr9Wf4
 rwAan1jsM42P8xpVZP9s65cRmhhi0WCn2k00mOCbqExSQTuzjw4DmRIDriI1cNr+9ZM0
 7BO/HG5V2k2u8nX0ke0pkwdBDnSdQeq0RHq+vRmThZ+Edi3IZX+KShD5B00CWhuzJPLS
 8ltUY3jziiOGdnskFtlmEQGj50fTcdojCRqXvimzoHq6QXu+Ded0x9wzKyWhg9+Tkbkc
 EiAjL6913gIs9TMiEsA70yK2Jmfanc6gPLLnOT3QxLfrPr9Ref3w6bvXunqAwoBlzy9i
 Rfqw==
X-Gm-Message-State: AOJu0YwLFuDkj0gb/ckhPmk+DT9WdYxHcYOhSwtuEpZkLeJA7r+bLAMT
 HWxJnyOyg0Kug6th9zJ5/41KOZ3WXIVLU/iL2M99PFoQIQoEX06GrbcNK3VP0SX5VNQg0/V9iKg
 IqjRxdERDdrtExJZIJsvQYjmoU0TigAImjBrePKiOcTMK/gVQjeS8iRDasYko9krUcC0ytDGkEn
 dhenT9S4WpVReuIyzZ4xLYFbJ0K4rXvNOcXZPgGg==
X-Gm-Gg: ATEYQzx/FUp7z8ebslsJnqwTrRNVyRRFHmuWJWRq8zPi61sM4wtGN5DBtNx55VDFk1Q
 jN+TELglJpQlQbL5WOElDu7ti3Ubw7Q9zKzU/igMu+0FAf0N8G82UOSucU2l+MruxRTqWwuOADa
 73RTwZuRhpbXpf8hd6ekkAH9sXWz0ntJFWnOupcyNm33MSdyhTR9SFyKQn0NvuAIV2zXx/HnUxi
 S8QAuJiVyoyzuvtyFOvFht+BZt3/3gx74f0xboaQMB1ohpKwk1kLpJu0lSjXAFZ5tTqiWX7jwoR
 q/qLTuaDSBJutVxLlN+0prM88H3F9Mpel5ke846cVBheNPH++2zlYtwRdz432hzBFBPXno3KPQo
 FAn6VbcvUu97Jzg==
X-Received: by 2002:a05:622a:5c7:b0:509:379b:d42 with SMTP id
 d75a77b69052e-50b3744a456mr16340891cf.16.1773961985822; 
 Thu, 19 Mar 2026 16:13:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5c7:b0:509:379b:d42 with SMTP id
 d75a77b69052e-50b3744a456mr16339951cf.16.1773961985129; 
 Thu, 19 Mar 2026 16:13:05 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 00/12] migration/vfio: Fix a few issues on API misuse or
 statistic reports
Date: Thu, 19 Mar 2026 19:12:50 -0400
Message-ID: <20260319231302.123135-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2396755777

VFIO migration was merged quite a while, but we do still see things off
here and there.  This series tries to address some of them, but only based
on my limited understandings.

This is RFC series as I don't have VFIO devices to test.  So one can also
see this as a raw proposal on raising the issues first with a solution that
hasn't been well tested.  However I tested non-vfio side and so far no
issue I'm aware.

Two major issues I wanted to resolve here:

(1) VFIO reports state_pending_{exact|estimate}() differently

It reports stop-only sizes in exact() only (which includes both precopy and
stopcopy data), while in estimate() it only reports precopy data.  This is
violating the API.  The guess was it was done like it to trigger proper
sync on the VFIO ioctls only.  This series should fix it by introducing
stopcopy size reporting facility for vmstate handlers.

(2) expected_downtime doesn't take VFIO devices into account

When query migration, QEMU reports one field called "expected-downtime".
The document was phrasing this almost from RAM perspective, but ideally it
should be about an estimated blackout window (in milliseconds) if we
switchover anytime, based on known information.

This didn't yet took VFIO into account, especially in the case of VFIO
devices that may contain a large amount of device states (like GPUs).

For problem (2), the use case should be that an mgmt app when migrating a
VFIO GPU device needs to always adjust downtime for migration to converge,
because when it's involved normal downtime like 300ms will normally not
suffice.

Now the issue with that is the mgmt doesn't have a good way to know exactly
how well the precopy goes with the whole system and the GPU device.

The hope is fixing expected_downtime may at least provide one way for the
mgmt app so that it can monitor this field in query-migrate at the start of
each iteration (by enabling events) to guess the progress, and it also may
provide a relatively reasonable hint for downtime at least in case of GPUs.
For this part, I tested nothing, so it's only a guess for now, but that's
the wish it'll be something easier to use than before.

When without GPU, mgmt can also monitor this field (which so far is the
only global field that one can query) so as to know how iterations are
making progresses, so the mgmt should expect to see expected_downtime
shrinking over iterations, and when it stops shrinking for a few iterations
maybe it's wise to do something about it.

Tests or reviews will be very much welcomed.

Thanks,

Peter Xu (12):
  migration: Fix low possibility downtime violation
  migration/qapi: Rename MigrationStats to MigrationRAMStats
  vfio/migration: Throttle vfio_save_block() on data size to read
  vfio/migration: Cache stop size in VFIOMigration
  migration/treewide: Merge @state_pending_{exact|estimate} APIs
  migration: Use the new save_query_pending() API directly
  migration: Introduce stopcopy_bytes in save_query_pending()
  vfio/migration: Fix incorrect reporting for VFIO pending data
  migration: Make iteration counter out of RAM
  migration: Introduce a helper to return switchover bw estimate
  migration: Calculate expected downtime on demand
  migration: Fix calculation of expected_downtime to take VFIO info

 docs/about/removed-features.rst   |   2 +-
 docs/devel/migration/main.rst     |   5 +-
 docs/devel/migration/vfio.rst     |   9 +-
 qapi/migration.json               |   8 +-
 hw/vfio/vfio-migration-internal.h |   1 +
 include/migration/register.h      |  64 ++++++------
 migration/migration-stats.h       |  15 +--
 migration/migration.h             |   2 +-
 migration/savevm.h                |   7 +-
 hw/s390x/s390-stattrib.c          |   8 +-
 hw/vfio/migration.c               | 114 ++++++++++++---------
 migration/block-dirty-bitmap.c    |   9 +-
 migration/migration.c             | 159 +++++++++++++++++++++---------
 migration/ram.c                   |  39 ++------
 migration/savevm.c                |  37 ++-----
 hw/vfio/trace-events              |   3 +-
 migration/trace-events            |   1 +
 17 files changed, 254 insertions(+), 229 deletions(-)

-- 
2.50.1


