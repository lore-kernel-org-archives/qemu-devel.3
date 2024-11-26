Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447BFD3B9B6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFy2v-0002m9-So; Tue, 26 Nov 2024 11:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFy2s-0002eV-Ga
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFy2q-00074b-GX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732637046;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zqlVlPAtDKx0eOW1eDUS6NkR4oeLdgXn2dJWGSse9kY=;
 b=cCAYMDwG9Sar5dMXe2tu1zOAxkm6DYTaIyjJJRi4947gA7e2qDqIuWThMkwh9uNQ1JYIgn
 HefO2l6enwqHyCzfu45GgbhDWZJWrfG2WLthBQXoUZ+xmtgy/E8pQ0Q+CdW5SDg0a1m3dS
 XySDub6jgVRh4N52AYy5nkLKfmSsRX8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-yZ_QKyaMNtuovQdj95MYeA-1; Tue,
 26 Nov 2024 11:03:59 -0500
X-MC-Unique: yZ_QKyaMNtuovQdj95MYeA-1
X-Mimecast-MFC-AGG-ID: yZ_QKyaMNtuovQdj95MYeA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFB7219560BE; Tue, 26 Nov 2024 16:03:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40AF1955F4A; Tue, 26 Nov 2024 16:03:54 +0000 (UTC)
Date: Tue, 26 Nov 2024 16:03:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
Message-ID: <Z0XxYpvj49colIIy@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
 <Z0RnuVKPHO1T2BfV@redhat.com>
 <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Mon, Nov 25, 2024 at 03:54:40PM -0500, Andrew Keesler wrote:
> I follow what you are saying. I misunderstood what a "display" was in the
> domain of QEMU. Yes, this makes more sense now.
> 
> > the user should give names for every output at startup
> 
> I see DEFINE_PROP_ARRAY exists. I can use that to define the new "outputs"
> property. Any reason that each "output" would ever need to be an object
> (rather than just a string)? Nothing comes to mind, I'm just taking a second
> to think about API forwards compatibility.

Currently we have 'xres' and 'yres' properties set against the device
for virtio-gpu.

If we're going to extend  it to allow the name of each "output" head
to be configured, it makes sense to allow for a data structure that
will let us also cnofigure xres & yres per output.

Hence, I thought it would make more sense to have an array of structs,
rather than the simpler array of strings, which will let us set any
amount of per-output config data we might want in future.

NB, I'm not asking you to wire up support for xres/yres per output,
just that we anticipate it as a possibility.

> > upto whatever they said for "max_outputs"
> 
> Where is the best place to perform this validation? I would imagine we would
> want to fast-fail if the user provided more "outputs" than "max_outputs". I
> can
> perform the validation in virtio_gpu_base_get_features but that seems late.

I'd suggest putting it in virtio_gpu_base_device_realize, as we already
have code there to validate 'max_outputs" is within limits.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


