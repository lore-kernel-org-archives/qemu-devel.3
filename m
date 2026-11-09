Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20612606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KF04rEN2;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ti483s+V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDvj-0006ME-T6; Sun, 08 Nov 2026 20:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDvh-0006Kp-Qo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDvf-0000W8-Vn
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794186731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZLhdv/Ka/BqV9RZ4JlnjTuhP4pL7O0JUwYD2/NZ1eA=;
 b=KF04rEN2i/Smb0a/t79Tt1ZbpR+dyKqXvxD/WrWCVll6iBda6nU3aCQqeCAxGmtrCHmMtN
 uV/Dnaa47vr8ukERAyrEh8aXdd0J6ABid3VM94w4i9RJwwI/nc0jwplfUObESwv71nlVcq
 PqZsqjcohhsP2fXC/yBZTMq3MCJT8NA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-l88cpipLMleG3mcAvUbwGQ-1; Sun, 08 Nov 2026 20:12:09 -0500
X-MC-Unique: l88cpipLMleG3mcAvUbwGQ-1
X-Mimecast-MFC-AGG-ID: l88cpipLMleG3mcAvUbwGQ_1794186729
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1fa972b4fso1424655e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 17:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794186728; x=1794791528; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ZLhdv/Ka/BqV9RZ4JlnjTuhP4pL7O0JUwYD2/NZ1eA=;
 b=ti483s+VlI0yne3llWsURg6uS5jOtNWwX50HZHVaq/AB9CzIa73R9XRyRvUoSj2dJC
 1wN7YRfbmbXZyXiOru15IcT0oB2At6M52lp9tFU+ZK/b5PsTR7aQuDKgRZtxISGA41/x
 R7MgPeOtZFD9HySL6XCeaIIYpPWqLpg25vv2y5VpaaJwS7H8enJBwvM7q1obyG+EEf13
 e5tOi2tNuFIc4ZgiQmXAr7kg+HhCtNQvl1oaYfUSaFoc9QgH94xwF5l5F2TfHBfQrd7Y
 6HRIJvZVO6PpnNpHlEKUu3N8UN2aH8ORYoLnkFR7McFEuNbPxJmiGrinCfAdygIcJp9J
 /Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794186728; x=1794791528;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ZLhdv/Ka/BqV9RZ4JlnjTuhP4pL7O0JUwYD2/NZ1eA=;
 b=v3Hqr8qFwq1Q2/ayks/5MdO8Mlm1jhr3dcLArNNF9ZE2RZI/lmONkbP/pFQP2Xj9gG
 2x0THkwMXxQEEmakIvNtcQcxJvoANq4njmbix7evg7soivJwoJPzgMP/kEhkhlg0mmBD
 tV9NJG7CvLXWy+gcM8yNJ7iMH3mJzFo/RHBR+8IBcLXRYFd//c6B6uop2Fz8cIUc3qJV
 cfkhhumM6IZ0vUnZLa6Yk8/GUKxG+v3JdHlN5y6Oh7KjNpHVR+hztyjocty3gAn4u2xE
 w+f8Qb1vsQOiC0zGJsMvn6PMWoin6kWFOUFIwdGNdmssTpziseqbAc2NmTiX0/DYwjD1
 XjCQ==
X-Gm-Message-State: APuU4Z+QjxGZRt8/nYiI63yg1a5XflkVQT4So0qajuko7GzP9F6gkFk4
 tWjcSJMvrGTRrX8x+RV1lzhfUfKoGoYqIC8G3idsCxcZoAwH6azZ1bwTAkjmeP9qMY58okAzjgh
 0q2JZUv+iOClEFnb1h2QCnHZvXpYCN82n82U4RogS+enryA92v7j/nP6X
X-Gm-Gg: AYBFou3rr1TH7vaHWbh0mMrJM58DvbSQ4/1srkqNPxOBBg3obJqr+5rsuS7OpIbVAD8
 gabcS82ckMc7aYcsX8u3s3yBXEh0f2NsrFdjqdIuodzYBBKRQtIRqWI7+j9xsiWYNgKlGBeWwXu
 dprkQBCkIO/WVglPdSu0c3oHmCDmDo+wjMzG/ifXovL7XsrdW7+2avD8/S/T33oHeQjLebW3+dT
 q54MPRga0YK1wzYfFbba4OGQtRO5H9yQJfSyDSLuAsnfcoWv20g3GexbG0SkQ+ENUF/aEyN9UeC
 6bkvBlOJfvEn5H2iWmOKqad7S8jCKiUvlfTmwJFS/Z3bZ2dQynvrlmBx4OU8YlCdvxKe4Gs53Og
 THGGdQP8VXnIeqxQGcjlMw4umhdLclRTw
X-Received: by 2002:a05:600c:190f:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4b94d76c162mr50725305e9.4.1794186728581; 
 Sun, 08 Nov 2026 17:12:08 -0800 (PST)
