Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00678F4611C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fn6-00071n-Eh; Mon, 23 Mar 2026 09:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w4fmg-0006tY-2l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w4fme-0006iD-EV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774274251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfcUm49uHHBtyItVC5u633X7yS+mvT2cAbMNi0GNZak=;
 b=g8aEm1pSYNlHGB6tXqKPwnHmGWn07tdGiASLsv7MvP/q9KfaGW6IorNSd3g9lvZYhHISBP
 24z3x0tD0Af1KqjBME0RdEeZVbF86ytKutuV+TRPRJ32QVh97Mi9Zkbpw79MuPD5qhQIYA
 mNDm1J4N6labNmm6HyBK6v4mWa2tkPs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-hpGosQ9rPJCHzev-NsSB5A-1; Mon, 23 Mar 2026 09:57:29 -0400
X-MC-Unique: hpGosQ9rPJCHzev-NsSB5A-1
X-Mimecast-MFC-AGG-ID: hpGosQ9rPJCHzev-NsSB5A_1774274248
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso3408998f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774274248; x=1774879048; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pfcUm49uHHBtyItVC5u633X7yS+mvT2cAbMNi0GNZak=;
 b=WgDgtS1JzTXzZ8gTn/gm4sWuesI7hfB/GJUdS4tJtfXfFMdATOSB8Op+KU23o8+9gG
 ALVYpw18Mza3wHWLEdm2uI87j6jpAXZStWZspIXOJJoI/3MgxDgJ44erN7ptvgGs/czL
 LjYCw5OQ4kAN/mMKApMW24Zlh64QIXsatnZ0QF+8ht/bhHPyjl0kjFd103di1SlOw8Bh
 VEycZKGly3LVa8H+PvqN67lYBtbdw+n1qPxUashYX/MT88ZFNtaF4duIO/B0X7yq33re
 vlrl3TJPXLuXBuHV4d+boaUe5aw4Tl2ol4BI6p8Uulvn9ClOO19eyxuJf58KievVemFm
 yK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274248; x=1774879048;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfcUm49uHHBtyItVC5u633X7yS+mvT2cAbMNi0GNZak=;
 b=YL17P0PeBDKtai4YEstsl3ymHX3y2fFq+m+If7KbuZbM9VGHPeHc25F5BF00lyZBpL
 mK/jNOrZRjBwIigYdL9110b27qLK1aS5JJ8KLeM+XiKG//Ikn4SUBXNxj4yYMgjOw9Di
 bEs8w9e3gMd9JuEz+m/UXypoLFXt/c7M9SG51KIz1ONKMwmX7+aDKz+zYc8kZcITu6s1
 94ElhU6Zo9szTnMNfTEOH0HFf3N9Jn72+TGTk4mQC19BVlUT4OUM/Fbl/Al7G3Ok/MQt
 Zm0S7GROgCcBMYtW07ypJIdZT6sJOr5RY2/AkMrbYLf/qqhOlxMQC5bDLCbkSd/4+2Ey
 yzRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKGzPp4f1WzLG+9wQZs3MOVG1QM9UFokOwr3BzNBryXnf017NXBrzpQwzX7LDdbZPMzslx4Fw7qJGf@nongnu.org
X-Gm-Message-State: AOJu0Yz+tOKQFnhBRhNVpE7zwjihVHvGfd24EqQId9eyQgs5Uzhc6zrt
 juSlWkxIVKjSMLVjMrOUC8HM7UrImFs0BbkYPtBOBfgtQQVb70GJF3lh/ba8bJ1YtucsR150cbK
 LhYswYctj5OPf8GzDD2cGsvn0o1yXhMjPHdrxvOq+s50Ng4Pf44/INf5w
X-Gm-Gg: ATEYQzwmdBbNU63BpUqqUoBWSpbvSi2NJSr/0/88sekPADJ2e5HLMVcZTbMOqw86Iwi
 SmVcXXwn5zeN1j9WQ9PG248ie0t+eQmApvCyo7oHap6+4/fzXUJmC0tRIWlzfAagHjMbLdWF/n8
 3ko/Sw69In67vOc60BC7IFQl60cwHj1pgutRn/DpO9HaY7mbaw+Cdb0Ilzetd06qJyS5YU4JgFV
 6WiBPe3Fca4kUvlYBfzWBb/mRLePeKI3s6XkzlY88Twqk4ZIi72H0TJ7dq4goAFNeT5PALHCZvC
 M2HmNqBwlJTDdsz+CbaW8nfD6Q1zPhzA9Cud6474uQ+t3gpE+zs/yq/OZ9Lpaahy3sEcIcM9iPQ
 rPuW1B+MXGREM7jbp
X-Received: by 2002:a05:6000:1787:b0:439:fcf4:32d0 with SMTP id
 ffacd0b85a97d-43b6427b8a3mr19765631f8f.54.1774274248139; 
 Mon, 23 Mar 2026 06:57:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1787:b0:439:fcf4:32d0 with SMTP id
 ffacd0b85a97d-43b6427b8a3mr19765569f8f.54.1774274247525; 
 Mon, 23 Mar 2026 06:57:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd38bsm29601225f8f.10.2026.03.23.06.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:57:26 -0700 (PDT)
Date: Mon, 23 Mar 2026 09:57:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, yuri.benditovich@daynix.com,
 akihiko.odaki@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
Message-ID: <20260323095706-mutt-send-email-mst@kernel.org>
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
 <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 23, 2026 at 01:53:53PM +0000, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 13:43, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> > > virtio_net_handle_rss() enforces that indirections_len is a non-zero
> > > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > > virtio_net_rss_post_load() applies none of these checks to values
> > > restored from the migration stream.
> > >
> > > A crafted migration stream can set indirections_len to 0.  Even if it
> >
> > The migration stream originating from the source QEMU is trusted.
> 
> Is it? In https://www.qemu.org/docs/master/system/security.html we say:
> 
> # The following entities are untrusted, meaning that they may be buggy
> # or malicious:
> 
> #  * Guest
> #  * User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> #  * Network protocols (e.g. NBD, live migration)
> #  * User-supplied files (e.g. disk images, kernels, device trees)
> #  * Passthrough devices (e.g. PCI, USB)
> 
> which explicitly lists "live migration" as an untrusted entity.
> 
> I would definitely be extremely cautious about having a threat
> model where I had to distrust inbound migration data, but the
> above does suggest we aim to handle that, and we have I think
> in the past taken patches which add sanity-checking to the
> migration data.
> 
> thanks
> -- PMM


And we even assigned a low priority CVEs to these.


