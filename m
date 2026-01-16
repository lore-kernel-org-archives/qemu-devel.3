Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677BBD4A602
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcs3-0003gW-Ui; Fri, 16 Jan 2026 00:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgcs2-0003gK-Oc
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:59:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgcs1-0007Ee-80
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:59:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so13994645e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 21:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768543179; x=1769147979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3K7mfps6uk69+3HixSTpf/c0zPsjPX1b3gOQPfnFgw=;
 b=xpvozG9fCzjsO1hinVd/clSIv9qPGLB6frCiN2sL/5edGzmuojOARKg1uHEUfyxK/1
 lkxd7LoS/Sx3IL0DI9Q5IikGLJAEoukikYuvuepnySDLAMP7oH6oEdBS9deHUe4RFWKZ
 Ux1/k51oAs/+O7Jz/6vfR7ZrL2c9RCWvePEhTUPV6rpyDPLPejUHsuKt9CBzRWIgmVGC
 8pFl093cTV59jkqptkjfmmN7TRmJ4P5MMfGvAAzIsoMwpgdhQLlAMRb9OM2pXOCjIBnh
 T1aP5k/dW779wLHP440hmeGhnm2lnbyE3v8dtJG+FVWTceyZKeRvQ3Ppq3CWLIvB47MF
 Nm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768543179; x=1769147979;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3K7mfps6uk69+3HixSTpf/c0zPsjPX1b3gOQPfnFgw=;
 b=G711mCCBJ7Ckgr6cHWvqbGe75xu0zl51v4QL81lUBTq0yRTwZVOnBqZcDitZLbcsTZ
 H+lDJCpFJvkSeLJBj4JFaL07c19pK+ULSwSzr68QWaybAfaoPK4RaxFKh1L7PH32dV6z
 RP6cDQU0yLUqx6L/o16wV31HZfKlHIH6y9spayqYz6lkN6FSyqqsbviSE2ItQcleuOBR
 ylmgrsbSB440ddFEH69YgNAfsxi02urVXCMszj6fnaWLv9W0tvKqwB3f1Rirnt6WswSt
 9S9+dIPACgyTJ55tgR0/PtyG/nM+tfPOZkHDNBxZy4o3b/vjbFPEiYYGmVSS+fCLa8KD
 W5Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOKoz3HKjIsg8cKio5tSbPwqiwkqAQfdN5w2C9Nx20i1UmrRwSUPmlplgenkpnADLtGElllhZ2mLS6@nongnu.org
X-Gm-Message-State: AOJu0YzXxxs3hwRvw1yEl5wWqr1CHDJPcKU4RKj+8YGmPAg84PQgnWss
 ExzkYyqNxEfuunLoWYsWXZpv4Ym/8LfmwGtrbfTPoKRHqTGvGfXX5xe3AR5WW4NfKkw=
X-Gm-Gg: AY/fxX7earR/ik/ITXkkTmDnHIar5Kyb47DkzTVlcYE/8aRap1mk8F6wsQiXMFZKknk
 tGZNGkO4k9zjqIcXxsnV8VomdVqA9BK+L77KEJCKMk5Kett0pI+9BrmNeXiwe+B1a+TaeZsuwhg
 I9KO+4wJFxUsfu14kVI4zt61nB+4G9Oi1ct7+Uz9tov9Ns5Nl1TKNbD2hM6soQNhoS3hWy7lrKB
 3plTxiiVbB5yF30EFoX1oLGOCt4saI2SPW2mfE4wRGm3BNKndOLTSyUXv113ygjEq/ys/kQrG+g
 CTWIeERT/bsrXsqY7gZkK7nWz1z0dPQ7EUI74zR24/3FmjCIcSEQi0ZyHwb/N5fLA8L/odOFNxJ
 p2AaobYzUR9SSeRT/bJFa35pr7fGBGNXJjgBadlBlZl60XmDzoCXlR+lv+DQRVKTJlrvVLp9Yzv
 Lh3BEOutEFoaMqGXnY8l6GKGVj9EcdVr50ioqbB4k/9mGydCIq9ouXGQ==
X-Received: by 2002:a5d:588a:0:b0:431:62:d946 with SMTP id
 ffacd0b85a97d-43569999473mr1931795f8f.23.1768543179182; 
 Thu, 15 Jan 2026 21:59:39 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921df9sm3140204f8f.3.2026.01.15.21.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 21:59:38 -0800 (PST)
Message-ID: <d955ea0a-9ee9-4048-b825-d913927b1f32@linaro.org>
Date: Fri, 16 Jan 2026 06:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/58] gitlab-ci: Drop build-wasm32-32bit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, thuth@redhat.com, pbonzini@redhat.com
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260116033305.51162-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/1/26 04:32, Richard Henderson wrote:
> Drop the wasm32 build and container jobs.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml       | 9 ---------
>   .gitlab-ci.d/container-cross.yml | 7 -------
>   .gitlab-ci.d/containers.yml      | 1 -
>   3 files changed, 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

