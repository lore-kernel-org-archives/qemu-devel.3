Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9989CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24vg-0005aR-20; Fri, 26 Sep 2025 05:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v24vc-0005Zo-6L
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v24vS-00012N-TC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758879566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mxd1YN9l6mHM8Zb+iZg60Z62cmnpA42byJZsk0C8qcs=;
 b=J2fU8rErn33RnPkMmsugFGEM1jsw4lsT0Z0obZVbljsdCutC8etuhaCypBGomNCKOQwsfk
 1I6WDNr1qW9IvB3d2rInXX7jVTIInbmbOfRP/lSe0LWaf5lN3BQ8QQPgm+f1GRTKzVO8jS
 BPwQLsOiHtFKuJRrpz5A3RHTnj0dNNc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-nZhsWrAJPpi11n5rlrvzaQ-1; Fri,
 26 Sep 2025 05:39:24 -0400
X-MC-Unique: nZhsWrAJPpi11n5rlrvzaQ-1
X-Mimecast-MFC-AGG-ID: nZhsWrAJPpi11n5rlrvzaQ_1758879563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D8BD180048E; Fri, 26 Sep 2025 09:39:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE5C019560A2; Fri, 26 Sep 2025 09:39:17 +0000 (UTC)
Date: Fri, 26 Sep 2025 10:39:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 7.2.x] use fedora:37 for python container instead of
 :latest
Message-ID: <aNZfQvXWo55KiUYh@redhat.com>
References: <20250926073120.2212284-1-mjt@tls.msk.ru>
 <aNZN6bON0bckydql@redhat.com>
 <edb2826b-f513-44d3-a028-e1278a3dd524@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb2826b-f513-44d3-a028-e1278a3dd524@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 26, 2025 at 11:36:34AM +0200, Philippe Mathieu-Daudé wrote:
> On 26/9/25 10:25, Daniel P. Berrangé wrote:
> > On Fri, Sep 26, 2025 at 10:31:19AM +0300, Michael Tokarev wrote:
> > > More recent fedora does not have our minimum python versions
> > > anymore.  Stick with the most common fedora version used in
> > > 7.2.x in other places, which is 37.  This way, python tests
> > > works again.
> 
> Valid change, so:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> > > 
> > > This is a 7.2-specific change, not aimed for the master branch.
> 
> Why? We already learnt using 'latest' tag in docker image is a pain
> to maintain, and hinder reproducibility. Personally I'd rather this
> patch in our /master branch.

Yes, we should change master too, but master will want something
much newer than Fedora 37, so this change for old stable is still
desirable as-is, as a newer Fedora won't be suitable for old
stable.

> > > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > > ---
> > >   tests/docker/dockerfiles/python.docker | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


