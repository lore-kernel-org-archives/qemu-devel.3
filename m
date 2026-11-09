Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD4606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MDsiSU21;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J2OLKugJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDv8-0005xB-GB; Sun, 08 Nov 2026 20:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDus-0005tD-RG
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDur-0000RW-0C
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794186679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezXgDapyYUap2Wgydxx6BPSv80jPvc21eH6t5g1Br50=;
 b=MDsiSU21XrMvWFDRsc+SaGk0OB/bhC8O1D3hozJXg7LF97fGxH6F+ml0fkA4Vfe7qxILAH
 FlwoBVgBDMMwhIxps4/wUtl/6f46RMNYtQuKc0cluEn3tNahUmBAOTJBnQv4fHVj3qOzkM
 N2DKIsOqLjR95Pn1BiTRRgVm6wshyNs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-2aj0ZpPeNgyJTw7a13p3xA-1; Sun, 08 Nov 2026 20:11:17 -0500
X-MC-Unique: 2aj0ZpPeNgyJTw7a13p3xA-1
X-Mimecast-MFC-AGG-ID: 2aj0ZpPeNgyJTw7a13p3xA_1794186677
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a80bd45e1cso1714315e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 17:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794186676; x=1794791476; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ezXgDapyYUap2Wgydxx6BPSv80jPvc21eH6t5g1Br50=;
 b=J2OLKugJsu4mwD8evlMBdLysZbrGEDFkUJgiDuqpWSoQee/ihiCHRxEZqDRkwZRutW
 Q1+aJONEcPhpP5NYxmAx8SoptuSt0ciZkfrtNdNkouatI9TeiTpmki9MF+6PCMH1jpT1
 Xbcutf2nYEEK6ZcPy+sKDoDvSVFv51EOTwOjfQ0Vk+MPkt95Uds43qLvNiuX8bTSPOez
 3Cl1sPLJhmyA/DbX6oH23EVvahaPpCVSDkgBIg9+uVuobG2YreVpA5/GoCMVEJCbbmvQ
 k8D8RzcQl0oRaCdB1XFqPKp3Hj+Duj0fTBYIWA3hGihsRTRP5+xWQ9eKD1sXfcoQLcvp
 pAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794186676; x=1794791476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ezXgDapyYUap2Wgydxx6BPSv80jPvc21eH6t5g1Br50=;
 b=qPRje1y/lRrk8Rjy35aNDccKfs545Xl8bMJyiv5CQfWQaESuzTga4KDTXV84CKv2vH
 OvnQZ8jqwHPOkbOoxqInNFvie4O/Pj9djlxXZmzZ6GPalUfh/G0BiRVIeIaxTEOUvmmf
 /zof0+JIvCKLUjUvnMAClpLAP+UVy6eRT/6iPQxid+hOxiHOh2FDFzt1ljukyPV6cvTs
 2YuyFsNpSpZPO9jw9MUB/h/fZ9t+k8t9L/ESM6+mattDB7hFIAkwu/5gXoGTj37nq69r
 zoeGuFoXEh1Mugg93h+eAUuVcMRr30PSggIneNmyT/AcMbN+6t0++RgdquQJ040YkuUV
 +skw==
X-Gm-Message-State: APuU4Z+RJcmX9VK0T6wZty8sMUFXlvPlwnQ9eUXYUzwD4XTekoUHuwV9
 GnGbjakwoCxP1yQeXDskV7MHY0+vVW4BPNr84IU86SN58Ho2Be8fbYsrXSlpiwVq/Rt/x1uw9o4
 B0aaoT75gCFWc+FfWHcsAxXPQhEELHNFcwYn1EJfUvzsHxrpQt3r8APRM
