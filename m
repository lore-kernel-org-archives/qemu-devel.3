Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFAD132A8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uGH-0001md-MT; Mon, 04 Nov 2024 05:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uGF-0001eS-2b
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:24:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uGD-00085u-9v
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:24:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso49435335e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730715876; x=1731320676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XaGIoCMH1NOoXkHuW5VAXIlTmI5m0h67iZJQ9SupAs8=;
 b=xafiLtdWD9NK1Zt7AsaT5p9p1E5OYfWe40Nfb9z7PCLNjKW8R7hqH4e+zLp5N4tj9v
 Q+vRF/zxtPQZYmWwjUTXkYufpKWBroMVWp45DZ4UirW84gvklQwcdm82hAjdSaKfj061
 0u/7SihP9+Pb0t89ntH2kH1YXPK8ryFBxI374zhQVSHqDHew897SXKaZQygzc6+6P4vL
 rYFz35DdI7ctUlQDsUJ5XU0/XfSIccNtSabLCXRPvtpDSSgorAqLTTeT3JVuwinGg4WD
 5ZPUATDzh/sqBgDu6ERqtyBDxE+EjBHq82MQl7feBjPmqPl3q6URu/BVIbo1KgiNsjtJ
 +ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730715876; x=1731320676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XaGIoCMH1NOoXkHuW5VAXIlTmI5m0h67iZJQ9SupAs8=;
 b=p9bZb29f0ckpdNuYozbgeoLj8umRBWkGwOG60ml5P7vMSxkVtoBmyOMOkKI+l5ZACT
 1UngLTXB368KfQmfma9A7t25mH5lmCzvFZ5rcrm992xgqbJjJlbJ6qZ/XoGlhvmqiJbF
 rRoItZ5Y6XsNtBU8BqqGkgemDY0tSVk2mNdCIKSl85QTV8g1l1jWWKoCM0NzjzZcITLW
 CzLFD4ucPEcbmFrgYazDhOZL6FK6kZL1VZ242NA5iouXo49XX2o/vbax2jjI0e+ZQSjw
 6i4EYxGIkOGntl/h7JsHS6EHuMyNNcySnnD3C9iuxfvS7eq33zig5HirzTO5sJ9lEmZ6
 Jfaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnWRonAkZmYiesisb3xMvgi/Fv8OmcEY0kcQdVGDwHNLmJPT8KcFdesv93c2Y8kcbDB3pihLZ5fPyQ@nongnu.org
X-Gm-Message-State: AOJu0Yyn8+w+s5D4+PgU3d8JuddBcD4aQPVv6cgKUPhxPgJtwnsZQVo+
 ri7k2U7KusYIZki6PzzWAH8NY+4t5I6oZB9u5S7e2Sycydk7/h3H9sOdCblSvhk=
X-Google-Smtp-Source: AGHT+IEmMlPhkuIzkG/DoDU1mJuKP3Sw5U6p6ub5TUR9saNKTw4xolWY6XZf8Zk2M78MqJG3YQMZSg==
X-Received: by 2002:a5d:47ac:0:b0:37d:48f2:e749 with SMTP id
 ffacd0b85a97d-381c7a4636cmr12352536f8f.10.1730715875654; 
 Mon, 04 Nov 2024 02:24:35 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7f80sm12867621f8f.20.2024.11.04.02.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:24:35 -0800 (PST)
Message-ID: <746d1fa4-aafd-415f-be67-94a7aee0b9de@linaro.org>
Date: Mon, 4 Nov 2024 11:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
 <20241101161125.1901394-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101161125.1901394-3-peter.maydell@linaro.org>
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

On 1/11/24 13:11, Peter Maydell wrote:
> When calculating the index into the GIC's GPIO array for per-CPU
> interrupts, we have to start with the number of SPIs.  The code
> currently hard-codes this to 'NUM_IRQS = 256'.  However the number of
> SPIs is set separately and implicitly by the value of
> AST2700_MAX_IRQ, which is the number of SPIs plus 32 (since it is
> what we set the GIC num-irq property to).
> 
> Define AST2700_MAX_IRQ as the total number of SPIs; this brings
> AST2700 into line with AST2600, which defines AST2600_MAX_IRQ as the
> number of SPIs not including the 32 internal interrupts.  We can then
> use AST2700_MAX_IRQ instead of the hardcoded 256.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/aspeed_ast27x0.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


