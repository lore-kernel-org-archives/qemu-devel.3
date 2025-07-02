Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B0FC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX1dm-00078d-3z; Wed, 02 Jul 2025 13:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uX1dc-0006yb-My
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:52:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uX1da-0006Gh-TV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:52:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 214D321163;
 Wed,  2 Jul 2025 17:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751478767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/l8JUxlK6GNRm6ikqwkuEkSaKy3qwdGI3oG0ZTjfGGk=;
 b=0RHqAyOLREzfYfIcKTWb5lwNtqqhKRge1jEeh0CR1mrPj3xq3Sd653T2R8sEQ59R6/jQgZ
 be4NyqYFlsI9oEsayIrT4IiOXcP/0npGEiodiXQw9nrTABwyGZ66aKfrc5W+7DToPs2dxb
 p8NaLj1wFl52Skv8YjU004PC1Ko4qko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751478767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/l8JUxlK6GNRm6ikqwkuEkSaKy3qwdGI3oG0ZTjfGGk=;
 b=ipJoDy3+qnEegTv4/7le13zhFQ+DTi+lN9+1L4TIaGhdVGhIKkYcsCjgA0Vky3Dnxohy3h
 UZNaW6cq0kx0ZMBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0RHqAyOL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ipJoDy3+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751478767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/l8JUxlK6GNRm6ikqwkuEkSaKy3qwdGI3oG0ZTjfGGk=;
 b=0RHqAyOLREzfYfIcKTWb5lwNtqqhKRge1jEeh0CR1mrPj3xq3Sd653T2R8sEQ59R6/jQgZ
 be4NyqYFlsI9oEsayIrT4IiOXcP/0npGEiodiXQw9nrTABwyGZ66aKfrc5W+7DToPs2dxb
 p8NaLj1wFl52Skv8YjU004PC1Ko4qko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751478767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/l8JUxlK6GNRm6ikqwkuEkSaKy3qwdGI3oG0ZTjfGGk=;
 b=ipJoDy3+qnEegTv4/7le13zhFQ+DTi+lN9+1L4TIaGhdVGhIKkYcsCjgA0Vky3Dnxohy3h
 UZNaW6cq0kx0ZMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D0D513A24;
 Wed,  2 Jul 2025 17:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1c7eDu5xZWi7BAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Jul 2025 17:52:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V5 38/38] vfio: doc changes for cpr
In-Reply-To: <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
Date: Wed, 02 Jul 2025 14:52:43 -0300
Message-ID: <87v7oa4h04.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 214D321163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.95 / 50.00]; BAYES_HAM(-2.94)[99.72%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,intel.com,gmail.com,oracle.com];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 oracle.com:email, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Update documentation to say that cpr-transfer supports vfio and iommufd.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  docs/devel/migration/CPR.rst | 5 ++---
>  qapi/migration.json          | 6 ++++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 7897873..0a0fd4f 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -152,8 +152,7 @@ cpr-transfer mode
>  This mode allows the user to transfer a guest to a new QEMU instance
>  on the same host with minimal guest pause time, by preserving guest
>  RAM in place, albeit with new virtual addresses in new QEMU.  Devices
> -and their pinned memory pages will also be preserved in a future QEMU
> -release.
> +and their pinned memory pages are also preserved for VFIO and IOMMUFD.
>  
>  The user starts new QEMU on the same host as old QEMU, with command-
>  line arguments to create the same machine, plus the ``-incoming``
> @@ -322,6 +321,6 @@ Futures
>  
>  cpr-transfer mode is based on a capability to transfer open file
>  descriptors from old to new QEMU.  In the future, descriptors for
> -vfio, iommufd, vhost, and char devices could be transferred,
> +vhost, and char devices could be transferred,
>  preserving those devices and their kernel state without interruption,
>  even if they do not explicitly support live migration.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6c..e8a7d3b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -620,8 +620,10 @@
>  #
>  # @cpr-transfer: This mode allows the user to transfer a guest to a
>  #     new QEMU instance on the same host with minimal guest pause
> -#     time by preserving guest RAM in place.  Devices and their pinned
> -#     pages will also be preserved in a future QEMU release.
> +#     time by preserving guest RAM in place.
> +#
> +#     Devices and their pinned pages are also preserved for VFIO and
> +#     IOMMUFD. (since 10.1)
>  #
>  #     The user starts new QEMU on the same host as old QEMU, with
>  #     command-line arguments to create the same machine, plus the

Reviewed-by: Fabiano Rosas <farosas@suse.de>

