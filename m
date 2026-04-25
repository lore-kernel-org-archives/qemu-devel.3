Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA39EFF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 10:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZvW-0001T7-0B; Sat, 25 Apr 2026 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGZvM-0001Se-J6
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 06:07:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGZvH-0006KW-4T
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 06:07:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso118790355e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777111657; x=1777716457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ftWR5yxI/cTgKcnDYnZASKJgqwKT+6x8D5x68NmmD4s=;
 b=fEY/vxCOKReT/ICgFuIMsXuC8ruCWjV1LZB354Y5NeAFrHjnOSgfL+1oZYkS/5VKqA
 q5spHCJ0ktgkj+TqG1jyWED15oNKojvyLkfqEPJvuG+WGIEIeXUYi0bb+w8UJs6sDaX2
 Fv6quuKyLUnhsZFQf5lkLsot/SjSSt1v7nz4dUoT9P+s6ZMH1/VnMWBHav+UxXU1A+qu
 a9SNg1W3Zfa22YXkJ18oZu4JzjvpjBtJX5EV/R4zWfFSY0hiPags5LAAuR/KJjbRJBrA
 3HUoLju6uh9hB9c+ZQ7mnxvw/2t1IvZcvluENBBBfzJgHwoS6Nhdd2kaEX4PS+fj701I
 G3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777111657; x=1777716457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftWR5yxI/cTgKcnDYnZASKJgqwKT+6x8D5x68NmmD4s=;
 b=AGjrBgUxcNz3/TtqNhyI7hRDqeZWV+BdZ0Mc9OB3JnSmqhzmsF4xTBL0AAEyc61kTf
 KkwaZ77Bnu3vn4l+dhB8WjMFOy/y6wU4o6AuUSxY3VpIBJF94qfRt1PZOdMtHs0ZcKIf
 /fVREhFPp2FrW/s0mm1BYORbjYwgsvZygw9BMpCNHoXMARyQz72WmhCicHpDqf4rNEI7
 wubCoFgLCz9EQvx91DpP12vBpLkaHqMANrPTKha60kSOHqnmh7n9bGwuJiRTQpYhD1ad
 4XdxEVP6Exx3oTJnJoNrynp46sl8oL1g8FBaMo/TO/7kgpLZIoG0aN55Q/NqA+BP3d9p
 M7Gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i6kn4IJOs906Zmia67jeNqkdR41EaJ+oQ7mvfaQrZsG8X9qzqxu5rbSsm7Tww9Uq5DQ9vC0kUt5TS@nongnu.org
X-Gm-Message-State: AOJu0Yy9cV7mLVa2n1T/TUM8hsCYPwy/22tkBZUg/49USZGmtEu4lCZK
 hWaYOY2TsWiXWwotBpp2ZfuU/iTLCVoBFGdWmBeYZPSvfxn4p688fAKFQbTBaxxmbUk=
X-Gm-Gg: AeBDietoz9X0ydrkLFpIzAj+wwIUHc+ZrGFU2DDccKYIHtQe2NQw5zoeTEW6A7SGJMG
 dRstP4Gkn6pHDScknS7O66z7QYPR6viI4CTgUpbXvUnbjEc1nRf3zPfts2S0Z+zJ2XRZrnMf3Da
 jdOxy7ncIqZpAPfQwXFqvEDUtwveQBen4G+uNovV0FWc88SKVYAKSHAkOOH5yEzqKoBzYAWHUY5
 rMbiFVKyPVK4fQUJt+l9h+HPBD/5eAj/oDMYR37e6frXi11APxToti4V+b+ivTt58cvIMrwN+bW
 GNeoq7nIEMQP0DSBup/rGHeT1m84NzRVwcHAcACMO/Dl4p4nrZlBOPtl/ZLVxpmGbR2NLda9hTa
 6aiOoZOgaf9+wY9WqKveAbhukVmQOGGA9zf2IuiELCg1u2o3Lfyt2QjcKeydlm8bUAFHXhR2sjW
 9Jfu9QjcDI+t8iOefuOFC7OkMMih2IPUQpO+yYDLx6KfbdlIOASLa6nrK/H6NVOfCCTvG4yB8vF
 89/
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-488fb7844c5mr548630315e9.27.1777111656640; 
 Sat, 25 Apr 2026 03:07:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a6124d7e7sm250327615e9.5.2026.04.25.03.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2026 03:07:35 -0700 (PDT)
Message-ID: <81605e59-a916-44f7-ae68-40b64b811bd3@linaro.org>
Date: Sat, 25 Apr 2026 12:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] single-binary: add stubs for target/
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
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

On 25/4/26 01:01, Pierrick Bouvier wrote:

> Pierrick Bouvier (2):
>    meson.build: define stubs library per target base architecture
>    target/arm: define stub library

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

You already had these tags ;)

