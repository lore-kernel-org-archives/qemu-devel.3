Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053E8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSQS-0001Xk-3O; Mon, 29 Jul 2024 11:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYSQQ-0001SB-IH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYSQO-0002yA-O6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722267395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kL5gQMPkiNOFObhH8ArDOtDQzMW4U5tZFuPv4Mg6bI=;
 b=Aft9XBCadk9PBIkC91XGQGUZPYCBYZ+zAmwLaThEAz0WuDdARrNDGjivjiOx77NqnBSUft
 X4khbak2s4rIaH5795nwRjjp7fzgeOXGlLKxBul20xKaSM72RMR34gxfHns2igJdto1rgq
 WEajjiDx46vNXh6sGENLg6pClGuYGc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-RYwzgvzQMNeSyPkO1U5xGA-1; Mon,
 29 Jul 2024 11:36:33 -0400
X-MC-Unique: RYwzgvzQMNeSyPkO1U5xGA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56AAE1954126; Mon, 29 Jul 2024 15:36:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F6DF19560AA; Mon, 29 Jul 2024 15:36:30 +0000 (UTC)
Date: Mon, 29 Jul 2024 16:36:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/14] Docs / testing patches for 2024-07-29
Message-ID: <Zqe2-4B8_qs3Oq0K@redhat.com>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 29, 2024 at 05:27:00PM +0200, Philippe Mathieu-Daudé wrote:
> The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:
> 
>   Merge tag 'pull-ppc-for-9.1-2-20240726-1' of https://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)
> 
> are available in the Git repository at:
> 
>   https://github.com/philmd/qemu.git tags/docs-testing-20240729
> 
> for you to fetch changes up to 8e2275592299b637e87cc905d20bfdeffa586a83:
> 
>   tests/avocado: test_arm_emcraft_sf2: handle RW requirements for asset (2024-07-29 16:33:24 +0200)
> 
> Ignored warnings:
> 
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>   WARNING: line over 80 characters
> 
> ----------------------------------------------------------------
> Docs & testing patch queue
> 
> - Test QAPI firmware.json schema (Thomas)
> - Handle new env.doc2path() return value (Peter)
> - Convert some Avocado tests to simpler python-based functional testing (Thomas)
> - Improve how assets are used by some Avocado tests (Cleber)
> 
> ----------------------------------------------------------------
> 
> Cleber Rosa (3):
>   tests/avocado: mips: fallback to HTTP given certificate expiration
>   tests/avocado: mips: add hint for fetchasset plugin
>   tests/avocado: test_arm_emcraft_sf2: handle RW requirements for asset
> 
> Peter Maydell (1):
>   docs/sphinx/depfile.py: Handle env.doc2path() returning a Path not a
>     str
> 
> Thomas Huth (9):
>   python: Install pycotap in our venv if necessary
>   tests/functional: Add base classes for the upcoming pytest-based tests
>   tests/Makefile.include: Increase the level of indentation in the help
>     text
>   tests/functional: Prepare the meson build system for the functional
>     tests
>   tests/functional: Convert simple avocado tests into standalone python
>     tests
>   tests/functional: Convert avocado tests that just need a small
>     adjustment
>   tests/functional: Convert the x86_cpu_model_versions test
>   tests/functional: Convert the riscv_opensbi avocado test into a
>     standalone test
>   gitlab-ci: Add "check-functional" to the build tests

On the avocado review I mentioned that I didn't think we should
be rebasing avocado during freeze. By the same token, I'm not
convinced we should be introducing a new test framework during
the freeze period.  This is alot simpler than avocado, but at
the same time this small subset of Thomas' patches isn't really
fixing any problem on its own, as avocado still exists in
parallel.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


