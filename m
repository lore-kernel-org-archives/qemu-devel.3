Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD6C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWcH-0000iE-94; Mon, 26 Feb 2024 03:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWcF-0000gM-Mj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:45:39 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWcE-0000Jm-3m
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:45:39 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so2022694f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708937135; x=1709541935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8IgqD9nWXfeDjrqab02hZFGJxBLzBKENk3j5SR/3RWA=;
 b=zSu6+dJLLpj/MH2wIDkSz9dqJQty5qNWqYrIdZxe5IGa4kzgFC6fWPeszgY77FTU9M
 VhrLM8DCZ9/D71g08XRnSKLja7s7iVVGpRwutIV/ya/a+xIikfFjH1GR/TXdxJdu58D1
 KzUNuOePvtr7rzlRFG3TK6KYllKXW0+Wk5YHjmgn/jjEetECKFR6kuOBFU5VLaohKHjr
 9woYFeBqJsIFLXoA8HaZ0ZO47aBq+5AiHTpfH92saLx57Jl/QGS/fFQVCX+BSN8qPLcT
 vLPgrKmOjGZX5LVusu87qdjZ76MXETm/ndodi/WuuKR2WTk9/7xTXSlwoAhc3LvS+c8X
 okLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937135; x=1709541935;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8IgqD9nWXfeDjrqab02hZFGJxBLzBKENk3j5SR/3RWA=;
 b=d2BG0oEacOOxlGKo0f/CXm28YwFoWRv/cSTraHsDMyC35QvVytVR75cxomqJEYatML
 93+T5Txa6CWEL1ENvmp7Zq2vdhW9MkpQyRhUalkHmIhKCO2rDtZXJR+MBrIPSNc6Fii1
 EjA4l3GGJVBxiXHT8HIVOxmZxsGUAwFybUtE0p9Bh+EFfF92hK81j5hLr4ytFjGyqq/s
 7n1rUm4OIq6JvnK2JPBlZ8gJbUzrO7yqtZ/8PFZJhEZFpzCbP/ADq5ju01y1AJbU1IKG
 DDYqhCJHpA2fd/wtU1wNw7L9Rco2o1vWtCAtA4cgbVtbZOKDEF+7ICtG5j55vgrm8490
 UVbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrb6vaa5dqplypTyiSlVM++UZYj65oMCmBHAyrg2Khi2nVHgra1Xl76guXkTpHChCaX6nDyiM2xQYEy7VPNZlXJwqP+rQ=
X-Gm-Message-State: AOJu0YxI5XTKli/DVoSBhX2w31zXNTj6JF/vEEKCJbBzeufIt8ynezcB
 VKPHZqSJQiZJ6zlDB9/duBurG77NRhLF05O2Rn3UQKABmLJFzFvSKSI0fbusdbTMVQ1bnTo+M50
 q
X-Google-Smtp-Source: AGHT+IFUNvsVHzoarSJJbwdZZZLmZaoKfNPPuX5VehnQe6y2JzwOSYzs9MQ3yauAr/IG0YdRkATHFQ==
X-Received: by 2002:adf:ea08:0:b0:33d:2226:a28b with SMTP id
 q8-20020adfea08000000b0033d2226a28bmr4108256wrm.37.1708937135526; 
 Mon, 26 Feb 2024 00:45:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 bn23-20020a056000061700b0033d1f25b798sm7624936wrb.82.2024.02.26.00.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:45:34 -0800 (PST)
Message-ID: <401e7d32-c39b-48dc-b06a-97a4af16e6c8@linaro.org>
Date: Mon, 26 Feb 2024 09:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ide, vl: turn -win2k-hack into a property on IDE
 devices
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240226082941.90364-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226082941.90364-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 26/2/24 09:29, Paolo Bonzini wrote:
> As per $SUBJECT, one less global and one more syntactic sugar property.
> Like -no-fd-bootchk, this could be deprecated but it can be done
> separately---and would slightly worsen documentation, so I'm leaving
> it aside for now.
> 
> Paolo
> 
> Paolo Bonzini (2):
>    ide: collapse parameters to ide_init_drive
>    ide, vl: turn -win2k-hack into a property on IDE devices

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(This series will be queued in 24h)

