Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867ABC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 06:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZOCb-00079G-7b; Wed, 09 Jul 2025 02:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZOCX-00077c-Mf
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 02:22:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZOCV-0007BD-He
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 02:22:41 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60c60f7eeaaso7815697a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 23:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752042157; x=1752646957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eU5MkZCjZ3zcKXhUUVHuA9ttfeBxlkWeraWlBe9UDDk=;
 b=HT8ZedC3UGzgjybsXf8vd9KJc09B/yuujYXRU+mj/PBFDC58/DoJCTdmTV+7bBHk93
 s9Hqr+rtIgj3BiIg6felnfT8W5FbA7RF1Uh8mFYet2gN+kaJc6I3SDrbeyUSDGGoHoaM
 ixwPpdxUlET/GPwZGWRrMVUYqPKQ/sbd9miO67H4Ela4cOsa25unOfW4GSevQ+2hQTqW
 V0Bzzw29+1t6kVLd/W/zdXb8fxMs2H4OlnR/XOoOXnzl5fxuJ+SeSwToSX76DGot58DR
 sgfgh/XPXaGIoKldbig6GwAVvjjBLZUWp/98GICKsMtFhWAHK3qmfEDkSQvOYx/vLqUC
 rGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752042157; x=1752646957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eU5MkZCjZ3zcKXhUUVHuA9ttfeBxlkWeraWlBe9UDDk=;
 b=k+DMaCR9C0AN0N93ebRpWoys0UP15GyCdqXIgm9UoVSZK6uArkFnhfDc2O9P4UYFFc
 HDioA0q8O0S+Bf8PrDy+XrMH66/HYdIDgpJ+DXAAGm2q4R7VTL+1YrnJEc3edL8ezBbx
 lTf1fndvmgrfxrpkuIij8tDVRcLDK/B2zdyESK+U+Ueu4BhePGTp18USjM2+Sjc+B6LE
 22K20q3NDYmUXyq+7OfcsJ26E1LIce0eZnAh4190db3kT8RytKY2CRZ4yyKyimND1rle
 hgzRLIOd7xeN3wZ0ERwx4nv57b6IRzyXI+KD386Ss2JQJVs5MkG6eGe9y72OBDQLTRoN
 Nc+g==
X-Gm-Message-State: AOJu0Yyi7kb68hJP0P7SX+J3HJwVl0LrGguEeIE5cPS5ds5goRCCgXio
 PrwlG2iH7CpGvMbA4FTB/T57TG+1aUSE3Yf+SidW5SmbD2NKMSQcdtiH84YQW/BcpErqxOxfjkJ
 alzDIRtPnCB2Ztyi3bKOiJt/ScPNGrk6OMKkXrG6fLA==
X-Gm-Gg: ASbGncvaoddgqEk/KbNoDVW8xzr/MwmeXUydHHkvJz39qiuha2KUhBnzoivJeD76Llx
 PD73J+f4Jb1skgxYuItjta7SNsKknxZccD14o5Ug44lA2Nx4YLxb9MbVX1B8i95bPVMMMqMj679
 coQ0AH/ktj7VF2btsdleWcSFo+LgOIdjqmT3+HYRrXxBZJLc40yRQQDA==
X-Google-Smtp-Source: AGHT+IHnDGBQG/JpDxUImxaVpn8crQOUWRo8jbi0mjHhkI3WKRL0wIp91nmZNF78kASWeucvSzFx+Y9ZPeWCRLzB4og=
X-Received: by 2002:a05:6402:2707:b0:604:f62b:4118 with SMTP id
 4fb4d7f45d1cf-611a659a338mr791401a12.5.1752042157439; Tue, 08 Jul 2025
 23:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250708204907.2178-1-shentey@gmail.com>
In-Reply-To: <20250708204907.2178-1-shentey@gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 9 Jul 2025 09:22:11 +0300
X-Gm-Features: Ac12FXxDsW7rsiE5qyty_PdDRbkuys9kO07MIeWQU6OglvyrNS4vTld9py4kyP8
Message-ID: <CAAjaMXb+eo5uUNV6=RjKqf2mQgNeeYxYbt7oj-j5k3ToU=zEJQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix compilation with rustc v1.88
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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

Hi Bernhard,

Thanks for your patch!

There was an identical patch last week on the list:
https://lore.kernel.org/qemu-rust/20250703-rust_bindings_allow_unnecessary_transmutes-v1-1-692ca210d331@linaro.org/

-- 
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

