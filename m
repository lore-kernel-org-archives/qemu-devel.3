Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D8C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raIDS-0007Au-16; Wed, 14 Feb 2024 11:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raIDP-00075m-T9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raIDN-0001p1-LZ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707928468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icuIjP40OYblSlMVKU+8yQZLEr553hgqpqRVSjRBYKs=;
 b=aKhIviKGBVfdjIqWh7PwNJ4ZuVnmj5iwk4A17Z1TFvJgtYRZaLy1e5uJrthw9+jUBAIHuc
 yIeS5q+GtcoWp3E0KsKaJW9qQATNXyWIrFCbnaEhz+/yL9VSDeaYt/iI+XfDb8+WlVuH4w
 sJ5Sgc0uQxygZQPGYNsoJEBEByKciiE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-fof3hmFzP5G3Euh-HAJ_jg-1; Wed, 14 Feb 2024 11:34:27 -0500
X-MC-Unique: fof3hmFzP5G3Euh-HAJ_jg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3d3e8f1635so51951666b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 08:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707928465; x=1708533265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icuIjP40OYblSlMVKU+8yQZLEr553hgqpqRVSjRBYKs=;
 b=e/Q4FXb5N6b1TNumYlYCqj4SOE0rIwFBCAWZLSPVlv83Lsouvzp1V4WMVYyaxpTijK
 L6OUXZG6S8Bam5N5oUxD93i9h0daMFm94Qzv1PWykgMpkjmWLpmJhe8RHTVeoVCwqmBR
 tAP7/GKwQMjC87DCwX16CWP26oHYNsv3ASYEr8MYfA8AFFgXwufCjvV3G3+mWXeUZ/+z
 MzyHeow1TOclS9wBmwLdvnoiNSK4T3yg6GUYt0jpaWQc36DUu1JTAhHilD20AwD3jHNp
 L/IwAOXdDrviyJ5d3R4iAp6YOR39s1DIEKDVSjwuPqYVsQF6f3TvT3Ziw1MUHWPs+3l9
 ZtTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/95EvjOuzSRHO8fOQSPV+oCKqSLxRnFjSi2MX+4mXVAmdmYr66AM9hCjQebRl6UoY10Pxs+D4NcrMyDHz3l/bfygE+JM=
X-Gm-Message-State: AOJu0YxeErw6NzJX5PIwv+g/0CXPh//pCPMNOqbMFMxNHTjtQm9mET5c
 qbJInBRy77sK0ncFjDl8wvbbVIRm57JKMoaHa3z2FKad9tZ74dCNuH0D4BM4JlxAgnH+xkN7cho
 22uVzcHaUmwkziuwwoedWhsIE6RJD/U9/Y97hcKet/8zt71UjzccM
X-Received: by 2002:a17:906:264d:b0:a3c:881d:8a8e with SMTP id
 i13-20020a170906264d00b00a3c881d8a8emr2110585ejc.64.1707928465282; 
 Wed, 14 Feb 2024 08:34:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPr/2MOrX5O6VCTdXOyHtdGCspWvOaqvRfDoct6/slXP0bc3LxcyLjGMsdkG84vqqJ3T/jUQ==
X-Received: by 2002:a17:906:264d:b0:a3c:881d:8a8e with SMTP id
 i13-20020a170906264d00b00a3c881d8a8emr2110570ejc.64.1707928464903; 
 Wed, 14 Feb 2024 08:34:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXvASEkc4amE2xQbFgF2DRYNCzIjj0hy6LO0tZgsN7UDPqEj6CbJarl5rkmDGDZslIr9agweiI743nHEXA5/q5g325Ggf44pk0SBQjVKRMynl2yLIzJi8Cf3meaG4U8O6EIPFZP+zqMqohzGFTXe2miMgqVPICx0ijQi497X6LSVMSuXiyPhG0LHaE3MnZkAc0pYkpTkTEtVVzkawN/7EaurzYRgh/JYOMGpCp2f8wU4rrUIVkcjWaR6SePu+97+N2tvrUx6Y0OYD/K4WvSYRQSntsZjV/TJ4CviKm2uXucRHoFDXwJuUu7lSXM6JokuUnAxuZTZxBTZ675du2uoWTYUVhyLZvcNJhS92oM9wGyyXDMUjtl8DfUQOjsnj/qn0nKTu+eWgJrjKpzeM0nw6vdBjEUE28dUaox1w==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 e20-20020a170906249400b00a3d7769b51esm19229ejb.53.2024.02.14.08.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 08:34:24 -0800 (PST)
