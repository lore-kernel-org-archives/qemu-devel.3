Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED3ECF65FF
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkM3o-0002o6-9e; Mon, 26 Jan 2026 07:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkM3m-0002kF-C8
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:51:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkM3k-0006ag-Of
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:51:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22DB633707;
 Mon, 26 Jan 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769431868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIl9FxQ/h6V+wSCw8SCl8c51J0IN3hRouxlmApMWxI0=;
 b=WJzOW4oCuNJGYFGzGQPncT204P4eKbHqZ639UEgx7FCttaxd+KarO8BSF62K4l2vC0xOfP
 zwwba4D8Ai9rUcDlBSoJvhMzXuFBuj2JEeqhy35qeEbQEt/sbOGBrHNeX2ZgVUiVhsCety
 n/uFoF15+LpLHEuQROS94jzwwHVnP9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769431868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIl9FxQ/h6V+wSCw8SCl8c51J0IN3hRouxlmApMWxI0=;
 b=KVsUA7pxbbXTmq2hLlMkIwciY5Untr92cmggKJcwcyAaLK/LNGOQaQzKIFxxzc/AbrEVaL
 P4AAWmBuBCYat3DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WJzOW4oC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KVsUA7px
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769431868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIl9FxQ/h6V+wSCw8SCl8c51J0IN3hRouxlmApMWxI0=;
 b=WJzOW4oCuNJGYFGzGQPncT204P4eKbHqZ639UEgx7FCttaxd+KarO8BSF62K4l2vC0xOfP
 zwwba4D8Ai9rUcDlBSoJvhMzXuFBuj2JEeqhy35qeEbQEt/sbOGBrHNeX2ZgVUiVhsCety
 n/uFoF15+LpLHEuQROS94jzwwHVnP9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769431868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIl9FxQ/h6V+wSCw8SCl8c51J0IN3hRouxlmApMWxI0=;
 b=KVsUA7pxbbXTmq2hLlMkIwciY5Untr92cmggKJcwcyAaLK/LNGOQaQzKIFxxzc/AbrEVaL
 P4AAWmBuBCYat3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C69139F0;
 Mon, 26 Jan 2026 12:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u6EIETtjd2m+KwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 12:51:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 03/10] Move ram state receive into
 multifd_ram_state_recv()
In-Reply-To: <20260125-colo_unit_test_multifd-v3-3-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-3-ae926ccd8eae@web.de>
Date: Mon, 26 Jan 2026 09:51:04 -0300
Message-ID: <87pl6wh70n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 22DB633707
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Lukas Straub <lukasstraub2@web.de> writes:

> This is in preparation for the next patch.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  migration/multifd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ad6261688fdf98a5c7f4ee9fb80ba2901201a33e..332e6fc58053462419f3171f6c320ac37648ef7b 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1253,6 +1253,15 @@ static int multifd_device_state_recv(MultiFDRecvParams *p, Error **errp)
>      return ret;
>  }
>  
> +static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    int ret;
> +
> +    ret = multifd_recv_state->ops->recv(p, errp);
> +
> +    return ret;
> +}
> +
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1387,7 +1396,7 @@ static void *multifd_recv_thread(void *opaque)
>                  assert(use_packets);
>                  ret = multifd_device_state_recv(p, &local_err);
>              } else {
> -                ret = multifd_recv_state->ops->recv(p, &local_err);
> +                ret = multifd_ram_state_recv(p, &local_err);
>              }
>              if (ret != 0) {
>                  break;

