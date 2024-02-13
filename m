Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D41C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZx7s-0003vT-9i; Tue, 13 Feb 2024 13:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZx7q-0003uu-N2
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:03:22 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZx7o-0005Pv-Tj
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:03:22 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e0f5934813so947531b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707847399; x=1708452199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7aZcc6AI/N6f6g7Z6Zmh9kSUxPw1seB6eZD0ODGvu2I=;
 b=vs3xlMX5Vp44A4Mb3QGTyDmxjwhjb1L5F41tP2NHHCdMpQPRI+2knMYT7I7yYZiXOo
 8PeN4Xu2P9o1YNYNBEShJc8hLTOJaDOUXtU77D5bZ2pvp/J2FTwnSM07PWF7Nod5QsaW
 dbArUWPPZYIh9DkpTICURSw1z43kNEwTWHwrBLgheYBv1g1uMR8J6JI0mu3CWatvoW1I
 3EU/qzZ1PFUs9UuzxeIJIQfhdrdzs4+UJ77f1kN4BtxCWORO4mP0Un5bQn4LrDJDF+MF
 V7gHgevFH9rUCC78E1t2+Kt09OMYg2Kw8ShdDQFwYykNy19aqFchaSahmo/zyB/krkhv
 +7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707847399; x=1708452199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7aZcc6AI/N6f6g7Z6Zmh9kSUxPw1seB6eZD0ODGvu2I=;
 b=s8BWUqB8vukJKkscNBtNunOOqJiBEro8A21UTR845PfcHZVHMLAoyiE21deHFvLsDn
 G4GUK6gv7eDJsYWG/JY8jTBfkRSY8ColVpBxVyUhYC8mf2hvcq5IiO/qprbVX1Lx9Wfn
 2WJZOV3w5UF+EJR+AlC2ARPphUqfnCIq8ZEPHXhjz8ExPajOr9pc5tyHyggBhTYx0KX/
 pc5e0uWaWh08uvRDa0UPKXsm0JmKIjeVHiHtcb6ImnnwJ3XAQsW0VTXkXp1Xebz6wWl2
 60UaTfZioT6ePbEEkFU25Di/DgABV+n8DExtpwY8kmPaIpJVU1jl5S00wCi75FMPpP5y
 9ovw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYD37/whgKViM6FRQzDEYfTX0TuwEUaM/jmQ50fHMSyPRuCOwCmaFGQmUFD56kHx6XoqAAjQtff8M/WC6dtrGi38xLLHE=
X-Gm-Message-State: AOJu0YxWQYE8xCQTDz3QM+1YnL3KxwKVJK8mkgGWlBtjKi3LQAxX/Frz
 7jLpuRIhwMBGUL6ISg9J5G4GoAMvdzvERtJg2bMTs2BTusaR+zaedLkCOyh+WV0=
X-Google-Smtp-Source: AGHT+IE4zTYBqsbD3g+0vCP1FHBW6cW78nqA0Z/Mu5TwCa08oMZYRi+gXjVDPt8v5cKv1Hs+66OTzg==
X-Received: by 2002:a05:6a20:3144:b0:19e:a77b:13db with SMTP id
 4-20020a056a20314400b0019ea77b13dbmr295632pzk.26.1707847399421; 
 Tue, 13 Feb 2024 10:03:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUKOQ6F5M1PaIx7fbNu1u5OKidm8RjHr2xRqbIlzj7j4MUICbGq0IvSuwRB4/WQp+9oTpJtEtqSTT0xakAQ16mZb1z1CfwaXL6pd/6+ACLs0xgLfj9ZTpx5ObRerQpkA38j42L2xWvhEL4NPcXH0MBy9fWNKIOKEcvmsH+1srY22GUvEbEkJkHUR9nFWy+A1EGYZaO3TDk5Gmw=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ck25-20020a056a02091900b005d8b89bbf20sm2360915pgb.63.2024.02.13.10.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:03:19 -0800 (PST)
Message-ID: <02e628f6-7d7f-44d7-8668-78e23adf6c3c@linaro.org>
Date: Tue, 13 Feb 2024 08:03:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/q35: Simplify pc_q35_init() since PCI is always
 enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240213041952.58840-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213041952.58840-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/12/24 18:19, Philippe Mathieu-Daudé wrote:
> We can not create the Q35 machine without PCI, so simplify
> pc_q35_init() removing pointless checks.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/pc_q35.c | 32 ++++++++++----------------------
>   1 file changed, 10 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

