Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43719606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z6g8PlFm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UwLIhgps;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z6g8PlFm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UwLIhgps
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWYxj-00043W-Me; Thu, 26 Nov 2026 07:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWYxb-00041Y-Gu
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:52:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWYxZ-0005WL-UY
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:52:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 308FF224EF;
 Thu, 26 Nov 2026 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795697540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10DegD2d529SBAIiK3hA+VTRu628dWxlX8R0Z0pQF90=;
 b=Z6g8PlFmlixg6PvA2q9JEB+UoU26BgP7VnC2K8PJlLM+BadTDN0uBkhGo0N4ofFNkO1U45
 Q0OTslRHk/YUsgeJldP5n0xbjrSzF2HDKzvpdi0U9Fy6PKuP3HZuXo3s1BrrZ0c8xyJAzq
 T+D2RjOM/TfTnpM3h7KA39rf7e8V3eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795697540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10DegD2d529SBAIiK3hA+VTRu628dWxlX8R0Z0pQF90=;
 b=UwLIhgpsFqxhGavLCic87BBwaFo2jz6m0Pj+FORDua9WvtXyiEaVIXftMq6bCga91XGXqy
 cbPaRdUfjbue7/BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795697540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10DegD2d529SBAIiK3hA+VTRu628dWxlX8R0Z0pQF90=;
 b=Z6g8PlFmlixg6PvA2q9JEB+UoU26BgP7VnC2K8PJlLM+BadTDN0uBkhGo0N4ofFNkO1U45
 Q0OTslRHk/YUsgeJldP5n0xbjrSzF2HDKzvpdi0U9Fy6PKuP3HZuXo3s1BrrZ0c8xyJAzq
 T+D2RjOM/TfTnpM3h7KA39rf7e8V3eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795697540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10DegD2d529SBAIiK3hA+VTRu628dWxlX8R0Z0pQF90=;
 b=UwLIhgpsFqxhGavLCic87BBwaFo2jz6m0Pj+FORDua9WvtXyiEaVIXftMq6bCga91XGXqy
 cbPaRdUfjbue7/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B18613432;
 Thu, 26 Nov 2026 12:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m65mDYMrCGuhPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 12:52:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jie Song <mail@jiesong.me>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, peterx@redhat.com, avihaih@nvidia.com,
 Jie Song <songjie_yewu@cmss.chinamobile.com>
Subject: Re: [PATCH] vfio/migration: Use qemu_put_buffer_async to avoid an
 extra copy
In-Reply-To: <20261120162026.31245-1-mail@jiesong.me>
References: <20261120162026.31245-1-mail@jiesong.me>
Date: Thu, 26 Nov 2026 09:52:17 -0300
Message-ID: <875wxjsqke.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jie Song <mail@jiesong.me> writes:

> From: Jie Song <songjie_yewu@cmss.chinamobile.com>
>
> Replace qemu_put_buffer with qemu_put_buffer_async + qemu_fflush in
> vfio_save_block to avoid an unnecessary memcpy of device state data
> through QEMUFile's 32 KiB internal buffer.
>
> With qemu_put_buffer_async, the data_buffer pointer is added directly
> to the iov array. Since the next read overwrites the same buffer,
> flush immediately so that the channel has consumed the data before
> the buffer is reused.
>
> Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> ---
>  hw/vfio/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 69d50cebdd..e363250b79 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -476,7 +476,8 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>      qemu_put_be64(f, data_size);
> -    qemu_put_buffer(f, migration->data_buffer, data_size);
> +    qemu_put_buffer_async(f, migration->data_buffer, data_size, false);
> +    qemu_fflush(f);
>      vfio_migration_add_bytes_transferred(data_size);
>  
>      trace_vfio_save_block(migration->vbasedev->name, data_size);

Acked-by: Fabiano Rosas <farosas@suse.de>

