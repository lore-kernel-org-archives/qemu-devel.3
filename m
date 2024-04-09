Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC86EC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8di-0001kf-KU; Tue, 09 Apr 2024 06:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ru8df-0001kJ-7v
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:23:39 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ru8dc-0005XA-A5
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:23:38 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5aa1b7a37b5so1775369eaf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712658214; x=1713263014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DyxleWY2IfO6vab88aKWB1eiBY0XTtW3dvM76WzKa1A=;
 b=N6kNqpiBj94m5yu0kjxo4eTxhzCQdhxCsMW0OL0kPLzExxqeaDnsopLOgJ+0Wj5wLQ
 WB27TcrwK9fnIJZEJcZNYI9zH52chFZP3YB8S5lsp/gq72lh+wktIK9YgG3Q8XYvU3Zk
 jzvSpZDNdjqnQeMDvz+wR1JajGq2J1g+FoTHQgq+N0b0wz/Kui3MrADNxplSsDrVoqBF
 J8heHDYOj5+rXohaRfNsz4YFCgoLpbSvrtA24JoFElaMptF4YrifQwWLa7109n/gKb4h
 m5ssm/iE+rcIDUwejT/HIbY9FVCMMKgRwieeA4JBS5OlN9+kMZxGyASuC3ihJlfk9NXM
 Ib1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712658214; x=1713263014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DyxleWY2IfO6vab88aKWB1eiBY0XTtW3dvM76WzKa1A=;
 b=xU7h1cZPKWBQVpZJOTgs0ePiHUsyYezO3z7JSqP+9IREkxFCD5j5tBMzNnS5/zK1JL
 8k3Jr6C5p0eZfpKfcLxUOa1Kmo3RXtqxO7rFB9W1FMjTLjUMqwyF2bnpgc5SQTBpvE6g
 GJHPxtKkgf5wWOV81bgmOXWn+BEETdRFzdRq17LSsTSLgWrgv1tr/byLOggR6ad2sVPS
 zDIIANuGdhOcnaaPveod0a8lqqik7XccuGgwrjzRJqB2LJVf9ms7nqlQlPDHW04bULua
 zXPkgUiCiwyK0pivsNoTnNaIUBXYK6BqBiYBxKGMQn07ZAzcm5uaQWCFh8Gwzcn87kFJ
 xQrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz6vM8wNtGSlA6VdFss4k3ZMlpoS/naiteU607Uhj/Blo/cQ5cKuBmLblolZC9s0EHjSsgwiA8DZBbL0Uc0jvPF20snNg=
X-Gm-Message-State: AOJu0YwEXWP8xecqK76aNnN4XXfKxTtnL9mh7vmwMTlxZMUGIr61UhUB
 yz41wUFgym/FKOLtt8qisL/dspP8YUTgZmT/cFGwwTme3DldcTPhmk/ViLuvacA=
X-Google-Smtp-Source: AGHT+IGyaSP4v7shfAAGG/IVh0mjrUEHtE8xTI0ek5swFPQV7BZFd0BxK62d/N2swKcZlW8N3XI4UQ==
X-Received: by 2002:a05:6359:5142:b0:183:a47e:6284 with SMTP id
 oc2-20020a056359514200b00183a47e6284mr8391706rwb.5.1712658214412; 
 Tue, 09 Apr 2024 03:23:34 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a62e702000000b006e6c733bde9sm7972540pfh.155.2024.04.09.03.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 03:23:34 -0700 (PDT)
Message-ID: <6a36727c-0104-4631-bd18-41c4b0befa00@bytedance.com>
Date: Tue, 9 Apr 2024 18:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2] backends/cryptodev: Do not abort for invalid
 session ID
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Alexander Bulekov <alxndr@bu.edu>, Zheyu Ma <zheyuma97@gmail.com>
References: <20240409094757.9127-1-philmd@linaro.org>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20240409094757.9127-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oo1-xc2b.google.com
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

LGTM, thanks!
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>

On 4/9/24 17:47, Philippe Mathieu-Daudé wrote:
> Instead of aborting when a session ID is invalid,
> return VIRTIO_CRYPTO_INVSESS ("Invalid session id").
> 
> Reproduced using:
> 
>    $ cat << EOF | qemu-system-i386 -display none \
>       -machine q35,accel=qtest -m 512M -nodefaults \
>       -object cryptodev-backend-builtin,id=cryptodev0 \
>       -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
>       -qtest stdio
>    outl 0xcf8 0x80000804
>    outw 0xcfc 0x06
>    outl 0xcf8 0x80000820
>    outl 0xcfc 0xe0008000
>    write 0x10800e 0x1 0x01
>    write 0xe0008016 0x1 0x01
>    write 0xe0008020 0x4 0x00801000
>    write 0xe0008028 0x4 0x00c01000
>    write 0xe000801c 0x1 0x01
>    write 0x110000 0x1 0x05
>    write 0x110001 0x1 0x04
>    write 0x108002 0x1 0x11
>    write 0x108008 0x1 0x48
>    write 0x10800c 0x1 0x01
>    write 0x108018 0x1 0x10
>    write 0x10801c 0x1 0x02
>    write 0x10c002 0x1 0x01
>    write 0xe000b005 0x1 0x00
>    EOF
>    Assertion failed: (session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]),
>    function cryptodev_builtin_close_session, file cryptodev-builtin.c, line 430.
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: Removed error_report()
> ---
>   backends/cryptodev-builtin.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
> index 39d0455280..a514bbb310 100644
> --- a/backends/cryptodev-builtin.c
> +++ b/backends/cryptodev-builtin.c
> @@ -427,7 +427,9 @@ static int cryptodev_builtin_close_session(
>                         CRYPTODEV_BACKEND_BUILTIN(backend);
>       CryptoDevBackendBuiltinSession *session;
>   
> -    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]);
> +    if (session_id >= MAX_NUM_SESSIONS || !builtin->sessions[session_id]) {
> +        return -VIRTIO_CRYPTO_INVSESS;
> +    }
>   
>       session = builtin->sessions[session_id];
>       if (session->cipher) {

-- 
zhenwei pi

