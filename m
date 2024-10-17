Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B239D3C525
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TpH-0007zw-Vz; Thu, 17 Oct 2024 12:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t1TpG-0007tY-1g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t1TpE-0004fE-8M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729184290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PowUg5d8/eugLMiUQS4cx99igD1voimkmtiC3oRRRE4=;
 b=PM8VqZGk0KHh5U2kB7KcWj7Dn40Sj2pR55jqCCmJnSg5t9ZM0Q1iDc5uFJbxXmaBJOSiEC
 VSgA+BNOOtMfwXENgXToDPx6ukLmTdfWOFXp5vfcs3ElL8OmrWR4lRUMWj5JG5lSjWdT/H
 YJuy7GH+xK3MbIslzeAm/hH5RYaInD0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-IGmep51YMm6jSrRRWHgVSQ-1; Thu, 17 Oct 2024 12:58:09 -0400
X-MC-Unique: IGmep51YMm6jSrRRWHgVSQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539f5f33333so1079300e87.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729184288; x=1729789088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PowUg5d8/eugLMiUQS4cx99igD1voimkmtiC3oRRRE4=;
 b=MjcgV0qKb7NRYUASmEUr9RRmfIrOMDMqBugNf32D7ZSarve6PQ76DDe9gWKRGSH25/
 j+cVGZofZA91JQakExU3pOuRgq399MHB0N098cvSpAuSw5aqUFFWBeWHrmeJ7UHgFbLD
 NQ8QCIigjtqh9Za8oufJLXrB+SELOBGnnKt9aOVlQBSxB0D7xd4wT999INTSp1kgrYTu
 E4v0opOPQE4P2h+s+D+sNw2BKdaFgc5fedSnVc4yxpi3zdZsiZ36Kx80CikRikI5lDMm
 20eE8aIuj3cF27kWinoyTcuwWYLZTAOKTyLAGLtM47FyYnbRHbn3NgjaTYAzv2tayZ02
 fKNw==
X-Gm-Message-State: AOJu0YyRRRdzFLOLmuDnp6j46SPdveqvePGCfuoay5ZT5wEPCNOo5ts0
 PVkCpSyWjts0O5VBifRkJDIS92joGXJ+2mn8uECKhDA9+MkIMnQyeJ8wSPvonfOmQodC/4aVG2y
 ehJs0n4mYcGi3L2my5oa6NZgX1B50Q8pfuudXrOQUsop9jxKi6Zcx
X-Received: by 2002:a05:6512:33ca:b0:539:964c:16d9 with SMTP id
 2adb3069b0e04-539e575e159mr10629854e87.57.1729184287726; 
 Thu, 17 Oct 2024 09:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0yPkNSLO0ernqHRtKr8kwcpLa/9zolOkDn9sxsFLTfZyejpqgTa0YwDAtoj3sAJQL7ZexWg==
X-Received: by 2002:a05:6512:33ca:b0:539:964c:16d9 with SMTP id
 2adb3069b0e04-539e575e159mr10629843e87.57.1729184287230; 
 Thu, 17 Oct 2024 09:58:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:9236:6b55:db09:362e:9a87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316062d7f3sm1016655e9.0.2024.10.17.09.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:58:06 -0700 (PDT)
Date: Thu, 17 Oct 2024 12:58:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pcie: enable Extended tag field capability
Message-ID: <20241017125724-mutt-send-email-mst@kernel.org>
References: <20241017-pcie-extend-v1-1-03eb1029f4ca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-pcie-extend-v1-1-03eb1029f4ca@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 17, 2024 at 03:33:44PM +0200, Marcin Juszkiewicz wrote:
> PCI has 32 transactions, PCI Express devices can handle 256.
> 
> SBSA ACS checks for this capability to be enabled on Arm server systems.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
> SBSA Reference Platform work goes on so I am looking at PCIe related tests.
> 
> SBSA ACS has test 824 which checks for PCIe device capabilities. BSA
> specification [1] (SBSA is on top of BSA) in section F.3.2 lists
> expected values for Device Capabilities Register:
> 
> Device Capabilities Register     Requirement
> Role based error reporting       RCEC and RCiEP: Hardwired to 1
> Endpoint L0s acceptable latency  RCEC and RCiEP: Hardwired to 0
> L1 acceptable latency            RCEC and RCiEP: Hardwired to 0
> Captured slot power limit scale  RCEC and RCiEP: Hardwired to 0
> Captured slot power limit value  RCEC and RCiEP: Hardwired to 0
> Max payload size                 value must be compliant with PCIe spec
> Phantom functions                RCEC and RCiEP: Recommendation is to
>                                  hardwire this bit to 0.
> Extended tag field               Hardwired to 1
> 
> 1. https://developer.arm.com/documentation/den0094/c/
> 
> QEMU leaves 'Extended tag field' with 0 as value:
> 
> Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, IntMsgNum 0
>         DevCap: MaxPayload 128 bytes, PhantFunc 0
>                 ExtTag- RBE+ FLReset- TEE-IO-
> 
> >From what I read PCI has 32 transactions, PCI Express devices can handle
> 256 with Extended tag enabled (spec mentions also larger values but I
> lack PCIe knowledge).
> ---
>  hw/pci/pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6..54c0f1ec67 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -86,7 +86,8 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>       * Specification, Revision 1.1., or subsequent PCI Express Base
>       * Specification revisions.
>       */
> -    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
> +    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER |
> +                 PCI_EXP_DEVCAP_EXT_TAG);
>  
>      pci_set_long(exp_cap + PCI_EXP_LNKCAP,
>                   (port << PCI_EXP_LNKCAP_PN_SHIFT) |


We can't change capabilities unconditionally.
It needs at least a machine type compat thing.

> ---
> base-commit: f774a677507966222624a9b2859f06ede7608100
> change-id: 20241017-pcie-extend-a6a9de74dbd0
> 
> Best regards,
> -- 
> Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


