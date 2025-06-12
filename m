Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4815DC7113E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 06:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPbdU-0002DP-1d; Thu, 12 Jun 2025 02:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uPbdJ-0002Cx-Dk
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uPbdF-0008WB-Hj
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749710507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9oX/ZhOdSK1om/XJmdHljtxwDcqvE/owxEk9/P+n+U=;
 b=EK9aO9L/4RuWqKzZYo24OeYrrMUD5nx68fPTtOggyC73o6J0QtiYkNb9+oujOaZaZuSQGf
 YyPFhG861XzReNbbhzGwek12G5Tex83Aywe91LGdqsZGGZa9qfNItKw4uPtvw7Ln0LxYul
 PfPNJzXblvzPAt5p/Z+YzYSQht9ySsE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-PAEilAN-MWm7ZNKuWtLSrg-1; Thu, 12 Jun 2025 02:41:46 -0400
X-MC-Unique: PAEilAN-MWm7ZNKuWtLSrg-1
X-Mimecast-MFC-AGG-ID: PAEilAN-MWm7ZNKuWtLSrg_1749710505
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-32b37b118a3so774951fa.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 23:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749710504; x=1750315304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9oX/ZhOdSK1om/XJmdHljtxwDcqvE/owxEk9/P+n+U=;
 b=eY2SxOXfz2JBQS0qImaR/g2NSaSwxgqXx26cfzjL3u3WIL9Y22onKWmteirOJG3pDO
 omAUJqgTLfsx/i3SWjc2kO/6NKBaKxiWqWpatvWoVWDfOgSeEn8jpk54qwEnnDhhlF2G
 pgFFAE7QMGybUe8v9XHbHgVJ2F59PN5ITE/7780egxlHE+7S075heEbYiKtJ8OiCHJGr
 gDnm3IRzbWl1p/OUpcj+t+4rMfByOll+LHhKSp2lY84TZRcMHLJ0OrU5qek5UZJYUFti
 5nfGs6igsWf1I1zEJcWzLxJX7CH88KxmHnLKeeZ9rZ+myytbRptd6TXufQzUMykTa4PX
 UzIA==
X-Gm-Message-State: AOJu0YwdXdG0/8pF0961T7Ir0sdZk5d6/OitFRipiHoOZK+zdZ44CLNK
 WMi5cSi5BVNKWR0z97jvajxP0wNLk34+VSFP07+gkGryInHOgoMXJPGnNJRh9t/JCvRfYj8PidQ
 T82D+8VQGnHqrMtcQBJcjIKgYsbyMUvMCdq6tXqi+TAe6MNq7sTB0CsrJtHiwsnmQqS2sRZ173c
 NqhKDiDFRghfj7o5Y5xsJnRUCRok4USAA=
X-Gm-Gg: ASbGnct3WeNhjrg31g+7OjL5mhCAjl6mvfmIJuVzaz64ApVl/9J4WKOFZA9SKDFpoob
 Z56gFXqknDvuUQBCPXGAilff/HpP0siFsTQcoV6rRRwmyAnJuWDmgWGZkOyfVYYiT2Tj4kna5z8
 U8CX8=
X-Received: by 2002:a05:651c:1986:b0:32b:3437:7e8d with SMTP id
 38308e7fff4ca-32b343781eamr2794811fa.15.1749710504334; 
 Wed, 11 Jun 2025 23:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4WIVA7hL5lZ/p6TO03Do2C3M0/HlPCFs3/XRMRYOfcDdB0BR8+PVG+otlMlGo8M619n/PYmWwgLNOpk8R+d0=
X-Received: by 2002:a05:651c:1986:b0:32b:3437:7e8d with SMTP id
 38308e7fff4ca-32b343781eamr2794731fa.15.1749710503904; Wed, 11 Jun 2025
 23:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250603013810.4772-1-farosas@suse.de>
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 12 Jun 2025 08:41:31 +0200
X-Gm-Features: AX0GCFu85GT2xxxrXCMSC4yOnyoWkhSD7IsrUq4p5EvvDuBL5fHt-ZWLM-6X2r4
Message-ID: <CAMXpfWt8GZ5L30dbCwDiOak3PbN3bi3w4iSPKLNricY5ShF4vQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] migration: Unify capabilities and parameters
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series has been successfully tested. Boot up two VMs, one in
source and the other in destination with -incoming defer. Using the
migrate_set_parameter, enable the postcopy-ram, after that check with
info migrate_parameters this is correct.

