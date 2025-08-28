Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7098ACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEc-00084Q-Hq; Thu, 28 Aug 2025 13:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureBQ-0003Mj-Ur
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:05:00 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureBN-0004C6-H3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:04:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d603a9cfaso7241467b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393496; x=1756998296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IjcbSHCZrDkytvJaf38SMhSlxohPnup9zrxec1mnV8M=;
 b=JX4El0HO+OgcACs7QtWtTFWOx2zPji4VnJ0cY8c8y89sA3yblMXHh69zjrMFdF6TCS
 AWpjI8hyI1EacSmue/1zYdlLpnqnKdm7NQG8b0ZKUJcNnbLZsQZ6LKWSMSlcxjGAYVOJ
 GyUsMMiggwe2MPl7wW0ZoiWPgvyfrvfdbUkvaRnXnPAklQ7RpHCMKOsDepugmMNOLqKu
 ELL3vdknmuk46M30SZOG8z7h0138wLBnPlmUGQ9uXLNFvdPC7G/nznCpUnoGK1aQEcHk
 9fEGVOGB3IzJFuVD7CzzwwRZDZ2e0FVhsSryYWUIIFUlqmTgHAhiv7KvkyvohBDSNpoZ
 erMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393496; x=1756998296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjcbSHCZrDkytvJaf38SMhSlxohPnup9zrxec1mnV8M=;
 b=PQwnx1HwKRMsyyp64QxUT3DIOFqHzj+AAqG+5hDvcRp/3RBrToIqsj7ILIVsjLv6SG
 iMKn1fGdREUiwa2SVT6bUYKOXer/W3AswqKGuETySocaMSBf7wwjTLJQFX+FTVbWaKLr
 8i0X/mhU9v3Mi641KQ4YN5kxfgums88R9u82BOYgSAEwneg9E3ph68wgvn0h26aBqRi1
 xmCiwKnduhFfEdZEMNiBv7BuuFpMfTPKl7JXBFYz4nrdzNDI28nSTd2l1N7E7itNtSFN
 R8AsMtv+yrUyafGFpnCd35CuopLB9Wqi/NS/Z+41NJKUymHpTz0OkwWZ6braU6uMIjBs
 gSKg==
X-Gm-Message-State: AOJu0Yx3fV1bKRkl7cHksBQJOFh39vdfO265grC9MCDMgRJraFC9PbXe
 2gEzvly5SI9P6KYPXZz4hk+b1Gp0RehcGQ+5T4hpSClnyc75Dg7KJKEzjj5rIZ/2GwMmNqKWOPY
 2R3o91dyE5X5Q8Oj+sli5JFv/U3O/2ocdWsaEU6DR+g==
X-Gm-Gg: ASbGncv3dx2mcfScv4XWmZtqYtUpFPtbIYXtlMP63hjpqtQ+gjF6zBZRTrUc5A/lQyI
 T6i9vvFIMze+IK1Q1hfHQrXolc4f4X8XVBq7OkQI+BmAudTcwDt43H6qxi+sx0/4/NGaOgOCbI7
 lX/U1LvelInF3NY+Ivrtd/KrRk7B0q45Jzmy82QN2YqFuThbeHiAg2iST56TrK64d5UnNwixOiF
 IsnhLVz
X-Google-Smtp-Source: AGHT+IEfepmhsTODlh6OnJTfjvgWjjf0ulY4KNGXVEfF3CXATOzXj7JGERsmkUNn09/dmuZuTA7bECxeTMvlVC32YG0=
X-Received: by 2002:a05:690c:c0b:b0:720:631:e788 with SMTP id
 00721157ae682-7200631f1admr207843427b3.23.1756393495634; Thu, 28 Aug 2025
 08:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-49-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:04:44 +0100
X-Gm-Features: Ac12FXxFlZsKOmYLpz2K12sLVqAS5btLq67tG2sRnEMamOCt8nnuLREVn_9rZik
Message-ID: <CAFEAcA8GnEcrSW6GM3e-kzVc==MJ_AUsovTt6rQD2FDz0bd2tQ@mail.gmail.com>
Subject: Re: [PATCH v3 48/87] linux-user/openrisc: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

