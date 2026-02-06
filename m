Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D3EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUZJ-0007q9-AJ; Fri, 06 Feb 2026 17:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUZH-0007pb-Bm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:44:51 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUZF-0003u2-BS
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:44:51 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8231061d234so2773106b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770417888; x=1771022688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DidPS+ktxwmkYwPK5GE8gOP8xjTVPXX5OliVP/z+wnE=;
 b=W2K53qc4W20RBlmRTZN2pP3meqPLaEO6M+kDIhnNbtq8u5iPMciKoxvJgJKBJxhQvu
 uV8tp9zixhihR1TIGJTZWB6lrpdGaya3FxzIgEzONJnpACrFUJwm+qXUipZZ4g19R5eD
 MjKOlJUi/+jDihOGg/4dfnthk9w9UFPuqjpe/faNrtE5MWuLXXwox9xbMuByZk77QWNE
 kfezjnhXn7lQhxsWeh8u9n8Dv6ct9C3jJP5OuwFegDDRqpL0BgdJoDtFC88ojavB+9ic
 84rPIlo4tJvwfj0uPcXBZJlfvZ+BKHxN5olrIbMfyuFYHw4dJAlw7joAhsGFll5rcVE+
 frEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770417888; x=1771022688;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DidPS+ktxwmkYwPK5GE8gOP8xjTVPXX5OliVP/z+wnE=;
 b=b0OVxhQujg3VJ+iutP6VYMtvKXT/bgGyeMJC7r/jKP+f3QeVKhWcfbEwdQ10SNbMit
 RmZvAtlRu4gSnYWzcVRUXYGVxiL0dC/hfeVH7Ypu4QrIKmcsiepEC4/UCY0MZm/lWpnz
 UDOIVDARRUO63FtIeJwSNvJYqh3RNGFo4UXhQ58GmJtYV7ImRn8fWRev05TA086+SBH3
 whgw2HnbukXRysf0TpV8AV12/KXmETEVPQ+8Tvzp4og7SxtoHZ4pp59UnUYIG64CzmjL
 iGsfRsC1pB8FogIo1oDICi3hl2W5KspxSDSoEngMR0YH1nROf7azPxudDEohxcwYh6Ks
 BtVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/98mehRM2yVAqKr9oiKxURL7iS5TVB/NuWfYdM/1haEfc8/aCtm+NShn/4Q8MLwftWAERumo/q94h@nongnu.org
X-Gm-Message-State: AOJu0Yx0a8FKV1WXVNRQ73A4KpGtjmSIEsbDM9nGaTNIhGLGXxFX2BBh
 LOVAlte7KQiz2EZ/X9gdOXS+VV3+A1/gmORSJ+kHXhyQthyfSm3m02vGKzUgCqeqI/o=
X-Gm-Gg: AZuq6aJ0uhUWv8U/PhWIcQrsr0uJ9a45hDwMVdJeU/6xSs6PRdos0vcraJMDqRPEdhv
 jEC1gZrL8cnDSIlu/f+rBZV7JVyJ8h4TNGrzD19iXji519kG7d/oHH9+Fia7sdDUJeloVP2GkM2
 xWt+JdaO7ZSfFi92rrh5wNKsbtlzNhW0Spp3c81RfIJe2Y0lmV6P2uns09gPeavxhshv/zX8obN
 P883ctmKyo1gTcjwnjPLaDLBgXwonAS4UXjrlp/lkjIK+OpU+ZogN7yrvO0NercA15vrjzHsIib
 KWlR+ytU7A6rRpqiwBe6LaurHqi4/TLvrH3TPojnqfvDe/E5S15cOUR8ZrIngaYpeSo8DvA9Rlg
 2NMJI6DHI3VyX4Zk8TTNoVBVyojuMSmB7TBjBf+krLQA4Sr571gCrLhNyLEYtUJnxGu1RacAZlp
 fjUZe5som7ZJBgkRHKgsJWpYBjfpOxhHu0LsQ9MsI7rPs/0rhG72MgeTqU
X-Received: by 2002:a05:6a00:3021:b0:81f:829d:6f72 with SMTP id
 d2e1a72fcca58-824416356e8mr2903272b3a.21.1770417887661; 
 Fri, 06 Feb 2026 14:44:47 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441884b80sm3248925b3a.44.2026.02.06.14.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 14:44:47 -0800 (PST)
Message-ID: <e857ee7f-c807-4280-9bae-150e10d718c7@linaro.org>
Date: Fri, 6 Feb 2026 14:44:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hexagon: Fix invalid duplex decoding
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, alex@alexrp.com, Brian Cain
 <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>
References: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
 <20260206183813.2573541-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260206183813.2573541-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/6/26 10:38 AM, Brian Cain wrote:
> When decoding a duplex instruction, if the slot0 sub-instruction fails
> to decode after slot1 succeeds, QEMU was leaving the packet in a
> partially-decoded state. This allowed invalid duplex encodings (where
> one sub-instruction doesn't match any valid pattern) to be executed
> incorrectly.
> 
> Fix by resetting the decoder state when slot0 fails, returning an empty
> instruction that triggers an exception.
> 
> Add gen_exception_decode_fail() for raising exceptions when decode fails
> before ctx->next_PC is initialized. This keeps gen_exception_end_tb()
> semantics unchanged (it continues to use ctx->next_PC for the exception
> PC after successful decode).
> 
> Update the invalid-slots test to expect SIGILL (exit code 132) instead
> of the old exit(1) behavior now that the exception is properly handled.
> Add invalid-duplex test for the specific case of invalid duplex encoding
> after immext.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3291
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   linux-user/hexagon/cpu_loop.c      |  4 ++++
>   target/hexagon/decode.c            | 13 +++++++++++--
>   target/hexagon/translate.c         | 18 ++++++++++++++++--
>   tests/tcg/hexagon/invalid-duplex.c | 28 ++++++++++++++++++++++++++++
>   tests/tcg/hexagon/Makefile.target  | 11 ++++++++++-
>   5 files changed, 69 insertions(+), 5 deletions(-)
>   create mode 100644 tests/tcg/hexagon/invalid-duplex.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