(qemu) migrate_set_parameter postcopy-ram on
(qemu) info migrate_parameters
...
events: off
postcopy-ram: on
x-colo: off
...

Do migration plus the postcopy and check with info migrate there's a
real postcopy process while migrating

(qemu) migrate -d tcp:${DST_IP}:8888
(qemu) info migrate
Status: postcopy-active
Time (ms): total=3D3410, setup=3D34, down=3D53
RAM info:
  Throughput (Mbps): 1000.82
  Sizes (KiB): pagesize=3D4, total=3D16798280,
    transferred=3D357703, remain=3D6293884,
    precopy=3D128792, multifd=3D0, postcopy=3D228566
  Pages: normal=3D88199, zero=3D440747, rate_per_sec=3D34875
  Others: dirty_syncs=3D2, postcopy_req=3D644

(qemu) info migrate -a
Status: postcopy-active
Sockets: [
tcp::::8888
]
Globals:
  store-global-state: on
  only-migratable: off
  send-configuration: on
  send-section-footer: on
  send-switchover-start: on
  clear-bitmap-shift: 18

Finally migration ends seamlessly.
(qemu) info migrate
Status: completed

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Tue, Jun 3, 2025 at 3:39=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Hi,
>
> Thanks for the reviews in the last round. Your feedback has allowed me
> to reduce the complexity of the series and the code considerably.
>
> Changes in this v2:
>
> - Followed the suggestion to unify the TLS strings as StrOrNull. This
>   allows the complete removal of the MigrateSetParameters
>   type. Therefore, no need for playing tricks with base types.
>
> - I figured out that block_bitmap_mapping was set as optional in
>   qmp_query_migrate_parameters in error. Fixing that allows to
>   simplify that function somewhat.
>
> - The suggestion of not checking the has_* fields when setting the
>   parameters also led to great simplification. Now there's no need to
>   open-code the setting of every single parameter.
>
> - Deprecated the capabilities commands.
>
> - Removed some redundant documentation from migration.json. Now
>   there's only 1 (one) place where migration parameters need to be
>   documented.
>
> The series:
> - passes CI: https://gitlab.com/farosas/qemu/-/pipelines/1849885920
> - passes the migration tests in the ASAN build.
> - passes the migration compat tests against each of the 3 last QEMU versi=
ons.
> - passes the iotest 300 (related to block_bitmap_mapping).
>
> v1:
> https://lore.kernel.org/r/20250411191443.22565-1-farosas@suse.de
>
> Fabiano Rosas (21):
>   migration: Normalize tls arguments
>   migration: Remove MigrateSetParameters
>   qapi/migration: Don't document MigrationParameter
>   migration: Run a post update routine after setting parameters
>   migration: Add a flag to track block-bitmap-mapping input
>   migration: Remove checks for s->parameters has_* fields
>   migration: Set block_bitmap_mapping unconditionally in
>     query-migrate-parameters
>   migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE
>   migration: Extract code to mark all parameters as present
>   migration: Use QAPI_CLONE_MEMBERS in query_migrate_parameters
>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
>   migration: Use visitors in migrate_params_test_apply
>   migration: Cleanup hmp_info_migrate_parameters
>   migration: Add capabilities into MigrationParameters
>   qapi/migration: Mark that query/set-migrate-parameters support
>     capabilities
>   migration: Remove s->capabilities
>   qapi/migration: Deprecate capabilities commands
>   migration: Allow migrate commands to provide the migration config
>   libqtest: Add a function to check whether a QMP command supports a
>     feature
>   tests/qtest/migration: Add a test for config passing
>
>  docs/about/deprecated.rst          |   12 +
>  migration/migration-hmp-cmds.c     |  484 ++++++++----
>  migration/migration.c              |   50 +-
>  migration/migration.h              |    9 +-
>  migration/options.c                | 1090 +++++++++++++---------------
>  migration/options.h                |   29 +-
>  migration/page_cache.c             |    6 +-
>  migration/ram.c                    |    5 +-
>  migration/savevm.c                 |    8 +-
>  migration/tls.c                    |    2 +-
>  qapi/migration.json                |  573 ++++++---------
>  qapi/pragma.json                   |    3 +-
>  system/vl.c                        |    3 +-
>  tests/qtest/libqtest.c             |   42 ++
>  tests/qtest/libqtest.h             |   12 +
>  tests/qtest/migration/framework.h  |    2 +
>  tests/qtest/migration/misc-tests.c |   39 +
>  17 files changed, 1243 insertions(+), 1126 deletions(-)
>
> --
> 2.35.3
>
>


