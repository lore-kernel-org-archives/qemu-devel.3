Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F3DCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSNu-0007vv-3b; Tue, 19 Aug 2025 15:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSNo-0007uy-G3
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSNm-0001xP-TT
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633154;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZiVOqCMrlsTBMNSPauScELHekMp+Y4wvYPFWNra9Jk=;
 b=FEpsSL+Vg5Lpu5z/7SXhjco8OIrFPd7yzMx1Uze/8ZDv+hAZ7HgI0AOnovNdXPKl0k6GFZ
 kfjlRR2WgesoLetWem5oKrFW9DRilDUyhH8QbJldkD4ISARnqUew6mBgjkYSxhI6FJD/47
 DKASBUo3Ol5Ua+GJ9XC7doCO0EnPx5E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-27URcOgoOGunTLR54sW8gA-1; Tue,
 19 Aug 2025 15:52:30 -0400
X-MC-Unique: 27URcOgoOGunTLR54sW8gA-1
X-Mimecast-MFC-AGG-ID: 27URcOgoOGunTLR54sW8gA_1755633149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D71F180035F; Tue, 19 Aug 2025 19:52:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19571955F24; Tue, 19 Aug 2025 19:52:24 +0000 (UTC)
Date: Tue, 19 Aug 2025 20:52:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/14] python: avoid deprecation warning with
 get_event_loop
Message-ID: <aKTV9X2db62iIzU7@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-3-berrange@redhat.com>
 <2hga6d4rth5t3ed5dn7d23dppk3tzanixzhhcmmll6e5zcicri@whlsonighvvu>
 <CAFn=p-a89AUC1ceG6fC0D4fNCN0r-kPrbMXpbduAFYG1usGtsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-a89AUC1ceG6fC0D4fNCN0r-kPrbMXpbduAFYG1usGtsA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 19, 2025 at 03:49:30PM -0400, John Snow wrote:
> On Wed, Jul 23, 2025 at 5:25 PM Eric Blake <eblake@redhat.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 03:30:11PM +0100, Daniel P. Berrangé wrote:
> > > We need to call get_event_loop but have no way of knowing ahead
> > > of time whether the current thread has an event loop of not. We
> >
> > s/of not /or not /
> >
> > > can handle a missing event loop, but we need to hide the warning
> > > python will emit to avoid tripping up iotests expected output.
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> Do you mind if I collect this patch and apply it against the standalone tree?

If it applies cleanly, then go ahead, and likewise for anything
else following in this series.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


