Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0F4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFchE-0002LR-RB; Thu, 15 May 2025 13:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFchD-0002JY-8j
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:48:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFchA-0004n6-FY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:48:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so14272315ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747331315; x=1747936115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLwzgiF2QXOiO+DlqGVZ+Wa8vcprRAO/KS09deuijTo=;
 b=KakxsTqeB/A4XxBhXYeyrkEYxoc0vuqPiWaYwGPtl2fkc9TaE8St10FssUEWolENuj
 TZLY0nfaml/nDN5ZEzZajmZYyCXxYWCyz2EjbtDZlatnPbRmqow2yQLOaZTCJ+Sk0VFJ
 dPeosY5T4F/0jB0Iiu+J4NI/1bwjGf0Dn5XTgTp2O7Apl2vs9iHqQcZXHT08pkbfQy65
 qEp9tzFr7GxBUUqeUdpxs2cn5K7y3ra3IT+BeODXHW2Le5CjT0aPnd9w2bWmod6E2rhi
 +Pg9oMRxR+SmQr5sn3/Blf+LupkFy/xsmfLg3X8mo/K1OeMowPmedkmkccoqNeLbN0dh
 3X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747331315; x=1747936115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oLwzgiF2QXOiO+DlqGVZ+Wa8vcprRAO/KS09deuijTo=;
 b=hcpZqSQgICLZioluXOWzINfE3kdEb6mf6ClzCEscB+v1r6aui53KZk5+y4GK7LE01a
 nUYmMJQu3QE+veWEgBacPVLLTImavyOer3/t3mGmzujU8mbFuVvjjP83wUU6OEN/I1/z
 wLKkuwI5iuofFrkTqGkys9po5s+nuUSR336L38qrKLsoIKdJRXq9RGJT6/0joCkmOMGG
 TXGotkruQs3oJrWP/VVjIPWl/IYBALbyOxfXVbkOcabjYElpo03ECprcnDtei0yQ+BVn
 PSxb9TUPTsvY6yWD6ZWcvZxIGp1C+19d3HRDMLBemn62UP8xJg7xNOUHZYZybzZp1Xge
 pCIg==
X-Gm-Message-State: AOJu0YxW5YJt8OpqJg+M5P8WSpHNp89iBB66VoPvumpQ5mTXiQGXmisX
 6juEOsvsPAb8byUqFT2Wbfh6Zv0KJlt/M32t4swon0qCGa40TtbpJgFyIPPpVDRQjGWLWRLAC3T
 d28uQ
X-Gm-Gg: ASbGnctq38sE2Cbtz5DZZ7XqwzxEKkHKBFbixNdn1w1/1LoN1i9tC6cFhoaqqIyVM3N
 tlo5pAPGRWnz4thFzPSkVI3COR8OeBROGNAfujzdTBUgsFtv+KN3t7z7AX11m+ePuk+GQ6rDzW+
 FW4urnmBtNwsbna3kGnFRyt3lSh/+/Z1a9kl81EJ/gAe5yMIjjn+jGOkO8/dPsGrXSsjRqkOKgL
 Sm+5e8LZECM64s40VeshHyQb3Ywv9D8T/i/wvpUjRY/qiP0ONQsA17XTbTOvwvx8G/XEH646rFJ
 TL5t2ouHGgINmrlsD7iu3S/MWtE++jN9oMrDAJhRK4K6M2XXtXwujIN+AsNrNYeM
X-Google-Smtp-Source: AGHT+IHMYHRC0sQEs0b8OvFjP0Q7Czw4Cu2mnDF/8QZ8JoUR5F2R4nUCHrEP0npRBdM0xU1nGolT4A==
X-Received: by 2002:a17:903:41d0:b0:223:4d5e:789d with SMTP id
 d9443c01a7336-231d43b3ba9mr5656265ad.19.1747331314889; 
 Thu, 15 May 2025 10:48:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dadsm553855ad.141.2025.05.15.10.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 10:48:34 -0700 (PDT)
Message-ID: <7f90ec6a-e0d9-4155-ae91-edc687360894@linaro.org>
Date: Thu, 15 May 2025 10:48:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/main: comment lock rationale
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, npiggin@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 5/15/25 10:46 AM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/main.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/system/main.c b/system/main.c
> index 1c022067349..b8f7157cc34 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -69,8 +69,21 @@ int (*qemu_main)(void) = os_darwin_cfrunloop_main;
>   int main(int argc, char **argv)
>   {
>       qemu_init(argc, argv);
> +
> +    /*
> +     * qemu_init acquires the BQL and replay mutex lock. BQL is acquired when
> +     * initializing cpus, to block associated threads until initialization is
> +     * complete. Replay_mutex lock is acquired on initialization, because it
> +     * must be held when configuring icount_mode.
> +     *
> +     * On MacOS, qemu main event loop runs in a background thread, as main
> +     * thread must be reserved for UI. Thus, we need to transfer lock ownership,
> +     * and the simplest way to do that is to release them, and reacquire them
> +     * from qemu_default_main.
> +     */
>       bql_unlock();
>       replay_mutex_unlock();
> +
>       if (qemu_main) {
>           QemuThread main_loop_thread;
>           qemu_thread_create(&main_loop_thread, "qemu_main",

This was requested previously by Nicholas:
https://lore.kernel.org/qemu-devel/D97QJO5Z909K.368VVIBFA17TA@gmail.com/

I sent this patch to qemu-devel some time ago, but it was never reviewed 
nor pulled, despite multiple pings, so I'm trying again with qemu-trivial.

Regards,
Pierrick

