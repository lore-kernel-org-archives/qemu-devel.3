Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 21:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTpYE-0006D7-Bi; Tue, 16 Jul 2024 17:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTpYA-0006CQ-Jm
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:17:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTpY9-0004iW-3W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:17:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so979145e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721164647; x=1721769447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bT3+F0lsgckSr7EkHOkFy+1HwUoonZs4RrHg9lk0r34=;
 b=p3z3O67Y3oE5OeD3f/vEoSrrqf9EVWp2qWVuvXZVMmsevBgLBlqrEFATIg+jsCAoEg
 BRDEYlnxNzGUNje9Fq0/+dtqqYqRHMz7zMFnzPdNNZyqbFOVW1aYXheXQbUjPZMhYAKc
 nzGeMx3S8ZRunW4gRLC6KZWEygDzTlY3+aTQWUtt10tCdNmvTiAakDJb9xM5iF9ApFeK
 cfPx2PFRyPZOab6ylOjsj34nsDBg/J4yGjCu1RHnuoNxQ+b6Q8qEkznD+s82A8Jb0bcS
 +DM+AioN06OUi7d/YOoGYN4lCzKLxd3RoQXW6Gshs9bUeiZpE1kIL5tl6JA7v74zCo+K
 PKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721164647; x=1721769447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bT3+F0lsgckSr7EkHOkFy+1HwUoonZs4RrHg9lk0r34=;
 b=ecx5JYuM8BROZ5tpROpzFOJe77gTTS9DOEn7/TtHzWduhhd7+i+TZ2TVXtvM5nBP4x
 UXVRwZWrgseeQt/dQrOTDQY/VZyBoGd4qmiBMf1S2sATQdECsbRVoKpra850iNaRIK4X
 OVCQrddo9UPmCu2zafV/qxyf1W5A4ufj/taH8F4eTNOZRVM22iwfKAcQYBn7GDoIHYp0
 W0WCpS4GCGnhnScFAoswK1A8FLyeQHH/0zxoQTY4K1AguBGyxSU7gCnfbp+10gBBiFPd
 z/wBgomi+HQQSwCkjX1rAmoVkjenfvPiIPsx0DA4YO6i4zna1HYst1/pHdd/v7miEj7d
 410w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpH/qbj1u31NOPyWQqxak+OeKQajj81x62Bl3ajstzYdT6v3zK70l/awJlsqgU4E/2hJwk6aGZfaXMc0QPQ2tEAb64+X4=
X-Gm-Message-State: AOJu0YwxXPZSrLXhaHlo4PKMQ1bNYlMZlRYxbHuhwoq7wEfYotd8JMdO
 4QwT/6mA+k+rM+nmkDdSRv9Kl/zqEPkRWiyJBwTupDMXOp3D0kps9XiW8A7cFdM=
X-Google-Smtp-Source: AGHT+IH9s4aCXnqfKEpGgxVyMlMNdV3e/jqnE951OYAFByXPoSnQ+UmuDrPKo/61RUHUvkMPDfp5+A==
X-Received: by 2002:a05:600c:190a:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-427bb6d2e0amr24932905e9.9.1721164647453; 
 Tue, 16 Jul 2024 14:17:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bb9988f6sm24308115e9.1.2024.07.16.14.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 14:17:26 -0700 (PDT)
Message-ID: <d25b8cd5-e580-48c9-b416-7462d060f1c8@linaro.org>
Date: Tue, 16 Jul 2024 23:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] qapi/sockets: Move deprecation note out of
 SocketAddress doc comment
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 eblake@redhat.com, mst@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, jsnow@redhat.com, imammedo@redhat.com
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-5-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711112228.2140606-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/7/24 13:22, Markus Armbruster wrote:
> Doc comments are reference documentation for users of QMP.
> SocketAddress's doc comment contains a deprecation note advising
> developers to use SocketAddress for new code.  Irrelevant for users of
> QMP.  Move the note out of the doc comment.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/sockets.json | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


