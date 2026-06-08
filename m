Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F91BCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWc0g-0000Ny-BZ; Mon, 08 Jun 2026 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWc0e-0000NY-Mr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWc0c-0003qV-D8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780932924;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ohWC9SO/vvQiac4QDD47SmItTO2p82ZQjqrucG9jpU4=;
 b=Nu1nsASTJxF99a2FrZMxSCEcuySjF/10cY8qmMPSTQ7XVZUIZrLoIKXEW+qz3zW30aTaCZ
 P17pLlkfdarWvcZS1Sxm2LCfCYM3fySXVVoyuIN+BM31pbkFI3WeLwt5kh6pFob6aR3/LJ
 p8GyrbAwfWaNpCFfXoyEf1oof/BJiBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-nHoOuNuzPaSHV2ypJromPw-1; Mon,
 08 Jun 2026 11:35:20 -0400
X-MC-Unique: nHoOuNuzPaSHV2ypJromPw-1
X-Mimecast-MFC-AGG-ID: nHoOuNuzPaSHV2ypJromPw_1780932919
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9692E180058F; Mon,  8 Jun 2026 15:35:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 954641955BC4; Mon,  8 Jun 2026 15:35:15 +0000 (UTC)
Date: Mon, 8 Jun 2026 16:35:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
Message-ID: <aibhMPHu6nbBT3Yi@redhat.com>
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
 <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 08, 2026 at 04:29:47PM +0100, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 16:25, Emmanuel Blot <eblot@meta.com> wrote:
> >
> > On macOS, plain QEMU binaries are named qemu-system-<arch>-unsigned.
> >
> > In libqtest, qtest_get_arch() extracts the architecture by splitting
> > after "-system-", which yields "arm-unsigned" instead of "arm".  This
> > prevents the QOS graph from matching any machine node, causing all
> > QOS-based tests to be silently skipped.
> >
> > In the functional test framework, the same suffix causes the arch to
> > be parsed as "unsigned", leading to wrong output directories and
> > teardown failures.
> >
> > Strip the "-unsigned" suffix on both code paths.
> >
> > Signed-off-by: Emmanuel Blot <eblot@meta.com>
> > ---
> > Address issues with liqtest and functional test framework when run from
> > a macOS host.
> >
> > Unsigned binaries on macOS may be appended an `-unsigned` suffix, which
> > confuse these components that rely on the binary name to recover the
> > guest architecture.
> 
> I still think this not the right thing to do. The "make" process
> on macos should produce and sign the binary in-place in the
> build tree, so that users and test cases don't have to care
> about this macos specific weirdness. (If the signing is
> location-specific and we need to sign again for "make install"
> that's fine. But we should produce a working binary with the
> usual name in the build tree, not a non-working one or one with a
> nonstandard name.)

Yes, I was just about to write similar when I saw your message.
We should not have this custom "-unsigned" name  in the build
tree as specialcases like this break too many expectations,
especially when most devs aren't ever testing for macOS and so
won't see the special case.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


