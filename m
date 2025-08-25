Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3466CCA0FEB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqV25-0004ss-Pr; Mon, 25 Aug 2025 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqV23-0004sQ-MU
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:06:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqV1w-0002Ft-RT
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:06:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3c763484ccdso1046618f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756119984; x=1756724784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7B1h6iBFdoyoaJoneA4WRk2fx4IAUGIgXcUS7w01a8=;
 b=HXPa4trq5luvpNj9CeIJqM+SuK0dtb2glJtvjajCLLh77+TF61LE5r8F20j8PGGxFJ
 en5nHjMqAGlHtTVCEk6fRcosoAjEZnHybLfRrjv0buIH6QVdaTf0k9Qku4S2fs79N+Jj
 IY+w7XOZHXZ8xnPSMij5MuxjMaaAq62vCBNEcnUOOaRz0aTLIxgLD/RxsaoahvPPCCZB
 NFLopykuyumCgVqPDiJnwDxVEpcKZdfc+Czkh4VN1F5r4FyChGD2T4vn3YAHFRxbs3o5
 Gk+pFFyofWP/t/7IBF+cb2GmZ6rwNxq2GZf5bvIkZ8JamnbCuAAuGKi2wFUA7po60g2G
 i5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756119984; x=1756724784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7B1h6iBFdoyoaJoneA4WRk2fx4IAUGIgXcUS7w01a8=;
 b=LV4cCqPHNA0VOJbwR3ZO0O6z/ZMnvfNzjx02xEvMb6A9LYG8FSJogpmord3VMoV0dn
 512FmexmRhUU0tx9DMm47+4nw5Uxrxp/uK7052FP5AVOtmKG/6GWA7jdLvoawIU/wh7F
 n85ro6DKienhWVkEYQKZgoJf5OmlXP0OFqt/oAk1VDaQZs+vlBJSiiIOSp9/tz078P3L
 83SKRxAsJA2k78Pss/gforgLoS7+Hhv6IXBX+dzbVX7kweOAYGQWceNDoPEcZTURzD2b
 qZiyGFmMq/8j7DrRmEVXd29dSdKAVudx54ean5vOTRJCaEufCAjpEqyijuHBjNejF022
 4haA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjW9bGGroDVnIlRQ9ZSdD7aJ2GArZlybUUOCSN+bunLCVbn6MvQiXL6lzKUWZ+Cv9nWYRFIT6hKjEf@nongnu.org
X-Gm-Message-State: AOJu0YxfKc3XhVLNX0o2oDAmUStT7rcLixd6oHP20RTBdCB5MERWd0fj
 NmexqxHwPQthtf3bwkyb+bQCwu4d/ERvNMjbuLxG2Pm3k6oRX4oKnig+Ndaawj8FHgo=
X-Gm-Gg: ASbGncveSprVpM+IcpgVpc7BsgTEcJu3Sb7MS0wWEPuk6164eph1p/i4yESw0Q3s0+7
 KqW6nrIFKyW2KqXhVXIy56tWM40ZmUwACWU70oQgF/UECNlzbpnmMh0r2Z+VZO1XC8Ie/VLDKdB
 RWD5B/HrdbcMQPOWzqGtkI3Xm+RZh1BHRsa2o3yeYJpiHd2zjOOG8Gdi1f47B8SoWJ7VEBNeoJ4
 TIJl1s1o6KJ6p1LLUUbb8oPU0q+CB/+g5WHAL5dlQKxjs75rgf4fIkkFZJYa+CUDhNGxkRoQpd0
 H5jcnC1rSuf3uafzp0/ttN2fMrzk1lxKMYbP6WX3fy5y0Y3lwySWsQVbSl2plLUa5OEg6accyn4
 H2vAH2YAOgdjixTEzNc9MRBnKlO8xeTlxQvGGVH7oj3zEA4p//quHCg+3xo8zT5F6ow==
X-Google-Smtp-Source: AGHT+IHVbiY7+DxA209a+SDNjN0O/t9xMOqd06ESsCjGRaKa3e26xGXMmjMrUSmrrcxdVZT5ShtZ5Q==
X-Received: by 2002:a05:6000:230a:b0:3c9:d1b0:809f with SMTP id
 ffacd0b85a97d-3c9d1b08468mr1534329f8f.29.1756119984369; 
 Mon, 25 Aug 2025 04:06:24 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba390sm11566406f8f.12.2025.08.25.04.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 04:06:23 -0700 (PDT)
Message-ID: <74f86350-a10a-45c0-a3f2-4d582989655b@linaro.org>
Date: Mon, 25 Aug 2025 13:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/9] system/memory: assert on invalid unaligned
 combo
To: CJ Chen <cjchen@igel.co.jp>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-8-cjchen@igel.co.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822092410.25833-8-cjchen@igel.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/25 11:24, CJ Chen wrote:
> When it comes to this pattern: .valid.unaligned = false and
> impl.unaligned = true, is effectlvely contradictory. The .valid
> structure indicates that unaligned access should be rejected at
> the access validation phase, yet .impl suggests the underlying
> device implementation can handle unaligned operations. As a result,
> the upper-layer code will never even reach the .impl logic, leading
> to confusion.
> 
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Tested-by: CJ Chen <cjchen@igel.co.jp>

It is normal for contributors to test their patches ;)

> Suggested-by: Peter Xu <peterx@redhat.com>
> Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> ---
>   system/memory.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


