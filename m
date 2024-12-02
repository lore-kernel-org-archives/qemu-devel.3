Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B83D7830F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4qv-0002Et-3x; Mon, 02 Dec 2024 06:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4qq-0002EC-TX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:44:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4qo-00070S-Pm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733139865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CuZCww9t9l+6qkiG/liZYbSNtQPwUgkXGCp6Kr+ejA=;
 b=BtHr9LP/9k1TBdXRO2+IBLM7aaBXl5bkl8JwoLY72dJMVnp9hzjDYFgZVHhYqTAmfZbWlq
 D4DwQdW+An4LEgvNUSCdioZSx4duonPgDrp59gefY+/tNXZTPG8hhvPshksy1a1Mgp+va5
 /RR+2fAyYKGF0qLJJwWGCHe3NtwKSuc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-v7VlsnuQMWCS02RNidehDg-1; Mon,
 02 Dec 2024 06:44:21 -0500
X-MC-Unique: v7VlsnuQMWCS02RNidehDg-1
X-Mimecast-MFC-AGG-ID: v7VlsnuQMWCS02RNidehDg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 767DF1944DDB; Mon,  2 Dec 2024 11:44:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6075630000DF; Mon,  2 Dec 2024 11:44:17 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:44:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 05/22] tests/functional: remove duplicated 'which'
 function impl
Message-ID: <Z02djVGVj-ZX2kV9@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-6-berrange@redhat.com>
 <23b4e458-b46d-4b7f-a6a0-16e58e3e5f2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23b4e458-b46d-4b7f-a6a0-16e58e3e5f2a@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Nov 30, 2024 at 11:16:30AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > Put the 'which' function into shared code.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/__init__.py |  2 +-
> >   tests/functional/qemu_test/cmd.py      | 10 ++++++++++
> >   tests/functional/test_acpi_bits.py     | 13 +------------
> >   tests/functional/test_ppc64_hv.py      | 13 +------------
> >   4 files changed, 13 insertions(+), 25 deletions(-)
> 
> None of the callers really seem to be interested in the location of the
> command, only whether it is available in the $PATH or not ... so could we
> maybe rather drop this function and use the has_cmd() function everywhere
> instead?
> 
> Hmm, thinking about it twice - has_cmd() uses the "which" program
> internally, but AFAIK this program is optional in Linux installations
> nowadays ... so maybe it's still a good idea to move our Python which() to
> cmd.py, but has_cmd() should maybe rather be changed to use it, too?

This reminds me I meant to ask about 'has_cmd' - it looks rather
over-engineered to me to be trying to invoke the command with
args.

Perhaps there was some reason to check support for individual
args in the past, but none of the current tests need that AFAICT.

So if anything I'd be looking to delete 'has_cmd' and 'has_cmds'
entirely, and rely only on the pure python 'which'.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


