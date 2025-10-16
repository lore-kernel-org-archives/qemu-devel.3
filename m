Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99434CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9TZZ-0000Zh-7R; Thu, 16 Oct 2025 15:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9TZX-0000Xb-E7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9TZQ-0007cL-St
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760642606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oACUPXZu+i1rHClvNpsITPhjQ54lAiEy9iwhvnDLBXw=;
 b=eclFkPXn5hdtbDWv1qDe3AphAoUGyMHsCgPKZSp4DaSjN5YLDG8PrMCvcFBFJD2I6exQJE
 aB7CdzU6ecAwpsZkC/JFBKqLySLWpWonTGnULLx84EnU/EXRKaX7mKIXv9kZRKupVJ8yaf
 5lllhC2HHkcJry7MBN1r3In7nhDyBcg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-vxwmfIUjOsKDK6umu97Y3g-1; Thu,
 16 Oct 2025 15:23:23 -0400
X-MC-Unique: vxwmfIUjOsKDK6umu97Y3g-1
X-Mimecast-MFC-AGG-ID: vxwmfIUjOsKDK6umu97Y3g_1760642602
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 431A3195608E; Thu, 16 Oct 2025 19:23:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 633591800446; Thu, 16 Oct 2025 19:23:20 +0000 (UTC)
Date: Thu, 16 Oct 2025 20:23:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: SLOF repo mirror URL updated to GitLab
Message-ID: <aPFGJXe5gEqEQoIJ@redhat.com>
References: <CAJSP0QXLR5QkPwS62aGyKTTajwaXz-6bXzq8FNumW-HfMiQptA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QXLR5QkPwS62aGyKTTajwaXz-6bXzq8FNumW-HfMiQptA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 02:57:20PM -0400, Stefan Hajnoczi wrote:
> Hi,
> QEMU's SLOF mirror at https://gitlab.com/qemu-project/SLOF has been
> updated to pull from https://gitlab.com/slof/slof instead of
> https://github.com/aik/SLOF.
> 
> Thomas Huth requested this change on IRC and I see that
> https://github.com/aik/SLOF has a notice pointing to
> https://gitlab.com/slof/slof as the new official repo.

Just changing the mirror location is not sufficient. The most recent
commit in aik/SLOF, which was mirrored into qemu-project/SLOF, never
existed in slof/slof.

We'll need to force push history to qemu-project/SLOF to get rid of
the divergence, before the mirroring will succeed.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


