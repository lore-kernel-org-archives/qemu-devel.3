Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE36C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTrX-0001gv-3j; Wed, 08 Jul 2026 11:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1whTrU-0001gE-Qa; Wed, 08 Jul 2026 11:06:56 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1whTrS-0004KV-Pk; Wed, 08 Jul 2026 11:06:56 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DB2657A014A;
 Wed,  8 Jul 2026 11:06:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 11:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783523212;
 x=1783609612; bh=fKMz4JzXRe8eCEYB+t1soX6iRvo05G++2pC9uMSQx94=; b=
 GldZtJcq+sDkGLXFcLVABdTVsGkY0lk8Dpv95rJ42svJ8AZ6mxe2V0VtGEDDi94/
 5N5RIv2leCwUkbWGo5HxP/D/rBBBnLJLix+jjE5QCcoxI4I18itm7ADI6edvHUKO
 NWU87DYUGLT2KJhqEBCDnNhUwkSitCnJ5b7MxMfcI8EXTTm5g0B5KdH5N0Z9eyhr
 Toej8GXAHMHBfNiE/ZaEmUuh9Xh2SGb5BuWDW76RAC/hwTQjKI3x7vxUJD3x/3DM
 D6/wSFtAZCuyV0dFxK4H0d46od7E5dPnW5J6YVKZ8fRevnKnTvtqRVwbUhNcfpgQ
 JEMAdBLz34iyMcuu0vG34Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783523212; x=
 1783609612; bh=fKMz4JzXRe8eCEYB+t1soX6iRvo05G++2pC9uMSQx94=; b=V
 EF/hj8HxpLk3DjAKXPKRbaaLFNPa3oHnYP2pKu/6sZbnISW3MkSx4zdlxI/1vBZ/
 4taNdRvgmb7zI2pL3CqaxIQr4sSe+S4Bobto2mkP3MJYqasp0ZUR4GmD6ReCff9f
 ejIB6YNI88qk9JVVEy8c+bNYny/WNEbbLlnnvfTBv29MZusqlzCUt3pMkYNgD/TQ
 aggw8Pi4JJi/5CL/Mu36T4on1gp31JepL2OZIdDJmpLS95Eekh7M0SvjpL4KPQmN
 yJJYiJAkr7ZBnbhlW3enq5TCEsbEKYX1bqLd2VOZsfr4HuIE2BO9OA6BZVCLWNiF
 f1l8zD2WgSP+MxDukCObw==
X-ME-Sender: <xms:jGdOar_u7kaSqAP6tjFpsGeHCSGyhhNbZBz6XDCha7Cnk24sBDbkqw>
 <xme:jGdOagqbS5xjE88Uc9vKPF3lx2QFZVMfINmkf9AuCePIsnn-8scEky0qMvf3Vrg44
 BhIo-Jkh1hw3THCqkl8nD_og2mVULq0uqMVZSnKmEr6eQK7pXq-Rw>
X-ME-Received: <xmr:jGdOaklH7WguOkJnDIASErD7XA11i_nErzfnQIep2VIGoGYigOkY5mjwuHQ>
X-ME-Proxy-Cause: dmFkZTEnwAxMd8cVVQO6EMd6fn/HIeIsU89+kh9BfzAUtpzw4T++sOnMSD0nWxn0Dgq3Lz
 id/JO1ITw5hjpFT9rOj4gidp38aleevUKyZT2QVjNNYCnVpSRJ90bHLrsQ8M8w+1edkpWm
 urZfG59/vZp98LNiT3hvQjz5bpbXFVj/tAgcM44g74idxvZI/KtvFSiUg4ds+EtUEtMArq
 oolQ8FVmg6Dk2nt2im7dx2gTHyF/T/kwchjZ13ZZ+XlM1WDC6UjYfmDaBTxq+igt3hnWBu
 k4a7SdEwB8hXoM43ZDkNf7fHGfoorYU3JD10qg1YB/ALaVLfjAXmY+rxrCVt1kkl3Bb/DL
 9sXn6Ua/teDDOwvEl6iJTJVE30/TrmSkLSRhm9WZ7LTbNWCnOQNnzfqMeQDoF5wXUo3EqX
 9azsiHWwqmSpf2P4MogQkPtUsb05Qi39yc6PDFGk+Ypxr2Ob7BF54Bc32T++tvHlEB5FwC
 v/0g7Zv+LuF9ATLTgpe1PWWjsUXHDtzqCmtXu1sCTu7b57wIFIJfZtXlU16DiqVbxTWo/6
 YCXboCeg2WcXHwy6zoscjWZdU+LUmZpUvaoWxuKfXDwGMbjMcO0881dVO+qEL/0WDWqSkw
 cjNsi1WvJszmrClST1wZO8vJQEdonSjCTv2S7pGGCB8xxXjlk7M12PbyfGbQ
X-ME-Proxy: <xmx:jGdOangx0Nc7shM-tmoRPLR_U-PrAZJ-5oJqqQDovKyQnnZKK063mg>
 <xmx:jGdOasc6euN6HA_xxoQ0pcQexXOFX1u0d4zfaK1Y6oCi_NTD4ndn2g>
 <xmx:jGdOanhAO1EmMl79GQ0opRWhc2jvCrHJCl6KgdK0-JrziSyqH0mhNw>
 <xmx:jGdOakwSPLeoftZSYNuOi6UhgUCkUj3AUeaSVuMb0ZEOKvKO9A56dw>
 <xmx:jGdOaoAKo7ceDYtKyOg9niw0BhCZUTaoWOtQyoo5wY73_lOROFRtn-87>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 11:06:51 -0400 (EDT)
Date: Wed, 8 Jul 2026 09:06:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 alex@shazbot.org
Subject: Re: [PATCH v2] vfio/listener: Replace misalignment whitelist with
 DMA capability check
Message-ID: <20260708090650.2247755c@shazbot.org>
In-Reply-To: <20260708133604.1606448-1-clg@redhat.com>
References: <20260708133604.1606448-1-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.152; envelope-from=alex@shazbot.org;
 helo=fhigh-b1-smtp.messagingengine.com
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

On Wed,  8 Jul 2026 15:36:04 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> The vfio_known_safe_misalignment() whitelist (currently TPM CRB only)
> requires a new entry every time a device exposes a non-page-aligned
> region, which does not scale.

Arguable as we have exactly one class of device so far that's validated
as safe.

> Replace it with a DMA capability check: a region that is not
> page-aligned or is smaller than a host page can never be a valid DMA
> target, so a page-offset mismatch is harmless and only traced. Only
> warn for page-aligned, page-sized regions where the mismatch could
> indicate a real mapping problem.

But it's the composition into the address space and how that address
space is defined to the guest that matters.  Imagine a minimum counter
example to the test presented here, a page-size range of RAM in the VM
is composed by a device as two contiguous sub-page MemoryRegions.  We
only see the individual MRs here, they're each sub-page, the shape
suggests they're not DMA targets, but together they map contiguously
into the VM address space.  KVM can trap and emulate them as normal
RAM.  QEMU emulated devices can DMA to them as RAM.  VFIO cannot map
them through the IOMMU.

That is what this test is meant to validate.  The judgment that the
control register range for a TPM device presented as a RAM MR is not a
meaningful DMA target for a vfio device is the thing that cannot be
determined based only on the shape of the MR.

> This removes the TPM CRB dependency from the VFIO listener and
> eliminates the need for per-device whitelisting entirely.

And removes the diagnostic it provided.  Thanks,

Alex

