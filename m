Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3652F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPfp-0004Vg-Iu; Mon, 13 Apr 2026 18:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPfm-0004VJ-Tq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:22:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPfj-0002Tc-Ta
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:22:25 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso1358166f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776118942; x=1776723742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MkEo2tqWfrRY38XhmcG25pXIT80ZoAFjEOHm2ctnvVw=;
 b=EaGtZL79jH0oCR4t5fJKdIre4BdzbIJwWclvJIvjufL8DKq8VMkEpuf3GG0YRo9N7J
 HHr0kl6zFymZ9Cj7//Wg5CwuDD90v8XHaUd8dNXBpMzLqaXVjzn5FAUmAGr+ViR+5J43
 7RI4vPxhl9M8dq9rgOkMSc/9PM35XVPtxe8lNHTeG7OUHZzyCFACsIoH5LHDsWbWR4rL
 AfVdFcyP4JMKB4FxposhgUY1ar3xh850o1+bF+tga9xGyhH6N4u8JJynlnZ9ylorpKpT
 NE1sO5D6oAyZrInbKDdiLiFTnw52He51/Aq53xytkYpyVbAFRek9I+EWOljCQzuEDnm3
 EPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776118942; x=1776723742;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MkEo2tqWfrRY38XhmcG25pXIT80ZoAFjEOHm2ctnvVw=;
 b=N8Z5JiPSEgFwZI5i2HR7lTbET3flHigG8eL15EaQo3G13uqHZEMkWoYgLF0T4e2cQt
 qmwxqtF2DibeDBQi1Gj1FwI4rCPV9Hb/p5EzMAWMRbYRnqin7imVbSwl9R2uMb18ShsE
 JFF7L+eaovimYoR9ZRTlIU9SBSoFgFhEkYrKIxiEbJSZ4lbVctBeKiopV/9D09GW8F41
 FrYSHa5ZLye1Z7hJhAVCE64FNDl41J2KyAKZOduFCTlPpnHgfGQuZ8EOEh3F1yWzoMfX
 g877a4Ix/W2WUtkwt9YLObxVopHjKv9+CTyh3f6GihnObte/XlnfBoQX9uqK4jICH1o4
 dROQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VOpLLt8f5hT6zMXkZOg98GHlfUBaN3MlJsN0SJZnRbuIZchm0SkuB76w5zhmoeYTCYVnKedjy6kPJ@nongnu.org
X-Gm-Message-State: AOJu0Yw8xxlN2kSEnXc++vG6nb970oN9BPkaCcMRDWPzFAfh/xJkzeDa
 aB2G6xG/sCNiWVYUAvx6nTA/xE2v3VdJ0xTbBfEiwrsKs2jF8lshmGVYLtpRQhsiYhE=
X-Gm-Gg: AeBDieulifP4KClxqeXKEsqh4NDIxVOy3/4jVzGNjJT7GTCXouLjIujyUWt7FKbgZXu
 iPdn3W+2bUXobvJ0bKVEl3WAjQ3cNHUIe8qVneQKmuOd8UjHhs7vz3pUZ1xNP7GZin8c5JQOakN
 B4aGBn6mzAtYDbMYYuF0d83Rara9xXF+B7OuT7YmHmqEAyTzh+yy0A7mu1ydor+gJwtQBq23hQV
 UgjJTEilUkYvdMt+lu8+8lN4OFjhgAnH/36BT/1bkVISN358C9gmZUTf8AZdBf3xHFmXvdrXmcH
 rUi4M6aJ42ArGtrieTb69cPCxLKh0w7IJXg4eCLzO5RgnlAUncW3uHIZv5ghGKxqFcG5MR9DC0+
 nhWmATmEKQWynk5DX9OqFWCwwG9NrWmEbBKDMwdTkB+USDTe/OH7CNMsUnOTzffnTH4xEdVYy+c
 iX+iDXcDShC+2cdQuVJAf1HpHKKNQlZdWHUB9B9GE7BC94me7xBHx7m53iqi8H34T8qA==
X-Received: by 2002:a05:6000:40db:b0:43b:86ce:27a1 with SMTP id
 ffacd0b85a97d-43d642a5095mr22561168f8f.17.1776118941676; 
 Mon, 13 Apr 2026 15:22:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7a6054dfsm10416745f8f.17.2026.04.13.15.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:22:21 -0700 (PDT)
Message-ID: <deeb42cf-2ef8-46b9-8cf7-3b6b32b88cd6@linaro.org>
Date: Tue, 14 Apr 2026 00:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] bsd-user: Generate the system call numbers in meson
 build.
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
 <20260413-syscall-nr-v1-2-f70408d042ea@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260413-syscall-nr-v1-2-f70408d042ea@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 13/4/26 17:31, Warner Losh wrote:
> Build glue to generate system call numbers with the meson build.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/meson.build | 4 ++++
>   meson.build                  | 2 ++
>   2 files changed, 6 insertions(+)

Squash with previous patch? Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

