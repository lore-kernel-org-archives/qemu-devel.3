Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD9C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6ru-0004AH-UE; Thu, 22 Aug 2024 08:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6rt-00042H-0c
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:24:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6rq-000514-In
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:24:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3848201C3;
 Thu, 22 Aug 2024 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k26sI7QLHFDJVfcmb6pglUMwqKFFRmiGLPY93FTFh2k=;
 b=aqW9X/dElIE3hyl15jkBgwlInOc8YGBf5untmzAHziOiRotPrql0j/SYQZGDcorMNwlnNM
 UPCVwj32FXlXD5T5V9b1JCgOvWYB/3Aj2esqvDZ8/+yi111TW5wUBMqtJBTy5+D/9EVoAC
 0LVlRojtsHQ1IzVigIVsCR7yWta/AHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k26sI7QLHFDJVfcmb6pglUMwqKFFRmiGLPY93FTFh2k=;
 b=Lop+mDcUIrUFePcNi13USV1VMg1+MJjBgzmzlrw1VcNq9vUJE+bd0N4hXjIa2E6Tn79++V
 GdZoYVO1VtQ+8bCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M+aNBlnU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kvr/Vvem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k26sI7QLHFDJVfcmb6pglUMwqKFFRmiGLPY93FTFh2k=;
 b=M+aNBlnU6VlS9WOdY9sPhF34wmv4+KmoxwWeVIMpsb5elH869OqxdZzL8a04QdYa2vA3kr
 dwKo9tt877hf3/tk+TCWOPq++rgAcBfVil7AUkDGZjDN1FNl6K4+VOKjip2jItPj7D0b+8
 mN4TQAwAFO7ciWN0qup9KOVA5dLKahk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k26sI7QLHFDJVfcmb6pglUMwqKFFRmiGLPY93FTFh2k=;
 b=kvr/Vvem2kfruNfAzxK+oAy1Fgx4yoYlVuOBb6PnDbv6R+1f5lESGpHBAxQwydnRjT5+dU
 ngwinpRL2cHOnNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C279139D3;
 Thu, 22 Aug 2024 12:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tu7QDAQux2bAOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 12:24:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 4/9] tests/qtest/migration-helpers: Fix
 migrate_get_socket_address() leak
In-Reply-To: <20240820144912.320744-5-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-5-peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 09:24:33 -0300
Message-ID: <87r0agzqwu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E3848201C3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:dkim, suse.de:mid,
 suse.de:email, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In migrate_get_socket_address() we leak the SocketAddressList:
>  (cd build/asan && \
>   ASAN_OPTIONS="fast_unwind_on_malloc=0:strip_path_prefix=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../"
>   QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>   ./tests/qtest/migration-test --tap -k -p /x86_64/migration/multifd/tcp/tls/psk/match )
>
> [...]
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x563d7f22f318 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f318) (BuildId: 2ad6282fb5d076c863ab87f41a345d46dc965ded)
>     #1 0x7f9de3b39c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x563d7f3a119c in qobject_input_start_list qapi/qobject-input-visitor.c:336:17
>     #3 0x563d7f390fbf in visit_start_list qapi/qapi-visit-core.c:80:10
>     #4 0x563d7f3882ef in visit_type_SocketAddressList /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-visit-sockets.c:519:10
>     #5 0x563d7f3658c9 in migrate_get_socket_address tests/qtest/migration-helpers.c:97:5
>     #6 0x563d7f362e24 in migrate_get_connect_uri tests/qtest/migration-helpers.c:111:13
>     #7 0x563d7f362bb2 in migrate_qmp tests/qtest/migration-helpers.c:222:23
>     #8 0x563d7f3533cd in test_precopy_common tests/qtest/migration-test.c:1817:5
>     #9 0x563d7f34dc1c in test_multifd_tcp_tls_psk_match tests/qtest/migration-test.c:3185:5
>     #10 0x563d7f365337 in migration_test_wrapper tests/qtest/migration-helpers.c:458:5
>
> The code fishes out the SocketAddress from the list to return it, and the
> callers are freeing that, but nothing frees the list.
>
> Since this function is called in only two places, the simple fix is to
> make it return the SocketAddressList rather than just a SocketAddress,
> and then the callers can easily access the SocketAddress, and free
> the whole SocketAddressList when they're done.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

