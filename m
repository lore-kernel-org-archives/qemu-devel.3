Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3620DC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUOM-0005AO-3w; Thu, 17 Jul 2025 15:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRyk-0003rK-Bx
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:01:09 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRyi-00012m-8X
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:01:05 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e8d70c65abcso663747276.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752771663; x=1753376463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7wp315y9iORLm1It62Sfp8STPRHaleSwNrWhxfXR45w=;
 b=nG5zEGWHJztLE3CCHd+J7228VYMweDiXlxMgML2HVD3C6gpMQXJ9xsecVjqOvSQUai
 TLlLhsBRIMKWw7BNEj8CbXqrrxXLyCrikQ3Zrp/vRcpp5fccRG8+AKwVlWrw83rkv7bb
 /LW4Os4Z6js4VUgl5WT5wWjvx3rdjXOKe/BLecT5yExaScQ+FK+5Hh1AtqBa/X3cLSfA
 qjIy7qSKEPQl19RwWfDUJdm+aD9d+SOuE91qFfby8k0U7Cl6QnoAycHb6Nkk/c2jsyc1
 dId8E8KRDz7RL1BJWDN53TzRJxGYwKcj5d3tCvO2j/2fOwG7L+fbKFOhlgRVCM6qBki9
 t6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771663; x=1753376463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wp315y9iORLm1It62Sfp8STPRHaleSwNrWhxfXR45w=;
 b=JbaeV3v2yAxEb4XF4pFwxl4aYY4E4fi7XSS6ItsrsLM72bPPv0GLynB+FHvvUO348r
 WZEr1b0dnPdRvLXYzoKMfgu511Q/jsfHnU+0OCwczb/LCjnC0KW2kTLlZiQggv9aM/vh
 NTCdsstWS+Q5+2MGxYNdYb5rq8HIaTkxc8qdWpGkMXdE2ji1LWa0EmF2AE1GPGm+JE++
 zQPTijL+asrtVr0yAEVSAgbJQitdx9bqxBqelZD0NvZ94svlH5GjNc5jC7eoxaJYbwBT
 0X/keO4YbQ780LsFZcMch6xrYzOQA1eCWwXvkA8uFIt7UvK/Wda2exOuFikX75jIbgI1
 I8Ug==
X-Gm-Message-State: AOJu0YwE0kSaYY8FJfwIOfZs4xWim0iDgcSBF8S+B6SoMqjSFkUDAYrT
 T5epD2X3QWg3noB8hUqrowZcGdoMJ5FaAa074JECKzlpMmIm2kNoYHY4bfnAmnDDbEzUS5CiDud
 jeTls4J8UUXAkyLs1lKQSuXK30TthZrCoUvrpcBtVwg==
X-Gm-Gg: ASbGnctL32+kQpLSVTOMNpHafaSi0r4GeUqwl+7hbtP8cB4R02mUzlBrR95L2S1WWWW
 cgeh5henVbo5Ly5UySEAPSlrpYabhL+6oRRZz0p/wwkApey+kS8B78x10Ha8z8/7AGMJCZZ9g8H
 Y+6Zbi55Gvm86zbRbVSZ+dne5I0IvN1D9IHbg+0quqHbFtATw6J7Ycf0NgVyhK7kz8dOl4NX/cM
 3F6KCLK
X-Google-Smtp-Source: AGHT+IHN5qYz/FrWQ0VqwcyPSyHOHuXifbW+bQ1Uoc/KrVcL2BwP6Y43kCAhtcPQWzUqHjklMgsurOuabgIGd2hd0ok=
X-Received: by 2002:a05:690c:350c:b0:712:e22d:a235 with SMTP id
 00721157ae682-7183504278emr117149807b3.17.1752771662665; Thu, 17 Jul 2025
 10:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250716002622.84685-1-jcksn@duck.com>
In-Reply-To: <20250716002622.84685-1-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 18:00:49 +0100
X-Gm-Features: Ac12FXzFWP9AgWgEJ60Jcupzar5GSKrNZAuMTqaWqRPpDJVROW3gm_ip8GToIJc
Message-ID: <CAFEAcA_UNG=7fcUqy2N8ymod558JFuMBb9ybiTXZvip7T7n7kw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/max78000_aes: Comment Internal Key Storage
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Wed, 16 Jul 2025 at 01:26, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> Coverity Scan noted an unusual pattern in the
> MAX78000 aes device, with duplicated calls to
> set_decrypt. This commit adds a comment noting
> why the implementation is correct.
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/misc/max78000_aes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/misc/max78000_aes.c b/hw/misc/max78000_aes.c
> index 0bfb2f02b5..d883ddd2b6 100644
> --- a/hw/misc/max78000_aes.c
> +++ b/hw/misc/max78000_aes.c
> @@ -79,6 +79,12 @@ static void max78000_aes_do_crypto(Max78000AesState *s)
>          keydata += 8;
>      }
>
> +    /*
> +     * The MAX78000 AES engine stores an internal key, which it uses only
> +     * for decryption. This results in the slighly odd looking pairs of
> +     * set_encrypt and set_decrypt calls below; s->internal_key is
> +     * being stored for later use in both cases.
> +     */
>      AES_KEY key;
>      if ((s->ctrl & TYPE) == 0) {
>          AES_set_encrypt_key(keydata, keylen, &key);



Applied to target-arm.next, thanks.

-- PMM

