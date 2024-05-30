Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B409CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 15:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChLg-0004Ii-Ma; Thu, 30 May 2024 11:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sChLf-0004IV-Se
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:05:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sChLd-0004XO-O3
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:05:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a196134d1so989900a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717081544; x=1717686344; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2GO2Bch22rPWmWecNCqjeQ+ehlXyEbrNWMzTV9ZiHE=;
 b=dwXcSccNmAG+eblZ0rqYbkS2ybVd+XgpATlpUW9jwnMlj75mmhdYg3UHp3YAgu8Gw8
 Fpba47a14jxNi4j8Eg85IqNL0tQ3ZAzeLyT9ToZJng94icfYHMX8hLTBohEJUoz8Fg+a
 qxC+Tp1BEuF/ay1KWis8zgxM/mzvOnW4BQ61sQIJj+W9W4ylsZ2vCBksORlqdsRN5KiT
 cOEjgtORUnEElUsB2ExqJ0k0DiEtANQ4tbbtYd9VUk27j1WN4mC53qgkvndlyMYO/8Ez
 bPXvjmlOBY+06teP/Lisv1YW0Vt4L6s7/C6bgQBseSi4rciebbAIMXMR3A136uEWhxWj
 dQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717081544; x=1717686344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2GO2Bch22rPWmWecNCqjeQ+ehlXyEbrNWMzTV9ZiHE=;
 b=TAcjbeCHrSmuWyXcIjK5pygPY2HoVkd9wUVUy3aJYSB+4EGxw/jcEXyBVNgHlW/kbd
 dcpK5aamNBbn6Voje/Q4RELG9kdHfiR0x+UuKZscYbfFaUQS6q+hAtYHCPLFkpcO/TIF
 ejS6pCkGJgLdw3JrHhKvycHzNL4EwuGLkZ3Gn/HL4I4qRObBPUhUgualT654dRhwf/4K
 wd1AGdMIMxj2rUS0PkNaBPY724FxO77mBy4DIiXM2CZH5ydefnO0jA/WMdKILtPzPicr
 qCG2+Q89fnv5WnPtW5y78PxcXbw+5Pd7w5CUF7JKEM6UBuptqO2peeQVzF7Uzf8JQzkO
 zaMw==
X-Gm-Message-State: AOJu0YzJgdxSLqNkkmD9nnrRop9Qtr9bZz+sx0NA9MNmTabqZiIzHSEy
 01DBAI+kWKfBdbWQVa5LDnzgRt2Gh8Cx7tjOJaE23A3ZSVg0QZY4agqlL3PmCSS6ARkpyH62Gib
 N6jdmuP1DjJxqKaPJyiCJVYgAt73u0xi1IbzWOp7RyhitkmQD
X-Google-Smtp-Source: AGHT+IF1vq8GfwISDKGM1KcZZUJi5ABkG6Wa35fmNAcrAe/LL7IsQSAoSm4fqQAMurtmxfJxO8T+Lrd6LXLFWs2J9HE=
X-Received: by 2002:a50:9f03:0:b0:578:63b0:5821 with SMTP id
 4fb4d7f45d1cf-57a17802e70mr1490950a12.25.1717081543836; Thu, 30 May 2024
 08:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
In-Reply-To: <20240520232634.317988-1-dmamfmgm@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 16:05:32 +0100
Message-ID: <CAFEAcA8ZLBxRtrmOxvf0nNBJaJOLrSBtdy6ZgbFt8Fw2oZB2Zw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: David Hubbard <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 21 May 2024 at 00:26, David Hubbard <dmamfmgm@gmail.com> wrote:
>
> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the way the ohci emulation handles a Transfer Descriptor with
> "Current Buffer Pointer" set to "Buffer End" + 1.
>
> The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than td.be
> to signal the buffer has zero length. Currently qemu only accepts zero-length
> Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI hardware
> accepts both cases.
>
> The qemu ohci emulation has a regression in ohci_service_td. Version 4.2
> and earlier matched the spec. (I haven't taken the time to bisect exactly
> where the logic was changed.)

Almost certainly this was commit 1328fe0c32d54 ("hw: usb: hcd-ohci:
check len and frame_number variables"), which added these bounds
checks. Prior to that we did no bounds checking at all, which
meant that we permitted cbp=be+1 to mean a zero length, but also
that we permitted the guest to overrun host-side buffers by
specifying completely bogus cbp and be values. The timeframe is
more or less right (2020), at least.

-- PMM

