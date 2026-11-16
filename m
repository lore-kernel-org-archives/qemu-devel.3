Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DE606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VYyBBCba;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=InPKa3O6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VYyBBCba;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=InPKa3O6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT1Iq-0007zN-M4; Mon, 16 Nov 2026 13:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xT1Ip-0007z9-6I
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:19:39 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xT1In-000464-HC
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:19:38 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CD7822190;
 Mon, 16 Nov 2026 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794853174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afVz9OUYiQf8XIidYWs+fWZ6tHaX1YSLllK9Uillapw=;
 b=VYyBBCbankVeFZMLt46FD6ynMBqacg6B01TIS+Ed/0aYWUNHkR6ke8hVvFGxp91KDOeqKg
 Zloj43vHTczTWhW1e0GXAQeIehE5+bXwSujk4/mb+GNkxs+n4HUmrk1/RyzS1Io6hKIPnB
 8xmytQqNQ4sEWkD3bTE79PmI19H0oT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794853174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afVz9OUYiQf8XIidYWs+fWZ6tHaX1YSLllK9Uillapw=;
 b=InPKa3O6RO4fRy43OQqRfK5hZA/CchcqUxL4eCh3DURNV1200T96KLS5XGjj3ornukqye9
 XSfiAedgrPHuadAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794853174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afVz9OUYiQf8XIidYWs+fWZ6tHaX1YSLllK9Uillapw=;
 b=VYyBBCbankVeFZMLt46FD6ynMBqacg6B01TIS+Ed/0aYWUNHkR6ke8hVvFGxp91KDOeqKg
 Zloj43vHTczTWhW1e0GXAQeIehE5+bXwSujk4/mb+GNkxs+n4HUmrk1/RyzS1Io6hKIPnB
 8xmytQqNQ4sEWkD3bTE79PmI19H0oT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794853174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afVz9OUYiQf8XIidYWs+fWZ6tHaX1YSLllK9Uillapw=;
 b=InPKa3O6RO4fRy43OQqRfK5hZA/CchcqUxL4eCh3DURNV1200T96KLS5XGjj3ornukqye9
 XSfiAedgrPHuadAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E30E41334C;
 Mon, 16 Nov 2026 18:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h7ReHjVJ+2qqYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Nov 2026 18:19:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Zhu Wei <zhuwei@sangfor.com.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com.cn>
Subject: Re: [PATCH 1/1] migration: free migration blocker error in
 migrate_del_blocker() stub
In-Reply-To: <20261111122711.3167511-2-zhuwei@sangfor.com.cn>
References: <20261111122711.3167511-1-zhuwei@sangfor.com.cn>
 <20261111122711.3167511-2-zhuwei@sangfor.com.cn>
Date: Mon, 16 Nov 2026 15:19:30 -0300
Message-ID: <87se10skp9.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[sangfor.com.cn:email,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Zhu Wei <zhuwei@sangfor.com.cn> writes:

> From: niming <niming@sangfor.com.cn>
>
> The migrate_del_blocker() implementation in stubs/migr-blocker.c was an
> empty no-op, while the real one in migration/migration.c takes ownership
> of the Error from the migration blocker, frees it and then clears the
> pointer:
>
>     void migrate_del_blocker(Error **reasonp)
>     {
>         if (*reasonp) {
>             ...
>             error_free(*reasonp);
>             *reasonp = NULL;
>         }
>     }
>
> Command line tools such as qemu-img link against the stub API. Block
> drivers like vmdk allocate a migration blocker Error during open() (see
> error_setg() in vmdk_open(), "does not support live migration") and pass
> it to migrate_add_blocker_normal(). Because the stub migrate_add_blocker*()
> is a no-op it does not take ownership of the Error, so on close the
> stub migrate_del_blocker() has to free it itself; leaving the body empty
> leaks the error message.
>
> This becomes visible when running under ASan: "qemu-img info foo.vmdk"
> leaks the migration-blocker error and hangs / fails to exit when the
> image is closed.
>
> Free the Error in the stub migrate_del_blocker() and set the pointer to
> NULL to match the semantics of the real implementation. This also covers
> every other driver that uses a migration blocker through the stub.
>
> Signed-off-by: niming <niming@sangfor.com.cn>
> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
> ---
>  stubs/migr-blocker.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
> index e54c7160d3..575b65f183 100644
> --- a/stubs/migr-blocker.c
> +++ b/stubs/migr-blocker.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "migration/blocker.h"
> +#include "qapi/error.h"
>  
>  int migrate_add_blocker(Error **reasonp, Error **errp)
>  {
> @@ -18,4 +19,12 @@ int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
>  
>  void migrate_del_blocker(Error **reasonp)
>  {
> +    /*
> +     * migrate_add_blocker*() is a no-op here, so nobody owns the Error;
> +     * free it to avoid a leak (e.g. "qemu-img info foo.vmdk").
> +     */
> +    if (reasonp && *reasonp) {
> +        error_free(*reasonp);
> +        *reasonp = NULL;
> +    }
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

