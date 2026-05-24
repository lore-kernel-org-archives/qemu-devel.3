Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20055CD5BB4
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 06:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR2ni-0003KK-Tl; Sun, 24 May 2026 02:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR2nd-0003Ju-Fs
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR2na-00004q-UT
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779605935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1NFLSivcclWCV2sCtRH9P5Pb5CBAnsIKZ1gnsz3RI44=;
 b=VvSxPeKD/gWnDe5WLPfA6OPZ7Lb9RQN3OEHIbt3ihf0g8k+Bm2NmmIp99fonihfYJCWggH
 lTY/ZubBsQqq7amF8axRY95sPU48zIMukLgnaz9BVu4tLX/WrlWLDbvU47paH5D+b/m6Ag
 Kn0z6F/J+SYCMj9Jf9SRV5P2QAhRpbQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-TDUkeNsRO4K68rxgL5sLEA-1; Sun, 24 May 2026 02:58:53 -0400
X-MC-Unique: TDUkeNsRO4K68rxgL5sLEA-1
X-Mimecast-MFC-AGG-ID: TDUkeNsRO4K68rxgL5sLEA_1779605933
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49051422d55so5773825e9.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779605932; x=1780210732; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1NFLSivcclWCV2sCtRH9P5Pb5CBAnsIKZ1gnsz3RI44=;
 b=R1P+uLhNQEYyHuNT1HbENvbIKyj9TsxUM5zmugRVCZB8nbNTGDV0nqBq250AEmFSlQ
 VcIaMtlro/m2roo6T+TYKsLv7LlYbpsF+eBVbWf82HLidWcqXM3TTyvE3OTw5cTzXKtC
 AnQ4XCfrS9axfyx7OJPlBFL5ISuCf7VPMJRDG3HDVUtYSeQtBjbX+1aHjmfVa6b+DhX9
 1Nu7N9D8ZIxTUYAeOTgOunQXq9sX5yIO+Znj39aL/m4gq+Z23O7KPDDoDyHp70wNC2qO
 9vP/3FaENFLbQ3Y2D1JpEO/Xj7eOoqcRU5AtC1MuvTdAg0T/vnz6O09fLj/WdCyc2cqw
 th+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779605932; x=1780210732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NFLSivcclWCV2sCtRH9P5Pb5CBAnsIKZ1gnsz3RI44=;
 b=oXEI2juhorP8mH99MydhCncz3XaHQ8EXs5xJqA1SlpTzbSa5CCoK+vbknVhHnEbqi4
 rwgWIPmASt4ndzBhJeKDvRpPMxfP2EqPCBjbUZX6T1CjWoJM0Dyx2+R+jlmqqnYjrhQf
 Ax8n6O3hkLLzNLfkPqSjJaY8lJnrjFHv0LV8xAjBtR96/xtJi5qBLUPAhLbOLRBgRTV+
 EI6lNV/EdhJ9WML9izfsyn8NcLRKnZASYHhV/mZFvcqvNajt5SwcBdbNz3wuew11OmAm
 KG22loUuNIPVlZpL1yb9oJhbwN2Xp/egA+GIoBwxOibx59u7tpEaTek1/9dZiLI6ENKC
 9EEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PvU3ku7MyNVFWHWlIggCdZjIHrzGP9OK8daYN9Ok0s4n9BFQql40HBX69vjghV/9NxTedrXySfk/0@nongnu.org
X-Gm-Message-State: AOJu0YzeJg+H7n/mMNmj951dWNwjlkucpqrr1hqK2fHF9LOgE3bqXGeJ
 b24omR0XLMiU3xW0BdL6wEG9RsKo9UhjNG51rW9reqYn3oCif+LIRACpfFfzvnXssi6eIbcgOmV
 qpc7YyO2qA7ioMiZljXbVur0/hXLg9LnDHyajcr5yF6TEey5z9dnFk0oY
