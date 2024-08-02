Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C127C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvWi-0001TW-Kt; Fri, 02 Aug 2024 12:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZvWh-0001Rq-D6
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZvWf-0003bW-0A
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722617587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JjBkgDXfZ4Ivjyv1O8UHc1PGSEmnokEtXxYejfzK+NI=;
 b=Nh7A0uwRMhCUruN4Ku0+UqdLTpoWww9RYl9hgov2QCtW/iVg7MHCDjLgR+QbgJUh2rqduX
 pMgmTdEwsTk8h9jskNpTEkeVPKx0Jw/16tHSL6mj3im3omBeKYmxvfRxTizuIkdgbwNFAl
 U6YrqlHWPGEdTbaVRy4c7TbOYe5ajP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-JbSWDsztMsy2eCCVcfzohA-1; Fri, 02 Aug 2024 12:53:06 -0400
X-MC-Unique: JbSWDsztMsy2eCCVcfzohA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4281d0d1c57so17105395e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722617585; x=1723222385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjBkgDXfZ4Ivjyv1O8UHc1PGSEmnokEtXxYejfzK+NI=;
 b=GSnuNtO1B6e8ELkNsLElXvs9c0AHU1PAnmJWG30eG0PStT39AjrJIYl4VhLPc+omVv
 sK+jIV9SPDLQCWFSy86PCgpH3dJn05DfEu/PgUGn8r402FykheM0KAv+cy5MqDOaQv9F
 w4XFBlQIZJvaPbCmn7Q/hNONhMmrzcfjfCnpfzBVHIOxJkBUbz5fFFn2SlVHgQ7inhN2
 9FUDG2pCfhgOTy43sx/3XSmwyILbKWdYkQ8zUewsHblU1tU5bOt52JO8oGkzYHstyoV4
 StYbAE3JZ+YoGseuMWUa+stduh/QfLCeOkE8c9faSgUEJMThZwlWzwbiyAvq6PPMRm39
 yyJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYCnlmOIDu+JRrAI+/alZmukq9LmA1wSO7DLKVqT2owtP0az7GQlJ0rUQUQitUA1gFVde6NIAjJadyqBIcnIYn5FMTmq8=
X-Gm-Message-State: AOJu0Yxp0UXg79bxzFptNkrMHNdupM/JcUSLhVMFhMSMXta+2zWICkG7
 0159R5l+tCz3qdf+zR8V1ad7UTEvRw4wH2QLNTV13CeuMSNJtC6U57e1d/p+m2Q8+y2JmmOcbBR
 wYrYu/oELO7zKSU/BYjc37+UvvxHmsDaLRq0UjYwCx6jpd69nBN9H
X-Received: by 2002:adf:f60b:0:b0:36b:aa96:d1e5 with SMTP id
 ffacd0b85a97d-36bbbe5b841mr3502142f8f.18.1722617585004; 
 Fri, 02 Aug 2024 09:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2mPhvXqUKWcX3r7C0v3gkaIfy5REYH4ttR5ojgGhiC9HKC7wIOM3fRFcLiI4DwMJZq6g8Bw==
X-Received: by 2002:adf:f60b:0:b0:36b:aa96:d1e5 with SMTP id
 ffacd0b85a97d-36bbbe5b841mr3502105f8f.18.1722617584102; 
 Fri, 02 Aug 2024 09:53:04 -0700 (PDT)
Received: from redhat.com ([31.187.78.99]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf1e175sm2330207f8f.29.2024.08.02.09.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:53:03 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:52:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v11 08/11] pcie_sriov: Remove num_vfs from
 PCIESriovPF
Message-ID: <20240802124956-mutt-send-email-mst@kernel.org>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-8-fb83bb8c19fb@daynix.com>
 <20240802083911-mutt-send-email-mst@kernel.org>
 <5058d9d4-7922-4746-b6d1-b16046bf69f9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5058d9d4-7922-4746-b6d1-b16046bf69f9@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Aug 03, 2024 at 12:38:10AM +0900, Akihiko Odaki wrote:
> On 2024/08/02 21:58, Michael S. Tsirkin wrote:
> > On Fri, Aug 02, 2024 at 02:17:58PM +0900, Akihiko Odaki wrote:
> > > num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
> > > instead.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   include/hw/pci/pcie_sriov.h |  1 -
> > >   hw/pci/pcie_sriov.c         | 28 ++++++++++++++++++++--------
> > >   hw/pci/trace-events         |  2 +-
> > >   3 files changed, 21 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> > > index 70649236c18a..5148c5b77dd1 100644
> > > --- a/include/hw/pci/pcie_sriov.h
> > > +++ b/include/hw/pci/pcie_sriov.h
> > > @@ -16,7 +16,6 @@
> > >   #include "hw/pci/pci.h"
> > >   typedef struct PCIESriovPF {
> > > -    uint16_t num_vfs;   /* Number of virtual functions created */
> > >       uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> > >       PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
> > >   } PCIESriovPF;
> > > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > > index 9bd7f8acc3f4..fae6acea4acb 100644
> > > --- a/hw/pci/pcie_sriov.c
> > > +++ b/hw/pci/pcie_sriov.c
> > > @@ -57,7 +57,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
> > >       pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
> > >                           offset, PCI_EXT_CAP_SRIOV_SIZEOF);
> > >       dev->exp.sriov_cap = offset;
> > > -    dev->exp.sriov_pf.num_vfs = 0;
> > >       dev->exp.sriov_pf.vf = NULL;
> > >       pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> > > @@ -186,6 +185,12 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
> > >       }
> > >   }
> > > +static void clear_ctrl_vfe(PCIDevice *dev)
> > > +{
> > > +    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
> > 
> > space here, after definition
> > 
> > > +    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
> > > +}
> > > +
> > 
> > Pls use pci_word_test_and_clear_mask
> 
> That sounds good. I'll do so with the next version.
> 
> > 
> > 
> > >   static void register_vfs(PCIDevice *dev)
> > >   {
> > >       uint16_t num_vfs;
> > > @@ -195,6 +200,7 @@ static void register_vfs(PCIDevice *dev)
> > >       assert(sriov_cap > 0);
> > >       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> > >       if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
> > > +        clear_ctrl_vfe(dev);
> > >           return;
> > >       }
> > > @@ -203,20 +209,18 @@ static void register_vfs(PCIDevice *dev)
> > >       for (i = 0; i < num_vfs; i++) {
> > >           pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
> > >       }
> > > -    dev->exp.sriov_pf.num_vfs = num_vfs;
> > >   }
> > >   static void unregister_vfs(PCIDevice *dev)
> > >   {
> > > -    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
> > >       uint16_t i;
> > > +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> > >       trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
> > > -                               PCI_FUNC(dev->devfn), num_vfs);
> > > -    for (i = 0; i < num_vfs; i++) {
> > > +                               PCI_FUNC(dev->devfn));
> > > +    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
> > 
> > Why PCI_SRIOV_TOTAL_VF not PCI_SRIOV_NUM_VF/pcie_sriov_num_vfs?
> 
> Because PCI_SRIOV_NUM_VF is overwritten when unregister_vfs() is called.


maybe this function should get the range of VFs to unregister, then.

> > 
> > 
> > >           pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
> > >       }
> > > -    dev->exp.sriov_pf.num_vfs = 0;
> > >   }
> > >   void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> > > @@ -242,6 +246,9 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> > >           } else {
> > >               unregister_vfs(dev);
> > >           }
> > > +    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
> > > +        clear_ctrl_vfe(dev);
> > > +        unregister_vfs(dev);
> > 
> > So any write into PCI_SRIOV_NUM_VF automatically clears VFE?
> > 
> > Yes writing into PCI_SRIOV_NUM_VF should not happen when VFE
> > is set, but spec does not say we need to clear it automatically.
> > Why come up with random rules? just don't special case it,
> > whatever happens, let it happen.
> > 
> > And what does this change have to do with getting rid of
> > num_vfs?
> 
> Keeping VFs working requires to know the number of VFs, but we do no longer
> know it because PCI_SRIOV_NUM_VF is overwritten. This disables all VFs
> instead of trying to keep VFs alive.
> 
> Regards,
> Akihiko Odaki

However, we then get into a situation where VFE is set but
PCI_SRIOV_NUM_VF no longer reflects the # of registered VFs.
Given you removed num_vfs which was exactly
the # of registered VFs, it is hard to say if that will lead to
confusion now or later.

-- 
MST