X-Gm-Gg: AYBFou15MKTvkmQqLScA8p/7xYuz66MtRnCSsvHKeGXyUqlPfaklum1HDe+0vQezPuJ
 i+0YwzV71Sl7OlYkxmEq39MfvVm41cjSRC7TvKQbUrvVliVIjqrDbBQatXgAqdJsBmV2B7Ahiwe
 R3EJqWFlRa75Z5TsxR8LX2ZIQiELgzraWQNqEcJAHZT+VRGfQowFvEM+wQ5OFCs45t3OoPqMqps
 RHEGddx/bJui6XYoBqbuiIfICCXVWv3ElZ7qzOISoU8xljXemcy/thPzkGgkuJ0Ycp4lXhcoygD
 h3ITeXkit79KnGb396/uuHWkvBuhPijh9ZXvWRmGiti/+lK1eW+BDtnHdgxpsFcXMfijJbcZWE/
 MgXzmX0/8nbMb1DxBtxLZRymnlJEJMHj3
X-Received: by 2002:a05:600c:190e:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4b960e9a361mr50822025e9.13.1794186676583; 
 Sun, 08 Nov 2026 17:11:16 -0800 (PST)
X-Received: by 2002:a05:600c:190e:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4b960e9a361mr50821845e9.13.1794186676162; 
 Sun, 08 Nov 2026 17:11:16 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbfa121sm115168515e9.1.2026.11.08.17.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:11:15 -0800 (PST)
Date: Mon, 9 Nov 2026 02:11:12 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <JimMacArthur@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] hw/pci: add IDE + TEE capability to PCIe root port
Message-ID: <ug6flavvztnklx3rewy67thrgjuny6woya6sthpipxowdk3lwz@ez3m2htpyrn3>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
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

On Thu, Oct 29, 2026 at 03:05:11PM +0000, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Adds the TEE flag in the legacy config space, and the IDE
> (Integrity & Data Encryption) extended capability. These
> will be present when rme-cap=on is specified for the
> pcie-root-port device.

This commit message needs some enhancement.

