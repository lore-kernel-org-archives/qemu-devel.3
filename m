Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484F0E9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDae-0005SX-NK; Thu, 05 Feb 2026 23:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDad-0005S9-5q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:37:07 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDab-0005Qz-MO
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:37:06 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35456fcb79cso954036a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770352624; x=1770957424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B/qHJuFR6BtK+Q/MKIP4Onl/VND9mtfwnwyE5i5qnA0=;
 b=iwkyjWZWeMfg/Ju6SdrgR9QOGuRGIqBemE66cwiFlk3dU2VHeGexwV6NUEoOoXqyNi
 1wgjDcSZCYxVhoNyAxdCr9fBJ8kOEhmi1VgUOA+B2HvKvRj1QzktYRVZ999dgYPvZigc
 VIKjqzXbl/KoE8dvwU6TKhQZpROmzpX9YV3XALozYbjCZb3BPLuTzs5EU5JdA9x5tQWe
 gWJazSxb30E2T8bvys1JX1nl8fT/b/egdtfrqyf3PR87e+HRJ6OoQxdiHcFzP9RSahPt
 D8XokTcEO+fhqivplBRRYBk8Eu2nUSL4Lf+qpZrQuz6sVViBVlha+ukR1ls1rLpSwSyJ
 Ww9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770352624; x=1770957424;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/qHJuFR6BtK+Q/MKIP4Onl/VND9mtfwnwyE5i5qnA0=;
 b=F16vSHpaElr0oPzx7cSAd/Gr17CIaji7hKlzy7o1tyLUTNRglBDh1e9YSscDXH0N3j
 VYK6d9tsBNdKI+E02+gY8GgqJmHZu1GSF+YuVDSe2ygrPPAc7FQtzZ6ub7lhgqrsyoeI
 yL8exhVysvxjKk0cixi7wgYE7byjqxvQNIjfLZBDlKa/8nJhpYOF1wcTsPTLdUQ6UyvA
 /uxStRNWyWruzrZmN+vFGEuS7UvqbSzklA8uvEwDhL3XupwdrMhyYWYmDtmU4Ske0xAt
 KHZsjlYMh4x79QwLf83pwrWNNzLvGYbJSUwfOP5DvcWLhylhOREUVpKXYLq1xfivkAnv
 s7Tg==
X-Gm-Message-State: AOJu0Yy7RLMWI4QlhrRIi7yF1Ww+QSgsH30dWB8IGyHfchLaCQUZg3p7
 2VZgy1RSwRB3o6ozfdc6xF9BnpuJwbHD98ZK6wHSf7D63DB2Pf2i5aPpXcT3XCpgFyzOohV1G0O
 1HsxU
X-Gm-Gg: AZuq6aI6EkeU+RSprGdRml8PA6wOU1BWh3zTLXN/YthdEg5q035TRgcI44aqJ5MLioO
 dWvtNZpfAXiXP4Bb+xq74yvczePip+KEU1Y7xuAnLHtusByZpEN/oP/nVreJhqdEO40UmzS59fV
 tcueoeJOxHIxPk9zw6AIvWHx6DjGA9Yzftfu1rR2du2GvJb5uoSejOe1GQVz5JFcgthPvijprgw
 o44l1gCdocB3auMzDQ2s5yVyVlz+b4PoeVNp4LrNoK0PTtqJQs0vyQC6OK0FcyChsLKOPetUpwB
 7VaqmLydqyULTr0utcNEjqXeTjYxT7xYBjd7+UpK81fahycbavtH+iS96DuxZNxy9Kg7lWVj1px
 34obr9z4fmqxIxB19DtvyKAJPq+UJP07nMekZgH9Sp2fdk6k7mR/PIOtAhE9LlpmOrql2deUr7j
 qDE8JeZl66TTbcoxA5kmCJGTvgQ9WV16xjXgwQGTuxocRsMbQ5kuihzS0K4yOF38Xr7qQQ
X-Received: by 2002:a17:90b:2fc3:b0:354:a1bc:f99b with SMTP id
 98e67ed59e1d1-354b3e15243mr1240673a91.37.1770352624287; 
 Thu, 05 Feb 2026 20:37:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b2eaaca0sm642544a91.0.2026.02.05.20.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 20:37:03 -0800 (PST)
Message-ID: <965a100d-aeb0-4e16-8fd9-3728bd8fc660@linaro.org>
Date: Thu, 5 Feb 2026 20:37:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/3/26 12:56 PM, Pierrick Bouvier wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Endianness access is constant between device resets.
> Use the field instead of calling the same function.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>   hw/virtio/virtio.c                |  4 ++--
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 

Oops, seems like it's not correct, I found some failing tests bisecting 
to this patch. I'll dig into it to see what is happening.

Regards,
Pierrick

