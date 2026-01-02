Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F63FA3748
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 13:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbfMY-0004nK-TA; Fri, 02 Jan 2026 08:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vbfMY-0004m1-0j
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:38:42 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vbfMV-000297-0t
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:38:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC52233681;
 Fri,  2 Jan 2026 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767361116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2TXDsTREjR9NXCjlruzTC5jpxdKQPlmBRxPq8UHSXg=;
 b=zx+WP0Q1QlsAHQYcirbd4gpGkX6SJi1AUuDpcqcgbCPvQjbpTxPkfBG2s0c99TMfU/bziW
 7P6NYJRV1et3hVLqkWAriMKvR9lnHNSmufsf4ubs2oXVki4biN0oxBNhxVOe8iaUXhYTwz
 iLd9D8OJdbsWDQOe4GDDbDt+DyGZ0JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767361116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2TXDsTREjR9NXCjlruzTC5jpxdKQPlmBRxPq8UHSXg=;
 b=V9riyUq2Huy8xr/bD3q+aSiG6+DTPQaTlv6oGDLFXPVBO4oK9HVSIGIEzZBo0zmKKfJbA+
 KELZmVCnywtp7lDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YAGlXy/l";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lVJ8fXb8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767361114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2TXDsTREjR9NXCjlruzTC5jpxdKQPlmBRxPq8UHSXg=;
 b=YAGlXy/ldOk2t998emL54wLqUiTNyVUaUosqHLT2Nf976ComoUHzdFQ+MKm045wVeIqUIh
 tRtz56QvXEBQsTENURwvTdgJWzO9hwfaFsxHV8SX4+MZovMz9Y8tPlF4gfha4LXHylatjM
 d/MpLlX8eiBRUwOoak1ehD6vw6aC99w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767361114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2TXDsTREjR9NXCjlruzTC5jpxdKQPlmBRxPq8UHSXg=;
 b=lVJ8fXb8XCtLlRqK7NaY0e/lS2Kr2zx7Wri9EBY5AAxykOwek4XJHS/T4Kzdr46KNn1K0n
 xI1a9sGxsOjLspDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A04213A90;
 Fri,  2 Jan 2026 13:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tn0NB1rKV2kFLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Jan 2026 13:38:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ilia Levi <ilia.levi@intel.com>, qemu-devel@nongnu.org
Cc: ilia.levi@intel.com, jeuk20.kim@samsung.com, lvivier@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 2/2] tests/qtest/ufs-test: Add test for mcq completion
 queue wraparound
In-Reply-To: <20251222123559.3387-3-ilia.levi@intel.com>
References: <20251222123559.3387-1-ilia.levi@intel.com>
 <20251222123559.3387-3-ilia.levi@intel.com>
Date: Fri, 02 Jan 2026 10:38:31 -0300
Message-ID: <87fr8orv6w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.93 / 50.00]; BAYES_HAM(-2.42)[97.36%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_FIVE(0.00)[6]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DC52233681
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ilia Levi <ilia.levi@intel.com> writes:

> Added a test that sends 32 NOP Out commands asynchronously. Since the CQ
> has 31 entries by default, this tests the scenario where CQ processing
> needs to wait for space to become available.
>
> Additionally, added two minor fixes to existing tests:
> * advance CQ head after reading from CQ
> * initialize command descriptor slots bitmap in ufs_init()
>
> Signed-off-by: Ilia Levi <ilia.levi@intel.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

