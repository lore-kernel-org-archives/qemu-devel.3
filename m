Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A856C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 02:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLvnl-0000OV-HW; Mon, 24 Jun 2024 22:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLvnj-0000MV-7G
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:20:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLvnh-000612-CL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:20:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42108856c33so35225715e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719282050; x=1719886850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qErrVXLVGUsWCWpltTsIpHAWmnkCJE8w5g6z6C6wIww=;
 b=xOSwCca6/5ZqCGC6YMCivm1RZ/8vywgiPqEXx2CS3KFZuyzUgAaThYKVqYn7MaICF2
 L09pirW8WhkiliSLOqub3ds4mxdZFAHYJ+JkzrE/A75HwBkc2ux3GK4o5hIHeWoAG7B6
 wJS2HLtIPijZB9dunAXXkfP+RxDDFerM8aCDK4hQqmOX0GuuCuxtVSyCduUmtf067PFV
 Xl41HGJOzlMySpQFf7pA4ZQGqFNYWeAY8cVsddeMD1n/xHZ2nlXkwC+xel7tPOqH8ULR
 vFMP+2e8nTy83G3SGtkoD5a1IJPXB5dW/BZ2cUsE0abZTHx4XesiqCCEVn0khWvA/5KO
 OLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719282050; x=1719886850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qErrVXLVGUsWCWpltTsIpHAWmnkCJE8w5g6z6C6wIww=;
 b=Kd8FCJ3mC4FHI2Yd7Z3aTXptBYhnL2TtLp/StXr/ZUrBdtp2n9qMFNYZ+JQg4JqePH
 d45fmNZpfmNJzwMJ2kuHajTlaaiF7wkaCw1o3qLqOqntk/H+iDFQGwt1Emvl6VGgW6Wo
 McfzKFUQL/+E5Nq7FlKBPgNB3IrhNVdrQh+/XnkhKh2Z7pfPok0num9KkabyBdTh3aTY
 IVzj0OzfRGINV2Z8ZeOuFyzj9K0kLIZafLp/t/o5e6yxZ9hwehRNoCjXcMnMoK5oujAg
 3KBsW75zIOQPGDbj/WjEddOf3iIM0IuDESKCcRS98B6GQr+mV3RRyvNVj8l7V+DXQ9nD
 8PQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6heUAVQqvYRyQl9Xxe7Vxv4OG+tkNWmyBmuk3sPXrRyjGyTtUNUOa1tTZutiRQnCxb9i99dS8FOlbtx/NLwzdsc5Gzl8=
X-Gm-Message-State: AOJu0YzdoV+jZp+FOtWQBJC/xcpO6c67QWJnGRXfEWQW1njhJIT4EmBy
 lyyDQihqt5mBZC5k3GqUuQfYb8aOrwvIKKlj4iPH73qtO99llbEV88Yfknla6u8=
X-Google-Smtp-Source: AGHT+IGPWB5lVPZPRO+KRvbE1BWqx310iJrAM0xH0t0AUNNCBIL0qv1VJbo+KcIdStdmSeX1xi3aKA==
X-Received: by 2002:a05:6000:45a7:b0:366:e2a0:9a68 with SMTP id
 ffacd0b85a97d-366e3669768mr5374592f8f.9.1719282049651; 
 Mon, 24 Jun 2024 19:20:49 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f668asm11521590f8f.20.2024.06.24.19.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 19:20:49 -0700 (PDT)
Message-ID: <d82916f9-3f5c-43f1-a545-0f5a30c8459e@linaro.org>
Date: Tue, 25 Jun 2024 04:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qom: Rename Object::class into Object::klass
To: Felix Wu <flwu@google.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240624204400.103747-1-flwu@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624204400.103747-1-flwu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Felix,

On 24/6/24 22:43, Felix Wu wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> 'class' is a C++ keyword and it prevents from
> using the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993

I asked Roman twice about this tag meaning:
https://lore.kernel.org/qemu-devel/e865d8e3-e768-4b1f-86d3-aeabe8f1d511@linaro.org/
https://lore.kernel.org/qemu-devel/09b7e7e1-30a6-49d0-a5f8-9cfc62884c55@linaro.org/
Since you are taking his work, do you mind clarifying?

Please include a cover letter for your series:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#include-a-meaningful-cover-letter

Also for headers refactors, enabling scripts/git.orderfile helps
reviewers.

Since you are posting different C++ enablement cleanups,
I suggest you add a section in our docs/devel/style.rst
requesting to keep headers C++ compatible, by not using
C++ reserved keywords, etc...
In particular because the mainstream project is not build-testing
for C++, thus we will likely merge patches breaking C++ and
make your life harder. That said, a C++ header smoke-build job
in our CI could help.

> Change-Id: I9ab7d2d77edef654a9c7b7cb9cd01795a6ed65a2
> Signed-off-by: Felix Wu <flwu@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   hw/core/qdev-properties-system.c |  2 +-
>   include/exec/memory.h            |  2 +-
>   include/qom/object.h             |  2 +-
>   qom/object.c                     | 90 ++++++++++++++++----------------
>   4 files changed, 48 insertions(+), 48 deletions(-)


> diff --git a/include/qom/object.h b/include/qom/object.h
> index 13d3a655dd..7afdb261a8 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -153,7 +153,7 @@ struct ObjectClass
>   struct Object
>   {
>       /* private: */
> -    ObjectClass *class;
> +    ObjectClass *klass;
>       ObjectFree *free;
>       GHashTable *properties;
>       uint32_t ref;

I suppose the OBJECT_CLASS / OBJECT_CLASS_CHECK / OBJECT_GET_CLASS
macros aren't compiled so "class" isn't a problem there.

Since it isn't worst than our INTERFACE_CLASS() use:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

