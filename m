Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47598F4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdF0-0005wK-AB; Mon, 09 Mar 2026 12:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdEy-0005tA-0i
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:13:56 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdEw-0003GN-9D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:13:55 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-505a1789a27so69584001cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773072833; x=1773677633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zi9YZw2fNlAvLthkVGtsKX5O06s7V1xGEuBilebLQkQ=;
 b=B7/A/PkTqyQUZUkGfVSmBr9vMw2HYiDsTmcaoJfesysuMgJ5a13PLC11aRYDdnQ/yp
 uf6H4hvamb1GS70i3MKy3aOYkfsCfOhumowX+eBPG7fTHM7F2NwiO+KRfOmrC8z5uvzO
 b83Cj2umXI8sY7zSLvxMa/ZCSeeNfhoy3a0wuMqa2+Gv4iiKuvQImLjYpw5G8LERVd5i
 TTqYe9RmEMJZB8fA/sGgUWo8hnFsEKMIAkojcQePVCUYPvLfsgzGC7tuXFdrOS7yt3z7
 M3ue0D+d151e345Vzn82rjpWDK3/rWrWZLQ67CM8fsqRafx0W8ILPU853HuS3koXZLJe
 C3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773072833; x=1773677633;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zi9YZw2fNlAvLthkVGtsKX5O06s7V1xGEuBilebLQkQ=;
 b=PYq0d+mTQGrslRUiyhpBGGWxx5n246k+e7NT67zBPy2ATA70zEV3WRwY8esggHgUe0
 sxBGqSl9jw15jrkr3zieq2m/OQw6f3TaGjOhHs5hh94sx+nE6mQ/qmTOC4TiR0snSRHf
 pcoE0m//zDTxz0PL9K9imW8pfwsl8Z8+zxSjRZBy1FJ4DQopA+mgmuo9MFNNwDuEx2Cd
 ejSn5es5VYKuctF6dtDAGQ5SjPNfKpovLvXABsmHBYLKmudNn9NVMZlFDsOaViUNQCzY
 6Nr51Qz3NS4PMat4TFaFiMD9tGmPZBSPpYwp10ibkGjD8/FJzcl//Lute21pyVNYeSfA
 GtyA==
X-Gm-Message-State: AOJu0YwXkgLJbqk50Ncex7Do1nXiE4xJZncem7hQMWeWMnJW0FJoxVOS
 jchisWkqv+S3RuI2KZaJ3sewA1Xvp240pLCZnI3oKYYU+y7LmEzkGUDwi2Z8/TrQJa2W8hfy+lB
 Elxks
X-Gm-Gg: ATEYQzzERjUvR6WN9c7vfsPuhbdA5mDO5vpHje+WCA58GnVqfcv/GTYgXIphVRShzvv
 x+zkgJ1ZZzPjZf16OVnr4TT0x/iT9ofDHWmjwFeC3iocC9oOEm29tQDm6yaVnSeOmT6upJjjQv8
 +Sdyd4cVuRasctwZR3qo6VylEPh0ZookbNisnRytdeEzNT5WDHHGpWtg8HF3LCbnxsKQmn+JdO4
 JQTvA9qqcwgjb2yvK0vDsYsr8FmMxZpVFSs1BiFQKbhGl8m8zBFXWZYNYIilC29n+nsowffoEPp
 KRNK+BMbXfoIAwgehAyySe0ZsWqHe66zi4VwmSfXEdJpZ/AjmbDKWVF80ZrWB1hL8InWR9xsHmU
 072fiuSWdHZ2CPIP2ZB3UypKe3PXJ3jlYLt6v70X70DMTE8WiSkma0kGb7dqN/b1oRynz8zfvpH
 vxLTXqQXY2zVqYf8ajXsKQ+pnHU8WVv2BVgF9J44S6RvHh6Ebw9E0+4BQglgLv/DJygUxu
X-Received: by 2002:a05:622a:1456:b0:509:219f:8e35 with SMTP id
 d75a77b69052e-509219f951amr20494741cf.42.1773072833072; 
 Mon, 09 Mar 2026 09:13:53 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57a538e5sm987706d6.21.2026.03.09.09.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:13:52 -0700 (PDT)
Message-ID: <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
Date: Mon, 9 Mar 2026 09:13:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x834.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/5/26 9:15 PM, Pierrick Bouvier wrote:
> When using llvm-addr2line in replacement of addr2line, it will output
> zero sized symbols, which can shadow other binaries depending on where
> there location is (happens with arm-trusted-firmware and its different
> binaries). Thus, those symbols.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 2 ++
>   1 file changed, 2 insertions(+)
> 

This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).

Regards,
Pierrick

