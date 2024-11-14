Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22660D68B2B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBb2T-00021j-7M; Thu, 14 Nov 2024 09:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBb2R-00021M-CC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:41:40 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBb2P-0006CJ-QZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:41:39 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so125181166b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731595296; x=1732200096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N7duJtbR4uLTEHjNSfWJnG8FMt5s6AUsHQMfU8HhnCE=;
 b=eoc00aDNGnFnNSk/vGWkyVSd9NOuE2wQox76zuTpJKOrldH3Qx4oQBkoF5r6fk4MDY
 cxbsdrGrggBgHWmVEtDPN2REJMPjbaZJqf2KSXcofXZxMWH7sWI8k/FvY3yFiOAYkiea
 sTMTjO8fuROWZsUhpOP+dXPPfOiH5Z4++J4b/VXMzZWFnzep8PLXB+N51nOsjs24h/Bo
 5czWnm+u4cufUmH5kVbV1RisRrjVMK3ONBHScvSUYzx9n2eStAZ7lBpYiEYsEdHhRfB+
 lmGPBHcPgI8IdzZrcTafMigmImIRytTmvsYU6bwy1nhVL/ZRf+31Enuv8wZ3mW7m0OlT
 WfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731595296; x=1732200096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7duJtbR4uLTEHjNSfWJnG8FMt5s6AUsHQMfU8HhnCE=;
 b=ELGJP7o1TwktAa4cgf+qz5jIw2un3kWdlc9/j7tkAxGLb6w6FAz0cwVD/GqJPTrqER
 2GHyrZw4LwyQgQX8/V26EGrdCcV6lgoMk2t8BcL+kki46VI+H8hA4v7K4jfNKxYWo9OR
 GAkCns7zwFEhhue+tbL2ybRawxkC5A+C17KLuBF+vRWjqEBtbO1lnQz0GgH1r748taFa
 HBCwY4/WuHtw18qAnjo6HcJUV+C4aDHlkl54pGrza0YRxWToFf4G3gI5BXXYwExhyQo6
 QDR519RgSJZim9Yi16adxt4DNDD+ui5cXYlH43D4yVLsRr2C70+luhAfprrzmhXzgLQz
 6W2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5gLL4MNacyE3YyUl69QedrGBvgIgp1+1LcCQdCgE6o6o5d6F10J8ejPWNSNGkW3ad5CkyJN18+i1Q@nongnu.org
X-Gm-Message-State: AOJu0Yzfy49HbzmOldr3MCM/3E4seJeJ/9M3mRszjc4JKqxFsKGU4+Jw
 L6J3jkc2yxHq+n5VZGd2Y92EGGJDNvvrX0mFweTAl3usHmr6ywIZ/cPDacCEJsM=
X-Google-Smtp-Source: AGHT+IG2JbXLVOMGDsBsbsyAPed4/jyzJtXkGow8/phdCSmbPTrnF7ebfqCtqGpsScfNy7OqlOu7Ag==
X-Received: by 2002:a17:907:1c11:b0:a9e:b08e:3de1 with SMTP id
 a640c23a62f3a-aa1b10a9779mr1011364366b.36.1731595295944; 
 Thu, 14 Nov 2024 06:41:35 -0800 (PST)
Received: from [192.168.69.174] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffd6a6sm69854466b.99.2024.11.14.06.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 06:41:34 -0800 (PST)
Message-ID: <468f6001-e354-4dbc-815b-dc1496adc92c@linaro.org>
Date: Thu, 14 Nov 2024 15:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix !CONFIG_SYNDBG build
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20241114130152.352009-1-vkuznets@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114130152.352009-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 14/11/24 13:01, Vitaly Kuznetsov wrote:
> Commit bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG
> enablement") broke !CONFIG_SYNDBG builds as hyperv_syndbg_query_options()
> is missing there. The idea probably was that as "hv-syndbg" is now under
> '#ifdef CONFIG_SYNDBG', hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) cannot
> be true anyway.
> 
> It would have been possible to add a stub for hyperv_syndbg_query_options()
> instead of resurrecting '#ifdef CONFIG_SYNDBG' but avoiding
> HV_X64_MSR_SYNDBG_OPTIONS altogether instead of zeroing it when
> !CONFIG_SYNDBG seems preferable.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG enablement")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


