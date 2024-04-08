Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE568CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts4e-00041G-CD; Mon, 08 Apr 2024 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts4b-0003zS-5T
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:42:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts4Y-0001MH-N5
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:42:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so22054955ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594536; x=1713199336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wJW/hRhTVKt1J8SGJTntMezByZ8BraPsAo4cfQ8Dhs=;
 b=DUcF+VZ+uajgj3v9jQPigjmKDOuIuJm7qxVO7DnkayWgVi6x7fY2ZjskCPYTg6cny0
 wpzbmcVvtuhZbGjPddTf+4yx17fgK6IEcpStJGN3YQ5KOmR2zbTmPQqmwnHnC1pNydEt
 fUfLRLQ+e8LZHx5BCvrvQx4xvfwFlIDs0XJOdt+z3j1KDbdfZziHIO6P+prCDO4E/PeH
 /TxEkBtQolL0VI+Fh+4tKPctnpz//ZWQTUMuLDxMfPGw9XNb38OFLDIAfCihc6A4BGqq
 C0N+OtfWIxE2Oa4kzjgH1un7iWAfJriuWxbW/Na2B8+/rwIXubbL+eCK9l58xzEdJblx
 EK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594536; x=1713199336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wJW/hRhTVKt1J8SGJTntMezByZ8BraPsAo4cfQ8Dhs=;
 b=pvixDqRRjBatXpB6cGvwIM2cbsA7g40aTfwydDIm6lXDm5THoDzrD3odBPhNMrrbkI
 rab23ePUXkojZxYGqU1VXb8kiUpLzgRhA2UVnpF1FRwLdV6pm6SUh6Ajz7nn3A2Uinf5
 /UQHFhj+TxCQF8aeaAXAsj6Lb1GkFEXNW65Muob3zyj916oAuqIF/kj5CJVc7Th4g0+v
 Tvp5o5NH9OmH5JX6kT9u/cbb99yAN10BtMuwtn/wWrws7UDJdd4C6Md990EbZdQ4sGCX
 jx/XYi4tiCpff5VMTw3y+UH9ZkRC6nHj/doZzaR3KNSygfWwBu6hCzk9U36ZHHhCDfY9
 f4RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Lqzv6yI4gFh22sAPhLXgeceG+8mVvQfFMWq+6hB9wwwT7Ony9TkiAdbeXWwtTi0fzgAiV3lrRQ+qMBMzbzLOXLV682M=
X-Gm-Message-State: AOJu0YzogiB/KPoquiGWuU1nBkyzhM3CKqbXMa8W5DwJdle1ixqu/c2D
 aSMnRPaN4ured3b+QrlN9N2KV3MnVndSjVUimK6F7ZYIqu5Lm+ziylO/oj1UCmw=
X-Google-Smtp-Source: AGHT+IHf8m6nV3tCYg0xg+qt1KcIUds4+aEt9Y/H5dArX9tcqlA2GLUp0zB/0RBmhenrMsDJ/JMsgA==
X-Received: by 2002:a17:902:e0ca:b0:1e2:15a8:e4c6 with SMTP id
 e10-20020a170902e0ca00b001e215a8e4c6mr6926545pla.55.1712594536180; 
 Mon, 08 Apr 2024 09:42:16 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a170902c94d00b001e2ba8605dfsm7208443pla.150.2024.04.08.09.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:42:15 -0700 (PDT)
Message-ID: <26ba84c3-717b-49fe-8848-f2c851feb250@linaro.org>
Date: Mon, 8 Apr 2024 06:42:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] tests/unit: match some unit tests to
 corresponding feature switches
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Try not to test code that is not used by user mode emulation, or by the
> block layer, unless they are being compiled; and fix test-timed-average
> which was not compiled with --disable-system --enable-tools.
> 
> This is by no means complete, it only touches the more blatantly
> wrong cases.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   tests/unit/meson.build | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

