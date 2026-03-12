Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF21106703F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0hGh-0004iE-TV; Thu, 12 Mar 2026 10:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0hGb-0004hc-GZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:44:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0hGY-0003kQ-H2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:44:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 300B44D259;
 Thu, 12 Mar 2026 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773326634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCzthHyL0nsEvZBvIXfLXlpMBfpZ0CAJ44BEwnVN+UA=;
 b=xXV7Z+oRA39bb3qCBCsRrbmbLi9hiqOLwcYpgEi1cMlMTtF2EcZgCYQ1jKtFgACcCWvmbL
 6tRuOXfVqf9MHl435O3dG7nn8h5uFCLiodERZyU1gvgAKbsboc6Y05P1X38DEjt9BVhEmz
 x0ONgxxhec9uDLCUVzWkRHqD3TGcmcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773326634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCzthHyL0nsEvZBvIXfLXlpMBfpZ0CAJ44BEwnVN+UA=;
 b=2//Ad3rnaQ4/dwzqCvV6RWACqT41aXtDGAHyOuvZLGq16G00CQ9Q+95kVtkKzq5ng7r3L3
 rx/bs4O7hxKHXlDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773326634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCzthHyL0nsEvZBvIXfLXlpMBfpZ0CAJ44BEwnVN+UA=;
 b=xXV7Z+oRA39bb3qCBCsRrbmbLi9hiqOLwcYpgEi1cMlMTtF2EcZgCYQ1jKtFgACcCWvmbL
 6tRuOXfVqf9MHl435O3dG7nn8h5uFCLiodERZyU1gvgAKbsboc6Y05P1X38DEjt9BVhEmz
 x0ONgxxhec9uDLCUVzWkRHqD3TGcmcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773326634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCzthHyL0nsEvZBvIXfLXlpMBfpZ0CAJ44BEwnVN+UA=;
 b=2//Ad3rnaQ4/dwzqCvV6RWACqT41aXtDGAHyOuvZLGq16G00CQ9Q+95kVtkKzq5ng7r3L3
 rx/bs4O7hxKHXlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D4740006;
 Thu, 12 Mar 2026 14:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6mqPGSnRsmlpBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Mar 2026 14:43:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org,
 ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: Add hexagon boot-serial-test
In-Reply-To: <20260311042019.1085030-10-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-10-brian.cain@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 11:43:51 -0300
Message-ID: <873425yuoo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[oss.qualcomm.com,linaro.org,gmail.com,quicinc.com,rev.ng,redhat.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> Add boot-serial-test support for Hexagon architecture using the virt
> machine.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/qtest/boot-serial-test.c | 8 ++++++++
>  tests/qtest/meson.build        | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
> index bcd0a9c50e7..37fee7a91c4 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -142,6 +142,13 @@ static const uint8_t kernel_stm32vldiscovery[] = {
>      0x04, 0x38, 0x01, 0x40                  /* 0x40013804 = USART1 TXD */
>  };
>  
> +static const uint8_t bios_hexagon[] = {
> +    0x00, 0x40, 0x00, 0x01,                 /* immext(#0x10000000) */
> +    0x00, 0xc0, 0x00, 0x78,                 /* r0 = ##0x10000000 */
> +    0x54, 0xc0, 0x00, 0x3c,                 /* memb(r0+#0) = #0x54 Write 'T' */
> +    0xf8, 0xff, 0xff, 0x59                  /* jump 0x0 ; Loop back to start */
> +};
> +
>  typedef struct testdef {
>      const char *arch;       /* Target architecture */
>      const char *machine;    /* Name of the machine */
> @@ -194,6 +201,7 @@ static const testdef_t tests[] = {
>      { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
>      { "arm", "stm32vldiscovery", "", "T",
>        sizeof(kernel_stm32vldiscovery), kernel_stm32vldiscovery },
> +    { "hexagon", "virt", "", "TT", sizeof(bios_hexagon), NULL, bios_hexagon },
>  
>      { NULL }
>  };
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ba9f59d2f8f..d83cb05cc8c 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -290,6 +290,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : [])
>  
> +qtests_hexagon = ['boot-serial-test']
> +
>  qos_test_ss = ss.source_set()
>  qos_test_ss.add(
>    'ac97-test.c',

Reviewed-by: Fabiano Rosas <farosas@suse.de>

