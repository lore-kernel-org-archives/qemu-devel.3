Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD7DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPEwu-0004d2-Lz; Tue, 19 May 2026 03:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPEwt-0004cs-3b
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:33:07 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPEwr-0001P1-CV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:33:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87C6A61810;
 Tue, 19 May 2026 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779175983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3jtSDxcCks87WTCLd7jujaqgqKWFGQoVaAm+LKYFmY=;
 b=qjuBO6HnHzduCg6l2KyqMCPhjmNG5diIOcB87aUfjGKT5vtYuAR2hefi9k577FA0gTr6x7
 kRNhAbiIuWPhl+O0USdyQcSbluWHOPlaFWWhmtJT2rE1+pnYbXonWOOydluQ/ji44emiJI
 HQjpTjyCxzCuFGbVCOfM/+SGbTbGzV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779175983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3jtSDxcCks87WTCLd7jujaqgqKWFGQoVaAm+LKYFmY=;
 b=0th5HM3CM0opaik3f7Nh9pjXVYY7xyFBzJWiDazOTIRgwJgiyUX8KF0jP7k9J31ffsaePs
 cv1Iuou8J15fzMBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qjuBO6Hn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0th5HM3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779175983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3jtSDxcCks87WTCLd7jujaqgqKWFGQoVaAm+LKYFmY=;
 b=qjuBO6HnHzduCg6l2KyqMCPhjmNG5diIOcB87aUfjGKT5vtYuAR2hefi9k577FA0gTr6x7
 kRNhAbiIuWPhl+O0USdyQcSbluWHOPlaFWWhmtJT2rE1+pnYbXonWOOydluQ/ji44emiJI
 HQjpTjyCxzCuFGbVCOfM/+SGbTbGzV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779175983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3jtSDxcCks87WTCLd7jujaqgqKWFGQoVaAm+LKYFmY=;
 b=0th5HM3CM0opaik3f7Nh9pjXVYY7xyFBzJWiDazOTIRgwJgiyUX8KF0jP7k9J31ffsaePs
 cv1Iuou8J15fzMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A492593A8;
 Tue, 19 May 2026 07:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dXEzOy4SDGp/VAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 May 2026 07:33:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 3/8] migration/vmstate: avoid per-element heap churn in
 vmsd ptr marker field
In-Reply-To: <20260518110112.21395-4-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
 <20260518110112.21395-4-guobin@linux.alibaba.com>
Date: Tue, 19 May 2026 04:32:56 -0300
Message-ID: <87qzn73lcn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 87C6A61810
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Bin Guo <guobin@linux.alibaba.com> writes:

> For every NULL slot in a VMS_ARRAY_OF_POINTER (or every entry of a
> dynamic array), the saver allocates a 1-element fake VMStateField via
> g_new0 and frees it again right after the save. For arrays of
> thousands of entries this is thousands of malloc/free pairs on the
> hot save path.
>
> Replace the heap-allocated marker with a stack-resident field
> populated by an init helper. The caller passes a pointer to a local
> VMStateField, the helper fills it in (still asserting the
> precondition), and no g_free is needed.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/vmstate.c | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 2f13b48a37..9ced78532f 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -59,29 +59,23 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
>   * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
>   * can't dereference the NULL pointer.
>   */
> -static const VMStateField *
> -vmsd_create_ptr_marker_field(const VMStateField *field)
> +static void
> +vmsd_init_ptr_marker_field(VMStateField *fake, const VMStateField *field)
>  {
> -    VMStateField *fake = g_new0(VMStateField, 1);
> -
>      /* It can only happen on an array of pointers! */
>      assert(field->flags & VMS_ARRAY_OF_POINTER);
>  
> -    /* Some of fake's properties should match the original's */
> -    fake->name = field->name;
> -    fake->version_id = field->version_id;
> -
> -    /* Do not need "field_exists" check as it always exists */
> -    fake->field_exists = NULL;
> -
> -    /* See vmstate_info_ptr_marker - use 1 byte to represent ptr status */
> -    fake->size = 1;
> -    fake->info = &vmstate_info_ptr_marker;
> -    fake->flags = VMS_SINGLE;
> -
> -    /* All the rest fields shouldn't matter.. */
> -
> -    return (const VMStateField *)fake;
> +    /* See vmstate_info_ptr_marker - 1 byte represents ptr status */
> +    *fake = (VMStateField) {
> +        .name = field->name,
> +        .version_id = field->version_id,
> +        /* Marker always exists, no field_exists callback needed */
> +        .field_exists = NULL,
> +        .size = 1,
> +        .info = &vmstate_info_ptr_marker,
> +        .flags = VMS_SINGLE,
> +        /* All other fields stay zero-initialised */
> +    };
>  }
>  
>  static int vmstate_n_elems(void *opaque, const VMStateField *field)
> @@ -680,6 +674,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>                  const VMStateField *inner_field;
> +                VMStateField marker_field;
>                  /* maximum number of elements to compress in the JSON blob */
>                  int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
>                  bool use_marker_field, is_null = false;
> @@ -693,7 +688,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  use_marker_field = use_dynamic_array || is_null;
>  
>                  if (use_marker_field) {
> -                    inner_field = vmsd_create_ptr_marker_field(field);
> +                    vmsd_init_ptr_marker_field(&marker_field, field);
> +                    inner_field = &marker_field;
>                  } else {
>                      inner_field = field;
>                  }
> @@ -730,11 +726,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                                      inner_field, vmdesc_loop,
>                                                      i, max_elems, errp);
>  
> -                /* If we used a fake temp field.. free it now */
> -                if (use_marker_field) {
> -                    g_clear_pointer((gpointer *)&inner_field, g_free);
> -                }
> -
>                  if (!ok) {
>                      goto out;
>                  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