Date: Wed, 14 Feb 2024 11:34:19 -0500
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
Subject: Re: [PATCH v4 9/9] hw/nvme: Refer to dev->exp.sriov_pf.num_vfs
Message-ID: <20240214113312-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-9-89ad093a07f4@daynix.com>
 <20240214015457-mutt-send-email-mst@kernel.org>
 <c7369ada-96b1-41ad-b141-ff7f1e1dc291@daynix.com>
 <20240214103705-mutt-send-email-mst@kernel.org>
 <0f7ae8e0-6c59-400a-8fc0-7ab21b7471d2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7ae8e0-6c59-400a-8fc0-7ab21b7471d2@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 15, 2024 at 01:07:29AM +0900, Akihiko Odaki wrote:
> On 2024/02/15 0:46, Michael S. Tsirkin wrote:
> > On Wed, Feb 14, 2024 at 11:09:50PM +0900, Akihiko Odaki wrote:
> > > On 2024/02/14 16:07, Michael S. Tsirkin wrote:
> > > > On Wed, Feb 14, 2024 at 02:13:47PM +0900, Akihiko Odaki wrote:
> > > > > NumVFs may not equal to the current effective number of VFs because VF
> > > > > Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
> > > > > greater than TotalVFs.
> > > > > 
> > > > > Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > > > I don't get what this is saying about VF enable.
> > > > This code will not trigger on numVFs write when VF enable is set.
> > > > Generally this commit makes no sense on its own, squash it with
> > > > the pci core change pls.
> > > 
> > > This code is meant to run when it is clearing VF Enable, and its
> > > functionality is to change the state of VFs currently enabled so that we can
> > > disable them.
> > > 
> > > However, NumVFs does not necessarily represent VFs currently being enabled,
> > > and have a different value in the case described above.
> > 
> > Ah so in this case, if numvfs is changed and then VFs are disabled,
> > we will not call nvme_virt_set_state? OK, it should say this in commit log.
> > And then, what happens?
> 
> We will call nvme_virt_set_state() but only for VFs already enabled.

And? What does it cause? memory leak? some buffer is overrun?
the guest behaviour is illegal so it does not really
matter what we do as long as nothing too bad happens.

> > 
> > > Such cases exist
> > > even before the earlier patches and this fix is independently meaningful.
> > 
> > yes but the previous patch causes a regression without this one.
> > squash it.
> 
> I'll move this patch before the previous patch.
> 
> > 
> > 
> > > > 
> > > > > ---
> > > > >    hw/nvme/ctrl.c | 5 ++---
> > > > >    1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > > > > index f8df622fe590..daedda5d326f 100644
> > > > > --- a/hw/nvme/ctrl.c
> > > > > +++ b/hw/nvme/ctrl.c
> > > > > @@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> > > > >        NvmeSecCtrlEntry *sctrl;
> > > > >        uint16_t sriov_cap = dev->exp.sriov_cap;
> > > > >        uint32_t off = address - sriov_cap;
> > > > > -    int i, num_vfs;
> > > > > +    int i;
> > > > >        if (!sriov_cap) {
> > > > >            return;
> > > > > @@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> > > > >        if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> > > > >            if (!(val & PCI_SRIOV_CTRL_VFE)) {
> > > > > -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> > > > > -            for (i = 0; i < num_vfs; i++) {
> > > > > +            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {
> > 
> > If the assumption you now make is that num_vfs only changes
> > when VFs are disabled, we should add a comment documenting this.
> > In fact, I think there's a nicer way to do this:
> > 
> > static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
> >                                    uint32_t val, int len)
> > {
> >      int old_num_vfs = dev->exp.sriov_pf.num_vfs;
> > 
> >      pci_default_write_config(dev, address, val, len);
> >      pcie_cap_flr_write_config(dev, address, val, len);
> >      nvme_sriov_pre_write_ctrl(dev, address, val, len, old_num_vfs);
> > }
> > 
> > and now, nvme_sriov_pre_write_ctrl can compare:
> > 
> > if (old_num_vfs && !dev->exp.sriov_pf.num_vfs)
> > 	disable everything
> > 
> > 
> > this, without bothering with detail of SRIOV capability.
> > No?
> 
> It looks better. I'll do so in the next version.


