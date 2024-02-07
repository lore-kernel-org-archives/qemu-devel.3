Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9E0C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYsK-0000a7-Ut; Tue, 06 Feb 2024 22:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYsJ-0000Zr-7F
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:45:27 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYsH-0003PX-OI
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:45:26 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-604819d544cso1973247b3.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707277524; x=1707882324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vxYdq2f/KGlGWpiEHSOs9rQINC45G9MxXzpTjaO3mMg=;
 b=FwAknori/tDNFVuuRowyELGx8lZejqwCAa4VQg8fA870lCFRu93nRL5mNSXzlCTgiF
 /m/WxoFeByzAGSoBC6Dxw5gr+Dr3yXl6zoqaO5+6uTwhQichqjLvHEQrTO9IDgba8qrL
 M/KR2xRdWZ1mIMC0iIO6j78LsRx9hM2O5Qhc1wt3Hf0mvuLsWbhil7uj1xa371H7Ojse
 XOqIAFpU89WGyUdb6LbtTN4H1NY0W0LWw6ueobEN5L7JwA/uuElUNOdunerc6SWcRLzV
 7XiDzo0s2pVOtrY5CEJBInB7LHQNyExacFD9uqeFPG5KmkO313fKWeGkDylzBwsw970K
 7vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707277524; x=1707882324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxYdq2f/KGlGWpiEHSOs9rQINC45G9MxXzpTjaO3mMg=;
 b=pXK+qhfsVZXp03r5r9edlHu04xli45pH1OI6LaEbKutgliXi6yFekfE0YYTuAGi/6X
 MlcyT0S2NGyGyU2d7P1WqNDyM2TeSi0dRE548vc+5Yp5ojPaxyLn59ZFAz8AlBg2OcS1
 fUOVjKtvWAAGElqkqZE7hrayhSfSPrUQ4CUhxTFkz9T98hbPe5oN8qvw1vEFUamFky8+
 VN0WCqC2LuTqQkoMDEFwUOvY1EXxJc1DFiQGbS6gxBt9nsQqsT0IxGwti6fUcHTYgaD+
 WkX50ZUE/ZMU+3KLL5pHs3LJZ9/bU6Px4DCQTkjfVqvv1fiU9lIjkewEHw6kkAxihu9J
 R7yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7lNb2SxspMDisOHF5Jcagt+YAlwXmyeidqRUdPgH5yRZbE9e8CR04Gy6xa3VywjLqFqbbeN01Dg3ldIMYHpVZLHr4SUQ=
X-Gm-Message-State: AOJu0YyBhBtc8t0zK1oLLXsyutpe2VMOWupHBchfpqQXmoZtQyr2rsmI
 FHk0KzgbYkiysmDNuY6tKJYTCL4odb/WH5u6C/DInNybFOzellZ1atMttvwLMBk=
X-Google-Smtp-Source: AGHT+IH5ZSaBmeANqsD58ZPDKzkP5aaYIjQGvV9t7vSr4p4l6eG8iHQeV4U1FPmNG6qLk42D0hNI1A==
X-Received: by 2002:a81:ef06:0:b0:5ff:d871:c76 with SMTP id
 o6-20020a81ef06000000b005ffd8710c76mr3839328ywm.34.1707277524553; 
 Tue, 06 Feb 2024 19:45:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW7nXiNaduSMraeHSerAF4ucgxlyW+WF3B94nfP/oAswDApyVUBpLrqYCstPfqTAcqMr6LMwTsyZJGyn/GD1GPj0P1I8hGK3nNzf0ACphgqaX4SKHGP188bbnF3stkliKi9Tkovsd5sfrPBrPRG1AWEbOvyfJkDNsQXndi1k0l5o7WmGClI44fJBK/1+afuiE60uU+vqOMZgiHWH3lUngh2aAGycWKOmSzABpqj4XP8CnrYm62CLPnnEBkjyt/GSNweCfrBFB7BetZbFo12RV5snZ2r6ywQDNri2qtekU3zrWhPEg==
Received: from [192.168.188.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 l136-20020a633e8e000000b005dc191a1599sm289627pga.1.2024.02.06.19.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 19:45:24 -0800 (PST)
Message-ID: <4fbda293-3fc3-423f-b7d2-130042a7640a@linaro.org>
Date: Wed, 7 Feb 2024 13:45:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] plugins: add inline operation per vcpu
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-9-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206092423.3005995-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
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

On 2/6/24 19:24, Pierrick Bouvier wrote:
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -442,6 +442,13 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
>       char *ptr = cb->userp;
>       size_t elem_size = 0;
>       size_t offset = 0;
> +    if (!ptr) {
> +        /* use inline entry */
> +        ptr = cb->inline_insn.entry.score->data->data;

This value will not survive the first resize.
You need to add a pointer dereference from the first "data".


r~