X-Gm-Gg: Acq92OFCNxOhZNoFci3AXuKvUEXthh/nSE4F6lmNibAXM0SMOCze0q9osQrTzA3qaB0
 OSpaaAmVIYbBlqMyGGn9v+pHsrYbe6RG+JMJV8/dl62K5X94ulOiw+qpW/0N2Ez0ubPYifml9Lv
 X+WSHp0jCq/z+mq5mzbz16pgi4QhE78ksmYLRWjumXLItKbk9r8yz+sPl3TV5LGqFkSTrOSkKxF
 rUifBwMBRW7gwFJvP4AJDNPNxBYIQTNRQnOaftQ1RQTAz/X/ENKYkIykIWE0JAjrTVLV3TETedi
 DE/FC+x/EPSRdvLmlBeEv3ONlZsmK6b8uCELGIwFX04absBJ1NMo3W6Wq4Fau5sMupngj4/6DY7
 fSKHdNqfcQSxajub5mCA9umK9LUqPdQN3qglu7EXATTY=
X-Received: by 2002:a05:600c:c10b:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-490426ddc41mr120366565e9.25.1779605932498; 
 Sat, 23 May 2026 23:58:52 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-490426ddc41mr120366445e9.25.1779605932075; 
 Sat, 23 May 2026 23:58:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d4c39sm54431285e9.20.2026.05.23.23.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 23:58:51 -0700 (PDT)
Date: Sun, 24 May 2026 02:58:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v6 04/22] vhost: move protocol_features to vhost_user
Message-ID: <20260524025735-mutt-send-email-mst@kernel.org>
References: <20260420200339.708640-1-vsementsov@yandex-team.ru>
 <20260420200339.708640-5-vsementsov@yandex-team.ru>
 <6b808fc2-a90e-4b25-84d2-d516eb176c8e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b808fc2-a90e-4b25-84d2-d516eb176c8e@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 22, 2026 at 03:31:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 20.04.26 23:03, Vladimir Sementsov-Ogievskiy wrote:
> > As comment says: it's only for vhost-user. So, let's move it
> > to corresponding vhost backend realization.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >   backends/cryptodev-vhost.c     |  1 -
> >   hw/block/vhost-user-blk.c      |  6 ++----
> >   hw/net/vhost_net.c             |  2 --
> >   hw/virtio/meson.build          |  3 +++
> >   hw/virtio/vhost-user-stub.c    |  6 ++++++
> >   hw/virtio/vhost-user.c         | 36 +++++++++++++++++++++++++++-------
> >   hw/virtio/virtio-qmp.c         |  6 ++++--
> >   include/hw/virtio/vhost-user.h |  4 ++++
> >   include/hw/virtio/vhost.h      |  8 --------
> >   9 files changed, 48 insertions(+), 24 deletions(-)
> >   create mode 100644 hw/virtio/vhost-user-stub.c
> > 
> 
> [..]
> 
> > diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> > index 415e359e9fc..adc3a4f748a 100644
> > --- a/hw/virtio/meson.build
> > +++ b/hw/virtio/meson.build
> > @@ -43,6 +43,8 @@ if have_vhost
> >                            if_true: files('vhost-user-input-pci.c'))
> >       system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
> >                            if_true: files('vhost-user-spi-pci.c'))
> 
> Small conflict, when applying to current master, as in master there is now
> one more entry after CONFIG_VHOST_USER_SPI:
> 
>    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RTC'],
>                         if_true: files('vhost-user-rtc-pci.c'))
> 
> so, "else" should go after this new CONFIG_VHOST_USER_RTC entry.
> 
> 
> Let me know, if resend needed.
> 
> > +  else
> > +    system_virtio_ss.add(files('vhost-user-stub.c'))
> >     endif
> >     if have_vhost_vdpa
> >       system_virtio_ss.add(files('vhost-vdpa.c'))
> > @@ -91,6 +93,7 @@ system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
> >   system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
> >   stub_ss.add(files('vhost-stub.c'))
> > +stub_ss.add(files('vhost-user-stub.c'))
> >   stub_ss.add(files('virtio-stub.c'))
> >   stub_ss.add(files('virtio-md-stubs.c'))


I'm confused why would we add vhost-user-stub.c twice at all.


> 
> 
> -- 
> Best regards,
> Vladimir


