Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2400606A339
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1xp7hXq/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=B4HTouKc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mLOYEZLk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=57KYOnzP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgBQ-0000vo-MF; Tue, 27 Oct 2026 08:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLgBO-0000vb-3F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:21:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLgBL-0001Y7-Vy
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:21:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E65D01F7BE;
 Tue, 27 Oct 2026 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793103694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itnkzj+j1917gGs7cmzTDwhYWfDguSX2Rh/soNs8FRQ=;
 b=1xp7hXq/KSR96edfbKeVkeALjnTwUeWUDNKPO4SCU2GI3jytNcuOZybAvyyYgStlksh3Ky
 0DbyRIidzVerJrX0nL9ija2OwAt398q6xZeh532X7bXGJSFCmM76nm3BgpcfzhZ7ODWE35
 Chl/ArXah/1A/WJUolGWObFOSCX/RwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793103694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itnkzj+j1917gGs7cmzTDwhYWfDguSX2Rh/soNs8FRQ=;
 b=B4HTouKcuBQ2anb0RygkoWaUmjZ9WwWESuie8iTjgojCPtdb9X1DHT7Jx9QonPbvwM23dC
 4PKNeiLT5JDSnWAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mLOYEZLk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=57KYOnzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793103693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itnkzj+j1917gGs7cmzTDwhYWfDguSX2Rh/soNs8FRQ=;
 b=mLOYEZLk4gEunFq6BjkMfQRIK760Pcz6PSR3dKBJA8WrERL620tnRpsT/eNoeS3Kdz8xE2
 l6rLWPshRVqBZIipqO2P3EkypGWyWSKDmpwkHac/c/3XhvgQezkocuBUI/6r1qXmbUeD6B
 Avmzi3fXK4pUf6txi4Qtky+4o/mHUQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793103693;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itnkzj+j1917gGs7cmzTDwhYWfDguSX2Rh/soNs8FRQ=;
 b=57KYOnzPD8iYtOP+gACb/ZTHLhXXPIihASkByqbLEXd2zR1oTXnTrvCRAhnIlbfRoqynRO
 Gvn2y17vl7x81eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65CFD1321C;
 Tue, 27 Oct 2026 12:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id woECA02X4GroBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Oct 2026 12:21:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] system/qtest: Avoid fixed-size irq_levels array for
 IRQ intercept
In-Reply-To: <20261026125655.2668658-2-peter.maydell@linaro.org>
References: <20261026125655.2668658-1-peter.maydell@linaro.org>
 <20261026125655.2668658-2-peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 09:21:26 -0300
Message-ID: <87tsm7jpvd.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E65D01F7BE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,linaro.org:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.51
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The current implementation of the irq_intercept_out and
> irq_intercept_in commands uses a fixed-size static irq_levels[] array
> to track the state of the intercepted IRQ lines.  This is sized at
> MAX_IRQ == 256, which is smaller than some real device models use
> (for instance the GICv2 on the virt board has 384 inputs).  A test
> that tried to intercept the inputs to such a device and then assert
> an interrupt over 255 would overrun the array.
>
> Reimplement the IRQ interception so that it allocates an array
> of the required size rather than using a static one.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  system/qtest.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index 47c954838dd..a3de815ce65 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -57,12 +57,18 @@ static DeviceState *irq_intercept_dev;
>  static FILE *qtest_log_fp;
>  static QTest *qtest;
>  static GString *inbuf;
> -static int irq_levels[MAX_IRQ];
>  static GTimer *timer;
>  static bool qtest_opened;
>  static void (*qtest_server_send)(void*, const char*);
>  static void *qtest_server_send_opaque;
>  
> +typedef struct IrqInterceptState {
> +    int *irq_levels;
> +    int num_irqs;
> +} IrqInterceptState;
> +
> +IrqInterceptState irq_intercept_state;
> +
>  #define FMT_timeval "%.06f"
>  
>  /**
> @@ -327,9 +333,10 @@ void qtest_sendf(CharFrontend *chr, const char *fmt, ...)
>  
>  static void qtest_irq_handler(void *opaque, int n, int level)
>  {
> -    if (irq_levels[n] != level) {
> +    assert(n >= 0 && n < irq_intercept_state.num_irqs);
> +    if (irq_intercept_state.irq_levels[n] != level) {
>          CharFrontend *chr = &qtest->qtest_chr;
> -        irq_levels[n] = level;
> +        irq_intercept_state.irq_levels[n] = level;
>          qtest_sendf(chr, "IRQ %s %d\n",
>                      level ? "raise" : "lower", n);
>      }
> @@ -353,6 +360,13 @@ static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name,
>      *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
>  }
>  
> +static void qtest_init_irq_intercept(int num_irqs)
> +{
> +    g_free(irq_intercept_state.irq_levels);
> +    irq_intercept_state.irq_levels = g_new0(int, num_irqs);
> +    irq_intercept_state.num_irqs = num_irqs;
> +}
> +
>  static void qtest_process_command(CharFrontend *chr, gchar **words)
>  {
>      const gchar *command;
> @@ -413,12 +427,14 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>                  /* NULL is valid and matchable, for "unnamed GPIO" */
>                  if (g_strcmp0(ngl->name, words[2]) == 0) {
>                      int i;
> +                    qtest_init_irq_intercept(ngl->num_out);
>                      for (i = 0; i < ngl->num_out; ++i) {
>                          qtest_install_gpio_out_intercept(dev, ngl->name, i);
>                      }
>                      interception_succeeded = true;
>                  }
>              } else {
> +                qtest_init_irq_intercept(ngl->num_in);
>                  qemu_irq_set_observer(ngl->in, qtest_irq_handler,
>                                        ngl->num_in);
>                  interception_succeeded = true;
> @@ -861,8 +877,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
>           * used.  Injects an extra reset even when it's not used, and
>           * that can mess up tests, e.g. -boot once.
>           */
> -        for (i = 0; i < ARRAY_SIZE(irq_levels); i++) {
> -            irq_levels[i] = 0;
> +        if (irq_intercept_state.irq_levels) {
> +            for (i = 0; i < irq_intercept_state.num_irqs; i++) {
> +                irq_intercept_state.irq_levels[i] = 0;
> +            }
>          }
>  
>          g_clear_pointer(&timer, g_timer_destroy);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

