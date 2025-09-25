Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D4CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jGE-0006a6-03; Thu, 25 Sep 2025 06:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jGC-0006Rm-9g
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jG1-0003KI-7w
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so620643f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796272; x=1759401072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GK0K3he9kAiZsqI6DwImOP7y3yjIf6254h5fsANVsWM=;
 b=NAurQ5TliTAHJw+G0fYxO/3yw4a1GQEsomL8hTNICVw/QgX4//N4anKFxM/E7ZMxxV
 BsixrVVhqudfl2jCjzOkW5DStrMSgufdK8zVFigaznrv8Uyk5KsQgFED500DXItNdGOl
 btJzvpl1lGj3lLPoOM8NQtdVZ3+5CdTSUU7kVBTB8v2BvvHJeaLGpeOQAobZzrYf65Xj
 T88IpdMshijrLzCdK8zGdDgulcJRuoYqFV0FU6FrGT7hMBVNEIGFD8j6aOyfdfuk+QIx
 sqIXP5RxqSH5x8ijEzvhWd6CrpViNI0GqHwRYfI0CqBmaHzRYFnzKQqDEVwpxxoVCfGq
 OgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796272; x=1759401072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GK0K3he9kAiZsqI6DwImOP7y3yjIf6254h5fsANVsWM=;
 b=HxVm4FOW1fcP0PB9SHNl6/KCdmbTcaPg1nOzPfnQ6i1+O1+WgcSI0Qpixa4V4tWtUj
 lvQxKIYdCM7ilBOFLVNuADas1C/ZaNcCK7cOUxAmJTtu8JlMWtujcDQxtjLo1NREMVIZ
 ba1pXuGwjVFmSP5MmiliESoPeGzl2yR0onTCvL4d/fhEL0JIfhAE30VU/n8NWS2Y41dl
 fBfMl9ZhSCHlTKNubJRWGZwNjeDnCO/clEU4lvjd4hFNzXj/vs9yJpCUwPKnbbqWN3Gj
 +ZZrxeQhhBiNzf3i4GY+n0hamgmsChAf6GkO+Wjx26qrHmeOPWfrTChCTn81JzXpKOt9
 eKtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIg33FViJOPeXQT+VDG6rnCvKpkMBC+Lk+9RyV/D48Joh0pZdhwnED1PGuO9MO+PuV7GZCevGzF5/4@nongnu.org
X-Gm-Message-State: AOJu0Yxm9Pkm3ZzoKgRG82W+NnWU45jx2jg2sF3N13PUULNmml5xEh0+
 kA7bk+XfUzhJUQZaBcgEPT6A8p7cOIyu0ywoaDZ8MmP3C/Pqu4sc5mdpmNbKCL8OBDU=
X-Gm-Gg: ASbGncs4hBCcQ5a4W/C1FTEkKBj3uR2Emv4us0fjqGNZsRJug0xmWOWoHYjD1fGFiuM
 2xn7XfYqyUgeS8netoV5rc8OqYdzl3abghzu9Mw5iWbaOehnNaJUBbvYVr5YIrvucIjaBkidR3A
 yvlrTUYST9CD9QiY9Z8zAg6R7NpkN1IL70BbctPeTxm1OeiHc96pf4tixjTOoF9NQoEKSe11CeI
 EhmPDJrK9v2cq0HD1UXKT1d9V0syq45LRrsSJGWkjQF1yRqZ3Zjg8qFZz+7j/HTejhD21p+oI+I
 sUQpG3uFkc2hXk8CfaDiDYtK3GHYgqF64MTUBd+vHykrlJtV+nHd8zVkEajJI8upn6nlp8yTzU3
 jXMTVmXdAwPcXaH4yGGdvyZbHPlHpmva/mIgWtv3pzP0tKV5ngIJ+ENGbpQdV8hqsJbJHXL9vMR
 oI
X-Google-Smtp-Source: AGHT+IH3Rsf4OX4bWm8lnyMggpZw7n7GrWr8F0BXsD9FOphgi0IhsmC7pfX5ZO4LHT1k1nDJOHcJMA==
X-Received: by 2002:a05:6000:2381:b0:3ee:1461:166c with SMTP id
 ffacd0b85a97d-40e497c34b8mr2791456f8f.5.1758796272399; 
 Thu, 25 Sep 2025 03:31:12 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb711sm2484562f8f.11.2025.09.25.03.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:31:11 -0700 (PDT)
Message-ID: <cd8a94b5-8aac-44af-a989-10b795434140@linaro.org>
Date: Thu, 25 Sep 2025 12:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/36] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Conversion between KVM system registers ids and the HVF system
> register ids is trivial.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

