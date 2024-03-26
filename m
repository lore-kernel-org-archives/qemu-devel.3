Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04AEC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp64m-0004fO-Hj; Tue, 26 Mar 2024 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp64l-0004fE-PT
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:38:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp64j-0001SF-RQ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:38:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-341808b6217so3471311f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456724; x=1712061524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=moj79F80528qTPBI7G4nUqRT3fEvk/Eg8GXtBzL2LD0=;
 b=gCSak1jUx75Wmpq+e47SwtVV7bc/MN7Ej4Q6fGpJmP2Xoon/JmdiwbqlIBjjDx4MaF
 LDYN91OxNydZbLPQhMgvxJk/scQ+dirTpLrlHw1L3ZltSOYlQUvJZwglqZM3aMNNpyDS
 PUTLW+yWOO5efxdFl1FTyG33liDUWU3btcqVntG1BPIKTLPOwWW+8iOV3GyQgs73ATb5
 9ucZTq7FI7zf4bJXaMkJOKG1uGWSeFcnNNe1hiMYFYe+nXKeveR2lmvYFSS2FyQpHb+y
 2WtLukxjbvB20S7V1H5u8c+juT7m2h4mqCcRTG/joxTkruimfWqjAEJzUj935mLZcCfx
 yPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456724; x=1712061524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=moj79F80528qTPBI7G4nUqRT3fEvk/Eg8GXtBzL2LD0=;
 b=h4nqygO3d+QQTwGw/nw3n8uCT1MtHw0nLnaY1PHHg0WYfaUUWtav6A2NvnxwX/BT9J
 W06AWxj4K9QP+IP+0vSNjNYlERmtHrPFzghmhz/xDFB5wrF1gn9tfDrP4ttYXiETk/7N
 URuqcmlXIVq6vGk3w/Hs3ljO5Ml37/1YDw+KTqeOjKgoX4Z5bEMYwwiJtJ3mJo0QpqPz
 NC163e6lJxTMX6uVbAgtI6WJHBc+1q3Uhx7MhrfPIqbDClNT+XqWI7vql388XMvVTYEZ
 mG7K+w7wLmJfMBEUQCcEmVrmaG1EWNH7fTSQYeI+SmLbKe44+yUk5FJyC0QTZzLuCQkr
 G8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRnCtT3RGJSn/u0L91S27lGMV5PdA66u99oy/XR6nKLuoiR1I/2ZsYTGJigrh4TQMbKv1k48WeIYkyy3C4CGYr0o5WpnM=
X-Gm-Message-State: AOJu0YzmRRymBDvcsujDwXOPJ0xYTSC2fttEzFtqLK+OKw8swb38rt7Q
 7uiZTyQHEuhZ+Lm4fLFJ6jAGr7Yt1EpM+BC2JWMaHTlZt+9nysFc+R9NCAmfA4c=
X-Google-Smtp-Source: AGHT+IFpgdmbMYl+AZ8VM947U7u4wCGSQJcQExXtPno1TAUpj6aTYlAqJq2jGb4FCXTm+u6Cpf3Inw==
X-Received: by 2002:a05:6000:e45:b0:33e:d06a:3273 with SMTP id
 dy5-20020a0560000e4500b0033ed06a3273mr7061999wrb.19.1711456723896; 
 Tue, 26 Mar 2024 05:38:43 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 ay26-20020a5d6f1a000000b00341dc343e21sm169645wrb.65.2024.03.26.05.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:38:43 -0700 (PDT)
Message-ID: <c75cf73d-5e8c-48da-a505-3cc0ba858856@linaro.org>
Date: Tue, 26 Mar 2024 16:38:39 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 peter.maydell@linaro.org
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
 <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
 <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x429.google.com
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

DQoNCk9uIDMvMjYvMjQgMTM6NTQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
PiANCj4gSSB3aWxsIHBvc3QgYSBzbWFsbCBQUiBsYXRlciB0b2RheSwgc28gdW50aWwgUGV0
ZXIgaGFzIHNvbWV0aGluZw0KPiBlbHNlIHBsYW5uZWQsIEkgY2FuIHRha2UgaXQsIHNpbmNl
IHRoZSBwYXRjaCBMR1RNIG5vdy4NCj4gDQoNClRoYW5rcyBQaGlsaXBwZSA6KQ0K

