Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1bDA8VkC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9A6ghXOp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1EfG7Vsb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YqMD0JI4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNvJ-0007yN-PL; Fri, 20 Nov 2026 07:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xUNvH-0007xu-85
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:40:59 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xUNvF-0006eO-BC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:40:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C15F9225DB;
 Fri, 20 Nov 2026 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795178450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsJ4Z8JgmOd5gSvDb3LfffnNceNPPK7xIxMl8U3FZcI=;
 b=1bDA8VkChh0Gnpic8DnZi65p807XTByTmmi14au3NeQE1TbJFO4iDsmVWRFOJZfAmrpKGE
 AF4HxrtjjhY7LqwBGdoC54cr4jrWtpCRz7M0r1E6OCq+SLd0wbHj4w9LRR5pUVTHGXRzpC
 kCmTAMNezWlvVtIKb1QPGs+Wo8M0U8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795178450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsJ4Z8JgmOd5gSvDb3LfffnNceNPPK7xIxMl8U3FZcI=;
 b=9A6ghXOp90FRwc+SgZmJ1BHcLaqVsmYPkBC4AcpZzcWIk68EdJQPPw4NsMjXPlWnJRMCSw
 rwk1HMHnheN0ytBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1EfG7Vsb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YqMD0JI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795178449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsJ4Z8JgmOd5gSvDb3LfffnNceNPPK7xIxMl8U3FZcI=;
 b=1EfG7Vsb15gstdejhSa9DaN789e++j4uMKYjOwcFw5Xq4iVZTPZB0safXP6NzC1TlaMQyy
 t+/M4wPe7Fy9xdwftRJ6kssBDxStoRDLfiEu4hinW/sovkTn9n3waL9s/XizXt7XDIom1g
 3E9sTkD6qkk/2LBheIBc86eb8zXkXWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795178449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsJ4Z8JgmOd5gSvDb3LfffnNceNPPK7xIxMl8U3FZcI=;
 b=YqMD0JI4myvXzFHfgIoZV+CMsvKPdf/hUSnmJqo+oFbzQkUJGKv70FzB1DZkYJ8KWkRX+W
 CsC3vaegwSb/kjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 408971342D;
 Fri, 20 Nov 2026 12:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yBTBMtA/AGvTPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 20 Nov 2026 12:40:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-11.2 00/14] Hexagon: fix systests + migration
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 09:40:41 -0300
Message-ID: <87mrr3smk6.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C15F9225DB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, qualcomm.com:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.51
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> The systests/arch tarballs were crafted while testing a downstream fork.
>
> Enabling the omitted tests revealed a few remaining bugs in 11.2.  Add
> those tests and the associated fixes, plus a couple of fixes from Marco's
> recent series.
>
> Brian Cain (12):
>   target/hexagon: fix get_exe_mode assertion in hexagon_stop_thread
>   target/hexagon: deliver floating point exceptions after the packet
>   target/hexagon: report the faulting packet for stack limit exceptions
>   target/hexagon: take exceptions for cache operations
>   target/hexagon: raise decode failures at the faulting packet
>   hw/hexagon: update the glob-reg vmstate ver
>   tests/functional/hexagon: run the rest of the tests
>   tests/tcg/hexagon: packet and COF corner cases
>   hw/hexagon: honor configured RAM backends
>   hw/hexagon: version the virt machine type
>   tests/qtest/migration: add Hexagon to the migration framework
>   tests/qtest: add a Hexagon migration state test
>
> Marco Liebel (2):
>   target/hexagon: read the old predicate value through C4
>   target/hexagon: bound packet lookahead to the current page
>
>  MAINTAINERS                                 |   2 +
>  docs/system/hexagon/machines.rst            |   3 +
>  target/hexagon/gen_tcg.h                    |  18 +-
>  target/hexagon/helper.h                     |   4 +-
>  target/hexagon/translate.h                  |   6 +-
>  tests/qtest/migration/bootfile.h            |   6 +
>  tests/qtest/migration/hexagon/a-b-kernel.h  |  21 ++
>  tests/qtest/migration/hexagon/guest.h       |  47 +++
>  tests/qtest/migration/hexagon/state.h       |  29 ++
>  hw/hexagon/hex-subsys.c                     |  10 +-
>  hw/hexagon/hexagon_globalreg.c              |   4 +-
>  hw/hexagon/virt.c                           |  37 +++
>  target/hexagon/arch.c                       |   9 +-
>  target/hexagon/cpu_helper.c                 |   1 +
>  target/hexagon/genptr.c                     |   3 +-
>  target/hexagon/hexswi.c                     |   1 +
>  target/hexagon/op_helper.c                  |  46 ++-
>  target/hexagon/translate.c                  |  28 +-
>  tests/qtest/hexagon-config-test.c           |  26 ++
>  tests/qtest/hexagon-migration-test.c        | 312 ++++++++++++++++++++
>  tests/qtest/migration/bootfile.c            |   4 +
>  tests/qtest/migration/framework.c           |   8 +
>  tests/tcg/hexagon/brev.c                    |  25 ++
>  tests/tcg/hexagon/circ.c                    |  42 +++
>  tests/tcg/hexagon/dual_stores.c             |  34 +++
>  tests/tcg/hexagon/mem_noshuf.c              |  58 +++-
>  tests/tcg/hexagon/packet_user.c             |  38 +++
>  tests/tcg/hexagon/preg_alias.c              |  58 ++++
>  tests/tcg/hexagon/test_cond_branch.c        |  95 ++++++
>  tests/tcg/hexagon/usr.c                     |  33 +++
>  tests/functional/hexagon/meson.build        |   2 +
>  tests/functional/hexagon/test_arch_tests.py | 114 ++++++-
>  tests/functional/hexagon/test_linux.py      |  62 ++++
>  tests/functional/hexagon/test_systests.py   | 259 +++++++++++++++-
>  tests/qtest/meson.build                     |   5 +-
>  tests/qtest/migration/Makefile              |   2 +-
>  tests/qtest/migration/hexagon/Makefile      |  48 +++
>  tests/qtest/migration/hexagon/a-b-kernel.S  |  37 +++
>  tests/qtest/migration/hexagon/guest.S       | 124 ++++++++
>  tests/tcg/hexagon/meson.build               |   1 +
>  tests/tcg/hexagon/test_dotnew.S             |  34 ++-
>  tests/tcg/hexagon/test_packet.S             |  46 ++-
>  42 files changed, 1700 insertions(+), 42 deletions(-)
>  create mode 100644 tests/qtest/migration/hexagon/a-b-kernel.h
>  create mode 100644 tests/qtest/migration/hexagon/guest.h
>  create mode 100644 tests/qtest/migration/hexagon/state.h
>  create mode 100644 tests/qtest/hexagon-migration-test.c
>  create mode 100644 tests/tcg/hexagon/packet_user.c
>  create mode 100755 tests/functional/hexagon/test_linux.py
>  create mode 100644 tests/qtest/migration/hexagon/Makefile
>  create mode 100644 tests/qtest/migration/hexagon/a-b-kernel.S
>  create mode 100644 tests/qtest/migration/hexagon/guest.S

Let's leave the migration tests for the next cycle, please.

