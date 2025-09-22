Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fSN-0001P5-Qa; Mon, 22 Sep 2025 08:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0fSH-0001NQ-PG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0fS7-0002QC-7z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758543326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCMz6MLRay7fRzJF8B/Bk5LDHZMit8OtBVTpZwQswc4=;
 b=h+I4c+Fnj12I6pf6anYMC9LvLPCBBJdTMorIkjWRgjK5WxDfvaYieLRwJtD6ordjHmrn1p
 GrBdN6+QfLm+0UwHS96CwzlMBI7b/J9OuVEkIFJTIEggoXRQCCrbmp+rm1/+u9qO/zJb9H
 BH8+8dByTFSitbtw91cuBWmbcwA0yJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-1RJys8EjPNK8MRJd3R_YSQ-1; Mon, 22 Sep 2025 08:15:25 -0400
X-MC-Unique: 1RJys8EjPNK8MRJd3R_YSQ-1
X-Mimecast-MFC-AGG-ID: 1RJys8EjPNK8MRJd3R_YSQ_1758543324
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso296631f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758543324; x=1759148124;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCMz6MLRay7fRzJF8B/Bk5LDHZMit8OtBVTpZwQswc4=;
 b=ibbu/+F/I1zsmZpjoAzEHDa3Iz+O5qkdupmEDjPvgX+/7pJBjKZkAMTQrRBPtjoYFj
 6ICMdnrxhCJz9NywmKtOv4fpmuNFeRWMPfD5r8anbdihwPJ37N8KYFZd32L/RwndsQDj
 0WnoN5zqRCLF2IX5wA5ECQBH/vJStrxrrjXDY3Lc0Tm/x5MB+AjehaRArs6oEKZk8yih
 rOf2mKQP1fzTaKBMbRum9Pf+laNMTcPhmfsb7TZCKdaugPAOOIUTsiznimZzX6RCUpPp
 cAFrTrDqK/r7P6D14L2P5xSvMqheyv86nXpSQcEyLbraIZDxO9IKItUWj6g+pFhZkJfo
 qsNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0zUSeTPyCb8Ko9+Xs6WwwNG16PbJPUUsMU4Amf4QGsi2rhqQjUqaKLxLsQtm5EARnPrTSUY2CKQZU@nongnu.org
X-Gm-Message-State: AOJu0YzeBCcFKIBVnJOziYnt9/8qFAVAUN/lV0Cg03/q7aXwIn0rqyM8
 eGgElynYtvuqcur+/sTHWzdVbVj6zNsJ7HSnmYgBd5DATa/81PWGF3gwk5jD+zaH3mn7PDitiHn
 3m9h7Ci4Xjf1Kj11kSLxXG9yI5yhZOI38Y3KsiaLFWzPuLm6xOilRi+tH
X-Gm-Gg: ASbGncvdjYruF9QCMAe4YJYGx0U45ecRKNmywFFLJgN9vKeYfgr3m7NhTGJxsF0lERk
 fRRlLYitX0DK1QBVamuaxwpTVrK+3GVidHg39SPdp9/CU9zAc2zVTDME9YBIWqUoZQEhQCLGsQ4
 eNOKZoetZU6U+7+3HyEZUiH/vzadVF+nfZ/qmHX4CFmhrdXbgnlYFKFgPFR2WQGw5olIswqtWDY
 wttac5op0QG0h7liBLaXPuAXQvQNx2IbBpl+WAhNkJBYk3iTQh1joHbSDDiOLQ2UVgeaAARg2Pg
 8n7psl5hYlHRhSrUVvFbsBXI0PTnfg23eck=
X-Received: by 2002:a05:6000:186f:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-3ee8054cd05mr10871098f8f.27.1758543323808; 
 Mon, 22 Sep 2025 05:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgC4xXCZSCcb7HxVAkljMgUPe6t60zJLuTFAe0I6re/B8i8wvFshsXZ//h3L5mH4YJnUcnGA==
X-Received: by 2002:a05:6000:186f:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-3ee8054cd05mr10871068f8f.27.1758543323280; 
 Mon, 22 Sep 2025 05:15:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbd5d65sm19141827f8f.46.2025.09.22.05.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:15:22 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:15:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250922081403-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNE0Bp0hsA31sLCJ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > This removes the change introduced in [1] that prevents the use of
> > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > 
> > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > 
> > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > ---
> > > vhost-user-device and vhost-user-device-pci started out as user
> > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > introduced.
> > > 
> > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > google for "vhost-user-device" I've seen no confused users.
> > > 
> > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > maintain our own QEMU packages, which is non-trivial.
> > > 
> > > So I want to propose lifting this restriction to make this feature
> > > usable without a custom QEMU.
> > > 
> > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > 
> > The confusion is after someone reuses the ID you are claiming without
> > telling anyone and then linux guests will start binding that driver to
> > your device.
> > 
> > 
> > We want people doing this kind of thing to *at a minimum*
> > go ahead and register a device id with the virtio TC,
> > but really to write and publish a spec.
> 
> Wanting people to register a device ID is a social problem and
> we're trying to apply a technical hammer to it, which is rarely
> an productive approach.
> 
> If we want to demonstrate that vhost-user-device is "risky", then
> how about we rename it to have an 'x-' prefix and thus disclaim
> any support for it, but none the less allow its use. Document it
> as an experimental device, and if it breaks, users get to keep
> both pieces.

Maybe with the insecure tag you are working on?
And disable in the default config?


> It seems like it would be useful before any virtio spec submission
> as a mechanism by which users can experiment to finese their ideas
> prior to getting to the point of needing to make a spec proposal.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


