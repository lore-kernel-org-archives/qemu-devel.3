Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A980CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 14:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL074-0000Bl-T4; Thu, 07 May 2026 10:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wL06z-0000Ag-G5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:54:02 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wL06w-0004W6-VE
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:54:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 686DC6C499;
 Thu,  7 May 2026 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778165636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQDL6hTg6yASUncl8kafWCBoYsqVD6AVfeaa+u09+7A=;
 b=CHJ3xdwXrBEtXgNYBmFYkUmQ9N2rnwKe0HxbrjbyuRi3jud0twp79EFGzX0DUuqUBU2G+e
 19RWUZFzOYNeVSXLH7RoTi6fujGJ3mPvKTjAAxt8MY6IoQ37S2gGz/N25vTcopLGGZx9jH
 HpUpRmBa7Jtk3X8KAGKrpd9uu2AeMlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778165636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQDL6hTg6yASUncl8kafWCBoYsqVD6AVfeaa+u09+7A=;
 b=H0263UUevxejG/eaalwmrJF3oenbm/alIemh3nyfiafo5Jwa1jPUz5PWAvI3MsD6Hha1UK
 GPcgpuerUmEi7rBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T31wCy7N;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wcZpspuh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778165632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQDL6hTg6yASUncl8kafWCBoYsqVD6AVfeaa+u09+7A=;
 b=T31wCy7NqgwuArhTA+j2848VYBoBhaRoInAAR3upW4J1mLImHd9iAdKCl8mbhLaL+Sm9KX
 bGotSh+/KyotvjWnsdilHhXrjxko4Posq34t/FEST3LkncofeEj8SrGSXqHTQ0hVV5SYlU
 gTZHHgXTltMkg4qgRXlMuiGoVj6Pun4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778165632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQDL6hTg6yASUncl8kafWCBoYsqVD6AVfeaa+u09+7A=;
 b=wcZpspuhpRmYpqXLc9y80YlAVUJbDXg8q/wR+Qc2Wfb1+fPK3EpmnrwHgnNWfE1lE2R30f
 6UBOxBfHZ3jEPyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06E77593A7;
 Thu,  7 May 2026 14:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 03IvMn+n/GmcTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 May 2026 14:53:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/iommu-smmuv3-test: Skip if no TCG GICv3
 device present
In-Reply-To: <20260507144831.1604398-1-peter.maydell@linaro.org>
References: <20260507144831.1604398-1-peter.maydell@linaro.org>
Date: Thu, 07 May 2026 11:53:49 -0300
Message-ID: <87cxz7xoci.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,nongnu.org:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 686DC6C499
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On a KVM-only (--disable-tcg) build, the iommu-smmuv3 qtest fails:
>
> qemu-system-aarch64: QTest does not support GICv3 emulation
> Broken pipe
> ../../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>
> This is because the test runs the virt board with the qtest
> accelerator and gic-version=3.  In the virt board this selects the
> TCG (emulated) GICv3, but in a --disable-tcg build we don't compile
> that device, only the KVM GICv3 (which isn't usable with qtest).
>
> Add a check to the test so we skip it if the arm-gicv3 device isn't
> in the QEMU binary.
>
> Cc: qemu-stable@nongnu.org
> Fixes: d8d19c31b220142641 ("tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Looks like our CI compile-tests the --disable-tcg build but doesn't
> try to run "make check" on it.
> ---
>  tests/qtest/iommu-smmuv3-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
> index dae9821b92..708fae5fd3 100644
> --- a/tests/qtest/iommu-smmuv3-test.c
> +++ b/tests/qtest/iommu-smmuv3-test.c
> @@ -64,6 +64,11 @@ static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
>          g_test_skip("virt machine not available");
>          return;
>      }
> +    if (!qtest_has_device("arm-gicv3")) {
> +        /* This can happen for a KVM-only build: qtest uses the TCG GICv3 */
> +        g_test_skip("gicv3 not available");
> +        return;
> +    }
>  
>      /* Initialize QEMU environment for SMMU testing */
>      qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "

Reviewed-by: Fabiano Rosas <farosas@suse.de>

