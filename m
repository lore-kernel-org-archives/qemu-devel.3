Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA28BC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA4pI-0003Vu-Qq; Fri, 25 Sep 2026 08:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA4pC-0003Va-Hp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 08:14:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA4pA-0005Yx-Fo
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 08:14:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB190201FF;
 Fri, 25 Sep 2026 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790338478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xx2c6IpikDj6LRczCgyu7mlCyGBUf0FBqhQmUVKBcPU=;
 b=fiJRk2rsT1nKWgi01Eq+zcEWXm4yDhqlRxdOg8Cf+PiaUBJoyMcIVs5dwZzWCKtfWYk11y
 EwzxpvunVnwdq06Uxu2WW3eRWB33xI9X64BlJVRGMB+kLVSW92eYuiCn+TwtsD+jUfchnk
 OWGk2Xwx2ZlpbyuwDOBjJ0aJd/4ZBCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790338478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xx2c6IpikDj6LRczCgyu7mlCyGBUf0FBqhQmUVKBcPU=;
 b=fDbjwrUIFYuBanUkF2vQykbvP4MPXvMOoZvFntLAay8INrzP4WIQRuwzjmgywzDKmRMKf8
 AlPW8JxxR9bJFqDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mik/SoZw";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R+VeHJGb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790338473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xx2c6IpikDj6LRczCgyu7mlCyGBUf0FBqhQmUVKBcPU=;
 b=mik/SoZwxOZM4M+RubLbr2nKY1JDsrjQlIiBMn9LLFJkZfO/XbEmaXoECWxc0AFeUTTKC/
 adgTMSbD+5UhtLbBNvDzsZLtQ52kDIgV07HcW03dxuGw4SxvE06uOufHekxbMrfjijkXkw
 atiB3VPFAmvSWhgnGvVCfMpgQRdm+JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790338473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xx2c6IpikDj6LRczCgyu7mlCyGBUf0FBqhQmUVKBcPU=;
 b=R+VeHJGb65O4584hxpYuBhOOz8DitqcTGih7IvQ3pkkE+lCmuES5mW79hSt+URzDfcxBPU
 mCtbz5qRrWmZHEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 549CF138A7;
 Fri, 25 Sep 2026 12:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wr13Oqhltmr6XQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 12:14:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, John Snow
 <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC PATCH 01/14] meson: Fix meson suites invocation from make
 check
In-Reply-To: <20260918223002.1892021-2-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
 <20260918223002.1892021-2-farosas@suse.de>
Date: Fri, 25 Sep 2026 09:14:22 -0300
Message-ID: <87tsnd8r4x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DB190201FF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,mtest2make.py:url,meson.build:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> make check is currently by default running tests tagged
> "slow". Running make check with no SPEED variable set should be
> equivalent to SPEED=quick and run the meson 'quick' test setup, which
> explicitly excludes slow tests:
>
>   add_test_setup('quick', exclude_suites: ['slow', 'thorough'] ...
>
> The problem is that the mtest2make.py script is effectively overriding
> the "meson test --setup" setting by using --suite which takes
> precedence over --setup according to meson documentation.
>
> Fix by excluding suites directly with the "--no-suite" option while
> generating Makefile.mtest.
>
> Although the 'exclude_suites' in meson.build are useless for make
> check, they still help when running 'meson test' from the
> command-line, so keep them around.
>
> For the configure line I'm using:
>
> make check goes from 1100 to 996 tests
> make SPEED=slow check stays at 2158 tests
> make SPEED=thorough check stays at 2279 tests
>
> (the rest of the test targets look sane, but maintainers please
> double-check)
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - With this change we obviously lose coverage in make check. I suggest
>   we use this opportunity to review what gets put in the quick
>   suite.
>
>   For migration, I want to keep only the smoke tests in make
>   check. I'll send a patch adding them back if this change is
>   accepted.
>
> - Some of the suffixes from functional tests could probably be removed
>   and rely on having the tests in the proper suite instead. I.e. use
>   'slow' instead of 'foobar_slow'.
> ---
>  scripts/mtest2make.py          | 11 +++++++++--
>  tests/qemu-iotests/meson.build |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index 383ea68b16..a61a83f775 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -26,6 +26,11 @@ def names(self, base):
>  .speed.slow = $(sort $(filter-out %-thorough, $1))
>  .speed.thorough = $(sort $1)
>  
> +.speed_exclude_suites.quick = --no-suite slow --no-suite thorough \
> +                              --no-suite optional
> +.speed_exclude_suites.slow = --no-suite thorough
> +.speed_exclude_suites.thorough =
> +
>  TIMEOUT_MULTIPLIER ?= 1
>  .mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
>  ifneq ($(SPEED), quick)
> @@ -34,7 +39,8 @@ def names(self, base):
>  .mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword -j1 $(filter -j%, $(MAKEFLAGS)))))
>  
>  .check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs) \
> -    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s)
> +    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s) \
> +    $(.speed_exclude_suites.$(SPEED))
>  .bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose \
>      $(foreach s, $(sort $(.bench.mtest-suites)), --suite $s)''')
>  
> @@ -102,7 +108,8 @@ def emit_suite(name, suite, prefix):
>          targets += f' {prefix} {prefix}-report.junit.xml'
>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
>      # for the "base" suite possibly add FOO-slow and FOO-thorough
> -    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
> +    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names}) "
> +          ".speed_exclude_suites.$(SPEED)")
>      print(f'endif')
>  
>  targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 8857f25f29..34cfcdc53b 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -68,7 +68,7 @@ foreach driver, speed: qemu_iotests_drivers
>    endif
>  
>    # Every driver gets put in the driver specific suite
> -  suites = ['block-' + driver + '-optional']
> +  suites = ['block-' + driver + '-optional', 'optional']
>    # Any driver tagged quick or slow also gets added to slow
>    # otherwise its tagged thorough
>    if speed != 'thorough'

Oops, this one sneaked in, please ignore it. I sent it as a separate
patch already.

https://lore.kernel.org/r/20260918203153.3874488-1-farosas@suse.de

