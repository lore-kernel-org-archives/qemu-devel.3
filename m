Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273C9C4829C
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 00:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYxus-0001Du-9b; Sat, 10 Feb 2024 19:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxuq-0001Dj-UO
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:41:52 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxup-0003YO-Ik
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:41:52 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e1270e8cd3so903701a34.1
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 16:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707612110; x=1708216910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aX1wJJo8bs1gZoWmHu+qHZrYihxXPDMAnfQnD6bRxnI=;
 b=OjiChcR4M6ijBmva/d7Enwecw9B0Agk722Aul9j1sshPgnHCqjCK0Ep9sdRGu4f3dv
 16/z9QDtlCqSfdOGpJq6Zn8m9X5vhVKYT/VO0pHODOEWuflBbkAZOrYBO/0poaPiinlQ
 ucZzWIW3qdW+BMvcEIv1yyDZ9AGk56DiS23cM/YMoLFaAeapy/rdxgvFYOg8e62pjSU+
 WBKn06qapoIymXu3J0IjCstMx4LjGf0vozgl96QEXi7PKSnj/yUMTf1INqmBDvSHfjfB
 1m1Vumh+ToMRDJvstES1xDe7QitSQfqQWDaQLgldCxPe6GX2IPqE6u4ZUBfyG0n3HyyA
 h4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707612110; x=1708216910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aX1wJJo8bs1gZoWmHu+qHZrYihxXPDMAnfQnD6bRxnI=;
 b=B+fVzfbpXhGOx75MMf07IGyAo+EFo9xB40GDXehpfTjrM7WVnmZBrDLyj5aUZDV+fl
 HLAFpxexUDH6OASgluldSPy/LLnHF2TzBjxeuYq2TMyI6+8bgl5HpSm1ZdRN0VNrIdb0
 UKmbrtYfIvPy3rx9VdImuo2LrxmfVVuUUbjo3TERaM4jJpQY8LeQSMwIf4AH34UJNSjp
 +zVA7idcaZCv8PhuAOOnBiIpsNUdZT4RKJxey2YhgclWm1MaA+k6+KP89m1Z7S/eFD/J
 5PyPKiL+ocW5cD6Va2o3dQe4KLlZeIxK4yMpOgEF4A9G2HDigTd9QJm5zo0XcM2zW7p6
 kCiA==
X-Gm-Message-State: AOJu0YzEOYkyaTBEak9J2htew0umluAQRWRTIvXJWbOfIAo4UFuWvd6y
 Cor1oiui7chcm0cBcbMLKx9oWrrh3lZmdlVcsaNsP3YBXqUE8+rX05jia+GgXs0=
X-Google-Smtp-Source: AGHT+IHqQBzI1I0xE9LrjWW4qxYqVVq5BQet3VzyLt8//YiS2wZZK/thMxbYW44Nb/iOETD7KzvqSQ==
X-Received: by 2002:a05:6358:898:b0:176:4135:fa3b with SMTP id
 m24-20020a056358089800b001764135fa3bmr3835502rwj.31.1707612109784; 
 Sat, 10 Feb 2024 16:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUh5+ItAoR+VsbFdNIQCZpSECvhrVVvL5b9E7eJ+KfVt2EnL2WiRgFIhIfifjoOel5Go0LpwNUSVxnlpQr/Y3q9K2fZuQvvvSO9WZyX2qE9jT3cUOen51F3DhSM2op+4qxj/RmT4HPrIpzS/QvAM+HTDKonpGVRlqrJv4W30WcFrP+OWCnZZLYC0rmdDY52pG2U7WQd3tw7vQmTGb7PtOMQ2J3dCWLm75X6RRgRe8QG0Da1hwzJrpAMvKCdU+PE4NalJ2dtdmWSXRCSf0zCT9ltw1CcJ6vkWdDSbBvSDL+k5Bcetw==
Received: from ?IPV6:2607:fb90:bde1:38:fbe0:8943:a8ed:9394?
 ([2607:fb90:bde1:38:fbe0:8943:a8ed:9394])
 by smtp.gmail.com with ESMTPSA id
 sz6-20020a17090b2d4600b002966dbf4d82sm4151881pjb.26.2024.02.10.16.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 16:41:49 -0800 (PST)
Message-ID: <73e5314b-5e92-4a57-9780-508a8f33fe72@linaro.org>
Date: Sat, 10 Feb 2024 14:41:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] plugins: scoreboard API
Content-Language: en-US
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
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3381ba3a-ae14-4160-b651-d88a7893189b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 2/6/24 19:59, Pierrick Bouvier wrote:
>> Why a hash table?  All you want is to be able to iterate through all, and add/remove
>> easily.  Seems like QLIST from <qemu/queue.h> would be better, and the QLIST_ENTRY member
>> would make struct qemu_plugin_scoreboard useful.
>>
> 
> Thought that having O(1) removal was a nice property, compared to a linked list. I can 
> switch to a QLIST if you still think it's better.

QLIST is double-linked, so it's still O(1).


> What do you mean by "make struct qemu_plugin_scoreboard useful"?

As opposed to simply a typedef of GArray.


r~


