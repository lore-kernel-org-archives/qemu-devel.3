Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15006D1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t811k-0004uL-4G; Mon, 04 Nov 2024 12:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t811i-0004rY-Ja
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:38:06 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t811b-0001Rr-Bl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:38:06 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso5547908a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730741877; x=1731346677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pq1JIogSuf81cTog8eKIEEkpSnZe4mHIRjbnePUA2Iw=;
 b=jlhq/VLHE4BUtLqMDNdEaCUXbxXO1FiEhd8iFEM9H3/C4sidsvP7JrxTrUb5l4PDEh
 PFJ7o/vwwROn1vQBw6UV8E9nBxDbtBVC4b7OqSdMXqp5tuZ+NAW0Oi9ZVVzpsNlY9Jdp
 OVNaVZpQGpCzA2RcGx+EGEMpX23EiGbbqrO+Mg+Il2MdX/QtjGPSJu4bEIXMMMCs1281
 0p0LB8426ERcU9RDRapfc7xW9K4TjPN/REAe4bL40A7DhOtM8oP77R/y///BVLDc0EUA
 l6R4xMyPkEFeU62U6AGr66/nav3gaF5Tj5Cg8lb8vnzK9bD96nFXlDeGoWRAUAzkc1s7
 rDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741877; x=1731346677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pq1JIogSuf81cTog8eKIEEkpSnZe4mHIRjbnePUA2Iw=;
 b=miabPp/AgjglRN7zOzUjzVkh4Jhq7nmRd4xKZKeQV7kpUAYpgMHlQMQmBpXSrl0XbH
 vp+/6K4M+oIl5Bp1sOq9m0D/DYm1xtF9shY/1wTBnDXnhl5kilvXugQI2S005cuM42wh
 nXRJU+ev53iu+rIr6ou+OrwAx+Nhbfz4fFfJwcqMD1BMpM4zYVAzsVqHi2Fq8nCc+PyD
 HoF9QpHivs6B8JfmVI/TRawFoxiCpC/gm5mmvxIfUcnpiD7naP0I1+/OVadOZ7xvykzh
 cQGaqP3wb/uMAgKFIxjgDJA9cYeLVGo9TPhBGxjlKeHPBXzfNDETWste6+j1j08/XmuP
 7wwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVVKifhKukFr8IAOKtRSpYCh3dT/8iC1NyWEuSWOMtF0yESlSl66tTajIc/+AuVyX9fF9IkEwnBXYo@nongnu.org
X-Gm-Message-State: AOJu0YyuF4G6eVPxbqXpgXEHRB/9Gx7RA76y8IFNUGYCHVzzoDIPwahf
 z7OITo140c1Uw/KkQmnm7xbY5ZBGHUCxuAVZSPmrDp9gMzjXgQoM9l6DMSNv3gHyqroNkLN6JQZ
 lV3+Z1XCgUqUrzUqHbEohNhyUJmQFEYYdX9gPHQ==
X-Google-Smtp-Source: AGHT+IFC8BI23CzvVD13z9BbFC2DbzCS8eQLUTvNuVOkjk7KUm2kITCynxjjqm41CIUfuRbbyVtG67mEdMQXV6Lx5wA=
X-Received: by 2002:a05:6402:2790:b0:5ce:d4ff:606 with SMTP id
 4fb4d7f45d1cf-5ced4ff0642mr4091135a12.34.1730741876740; Mon, 04 Nov 2024
 09:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20241103195941.22724-1-deller@kernel.org>
In-Reply-To: <20241103195941.22724-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 17:37:46 +0000
Message-ID: <CAFEAcA8BUVzhf_dMmApm75_Umg0g-22NoQmXY6yOKdHxMH_LbQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios hppa v17 patches
To: deller@kernel.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Nov 2024 at 19:59, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:
>
>   Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/seabios-hppa-v17-pull-request
>
> for you to fetch changes up to c9d77526bddba0803a1fa982fb59ec98057150f9:
>
>   target/hppa: Update SeaBIOS-hppa to version 17 (2024-11-03 20:46:06 +0100)
>
> ----------------------------------------------------------------
> SeaBIOS-hppa v17 pull request
>
> Please pull a single commit, which updates SeaBIOS-hppa
> to version 17.
>
> If comes with some important firmware and SCSI fixes and
> prepares for futher development to support 64-bit HP-UX
> and MPE/UX in the future.
>
> New PDC functions & general enhancements:
> - Add PDC_MODEL_GET_INSTALL_KERNEL firmware call
> - Add PDC_PAT_EVENT firmware call
> - Support ENTRY_IO_BOOTOUT
> - Prefer memory-access over io-access of GSP serial port
> - Disable LMMIO_DIRECT0 range during modification
> - Small optimizations in IODC call
>
> Fixes:
> - esp-scsi: indicate acceptance of MESSAGE IN phase data
> - Avoid crash when booting without SCSI controller
> - Remove exec flag from hppa-firmware.img
> - Fix LMMIO detection for PCI cards on Astro/Elroy
> - Avoid trashing MPE IPL bootloader stack
> - HP-UX 11 64-bit saves number of RAM pages in PAGE0 at 0x33c
> - Fix return value of PDC_CACHE/PDC_CACHE_RET_SPID for space id hashing
> - Allow PDC functions to act when called in narrow mode
> - pcidevice: Use portaddr_t for io port addresses
>
> Cleanups:
> - Change default make target to "parisc"
> - Clean the "out-64" directory on "make clean"
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

