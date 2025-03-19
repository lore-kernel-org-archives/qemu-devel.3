Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7A7C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusQX-00068o-60; Wed, 19 Mar 2025 08:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tusQ1-00065x-B7
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tusPz-0003Ef-1C
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742386863;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWkcSmJJjrpvlLQDeKOoXBqNCpSRqrAjjYDVA3kPWeQ=;
 b=fEY7mEVwerA9CRwCqGdaWpCYvXbh+R5t/YHRkz1PkYDN1JZV57ymZm8VVxFluf8laQZWB0
 H3J9gW0ylvTrW8cexrBt2Oz1EyAwYjjs8FlsBvUd2fuT5zsOwvlzGCAwhR+hzSU2qrrjH8
 tsEuIjZz3eCWxDuOgMZ6MT/leEVi018=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-yVzpJK-dMMalTqEkxvErFw-1; Wed,
 19 Mar 2025 08:21:00 -0400
X-MC-Unique: yVzpJK-dMMalTqEkxvErFw-1
X-Mimecast-MFC-AGG-ID: yVzpJK-dMMalTqEkxvErFw_1742386859
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7D01801A07; Wed, 19 Mar 2025 12:20:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC3F81955BC2; Wed, 19 Mar 2025 12:20:57 +0000 (UTC)
Date: Wed, 19 Mar 2025 12:20:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH v2 4/4] docs/firmware: add feature flag for qemu variable
 store
Message-ID: <Z9q2pjalGZM4laWJ@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-5-kraxel@redhat.com>
 <Z9qlWV_TsnndwIM4@redhat.com>
 <qimb4oxprocd2yz6chamb4a2z3oyuofm2gqwutz3l7jz4me7gi@ze5q2caadazj>
 <Z9qshApFGwvNAD5F@redhat.com>
 <46ersbz6ema7tj6eei7d6rmr5nyaz4zultzdhhlc6ncaqtucn2@tcmnl6gb3jfz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46ersbz6ema7tj6eei7d6rmr5nyaz4zultzdhhlc6ncaqtucn2@tcmnl6gb3jfz>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 19, 2025 at 12:51:16PM +0100, Gerd Hoffmann wrote:
> On Wed, Mar 19, 2025 at 11:37:40AM +0000, Daniel P. Berrangé wrote:
> 
> > > > > +# @qemu-vars: The firmware expects qemu to provide an efi variable
> > > > > +#             store, via "uefi-vars-sysbus" or "uefi-vars-x64" device.
> > 
> > I wonder if 'qemu-vars' is the right name here ? It feels like the specification
> > for such device is effectively defined by UEFI, with any hypervisor providing a
> > impl. Perhaps just call it 'uefi-vars-dev' or some name that's relevant for
> > what EDK2 calls it ?
> 
> 'host-uefi-vars' maybe?  Or 'vmm-uefi-vars'?
> 
> > > There is 'stateless' already for 'firmware image in r/o flash'.
> > 
> > What's the behaviour of UEFI if build with JSON vars support, but without
> > QEMU providing any JSON vars backend ?
> 
> It will panic.

In that case, we must not reuse 'stateless' with such builds, as that's
quite different semantics & incompatible with current usage.

We would need a new 'uefi-vars' mode, or just declare that we must
always use 'memory'  not 'flash' for such builds.

> 
> > We would want to expand the 'stateless' docs to mention that this feature
> > flag indicates optional support for persistence in that case.
> 
> Optional is not possible do due to the way variable store support is
> organized in edk2.  Firmware can't switch between smm and non-smm
> configuration at runtime for similar reasons.
> 
> take care,
>   Gerd
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


