Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB96ACCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 17:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGSg-000632-8w; Tue, 21 Oct 2025 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBGSe-00062e-Gq
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:47:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBGSc-00064U-Aj
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:47:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso63159885e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761068868; x=1761673668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ZJ8rn732TfJ48h7DbPKX97XzS5mXFLtabG3ZNCjuP4=;
 b=sXt/YzJ8MBONBfSPjDMLOmadd4baagynr96vb/Dle7rYYzmekHWznI7xsyFT6b+1I2
 WytPrPmEJsXKTLfNeGDge8WDqr8Dy6PYEOxbN4gfbLS7q8gEKbCLxzglbwhU7zTT4Zqi
 t/V8aRsIkubq1QdiHwahYGbXzkqbmjG2GXDpg27gIZCkckuZINewaRSnXxW+knjqzSMo
 aMhBWj9xQl5t0qQdrkEyEA4Y9V4r78sptNo6BAVoPdXApOvA3bqK98pskpv6zbNOWhFL
 86U+IkG5PLTy3p4ClwyARQAeSIZPS23O+m2c9nZQI9j1B9o5Y6SJABwItE8mSW1o3jfO
 a+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761068868; x=1761673668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZJ8rn732TfJ48h7DbPKX97XzS5mXFLtabG3ZNCjuP4=;
 b=XFZQVS+DtU8ZcrGYlA5cHaDh5zsFOjxWkjjFAsWCtPu3vScYkmvu6CPs9ExYKTJ+gC
 jWo3XBL6W2zcblcSGQW7WnTQqEjkQY6B0MY1tc4HgUZdu/RPEe4gEueZIwgyZ5RYv1yF
 SvnK83QIqNtca3P6O8OYB03z1aGP3mOAfDnudqgHjTUtPcpqOiHCLnlAZ6lwcrb746aA
 ohRMRpIsjDBik+hHeMzzzaRDq6nqozAGumU1SBzI/YB5AU1vESiRiQ93YwnrDpT4ShfH
 bulpYXhbKkUaVkwQfTSSr2R627Jitvv6XTn6bex6U6EG7SkcyCO8j0Eh92/7NPr0r4V3
 KMXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvbaUZuHB7AG+etGlFFpbrbamXaHV5cBmoVcpQjC4hiXm0xTnv1uG0vof5W8tDbpeKxj70W+pl5FvZ@nongnu.org
X-Gm-Message-State: AOJu0YzKfSp7OFf0RuxNNDQ+cywWhwqAsdE8u72QTy1aSlPbenJVKojz
 G9UFW5iRozM+dN+JkC67FYmqzSAk4dtAUKZsbqTs+LZ/qFx2vvpdRhU4qqL1XyPpTzU=
X-Gm-Gg: ASbGncvWskIYt9Cr70sGrsZtCrZLnK9hjDwjkTHNaS+3DG1JEPWH6C6pDplHKcu2q9w
 5e0uxRSR42sTPTf2UtiIv1DSGJr6RM9RnHbJgjsauwmQh2FUsNGEeD9zWuZjUSZk+hRBB2M3jHN
 ASQkAvf/aG6AJvFRh/M2zNFK0Ku0fZfXfE6leYrQbK08GIKpuMnlcSVOR/4deE8R7szVkTvwq1V
 7trdsiS49gDhoVXa05NAWHBDSbgoc5+BMbf5BpX0ldAE2nYzjyQoKZwXD7TxAJfWj257C1XBJAg
 49RyvS8FQGGzNGoh2M2QFRhcRwuRrq7Xl6OHjU3pTbvIQVMx5ic73z9S/bQaErjSTnSDr0m4HTf
 PG88Ctm5wQSVOkEZ4hKeUBeA6wZiI5Kv7aintw//D+fWgwQ1/KcB4cafMYLp74yLF6y4PaXX/eq
 w8F5niIDlQWC746W3j42q+jkmjYxZ6O69mXQlAwKDFDAS18xt7d9JUUw==
X-Google-Smtp-Source: AGHT+IGwq6zPPsmpi+85UFxOUfl+mAJusQY8JfAqDTkS3XMlTc9nnZvIYzRNzlsASpYsWf6ZWsmRmw==
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-4711787c803mr130610815e9.12.1761068867983; 
 Tue, 21 Oct 2025 10:47:47 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c438caeesm2912855e9.18.2025.10.21.10.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:47:47 -0700 (PDT)
Message-ID: <ea52c490-e99e-4193-bc05-059b02f5745e@linaro.org>
Date: Tue, 21 Oct 2025 19:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/43] hw/audio: drop audio_model.isa
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-16-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> That's no longer necessary, the code is bus-agnostic.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/audio/model.h  | 2 +-
>   hw/audio/ac97.c           | 2 +-
>   hw/audio/adlib.c          | 2 +-
>   hw/audio/cs4231a.c        | 2 +-
>   hw/audio/es1370.c         | 2 +-
>   hw/audio/gus.c            | 2 +-
>   hw/audio/model.c          | 7 +------
>   hw/audio/sb16.c           | 2 +-
>   hw/audio/virtio-snd-pci.c | 2 +-
>   9 files changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


