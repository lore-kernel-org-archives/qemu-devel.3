Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F5EEE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE1x-0001Aj-Dw; Tue, 10 Sep 2024 23:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE1v-00011T-E3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:28:31 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE1t-00013T-Kn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:28:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7c3d8f260easo832344a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025308; x=1726630108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XhrptYahcu1vPZ3sdDX2D0rHwD88MSue+D2Eni57soo=;
 b=kyN0sFOxjeQNnIbLVStzFAlDI42DlDKHRVSekqhJLTW9DEi8eiRg2twd2jo8qUf3L0
 UnHsek2J3YaYZm5eaXzYErv06AsYvfMSNxwI9mcJjZpOoMJSMfBHYN28MuZyd48fk01B
 ROEoQnfuRgj+MhPlrBu73L6TY4jIk3WUUS2qsvmlkeIWZR+h3ZyLx6o91/QaQ6PuYYpf
 ihmoznktX3fWc1UrFhnUT3skUdXiV9N7zCy8q4SpoJWHyJByJGrwQot3M10MbO3SRk8X
 sn8ARNsX+l6TIJHfI+YcIAeb4zqkx0hPv3PlcZ5rK153liTuGlZDF9/9OdRFj43PPsqg
 2yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025308; x=1726630108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XhrptYahcu1vPZ3sdDX2D0rHwD88MSue+D2Eni57soo=;
 b=JTn+9UdsL6X6HKzGtGF6Ia7vY2n6h5vqkjETynubBg+08Npq6/3coEhGfkogKkNjmx
 /46nHWrsMtPsLgMPYTGRzG/1WBHTOtoWwP+saoJbkc4SdItyyV74dckL/jznKSg+3KGh
 tzL0XVeCdqVFyEzObimFWqiYgq6wP6YTOaaLtsghLN1bds2xCmdjcC15ftyc/HePLdzC
 Gdv3pY6sBN1119Xmlp7VgBUXTJoYUj4uNgez3QfkpYH4YrV9e83IS5UlkDcrYEcQEwRz
 dj9BMLbyFsheq/kLUibnyQ+jsQ0vGG/buzQZje4PY9Do/j6PD6E4xik/AKb9VwyGBTaP
 RTBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVVDlBDh6QmpYIvTfLtWaw3XeREWHpvKuD7ok1IKADwFegj9x8W2EzCIiM/lch9A1L/tPnBUE/7wbC@nongnu.org
X-Gm-Message-State: AOJu0YzgOJ/e2yoeO2ac/U5lMlMEaikncI+40+cR9GNvOvKwGFsRbQSh
 tsuwdBYUafa4sm9+hwIYo3iChhli0ssW0B+PXJOdZbqbcu380Sci5qmVKnHCwoU=
X-Google-Smtp-Source: AGHT+IE/lsvm/1EuHwzxUvXMyTtJ7qCUMzJ1EMwYFBuqx+qTpqVCWQHJ4Rg2S8o03rhJ57pz1mEMMg==
X-Received: by 2002:a05:6a20:c844:b0:1ce:f77a:67bf with SMTP id
 adf61e73a8af0-1cf62d7cbd3mr2244787637.49.1726025308078; 
 Tue, 10 Sep 2024 20:28:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b0522sm2049840b3a.157.2024.09.10.20.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:28:27 -0700 (PDT)
Message-ID: <df0b9645-e865-4092-8bd4-defb3b641b63@linaro.org>
Date: Tue, 10 Sep 2024 20:28:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/39] tests/qtest: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-24-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-24-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/qtest/numa-test.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


