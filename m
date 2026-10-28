Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67194606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MLd4bEt/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Pm4F78bM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0r8sMvQZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BiNZQVMD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3iy-0002K4-AX; Wed, 28 Oct 2026 09:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xM3ix-0002Ju-De
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:29:51 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xM3iv-0006sA-Bs
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:29:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65A452211D;
 Wed, 28 Oct 2026 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793194187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u0001oTc49Ugg0a6W96NJP7IZnakZ2rNConViXEMVnM=;
 b=MLd4bEt/AL94nk3O7Pu1fpyLqWgloakIhzJKwi2Tj9D7S1zqr9fGhAC1KK604d5oSThkqF
 OkNRiM6AJUCo9NN2OGkwY7DZrRwnrIVJ/BcyN9cElqtQ3p8nTc4WqHiU+JTr9Y7ccl6+gI
 33fxmgHQRFgXK1SvQlfnYS06/Rusu60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793194187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u0001oTc49Ugg0a6W96NJP7IZnakZ2rNConViXEMVnM=;
 b=Pm4F78bMgdAVl/7jld9nRljedIEwd1NT9Mnz7WgHNzEnvjSBGoz6TbtZyguYmNnTtr3CIw
 iT8V+FoBzbmuAlDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0r8sMvQZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BiNZQVMD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793194186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u0001oTc49Ugg0a6W96NJP7IZnakZ2rNConViXEMVnM=;
 b=0r8sMvQZRpWP8NL5d5SYOWsHMIvP8tefWjXNRN62SsyTp+f6/2V5xN4kd3c9G9MSpo8Fnl
 7OHRc4XNzhRNBppj9khAqdkODBAennP0NcLRTzM746y76L/g4n/k43geyXLAYfgu0a8RYD
 PqVBpJs6IJ5wSbdvSHeDeMbiUCDy0Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793194186;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u0001oTc49Ugg0a6W96NJP7IZnakZ2rNConViXEMVnM=;
 b=BiNZQVMDPMTWIyuw+UpVyt2OQLzAI8KmP82zukGaEJU/feB8PfkoWpqPvJ4ZHiWBmOTZjN
 q5FRq2oMpWIVYcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF70113419;
 Wed, 28 Oct 2026 13:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RgyyHMn44WrEOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Oct 2026 13:29:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Jason Wang <jasowangio@gmail.com>, Samuel
 Thibault <samuel.thibault@ens-lyon.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Dani?=
 =?utf-8?Q?el_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/4] tests/qtest: Make netfilter tests accept padded
 ethernet packets
In-Reply-To: <20261027174625.4025878-2-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
 <20261027174625.4025878-2-peter.maydell@linaro.org>
Date: Wed, 28 Oct 2026 10:29:42 -0300
Message-ID: <87a4nyj6m1.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[gmail.com,rsg.ci.i.u-tokyo.ac.jp,ens-lyon.org,redhat.com,fujitsu.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_SEVEN(0.00)[11];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, nongnu.org:email, suse.de:email, suse.de:dkim,
 linaro.org:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: 65A452211D
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Currently the various netfilter tests assume and assert that the data
> they get from the filter is an exact match for the data that they
> send in to it via the net socket backend.  This happens to be the
> case currently because the net socket backend fails to pad frames to
> the ethernet minimum when the device expects that (unlike e.g.  the
> tap backend).  When we fix the socket backend to honour the device's
> request for padding, the netfilter will see padded packets for
> devices that require them (which is most of them), and not for those
> that don't (notably virtio-net).
>
> This seems best considered as a test error: if you're using netfilter
> to look at what a particular network device is receiving, you want to
> actually see what it is receiving.  And most real-world users of
> filtering will be doing it with the backends like TAP that were
> already doing pad-before-filter; it's only the oddball backends like
> 'socket' that forgot to pad.
>
> Make the test cases accept as valid both padded and unpadded frames.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/test-filter-buffer.c     | 4 +++-
>  tests/qtest/test-filter-mirror.c     | 4 +++-
>  tests/qtest/test-filter-redirector.c | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filter-buffer.c
> index 441cbb975ca..418caccf00a 100644
> --- a/tests/qtest/test-filter-buffer.c
> +++ b/tests/qtest/test-filter-buffer.c
> @@ -11,6 +11,7 @@
>  #include "qobject/qdict.h"
>  #include "qemu/iov.h"
>  #include "qemu/sockets.h"
> +#include "net/eth.h"
>  
>  /*
>   * Test that changing interval at runtime affects packet release timing.
> @@ -148,7 +149,8 @@ static void test_change_interval_timer(void)
>      ret = recv(recv_sock, &len, sizeof(len), 0);
>      g_assert_cmpint(ret, ==, sizeof(len));
>      len = ntohl(len);
> -    g_assert_cmpint(len, ==, sizeof(send_buf));
> +    /* The snooped network device might or might not have asked for padding */
> +    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
>  
>      ret = recv(recv_sock, recv_buf, len, 0);
>      g_assert_cmpint(ret, ==, len);
> diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
> index 723d2c2f291..9972712cb49 100644
> --- a/tests/qtest/test-filter-mirror.c
> +++ b/tests/qtest/test-filter-mirror.c
> @@ -15,6 +15,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "net/eth.h"
>  
>  static void test_mirror(void)
>  {
> @@ -58,7 +59,8 @@ static void test_mirror(void)
>      g_assert_cmpint(ret, ==, sizeof(len));
>      len = ntohl(len);
>  
> -    g_assert_cmpint(len, ==, sizeof(send_buf));
> +    /* The snooped network device might or might not have asked for padding */
> +    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
>      recv_buf = g_malloc(len);
>      ret = recv(recv_sock[0], recv_buf, len, 0);
>      g_assert_cmpint(ret, ==, len);
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
> index 5540c232c0b..a4f9b73c72a 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -57,6 +57,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "net/eth.h"
>  
>  static void test_redirector_tx(void)
>  {
> @@ -115,7 +116,8 @@ static void test_redirector_tx(void)
>      g_assert_cmpint(ret, ==, sizeof(len));
>      len = ntohl(len);
>  
> -    g_assert_cmpint(len, ==, sizeof(send_buf));
> +    /* The snooped network device might or might not have asked for padding */
> +    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
>      recv_buf = g_malloc(len);
>      ret = recv(recv_sock, recv_buf, len, 0);
>      g_assert_cmpint(ret, ==, len);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

