Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6992FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hab-0004B3-7U; Mon, 22 Sep 2025 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0haS-00049n-JW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:32:20 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0haP-0000DI-2V
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:32:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so3962528b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758551526; x=1759156326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=61Vl2O8t7aDJLXy50s5gByuFUKV2XCcmQixPh0ATBm4=;
 b=whGIf9JoqHUuLn8SdTN7amQbaKEzWQc+O/v6//lfS6yadoZnYXfoXWYyh9jT7HN1Up
 Gu6k1TlPGqBgRjGTjmWBemP3A2W/VHveXyTkeVk7PHqxFkvpvIgcebdPWLXD/AUlkSsv
 9RMeCb/cQb7mCpclARFHrH8aXH0ZXfVGQi6sD2FtPA49l3kf8keeJsFKw8D1rgTIcYYO
 k3d6y5kC8LVkhTFhpsBN822UYePJab//yLSX7w1MczO4xe+/v2X+wjC+Xq+WBoevyvk2
 7wLGAm4f3mRV7kF6myEN6CS/84FtuBIT9hjzcRYnt6AsfQtg6oGlrg6qWHQ3k/WXPdTB
 0l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551526; x=1759156326;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=61Vl2O8t7aDJLXy50s5gByuFUKV2XCcmQixPh0ATBm4=;
 b=ctQn1GWrPEvf8M7YpnJbGJslgzWPzLFxNOz79I53gJ1kFrkcRpftWMjn3ms9yh+pBp
 PpOh5DXDzAb0YYfmK1dmPMnFlgSRokDKC2idzoKHZxow4J/abc9BX63zc4YWmmaLFG8Z
 ffNLbN6W3NrGJylvYBl9c7i3nlSf9YkcOT584Sp9UnfsGc8wI4cPfAKh9cv31DVulvxg
 t7llOsEupY4izCx1WxmgADPj5S+ZLnSiWp2ezinI4f4cRwXmHGykFDUBbi+9RVzwB/sj
 GrEM0YrJrCQbhozQiUsIW+zvJzNr6eP7xnv2X2R23oBqiSiUfIGjwiunNgAGwKZqFYQL
 WLDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmKmD5Mju3Vn4jQUL4bo44HtAViEKbLd6eRVuSF8EMWXNjQMZ3FNbySpSfQ7XhMyUmHnXuuyORuAEQ@nongnu.org
X-Gm-Message-State: AOJu0Ywfw8e9cZL5Ne/7KHugoDhotMnF30nvDBlrfP+jUmAY9Wvk8R+q
 SLKT1EEOj+dKejuuzKLDHaOlaktlJZTVsIgUiwHO3/cdx7Roz2OJynLAoWgyidiU50U=
X-Gm-Gg: ASbGncsvV6lJshUKwFub9e9alMLRENvMUpvoQjG320hW7s9nu4Z6azQGNchY6fDWJ3n
 Dv54EQngIC2QXoaSd0TL2MEfLfFTnbqj+rz0BONlTGeL2FmppDREVxjeaoLhbQueTlfYbrtsV1U
 GhmtVhY1BePcjzM7lxa0gMlkzsR2vKt+Qixvj0i7XGs8IlLXhGd1FoQZMuyQcZfpPg/o1ux1dLO
 lMnhzKCDCIsIDJcuIZmp55AleQ1a765Rb1jWFIGOYVmVxvwi3Nc+MYAEOoK7ALRAHa2rx2oW9uJ
 WKoJFJ7pfmBj8ACEgfT5YsGmAMEimby10ax7fmGPJK11EKntj73mjSB66ZG3E0MfTYZXDsEG7H/
 iKzriMyazm5wkDL2EeKvW/BpMkMT4KcQG3p9q
X-Google-Smtp-Source: AGHT+IGEQdG/SLb6Oc2OnAhauv+4sG125z6WL+B9v6oNPJErH+eyd+aG7WUQJQFhWB/V0WHFhcw9Ow==
X-Received: by 2002:a05:6a00:bd13:b0:771:e5f3:8840 with SMTP id
 d2e1a72fcca58-77e36935457mr15328439b3a.13.1758551526370; 
 Mon, 22 Sep 2025 07:32:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f1550f70asm8102954b3a.13.2025.09.22.07.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 07:32:06 -0700 (PDT)
Message-ID: <f30fa0e6-f69e-4f04-9182-5c2a4971c7f7@linaro.org>
Date: Mon, 22 Sep 2025 07:32:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/loongarch: Move function do_raise_exception()
 to tcg_cpu.c
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250922073400.1308169-1-maobibo@loongson.cn>
 <20250922073400.1308169-5-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250922073400.1308169-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/22/25 00:33, Bibo Mao wrote:
> Function do_raise_exception() is specified with TCG mode, so move
> it to file target/loongarch/tcg/tcg_cpu.c
> 
> It is only code movement and there is no any function change.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c         | 56 ----------------------------------
>   target/loongarch/tcg/tcg_cpu.c | 56 ++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 56 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll note that loongarch_exception_name is now only used within tcg_cpu.c.


r~

