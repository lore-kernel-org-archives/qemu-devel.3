Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EBDC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA35D-0002c6-6j; Wed, 30 Apr 2025 04:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA359-0002bh-7l
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:46:19 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA356-00064n-Jq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:46:18 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c081915cf3so1119978985a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746002775; x=1746607575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eHgCB1hkLawCmyPOi0n971vetqKmWkZyGmQF8ZioWio=;
 b=CzoPwl2BOH+WbIk6GC+2wFB7uC3ogM+Sn6M9lXEkn0MpbVmmTa/EzhEnsyttk4JQFR
 jXf9rBHeeMRuPZboI8Ba4wjO9wPDbGsIZgrU3mPshIIJ1ftxKOSy9GyiEpMmTj9EIkup
 xgJtBA/s2ygmlqiF/7EsuxSqlBKkpweoim/37XMwMGReF9bGByjBTtP8FQhYZgoUZX8R
 9SVeK8kGs8RJv47YltICIIWA7LAv7B6M2kiOzZU2su6JneqwAKwsmDQATiIGsRh1L6hJ
 XHA+dGLsxMtMJSLeaZJoghcqNRguqCCbAeIGTjFLF9BpFk3/uS6YHakX6qnc1q1WyEQY
 yUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746002775; x=1746607575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHgCB1hkLawCmyPOi0n971vetqKmWkZyGmQF8ZioWio=;
 b=ocrN5pw2ntCb5wb0fn58uw89/PZc5QTww3Ci+GEvfeiFMbjtJEArwzdPBQPk3E6QqB
 boGywmT0M7MYV18sACtctrd0lVN6cDwhtGFKaoZF60mro79WXPBJ3YHmjBcewCOTjKHi
 s69TWecoBeQAfxg/1v1UETH379ZRbw8TIknG13gQzGGcqpuxRpEzaTwtYwEX5S3Jxi9k
 7VI6sn5Bqb5sG+Q1YEDGJBcrhOaFoBFf0r8/+OWVs821VBqzHSzpfmgxehdCUSUgZKXU
 BkhXkIaHK6Ws1uMWgJjqLjqFsxujRX6zhv3Bwk+FZOYcxLj/1QS6wvmfL7idXOzuG62d
 ebMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2BbZjFmBWtn0jXn1ORE/qlIxSntmODm+GgmZcMAy5yj8dsV2pqeRcN+VSBBY4tYA7kGz6EW+lbAUZ@nongnu.org
X-Gm-Message-State: AOJu0Yze41AAFBxe5A2LOfglph3xU93PfnYkuhsh9lSe84RzNN3/BTSl
 xrejWYYufzTRJVKZ3amchfaUD5wy/DjWF1nnbjraND0XQOJuOntU8LOZgb6ubOn5wwQ6aidDS8j
 G
X-Gm-Gg: ASbGncsKko6/mJK/HjvQUjALj1pj2up+wQaFbvlfA416pQ7DIIeFTaTJDeTq41Up6YU
 ThuH23b5Q+60GzDdtz4irk5Y6WwNuFmk2Ss548Nn5avhP7E2qOZu+dKQWwg1sgMeqaNq8jhGtAQ
 zk1Z86XPgAFdUVA607/9Xu/cI1pv8WZyzuJEIMRmQB0nnwP/R/iRtxkmMn6xIIwiisYXQvX/EMj
 4LrxLnX8zw3dVlX1z+nlJdPecv+m1ohamVavb8Q7Nm6MaWpOJwLC7hffCBFQXNMjVKZG6uKDzti
 ZjgO4+FfrOnReentjepeyFtfEOvd7pa2dJ6t2x+rkTMAB3hdwknaqwCnIBx/b5K2XMisweL6nZG
 7vt2K2+4/w3n6vw==
X-Google-Smtp-Source: AGHT+IHoFsy8zGFKUTIcywiaQPHqxUDVM/nTuZ7xE8q4iQj/IEsr66UkF+ZVyBYLROq03T1dp/shsw==
X-Received: by 2002:a05:620a:4082:b0:7c0:c046:7c6b with SMTP id
 af79cd13be357-7cac7ea1a0fmr258741085a.53.1746002775105; 
 Wed, 30 Apr 2025 01:46:15 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958e9f933sm831265485a.98.2025.04.30.01.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:46:14 -0700 (PDT)
Message-ID: <72b2d911-112e-48e3-9ba4-017a11758060@linaro.org>
Date: Wed, 30 Apr 2025 10:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] system: optimizing info mtree printing for monitors
To: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1746001489.git.lc00631@tecorigin.com>
 <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x733.google.com
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

Hi Chao,

On 30/4/25 10:31, Chao Liu wrote:
> Make the hierarchical relationship between nodes clearer by adding characters
> 
> e.g.
> 
> qemu-system-riscv64 -M virt -monitor stdio -display none
> 
> ```
> (qemu) info mtree
> ...
> memory-region: system
> │  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
> │  │   ├── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
> │  │   │   └── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
> ...
> │  │   └── 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
> ```

Nice :)

> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> ---
>   system/memory.c | 42 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..3a7faeb533 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3296,6 +3296,27 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>                              int128_sub((size), int128_one())) : 0)
>   #define MTREE_INDENT "  "
>   
> +enum mtree_node_type {
> +    MTREE_NODE_T_INNER,
> +    MTREE_NODE_T_TAIL,
> +};
> +
> +#define PRINT_MTREE_NODE(node_type) do {  \
> +    if (node_type == MTREE_NODE_T_TAIL) { \
> +        qemu_printf("└── ");              \
> +    } else {                              \
> +        qemu_printf("├── ");              \
> +    }                                     \
> +} while (0)
> +
> +#define PRINT_MTREE_COL(level) do { \
> +    if (level == 0) {               \
> +        qemu_printf("│  ");         \
> +    } else {                        \
> +        qemu_printf("│   ");        \
> +    }                               \
> +} while (0)

Prefer tiny C functions over macros (easier to maintain):

static void mtree_print_node(bool is_tail)
{
     qemu_printf(is_tail ? "└── " : "├── ");
}

static void mtree_print_col(unsigned level)
{
     qemu_printf(level ? "│   " : "│  ");
}


