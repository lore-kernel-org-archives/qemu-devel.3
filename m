Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32C9104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw67s-0004pu-11; Fri, 27 Feb 2026 17:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw67p-0004pJ-Po
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:15:57 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw67o-00078w-AU
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:15:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC3384D449;
 Fri, 27 Feb 2026 22:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772230554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6zzJYj5MqUiiZQuNINlHa3uNLIb4/VSqWoNfZc6LMI=;
 b=QfQRTLEh+taB/8iz7JiaZsjSk9dsqAYAno1Oj9saKLoDThSO9/dH44C3DOUat1pxFjNHJp
 n6tKszMWr6Fa+9AiZ9DQqZj0D1ZdX7+Oo35lMd4HkaQ8mSqRm71mdNtRl+M6cpy1oeuGZn
 F3BFWbd/pphdW/R758s8yA4b2yvwIoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772230554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6zzJYj5MqUiiZQuNINlHa3uNLIb4/VSqWoNfZc6LMI=;
 b=Uncx5cNgvsuriyaTvN6xanvxMjceuZ+oT+Fqz4fADK0hPy0BAeOHFMqMLSuKzD7mGsIccn
 KdQPVDeDNriWT6AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QfQRTLEh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Uncx5cNg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772230554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6zzJYj5MqUiiZQuNINlHa3uNLIb4/VSqWoNfZc6LMI=;
 b=QfQRTLEh+taB/8iz7JiaZsjSk9dsqAYAno1Oj9saKLoDThSO9/dH44C3DOUat1pxFjNHJp
 n6tKszMWr6Fa+9AiZ9DQqZj0D1ZdX7+Oo35lMd4HkaQ8mSqRm71mdNtRl+M6cpy1oeuGZn
 F3BFWbd/pphdW/R758s8yA4b2yvwIoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772230554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6zzJYj5MqUiiZQuNINlHa3uNLIb4/VSqWoNfZc6LMI=;
 b=Uncx5cNgvsuriyaTvN6xanvxMjceuZ+oT+Fqz4fADK0hPy0BAeOHFMqMLSuKzD7mGsIccn
 KdQPVDeDNriWT6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 325C43EA69;
 Fri, 27 Feb 2026 22:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nJnkOZkXomkYWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 22:15:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 02/16] migration: make vmstate_save_state_v() static
In-Reply-To: <20260220210214.800050-3-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-3-vsementsov@yandex-team.ru>
Date: Fri, 27 Feb 2026 19:15:51 -0300
Message-ID: <87h5r1u92g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[yandex-team.ru:email,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: AC3384D449
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> It's used only in vmstate.c.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/migration/vmstate.h |  3 ---
>  migration/vmstate.c         | 19 ++++++++++---------
>  2 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 89f9f49d20..3695afd483 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1234,9 +1234,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, int version_id, Error **errp);
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, JSONWriter *vmdesc, Error **errp);
> -int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> -                         void *opaque, JSONWriter *vmdesc,
> -                         int version_id, Error **errp);
>  
>  bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
>  
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index fccd030dfd..651c3fe011 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -420,15 +420,9 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
>      return true;
>  }
>  
> -
> -int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
> -{
> -    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
> -}
> -
> -int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> -                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
> +static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> +                                void *opaque, JSONWriter *vmdesc,
> +                                int version_id, Error **errp)
>  {
>      ERRP_GUARD();
>      int ret = 0;
> @@ -608,6 +602,13 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
>      return NULL;
>  }
>  
> +int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> +                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
> +{
> +    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id,
> +                                errp);
> +}
> +
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>                                     void *opaque, Error **errp)
>  {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

