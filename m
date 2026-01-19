Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942DACCF2F2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vho39-0005vL-8H; Mon, 19 Jan 2026 07:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vho2z-0005ry-BO
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:07:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vho2w-0001X4-SR
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:07:52 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so48638055e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768824468; x=1769429268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pinOi1QmEbM3A/U1ZTxxLVtBtlYlFQX4n9yCVL/5a2c=;
 b=wcUfuUEy5FXz1HcV/4R8p+tWW/xltBJvTAhxnPGXFC5Pgv1eeTfu0kYOSCsq0YB2er
 Jho4qzgtymKHriLgXt63t+RrOzFvNzlyv2mFI/8BI4s9d/wE9jzAhLrpU+cyxOnVJtpm
 itj/Vs62HiAP+n4fWFIzKUwsfnjUoHmgoWktjINM+S+OjhltAxtMXLZmutLGnX+9pHFk
 gi5jadLGBDoudIjhk8iRmsiKMGwu+JobxU2tcwoBuXX0XSBeC5IzTRZjYooo6dhCclrh
 +d/+g/p5JSN5PeIUpAdy7/8NY6g2jRqdLWxh2H3I/c/wfr2AsNystJHASpkBPpbGujfD
 K0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768824468; x=1769429268;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pinOi1QmEbM3A/U1ZTxxLVtBtlYlFQX4n9yCVL/5a2c=;
 b=Ea/zYOsTwlMVqklzSVjkbcXaEREEykRyvj5+G0yRflYUjNKvekLWdnRTXuNQIPyCNn
 X2LntvK9ric9fMV2fddizZuFg5E0gKoC05lB64cL8ZAHUoW2OeoYl5urQpPjn4iuVA7x
 GExxlu9OkQjIo6fP5h0ZItBki2w4G+/wXmCV2UCEAnXn0h4bjkoICrhnjY7fP0devxKf
 V69ZEyCfBsjqejfNw/AG40IuFLth9pNOVQudQq6Rlmv3KKeCEoYh6cILELLjVaHU8hgU
 P7gDryrfKx7F1Ph7jB2WehGH9HeXgm0RSv/4Uv5iZV8ClE4uV8AuaKQNs1BZI2vTfDeN
 WUVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJNlll4C1ssG/yoZwGLrdc612H2yhArEolIoX/B0W5uuYWPEhtlBCPmP+Ce+AW4eey9FPKyqeHk9UG@nongnu.org
X-Gm-Message-State: AOJu0YyK9OpZokiH0xnM3dxooBbOAFKt1BfAoTBVyA9ud0cQYKIYa47U
 9JL3urBHs41rONvJN3l4WslT6Ai3fPUYdWQFuLYoLIVuEY8qqHMXFb/YbiEUlUaESsM=
X-Gm-Gg: AY/fxX475ZM27OWXpuRq5vLqPhSxe00qVATkLwziZeVfX4IFFJf5FEBIHnil8Qmqi9i
 lSIjOBnlfI5IrP97MkwJl//bxE8SflfKTGdQzoZp3E8LfRaHVAVEqmgzU125gdYVdZSavw/Xqfn
 rQIxULr18f1Nhve0SFMf2SJtXoItpafemUolBULwdAHtjePNu6X9zrLfwi+ZCAWtdK0T319n8py
 fenOhnkCK3flTba3n2OU5mdZO2PNkOgv+J87lRww5IwW7dZcphslxqRIV0Ta/E1mLbDZMwJnP9j
 YisIdSfnNQvEH5FS4ZLTknv63nlb6+Y6Zr8JN8Ro8YVCPnvjY3WX3WU5JQV3IKqvV9R7FKzXb5Y
 HJfj5Ux9z9EwYmfPc1GWtSeX/r5oXTuEfEPpTLo006HyZdvRk6GJkpK7dhTmeMcAxbOHKZV8LXN
 gPAbIe3OMxBxIhIZy9bqPRaUGJuPqefH+DURBtkMxfmc26Jqhddcr+qpoTytRhGctw
X-Received: by 2002:a05:600c:a12:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-4801e34cbd8mr138001385e9.30.1768824468221; 
 Mon, 19 Jan 2026 04:07:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c00esm186882005e9.2.2026.01.19.04.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 04:07:47 -0800 (PST)
Message-ID: <7b158bd4-aa40-4c2b-9bce-9106f0fd5351@linaro.org>
Date: Mon, 19 Jan 2026 13:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-nsm: include qemu/osdep.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com, Peter Maydell <peter.maydell@linaro.org>
References: <20260119120402.284985-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119120402.284985-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 19/1/26 13:04, Paolo Bonzini wrote:
> The file hw/virtio/cbor-helpers.c does not include our standard qemu/osdep.h
> header, add it.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/virtio/cbor-helpers.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

