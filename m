Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C3ECD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 03:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLCIY-0001jp-W5; Thu, 07 May 2026 23:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wLCIV-0001jW-MS
 for qemu-devel@nongnu.org; Thu, 07 May 2026 23:54:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wLCIT-0003Oe-P9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 23:54:43 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso5802635ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778212480; x=1778817280; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wm0HQ8hf4OvljVr37UO0CVpEHhudkGBNHr8K9hfE9No=;
 b=Axlzs4OAbdE+GvF7tVoBMz9S1TpeFGLAuzW+Xd8Z9IcNXUNwXvKBfIfPM+cHV5qK0x
 NqoDmDvTzvDE1G9ziv0fMZiH1c5RSikaUrJIUyqEUovCo+bVeosAmKwZ3T03HdFiPxJr
 X2fYKnwIsUHOEr/HyrszQZBCQvJu0gsL76tAI59NhlbuVby7DQYSZAQdYM40YuRC4TAX
 Fm4EiXdmhbjm2be8EgIT0tEjRrkKhjTRtwBX02KfzF4QMDE5zWRYvONnY9EL1G5kC/EV
 Rp1N+Gg8CO4AAawEs9zIXLYAOCHnqeDw124WMIfI1Tv8lpEP7tFk1lvItEWNshsPZAPe
 fW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778212480; x=1778817280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wm0HQ8hf4OvljVr37UO0CVpEHhudkGBNHr8K9hfE9No=;
 b=Yla7pbspc+bSn2eoyHcsRSvzTRVL31eZoWOsRgTzV9tk6cj/6hp9f4ZU6RQYuXeSt0
 jTozS7mzkZ7bpvFYltalEBZzuXxIKK51gGOHiP8/Q9wiTUAsDix9f9sq5Z92fh+N1IYp
 1M6oQTcLk9TuGpR7KtuzIMeRmXpeVpLI3eGW4TVzi2c8e0c9QKQmmyrU8DlCifd88tVo
 em7zjD3G0j2DYG35n4QJZrWQ/FDD6xedZ3vCmzGVzDMTBKjo522xX9Z/8EO0KEaWdUF4
 8QaNBds+edwph5lXPOsOVKtCmM+ZPlKt+RdLxsgjqjUN5fQ56mWEMF9kQKZhhRU5sL1x
 Fb3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mCi2T0hkk43w0TpmYE/tmebXSEsa5KPeJpMTiMAg15jfP/BlI/KlucH5mX4GBbnRiZgHftgCb4zIC@nongnu.org
X-Gm-Message-State: AOJu0Yw3blVlmG250co1T2yyn6kj/LsAkTCBrO3bOI7nx0OCiIjKjMqY
 hZB9gwVL04H9hadkCqSRT3wUoZOFuafJG/ctA+8QX/8i2ZoUAJjSBL0i
X-Gm-Gg: Acq92OHvY/ZV4KSXisegFiBDDSF+b3WuE7Q7IQu/BFwHpyh4BwC6t9dRGpvD/Y5pCyy
 1KIKnJ/nCkHQmSgp+Bs+jAvvN2bxHkFs+EXtRjhvpJLDHQYIhG8F0LFNB15DgP8mSJoiHivFHFz
 XfiW9tM6unuPoLpaCytgq5leog6Uu04woWrjV86pWjBYdeuz85WgAYfrQjprHRPiNOf1ERhDogB
 MPJEJ12ENbwD9rB+htraO+NfaKL3vqB/1inBq7jikKdlHFlG0Vv41lPRNWPrlixSuUuUpkUmoPe
 1JjQ+mgpf7mGFpggMgXdOL+hpetTSyrLlGVj2WacS8fk3PtQw7MDMHYkhoZtw5ACbZud1iPT+T6
 JfrGOKiqD5eiTEk0iySF7FDjlhUg4OyptHr/ZgeQ6PKo1spqAEMgdj7nRM6MpmFTwYFN/2DsNHg
 UK54KvTn5YcFQb36ygGCWsmqWx7ZO15Mk=
X-Received: by 2002:a17:903:46c6:b0:2ba:9e1c:7c93 with SMTP id
 d9443c01a7336-2ba9e1c7ddamr83984135ad.40.1778212479997; 
 Thu, 07 May 2026 20:54:39 -0700 (PDT)
Received: from localhost ([1.146.100.102]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d271b7sm4430135ad.14.2026.05.07.20.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 20:54:39 -0700 (PDT)
Date: Fri, 8 May 2026 13:54:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 6/9] target/riscv: tt-ascalon: Enable Svadu by
 removing Svade
Message-ID: <af1UmCFaLRERlpwa@lima-default>
References: <20260507043838.45652-1-npiggin@gmail.com>
 <20260507043838.45652-7-npiggin@gmail.com>
 <dic5owmgvmaoqhiinu3v6kcdyakwt6kj4ryfw5vm446w3pv6mj@77kcjokjpnem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dic5owmgvmaoqhiinu3v6kcdyakwt6kj4ryfw5vm446w3pv6mj@77kcjokjpnem>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, May 07, 2026 at 01:57:02PM -0500, Andrew Jones wrote:
> On Thu, May 07, 2026 at 02:38:34PM +1000, Nicholas Piggin wrote:
> > Ascalon supports Svadu (hardware A/D bit updates).
> > 
> > QEMU makes Svadu and Svade mutually exclusive, remove Svade so
> > Ascalon comes up with Svadu working.
> 
> Hi Nicholas,
> 
> Svadu and Svade aren't mutually exclusive, you can see the expected
> behaviors for the pair in the commit message of commit 70d22fd92c3b
> ("target/riscv: Gate hardware A/D PTE bit updating").

Okay misunderstood what QEMU is doing. What does it mean for an
implementation to support Svadu && !Svade? AFAIKS the spec says ADUE=0
means the access is performed as though Svade is implemented. I'm either
wrong about that or miss the point why Svadu && Svade is handled
differently in the patch you reference (or both).

> Does the
> Ascalon support Svade? If so, then it's probably best to enable both
> and leave it to Linux to enable Svadu with SBI FWFT
> SBI_FWFT_PTE_AD_HW_UPDATING in order to maximize the amount of
> software supported. But, unfortunately Linux doesn't yet support the
> checking for and enabling of SBI_FWFT_PTE_AD_HW_UPDATING. We still
> need kernel patches for that.

Our docs say it supports both. If enabling both bits is the correct
thing to do we should go with that for upstream.

Thanks,
Nick

