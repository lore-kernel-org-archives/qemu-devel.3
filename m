Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F03AC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQ8f-0001Mz-61; Mon, 28 Jul 2025 11:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugQ8X-0000PL-2E
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:51:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugQ8V-0003U7-0k
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:51:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so1268336f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753717893; x=1754322693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yy5Xqg7XGt/hZCXa3nvoa929f9FQ2BlegZ6uJ9oJtcM=;
 b=seupnLV8Bcsd7z/KkYSycHcmVb6k6FqY9ZZo1wBRPzdNYPtpGdPBAWabLrtBA3YiVQ
 OLuRM2OQ/T5ZKx/CE4kKDxYguO9H12m4Ut1cXJW6IDpmrA83BjcwOOPgT4Zr7BRRSgxW
 kVUGzF+Gs36cJLJQbF2teTjqOeTao0QU8L+PD6c2FRTXscP+VPW0E6dOv6IEFjLbJcwM
 HovEWFODQS6esIoa4M35Y//q12cF4gAz3AxwSow25T6T+Gm6G/hQXp5QygEVMZFh6GE9
 RYjHYyngidUkiBlHByrYK7ChJVV8pjXfwJBTsGhqhqqIGWNfW8GZaxtRfdDgfhwzuG/+
 DBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717893; x=1754322693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yy5Xqg7XGt/hZCXa3nvoa929f9FQ2BlegZ6uJ9oJtcM=;
 b=dRNkrMdDWJOn3Vnc5vMu7cjq/RG9w1QvWZtWWO5jPj+jkCr1LoA1d2rlDvigSla/Um
 k9CtLLYKoSsqugPK9sQmqUXwYu5ytDLzJ/70WIoIR1EwpFz6Qx73mI2nmf/8MxoOJYtw
 rUp0l0ZogxgP2f/Af0J6rJq6CLL1pt0CfWKpRYb3nKimW4yXUIgVJKBVCEDxkza4LSmw
 s4fJWmzKM8nNc14zc43h67dsNAwOIzC/w/h2Q0GAjhW4qj4l/Rxnsk+CJUaz82ujKWSy
 Ld5FpdV4491uW8TlBm0KN8/ClwUG0sn26tx/pyoR9N/powe6uPoEzBs+KQ/YQMheBx+m
 +2Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkoWypVU0Gj/Z6hE0VrZIh0KsVPhVLpBcEprYWUFu1gR2h/dciW2F7EVUeJtn+FsybQpMNBTrtMtsm@nongnu.org
X-Gm-Message-State: AOJu0YxTazY+WjpJEZ6cGM5nnk2+Z3PdfnDDkZbC2cmWYHI2UxRhEfAj
 tMiwmH6VeF/WrX/K9VxonNJDlpkpswVL7XrVFaVznUPBp5SAxsNVI+6jJSW7kyLS4LE=
X-Gm-Gg: ASbGncsFyYX0aeFdQRiewZ7y9L1E2uMytkL44rqlbmbHUeVG22kGaUtvq3/qX4bPbUu
 EWGiBkkCPUDKd7wJPcziy+U/d9Df1B+mA00EVwVT5pilDHw5CAAQ1isH4NYanmO1fkqquKJBf6a
 p0K3jt6vHjxZsw8gtjeHC+G+xxFmubsf5OpffQJmsjETJgXt+a45599hFXmv/b2cu1nDCPBYvhx
 adP3Mdcvll8ImkyJWLwx4ORa+Hy8mzfkJ+H9Lqc3Syxu6O7Fw5JFHTgeK4+VfcGV7TBW+6FxBA1
 Z+unWGLsl032VSW0InoPho1H6F5qkS3sphjt/X5pLeEMkNnTAChyRUu9y0haNiYwwq5DmYCGhGG
 d+tzVuqJv7q+leLpoj+bLW1USZ1uKuDt6fB7wW8mzv+DByM3p9x0eMPQSxuRI5IrQ9g==
X-Google-Smtp-Source: AGHT+IHhlpQDDX4UnrkJ67/9Efshmc3nxe5aMpul0gzjXThfxzYD/8zYwrQIQa+u3pKyrW4KIR8o9Q==
X-Received: by 2002:a05:6000:2c0d:b0:3b5:dfcb:8fee with SMTP id
 ffacd0b85a97d-3b776663f45mr7937458f8f.41.1753717892792; 
 Mon, 28 Jul 2025 08:51:32 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588370471esm68946355e9.29.2025.07.28.08.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:51:32 -0700 (PDT)
Message-ID: <6051eb58-1ab1-41c8-a693-c7cb4a89fb9f@linaro.org>
Date: Mon, 28 Jul 2025 17:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/mips: Only update MVPControl.EVP bit if
 executed by master VPE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 1926277@bugs.launchpad.net, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20210427133343.159718-1-f4bug@amsat.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20210427133343.159718-1-f4bug@amsat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 27/4/21 15:33, Philippe Mathieu-Daudé wrote:
> According to the 'MIPS MT Application-Speciﬁc Extension' manual:
> 
>    If the VPE executing the instruction is not a Master VPE,
>    with the MVP bit of the VPEConf0 register set, the EVP bit
>    is unchanged by the instruction.
> 
> Modify the DVPE/EVPE opcodes to only update the MVPControl.EVP bit
> if executed on a master VPE.
> 
> Reported-by: Hansni Bu <https://launchpad.net/%7Ehansni/+contactuser>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1926277
> Fixes: f249412c749 ("mips: Add MT halting and waking of VPEs")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Supersedes: <20210427103555.112652-1-f4bug@amsat.org>
> v2: Check VPEConf0.MVP bit (hansni)
> ---
>   target/mips/cp0_helper.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)

Patch queued.

