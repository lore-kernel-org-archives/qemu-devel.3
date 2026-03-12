Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D285106ACC1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iXM-0004n8-Ta; Thu, 12 Mar 2026 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1w0iWw-0004eG-TR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:04:59 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1w0iWu-0005Je-Rc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:04:58 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 21EA9EC0B6C;
 Thu, 12 Mar 2026 12:04:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 12:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1773331494;
 x=1773417894; bh=H+jruQmOxoyo/RNkEyK/wpeJdj+x/03Gqq1ur9Z8SEw=; b=
 huxWjhO9opitysF65T2b/AwgDvjcmDAnFkooYdFAS11utfNp/YbnFXMomoghCBUD
 uWp1I2FK65r16VYJpviFiESNlBC9Ri1gb6QdioXi4DqU1T1X2xp1dHFp0Ev2Zkze
 2FJ4x0qI2TyLUFUhtRp7YZ5R1S+DxUjkBrZOYEJWVQ1xWZybe+T87VfplVAtCZBd
 eH2KlINjdxu3p4LEquBIxtxfqbw62ZMuYhuhhUzj1rOCiD7B4UrpMeEnJkC7VpYt
 +OpTzOy2BJxTPELi/r/zKm5tCpcUrML1FclSXb4LWeONPXtyetxSqzGgV1Yqdslp
 yqr2HU2PSSrPXdyGpMYItg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773331494; x=
 1773417894; bh=H+jruQmOxoyo/RNkEyK/wpeJdj+x/03Gqq1ur9Z8SEw=; b=k
 lxrKlCxWg27PguwKv0BWBngyLvTpb1dwrBYooNWwglY+wNs9Bj31EwiNvFDV6v1N
 8k3JJqOx+RYKFQp1Sxv+PMcFyfs20811ujmKiVgkuxnUM9er3ne3g4pkgSg/EyUP
 4hRQ/VKPhDsqf/6vNakEgWAELGM6cj2dlI2E74dB3I27FwGAhYZjZEr5uz4FteQJ
 oPBhdEUNu1EoJOiZ9QDuEfld7U09Lv0s0s4rQDmv2daMhRMgXTdhBaF5xpJS2hDB
 X1xEbINxZ8bgVbnXoLqjqqoWy41+4fJbacsbroEGe30nVsirqu5VIY/Yvb7U/Ldq
 PYtXQOaepPfurGHP+dR8Q==
X-ME-Sender: <xms:JeSyaQsvQATYUDuO-NGWXadwEiKm-u7UVSh3QdXwyYRHYuZ4REt46g>
 <xme:JeSyadlqTWx9AtXAg3Zzkf3CsWvMtm9v85Fu5c3e57jEJfbogmbP6Keqfx49qG0PE
 PpcAVy90MaWqCrl-Jwxchi123tkydE8MBeM-F4koYwwhZZ1qnXtKQ>
X-ME-Received: <xmr:JeSyaTt-1MbTWquOAncJT2OJASGiBHsHe9P8c9fp0lmggTCYG-G7MW_dEoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
 vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuh
 hrthesghgrrhhlohhffhdruggvpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhn
 ghhnuhdrohhrghdprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtth
 hopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:JeSyabeBdX1ZhfP3RoaI8yFJdv0vq24X89iaMwHyLyntmDsjKXbBzA>
 <xmx:JeSyabyyMLJvZ3T0x4mQ-PZXQh12mn1KI0QvTrWQ6UgVELGX3Zu0Dw>
 <xmx:JeSyaREQwUWybHXiokDZxfyO2Bo2oruuNtSWMWQ0i2OjHVlpAu7YIA>
 <xmx:JeSyafxSkGLbOzyxagGoEKWVAS5q8pAlB0JTTuXdbXBgdF-zAkcykg>
 <xmx:JuSyacH6O3fjIJsPvPV6VZIjEf1l6WziO9mrAPOQocrnqUm7ncyvJhQe>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 12:04:53 -0400 (EDT)
Date: Thu, 12 Mar 2026 10:04:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Kurt Garloff <kurt@garloff.de>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, alex@shazbot.org
Subject: Re: [PATCH] Don't disable PCIe atomic routing for multifunction
 devices
Message-ID: <20260312100452.7799d19a@shazbot.org>
In-Reply-To: <20260312-enable-multifunc-atomicroute-v1-1-b7d66ca54319@garloff.de>
References: <20260312-enable-multifunc-atomicroute-v1-1-b7d66ca54319@garloff.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.146; envelope-from=alex@shazbot.org;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 12 Mar 2026 15:48:05 +0000
Kurt Garloff <kurt@garloff.de> wrote:

> As included in the comment: The PCIe atomics routing does not hurt,
> even if some subfunctions of a PCIe device don't require it.
> Graphics cards often have an audio device next to the GPU, so this
> actually causes them not to have PCIe atomics support. The amdgpu
> driver however needs atomics for fully supporting ROCm.
> So stop excluding multifunction devices.

NAK.  This was discussed recently:

https://lore.kernel.org/all/8b3e30e6-3c3e-49ab-b9db-8296aaf819d1@app.fastmail.com/

Just map the audio function to a separate slot in the VM, the GPU and
audio functions don't need to appear as a multi-function device in the
guest.  Thanks,

Alex
 
> Tested with Radeon 7900 XTX.
> 
> Signed-off-by: Kurt Garloff <kurt@garloff.de>
> ---
> The amdgpu driver requires them to fully work with ROCm.
> 
> The good news is that qemu already has code that detects the capability
> of the PCI device and enables the routing of PCI atomics in the
> pcie-bridge. This unfortunately did not work on my system, because I
> have a RX7900XTX which is a multi-function PCI device with the GPU
> and the audio function. I pass through both to the VM.
> 
> I could not find any reason to disable PCIe atomics routing even
> if some subfunction does not require it -- it does not hurt.
> So I took out the check.
> 
> With it, the amdgpu driver works nicely in the VM.
> 
> Sidenote: I had used patches to manually override the autodetection,
> but prefer the automatic detection which is much simpler in both
> code and usability.
> ---
>  hw/vfio/pci.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 94c174a773..077ff3a6a8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2112,17 +2112,19 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>      uint8_t *pos;
>  
>      /*
> -     * PCIe Atomic Ops completer support is only added automatically for single
> -     * function devices downstream of a root port supporting DEVCAP2.  Support
> -     * is added during realize and, if added, removed during device exit.  The
> -     * single function requirement avoids conflicting requirements should a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * PCIe Atomic Ops completer support is added automatically for devices
> +     * downstream of a root port supporting DEVCAP2.  Support is added during
> +     * realize and, if added, removed during device exit.
> +     * Note that we previously only did this for multifunction devices to
> +     * avoid conflicts; this restriction was unnecessary as routing atomics
> +     * will not harm and won't be generated by devices not requiring it anyhow.
> +     * The restictions hurt many discrete graphics cards which have an audio
> +     * device next to the GPU.
>       */
>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>          pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
>          pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
> -        pdev->devfn ||
> -        pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        pdev->devfn) {
>          return;
>      }
>  
> 
> ---
> base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4
> change-id: 20260312-enable-multifunc-atomicroute-ca11e3a399d2
> 
> Best regards,


