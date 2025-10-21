Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E252CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBC4j-0000Xd-IA; Tue, 21 Oct 2025 09:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBC4g-0000XH-Hk
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:06:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBC4e-0001Nd-1C
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:06:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso5175308f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761052006; x=1761656806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SS7QWqkYLFAeOIFoWBxDtZ8ohlEoQkTk9jxgZxNSEyM=;
 b=WpOD9xDDlfT6aJWa6RGStC3xo39ehMAKB9P58glvCY8rB1zutAcLzcKpSCok8eVm0z
 BIQqZDsOY1YnQ+fwqoJJf33fzpWiPZfsJVrIs7Yt4Rs/9z1xs/qKAUcDOhOGls8VKKyq
 sFDF/ZXvZD9adLGv6ScihjGa5DS7EVPFQUdBAkqV3PEu2JX918s6nknbrIjTRD8uqQdq
 QqpRVS59cAEG3UV02dVKYcgefH8lPGpyVk0gXDFpwlXpCE2zhjcS13aFNwfDqnbQViLe
 lPgzby1AwrrlL8jsV9umtv3mS3w7+UrK6ufHLsYsxudjTlDGI/rjpmj5029hmhrbQce5
 y09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761052006; x=1761656806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SS7QWqkYLFAeOIFoWBxDtZ8ohlEoQkTk9jxgZxNSEyM=;
 b=lzkVx4yfsO8Z5xWtQes51IL8BdVveLXXMUH7LVrA9WTUqzfifbob2EHxM7gEv/UoI9
 qI5QB1aEAbik752vcLO+bunEt9JMdARv/yuOgMEsbwcKG3Zvtv0oE5b7VfoT5/Wp4k7v
 SbbV/Wf65369mvrti7cHehJU8Ol0A1HTFDpOXOz/9t5+HpDD+PmD6yn2GIjtZ/HGOKOM
 55K05F8+Rm7rjv35UPEvoFuaH8t3DcBhG16IubDXp3Rhpav7HrXn9wcQLN0dX3VUWGc3
 cDiXhevHav5ncKWWdR0GXMpqlvyZvPWgkU2+XnRG9q324/oiVaDLVYK7XKZYZNjIF3C/
 aO8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKJdtnCd0IqxcRH7qmRtsjQgGXMp/0T5LuGfKCX91iZQ4K6QWfEiPTe1UjZ15xqEv1hcLQm3kzzyhD@nongnu.org
X-Gm-Message-State: AOJu0YwRcioH9dmWVkrg5PxYsPCP/TcjDIgA9bzaPUABr9ZJA01rRUZ4
 K1HrUw2ZJiKT2NkrgVic7O/a82n9y3ygIYbDwJKUj059MRcOEXyZZRn4jEGibZ3ipGw=
X-Gm-Gg: ASbGnct7P18dKzGFETtq9hd02x5xVCnNW3AAaLBtkmfrhKgWrDkSQMVEfvbEsOLcgSR
 J44QfPmhk3Zf5jfozVUinD9gWvXa3lFxezUOpKxmzd0+GrncGUTcZaoJIi4fde0LvgJJneSODlt
 PgLkYIE75TeZtObp21IKmv2zKyTymmbxgFDgV8ez0PbdWCv5CbNFnU8xpBtuWmp/W8vCgLUbRj2
 FKPxgbdQOras1CEbONllQJ1sWeKa2OAlVKLsBVsEy6Aqe+WT6itCYVWg29YgfJl0k+z86+z3QqC
 SwPX1QINl25UkMJkcHlUqY0e8kI71AfnkfCSqZeJbeVkcC8YGnjrAkbVMvtS+zDmFj4lR+YaGO3
 9rz9L6fSh85LawqPDQU98SDyESAnApR9AoZAeqZPDSACZSjWIuCbeIxc69A7/vv9Chc8GKSfXab
 MW7PR9RtfwZmkN1dzrDauLbpe8R88n3uXKKTQrMoaI7ikD8jZsCSZ9OWKri2Fnfy1v
X-Google-Smtp-Source: AGHT+IHU0JoMS0iXssXhN/vFn0qGO4hGRwLqx52lrjIzIuGPct7261howdONSa0QZP79UQAmDGWAqg==
X-Received: by 2002:a05:6000:41f7:b0:427:546:4378 with SMTP id
 ffacd0b85a97d-42705464602mr12599115f8f.20.1761052005814; 
 Tue, 21 Oct 2025 06:06:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce178sm20229059f8f.46.2025.10.21.06.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 06:06:45 -0700 (PDT)
Message-ID: <55f5736b-d51e-4e32-afd5-4a01fec0f9d3@linaro.org>
Date: Tue, 21 Oct 2025 15:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/43] hw/audio: improve error reports
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The -audiodev argument is 'model=..', use same terminology.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/soundhw.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


