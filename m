Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777DBCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8zj-00047q-LN; Tue, 21 Oct 2025 05:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB8zh-00047P-8t
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:49:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB8zf-0001vW-IX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:49:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47495477241so5765815e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040165; x=1761644965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxsoay4HCzhiBRdkJZpSgZ5muvUN4gGA/uvE3ytVGyE=;
 b=SBxvS21MCtURvq6ULOlVdOQW3OY/cYlm38Zom9wa5iu/SASLCpmUTRTvgsOQqELnk+
 wiPG1K07BByKUbGyEwY6WhkWk6z8eX/StrEuZdb0tUZqSpcPQTyzRKEQ7D6o3UXiVqUD
 HaPGsdPISbn1LBwUFQNCMlUk0mTm8I1y51CsjcW3yRY+jb3tBIgZwWf1kvGNkCB4hXUs
 +qXqAGhXMT8rvnzUch+ZqrpOWNMKqPmxiOYIm9JWw5k3RIbaiYEAr9s6TNARsx0RYjyz
 scHVEY34fb2AQQiO7H08cKzzI7REWDcc6A51nEE34klCGZvi17C0XKxsEP+FPwq1b1gJ
 N+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040165; x=1761644965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uxsoay4HCzhiBRdkJZpSgZ5muvUN4gGA/uvE3ytVGyE=;
 b=RY4zgyCVL5umAEibLazSLBrLcfxYLm2V2JxTBAWw+9w7f1M/JIj+YQjqNdSvPc4kQY
 mktEYQfy1nOn2QUiHXoWtpQIL/MIjYeTTFgO25ZJ46uGIUmevhBQr3E7bJrtbvTtx1Cz
 2asneGMfCqvRUVC/twUVVTiFgvJQPOjvxx/mOFFW5vpk0PQmIA8XCq7GRW1n/4vxSnIm
 M6+RIFBHJNmFDeqvjSWrmVz9/twHsCW9yDGNyAiV1Pyb1YUgvujOhk88BAPUTuYFqDIf
 YIeFBmqPXal1+K7TjuAXvlzBS1//FTMS9VNBIO8bRK0ZcrJ5DGjLW1aiguWFah+ohcLu
 2uOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsYSYPdhlnm11Cjw/r7oGs+tWvMqIbISFpH5coTQVhTEerpKUpYoNQ51ocIpzoCg8jm8P59YaRd+5G@nongnu.org
X-Gm-Message-State: AOJu0YwW4cNnk3RDyxgAaghcVi1RALKxmmEplCmtNve53fiN8AAMikVU
 YD1O2HIYVIKhtNL4AN3N010p57QddD8izTELjzvPdDDXSDJIyOfbN2h/+e9bwERH57w=
X-Gm-Gg: ASbGncsUVGvVu5VIdnPIrb3U8nSAClCrkmGxVNwygRbV1uGeR6iw3kV6vD/5E9x5L95
 27laOkVGMUEGtlHyrokDC77oq7AvsbWSO85xzW44HcS7dEZFP9fVyQK57j9f4U3Bjox8WRddNK4
 h6+nSS7bVwCSYqb/zOOGjtnXJMFJoOFBdt2Q1JVGC8wMvLrfOXIVs1C2Vsr3ExJxkZlzL3EdFQl
 PO2S5nh2bDfUw24KRSZGMb7KS4hybvHqAoFPTG84x/crJQ2ui61k8PoQfuM5/QjaQe3Xktp9+kV
 o+P8TBlhvWu2BAjtbW9O98lE0nT4YBILyAe9by9dW+BbuUefz7IRJC2WHaw+8tvEyKkQwNmNT+B
 PcmxP45renfuYGaLmZF8gdNshNMTDwrBCoRgokP0lUIgUzTgAplaI1nusjxyE4utOw4e4K1gKwY
 klqX8TvisNP5BaCxLVSTvsfrrsUNjppdHv+VxazDvubp4=
X-Google-Smtp-Source: AGHT+IFNMaTukQ6dC4ZrpBMRNENqOvSE714Vv5iK804eCNIZTB6B3ldn2srQApiwwNBqgWrfWnYRLQ==
X-Received: by 2002:a05:600c:1907:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-4711791c3b0mr134217795e9.28.1761040165368; 
 Tue, 21 Oct 2025 02:49:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f88sm18790778f8f.7.2025.10.21.02.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:49:24 -0700 (PDT)
Message-ID: <89dfd1e5-8672-486d-b45f-16a07eb2f2ea@linaro.org>
Date: Tue, 21 Oct 2025 11:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/43] hw/audio: remove global pcspk
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
> It is no longer used since commit 6033b9ecd4 ("pc: remove -soundhw pcspk")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/pcspk.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


