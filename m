Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F72C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpGd-000098-GJ; Tue, 13 Aug 2024 07:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpGM-0008Sx-Nl
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:00:26 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpGK-0004Tn-Lr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:00:26 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39b51ba15dbso20986445ab.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723546823; x=1724151623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SeKTHGCXlpIpNbntnq+vvKArf1Tk6En/T8fhQjJpBKs=;
 b=tStRp3Miu4vljyd8bn0dKVWNoO76TcddvP1s/V3PRhlp7OGd1jZlbTkAhMU1/ChaWC
 sNi7vK9gUeGVHfbnx2GNVTMcsSnXxQk8Y+MSgbnDZj0m9rdl9/Ov112djrebv/WLaPYX
 0jae0BQxs5wYfwG/W2jsXs2SpQDlFXZxSpQ+tXaGG6ZK495VtM1hrvzWofHnmeYLg8u8
 v03e2Owiieg71CKFmw1JybxFDJxKZCCN1mk9K6UPZUBbGEC4ZXiYFiiVZ8hKATUq3RCh
 r2MBoLuRRx1hlX/Bsfc++pfPT33omINYigIlUi++ALpfVVTWMYYza3p9F1NW7yIpe7hX
 lNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723546823; x=1724151623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SeKTHGCXlpIpNbntnq+vvKArf1Tk6En/T8fhQjJpBKs=;
 b=cyZBT4uPWo2Pn1OxFD0TfXcTtajA141YKk8Gw3jGEZUZAYu+MjWinR5eEHPz0Bawt3
 +DVjXrl+DXFdgVXtQ7qTj6NQ0Tq/DPO+DtBTYGzebM1JAgipRSMoiaHPEwk2rqOUrAp4
 Jl+iPmN0u+2XLPA5or/xwg34LmKsBDc2jiyv7nHN9EhBtOYq6MJjsFCan/SAltFtgZyu
 DTTRJ0N78xRwnM/9sjdvMHECReMmwszKVVtsl4TfBlfxAn2hOfaNmj2CQQIhO6pDT4hY
 HvFXXWfIKB1Vqjivjp56+JuE/VgsqcJQb+XG+i2il6A9GN4V4B29rLt/Oim5bT5O8KCJ
 hAtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaUJaTrKLEGoyftDhqHfFqjHwNsxF6z7z0dA/3V8lOboYbLWQl98yHzUVtBcXIkzQ8wSNrNQrCzL4rISLFBNBB+Gi2Uv0=
X-Gm-Message-State: AOJu0Yz1IpUaNmNQnNmXjCEuFicj5k00MoqLsXIaJupnaIUD/UIGzySb
 ingo8P0T/8a8aOM/qPlQTt6V70XswWJbYiXIRSFDaLEWXBKiN2XGkF2oxFu/Gc0=
X-Google-Smtp-Source: AGHT+IHJ3FlX1eSuT7jfaEk+IiwWblc9uN9ntex4N72mDQQ4xvu/+c1MJliZ4JDGwnJ9d1RwBt0LOA==
X-Received: by 2002:a05:6e02:154a:b0:39a:eabf:c28a with SMTP id
 e9e14a558f8ab-39c478b30f4mr38339535ab.20.1723546822726; 
 Tue, 13 Aug 2024 04:00:22 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c697a06af5sm1200407a12.45.2024.08.13.04.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:00:22 -0700 (PDT)
Message-ID: <551ca808-a865-4f80-b35c-c6c02f4bb672@linaro.org>
Date: Tue, 13 Aug 2024 21:00:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 1/2] target/mips: Pass page table entry size in
 bytes to get_pte()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240813101856.49469-1-philmd@linaro.org>
 <20240813101856.49469-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813101856.49469-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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

On 8/13/24 20:18, Philippe Mathieu-Daudé wrote:
> -    if (ptei > entry_size) {
> +    if (ptei > entry_bytes >> 3) {

Shifting the wrong way here.

r~

