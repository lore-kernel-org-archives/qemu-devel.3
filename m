Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05011C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ractv-0004ED-KH; Thu, 15 Feb 2024 09:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1racti-0004D7-NS
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:39:37 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ractV-0004g4-8p
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:39:22 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563cf32e130so308512a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708007959; x=1708612759; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HFr7FApZYLQRYuCgSuuloiuEEUdNJbVYh1Z1LoYtLFs=;
 b=OxKi5nI+1qvev+C6jP0/q8cgTGHh0s0LTDYeUn83R4CGlxHEUcFcIDQWQPtlFTUmMT
 DExNCsOd7ZLh6+kLVzP/NeG6p04sTF8/0d/U3svQM2qKDRtxNcJ3aWbDM3OLbHpdVKAe
 mnwJUKSjrkWpc5gSTAJ7Ywc8Okx0duZzUScDz6Gfdq72xp/aOUu93k6KvBj4K+t5DuNs
 WCRG50+ITHnyv8HVWV9IN9LxMFy1btVbuacjAv8kUp1Dj3+dbx8KprSDiOy6hbT0lqsf
 ginX7F7jR/Cg+1Ax1TTUTtzwfybeStFRhcgNCi5xKNX7uf2Zm4NX3lsNTf/1woV40qWs
 SuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708007959; x=1708612759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFr7FApZYLQRYuCgSuuloiuEEUdNJbVYh1Z1LoYtLFs=;
 b=FktU56O1/pDfjKd8xPiaQAOTE9v3sxqk7fOisXq13YzcZs1vf24z7IVDy1nhVPyXGr
 HkROTd8104aXBg87TPxhze/ZK5c/0gS+4bkR0smP/5zfpXjXK1MYAGZltnw3ut5hUAa+
 vRDHX1U9vhDmKOIWIrVIK1FFzmcfxmGUREQ5m9noaeAtpylfXBqh/39tkSDsB3XfQs3Y
 WwbgHAHsXS/wu/ecrZ20NfftFeviNKi9yW6FjYaYew4p5ihlVrt9o+Xl9WqdoA0ttWzF
 FUsd4+OQGYwKdxHTWxT/AeRqG6aDlmyJhixnLAC1SynGmyQxggZBpM3iFBWj2xhWUdyL
 01Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6UHDB2Lh616wcu4hOx0nlAGmG+27GqZRcvqnwQNFqInBsjo9J6taDX5CgtTQcCaVpFPunrdWwJ1BXSLv5uwR4qaGj3nI=
X-Gm-Message-State: AOJu0Yz7nwE4E1df0iF9L7An91BhaxsgODugMyt8b0f9grBkmB1nNzuQ
 M4Nr9fRR4QcHXxX0z8/Fi1pSdo3PU1o08RJrrmMxMKfqRXeSuiHxxnoUtzGjr2IEZsi8TbP64uB
 l
X-Google-Smtp-Source: AGHT+IEII9ZKI1s3tNnGsjuieKqxLhqlQOfxAhQ4yGp3aQzk1rkdDCjpx4zpYcFk5FOrNjGkw1D5bQ==
X-Received: by 2002:a05:6402:4285:b0:563:c88b:68b5 with SMTP id
 g5-20020a056402428500b00563c88b68b5mr799964edc.14.1708007959587; 
 Thu, 15 Feb 2024 06:39:19 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a50f685000000b0056384b26771sm630310edn.91.2024.02.15.06.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 06:39:19 -0800 (PST)
Date: Thu, 15 Feb 2024 15:39:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240215-e18cdd6d9c622bcaeea2c8f4@orel>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
 <cb84b02b-eb4b-43e9-82e5-2367ee2a2789@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb84b02b-eb4b-43e9-82e5-2367ee2a2789@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x536.google.com
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

On Thu, Feb 15, 2024 at 11:13:51AM -0300, Daniel Henrique Barboza wrote:
...
> > I want to raise my frustration with the crock we've been given here by
> > RVI. Any "named feature" that just creates a name for something that
> > already is assumed is completely useless, and DT property that is used
> > to communicate it's presence cannot be used - instead the property needs
> > to be inverted - indicating the absence of that named feature.
> 
> Let's say that I'm not the biggest fan of how these profile extensions are being
> dealt with in the spec :) the text is vague w.r.t whether zicclsm and others
> are actual extensions, or a 'named feature'( like we're calling here in QEMU)
>

The text is vague, I certainly didn't get it at first, but it's been
clarified that these "named features" are considered extensions with
the given names and those extensions are ratified at the time the profile
in which they first appear is ratified. As I said in my other reply, I
hope the need to name old features is behind us now that the first
profiles are done.

> that is just a glorified way of saying, for example, "zic64b" instead of "all
> cache blocks have 64 bytes".

The note that accompanies "Zic64b" also states that the cache blocks may
be larger or smaller than 64 bytes. So, when a platform includes this
"Zic64b" extension in its DT it doesn't mean all blocks are 64 bytes, it
means they're all compatible with 64 bytes by either using 64-byte sub-
blocks (when they're bigger) or by sequencing cache ops across multiple
blocks (when they're smaller). So, while we can derive 'zic64b' from a
platform which does have all blocks of size 64, some platforms will need
to explicitly add it to the ISA string when they know they're compatible,
since they'll be putting other block sizes in the block size descriptions.

Thanks,
drew