First, it ideally should mention the reason/effect for setting the TEE-IO and
advertising the IDE cap, explaining why it's required. For instance, say
that they go together because both are pieces of PCIe TEE-IO, the framework for
assigning a device directly to a confidential VM, and that, accordingly to the
spec, the TEE-IO presence requires IDE, as per §11.3.29.3 Securing Interconnects
(I'm looking at spec rev. 7), which reads:

"TEE-I/O capable devices must support Integrity and Data Encryption (IDE) to
protect transactions on the interconnect between the device and the Root
Complex. Devices must support selective IDE streams between the Root Complex and
the device."

Second, I think legacy word should be dropped here and in all other parts of the
patch below because I consider it misleading. The first 256 bytes are still
present in the PCIe spec rev. 7. I'm aware the spec mentions this area as
"available on legacy OSs" so accessible from the CAM mechanism, but from a PCIe
device pov it's simply a the PCI Configuration Space. Moreover, the TEE-IO bit
is in that space and TEE-IO is a quite recent addition to the PCIe spec, hence
it's odd to say a bit related to a new feature like this is being set in a
legacy configuration space.

Also, rme-cap=on is not good, as Jonathan said, because we're in the PCIe
context, so it's not restrict to the Arm arch. I think "tee-io=[on/off]" would
fit better, or even "x-tee-io" if we are experimenting with it and not so sure
how the flag would be called at the end.

ah, and although here it says "rme-cap=on" the prop. being added below is
actually "rme-caps".


> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <Jim MacArthur@linaro.org>

nit: email seems ruined here ------^


> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 21 ++++++++++++++++++++-
>  hw/pci/pcie.c                      | 19 +++++++++++++++++++
>  include/hw/pci/pcie.h              |  3 +++
>  include/hw/pci/pcie_regs.h         |  4 ++++
>  4 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 5434d693d9..ab8087da87 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -26,13 +26,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
>  #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
>          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> -
> +#define GEN_PCIE_ROOT_PORT_ACS_END \
> +        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
>  
>  struct GenPCIERootPort {
>      /*< private >*/
>      PCIESlot parent_obj;
> +    bool     rme_caps;
> +
>      /*< public >*/
>  
>      /* additional resources to reserve */
> @@ -71,6 +74,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>      GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
>      PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
>      Error *local_err = NULL;
> +    uint32_t next_cap_offset = GEN_PCIE_ROOT_PORT_ACS_END;
>  
>      rpc->parent_realize(dev, &local_err);
>      if (local_err) {
> @@ -100,6 +104,19 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>          d->wmask[PCI_IO_BASE] = 0;
>          d->wmask[PCI_IO_LIMIT] = 0;
>      }
> +
> +    if (grp->rme_caps) {

See my comment on using rme, which is Arm-specific.


> +        pcie_ide_init(d, next_cap_offset);
> +
> +        /* Unused value, but may be useful for the next capability */
> +        next_cap_offset += PCI_IDE_SIZEOF;
> +
> +        /*
> +         * Set up TEE (in the legacy config space, not an extended
> +         * capability)
> +         */
> +        pcie_cap_tee_init(d);
> +    }
>  }
>  
>  static const VMStateDescription vmstate_rp_dev = {
> @@ -133,6 +150,8 @@ static const Property gen_rp_props[] = {
>                                  speed, PCIE_LINK_SPEED_16),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
> +    DEFINE_PROP_BOOL("rme-caps", GenPCIERootPort,
> +                     rme_caps, false),
>  };
>  
>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 42c4997b42..bf2c184cfc 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -968,6 +968,16 @@ void pcie_cap_flr_write_config(PCIDevice *dev,
>      }
>  }
>  
> +/*
> + * Set PCI_EXP_DEVCAP_TEE flag in the PCI Express Capability Structure
> + * (in legacy config space) indicating that we support TEE-IO.
> + */
> +void pcie_cap_tee_init(PCIDevice *dev)
> +{
> +    pci_long_test_and_set_mask(dev->config + dev->exp.exp_cap + PCI_EXP_DEVCAP,
> +                               PCI_EXP_DEVCAP_TEE);
> +}
> +
>  /* Alternative Routing-ID Interpretation (ARI)
>   * forwarding support for root and downstream ports
>   */
> @@ -1387,6 +1397,15 @@ uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
>      return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_REQ);
>  }
>  
> +/* IDE (Integrity & Data Encryption) */
> +void pcie_ide_init(PCIDevice *dev, uint16_t offset)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_IDE, PCI_IDE_VER,
> +                        offset, PCI_IDE_SIZEOF);
> +    uint32_t cap = PCI_IDE_CAP_SELECTIVE;
> +    pci_set_byte(dev->config + offset + PCI_IDE_CAP, cap);

I would set PCI_IDE_CAP_SELECTIVE directly and avoid 'cap' var here.


Cheers,
Gustavo

> +}
> +
>  bool pcie_pri_enabled(const PCIDevice *dev)
>  {
>      if (!pci_is_express(dev) || !dev->exp.pri_cap) {
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 86c29f7d8b..6c02c846df 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -123,6 +123,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
>  void pcie_cap_flr_write_config(PCIDevice *dev,
>                             uint32_t addr, uint32_t val, int len);
>  
> +void pcie_cap_tee_init(PCIDevice *dev);
> +
>  /* ARI forwarding capability and control */
>  void pcie_cap_arifwd_init(PCIDevice *dev);
>  void pcie_cap_arifwd_reset(PCIDevice *dev);
> @@ -165,6 +167,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
>                       bool exec_perm, bool priv_mod);
>  void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
>                     bool prg_response_pasid_req);
> +void pcie_ide_init(PCIDevice *dev, uint16_t offset);
>  
>  uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
>  bool pcie_pri_enabled(const PCIDevice *dev);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 33a22229fe..aa21177411 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -182,4 +182,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_DOE_VER                     0x1
>  #define PCI_DOE_SIZEOF                  24
>  
> +/* IDE */
> +#define PCI_IDE_VER                     0x1
> +#define PCI_IDE_SIZEOF                  12
> +
>  #endif /* QEMU_PCIE_REGS_H */
> 
> -- 
> 2.43.0
> 
> 


