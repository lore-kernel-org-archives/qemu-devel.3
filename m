Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF94C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0RQ-0005rH-G3; Wed, 05 Jun 2024 19:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF0RO-0005qw-NS
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:53:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF0RM-0000RT-UI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:53:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so226089b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717631591; x=1718236391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoVuJOX4iT/2n+wq/AvNL0K6K6NVIHdTKWXZF+zFTQo=;
 b=UvKNw+v69Z2FrVW5t+Ry1l2zCdmFYsDwReov7i3c/kE6XrgUDWucawYvvT3sxHayZz
 SN+TLyZ68CB0Og+P+kwIvaWN9GX3kN+Jo/zjeI1hwjRfFW1t5Hu86SLABFdrDUwt+tfO
 wo+TKoqCXwm1nbezY1PDbgqyxL3wAScpkZlSr/R5gtllP4y7lNhwCFrXHgyNq9JrwBaR
 yuceXtdfGhw+M3YmbT0QKFsOIflwbhHb8lEcpF9myaquvFFWYKZ5/tCzGrO6nSu6JZm/
 ihI9Fv6rFAQkHsXprsmCx00dWTi+pNE2EqDOyaVFoIAj6zegzzAHGyu02oWQXMmWJ3N3
 yNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631591; x=1718236391;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uoVuJOX4iT/2n+wq/AvNL0K6K6NVIHdTKWXZF+zFTQo=;
 b=u7QKs+xHjCaCwAHVmbO0ccNYcEYSkxlgbclA4L24tQf2KkUO/JLUVZN4lKzOpbIMRd
 WLeLb+8CWcU+11RsE2fuEGKGHH+83+5JMcN7JJaHWa8eQOv8Zlo97jqOBf1MAmdIr2Le
 cp4Si4DyXjjJwL7vwg417LSmqAgGWBtrerKYjN6Kh7AeUQq4Hle0MPx3cafLAk2yaaiI
 oNbDGDeUQAdNuLFS17ENrpLt5SY6MWRsCuVB8tZyARPQBupSFHTgvEte/GmnxkglGM1F
 dVdZ0pEC5NFzfBlf1G33j63qkELNCjqmpjOu95OvkPT2u5bu86gGh8eTqRPAhJz0R80q
 Zbnw==
X-Gm-Message-State: AOJu0YxNgNAYeb0f1/VF7XDY+qFIUxtjb8Yf+bzXfLi3nD9hJlaZiXXL
 mPQ16pQOulP7xqJje1IokbXtWDze3CL9x2z+XrNLoxJXTYLDYCo8QdHR1ax2TDYfP8hCzbjZ2rw
 i
X-Google-Smtp-Source: AGHT+IGndw8LHqg2TL0KEOQABPapde37japETSmMOmfljh5sqolnktVpZZJnFtc4mHlMv29Yjyrchw==
X-Received: by 2002:a05:6a00:2e87:b0:703:ecde:fc00 with SMTP id
 d2e1a72fcca58-703f85f9f53mr1614623b3a.1.1717631590887; 
 Wed, 05 Jun 2024 16:53:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd49a787sm58921b3a.134.2024.06.05.16.53.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 16:53:10 -0700 (PDT)
Message-ID: <c6062b10-6fb4-46c3-9ba0-960e850ea1b4@linaro.org>
Date: Wed, 5 Jun 2024 16:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] sprintf fixes
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240605211521.577094-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/5/24 14:15, Richard Henderson wrote:
> The following changes since commit f1572ab94738bd5787b7badcd4bd93a3657f0680:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-06-05 07:45:23 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-misc-20240605
> 
> for you to fetch changes up to b89fb575fd467ed5dfde4608d51c47c2aa427f30:
> 
>    disas/riscv: Use GString in format_inst (2024-06-05 12:29:54 -0700)
> 
> ----------------------------------------------------------------
> util/hexdump: Use a GString for qemu_hexdump_line.
> system/qtest: Replace sprintf by qemu_hexdump_line
> hw/scsi/scsi-disk: Use qemu_hexdump_line to avoid sprintf
> hw/ide/atapi: Use qemu_hexdump_line to avoid sprintf
> hw/dma/pl330: Use qemu_hexdump_line to avoid sprintf
> disas/microblaze: Reorg to avoid intermediate sprintf
> disas/riscv: Use GString in format_inst

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


