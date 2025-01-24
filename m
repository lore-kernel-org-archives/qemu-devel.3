Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED3DC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIvs-0005pW-1d; Fri, 24 Jan 2025 07:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbIvo-0005ov-2G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:37:06 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbIvf-0003Vh-8p
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:36:57 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e53537d8feeso3083716276.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737722211; x=1738327011; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i9IyTuvfWV6nrzn0/6hPPMStLrQF7NVwMI61LXskvJo=;
 b=KB+n6o+wqWzVMgK59Le2xZBdAJXtkEp/EtFDhFx9V0P4PObhanqdhtpuPBXiC3lYbG
 MVG2TwFYju7qEzy6DTzrkbb6goIafjHDGJfS5ZbzDlYaxpjLMm1AU0fwC/f3ng3jblKc
 L+Ug9ExmecdoLERebQhOYbUqPZgmhPIPZg73lHeN51yVyL6F0utgSuWTR9G6SxS71/G8
 gaE16IBzGajpDBRbO2AzwmbrGaFgBqesnjUHSZ4x2sOK54VOjGsnWLbzbq/dswGHYkjE
 O/EipehgWJdCnR+h7kw3O2nO/EtCMubMq3GWXKo7okaRPvGvbyQNVToJ6D/QbCLRafvc
 f0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737722211; x=1738327011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9IyTuvfWV6nrzn0/6hPPMStLrQF7NVwMI61LXskvJo=;
 b=UkPcnZiJhmXRjnAyPvWbbJ4u6GW1FwDdQzLhpL5kn6ug+iZuUhxMiK5IJ/ntEAkHeV
 /fxlb9D9jJwPbXVICi6M51/8ieFzoGBOK3jTrsJd7Lc+jhJQtVGP55mYUlX9dRlhMYzs
 /1nlCCXwWLTYusfjC8lePbpVvbWRok/Awrwfm4PHEVbdZyE5qIV5nISihgHPuGcddyoe
 e99Q9rfi6t/X8sI1xE74F5MI+WyuJCxV1vI1J9zdIDzpVDwi16ocH68ob73fLbBDfVpp
 TAZiW0UujnsG0AGkVVOb9GuP/8pniRBfB2VkE2sXYotnfprQduTOcHs9jYvk5txc9rv7
 jGzg==
X-Gm-Message-State: AOJu0Yx95Jcxk0dBDORFYzhmBxAvPMyEt9nzYnpzLvOVJQNTppZW1rUA
 MJipSV6V8X3x6qIQKxhHJ0Wld/LixBfTo1t/oniontt7zRM6igDoz3LFF3hSstMgwYHEog0lCLm
 vzrx7N6uERvmrGAyP5v/VpQQhhLUsmUy71J4MMw==
X-Gm-Gg: ASbGncvpGqwEHf1csag32HZka37ch6NHErq6gdnFMxi//uJTFC/X9IrdQqnexA05TaW
 BjWPEGTqpkHkUYiKeS5dYeVli2+ej6PrdKkvVQz0QfvkSEVmB8NHSch4Q7uz88go=
X-Google-Smtp-Source: AGHT+IHgqTJCnVtWXRMfG6DbnLahWECSZwmxQ0G7p7sKK+jPgwgCv1zqPh9mXpwXFKY8Xiu0PKAhIVgs4Vq+Ps+P+Vg=
X-Received: by 2002:a05:6902:a01:b0:e48:7efe:57b0 with SMTP id
 3f1490d57ef6-e57b13516f4mr22191149276.47.1737722210665; Fri, 24 Jan 2025
 04:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20250124122707.54264-1-gerben@altlinux.org>
In-Reply-To: <20250124122707.54264-1-gerben@altlinux.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2025 12:36:39 +0000
X-Gm-Features: AWEUYZkFaA_YZEG2mBqIFULNQe8TjEpJOi7MZKhiQVdcQMgtJKfMQEYLWYX3cTc
Message-ID: <CAFEAcA_M5e1YWwygwM=w=EN4qP8TneiWHhDYz19SOrFCxqsP2A@mail.gmail.com>
Subject: Re: [PATCH] target/mips: fix possible int overflow
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org, philmd@linaro.org, 
 richard.henderson@linaro.org, Dmitriy Fedin <d.fedin@fobos-nt.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Fri, 24 Jan 2025 at 12:27, <gerben@altlinux.org> wrote:
>
> From: Denis Rastyogin <gerben@altlinux.org>
>
> Fix possible overflow in 1 << (DF_BITS(df) - 2) when DF_BITS(df)
> is 64 by using a 64-bit integer for the shift operation.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Reported-by: Dmitriy Fedin <d.fedin@fobos-nt.ru>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

