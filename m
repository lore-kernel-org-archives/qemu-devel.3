Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F18606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DO/xKcY0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPN5h-0000nQ-6R; Fri, 06 Nov 2026 11:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPN5d-0000lA-5C
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:46:57 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPN5b-0007Yg-GJ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:46:56 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cd6a7b62ce8so330703a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793983610; x=1794588410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OT8Ln1NpEQIvM2HEke4buGqdV+mGmQmMKjlsuCr368A=;
 b=DO/xKcY0gU+MxWPvygDDf/cGbNF/33x7kYb46YepRV5hJkIjhGTWPCGNChqGj+DQIG
 /DklnOOgxVzFsW2vQezlLP1WeK8aHBaRH1zdgTFc7EDSJIDyMGJRs45n2A2V1DlpnGMb
 Aq0YBPiX1jeQbucQk8D2BtjuSUsdPFuVDZutsKIUPmxMQFLXurlLFH1bXZKNpDzzf+py
 SrCvYdZZIYgW48bZL68f1s3Qe5bIoYC5/dlWENpiCGf+k/abOWELmzomG1UrYW7XClzd
 /+WIV3MI9K20Wb5L7dvrsKTVLyXGgsnnR+xDsTxLcNZeQoAvRaHJ9ApLQKKnsrpMVpm3
 ovxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983610; x=1794588410;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OT8Ln1NpEQIvM2HEke4buGqdV+mGmQmMKjlsuCr368A=;
 b=ZF8A9NXe7nMJGpNXcXgjeq0BnhJhvmIZCT/+BCYfbFHF8xFLYjwuFyuA6mQIiuIB1n
 nCv6JxQ8Y8i8Qx+pOpL3plhPH8ud+mYx2Mq/GUOYoCfJYl4/uVqERMlXGI86Le7nI/Gi
 s8VXc5E++DOdaGRRDWiRbWx2x/kEvrRm700dAXo2ZcETKlwtkf6yrVg+O9oaMPpXBfvC
 SXPPWf7ZBfBWhAmco2zHP3OJAjABuFwycaoA+4C/zIV/B3LbbSNx3s+k2wyRiT3xZWsc
 KtB8Vk7luJI9MLCxMGZH2WUNfy3tNdP33pKtFdwSLnVuRUNzpJ6ALEL+y+LG66F+RHsY
 x0lA==
X-Forwarded-Encrypted: i=1;
 AL+hErE/Sy5qhFanBoyg/ze6pVx+/f/Dn8M2mbXttg4CAk63Xq0SIIR+CTvcVYAYxOfwVAH3BLK09LMqKJdg@nongnu.org
X-Gm-Message-State: APuU4Z9fD2+cjHBzYzV2uTxvdeq/iu8T/dHuvIYO3HSZDy/g27RheWXN
 Wk3hqjFU/udXs5/dufcRBYRkDr7ZDN3A7UedGek0bERkmwuY/m1XPWCx9qaAzh+qBAs=
X-Gm-Gg: AYBFou1qU4JIeg8Cfy5Fcp/Hb7TDHwNw4bSbiJpOnmvQVYqurnawf9IAMDhN/fRwz8r
 RClkHow3y2tTAPIprzPak90IY4OVCUw4okeiATnIrn1iHodLv1S/pAGVSt+sudEbPiPwKjhUXOq
 d3u5W9gG5bQWo1kDz26L0X10fgt0H60HEyrS8C9BLVdJWIvG6PtM4H/ueXjrRn2b6uoNMbKd4gv
 6aTfT5jtTrU+TMeQp27gz1a6DHXGlLTqxHjpEyVhrqMLmKMU+VFYdfzf+l9T0LX9a5wBR2OUhb/
 44Nwl8393bP7/lhLcIh34ddZwScrVrNjz+BibL7IZpnwu+EffYMz23nWESqnlrEr23qWP9EvHzS
 DdR1XmNUjYhd0mzaDvEdwn+asu88w70qf+29LOfLCDcP30HlxGGZZln63C/RL0pZjwXlfI9oa2x
 oKgofOCTSvB2L60DEo0moEJfe4IfesUGwBvx4IEkGiizTZv0vhvO98K3KjDQ1svn3WPugQ6LjT2
 1dkIIWa60qV8t58C+Zq3VkK1lFYF+eDANb9FGe2QfooxodI/wA1zHQvfSYeimtbPUsAVJ5GwkIW
 l0QrYxGxfooFsD8f7MHaaQBj3AeHGqnN5qz99Esuo3Io
X-Received: by 2002:a17:90a:d88f:b0:3b0:a37a:230a with SMTP id
 98e67ed59e1d1-3b0db6f1006mr2905204a91.25.1793983610179; 
 Fri, 06 Nov 2026 08:46:50 -0800 (PST)
Received: from [192.168.79.85] ([50.239.128.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0fc1bc1e6sm312253a91.0.2026.11.06.08.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:46:49 -0800 (PST)
Message-ID: <f947e447-88a8-44ec-957d-6acadbe9e8b1@linaro.org>
Date: Fri, 6 Nov 2026 08:46:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] Hppa 715 cpu nic patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>
References: <20261105223122.8729-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 14:31, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 99e6fa0053ba1b1454b8c4446f857c430547a702:
> 
>    Merge tag 'pull-nbd-2026-11-02' ofhttps://gitlab.com/ebblake/qemu into staging (2026-11-03 10:54:31 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-715-cpu-nic-pull-request
> 
> for you to fetch changes up to 58952e4a5a2ddc0e450bef0770959b1147c98f2e:
> 
>    i82596: Various send- and transmit fixes for 715 (2026-11-05 23:29:19 +0100)
> 
> ----------------------------------------------------------------
> qemu-hppa-715
> 
> A last bunch of fixes to allow HP-UX 9.05 to run on the 715 machine.
> This includes a fix to handle an invalid use of the blr instruction, a fix
> which puts the power button address outside of the ROM, and various fixes for
> the i82596 NIC.
> 
> Tests were run on HP-UX 9.05, HP-UX 10.20, NetBSD and Linux.

Applied, thanks.

r~

