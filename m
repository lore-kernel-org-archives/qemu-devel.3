Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630331093177
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 06:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Tky-0001bS-I2; Fri, 20 Mar 2026 02:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3Tkw-0001aw-ML
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 02:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3Tku-0004q7-0V
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 02:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773989685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G8qHjwIcyL3+jxonEsuie58tPAeNBJLPGTKJWWyhJZ4=;
 b=VGCwfnwQhsbxzQeFhYU+5C3QvTrxEUiC8rl2VmK1AdLeEWB4Lsn/hseC7E4X6Ul8qcZhiQ
 AFGH3fpKedf5Ym1kRokrDMJSg2aTiGLZA3BgMjqI+ZslTEY3tOHx6xvPHBpPdBY1yZDCMb
 qfHVqtVu8Jqd4GWt2pdNOsc5CZD0TLY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-RMS2w4zBPFCT9TCTBULFpw-1; Fri,
 20 Mar 2026 02:54:44 -0400
X-MC-Unique: RMS2w4zBPFCT9TCTBULFpw-1
X-Mimecast-MFC-AGG-ID: RMS2w4zBPFCT9TCTBULFpw_1773989682
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 136AD180044D; Fri, 20 Mar 2026 06:54:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B52941955D84; Fri, 20 Mar 2026 06:54:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49D7221E6937; Fri, 20 Mar 2026 07:54:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,  Kirti
 Wankhede <kwankhede@nvidia.com>,  "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,  Alex Williamson
 <alex@shazbot.org>,  Yishai Hadas <yishaih@nvidia.com>,  Fabiano Rosas
 <farosas@suse.de>,  Pranav Tyagi <prtyagi@redhat.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  Avihai Horon <avihaih@nvidia.com>,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater <clg@redhat.com>,  devel@lists.libvirt.org
Subject: Re: [PATCH RFC 02/12] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
In-Reply-To: <20260319231302.123135-3-peterx@redhat.com> (Peter Xu's message
 of "Thu, 19 Mar 2026 19:12:52 -0400")
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-3-peterx@redhat.com>
Date: Fri, 20 Mar 2026 07:54:38 +0100
Message-ID: <877br7kn2p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Cc: correct libvirt list address

Peter Xu <peterx@redhat.com> writes:

> This stats is only about RAM, so make it accurate.  This paves way for
> statistics for all devices.
>
> Note that even if this is part of qapi/, this should not be part of ABI of

docs/devel/qapi-code-gen.rst section "Compatibility considerations":

    Since type names are not visible in the Client JSON Protocol, types
    may be freely renamed.  Even certain refactorings are invisible, such
    as splitting members from one type into a common base type.

So, s/should not be/is not/.

> at least query-migrate, because the structure is not changed, and this
> stats is always reported only under the "ram" section.

Why "at least query-migrate"?  Do you have other interfaces in mind, or
are you just hedging?

> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Libvirt Mailing List <libvir-list@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/removed-features.rst | 2 +-
>  qapi/migration.json             | 8 ++++----
>  migration/migration-stats.h     | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 6f4447993c..7c4f4325f7 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -699,7 +699,7 @@ was superseded by ``sections``.
>  ``query-migrate`` return value member ``skipped`` (removed in 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>=20=20
> -Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
> +Member ``skipped`` of the ``MigrationRAMStats`` struct hasn't been used
>  for more than 10 years. Removed with no replacement.

Could simply use "of the return value".  But this is fine, too.

>=20=20
>  ``migrate`` command option ``inc`` (removed in 9.1)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..cfc6ccee26 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -12,7 +12,7 @@
>  { 'include': 'sockets.json' }
>=20=20
>  ##
> -# @MigrationStats:
> +# @MigrationRAMStats:
>  #
>  # Detailed migration status.
>  #
> @@ -64,7 +64,7 @@
>  #
>  # Since: 0.14
>  ##
> -{ 'struct': 'MigrationStats',
> +{ 'struct': 'MigrationRAMStats',
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int',
>             'normal': 'int',
> @@ -209,7 +209,7 @@
>  #     If this field is not returned, no migration process has been
>  #     initiated
>  #
> -# @ram: `MigrationStats` containing detailed migration status, only
> +# @ram: `MigrationRAMStats` containing detailed migration status, only
>  #     returned if status is 'active' or 'completed'(since 1.2)

This gets rendered like

      * ram (MigrationStats, *optional*) -- MigrationStats
        containing detailed migration status, only returned if status
        is 'active' or 'completed'(since 1.2)

Recommend to rephrase to avoid the repetition.  Maybe

   # @ram: Detailed migration RAM status, only returned if status is
   #     'active' or 'completed' (since 1.2)

Also consider replacing "status" by "statistics".

>  #
>  # @xbzrle-cache: `XBZRLECacheStats` containing detailed XBZRLE
> @@ -309,7 +309,7 @@
>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationInfo',
> -  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
> +  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
>             '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index c0f50144c9..1153520f7a 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -27,7 +27,7 @@
>=20=20
>  /*
>   * These are the ram migration statistic counters.  It is loosely
> - * based on MigrationStats.
> + * based on MigrationRAMStats.
>   */
>  typedef struct {
>      /*

Only minor issues, and none added by this patch, so
Acked-by: Markus Armbruster <armbru@redhat.com>


