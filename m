Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBFAC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsgv-0006ge-Vo; Thu, 10 Jul 2025 10:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsc4-0001bi-Qc
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsc1-0000BM-Ia
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752159059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=W49KpvM0zP1qTgwJOqPQ5WflIL25lKeCFaINUPeoqvA=;
 b=J9A65th4EFxjAN/n/LiN7hyqaIM1w8nGft3fomn4Zeo/CZoCpAU3Kz7O8mzOn44xbHsi6Y
 6uHEpkS4c0mhQJbFb94AxxOblQz2r2g+8cI0WtlqCl1ByCN5x2YI/cBc+PaWdjFqMHp3AC
 ZvYRYOYgnJMvmVorprGmLxiI+ndS+Vo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-PdlVlt3xOGmzV_NZmoHc9g-1; Thu,
 10 Jul 2025 10:50:56 -0400
X-MC-Unique: PdlVlt3xOGmzV_NZmoHc9g-1
X-Mimecast-MFC-AGG-ID: PdlVlt3xOGmzV_NZmoHc9g_1752159055
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F1D1809C8A; Thu, 10 Jul 2025 14:50:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.76])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7661519560A3; Thu, 10 Jul 2025 14:50:51 +0000 (UTC)
Date: Thu, 10 Jul 2025 15:50:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
Message-ID: <aG_TSITe2VhMfpA9@redhat.com>
References: <20250710094251.139514-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710094251.139514-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 10, 2025 at 11:42:51AM +0200, Thomas Huth wrote:
> This patch tackles two issues. First, the tests/functional folder has
> become quite crowded already, some restructuring would be helpful here.
> Second, we currently encode the target architecture twice in the test
> names since a lot of the test file names contain the target, too.
> This contributes to the very long output lines when running "make
> check-functional".
> 
> So let's move the individual test files to target specific folders now.
> Then we can drop the target from the file name (and thus from the test
> name).

> ---
>  Note: Marked as RFC since I'm not that happy about the symlinks yet ...
>        if someone has a better idea, please let me know!
>        Also the update to the MAINTAINERS file is still missing - I'll add
>        that once we agreed on whether this patch is a good idea or not.

FWIW, I don't find the symlinks to be a problem, but if they bother you,
we could probably just have a trivial subclass.


   from ../generic/test_migration import MigrationTest

   class MigrateTestX86(MigrationTest):
       pass


Unless pytest runner really needs the 'test_XXX' methods to be only on
the leaf class, not a parent, in order to enumerate test cases ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


