Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A4606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aLtWByy2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AhU+kDCJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s2wUJFgd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qYJFx55F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPT2-0004zA-OX; Thu, 29 Oct 2026 08:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xMPSz-0004yo-IS; Thu, 29 Oct 2026 08:42:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xMPSq-0002cX-Oy; Thu, 29 Oct 2026 08:42:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F78A1F7F2;
 Thu, 29 Oct 2026 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793277756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwlpaKwRJOG6mcj5pd6hl3Mkg0J+BxhPbs0TlsL25ss=;
 b=aLtWByy29wZIwqAQMwJLDEB4hJeYr3jNOq0w03iR4NM81jmixUvhPNgd9T2JOOZR1rLAzS
 wX7C0YNs9LbekUvW9y+FPhgjPZOyXpHFFYtsHok7qebrsuaOTguCBV+wPveGmlJbfISTIo
 C+IFpglf+9HY+Id4D494qI8EjdkkKyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793277756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwlpaKwRJOG6mcj5pd6hl3Mkg0J+BxhPbs0TlsL25ss=;
 b=AhU+kDCJQzZbA028r8olP7xbEYoOksTJ+HtXOMTtB9+bOu3+XhZt5Gs1kV5lhN9IrycPmf
 g2eq/oMC1SKeC0DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793277755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwlpaKwRJOG6mcj5pd6hl3Mkg0J+BxhPbs0TlsL25ss=;
 b=s2wUJFgd2X2NB1kBIzkehhYAMOuzd8q1k8/4w2AmR8iih2pnrrl67B2FTHEYpbfm3rz+Gh
 BSsH+mX/l3N0z+bMbJovc6JBYbbTEmfIzruP4pl5QqKKDtIQkRUCCDKnQY+aBoBDapjpwV
 yPQoEGeni7wlH2P8JEFw38hfdiI4jyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793277755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwlpaKwRJOG6mcj5pd6hl3Mkg0J+BxhPbs0TlsL25ss=;
 b=qYJFx55FPbNg7Yh29KfZ/9oTE+xl0GyAEO14AnlNyvDLGovXSf6UcCZ2nUHfWtGa8SJxpG
 zNRsAOKX0RLEU5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC76E1339F;
 Thu, 29 Oct 2026 12:42:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IItdFDo/42p+UQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 12:42:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Showta Ishizaki <zakinko@snowrabbit.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles
 <milesg@linux.ibm.com>, qemu-stable@nongnu.org, Showta Ishizaki
 <zakinko@snowrabbit.org>
Subject: Re: [PATCH] target/ppc: Register the 745's HID0 and HID1 once
In-Reply-To: <179325247250.65414.17031704056960380956.745-hid@snowrabbit.org>
References: <179325247250.65414.17031704056960380956.745-hid@snowrabbit.org>
Date: Thu, 29 Oct 2026 09:42:32 -0300
Message-ID: <87wlr0isp3.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,nongnu.org,snowrabbit.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, snowrabbit.org:email,
 imap1.dmz-prg2.suse.org:helo, nongnu.org:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Showta Ishizaki <zakinko@snowrabbit.org> writes:

> init_proc_745(), which the 755 shares, calls register_7xx_sprs() and
> then register_745_sprs().  Since HID0 and HID1 moved into
> register_7xx_sprs(), both functions register them the same way, and
> _spr_register() asserts that no SPR is registered twice, so the 745 and
> the 755 cannot be created at all:
>
>   $ qemu-system-ppc -M none -cpu 745
>   Assertion failed: (spr->name == NULL), function _spr_register,
>   file helper_regs.c, line 419.
>
> Leave the two to register_7xx_sprs().
>
> Fixes: 0301b39c78c8 ("target/ppc: cpu_init: Deduplicate 7xx SPR registration")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> ---
>  target/ppc/cpu_init.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7f3036d903e..9fb05ff265d 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -86,17 +86,10 @@ static void register_745_sprs(CPUPPCState *env)
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
>  
> -    /* Hardware implementation registers */
> -    spr_register(env, SPR_HID0, "HID0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_HID1, "HID1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> +    /*
> +     * Hardware implementation registers.  HID0 and HID1 are registered by
> +     * register_7xx_sprs(), which init_proc_745() calls first.
> +     */
>      spr_register(env, SPR_HID2, "HID2",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>
> base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b

Reviewed-by: Fabiano Rosas <farosas@suse.de>

