Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853F6C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutHE-0007cF-7C; Wed, 19 Mar 2025 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tutH1-0007ZO-VJ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tutGz-0006KM-HG
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742390150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9h60U7V/rzispuzaJweO12CWSVFwSJWsldFpnLq4ZQ4=;
 b=AgLQbMb/mihEKvcpmUX+gOJQlTAbFRrCu0QMz+mPjYN5tJUldvJ/Sl4olb1iaOez42Wb30
 6Iu8fbpJhJQkIC6c7qWDNHWhUNI33JppBMfWhacNuBDBgLyFBLb4oCqa8Uv8KOl5UL3B3B
 qI610QQxnNMKJv4S4A901opyD6jrdao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-9ulGfNJjNO62Go_DZDEGFQ-1; Wed,
 19 Mar 2025 09:15:49 -0400
X-MC-Unique: 9ulGfNJjNO62Go_DZDEGFQ-1
X-Mimecast-MFC-AGG-ID: 9ulGfNJjNO62Go_DZDEGFQ_1742390146
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14AE8180899B; Wed, 19 Mar 2025 13:15:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8844C3001D0E; Wed, 19 Mar 2025 13:15:44 +0000 (UTC)
Date: Wed, 19 Mar 2025 13:15:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH v2 4/4] docs/firmware: add feature flag for qemu variable
 store
Message-ID: <Z9rDfbm5vw-uTVJJ@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-5-kraxel@redhat.com>
 <Z9qlWV_TsnndwIM4@redhat.com>
 <qimb4oxprocd2yz6chamb4a2z3oyuofm2gqwutz3l7jz4me7gi@ze5q2caadazj>
 <Z9qshApFGwvNAD5F@redhat.com>
 <46ersbz6ema7tj6eei7d6rmr5nyaz4zultzdhhlc6ncaqtucn2@tcmnl6gb3jfz>
 <Z9q2pjalGZM4laWJ@redhat.com>
 <rjz4px5v7csjjo5vehhgpotbwjf6fptkexcyv5jg7omwgdtl7h@cnhgtnyjk4ly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rjz4px5v7csjjo5vehhgpotbwjf6fptkexcyv5jg7omwgdtl7h@cnhgtnyjk4ly>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Mar 19, 2025 at 02:03:09PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > > > There is 'stateless' already for 'firmware image in r/o flash'.
> > > > 
> > > > What's the behaviour of UEFI if build with JSON vars support, but without
> > > > QEMU providing any JSON vars backend ?
> > > 
> > > It will panic.
> > 
> > In that case, we must not reuse 'stateless' with such builds, as that's
> > quite different semantics & incompatible with current usage.
> > 
> > We would need a new 'uefi-vars' mode, or just declare that we must
> > always use 'memory'  not 'flash' for such builds.
> 
> I don't see how 'flash.stateless' is any different than 'memory' (or
> 'kernel', or maybe 'igvm' some day).  If the 'host-uefi-vars' feature
> is present '-device uefi-vars-$kind' is required, no matter how you
> load the firmware.
> 
> What exactly will an old libvirt which does not know the
> 'host-uefi-vars' feature do in case it finds a firmware.json file with
> that feature?  Play safe and ignore the file?

No, unknown features are simply ignored. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


