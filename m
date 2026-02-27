Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A8CFD530A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3Hi-0007hu-Ci; Fri, 27 Feb 2026 14:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw3Hg-0007hd-Va
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:13:57 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw3Hf-0007If-Cg
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:13:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DD5E3F854;
 Fri, 27 Feb 2026 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772219633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJ3JOIG1ljnjBjv6HL31qwQmbi0dh+i/yCUBN+sYCdk=;
 b=FyINWOb5TP17vVzIG9B8fGHthcyGyrIpirHPgDtfZu8SleQVfwlAicwpsdwSMxE38v0OxP
 BBpzapNs/xsd06DOY6df0EDG7WRV6JQ2mURIaVJ8RwrggRCkWwLJ847p+ZfKihZRQzBnZZ
 CBlLKXE3ApPDpD9zlELZug5FhKSlYWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772219633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJ3JOIG1ljnjBjv6HL31qwQmbi0dh+i/yCUBN+sYCdk=;
 b=jeIu8TZww0rYrKv5a7XBCL+rpnwBilM2Lxg/PlqgEd7zJb4tUoIWrxuLmFJiSraDvis0jq
 PIz59JetFi+iq7Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FyINWOb5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jeIu8TZw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772219633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJ3JOIG1ljnjBjv6HL31qwQmbi0dh+i/yCUBN+sYCdk=;
 b=FyINWOb5TP17vVzIG9B8fGHthcyGyrIpirHPgDtfZu8SleQVfwlAicwpsdwSMxE38v0OxP
 BBpzapNs/xsd06DOY6df0EDG7WRV6JQ2mURIaVJ8RwrggRCkWwLJ847p+ZfKihZRQzBnZZ
 CBlLKXE3ApPDpD9zlELZug5FhKSlYWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772219633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJ3JOIG1ljnjBjv6HL31qwQmbi0dh+i/yCUBN+sYCdk=;
 b=jeIu8TZww0rYrKv5a7XBCL+rpnwBilM2Lxg/PlqgEd7zJb4tUoIWrxuLmFJiSraDvis0jq
 PIz59JetFi+iq7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047293EA69;
 Fri, 27 Feb 2026 19:13:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NrvdLvDsoWm9IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 19:13:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/4] tests/qtest/iommu-smmuv3-test: Free QPCIDevice
In-Reply-To: <20260227135736.2280161-5-peter.maydell@linaro.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-5-peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 16:13:50 -0300
Message-ID: <87fr6m579t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7DD5E3F854
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The QPCIDevice we get via qpci_device_foreach() is allocated
> memory, and we need to g_free() it after use.
>
> This fixes asan leaks like this:
>
> Direct leak of 64 byte(s) in 1 object(s) allocated from:
>     #0 0x622a5f16913d in calloc (/home/pm215/qemu/build/arm-clang/tests/qtest/iommu-smmuv3-test+0x1d413d) (BuildId: bc598be1f4ad6d1a9a600c55aeef36108bdb6a04)
>     #1 0x73ee41c0f771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x622a5f1d4cec in qpci_device_find /home/pm215/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:82:11
>     #3 0x622a5f1d4cec in qpci_device_foreach /home/pm215/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:34:19
>     #4 0x622a5f23cc73 in setup_qtest_pci_device /home/pm215/qemu/build/arm-clang/../../tests/qtest/iommu-smmuv3-test.c:45:5
>     #5 0x622a5f23cc73 in run_smmuv3_translation /home/pm215/qemu/build/arm-clang/../../tests/qtest/iommu-smmuv3-test.c:74:11
>
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/iommu-smmuv3-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
> index cced49a9b6..dae9821b92 100644
> --- a/tests/qtest/iommu-smmuv3-test.c
> +++ b/tests/qtest/iommu-smmuv3-test.c
> @@ -77,6 +77,7 @@ static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
>      g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
>                     cfg->trans_mode, cfg->sec_sid);
>      qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
> +    g_free(dev);
>      qtest_quit(qts);
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

