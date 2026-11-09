Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF813606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhuXsmvz;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ea8kOODa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDxC-0006zK-P7; Sun, 08 Nov 2026 20:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDww-0006x7-Ub
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDwv-0000ZO-Dq
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794186808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f+KK/42JLWtq/9CQwsAodIIXxtxMa0fPESf5y5RYcGE=;
 b=bhuXsmvzJuI7ezxGW7V1QKzEeIROgGIvawtXFbqnpXjkHAXqs+p/ZRl7IU6mmLrhkcpky1
 sh+w6t6sNrJu3nqtMHX8+bHGBAX0j4XO3opTDKNLt4kqh9vmbk5kP6GZfhpLO/1P5SiRNt
 iLCKy7JnlVVk/jaG6T9ezWbpxmvPOmU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-KcqPRujPOuS-Yfs703RRpA-1; Sun, 08 Nov 2026 20:13:25 -0500
X-MC-Unique: KcqPRujPOuS-Yfs703RRpA-1
X-Mimecast-MFC-AGG-ID: KcqPRujPOuS-Yfs703RRpA_1794186804
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so236715f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794186804; x=1794791604; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+KK/42JLWtq/9CQwsAodIIXxtxMa0fPESf5y5RYcGE=;
 b=ea8kOODaop4+1J3x7pt6+YUm1hczqzzZwPXGeASXyyO64FolO3VtJ6OW10U1Y1LVwd
 q37gVBhuytwQcwMZ0wFxE6rNnXjeZf918ifkbPyq2jrIkJBQsrRxBybYLbFv30u0V6tX
 nd8kNhj8TAHzn0/DRRW2TqXsLJ8wjBsSGAWpBslUC0dUeTWplW56XIPtN8JJ97sRvLBi
 qRc+KH4/kJuQrm/pMm7Yo0+hRoBVNwIzNiFFex5e7sGQPsAJ3mKmq0OTtcDhw06QBLQh
 Bd+nPsJeWh2j/I9x2uTf2JwdFpOJK269K+qc3vuGdtKSoTdP5n34afwFvNN0UJy/7H39
 IagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794186804; x=1794791604;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+KK/42JLWtq/9CQwsAodIIXxtxMa0fPESf5y5RYcGE=;
 b=utQhhwrqUeyafL7WQaOOtOvfbiBv/NK+/twKIWCG2WQvbsHILbaPEYKACSHsRKGLBG
 bnBmdVUULSn9OKAdy4UxxhAndBVFEzZM1+owjmz1ah6pGysIzvq0ORex7S6OHTGqpLI0
 fky6xjKEsLLY+Vi7wPwtxXwrpd90QB/HcEruX1FxuZJcek0I63hLRKix/z03O0NTs21E
 5nOntA9IjLWajkdVAB5JwzDgbg5OsS0AGGc4nfVn9jpnNsQ0XNj2d+jGESX3eu8GPmKb
 5TRMTQ2LLYBmmX7qkzjLpeugSyWXeMSUxGCpfII0K0B0yCrVvin5+zOPjHjPfwsgbtTQ
 xs+Q==
X-Gm-Message-State: APuU4Z8pProS2mlBYVLlBAtKs58goNI8s2mD+LeaDxGkGLsydq9K51GG
 fxLnU/lvvoiOWvq8LkhN8iTG29wP4iLSvB2OQDK80BcPJlQR/v1+tPbr6zA2vb4oqXmSgmf3POC
 nv1f1FvvhQjVhyGoRLL9YKTQc2ajY1hJ5hnWnA3L3EnF/GWv+Mb5hp7vx
X-Gm-Gg: AYBFou0oo2+hI3o/pRFV56jUZLr+rQ8MGF3ltd8jqw92UCOcEz4/MqQhni4CPhPacLI
 SbuHE2YazfZqidAhVNqCPaUfs1D/DCU6NUwHVWdUSzJF+Fj4857CYb/FqwpAN0MoOdICynOnBFH
 a+Q4dPPDDzHjyP5iXDFJo0uN52MV4lMZjogHgW6TgfnN2oyuxSl+iiFlhriGjMZkdOcSkDFZBWE
 MSG9eXM5sUkzXP+rgxB8HAml4Mlx04ueTvkxch9NyHvxMIxB1nv2CngY2hH0t0hWjmeD7AjSjxx
 qmDB0pAWHtvOQT5SOZTm/UcNZY2Xazm5veeG9brESncKkMRs6zA8StncvrZbHdwbYdHFDkwWmpd
 aL4jyAF5Mwx2PlHSrJMdwRov2faVGosFV
X-Received: by 2002:a05:6000:2511:b0:48e:6092:dea1 with SMTP id
 ffacd0b85a97d-4958bfc8c56mr5012279f8f.47.1794186803952; 
 Sun, 08 Nov 2026 17:13:23 -0800 (PST)
X-Received: by 2002:a05:6000:2511:b0:48e:6092:dea1 with SMTP id
 ffacd0b85a97d-4958bfc8c56mr5012264f8f.47.1794186803653; 
 Sun, 08 Nov 2026 17:13:23 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959755d423sm6751264f8f.40.2026.11.08.17.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:13:22 -0800 (PST)
Date: Mon, 9 Nov 2026 02:13:19 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <JimMacArthur@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 0/4] RME-DA capabilities for PCIe Root Port
Message-ID: <fx5bt57myqqw7kfh5wmvlvflf7jriakpmt3pkm7k4xtbhnh4yq@didjqnojfkda>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 29, 2026 at 03:05:09PM +0000, Jim MacArthur wrote:
> This adds optional capabilities for the PCIe Root Port device: the TEE
> flag in legacy config space and two extended capabilties:
> - IDE (Integrity & Data Encryption)
> - The RME-DA DVSEC capability.
> 
> All changes are enabled by the rme-cap=on flag for the pcie-root-port
> device.
> 
> This is a rearrangement of original work done by Pierrick Bouvier
> <pierrick.bouvier@linaro.org>.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
> Jim MacArthur (2):
>       hw/pci-bridge: Add pcie_add_dvsec_capability helper
>       hw/pci: More comments in pcie.c
> 
> Pierrick Bouvier (2):
>       hw/pci: add IDE + TEE capability to PCIe root port
>       hw/pci: add DVSEC RMEDA capability to PCIe root port

I think the series would read better by adding the TEE bit + IDE, then
the dvsec helper and finally the RMEDA capability.


Cheers,
Gustavo

>  hw/pci-bridge/gen_pcie_root_port.c | 54 ++++++++++++++++++++++++++++++++++++++
>  hw/pci/pcie.c                      | 49 ++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h              |  7 +++++
>  include/hw/pci/pcie_regs.h         |  8 ++++++
>  4 files changed, 118 insertions(+)
> ---
> base-commit: 5624b266cdd513506fb333e9041778407b6d1ac4
> change-id: 20261022-jmac-pcie-rme-extensions-ecbc501d4d7f
> 
> Best regards,
> --  
> Jim MacArthur <jim.macarthur@linaro.org>
> 
> 


