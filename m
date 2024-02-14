Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3763BC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHal-0006xm-My; Wed, 14 Feb 2024 10:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHak-0006xH-0c
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHai-0000lh-Fg
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707926071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7R/fMl0p61ZNLrqQ17Wft4e9Zat6+Eb3H0/ZzAUzcc=;
 b=Iz7vxlxRPeAJ3qkTGSs9kWQASc7NTmBW/S0SRqsTdDmwiE8PCKD3YOJVuOW3k1mVVH7xsu
 PrpYtGwSO+2yc0gU/WKC6ZtKEapQpgGCDqk34gyyUenDhT677qnvX+8TkW9zqXQKFd3ZEK
 5ZQEyhaG3xdvTXiDEtAz+qjcYjGmbqY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-maXjl2IYMN6GqO6uqGuWww-1; Wed, 14 Feb 2024 10:54:30 -0500
X-MC-Unique: maXjl2IYMN6GqO6uqGuWww-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4102b934ba0so32625045e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707926069; x=1708530869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7R/fMl0p61ZNLrqQ17Wft4e9Zat6+Eb3H0/ZzAUzcc=;
 b=AoUI3z0MkqC7iKkBPmp2tKlswWMYusRIGUSnEW1zn+4vwPFqIaozCSlUBV1s8sqf+2
 T/dK5AfLvt33p0lgUtsOPBAKenqtwkYBw+4erJlzSA6EuLOxqtUxHjQFQcYJWDP7HXfx
 KhDS5sMUk1uLretEiybw7MH6RnXlsn7b3n3XL4MoYCXLdsnTSHDh+kI8FKyrt8pJJqZP
 QCkO2YHAScT6HHuCcR5AJvAYwb95cRWTqWgFTOS9MHTNb9weUe7zXkaWqmvuvTh7DJ0N
 s/6wsVCvW4Cl3zVTiEh97Qk3Io+blZ7kO8Bu0LWeyOLWHWtropf7IaaVGi6ZTpyiyOXY
 02mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOkKhmrTsj8EF+EUXXIzZjWK3P5TIhP6DGrLM5CF0q/l5B/ERrdKj8W5QXm1ZDC+zKztIoCnJecVkcADwSJRjvjUaqws8=
X-Gm-Message-State: AOJu0YwXbo8y3Ij3dAp3/g+g1kgfC/aepxZfQ72EMUS79yAxZ5IaKMoC
 u2sZtXf3JmbEpuGxi7kFJWldRfIDWF6XfaX7pMLokZxZiLfKMy5lxxXDKYtoQTTf+W+aFTEWq5z
 +R8W+42sbnfW8pGeCXLBDCV1jHfBo4VgNfDhWwe4lsu09EPkEHzV6
X-Received: by 2002:a05:600c:3f8e:b0:40f:dc50:aea5 with SMTP id
 fs14-20020a05600c3f8e00b0040fdc50aea5mr2534759wmb.22.1707926069100; 
 Wed, 14 Feb 2024 07:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsfXnhtr4wT0hPXeQBa47QJ5tTpnSMMV9VmLtNheKHbIGCrt62phGwDDVakGqALsCiPJMZhw==
X-Received: by 2002:a05:600c:3f8e:b0:40f:dc50:aea5 with SMTP id
 fs14-20020a05600c3f8e00b0040fdc50aea5mr2534739wmb.22.1707926068740; 
 Wed, 14 Feb 2024 07:54:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU9o98DlEX9YimkYMhW2nHH6kkERfKX4FOZtDaFzfNqaNG2yryFMiSXGuLOBwMx3khp2dHpzlXS89o2FzI7B7yrY/WUWrp8CQAUmU7Gr/+yGAn1OeuVUUbv6caXEIpWcyWs6EMfejAxIS2q0Eq2FmKF00evgqTEkEhX/QWg41LAPeuzZfIaYyQ2peDMHOwSLy7xJCHDZqVGDif2rGKO3BWRSOruRNJvQQA/wNqBGbyKxuoboqvE7cginjOi7huNtIiEMwjqH6E8G7tPBtNiccyKOJgTEoSiS3BSzmMd74kEwwszCx26oByMM81TpV+2RmyRZeJ/GpYtL1e+Yc58yoSSzxKizoDXHAKBqw7TsXvtkEuv0GBJ/MhWk81ldSFkkxiBFTWu0/2IEqqSzqz01iehEWMaBRLUrWOgsQ==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b00410d7e55e5asm2364898wmn.3.2024.02.14.07.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 07:54:27 -0800 (PST)
Date: Wed, 14 Feb 2024 10:54:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
Message-ID: <20240214105244-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
 <20240214015107-mutt-send-email-mst@kernel.org>
 <dbb8562b-6532-45af-a6fe-63bbf9b74a1d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb8562b-6532-45af-a6fe-63bbf9b74a1d@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 11:49:52PM +0900, Akihiko Odaki wrote:
> On 2024/02/14 15:52, Michael S. Tsirkin wrote:
> > On Wed, Feb 14, 2024 at 02:13:43PM +0900, Akihiko Odaki wrote:
> > > The guest may write NumVFs greater than TotalVFs and that can lead
> > > to buffer overflow in VF implementations.
> > > 
> > > Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   hw/pci/pcie_sriov.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > > index a1fe65f5d801..da209b7f47fd 100644
> > > --- a/hw/pci/pcie_sriov.c
> > > +++ b/hw/pci/pcie_sriov.c
> > > @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
> > >       assert(sriov_cap > 0);
> > >       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> > > +    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
> > > +        return;
> > > +    }
> > 
> > 
> > yes but with your change PCI_SRIOV_NUM_VF no longer reflects the
> > number of registered VFs and that might lead to uninitialized
> > data read which is not better :(.
> > 
> > How about just forcing the PCI_SRIOV_NUM_VF register to be
> > below PCI_SRIOV_TOTAL_VF at all times?
> 
> PCI_SRIOV_NUM_VF is already divergent from the number of registered VFs. It
> may have a number greater than the current registered VFs before setting VF
> Enable.
> 
> The guest may also change PCI_SRIOV_NUM_VF while VF Enable is set; the
> behavior is undefined in such a case but we still accept such a write. A
> value written in such a case won't be reflected to the actual number of
> enabled VFs.

OK then let's add a comment near num_vfs explaining all this and saying
only to use this value. I also would prefer to have this if
just where we set num_vfs. And maybe after all do set num_vfs to
PCI_SRIOV_TOTAL_VF? Less of a chance of breaking something I feel...

-- 
MST


