Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C93C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPNK-0008Ve-Hz; Thu, 18 Jul 2024 07:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUPN4-00083g-1c
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:32:32 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUPN2-0004Rt-6B
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:32:25 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-59f9f59b827so865065a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721302342; x=1721907142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ryIKyPb7RjkROR33Ga1OGU7ygAznzAr+5J1u0kZSIeU=;
 b=YbZwzAXgGf+UNyBfWu9CiY1O/Te8UDaqWkcEG+g35UGgC1G1thP0kEVXQ1EuXUEW86
 SwrQLAhJhcjTXzBWv6OKml2dqk4RhGkIjauFLOVr8KHvSA5jUlWl/rXwDY4MZ40K/IW2
 LU4rsc6yBpGJ4knZOvHTejipCdMRj/CCVo8He+tDGej05woEUu07csyun3rTd8ciQaZj
 aj0SJXWBCstCUCIZsEWjOp712+voyXEGwCwBjZSXC/howWYjHH/U6zMrxNCITic3t7At
 QKRprxaOLjX59H34M+jxokCNkpMsrm3L6aTPWL+qGoYpSn9LhuSe6WrQXLKJXjjvayYS
 l9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721302342; x=1721907142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ryIKyPb7RjkROR33Ga1OGU7ygAznzAr+5J1u0kZSIeU=;
 b=hcGYzp/xvKMyGP6SKutYASJ5usDoROdnmzbmx70hD6arGr6cFl6zJXAZ0s/NYYvD9m
 vIR94O1jr6dNvsdeM5nqkhr19pgyXZxx+a3y9rNJBjGcI5miy5owFDH5ubuughma0IDZ
 zLrktgHyGM6NQh5Rzq6k5T2oI8jY7WfeVPlpv4Vhp1O1f+cHul6COQT14rhG+O4LX2Hc
 9plVD/epKwUTyJXoYG6r4cO+xEOFpdzxXO5tUYN7R0jjmmXhp84GeFqQPCjgKc2LQaUp
 rH8Vh/WAuEiY4WOPm5XoH4BgtmWygOoFlnDN57U4lMcQyrNqSykQZXcAGd4a+NgaJi4u
 QURg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2xL4XJHh0uxXoObRgxif54CLkrp1soqFoB5pQPJ32LVUZXi2FMOm99By4zsmm4AIuvhNBhAJV33L+U4Ut1PpBweWlkuE=
X-Gm-Message-State: AOJu0YzkgpmiCFQCt4eMvzTde0HKq9VHTcF2q8hdl86kpb4tSCJ6HzTP
 hP5OPSvLuXBLaKPgem1JVfVice6Bid3aNQp5yYuhK122tfie+jSKFbNRaDMwDgM=
X-Google-Smtp-Source: AGHT+IG3IJ/43HLG6tMGubR4equSkkgvVKLiD1V1GQijfzXIvwg2UMnDOAvQBKco/yPgxQAYPKw8Mw==
X-Received: by 2002:a17:906:705:b0:a77:d0a0:ea6d with SMTP id
 a640c23a62f3a-a7a01145908mr306994966b.24.1721302340856; 
 Thu, 18 Jul 2024 04:32:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7ff9f0sm548113066b.160.2024.07.18.04.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 04:32:20 -0700 (PDT)
Message-ID: <b9851909-5b68-4dab-9231-044ccd138f80@linaro.org>
Date: Thu, 18 Jul 2024 13:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] tests/plugins: use qemu_plugin_outs for inline stats
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
 <20240718094523.1198645-7-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240718094523.1198645-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 18/7/24 11:45, Alex Bennée wrote:
> Using bare printf's in plugins is perfectly acceptable but they do
> rather mess up the output of "make check-tcg". Convert the printfs to
> use g_string and then output with the plugin output helper which will
> already be captured to .pout files by the test harness.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/plugin/inline.c | 58 ++++++++++++++++++++++++-------------------
>   1 file changed, 33 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


