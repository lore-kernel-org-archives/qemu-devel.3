Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1DBCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRy8a-0002Mx-OZ; Tue, 26 May 2026 16:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRy8U-0002Jb-Gk
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:12:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRy8S-0004qB-To
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:12:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso6179871f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779826339; x=1780431139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nyD8wheZIvqh25sa/tavUVwSj39qnoEY9Y5OoPgjPgE=;
 b=GMEVlWDiXblGldiAtl7Hcm2TjOhuyKNnPP29tIZjmaNTbtA8Y7Sm6Sxtwvq7aLtDsM
 bNkl94bwL+ddaY811ZRxAwcl1BRSHeiPPdwU46d5TCFHDIoD75QrtWV766g627rzmyTm
 TQ9ASigP2wtkzK6XGrBjgjDVgtCYD1qe9GrdkK85QuH1EPlOijlIFXzZeXM1Xcxwx0dF
 cukEVay/jUcovb2Y/cF0H1DbAOWkOBqKuE8taS6XvVWJG/hpfZLFs6dDT7IptFXlr8SD
 iAw3Pl5tZqFWTckE9N8NqQt+XvDbvpiZxDlJO/S2xR76HpZKvGVkffokOQCKhBc5PYmf
 PyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779826339; x=1780431139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nyD8wheZIvqh25sa/tavUVwSj39qnoEY9Y5OoPgjPgE=;
 b=gT5f5W1Z6Y+jz3RbDHej1gS34fLNrjN+ydxcYNE5BKDMuuZxIj+/tpn8saxaAt3rj7
 2bzfkubFD0YO74VLAh+J65D3GF1lTvXt2UbTuM8lHr3GClCgOTevKU1kD/SKAIhg5QSx
 u77oGl+ql1dVmjpO/v7HrbygMxvYaxNi65zjMRX6R9hMAF6+Di6rcParUqVasc9h4TcQ
 qhmNWdgTnAYsj0YI7I+6u1mMHnODS0UY2yKxgzn4AK11FNusGy8F9vehgjpsumBUY8Jq
 A6RixvuzqG3mg+3j3/aLb3LxScfo1BGexbghGK01WIMg6Q0L7fhOw50mm2TKWnedIya0
 3M/A==
X-Gm-Message-State: AOJu0YzcOho48IF8qdTZYXT5jGTe7qGJ0xhjSK07am96R6iqGuco9f6v
 St9f202N+aamT1UKuxpJ8pOSXHFWKRbinAEPAy015ixtGd3Plok7ksh75LKkzjkVoHOzh1OB9X3
 MmmJMS43O1A==
X-Gm-Gg: Acq92OF5WnQYaVcioM0K0CLXVNsFwxb9ZhUAQ7gLJFE5CRkQN/9aDwfeVsdVjFJIUXk
 JkAjZjVhZVvOd5Ptj3k1ouIG3VwdhOm214KrcPDCORzezRVumEr/UEfKBRJIBW4mqSxr3B7ansl
 QRwdBFbIPXJBNO1Qyp5t7v9emEbhlQdMGx+XDSLl9WOYdEPXfKuXfd97qgDY4X2OUZos/5qWhEd
 D5yHHB/9T9rpgE/9c5CO6+U7sMw6WUEq2uK9iJHowoPhdpMGElLs7WCDQc1Tf57LaHmoOacfV4X
 i735oVPximHEUZyg5nn6cTr1HrR1QPT43XgCZlsnpTfzCTWhYK2f5q+VhDqsTAwvxpOC8SKT70z
 Fc/hhh7vryvpOZmUw8OCeh4dHNSWbOJITocTWKo7+ETB7rHRqvIn/21I0rAJEnDNKEzMUiHKhji
 hROvIJTaSsJRGDj0pecJSq4JhWq6Pl0o62GUzDjVo80e43GE7QZLMcTnYixrXfbVRhVw==
X-Received: by 2002:a05:6000:98b:b0:44d:821:1a0b with SMTP id
 ffacd0b85a97d-45eb38a1692mr32270631f8f.29.1779826339030; 
 Tue, 26 May 2026 13:12:19 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c44e4sm555745f8f.36.2026.05.26.13.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 13:12:18 -0700 (PDT)
Message-ID: <406516d7-7de5-4876-b40b-ebe188166cdd@linaro.org>
Date: Tue, 26 May 2026 22:12:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/18] single-binary: Make hw/arm/ common
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260519144553.91483-1-philmd@linaro.org>
 <CAFEAcA9_RB-VjLuy43p5kgkvXNJPa=WyADocKLxRxve1rFq-Ng@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9_RB-VjLuy43p5kgkvXNJPa=WyADocKLxRxve1rFq-Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 26/5/26 17:55, Peter Maydell wrote:
> On Tue, 19 May 2026 at 15:46, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Series fully reviewed.
> 
> Since it's all reviewed, if you want to take it via
> a single-binary pullreq you can have my
> Acked-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

> 
> Otherwise I can take it in my next arm pullreq, but
> that might be a while as I've just sent one.

Unfortunately an aspeed pull request got merged today which
also updates hw/arm/meson.build, so I need to respin another time.

