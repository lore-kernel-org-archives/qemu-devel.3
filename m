Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C3BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsQq-0008Qw-1p; Mon, 18 May 2026 03:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsQi-0008Oq-42
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:30:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsQf-0007U7-8v
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:30:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso11809675e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779089418; x=1779694218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ib2mc75U+oqgPinssSk3d6erhZLBLe7cBiii0+DCosk=;
 b=LwvdzEAxLYtOKuy7a7NDEU1eaJ3/5pl+duRYxFwVIOtsbDBoIh2wwcRb+V11z7y0pv
 Xwyda6pL+XNQXXoezm/Z9kuzO3LmdIwuf7sawwwYuK7/ODsq7JUruBxyOhnurSb8Xnq9
 WoQUFke/CKMvkZb17fUNbUB8d9jDsb5hKxxQWReK8/x91pdRxk11zyPpHS4kMlRXRNag
 Z3RB4FtKZPJpHnAA5U8rtMCjrLd0yesDABGylUWtQmUMxaIx7vyPseOaaIiNmF035uV1
 Wj9lDNuoJofWKEc4Q7wuAXIlGsaSF2ehisxYdpC7MC8GLyyBbYdsYmhbNhEBKxP4vDKM
 wBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089418; x=1779694218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ib2mc75U+oqgPinssSk3d6erhZLBLe7cBiii0+DCosk=;
 b=qyXJp4yafgvuEXlPbnhQzrTq/7pEzjMxT8XC2um0ZkvRCYAxM3c+y6cDVaAWxSnGGw
 JtlGewkwonGw7DfFJDrjYkxJY+ujcrSw+SPaJfvCjmcudDFlDVZNnfYKBxB9D2fBoke2
 9XtpsTM7ZULhNgIcvH0QirzsaNUIyAK4QdAjD7fyv1+SVq8t5KUUzEsFibJvCQ8DmEJh
 gLTUdSDhoot5UPHNHhp+IVA0ojeSjLkWMxFUjgQX60Lsmfdng5jMCRhmrgIcOaSJF1Ao
 Szf8XK7thiBEHHAiitE7l/Kip+66B5QtmNMMMhNf08UDS/XLPKGjA8yNQWnmgX7eHNsn
 G3fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ilqfq8R3agkvVpfVEXUBLMxRZsmRV95rYfziFhAwYiKipac1iATjt8uJRpTwPPGLCC46V6Fi/66ju@nongnu.org
X-Gm-Message-State: AOJu0YzgdSlvyvNxKQHG6g09hytwGxgHDc3DIo2XKYhl1ROIzOvsEa/G
 PtUGGm/Z+g9zdzmqRVSyUDpikVcIZJIPRBIocNaqTRQ2EsmaO4yVRIAC7f1uTnY40w8=
X-Gm-Gg: Acq92OF2C9d40YjWrvqalfoG3AnxKrIUvune2FvZL0tKXVqFzZX26SpdadPyu7I0XpX
 bzS02BWU7OWcqeDJGC7U1hzj/QbHs2SdIoiIUkwVC30gXvsuHdAuNKzaj59uLFqEOmID/Unpaar
 +8e/Lf2KKxBHvgtm93S1ndnrn9CDgWZt8Z+lROYmtxxgkEp+D/pzSLMG/VB/t20MTZNgLI4nYz9
 HHuoY9utuhdpbukRKnkr9uZ5BNBLwimVlT9i2ncpW1VrOGZ3oC2+6Gmk3Fuu/ElK6XaYdRomemd
 nK6IUVKjViKewVkTuLSoV/AGsi6hBWiCUr0c4s57BE/HJjREIUzBbkWgLw2NXZ0TLiYHuyqmAEw
 2KM2uESYEfhbzlmf5cxGNiIB3tHK33tCpKC9Q+UKYuhKWR7iCrGwT9P5CB2yAu0N4WEUlKJ4QOa
 ZSbxEXJEbETIAKKPuG/TkEAMwRHVFNQSrqEZlpVfWPj60MUq2Bx9Zz8Q7m+MUf6IPHvQ==
X-Received: by 2002:a05:600c:a414:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48fe60e3b83mr183742745e9.3.1779089418187; 
 Mon, 18 May 2026 00:30:18 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e6a135f0csm16584707f8f.27.2026.05.18.00.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:30:17 -0700 (PDT)
Message-ID: <b1cc2c4b-bc94-48c1-a84d-f4a574d1016a@linaro.org>
Date: Mon, 18 May 2026 09:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] system/memory: constify section arguments
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-3-bdf61e57c1e1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260504-rdm5-v4-3-bdf61e57c1e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 4/5/26 14:30, Marc-André Lureau wrote:
> The sections shouldn't be modified.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/vfio/vfio-container.h     |  2 +-
>   include/hw/vfio/vfio-cpr.h           |  2 +-
>   include/system/ram-discard-manager.h | 14 +++++++-------
>   hw/vfio/cpr-legacy.c                 |  4 ++--
>   hw/vfio/listener.c                   | 10 +++++-----
>   hw/virtio/virtio-mem.c               | 10 +++++-----
>   migration/ram.c                      |  6 +++---
>   system/memory_mapping.c              |  4 ++--
>   system/ram-block-attributes.c        |  8 ++++----
>   system/ram-discard-manager.c         | 10 +++++-----
>   10 files changed, 35 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

