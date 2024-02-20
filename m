Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31445C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVqR-0005Lf-Ka; Tue, 20 Feb 2024 14:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVqN-0005K3-6F
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:31:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVqL-0007eh-Np
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:31:54 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d944e8f367so47366225ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708457512; x=1709062312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cWrwOM4Hgt7Z7ruudJPdPzW4RxXvLTgRHJaDkd4Ga4=;
 b=CztUqGJzImmc2vw7cmueHiLPCPTFlTMEJOnBefdLznaWE0w0qk+UBnFA/Ewyh0/ctj
 szjL7hLJ9vZJQpBxh/YIKrRAIAE/uPmawyx7p0u5w0Cp9OqYLGt5v2dEqqsm4rYSIizf
 1UziazhIblTdx2XYBTqEAPB7CjLOCI7VAcWMxb+qKUoNDCElSfqzhYBs8SxSREjVBTOn
 9SMaM2kJauBJ9IPfLFwhRZ9R3+5oogSxYN+NzbGUr1E+jD/5CNwZ8EW/gOsUU/dZA6NJ
 P2+1JF5O6nLOKM/wUBsyu+YKgrag8RMfRxX2x4i4PxQschNT0ABBJ8rx4/6AkBDGZMNQ
 agsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457512; x=1709062312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cWrwOM4Hgt7Z7ruudJPdPzW4RxXvLTgRHJaDkd4Ga4=;
 b=HeO2N9v/rh8v/66VyjSMIuWDdQ6A9m8wl9f2e8fl+nt1c4C84qEub1ir8UC53bB8Gr
 BMlNaI/UYgaYDlXW1BFD6798r60z/fYqKGbQpIjkxV/k042QsWGUgtErP2Cc8N1OrPiQ
 TXYOK2NwL2kVI+xgZSawU+oSFmboZaEj1mPfvVcEcu4QCZ+I2WV8ClT9xbbY/dX/FO0y
 CIAw8hICQdRlqkEuLJVghTiuYEa/V7HoOgr1UbNInAKr1ZW9jvuioJmA9Sz8K8YmoFXb
 Qrpf1DCV38F3e1i8ttFGAjukL4K9zU26b/vOtoVfSwyc48Jjf4ydoHXjVhA8HPWP1wa7
 3QNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9TwHEjFGT4qfN686iuxO0M4RYH1InpfIfVbxs8NkcHLtVMOzUzP8v0XkYRQLfi+Cmg/mJ+uWaSk3mTlSn1qb0hTPzC4=
X-Gm-Message-State: AOJu0Yxuw4tjDJbGQ7ylAptUerKHt54ZojegUsRWhOVY68oFAzahd0EC
 KOMzqGPTrBrsXYfYdauj9jOlf7F/DvbFpRMuzJ/8DioMRpTbbYrmPtb8ii9AgNE=
X-Google-Smtp-Source: AGHT+IHQtAVHkue5TfqkGbHZYH/k68SLvz4P9wwAOCP+BFwhjMbNOQLQbPePuop9f4XJuZtTuaz9AQ==
X-Received: by 2002:a17:902:b697:b0:1db:9f88:4ce6 with SMTP id
 c23-20020a170902b69700b001db9f884ce6mr11810818pls.1.1708457511825; 
 Tue, 20 Feb 2024 11:31:51 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 kk8-20020a170903070800b001dbb11a5cf3sm6671793plb.63.2024.02.20.11.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:31:51 -0800 (PST)
Message-ID: <1b3708f7-b962-41f5-809c-23f9e48c151a@linaro.org>
Date: Tue, 20 Feb 2024 09:31:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/i386/pc: Do pc_cmos_init_late() from
 pc_machine_done()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> -static void pc_cmos_init_late(void *opaque)
> +static void pc_cmos_init_late(PCMachineState *pcms)
>   {
> -    pc_cmos_init_late_arg *arg = opaque;
> -    MC146818RtcState *s = arg->rtc_state;
> +    X86MachineState *x86ms = X86_MACHINE(pcms);

We've already done the X86_MACHINE resolution in pc_machine_done -- why not just pass it in?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

