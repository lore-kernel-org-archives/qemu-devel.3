Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F49606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=a/g7imW+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d6YFAWCr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=a/g7imW+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d6YFAWCr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgEW-0001Ng-B1; Tue, 27 Oct 2026 08:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLgEU-0001NX-L5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:24:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLgES-0001fL-V0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:24:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 062A91F7BE;
 Tue, 27 Oct 2026 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793103887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=436DXlEJ6oa2kKQqC69gDDAQo711PyYPWljJ7y0ryFE=;
 b=a/g7imW+cuj7gAzQPEmM6M4Jw5OSWQlfzwdpog8yx/tzRRp2C1bB2H8Ykb1f9hrs4njZXj
 W2OmOOOjGS3boQZa8epQa8wTTXzS7gSilfBJV7XwVpTCwEXjwvgrmxt96QdVr6An8ItD5i
 OeD56li4bvwqa9RwAaP+YHEpfTGEb20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793103887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=436DXlEJ6oa2kKQqC69gDDAQo711PyYPWljJ7y0ryFE=;
 b=d6YFAWCrtlMCjZqkuhfNjsjFsCLyAz9E8xitGp/4qrIIEkpPj6AdQgw3jPfmUnqaKexzd5
 BOK5GJc6R9AJPvDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="a/g7imW+";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d6YFAWCr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793103887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=436DXlEJ6oa2kKQqC69gDDAQo711PyYPWljJ7y0ryFE=;
 b=a/g7imW+cuj7gAzQPEmM6M4Jw5OSWQlfzwdpog8yx/tzRRp2C1bB2H8Ykb1f9hrs4njZXj
 W2OmOOOjGS3boQZa8epQa8wTTXzS7gSilfBJV7XwVpTCwEXjwvgrmxt96QdVr6An8ItD5i
 OeD56li4bvwqa9RwAaP+YHEpfTGEb20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793103887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=436DXlEJ6oa2kKQqC69gDDAQo711PyYPWljJ7y0ryFE=;
 b=d6YFAWCrtlMCjZqkuhfNjsjFsCLyAz9E8xitGp/4qrIIEkpPj6AdQgw3jPfmUnqaKexzd5
 BOK5GJc6R9AJPvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C4A11321C;
 Tue, 27 Oct 2026 12:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 73uICA6Y4GrtCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Oct 2026 12:24:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] system/qtest: Check ngl->name for irq_intercept_in
In-Reply-To: <20261026125655.2668658-3-peter.maydell@linaro.org>
References: <20261026125655.2668658-1-peter.maydell@linaro.org>
 <20261026125655.2668658-3-peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 09:24:44 -0300
Message-ID: <87qzhbjppv.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 062A91F7BE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> Currently we check the name of the NamedGPIOList when doing
> irq_intercept_out, but not for irq_intercept_in.  Even though we
> don't currently support irq_intercept_in on named GPIO lines, we
> still need to check the name, because otherwise we will install the
> observer on every set of GPIO inputs the device has, rather than only
> for the unnamed GPIO inputs.
>
> This doesn't currently affect any test cases, because of all the
> tests which use irq_intercept_in only tests/qtest-l2vic-test.c uses
> it on a device that creates named GPIO inputs.  That device has both
> unnamed GPIO inputs and a named GPIO input "reset".  The effect is
> that a change in the "reset" line state looks like a change in
> interrupt input line 0; but since the test doesn't cause "reset" to
> change this doesn't happen and there are no observable effects of the
> bug.
>
> Check the ngl->name against the specified one for both input
> and output interception. (Currently this will be equivalent to
> a check against NULL for input intercepts.) As we're now checking
> for an exact name match unconditionally, we can break out of the
> loop as soon as we've found it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The forbidding of intercept_in for named GPIOs is done before
> the loop. I think the only reason we forbid it is that we don't
> have a mechanism for the "IRQ raise"/"IRQ lower" messages to
> say what GPIO they're for. Similarly I don't think supporting
> intercepts of multiple devices simultaneously would be too
> hard; but I'd rather wait til we have a test that actually wants
> that functionality.
> ---
>  system/qtest.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index a3de815ce65..5ff3f9f27d8 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -422,23 +422,24 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>          }
>  
>          QLIST_FOREACH(ngl, &dev->gpios, node) {
> -            /* We don't support inbound interception of named GPIOs yet */
> +            /* NULL is valid and matchable, for "unnamed GPIO" */
> +            if (g_strcmp0(ngl->name, words[2]) != 0) {
> +                continue;
> +            }
> +
>              if (is_outbound) {
> -                /* NULL is valid and matchable, for "unnamed GPIO" */
> -                if (g_strcmp0(ngl->name, words[2]) == 0) {
> -                    int i;
> -                    qtest_init_irq_intercept(ngl->num_out);
> -                    for (i = 0; i < ngl->num_out; ++i) {
> -                        qtest_install_gpio_out_intercept(dev, ngl->name, i);
> -                    }
> -                    interception_succeeded = true;
> +                int i;
> +                qtest_init_irq_intercept(ngl->num_out);
> +                for (i = 0; i < ngl->num_out; ++i) {
> +                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
>                  }
>              } else {
>                  qtest_init_irq_intercept(ngl->num_in);
>                  qemu_irq_set_observer(ngl->in, qtest_irq_handler,
>                                        ngl->num_in);
> -                interception_succeeded = true;
>              }
> +            interception_succeeded = true;
> +            break;
>          }
>  
>          if (interception_succeeded) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

