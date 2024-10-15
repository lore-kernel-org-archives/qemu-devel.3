Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B5FD216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ipt-0002ka-Ot; Tue, 15 Oct 2024 10:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ips-0002kH-Dj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:47:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ipq-0006wW-TM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:47:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so2022259b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003661; x=1729608461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90HvPRdExlP1+TSTD1mRd2RVhTifk938gAnosHnNG1Y=;
 b=KJw0uSpCz64uLnjXmJZcW8URnfGiT2IQ7225Xh4pMu+vagahhPoKSmpwI5Sm3bbf51
 ZakqclR27EY3Pnu3ibkx/EihosSqJjGHx9uV8yz2nq/OlHynvB5OEXisYvcYpIVUddfM
 zmBZyVkACqddgJQoTUTbghEbyjcYGEaX3q7lsVwRHlQFFSkuE8E8pWS0uFn0sJmIGdfo
 yAOZqb91fYcQ+AHWAJdqu/Gy40ke2p/WN5SONao9g8Q0D5SgqSB+hV47pe1+eUuBgGIq
 5rwotrnHlSFJ+hKc6VMp4E8oOubBpHKS+WA+t35YrDSAGKPsVW2b0ZGOr8rwdxQfscQV
 pxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003661; x=1729608461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90HvPRdExlP1+TSTD1mRd2RVhTifk938gAnosHnNG1Y=;
 b=MVUicUOmzWqylJei90OUUcPpKIKPOix+DKGyQ8iEzS7/5QIf9Tson8ozaBE+yVWBm3
 a6YLc8HP94Y1qnCwGN+Kzngm7lWB5dYEV2ECzbSFhS5fE8fXNKcnlX70cQ7jqCIYdTWo
 YsmOKsknnocRJogy9akLvLnZKrDv5Ib8rmVk+jKQzf2TzDoRFWXHBsWn3Z5OWSHhDxMO
 bqHEvJqpd7QhlpsG0yX7L2+aNhkQwH/mNhVmOj/La8mbeNwyozY+zDny7EVz0f06F3du
 M3aB/tYE3MLVpKdp08Me9m3ZeX76d9LeuuE8IZu0HAzP9pESry34RJEPqltnrz9NeuUY
 izMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRenu9igo4cK1BCKWrENXBnl1eTm77/lXtyEVFHtGFc3JOPatRYgDqmHzqosAOfRPdI5dxsrxplGPq@nongnu.org
X-Gm-Message-State: AOJu0YyVN7l6fBhpF+2jlepUkKIA7g1MZlb0I0KGVwv32tZBY5XpDGWq
 yh7dc0rJ/tIVPSvXRy3BXs5+JUo0p9KmNRBTIB4A4ovYItxmWTUdr/PZAF+G5KwPoLhIyeLd3p4
 8
X-Google-Smtp-Source: AGHT+IFdjEJMkft1Tx/yCxSoYKQ02ZxNlmDjmaoNX9IokQOn1JwcJjSr15Yl2pjdNE6yY6kV56fkQQ==
X-Received: by 2002:a05:6a00:4b11:b0:710:6e83:cd5e with SMTP id
 d2e1a72fcca58-71e4c030597mr20511485b3a.0.1729003661431; 
 Tue, 15 Oct 2024 07:47:41 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6c11f2sm1429916a12.23.2024.10.15.07.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:47:41 -0700 (PDT)
Message-ID: <cf6da6d3-f8b4-48c9-aba8-9593951c2e73@linaro.org>
Date: Tue, 15 Oct 2024 11:47:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/aarch64: Use raw strings for regexes in
 test-mte.py
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20241015140806.385449-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241015140806.385449-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 15/10/24 11:08, Gustavo Romero wrote:
> Use Python's raw string notation instead of string literals for regex so
> it's not necessary to double backslashes when regex special forms are
> used. Raw notation is preferred for regex and easier to read.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/tcg/aarch64/gdbstub/test-mte.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


