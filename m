Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EF2C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg428-0007it-1z; Fri, 01 Mar 2024 09:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg426-0007hK-BJ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:38:42 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg424-0000ft-5F
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:38:41 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5131c0691feso2667113e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709303917; x=1709908717; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=saLjE0nD9m0n/GVuxHoNEFxY3eiqWZoV8vZ6BggC4XE=;
 b=wp8i6eZMNPV+sOJ5GWUq8XrdbkkQrZo9VcBQ+15Bgvg5FhSNeG4OuMThwsxpcCmMp4
 qtshvRIMUZm9e30mAtSfTpxbKLd7m1d2Rv0FxtVJjftLqDIY26KMwk1RKoNcEVfjciOr
 m+TEiR+uvpk7/Cljaz2bvBaaRRsqydNhTxptd8pl3UBs73mNBzFDV2gtIO5ls6WXoBF8
 gx/H549KHe82xxX2aMdAIMN57/Gq2o2phC8DhMxK6TjJfLlfk9A/80H6qcqqCW4xLYW7
 pIJZhf3b/7aQr73MFZXAcNRNWAeJi1ivmOTHEOZeYxVkPPkX7bwzLSIBykknZGJ4tPfd
 zieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709303917; x=1709908717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=saLjE0nD9m0n/GVuxHoNEFxY3eiqWZoV8vZ6BggC4XE=;
 b=hw0TjWGbpqjvSZ4UHL/tXAZsEEKb9DBHfhOClMXA7fBDyAcXXmkO40yTNI51j6GZY8
 FlaKTSTWm9LruDJhPKN2DqTgW3G8lXUmfzE6K6dZjfgvG/mgCShHpB16CGQZ6xfDaNJb
 Dyh29tsXkHKwW/suyLuzMp8q+CJgCji5Myj6DI28pmLzBev1KolduO6f+RSPGpxI2BqY
 x9mhM1S8VVMVNTasxCA3VDehXw974qBDRyAsst5sACGsFyBXlJpJneF8PUUhGsfoOb7O
 QEPlovTR5ymn3c5if3aUAvUswllwOMeHTB5kNoYh/PCuBrH9ovErOH4VlU5cp4/1zPkU
 ebUg==
X-Gm-Message-State: AOJu0YwUTbJ+nq8wyp21ErElbag3YsAQ//fAxqlLwy/p94YZyLAoh/Bd
 P8gObykADIrFirMwLXcCKGOE1YfgyvXBGjARijvyVoTuFCZuL0OkXRl7i9F+0NuF/JxhHCS8GFe
 jPkvPpMsN/Ph2u/jIJjE4qQh9+mMeKFCL0SHQjP41uRn8iJLV
X-Google-Smtp-Source: AGHT+IGJXYwwfNzDcowP/qQO5gS7/xrmttTxP7Vwma/X6TjdMI0QxIWajtHMjc4jWPibPjru79xJoivCvKz5PoVPkiE=
X-Received: by 2002:ac2:58d0:0:b0:512:cef7:4754 with SMTP id
 u16-20020ac258d0000000b00512cef74754mr1184887lfo.5.1709303917001; Fri, 01 Mar
 2024 06:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20240229113842.619738-1-gaosong@loongson.cn>
In-Reply-To: <20240229113842.619738-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2024 14:38:25 +0000
Message-ID: <CAFEAcA_P+1+tvSuLgZ-tkU8W=i-r+KjHCQi=n4TVwE_8xXgcZA@mail.gmail.com>
Subject: Re: [PULL v2 0/1] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 29 Feb 2024 at 11:38, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit bfe8020c814a30479a4241aaa78b63960655962b:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-02-28 14:23:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240229
>
> for you to fetch changes up to c6e9847fc4becba561c631c4505e3b05d4926184:
>
>   loongarch: Change the UEFI loading mode to loongarch (2024-02-29 19:32:45 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240229
>
> V2: fix build error on mipsel
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

