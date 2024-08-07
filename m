Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B1CC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUZr-0003Ui-Qn; Tue, 06 Aug 2024 20:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbUZi-0002ya-Jl
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:30:47 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbUZf-0004tF-TX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:30:46 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-261e543ef35so670541fac.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722990642; x=1723595442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ViO0Y6FlHZ3vbVocVUg2sPEYwY8UQ+Ad5v0LFJEN6K4=;
 b=xO0T1zarz0JpyIkJQ+Oib4pSQY+LGNJAJ+NSs2mhECQrkUIyg52G7lse8XAarACsFG
 OI80ThY2wxbD2e9TdaxKAmQqExfxlcAvmpicKSq9x2KbSeOu6r2CF40rLCbyQPV4g645
 qMKpmSxK9tMlZVo+cgsAag/3jgPsoGlOp8W5xN0+Q0loLF0Sr+64roEzcz3sVUKUnXoA
 BDpuRB5UlWPrhpABR5Jk+CRhaG/UtOmz/2ZK9HAwqUvHrun5rJHjx1OqvbSJyCb34gFT
 XYgrL3UHu62gfaurR0Qui5M8xqdm2Ug4Fzyh+GFArO0BZJaT3v3QIqFWnwSxrADsjy5S
 modA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722990642; x=1723595442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ViO0Y6FlHZ3vbVocVUg2sPEYwY8UQ+Ad5v0LFJEN6K4=;
 b=bFUsAFVI3RR16GTlWkLdXjKVbhtPNQ6mb96sJIGXN8t+cFs1d+UecyYRYtXsgLGbhm
 YWqXK9yFwEQevb2vY/hnt07HOQTIVpEVfofKbbfIBG2K9UjZOSUN1kd8DXA19ntwKTIh
 nyHY/H3aMPvlxCa1fNkz+BuAp2pQwp/534B6NPGiynNGbIHj5icV3C6jXKUg4fEItB5N
 HdVayDviQPNA3b9/k9RxuyoVpsH4NrcAsGGSKwW7EqW1MRD6sCT9DiONyY/U1WlYxC+o
 QXkqEJxNgU6avyOnR7O+i9yrRuAa0x+yvCQnw3Gc5YON1J2Nb85CxpkDx2AwqMDO5M2i
 wguA==
X-Gm-Message-State: AOJu0Yy0+3yOTMRKIIxaPuX2V7iEiorL9dmDklEGoAmqxjptdRKofMUu
 Li0Xz5rXb5Ev8c9toj68zurUvHrC8VF4rupQqlhujc+eueAaqXHYi25jJdn1+o4=
X-Google-Smtp-Source: AGHT+IEbHpfWgp09vnu711xkrCF1iO0DAP3u/zPQq06CkB+u8qtTxnpbOw6vXdeJGGJ9FJ26O/4CGA==
X-Received: by 2002:a05:6870:1615:b0:261:119f:7560 with SMTP id
 586e51a60fabf-26891ea8fa4mr19764646fac.31.1722990642340; 
 Tue, 06 Aug 2024 17:30:42 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed31aa0sm7452819b3a.212.2024.08.06.17.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 17:30:41 -0700 (PDT)
Message-ID: <31c2140e-22c8-44f9-a7d8-a7cfdf7e590e@linaro.org>
Date: Wed, 7 Aug 2024 10:30:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/13] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806182346.91118-1-kwolf@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806182346.91118-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/24 04:23, Kevin Wolf wrote:
> The following changes since commit c659b7b3b4925f8cef486a3ee64e911519495782:
> 
>    Merge tag 'pull-riscv-to-apply-20240806-2' ofhttps://github.com/alistair23/qemu into staging (2024-08-06 17:35:51 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to ca1dcc913888a97073233dd9142ca5241dab1b7c:
> 
>    iotests/024: exclude 'backing file format' field from the output (2024-08-06 20:12:40 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - scsi-block: Fix error handling with r/werror=stop
> - Depend on newer clang for TSA, make WITH_GRAPH_RDLOCK_GUARD() fully
>    checked, fix block-copy to add missing lock
> - vvfat: Fix write bugs for large files and add iotests
> - Clean up blockdev-snapshot-internal-sync doc
> - Fix iotests 024 for qed


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


