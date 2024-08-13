Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFE2C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 21:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdzDa-00065y-Nm; Tue, 13 Aug 2024 17:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzDZ-00065J-01
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:38:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzDW-0000Ql-KF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:38:11 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7163489149eso4200302a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723585089; x=1724189889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQD9cBhIPwH1H0UEgyAqbKYnyCNEru9M3fF0BEeZmD0=;
 b=agtxjWAXmql3zzk/2d4CD2dzn3aGYQyDzpZBsdFbpnlAheug36SYeiLJV/uEZ+RiqM
 YiwOA4BIRxNtoIyWwFxWsyUxFNRFCoVcDtGiy0nJNc7NsTadNnWksCA2p+IcoFbiwOK0
 dzL8vcafZhypKuYgPl/gHLvoZ9se8VkXuJTmZGxTb9vN0d98P4UolTYN85Mfms1Ryyp3
 JZjYcHF9OpPZOthDaER7f2ddZsk5YwK6QuPjBRUCnY4ZfKghxED19xmp0DkaKiAybVLf
 YB+HWpv2D8pwSHrXE+29HjFlMillnVSq79sxnUyUyOiNEU5ERkJxGXehGZstImZEx9W3
 lCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723585089; x=1724189889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQD9cBhIPwH1H0UEgyAqbKYnyCNEru9M3fF0BEeZmD0=;
 b=R6Yi4KkE1JwqOPkVisCs1+LcQxBkf2uzst+cWHzJl2It7C3Amn4xuWQYxHaBnFV5ae
 aF/gjCDlyqNhexVyyNHgojTMr746oSkjq2Y9EZdWhsGl6ndWRVid4+r1GfjJuY8lnAOn
 BUiMEe/tBlFfmq46WnaeMjKfsz9CNjeHaFCkHaBkOrkzop4Hx0QLFfKGliLBqglcXTY+
 SNs0pkEH7xaBnmvN0PaJi8QHYPDF1r3sxng+qnsyEuJuorAQC3E1KetzX5+8gjxu6hM2
 22kwV4lrw22tNmSTUCzz0NUmcOAM9qB59R1xjrajGRNCLOvBkRH6nQcYdT+CSkaqiNgy
 VbAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL0yeLGquFtAovSYM02slWq9fG0R1XSowHJ2CguUf4bvK6LM9sTETNWzquXr1WPQpTzQngK4SxUanpD4nvjKctfuPI5Dc=
X-Gm-Message-State: AOJu0YzcNPtDZ6x7jWlybn7uric1qh06yA9XQks7g/qw3bdA8kyAnL1b
 RrSaUdoVeeooScpM8VvKYUt2UXEaHE6J8ixPrfPPVi8Vtdjq1SAhRGhppPt+TCk=
X-Google-Smtp-Source: AGHT+IFFJ2dhGnMEvVjB1pb+A2jwat+aGKgEOhK8uWCAIBNmp74B+sIQJTXEuhghVAzo0ylDHRy/fA==
X-Received: by 2002:a17:90b:3ec4:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2d3aab87cf0mr1042794a91.37.1723585088219; 
 Tue, 13 Aug 2024 14:38:08 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac845f55sm48722a91.36.2024.08.13.14.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 14:38:07 -0700 (PDT)
Message-ID: <bac4742d-1939-420c-83ba-de863e433df0@linaro.org>
Date: Wed, 14 Aug 2024 07:37:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] hw/i386/acpi-build: Return a pre-computed _PRT
 table
To: Ricardo Ribalda <ribalda@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org, Andrea Righi <andrea.righi@canonical.com>
References: <20240813133936.1175467-1-ribalda@chromium.org>
 <20240813133936.1175467-3-ribalda@chromium.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813133936.1175467-3-ribalda@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 8/13/24 23:39, Ricardo Ribalda wrote:
> +            const char link_name[][5] = {"LNKD", "LNKA", "LNKB", "LNKC"};

static

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

