Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5B3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 20:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGLR-0004dW-V1; Wed, 31 Jul 2024 16:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGLQ-0004Xi-ER
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:54:48 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGLO-0006QA-Q1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:54:48 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so10323012a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722459284; x=1723064084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rV3rIxm7JbaltMtQssOzRfirXzXX9cc9N2Wm/RGHImI=;
 b=LBFO1PPokBLGb/IdYo9n9i7SOPJnPbrx+WVvZO1PrHYBlQFRH/SiyPdW30PEhMIAdj
 F3HyUFuRbMj9NhOab6MLRptymzujxFucpOX6GfgD3i6y6Ndt4+bUH43lxsTD30T3VyKL
 U3oEbAFBhKTA8BDmz2j+TmvB01ZCOEx2Wr/6ifsiCrh0U/YEr56GU8IdCvXDYadiGdvP
 fziv3qV7zjKlDBx2LN25aKBsw/+UdSmU9VKsy+6766TNjSK441c5u5ttieu8ZftGq5mY
 a/0fpvLWZcSwe0lqnQWwbFeawhyYb0tbgS1Rw/xDVggpigfu4k6Gy4SYws+FW8/b2u70
 OH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722459284; x=1723064084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rV3rIxm7JbaltMtQssOzRfirXzXX9cc9N2Wm/RGHImI=;
 b=trd2z45AHOkzDIT0RHUilxTU3g1yg+Xi/VL4JnU9X22K5D2OAdjf54jCIuQYgnRn1j
 L/Q16fDXNEKyqhea3yMcyC8Hxg2R70ipVRFHZebgozDxF7jAUhWc/4r5mItXktXS8Lj6
 JIGZsmhGqnj/QMcfqtR/rMv8eZGzW7ErtbGa6ty1JUoSAzfFU9yqrk8p2vwe2XnGMh+E
 Cum9ojTGfaPiIbFvmlP5EW1qjQjWDQd0vVCXk7qVTRowawwUhMreeblTvGx5JWlTDrMd
 6U3jbXTk1UkGTCkdamvV4AnPUjPIYkjqwwAwtGU4HjuQaziA08dNcZQEA4O/APrE8pla
 BNZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJsMaVUk3Ioox10qNqstAN6OD2162D4cHMiE58ETvsgveWkkVnAGh1JhK1xvDtNl0gDxUKEwD1sqz1kqxbovH1IsJ/l1M=
X-Gm-Message-State: AOJu0YwhVZpbOZNBGHgy8nWIhuCCAMg/zHqYTIGmZAv5so5xSherUcNZ
 90iIPzGNMa/ocIdtmDBJg7jkppSgmYO7ZQaQhx6FstpSADJT2oNk/UlJrR3HWgA=
X-Google-Smtp-Source: AGHT+IHemfMaEi0BvAQeP6zqvAeTK8Fvl81iPwLD6Ov/n0WWBlR5uejAICPIMZ8BM0KEzDIS9xT7/g==
X-Received: by 2002:aa7:df01:0:b0:5a3:d140:1a52 with SMTP id
 4fb4d7f45d1cf-5b6fe72e687mr134126a12.3.1722459284456; 
 Wed, 31 Jul 2024 13:54:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590cedsm9081757a12.29.2024.07.31.13.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 13:54:43 -0700 (PDT)
Message-ID: <33eab764-7e7a-4116-977f-c653f6568cd3@linaro.org>
Date: Wed, 31 Jul 2024 22:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] block/gluster: Use g_autofree for string in
 qemu_gluster_parse_json()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731143617.3391947-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 31/7/24 16:36, Peter Maydell wrote:
> In the loop in qemu_gluster_parse_json() we do:
> 
>      char *str = NULL;
>      for(...) {
>          str = g_strdup_printf(...);
>          ...
>          if (various errors) {
>              goto out;
>          }
>          ...
>          g_free(str);
>          str = NULL;
>      }
>      return 0;
> out:
>      various cleanups;
>      g_free(str);
>      ...
>      return -errno;
> 
> Coverity correctly complains that the assignment "str = NULL" at the
> end of the loop is unnecessary, because we will either go back to the
> top of the loop and overwrite it, or else we will exit the loop and
> then exit the function without ever reading str again. The assignment
> is there as defensive coding to ensure that str is only non-NULL if
> it's a live allocation, so this is intentional.
> 
> We can make Coverity happier and simplify the code here by using
> g_autofree, since we never need 'str' outside the loop.
> 
> Resolves: Coverity CID 1527385
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   block/gluster.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


