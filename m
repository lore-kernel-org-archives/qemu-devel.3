Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1C0C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcR2T-0007z6-8D; Mon, 27 Jan 2025 10:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcR2R-0007ui-O5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:28:35 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcR2P-0004CM-Lu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:28:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C8F0D2110B;
 Mon, 27 Jan 2025 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737991708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Olm3MigGPobOrxa+dZ0z7MdgVyFwDTP22y0DTPKipgE=;
 b=aU+aTat1m5Gb9oGL+rgHJJkxBVcRqk8BGj9fZYF+sZJ6XNPCaENVC8QCYp/umlEkKhu/kt
 GkxIofrJJZsmBGI/G1AiZ/aS/QTfcL5lGp0Yh+FFSEpq3FXLL+VaGZyOpHYXYkwnLzfq3y
 4i/c5RrHWH9aM1cUtDawaK3+onpH4Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737991708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Olm3MigGPobOrxa+dZ0z7MdgVyFwDTP22y0DTPKipgE=;
 b=C0EOgbf5YaOzBjXifvMwiRoP+SS/PaQUyBGfzIT0MtxOh9AuHReaa8iT/rzhyv9a0U/Y4Q
 K1pvHMKAmf+kjHBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QjTpx8R4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P4snm04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737991707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Olm3MigGPobOrxa+dZ0z7MdgVyFwDTP22y0DTPKipgE=;
 b=QjTpx8R4L6qJ163OfpRZJcGeNtfrqW39Mjy5ZyEWhZhQdk3loW3JYOV+WSQc1PfDrD1vAO
 0MyzhAOHNUjdCJIYH2EKqYQ38dKtCT9l6CwKXRiDa/Cp0cwdYTUT32opDYbVrr6FYJQ2KB
 cRIeEBkPbkPMWzAAGEPidMpchWrFYsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737991707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Olm3MigGPobOrxa+dZ0z7MdgVyFwDTP22y0DTPKipgE=;
 b=P4snm04aYcMrS+A6IXegeK2FoMebGhS/xITLuJdYntqXAk+x5eDM3mQO0gS73nfWhGWS+A
 m0W+Emhi4zCc23AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D044137C0;
 Mon, 27 Jan 2025 15:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zKWKOhqml2eJTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Jan 2025 15:28:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ani Sinha <anisinha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 2/3] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
In-Reply-To: <20250120043847.954881-3-anisinha@redhat.com>
References: <20250120043847.954881-1-anisinha@redhat.com>
 <20250120043847.954881-3-anisinha@redhat.com>
Date: Mon, 27 Jan 2025 12:28:24 -0300
Message-ID: <877c6gs2cn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C8F0D2110B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ani Sinha <anisinha@redhat.com> writes:

> At present, the libqos/fw_cfg.c library does not support the modern DMA
> interface which is required to write to the fw_cfg files. It only uses the IO
> interface. Implement read and write methods based on DMA. This will enable
> developers to add tests that writes to the fw_cfg file(s). The structure of
> the code is taken from edk2 fw_cfg implementation. It has been tested by
> writing a qtest that writes to a fw_cfg file.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