X-Received: by 2002:a05:600c:190f:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4b94d76c162mr50725155e9.4.1794186728237; 
 Sun, 08 Nov 2026 17:12:08 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4967a70a35dsm3629536f8f.9.2026.11.08.17.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:12:07 -0800 (PST)
Date: Mon, 9 Nov 2026 02:12:04 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 3/4] hw/pci: add DVSEC RMEDA capability to PCIe root port
Message-ID: <yljxtniyftlrvrbtlzbunmeiako3bvgeu5k37rmp26ptym3pyo@4iq4armziigf>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-3-212d2409563e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-3-212d2409563e@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jim,

On Thu, Oct 29, 2026 at 03:05:12PM +0000, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Again, gated by the rme-cap=on flag for pcie-root-port.

Please, give some love to the commit messages :)

Yeah, now this cap only makes sense on Arm and on CPUs with FEAT_RME.

So I think it should actually be gated on a different flag, e.g.: "x-rme-da",
this would allow more control considering other platforms.

And then that's ok to keep this code in the generic root port code. Other archs
will gate on different flags.

I think we could then set "x-rme-da" globally at machine level, e.g., virt.c and
sbsa-ref.c, based on CPU's "x-rme" property, so we don't need pass "x-rme-da" to
every root port. Actually we could do that for "x-tee-io" (Patch 2/2) too,
although I think it would be premature to that now for both "x-tee-io"
and "x-rme-da".


> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie_regs.h         |  4 ++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index ab8087da87..fb8dbb7959 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -28,6 +28,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
>          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
>  #define GEN_PCIE_ROOT_PORT_ACS_END \
>          (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
> +
>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
>  
> @@ -67,6 +68,39 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
>      msix_uninit_exclusive_bar(d);
>  }
>  
> +static uint32_t add_rme_dvsec_capability(PCIDevice *device, uint32_t offset)
> +{
> +    /*
> +     * dvsec rme-da
> +     * https://developer.arm.com/documentation/den0129/latest/
> +     * Arm RME System Architecture
> +     * 0x0000 RMEDA_ECH See B3.2.6.2.1 RME-DA Extended Capability Header
> +     * 0x0004 RMEDA_HEAD1 See B3.2.6.2.2 RME-DA DVSEC Header 1
> +     * 0x0008 RMEDA_HEAD2 See B3.2.6.2.3 RME-DA DVSEC Header 2
> +     * 0x000C RMEDA_CTL1 See B3.2.6.2.4 RME-DA Control register 1
> +     * 0x0010 RMEDA_CTL2 See B3.2.6.2.5 RME-DA Control register 2
> +     */
> +    const uint32_t ARM_PCI_VID = 0x13b5;
> +    const uint32_t RME_DA_DVSEC_ID = 0;
> +    pcie_add_dvsec_capability(device, PCI_EXT_CAP_ID_DVSEC, 1, offset,
> +                              PCI_RME_DVSEC_SIZE, ARM_PCI_VID,
> +                              PCI_RME_DVSEC_VER, RME_DA_DVSEC_ID);
> +    const uint32_t ctl1 = 0x1; /* support tdisp */
> +    const uint32_t ctl2 = 0x0; /* unlocked */
> +    pci_set_long(device->config + offset + 0xC, ctl1);
> +    pci_set_long(device->config + offset + 0x10, ctl2);
> +    device->wmask[offset + 0xC] = 0xff;
> +    device->wmask[offset + 0xC + 1] = 0xff;
> +    device->wmask[offset + 0xC + 2] = 0xff;
> +    device->wmask[offset + 0xC + 3] = 0xff;
> +    device->wmask[offset + 0x10] = 0xff;
> +    device->wmask[offset + 0x10 + 1] = 0xff;
> +    device->wmask[offset + 0x10 + 2] = 0xff;
> +    device->wmask[offset + 0x10 + 3] = 0xff;
> +    offset += PCI_RME_DVSEC_SIZE;
> +    return offset;
> +}
> +
>  static void gen_rp_realize(DeviceState *dev, Error **errp)
>  {
>      PCIDevice *d = PCI_DEVICE(dev);
> @@ -106,6 +140,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (grp->rme_caps) {

So it would be something like:

if (tee_io) {
    ...
  
    if (rme_da) {
        add_rme_dvsec_capability(...);
    }
}


Cheers,
Gustavo

> +        next_cap_offset = add_rme_dvsec_capability(d, next_cap_offset);
>          pcie_ide_init(d, next_cap_offset);
>  
>          /* Unused value, but may be useful for the next capability */
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index aa21177411..da812d32ff 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -186,4 +186,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_IDE_VER                     0x1
>  #define PCI_IDE_SIZEOF                  12
>  
> +/* RME DVSEC */
> +#define PCI_RME_DVSEC_VER               0x1
> +#define PCI_RME_DVSEC_SIZE              20
> +
>  #endif /* QEMU_PCIE_REGS_H */
> 
> -- 
> 2.43.0
> 
> 


