Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9317C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFc5-0000sY-NR; Tue, 06 Aug 2024 04:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFc4-0000rX-Iy
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:32:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFc2-0003RL-QF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:32:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso31664266b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722933129; x=1723537929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ndeah8Hsl3RNYQe3nX7X8qB+X5NMguLIAbBV4kQ9TPs=;
 b=bsTEWTteiJbG+Eefng2v+h/+1iQhmJZdVcuOhLH/0tESGWkHy1bDU8SSB5xrwst6Hm
 M68EeLG5Sxj7sSiylxwGStwsnO/Kj3BH9M6C0mjosGq5Aq0NxKneo5zIGK2uXTU/qVja
 DbKBv4JiQ/HvMCe180v0yu4heegLMgeH44eEVV1llbazSKxkV2WuFMV8mXylv89/8UIg
 QujIyqCh5fwIq3gfu/iz7fbdkrQypRO8TFVFLG/htnTLOfdR6u34FPx9NPtz6tqzz3rW
 NGGSyGKRE6aG3BFSdrBoTnihlAHRElvsEr1WYLHS2PHYtNEohHz6eEkVW7poh9iQa61d
 eACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722933129; x=1723537929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndeah8Hsl3RNYQe3nX7X8qB+X5NMguLIAbBV4kQ9TPs=;
 b=Ff3u1Y6kva06K3YBv8ruLcfhUXHrGrxqWjn/vYW1U75hgKrCRmkbB5LUL2e8hIRwmY
 +rjIQJjRC8uRam8kvDYiTdVi8OcBfIsw64YdS5U5Gl2jteuzAyb+ACUzsiTTzXBc766V
 7ujbKD2YGawhA4Hl4aGcEXzjXqTEQrZeOFdMntu3bNeygm6Az8JhVqw9C+jH7mwRLcQd
 A/gJ1s64PIJFurDnPoY9ZnwdgoIz1Uc9wayH2tJ+xx4Q8DpFVUCqb050FkwulwKnWbaA
 47e0KJmwAHuqykWja33NtcoSVVP7u9/3XYlBHOEjLfY4noKe8jEdxvK/hSrKoPeZaSLz
 sREA==
X-Gm-Message-State: AOJu0YyqmIPs4o73b0YTkFyPY7KQkZ0hWQEredaZwN4GVB+EJpcG+bc5
 QYN2PcUM4GbelkmJh+QdVDxAOXFbH7KhLdyb7WUw5UNqBkV+V54ncU8+PTdhGELe+YCafX8xWSp
 I
X-Google-Smtp-Source: AGHT+IFf1C8HcSZwtls9zANLVt0mQvV9rlXU7WNRbdzE+FJbSfB03FWkgy0KU0fWHKNfFZKsxiXgLg==
X-Received: by 2002:a17:907:2dac:b0:a7d:2391:6037 with SMTP id
 a640c23a62f3a-a7dc50015e2mr1006266166b.41.1722933128849; 
 Tue, 06 Aug 2024 01:32:08 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4520fsm522214266b.110.2024.08.06.01.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 01:32:08 -0700 (PDT)
Message-ID: <ea16ae81-a003-4190-8d7a-af6d7bf79e6a@linaro.org>
Date: Tue, 6 Aug 2024 10:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2] hw/ide/pci.c: Remove dead code from
 bmdma_prepare_buf()
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20240805182419.22239-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240805182419.22239-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 5/8/24 20:24, Philippe Mathieu-Daudé wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> Coverity notes that the code at the end of the loop in
> bmdma_prepare_buf() is unreachable.  This is because in commit
> 9fbf0fa81fca8f527 ("ide: remove hardcoded 2GiB transactional limit")
> we removed the only codepath in the loop which could "break" out of
> it, but didn't notice that this meant we should also remove the code
> at the end of the loop.
> 
> Remove the dead code.
> 
> Resolves: Coverity CID 1547772
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: Break and return once at EOF
> ---
>   hw/ide/pci.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Patch queued.

