Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870C3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0QD-0005xI-9o; Mon, 22 Jul 2024 17:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Q9-0005mK-5m
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:18:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Q7-0007Ae-MX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:18:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso34486665e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721683090; x=1722287890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u1Dxa2top5UQEMYVO1Gw0jihMKe4arXNF/fGqrXEzmo=;
 b=wAXd0okrdGQAkYVkdLKA5x2xNqGLusKMW4AuOHi8EXqadW3g7Gl4V8Hb7o5oATn0bz
 YHmPkm7vvIrL3fxnZCICbFCaCQcT6N48yKLHjybWCxGkHzlC1YVXj+jYjdErVWTYq+Ja
 MDgXn1Bp5M7INkcChN42AT7QxGhWtvl7P1Fgc1Mq5jXJl18g3vF+KQshMCjPIFBmvym8
 OsqQCviWNYrevmev16P8X+wEcyD22yMgLq6uYTNwAq8Oju9Qe1ZiQJLM/8WXUTcAGO6c
 FsqZ95JPjMWDyVFi5JfZ/Ye6GHdRJ+KW00a7IvvykQ1aZgYzmD7wxgHP502UhTnjUODB
 oZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721683090; x=1722287890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1Dxa2top5UQEMYVO1Gw0jihMKe4arXNF/fGqrXEzmo=;
 b=JJoN/LXTKQ8170yXiCBIFv0NJlL6mwKMgp7HA84Qj8i8uwe/nwgQeedKF9F6CsoX6X
 qS3HAiWCxIxm+LARs9y9Qj3i9yCWyKy7GjqbUXYplk+TgDSRB7fSOXfWsxMn2Bpbwwj4
 UISUQ5UdO7RpQU0RJf3c9Xu44xlWixD8Ic7b8XqP03gmyyf0kjXiS5hDBnjJUBp+PWek
 sF/EnGDNpTGS3TojVkPZvHw6qbCMNXiB4LE449UNBHz+9sbs5xrz6gEf6N19W4usgEky
 Dr8P5EDJWoACop7FwKOZj9nylSZOAnWAu5Ine162s/SThZmxizjOmc4eoI3KhiyLU4yH
 CtVg==
X-Gm-Message-State: AOJu0YyZ73OqPaoO2oiqzPZtIc5g16/op8732Pa9u6AqnTcmWqzIFToN
 qyLxVQXz8cs7YfnwIULV4AikIecbsmcHFwH9Sf2pIOOjJMwMFzPhBvqpO7NAbe26HloNA6CF8Mq
 X6tI=
X-Google-Smtp-Source: AGHT+IHiSG3qi2oiKaEMQIieHjrkfSUz7nbulB3utZqdTTJWYrJ/l4Vv/Spde8TNQpC4/LSopn7qjQ==
X-Received: by 2002:a05:600c:4f8e:b0:427:98b4:624b with SMTP id
 5b1f17b1804b1-427df7aa65bmr44293115e9.24.1721683089753; 
 Mon, 22 Jul 2024 14:18:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94380sm169998385e9.39.2024.07.22.14.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:18:09 -0700 (PDT)
Message-ID: <c2ad7aec-1d27-4ef5-a7df-a54e656e0d2a@linaro.org>
Date: Mon, 22 Jul 2024 23:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Cover guest-agent in QAPI schema
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Dehan Meng <demeng@redhat.com>,
 qemu-trivial@nongnu.org
References: <20240717140025.66397-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717140025.66397-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/7/24 16:00, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Patch queued.


