Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F89CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVcdH-00015c-K2; Fri, 05 Jun 2026 18:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVcdF-00015F-8W
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:03:13 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVcdD-0000zK-Me
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:03:13 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id C997DEC0120;
 Fri,  5 Jun 2026 18:03:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 18:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780696990;
 x=1780783390; bh=FfukQV7JB5d+b6xSovxgWWLbNst5wtuG0d8rn4Mp9RU=; b=
 lY7zKWiZ0vv6RuUCJ7w+dUGnBIMbLyy1fH/FR5Ib8p0fxv98uIUVx3/041h6nzbn
 nInq4brRqGTYhs7LfG5aqonMhpb/fBxnVgFugViq24GiMP0h/eHA2Ne6jsLuwDay
 Nz00b8WWO0eNGgL675WGo2XeVREW7HHW3b2viRUGvXmTLbajnyRQMPTJAG9HpUbZ
 +AIbGpAFIc30JUHyNv+RjA7QVDER6wZesxkimC9FgBnW136CJ5JfyvwT52ZCK43S
 q841bTxkrv94usi+C83D9JaIkE6a0zHH2yH5zSIJxZkgmBWmybvFNyTLfN3bqCnI
 UW4qVCOb7H778YUJsT0Y6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780696990; x=
 1780783390; bh=FfukQV7JB5d+b6xSovxgWWLbNst5wtuG0d8rn4Mp9RU=; b=V
 JVxbXLUMEYAMxtt4sFx/Pdf0RiskndJVYLrscizCEkv9fMSATU1WmU+9hzKUjfU0
 4K9JVA5ggNEMRnBs1DfOiZgCKYwOoxk/jocCQA6Luivyf4IqwPQlQIQmb27O7F3S
 FF9HshbjYrtjGdrNcnfezAdeNCMY83YSvlbSDeXnS+T5pvf6IIc2ThjWVUOp0cl9
 puKsCKiC0ifAVMsAzuHVG5bhnz0iu1h7LjPpPbgJVw4IKfeX8sElh8i5Yi1MmkQJ
 N2Jfs5AJSU5bGkDo/5IDDGofs+jBLGRV+D/RUrFpxWEIQFO1zFmSJ8sozmo19Mcz
 Z30eO769/n4pj2ZZk3IJA==
X-ME-Sender: <xms:nkcjajX3oOdXOm-E40W8giByimRuQ0uFxswbky3FsRQbNxIcaDUk9w>
 <xme:nkcjakg5exyvelI-roRMK_dMuLf-j6kiKPqOcbrJfyV9hnXMCZLPmjbt72DRhWOkz
 2AgxDREBMS0B-efO4mX-1eyDmdfHVQYV-pagsvJvIyx_pB5ogHHPA>
X-ME-Received: <xmr:nkcjaq9bh2qSJhcefP__8N1Y061S2FFSwggkz80Iv_HeORIpK8vzOKERIZA>
X-ME-Proxy-Cause: dmFkZTFW0/HJg84SCHeNWA+1evtL1PhrZVIVRZTGAahxDG44rtp+xna683lf2rr+HHhFct
 syN4BxA5h4qmlSK6Q/oZ4UDNrK3oKLxN6mddwTuiGg/kkdspU7b9Fwle1S/UHOY+i2ummn
 1E6a/sw4sW2oOfVLzLyXTlFnHiodofTFoNKzRI99JFdw03GPzNaRnSviTKnFW0L6FLq69y
 kVdD/8IOAFDGLIeuctWdeVIVm8vK572mRrVXPGNrinbqNggysXZVDWuFzAqW1xDzJQ6Ksz
 9+Hj67Wo2MUZB+csQwUxkiW6Lm5V2ZkoQIJ0gP+6rs2dHxNhYc+IdlJy7x4yAkemAcddDM
 deO2qTJiIcF1NV3fi5nzCMfmUSdpAxAUpxPaetUiizlPTkYT3mXqkyZUMekTtBovmUczyS
 kAf898XubPIRZtit2SsizUpiZB/As7Lu9i/Tu/CeoZEds7c5ilqPb+rw01a0FFA1wGLqgB
 Rcsos7G+vhWlEjp8OnAk7BkX8p+/+hvzn9CrNR1djezmeNKq+03030j6XH18xFlGrQcI+H
 wUY7XqOkyPwrz9I0GRBoM9rjt/WIhvGv+dv7VyTM7SEul7k7zMF1WfGRWPTgUD6T7pfXL4
 tAHbvV4FBQz0e7xU+z9Y8kj0hdadSVOnv9YJNF98luQIQluI135ChfmrSuzg
X-ME-Proxy: <xmx:nkcjauaExjZ57rppt8uKo7cTqt18AoNNsRXJwXcEEPUBWPTGW5a2Jg>
 <xmx:nkcjap2UuO4jPHs1oSYs3So1t_q8ELd_qn3APoVXq8OWNmaxfrfRjA>
 <xmx:nkcjapbExYRmrxOVMd3TTX6YPQpWjUUl4eu1JOgb5iLB0guIaVUDuQ>
 <xmx:nkcjahJHkes6DGTqq8gAG7nkZ8QpMklQ4euHzuxw__Ut-EXOxOSBPw>
 <xmx:nkcjai2Tc2imo37VRneWj5gRZKPsPyMCRr278TwGeZ8Z0363R2c5eT1v>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 18:03:09 -0400 (EDT)
Date: Fri, 5 Jun 2026 16:03:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 2/6] hw/pci: Introduce rom_need_patch_id flag in PCIDevice
Message-ID: <20260605160309.1d14edb8@shazbot.org>
In-Reply-To: <20260603173355.36121-3-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-3-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=alex@shazbot.org;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu,  4 Jun 2026 01:33:50 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 5cac6e1688..daa679b3f5 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -159,6 +159,7 @@ struct PCIDevice {
>      bool has_rom;
>      MemoryRegion rom;
>      int32_t rom_bar;
> +    bool rom_need_patch_id;
>  
>      /* INTx routing notifier */
>      PCIINTxRoutingNotifier intx_routing_notifier;

Micro nit, maybe groups better with has_rom.  It's filling an existing
hole either way, but might help some future cleanup.  Thanks,

Alex

