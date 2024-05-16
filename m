Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E689C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ST8-0001bD-GR; Thu, 16 May 2024 00:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7ST7-0001b5-4k
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7SSz-0003lZ-4T
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715832699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgsmUie6oNRshpsUHGjExxGQpjucuEvOk67Y+fIg6zY=;
 b=EjdnQGs7n5V0FaLOV71u+GAB5fWSizLh04jQhS0vvJWNQtd+NZZEbqOHF9+yViNk1xN/7F
 RnFlGl4Ni/oinM6HF9erF0ykR9F/Tht+Ke6o5iOL84r962Pn1n4CVgdpZDqpL5yibtBgD0
 idmBq4HWZ5eTW20Y7tW+AQ8ATatcqiI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-kIVHt-ryMX-N815TuCZ80g-1; Thu, 16 May 2024 00:11:17 -0400
X-MC-Unique: kIVHt-ryMX-N815TuCZ80g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b2c8a007f2so895712a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 21:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715832676; x=1716437476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RgsmUie6oNRshpsUHGjExxGQpjucuEvOk67Y+fIg6zY=;
 b=wnZeOzg8Ai0OVQj5WqsKmx8Xmv6qDGI0tMFFBp0asKKejDW9Q2dFOltJnnllZ3JeHj
 C9qt1gViUHa5Zw9w6l8EufjdBjInL08iIZpAZnbZ0uuG4mdj2Dge7lRYBPf7TgsnFDh+
 pxCW6UubqTJknl9LeuJsYLmto0ctR6970952E1GR47D9qxUPKeNmDHMOerGFzjYPpfZB
 PZfSBzIywEp/VZd4E8H0wEAjmpfrua7PaiejkE331a9CXRiSDzl9y2/jZB4O0XeTAPG6
 DMgwtHrYISbvIJGna0CJvxhAel3f9SYXKR838AOuRQkJ4E/xTPSrfh6myqQ1dH66IY3G
 pvmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWham60G/095pMKRp3LU+yRUSi301e/D+N7eadL7J184iGy3zLHv8MW2trRCL87DCLP+ZgKwbym6SCmTM5KLe/6gBsV8I=
X-Gm-Message-State: AOJu0YyWgJYK1ehF4G7YuXYqlZ+sal84O5q4p+BaThfuQfRGNOt3Luzu
 vkCeIxbha97kcK2w4vKOWRglB5lZtYkCRMALmU7hYTzhjRZZf3hOe7RqMJbJeK/SQvl1IoD07Gr
 +EUdqhnqiDXCbnBsNV1aC82Arn9i4UhOco4VqszAQR1oBBvRRqhHl
X-Received: by 2002:a05:6a20:4306:b0:1ad:8f18:8621 with SMTP id
 adf61e73a8af0-1afde28cf65mr20831437637.6.1715832676453; 
 Wed, 15 May 2024 21:11:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvGEC8tCczvkebc2jghSKcsruYVv65nJ7jKTjwUEApvi0Z+gRCqY5VscHaHMArB6bAGmE2bw==
X-Received: by 2002:a05:6a20:4306:b0:1ad:8f18:8621 with SMTP id
 adf61e73a8af0-1afde28cf65mr20831412637.6.1715832675762; 
 Wed, 15 May 2024 21:11:15 -0700 (PDT)
Received: from x1n ([67.214.252.166]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b9f5820ce9sm1624392a91.56.2024.05.15.21.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 21:11:15 -0700 (PDT)
Date: Wed, 15 May 2024 22:11:12 -0600
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 5/5] virtio-gpu: fix v2 migration
Message-ID: <ZkWHYAM_iaPSamAw@x1n>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <20240515141557.1277999-6-marcandre.lureau@redhat.com>
 <ZkTc4Ott5M15k55R@redhat.com> <ZkTq3xBP-0UiLV2X@x1n>
 <ZkTtxLcgoZlzWH8A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTtxLcgoZlzWH8A@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 15, 2024 at 06:15:48PM +0100, Daniel P. Berrangé wrote:
> On Wed, May 15, 2024 at 11:03:27AM -0600, Peter Xu wrote:
> > On Wed, May 15, 2024 at 05:03:44PM +0100, Daniel P. Berrangé wrote:
> > > Above all, I'm failing to see why there's a compelling reason
> > > for virtio_gpu to diverge from our long standing practice of
> > > adding a named property flag "virtio_scanout_vmstate_fix"
> > > on the machine class, and then setting it in machine types
> > > which need it.
> > 
> > The reason to introduce that is definitely avoid introducing fields /
> > properties in similar cases in which case all the fields may represent the
> > same thing ("return true if MC is older than xxx version").  Especially
> > when such change is not bound to a new feature so in which case it won't
> > make sense to allow user to even control that propoerty, even if we
> > exported this "x-virtio-scanout-fix" property, but now we must export it
> > because compat fields require it.
> > 
> > However I think agree that having upstream specific MC versions in VMSD
> > checks is kind of unwanted.  I think the major problem is we don't have
> > that extra machine type abstract where we can have simply a number showing
> > the release of QEMU, then we can map that number to whatever
> > upstream/downstream machine types.  E.g.:
> > 
> >   Release No.         Upstream version       Downstream version
> >   50                  9.0                    Y.0
> >   51                  9.1
> >   52                  9.2                    Y.1
> >   ...
> 
> Downstream versions do not map cleanly to individual upstream versions
> across the whole code base. If we have two distinct features in upstream
> version X, each of them may map to a different downstream release. 
> 
> This can happen when downstream skips one or more upstream releases.
> One feature from the skipped release might be backported to an earlier
> downstream release, while other feature might not arrive downstream
> until they later rebase. Version based checks are an inherantly
> undesirable idea for a situation where there is any backporting taking
> place, whether its machine type versions or something else. Named feature
> / flag based checks are always the way to go.

I thought this should work better with things like this where we only want
to fix a break in ABI, and none of downstream should special case things
like such fix.. but I agree even with that in mind such case could be so
rare to bother with above scheme.  I could have raised a bad idea I
suppose. :-( Let's stick with the simple until someone has better idea.

Thanks,

-- 
Peter Xu


