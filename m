Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66A3E68955
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6TZm-00059g-A2; Thu, 31 Oct 2024 07:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t6TZj-00059N-CZ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t6TZg-0007JD-LO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730374963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0d0XIuJT6jqOYuopAQDB6w2ik3Fx6ww1pyPefhqJJ10=;
 b=YUBbomUO3aBXjJcTjUoa38K2XIczIqr3p2n5HOIdqOpiGkQhQTqNmCEI2SVD8mzS8GKRuY
 O96n0MGVUTXBGskWLXAJsL1zkkRFD6RvKHflXztZhWI78tGN/sILGH59+fWuGd2+4T49/d
 l9V+YqW62w4LvX7Y4JCknD6z/qST/No=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-PvHACf0rNIiwF_i3omscCg-1; Thu, 31 Oct 2024 07:42:39 -0400
X-MC-Unique: PvHACf0rNIiwF_i3omscCg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso6961385e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 04:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730374958; x=1730979758;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0d0XIuJT6jqOYuopAQDB6w2ik3Fx6ww1pyPefhqJJ10=;
 b=mC3pi9CFPXjT1gxaE6U819RHl1JFOwbdcwa4zVqB7uhSk22+Qg6go/scYtyNsPnpoC
 dRU9vMCadsTdzWWTdIAGb07DjSc4z2G1HzfZJsgkwgKs9dursnjBDLuyo7gCZK52Imi0
 Kj28b/Jqu/q4b4j/DEb/j5jcVZgZLjd2zDy+78WDJhtbBukq8L8KEikeRT8UivuAtZkv
 2X7scuInzp6/5zmmQYDE4o8aIwxnid54xWFPaED+4oDUaYUByGOfWjvqimlVZzf0KIFw
 WBFoG93RecyCqhYAoYOVeFAB81ODki8PlSBD0aft8zgYwHwIcA++abUZ3jG2dxLPGR8O
 GZIw==
X-Gm-Message-State: AOJu0YwyuGewCi3S4RJ9ryNqmZA6ztZj+fmG4jfTXfIAXATY5vssQijl
 XQyp0qcfbBLf/iR7h4b+BgV7KCMJuRvckpC+CBy8sQ3fvNeJjC9Z0yhkjqMtHpkNGls+KrRg4mi
 pLzEA1YJTjJy0GfVCCNX30U8Up6jGS6wZSHdLZGSH5MdGrkLnmfqP
X-Received: by 2002:a05:600c:3b8f:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-4319ac6f8f8mr209964115e9.7.1730374958095; 
 Thu, 31 Oct 2024 04:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVbpn0CsH4Gk+ZEZXPeNVwLcE14YlLLvJBgKaTpmiCfN2YpvPa/m4ugRYr52C1lWRB5fUTLQ==
X-Received: by 2002:a05:600c:3b8f:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-4319ac6f8f8mr209963905e9.7.1730374957737; 
 Thu, 31 Oct 2024 04:42:37 -0700 (PDT)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917fefsm52697485e9.16.2024.10.31.04.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 04:42:37 -0700 (PDT)
Date: Thu, 31 Oct 2024 07:42:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: enable Extended tag field support
Message-ID: <20241031074216-mutt-send-email-mst@kernel.org>
References: <20241023113820.486017-1-marcin.juszkiewicz@linaro.org>
 <0a77763b-94b0-42de-96a3-5fc6882be06c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a77763b-94b0-42de-96a3-5fc6882be06c@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Oct 31, 2024 at 12:10:26PM +0100, Marcin Juszkiewicz wrote:
> W dniu 23.10.2024 o 13:38, Marcin Juszkiewicz pisze:
> >  From what I read PCI has 32 transactions, PCI Express devices can handle
> > 256 with Extended tag enabled (spec mentions also larger values but I
> > lack PCIe knowledge).
> 
> Ping?
> 

tagged, thanks!

> > QEMU leaves 'Extended tag field' with 0 as value:
> > 
> > Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, IntMsgNum 0
> >          DevCap: MaxPayload 128 bytes, PhantFunc 0
> >                  ExtTag- RBE+ FLReset- TEE-IO-
> > 
> > SBSA ACS has test 824 which checks for PCIe device capabilities. BSA
> > specification [1] (SBSA is on top of BSA) in section F.3.2 lists
> > expected values for Device Capabilities Register:
> > 
> > Device Capabilities Register     Requirement
> > Role based error reporting       RCEC and RCiEP: Hardwired to 1
> > Endpoint L0s acceptable latency  RCEC and RCiEP: Hardwired to 0
> > L1 acceptable latency            RCEC and RCiEP: Hardwired to 0
> > Captured slot power limit scale  RCEC and RCiEP: Hardwired to 0
> > Captured slot power limit value  RCEC and RCiEP: Hardwired to 0
> > Max payload size                 value must be compliant with PCIe spec
> > Phantom functions                RCEC and RCiEP: Recommendation is to
> >                                   hardwire this bit to 0.
> > Extended tag field               Hardwired to 1
> > 
> > 1. https://developer.arm.com/documentation/den0094/c/
> > 
> > This change enables Extended tag field. All versioned platforms should
> > have it disabled for older versions (tested with Arm/virt).
> > 
> > Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > ---
> >   hw/core/machine.c    | 4 +++-
> >   hw/pci/pci.c         | 2 ++
> >   hw/pci/pcie.c        | 8 +++++++-
> >   include/hw/pci/pci.h | 2 ++
> >   4 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index adaba17eba..8ccc74067a 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -34,7 +34,9 @@
> >   #include "hw/virtio/virtio-iommu.h"
> >   #include "audio/audio.h"
> > -GlobalProperty hw_compat_9_1[] = {};
> > +GlobalProperty hw_compat_9_1[] = {
> > +    { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
> > +};
> >   const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
> >   GlobalProperty hw_compat_9_0[] = {
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 87da35ca9b..9a3b0e4a43 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -87,6 +87,8 @@ static Property pci_props[] = {
> >                       QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> >       DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> >                        max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
> > +    DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
> > +                    QEMU_PCIE_EXT_TAG_BITNR, true),
> >       DEFINE_PROP_END_OF_LIST()
> >   };
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 4b2f0805c6..9f369c2b6c 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -86,7 +86,13 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
> >        * Specification, Revision 1.1., or subsequent PCI Express Base
> >        * Specification revisions.
> >        */
> > -    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
> > +    uint32_t devcap = PCI_EXP_DEVCAP_RBER;
> > +
> > +    if (dev->cap_present & QEMU_PCIE_EXT_TAG) {
> > +        devcap = PCI_EXP_DEVCAP_RBER | PCI_EXP_DEVCAP_EXT_TAG;
> > +    }
> > +
> > +    pci_set_long(exp_cap + PCI_EXP_DEVCAP, devcap);
> >       pci_set_long(exp_cap + PCI_EXP_LNKCAP,
> >                    (port << PCI_EXP_LNKCAP_PN_SHIFT) |
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index eb26cac810..5b14f9d375 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -213,6 +213,8 @@ enum {
> >       QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> >   #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> >       QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> > +#define QEMU_PCIE_EXT_TAG_BITNR 13
> > +    QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
> >   };
> >   typedef struct PCIINTxRoute {


