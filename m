Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742DAC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHSn-0001Ku-Ss; Wed, 14 Feb 2024 10:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHSm-0001Kk-HH
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHSj-0007BP-Er
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707925576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9wcQAypRgyo+My3crtv5shRBgjt9hakP8xZcE2QOII=;
 b=GPBaBiYcVc95gu5CRtleNPQ9E9WZZHX9VC95zOZjwgIanJ+ZOLieW/q4kCZ+LpuLtI9TyF
 keaQc4+a15lTe3Y+aGt+mdNxzYyv82F89yp6XS8YGD+e2s/4Rqg1GxjBqT4JEoSVpdU4X7
 +rjHUm+ZrzsG1cNqYMKJxbvOOripBkI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-TgbJ76p-N0acVG8NlXqqlw-1; Wed, 14 Feb 2024 10:46:10 -0500
X-MC-Unique: TgbJ76p-N0acVG8NlXqqlw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33b8837355dso1247619f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707925569; x=1708530369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9wcQAypRgyo+My3crtv5shRBgjt9hakP8xZcE2QOII=;
 b=nvwL3w8a9p0or+U7lyQHRbSgps6NAQTKCGEMFl/mHcKH7V7y3+X58GqurRVvX9IUdY
 RXKlOeYAqFFdERVs+1fLLh8t6zC3+UnJSIWaN4ufGqz7sYDy/9Ssxpq39DuIVqNXl2ZM
 xRXn9UpfBpAse2wofksakd9xmd4Tfe8LTxSJs21MZLRqlSI3hM+SpBS/WCh8nAU1CHl4
 ggmYlIxhqqF4WsZH22U9G5LTqZeIk8OgzgZyKzNK9nVVssv5mdL6BJ5R/2wKqnOsJ0cg
 BbLESl4lPRqcmwoAoDfjXYxQw/MOzpESoP3/ITzIXMLaMkLOJC7gsMb+vX6hybV0JJNN
 369A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbS0MC5meKM0QI3XYs8P6AYn9d9WvM3ma+XUeeBt5r4w68O19Av4+8nkeGLpvzX/kEYpPW6PT9o5aiQ+XeqAwLEUtGB7E=
X-Gm-Message-State: AOJu0YxLriVBHKcDjUxH1+nbqB0+wdcsZONKXy9ClnFC5jFGQPM1Lzz2
 MfGKwuYfZdyuMojVSRKyKrgzgziRG5Pn35CLB4ECrta5bTBtN9vI07oLeIn0WuiLj4DTB9ZEaQ1
 ICJrrSPAd/4AFIrUGoVW57iQ5tsnD07E2rCAGZgIHhuCdsRQICVmT
X-Received: by 2002:adf:fd49:0:b0:33b:4b0f:b98c with SMTP id
 h9-20020adffd49000000b0033b4b0fb98cmr2477769wrs.32.1707925568941; 
 Wed, 14 Feb 2024 07:46:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+7MwHWemuNF9t4wkOrD5bav7Q3C6HZKiB79lznPYSv3KezLzx6n92F+r2G+Z84fq/GCMAWA==
X-Received: by 2002:adf:fd49:0:b0:33b:4b0f:b98c with SMTP id
 h9-20020adffd49000000b0033b4b0fb98cmr2477739wrs.32.1707925568561; 
 Wed, 14 Feb 2024 07:46:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWyrPxfyCYa89Opn1b4UFxCzoZoQfsA3QebdyvqTNCg+gXfhQQ2GgJAaaf4V9kr7Y05Kb0JREHCVOUXXRQ1HbVMgImXWQgZBMYf/FFc0fhRsphqCngrDeAkcwVGz01cFQteovvNaZ4/KMkalpt/FSWtEyOBBtUiiQ/P0oya2qNNvJprz+xVzptoUSc58u3QbhsACXjcDqWVlEL36Shojaelaqc5oVkaQRGW7pUhyYNt3MFmLVGtdDcDGO1fGoJt8R3GuWt5dTmv5kCOYFht7IaWLTiiT9vMyKcvdC6lbkeicrIM4jIgv+cU2htlxmd7lNkoXXcNU7HFgJjVvC04l2vbVvsXrvaPwuXJSwEQRfYUmKWWYC+LDzrxs5ra5zCCNkZEp/eVpqnG0Mzra7pgSRknFHorYMh36UMR8w==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm12408673wrb.79.2024.02.14.07.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 07:46:07 -0800 (PST)
Date: Wed, 14 Feb 2024 10:46:03 -0500
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
Message-ID: <20240214103705-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-9-89ad093a07f4@daynix.com>
 <20240214015457-mutt-send-email-mst@kernel.org>
 <c7369ada-96b1-41ad-b141-ff7f1e1dc291@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7369ada-96b1-41ad-b141-ff7f1e1dc291@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 14, 2024 at 11:09:50PM +0900, Akihiko Odaki wrote:
> On 2024/02/14 16:07, Michael S. Tsirkin wrote:
> > On Wed, Feb 14, 2024 at 02:13:47PM +0900, Akihiko Odaki wrote:
> > > NumVFs may not equal to the current effective number of VFs because VF
> > > Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
> > > greater than TotalVFs.
> > > 
> > > Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > I don't get what this is saying about VF enable.
> > This code will not trigger on numVFs write when VF enable is set.
> > Generally this commit makes no sense on its own, squash it with
> > the pci core change pls.
> 
> This code is meant to run when it is clearing VF Enable, and its
> functionality is to change the state of VFs currently enabled so that we can
> disable them.
> 
> However, NumVFs does not necessarily represent VFs currently being enabled,
> and have a different value in the case described above.

Ah so in this case, if numvfs is changed and then VFs are disabled,
we will not call nvme_virt_set_state? OK, it should say this in commit log.
And then, what happens?

> Such cases exist
> even before the earlier patches and this fix is independently meaningful.

yes but the previous patch causes a regression without this one.
squash it.


> > 
> > > ---
> > >   hw/nvme/ctrl.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > > index f8df622fe590..daedda5d326f 100644
> > > --- a/hw/nvme/ctrl.c
> > > +++ b/hw/nvme/ctrl.c
> > > @@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> > >       NvmeSecCtrlEntry *sctrl;
> > >       uint16_t sriov_cap = dev->exp.sriov_cap;
> > >       uint32_t off = address - sriov_cap;
> > > -    int i, num_vfs;
> > > +    int i;
> > >       if (!sriov_cap) {
> > >           return;
> > > @@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> > >       if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> > >           if (!(val & PCI_SRIOV_CTRL_VFE)) {
> > > -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> > > -            for (i = 0; i < num_vfs; i++) {
> > > +            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {

If the assumption you now make is that num_vfs only changes
when VFs are disabled, we should add a comment documenting this.
In fact, I think there's a nicer way to do this:

static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
                                  uint32_t val, int len)
{
    int old_num_vfs = dev->exp.sriov_pf.num_vfs;

    pci_default_write_config(dev, address, val, len);
    pcie_cap_flr_write_config(dev, address, val, len);
    nvme_sriov_pre_write_ctrl(dev, address, val, len, old_num_vfs);
}

and now, nvme_sriov_pre_write_ctrl can compare:

if (old_num_vfs && !dev->exp.sriov_pf.num_vfs)
	disable everything


this, without bothering with detail of SRIOV capability.
No?



> > >                   sctrl = &n->sec_ctrl_list.sec[i];
> > >                   nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
> > >               }
> > > 
> > > -- 
> > > 2.43.0
> > 


