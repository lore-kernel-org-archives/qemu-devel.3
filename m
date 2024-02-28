Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4064C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 07:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfE74-0004fh-Vr; Wed, 28 Feb 2024 02:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfE74-0004fF-3L
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfE72-000312-5f
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709104338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=leg0/d4GqL+C0222rFaatCnApGNJfZzjXHAdaTUTmys=;
 b=goiyDSU9fdiLQFVlavT+MQyt7+4qV9rTOHQ9x0IQKNU+T7O66rVT41HF9bX9hOd9FCfJi0
 B3GLhxSsHd0OjYxdlQQAg+MoUgbVtroUfz/NRpqQWocw21n+XNJGC6gqp17gv5/Mc+a8Zh
 aYt72errq9biIfHaJC9RS4JjdrZ+lUI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-dQ35S7P0N8irTaKzvm3x8Q-1; Wed, 28 Feb 2024 02:12:15 -0500
X-MC-Unique: dQ35S7P0N8irTaKzvm3x8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA1E5185A780;
 Wed, 28 Feb 2024 07:12:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4C5A201B06F;
 Wed, 28 Feb 2024 07:12:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CBEF21E66F4; Wed, 28 Feb 2024 08:12:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,  David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH V4 13/14] migration: update cpr-reboot description
In-Reply-To: <1708622920-68779-14-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 22 Feb 2024 09:28:39 -0800")
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-14-git-send-email-steven.sistare@oracle.com>
Date: Wed, 28 Feb 2024 08:12:11 +0100
Message-ID: <87h6ht3vw4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Clarify qapi for cpr-reboot migration mode, and add vfio support.

The patch only affects documentation, but that's less than clear from
the commit message.  Suggest

  Improve documentation for migration mode @cpr-reboot.  In particular,
  document VFIO support.

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5a565d9..0990297 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -636,19 +636,28 @@
>  #
>  # @normal: the original form of migration. (since 8.2)
>  #
> -# @cpr-reboot: The migrate command saves state to a file, allowing one to
> -#              quit qemu, reboot to an updated kernel, and restart an updated
> -#              version of qemu.  The caller must specify a migration URI
> -#              that writes to and reads from a file.  Unlike normal mode,
> -#              the use of certain local storage options does not block the
> -#              migration, but the caller must not modify guest block devices
> -#              between the quit and restart.  To avoid saving guest RAM to the
> -#              file, the memory backend must be shared, and the @x-ignore-shared
> -#              migration capability must be set.  Guest RAM must be non-volatile
> -#              across reboot, such as by backing it with a dax device, but this
> -#              is not enforced.  The restarted qemu arguments must match those
> -#              used to initially start qemu, plus the -incoming option.
> -#              (since 8.2)
> +# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
> +#     After quitting qemu, the user resumes by running qemu -incoming.

These two sentences apply to any migration mode, don't they?  Just
checking I understand.

> +#
> +#     This mode allows the user to quit qemu, and restart an updated version
> +#     of qemu.  The user may even update and reboot the OS before restarting,
> +#     as long as the URI persists across a reboot.

Hmm, doesn't normal migration also support migrating to a newer QEMU?

> +#
> +#     Unlike normal mode, the use of certain local storage options does not
> +#     block the migration, but the user must not modify guest block devices
> +#     between the quit and restart.

"Must not modify the contents of the guest block devices"?

> +#
> +#     This mode supports vfio devices provided the user first puts the guest

"VFIO devices"

> +#     in the suspended runstate, such as by issuing guest-suspend-ram to the
> +#     qemu guest agent.
> +#
> +#     Best performance is achieved when the memory backend is shared and the
> +#     @x-ignore-shared migration capability is set, but this is not required.
> +#     Further, if the user reboots before restarting such a configuration, the
> +#     shared backend must be be non-volatile across reboot, such as by backing

Typo: "be be non-volatile"

Suggest "the shared memory must persist"

> +#     it with a dax device.
> +#
> +#     (since 8.2)
>  ##
>  { 'enum': 'MigMode',
>    'data': [ 'normal', 'cpr-reboot' ] }

Thanks for adjusting indentation to conform to conventions.  Please
additionally reflow the text to limit line length to 70 characters.


