Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65231C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 08:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd452-0007J3-LT; Sun, 11 Aug 2024 04:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sd44y-0007Hr-Si
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 04:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sd44w-0005qB-Jv
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 04:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723365448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQ6/CgAqq+YPFEdkAw4Vf6wCEm3plmJEOqO9wdW8kDw=;
 b=LX0ReeQgpdtS8rX0q2N9WY/7Zu13xGBeKJeTZO+cs6FsRA1UAgLD0czkeyCI60juxe6ZtK
 Gb7DeWzBweN8m/kEqU4c7dnKG2BQ6Q0sIQGNsvhT/j3JyyFr0Kpu0ELK+RHfMsd4gFekMu
 dFVy9woxNYfugM6+VKGM1tYF1Z2FUf0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-35v0aA9MN0azTRLQIw2kdw-1; Sun, 11 Aug 2024 04:37:27 -0400
X-MC-Unique: 35v0aA9MN0azTRLQIw2kdw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42808efc688so25576415e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 01:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723365446; x=1723970246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQ6/CgAqq+YPFEdkAw4Vf6wCEm3plmJEOqO9wdW8kDw=;
 b=uw1BNETP5vR4n+NpyXOuNopI66HS8SvOHdg6WqXyANHDyjdJtITz0hLDQYUssV83U/
 RwX95/fMIh1uWO7CaTEixYvMSfJqBsRI6NGFp0HAcGEdZMpE+8pm6F2VE5cwUcicmnoK
 dP/KvLZOhuUmN8sm/qXYQe+SoZ8mPeP0q/q43akunkSin5X5BE4CDCW49iUgWqwNxBuc
 6d3D5f4ke0j8aTgNGUfS86rtq2B73Q2f4SI63LnaNdedzCDwOVLR72yNVOymKKTspOcB
 iM75j7W5WAZgFyfVGsYo1Cct5TVqnofSvbbOP69OiGxpkTjJYvF+Z1oqRfcMuFU1UcnY
 iaEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPW3RD3aC74Ju8EXkKZAOOsESKJreJVAYiuOrizmWjYyG0NS0ULNNKFbRwZReN0GgHvpUIG7ng9cRquFyrLG7nL8AGT+k=
X-Gm-Message-State: AOJu0Yx2AbtMCnnXxCAsFtCBaPukCl1JvdJeza+qR0bf8HeXKSU0Den0
 pLLP6wHSADBSJxFrOQw7BSmvK0Mlrd4z0EhqtmPOXeiPrRZrgAIohR8UVcQQbPe+gl798WaFg6V
 xHpeQu56D0/nNcUBodecxJ8rtjX8SgdVynBrN6v45ECzIUCQo0Isu
X-Received: by 2002:adf:e402:0:b0:367:980a:6af with SMTP id
 ffacd0b85a97d-36d6092748amr3446887f8f.59.1723365445805; 
 Sun, 11 Aug 2024 01:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBMDH6td/VMoogk0cuJ5p1Ac2xpW52e4D6srgBjanq95bCueY0hd/Mom4rb8Wo2LY+ixva7g==
X-Received: by 2002:adf:e402:0:b0:367:980a:6af with SMTP id
 ffacd0b85a97d-36d6092748amr3446867f8f.59.1723365445104; 
 Sun, 11 Aug 2024 01:37:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:cda4:bbcf:b3a:9142:2f8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm4284292f8f.115.2024.08.11.01.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 01:37:24 -0700 (PDT)
Date: Sun, 11 Aug 2024 04:37:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v6] virtio-pci: Fix the use of an uninitialized irqfd
Message-ID: <20240811043559-mutt-send-email-mst@kernel.org>
References: <20240806093715.65105-1-lulu@redhat.com>
 <CACGkMEs8T4z1+dMxJ2AotTX6X-Y6POtNX4WLxJxCbe6xes70Ow@mail.gmail.com>
 <e9848924-65ef-45ca-985d-c420f0baacec@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9848924-65ef-45ca-985d-c420f0baacec@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 11, 2024 at 11:06:09AM +0300, Michael Tokarev wrote:
> 07.08.2024 07:02, Jason Wang wrote:
> 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Jason, would you mind picking this up together with -net help bugfix
> and sending a pull request?
> 
> This particular change has been (re)tried multiple times by Cindy Lu
> already, and the bug is still not fixed and affects users.  Both
> this and -net help fix are a must for 9.1 and for stable series.
> 
> Thanks,
> 
> /mjt
> 
> -- 
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt

I have it tagged, just didn't do a pull with it yet. Should make 9.1
with no issues.


