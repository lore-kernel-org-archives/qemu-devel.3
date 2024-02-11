Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD7EC4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 19:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZFGU-0005C9-4h; Sun, 11 Feb 2024 14:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZFGS-0005Bk-Ft
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 14:13:20 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZFGR-00007C-2f
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 14:13:20 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e0cc8d740cso360461b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Feb 2024 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707678797; x=1708283597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Pmo1B342Uvu9HZuh/Wv7P+2zDhyRwSptvfx2lo3BeY=;
 b=oaqXoEsyYsEBiKjHlmedWH3EewYvCJqO6h6P5+/PCOcz2m5o2GNGahqObb7v5AInsJ
 UZuHrdlOTDDZQg1MZzREGiZffftX9axMMlf3LQHa7td9owxcfTJx+oRNk17tZK/sJycx
 qO16AnUkySqRqztAVFa8dXjfnCtDJjcIzcEXbALAfGqh+UWkYigYGVy//rif2jSLC7QI
 OteN3hlgABCZmvhQ9ZI+O4FOboqp8upH/rbaORDYTgT4aVx2bOlxT3E6rghQKuAQZcZ7
 2kOt0zJ1DHfVWU4T8pDkTqN2keiPAm9gmvAwwnUifj9Ho2LrTTqkbrI3CO5Zn4o4tP1W
 Q0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707678797; x=1708283597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Pmo1B342Uvu9HZuh/Wv7P+2zDhyRwSptvfx2lo3BeY=;
 b=r0OdtFRwIvtDUEaZL7eyJgvY7DAyJDpPqtG4rrv1RTD2MkB5CFLCIkgqUsRYv9+LrH
 9YppYcY2IeN8DADiXzD5l3TPsGXY2J4E9bLr9MwfjJUV7hTJYT7+v10NTPPPMwK9Leer
 557CVtIPGzTN81mkPOm93vI+5STOEBXELIzmIV9yiSabokLafExlcQUSRzz9POdPW14o
 0htiPHgqQ1oEvDtHwwnbv6mJ55XGRBm2XdpUEzuSdYKBcuExILq6WFmr+ohMBrGR2toO
 0uy6s02cnCsRCWipwxgKoSThoQJ91GbSnnf5QshXctBq0vO7mji7yJIRC4VfQEMiGPqi
 Ckjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAam5Y1XLnQLbzLm5TiJX7g6hrA3cdTXkdF/cjID8VABv2R6piq/+/AbPggbqUxIgdsECYulCPExjLiNrU6nCVMY9Qf3w=
X-Gm-Message-State: AOJu0YwqkGvXDinWpzVr0+NSGhCNUAm0V+OrvgJQdjwrYY2Aux8IosWb
 YFuyKPQgn2dAGZX9S2GZUceByH3XMXeKTq1xMjpCWQXDGo6XdeNGDCVeh2ZlVdg=
X-Google-Smtp-Source: AGHT+IF+ez12ZfBG9P17+0oIYSFPqv7vheL9gUQ22v+8sNc6jR2Y9PujiXS/HIcozaU6aJuLX7SJow==
X-Received: by 2002:a05:6a00:4fc6:b0:6e0:ad61:6a8d with SMTP id
 le6-20020a056a004fc600b006e0ad616a8dmr3548826pfb.1.1707678796686; 
 Sun, 11 Feb 2024 11:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZ85ol16HJJ+mVdEAZ7RcaJjD+/TsNpIws788uQZG19CL7SzRn+evCszBZcsQGAV5QwaSvOEny9eOACGuiDSKQXhGeX9I4oBx5rKtqfVfhOk56OKrnlEe6RgkCVupcyTiPbDT4ndVQ9SNUKZoaDWLvAqmJ+bQjaoVKADZrMoU2gNKv/C+k9w6G1HJ2tT0hsr+UDvw1XkT5Kk7s5Qz9rbz2Rxv1OwBW8glL8n+9YuhuUy4h7MWK/ifx0XRPfT+W72QTlhB9OPi9pCaJmzrykpfh7gsc4+nJ+UYEp4k9d3qqxMMqw==
Received: from [192.168.142.227] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y9-20020aa79e09000000b006e080ab69d1sm3983459pfq.190.2024.02.11.11.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Feb 2024 11:13:16 -0800 (PST)
Message-ID: <acafbcf1-8606-4450-8720-d96078fe5b03@linaro.org>
Date: Sun, 11 Feb 2024 09:13:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] plugins: scoreboard API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
 <e4db51de-a040-4c9e-93fa-64a378e4e5fa@linaro.org>
 <3381ba3a-ae14-4160-b651-d88a7893189b@linaro.org>
 <73e5314b-5e92-4a57-9780-508a8f33fe72@linaro.org>
 <18e758f6-eb96-4418-9494-88092f8813dd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <18e758f6-eb96-4418-9494-88092f8813dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/11/24 04:26, Pierrick Bouvier wrote:
> On 2/11/24 04:41, Richard Henderson wrote:
>> On 2/6/24 19:59, Pierrick Bouvier wrote:
>>>> Why a hash table?  All you want is to be able to iterate through all, and add/remove
>>>> easily.  Seems like QLIST from <qemu/queue.h> would be better, and the QLIST_ENTRY member
>>>> would make struct qemu_plugin_scoreboard useful.
>>>>
>>>
>>> Thought that having O(1) removal was a nice property, compared to a linked list. I can
>>> switch to a QLIST if you still think it's better.
>>
>> QLIST is double-linked, so it's still O(1).
>>
>>
> 
> Is it an "intrusive" linked list (where next and prev are part of the struct entry itself)?

Yes.


r~

