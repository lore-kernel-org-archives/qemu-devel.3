Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78077E63CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 16:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk3PO-0000v6-2o; Sun, 25 Jan 2026 11:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vk3PL-0000tu-Qd
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 11:56:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vk3PJ-0003b5-Mv
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 11:56:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso22026925e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769360171; x=1769964971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1zEOLLwIHKsHu+Kcrl6K9wXm03RRA72WMEjVjBc2dck=;
 b=nNV3FHNFzq3e8cX5rKQFOJTPTtYm4Iii/rRnFBGZjRDjoEBBpTgPG5PDYizWpLORAQ
 A2dh+5/rseGrwx+cNvhrXD85vrk9apD+Y9fUjQZr2vxA1IWbvVy3NUB2BmmxEq2djuwz
 XQ+dosgCaVmgVUBv1oSjqG8VGWRVON7ZF2YR+KGFoSqkB/U3WJ5JhCgYPxJbWf/HyQIa
 8nOjUcshcHbBjBme0HHWu8KO1gzQiKePxraLRv9cvfNMUy5xLfsSnipUBDfDs23wIn8C
 hYvhlk9iCPrKWlGpl6ebit6hinZeRt4Qc2QxsMzCElyDKn1S6YBXyd2vMSVEAlBlPatY
 DeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769360171; x=1769964971;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1zEOLLwIHKsHu+Kcrl6K9wXm03RRA72WMEjVjBc2dck=;
 b=kbX/lxF4fiD9CTNljQ1ip4IzNTXMpzUXGRM5ktz8ecpQL9gHglK4NVlqzJIqa16yZM
 Ozg/OvR5Wkq21Ly2LZ6mg5LMcbhK7aezuyXAmB8gshHf3Su/+wPMtQGg+keXDgUARL2/
 qhfuz0iYxE7lhnyOdZJCDM1lQSORjfHm7E48fUPsZ8cY4PJSiOmwpwf2LYJfY9V2eJuT
 3ORtyogTukx8omL2pgB5Ck9RgvsI51jP6t1+nRGpKC5XBNx1KTvklemLkm2MVz/iIb91
 I1L5PNmDLDhAT0fw5G53U9mca3nnC5dAtrFOWQKcTHUNhE43RrotEPn4frL/KXRW57iX
 JnPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5jbJO40zTVObm29VB9fzpNcxfDF2mun2Nl1PMkaKRbsfLthAHmlSISsPZcHmnVB4iT4z5NpXwdaQd@nongnu.org
X-Gm-Message-State: AOJu0YwHRevY63jwHMTFWhxEU+y9mXZXDO4JeiQaWSe58LzsLwRWqhy7
 3rB2DEy3O5aTRtSV++91Ndol2LfUpZmhqCyZGa9eFp+6fdSeji4lvS6KRk5rYbr0uvk=
X-Gm-Gg: AZuq6aKO++D5Jmb+JTnw2eDYsOK2esmElT9oOKTD3mJ2JYzriaOCVvZeCdwX/9kJkQf
 TFpyKG8extag6oX2xOah3CnVre+MqGH3sjcIZ+7ppjw+ducI5Yrtb6k7kUEhKpUWPJ4/syHOdQj
 3kMnVRPoO7n/KdvaHfuf3VT7W8yeM7DQcxsTr+Z51WPX2fE0DH4kqb1ucz9JSjGlxKAOfLr0raK
 l6L0ojSRwKand+ut1VY6ewtKeDXKLQHm86cujKIYLVlzEas0apPIJMBhOB5Qt1uoXpZH427EHzW
 2f6ggDDj3D3fWhvNL0nQIGimrBnp0BmKcDTOfYoqu17XtX73BNyDoj7NPfzR71lUHZqgATgbTGI
 bqDX4NPSKVZAq0Z6vUM9sa2Icr05j1y1L0kQc6On0PYZRft1uCLy8gYoIB/DbflJGi4ewrFHGyM
 ub1/cYBC09KogqujdSbqi2tY11k7B9jlYW+5gJf9hoiy/qiOsGCD3C9A==
X-Received: by 2002:a05:600c:3e18:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-48060ad816fmr6474525e9.0.1769360171221; 
 Sun, 25 Jan 2026 08:56:11 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02cf6sm24284939f8f.7.2026.01.25.08.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jan 2026 08:56:10 -0800 (PST)
Message-ID: <d74ef37a-b423-457a-b2c1-31989243b1a8@linaro.org>
Date: Sun, 25 Jan 2026 17:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/nvme: Fix bootindex suffix use-after-free
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 25/1/26 07:42, Akihiko Odaki wrote:
> The bootindex suffix can be used as long as the property is alive.

True, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But maybe it shouldn't (we should g_strdup it like other QOM fields).

> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/nvme/nvme.h | 1 +
>   hw/nvme/ns.c   | 7 +++----
>   2 files changed, 4 insertions(+), 4 deletions(-)

