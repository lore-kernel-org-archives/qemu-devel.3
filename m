Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07678106B504
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5VMk-0005bu-6V; Wed, 25 Mar 2026 17:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5VMg-0005bO-52
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:02:10 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5VMe-0004TK-Gr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:02:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 521C95BCF8;
 Wed, 25 Mar 2026 21:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774472526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOl4HX8k1ATCUErLnwQM1O6qkxzlv6DDPzoG/jScB1U=;
 b=x8bNr4cO0I5Uv5KL/9v2UTfhbZzudt0QS21QOi8v3pDLZMhZxGA9QXtSL53KeqYRYvzE5Z
 9i8e8PbfyV+l8jxs+ALbkKwSvmEJBKPGlMjP1ZKnfIALZbqorfWGl7kGORIfe0Wvl6oYhb
 3MktnFrbPN2PXITD+8qEg+rWhHJyfvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774472526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOl4HX8k1ATCUErLnwQM1O6qkxzlv6DDPzoG/jScB1U=;
 b=5KNnBAGynU1vxxy6dsmwWNhEMxildYR2HEY0fUaEw4k5zPcrj2hs830JYLFqiCCqawhu99
 ElUdjjQDjUWvH4BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774472526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOl4HX8k1ATCUErLnwQM1O6qkxzlv6DDPzoG/jScB1U=;
 b=x8bNr4cO0I5Uv5KL/9v2UTfhbZzudt0QS21QOi8v3pDLZMhZxGA9QXtSL53KeqYRYvzE5Z
 9i8e8PbfyV+l8jxs+ALbkKwSvmEJBKPGlMjP1ZKnfIALZbqorfWGl7kGORIfe0Wvl6oYhb
 3MktnFrbPN2PXITD+8qEg+rWhHJyfvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774472526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOl4HX8k1ATCUErLnwQM1O6qkxzlv6DDPzoG/jScB1U=;
 b=5KNnBAGynU1vxxy6dsmwWNhEMxildYR2HEY0fUaEw4k5zPcrj2hs830JYLFqiCCqawhu99
 ElUdjjQDjUWvH4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D141A4A0A2;
 Wed, 25 Mar 2026 21:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YfocJU1NxGl/WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Mar 2026 21:02:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Koushik Dutta
 <kdutta@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [RFC PATCH 1/8] tests: vhost-vdpa: add initial VDUSE-based
 vhost-vdpa tests
In-Reply-To: <20260305163938.3200787-2-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
 <20260305163938.3200787-2-eperezma@redhat.com>
Date: Wed, 25 Mar 2026 18:02:03 -0300
Message-ID: <87jyuzk4hg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Eugenio P=C3=A9rez <eperezma@redhat.com> writes:

> Based on vhost-user tests, the qos register itself as a VDUSE device and
> receives the events from QEMU.
>
> The test infrastructure creates a thread that acts as a VDUSE device,
> while the regular test thread is managing QEMU.
>
> This basic test just verify that the guest memory ring addresses are
> accessible, similar to the already existing test in vhost-user.
>
> This enables automated testing of vhost-vdpa code paths that previously
> required manual testing with real hardware.
>
> Changes from vhost-user test:
> * Automatic cleanup of many things.
> * Handle the vduse fd and timeout.
> * VDPA device cannot be removed before deleting QEMU, killing QEMU in
>   vhost_vdpa_test_cleanup.
> * Read in enable callbacks, and the actual test_read_guest_mem is just
>   waiting.
> * Add vhost_vdpa_thread to abstract fd monitoring
> * Use QemuMutex and QemuConf for scoped cleanup
>
> RFC: I'm not sure if this is the right place to add the tests in meson.
> Also, a few things are just with asserts() or g_spawn(), instead of
> more elegant code.
>
> Also, I don't know how to include the libvduse.a library as meson
> complains it's out of the tests/ directory, so I'm including the .c
> directly.  Ugly but it works.
>

The proper way should be the following. Unfortunately, you'll have to
rewrite some parts of the test as it currently accesses symbols internal
to the library.

-- >8 --
From ca4418e57a2de83b1fea49f589f2c27ba424039b Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Wed, 25 Mar 2026 17:54:41 -0300
Subject: [PATCH] tmp

---
 tests/qtest/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b002ea1ce..d6cf0e25ad 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -348,6 +348,7 @@ if have_tools and have_vhost_user_blk_server
 endif
 if have_libvduse and have_vhost_vdpa
   qos_test_ss.add(files('vhost-vdpa-test.c'))
+  qos_test_ss.add(libvduse)
 endif
=20
 tpmemu_files =3D ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
@@ -395,7 +396,8 @@ qtests =3D {
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-  'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
+  'qos-test': [chardev, io, qos_test_ss.apply({}).sources(),
+               qos_test_ss.apply({}).dependencies()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
--=20
2.51.0

