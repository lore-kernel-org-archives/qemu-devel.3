Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B82D172AB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 01:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmifh-00037j-Uf; Sun, 01 Feb 2026 20:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmifg-00037N-FO
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 20:24:08 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmife-0007F5-Um
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 20:24:08 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35305538592so3452787a91.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 17:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769995444; x=1770600244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hx4cmTVQN+6qWv/n8wq0nvraZkPrZcCcvw9o30vu5/U=;
 b=L0vUfXQoDqNjpQV3zOk+lPLDcrvJeyqoByzBaDzdQWHSMcLB7cjuzzRRTtZZVmLK+R
 XN7BTPKhUyai0+kQmcC5lw0uKEYKrUQaqdagqtcvHcg8fmlku6xFDiWRJX25XO0ic0mP
 2BThDwK4Z9OK4vIVov1XtNmX4CVFXf0UKPjWy/4emOa6QLr/xcXkZvCHP6LvSuiACdTQ
 8RXgB/PD8UX0ic86OyaBpAl5oPhrJd7AJCp6wU3UiKVadrJTY4xU1BpmrhDD6sOf0uNg
 wlyA+9hrSOp8sP+lLSdNNQ6hkSqEEP1ZcjTCK5rTm4KD67w+Q+vvhwbwIlCHM5m0IBAr
 uCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769995444; x=1770600244;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hx4cmTVQN+6qWv/n8wq0nvraZkPrZcCcvw9o30vu5/U=;
 b=siTj0kBcgxpfnxCcA3W3ImDpH9i/xrEkrF/qk1ajkVh0kE4BrQ2vOaeYXZLzTPgpZO
 oKDEHIWYmlOH/UIvTseFQRgGhOmKI306kH4Y6pCHRm7/sJmErmBDC6FS37hgYcucdNzg
 Ap7Jp1RbwviaYok/DwFREP8BLVgFpxmg35dJVgKFCx5PYjs+BjPlBRRQANDeN4eo8jsr
 Vmd18m6FO2DvJtH1M1Kiw1SpABcnJUVunuFlOF5iF/DMFaJqGXTikAsq06gKJ3+Tgsu0
 091fSB9brtTL2esnV+YD18fTl3++6Gzngs1k/4yRfFh3UD3lctLN8Urye7iHphs5Yie6
 kjbA==
X-Gm-Message-State: AOJu0YxOQ8HI7MHVoKw9uaaNXW5W46KawdBdYfDw//qLWMt/+W3QwZjK
 D+2Hsjdu0W8iHyo58o4d3en5rauf63z8FkUjpMVSaAgPs6PxANWATZWZPGPSW+LF/F0=
X-Gm-Gg: AZuq6aInb8GaJprwuXav9tTJBb5KA69VrS/K66HoAkmjIHeWBw1mITCYqvIieTJ+PwY
 6gq+X5ZbAJyrD3CcZcGsYZgD4Y+vvDbcFGvfZ/hVUIaeDew042xk1EbuZeEAPehNUszRolO2yTl
 Z3NPppl+runBZhDwvFCoMnul/m6JlwHTHZsbCbygaKCvk2UchNikzdJ+D6jppVSHoCOH+o5xTFv
 tbLghqzO/p0w2zVdvX1yyks6vS9YanWWZe9YuWDS2RlQOJxtgpIpbWoDj5DC3swZ+f4nnelH11I
 4knWVQerlCK2NqpApT27OLEslMUHu+YEypvQAB4Pn7WQI4PAxHtFkdkOgjrvzXqB1C3JGqTV7lQ
 2POlRG3KAymWZdmlNO2uBsy8ATsV7tEtV/UxQnd8jqApqfUOz9BqNHoyudoXFvPJkw03KhfcJ//
 qeGuokuPWWuKaEpHJQ4Na5YhHZ3+lMf3yu5tfgMk9Ok5w5XheF7ZDRgQHV
X-Received: by 2002:a17:90a:e704:b0:343:a631:28b1 with SMTP id
 98e67ed59e1d1-3543b3161dcmr11323190a91.16.1769995444536; 
 Sun, 01 Feb 2026 17:24:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3540f3ed0dasm13051997a91.14.2026.02.01.17.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 17:24:04 -0800 (PST)
Message-ID: <095a1def-1548-4764-84d2-87ffb642bb8e@linaro.org>
Date: Sun, 1 Feb 2026 17:24:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260131124842-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/31/26 9:48 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Performance impact?
> 
> the reason we have these is for performance ...
>

I would be very happy to run any benchmark that you might judge critical.

Should we run a disk read/write sequence with a virtio disk, or a 
download with a virtio interface? Any other idea?

Regards,
Pierrick

