Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D17CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wx7-0005Bb-6F; Wed, 08 Oct 2025 12:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6Wx3-00059V-Fq
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6Wws-0006Tz-5b
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759940604;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhNquXz/Rp4NIlyTSomMiMtgztB/hboERJUUIKPcNsU=;
 b=GY+QpKF5nmQwby/lNjYr+xAiBQyMMkc+a6CfPtdA0xtYKb6v+TySei0I0VeLbTP/lYR8KS
 Kp+rGzRRK44ef76tJVdjTj401QpTXKGBGGl989Ev4ueq9qQdYsVSVxQ9L/kYscaYwzoNG/
 xFfIxp/gfSSwVBLgyySCbAg7NPpGdZQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-TJN1cdU9NOCl54YdJmBhJg-1; Wed,
 08 Oct 2025 12:23:20 -0400
X-MC-Unique: TJN1cdU9NOCl54YdJmBhJg-1
X-Mimecast-MFC-AGG-ID: TJN1cdU9NOCl54YdJmBhJg_1759940599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67BE8195608D; Wed,  8 Oct 2025 16:23:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01A5B300018D; Wed,  8 Oct 2025 16:23:14 +0000 (UTC)
Date: Wed, 8 Oct 2025 17:23:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH RFC/WIP 4/4] gitlab: add jobs for thorough block tests
Message-ID: <aOaP7sBjIMRpCOgu@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-5-berrange@redhat.com>
 <wboov2wdkicvhzwpkckoav3d4uwghdzd7g6kwzy3ynrdt3cyr4@qeu6nviffl2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wboov2wdkicvhzwpkckoav3d4uwghdzd7g6kwzy3ynrdt3cyr4@qeu6nviffl2i>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 08, 2025 at 10:57:45AM -0500, Eric Blake wrote:
> On Wed, Oct 08, 2025 at 12:35:52PM +0100, Daniel P. Berrangé wrote:
> > CI is only exercising the qcow2 'auto' tests currently. As a result we
> > get no exposure of changes which cause regressions in other block format
> > drivers.
> > 
> > This adds new CI jobs for each block format, that will run the target
> > 'make check-block-$FORMAT'. The jobs are separate so that we have the
> > ability to make each formats gating or not, depending on their level
> > of reliability.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest.yml | 63 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> 
> The idea makes sense to me.
> 
> Did you have a link a URL of a CI run that failed tests on NBD, where
> I might be able to help make the tests more deterministic?

Its the one in the cover letter - the nbd job is

  https://gitlab.com/berrange/qemu/-/jobs/11633680715


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


