Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93511061B14
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7FO2-0002ie-9y; Mon, 30 Mar 2026 12:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7FNz-0002i6-Mn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:22:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7FNx-0007Zt-KZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:22:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 386E84D1FD;
 Mon, 30 Mar 2026 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774887759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfqyhdTyGciMy4unOm8FsJumfm+MWXtR+WKSyYMy3M8=;
 b=R4AaBwR/6GINVmUeMNMbfJMbVDcEx3rUq4lz9v1eHSOMIYrF8FdzuraTJNjNGkQ+VrhrUD
 VQAM9aqQvX0F11G4rFE1m77kCxY1Hp7/+UG+h+tt8lunNzCVCJbOS2Vy21s39eXX1ovr4N
 G4XgypQwOpCXjjingTbcaoB3wol2OAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774887759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfqyhdTyGciMy4unOm8FsJumfm+MWXtR+WKSyYMy3M8=;
 b=2z2Jia8aEJ+To50IPl4bwYe2TV6/ZND6QN6bE8PfL8Kc6qNtj8XwiiakX80GqjLROPj+9I
 8+rcBUvT31v3kxAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="R4AaBwR/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2z2Jia8a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774887759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfqyhdTyGciMy4unOm8FsJumfm+MWXtR+WKSyYMy3M8=;
 b=R4AaBwR/6GINVmUeMNMbfJMbVDcEx3rUq4lz9v1eHSOMIYrF8FdzuraTJNjNGkQ+VrhrUD
 VQAM9aqQvX0F11G4rFE1m77kCxY1Hp7/+UG+h+tt8lunNzCVCJbOS2Vy21s39eXX1ovr4N
 G4XgypQwOpCXjjingTbcaoB3wol2OAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774887759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfqyhdTyGciMy4unOm8FsJumfm+MWXtR+WKSyYMy3M8=;
 b=2z2Jia8aEJ+To50IPl4bwYe2TV6/ZND6QN6bE8PfL8Kc6qNtj8XwiiakX80GqjLROPj+9I
 8+rcBUvT31v3kxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9CA34A0A2;
 Mon, 30 Mar 2026 16:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id msUIJk6jymniUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Mar 2026 16:22:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com, Thomas
 Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] cirrus-vga: Add property to set frame buffer
 endianness and make it default to little endian
In-Reply-To: <20260330140655.31EC55968DE@zero.eik.bme.hu>
References: <20260330140655.31EC55968DE@zero.eik.bme.hu>
Date: Mon, 30 Mar 2026 13:22:36 -0300
Message-ID: <87mrzpgucz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 386E84D1FD
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> I've tried this but it does not seem to work and leaves default to
> auto. Could somebody tell how this should work?
>

This patch sets the hw_compat to "off" so when new code migrates to/from
an old machine type, it will set the endianness to LE due to the
conditional you added.

  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2
  s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0

overriding works:

  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2 -global cirrus-vga.x-big-endian-fb=on
  s->big_endian_fb: 1 --> s->vga.big_endian_fb: 1
  
  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2 -global cirrus-vga.x-big-endian-fb=off
  s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0

The default value is a separate thing, this patch sets it to "auto" so
unless the hw_compat or the user overrides it, that's what you get.

  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus
  s->big_endian_fb: 0
  (s->vga.big_endian_fb: 0, unchanged)
  
  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -global cirrus-vga.x-big-endian-fb=on
  s->big_endian_fb: 1 --> s->vga.big_endian_fb: 1
  
  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -global cirrus-vga.x-big-endian-fb=off
  s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0

Maybe what you want is to say the old behavior is auto? Then set the
default to off.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/core/machine.c                | 2 ++
>  hw/display/cirrus_vga.c          | 6 ++++++
>  hw/display/cirrus_vga_internal.h | 2 ++
>  hw/display/cirrus_vga_isa.c      | 2 ++
>  4 files changed, 12 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e9..e573ef46bc 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,8 @@
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },
>      { "isa-cirrus-vga", "global-vmstate", "true" },
> +    { "isa-cirrus-vga", "x-big-endian-fb", "off" },
> +    { "cirrus-vga", "x-big-endian-fb", "off" },
>  };
>  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
>  
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 629b34fc68..e379f125ae 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -2930,6 +2930,10 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
>      s->vga.cursor_invalidate = cirrus_cursor_invalidate;
>      s->vga.cursor_draw_line = cirrus_cursor_draw_line;
>  
> +    if (s->big_endian_fb != ON_OFF_AUTO_AUTO) {
> +        s->vga.big_endian_fb = (s->big_endian_fb == ON_OFF_AUTO_ON);
> +    }
> +
>      qemu_register_reset(cirrus_reset, s);
>  }
>  
> @@ -2987,6 +2991,8 @@ static const Property pci_vga_cirrus_properties[] = {
>                         cirrus_vga.vga.vram_size_mb, 4),
>      DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
>                       cirrus_vga.enable_blitter, true),
> +    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,
> +                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_AUTO),
>  };
>  
>  static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/display/cirrus_vga_internal.h b/hw/display/cirrus_vga_internal.h
> index a78ebbd920..7c07201f18 100644
> --- a/hw/display/cirrus_vga_internal.h
> +++ b/hw/display/cirrus_vga_internal.h
> @@ -26,6 +26,7 @@
>  #ifndef CIRRUS_VGA_INTERNAL_H
>  #define CIRRUS_VGA_INTERNAL_H
>  
> +#include "hw/core/qdev-properties.h"
>  #include "vga_int.h"
>  
>  /* IDs */
> @@ -94,6 +95,7 @@ typedef struct CirrusVGAState {
>      int real_vram_size; /* XXX: suppress that */
>      int device_id;
>      int bustype;
> +    OnOffAuto big_endian_fb;
>  } CirrusVGAState;
>  
>  void cirrus_init_common(CirrusVGAState *s, Object *owner,
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index 76034a8860..c2b0b61476 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -75,6 +75,8 @@ static const Property isa_cirrus_vga_properties[] = {
>                       cirrus_vga.enable_blitter, true),
>      DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
>                       cirrus_vga.vga.global_vmstate, false),
> +    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,

s/PCICirrusVGAState/ISACirrusVGAState/

> +                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_AUTO),
>  };
>  
>  static void isa_cirrus_vga_class_init(ObjectClass *klass, const void
>  *data)

