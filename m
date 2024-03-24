Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AA7C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 17:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roRPa-0004eH-VC; Sun, 24 Mar 2024 13:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roRPZ-0004e9-LJ
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:13:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roRPY-0007tK-0Q
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:13:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso2940868b3a.3
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711300407; x=1711905207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tir/yZ8e8skhA2np6549EciKMEnksHP04nyo+kk546I=;
 b=I7q2eOrNClEhPMTb8XuaqP9iZvAb9sG0FY47YVaYeqqhQoYrLe40SCXxXv0OZAVmzm
 6ZHQb8VBIKWfoAbNjbrpiWP0wl4oK77e2ERE1zWIvKgjcPFJGQhdlLpi3d9GQ3y90SKL
 dF3YoZ8tM3cJOgN6HYQSPnK/1YDVBczKb01y5MjKL9ReQoAcA0PBVMQhJPOBIbDMJd2c
 5heiQAxa+eFgcbDg+tpds694C+tekaOYvMmn9Kwx7ggFmqpXfZnM601J1GVPAegtU6/0
 6GbSJ7prQE/KbwGMc3/ApewCwdYfa0a2y/YXESok8cjnKqgcHnPhz7+oBr6B3pjgUcTg
 yETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711300407; x=1711905207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tir/yZ8e8skhA2np6549EciKMEnksHP04nyo+kk546I=;
 b=Y9jo0iQtvYK7fonUGsOZOoxg5WdSjeFhHGneXJ1aazNTijbZblXd0ylehn6KB9ZLjA
 MQ4VwMWVu8jE3WtPZ7jnI073vQv2ALwehX9gftthrThF/8RIoctpC44+iiqt1yx1cW5b
 m+wxr6GWSWvp6vldT6T8AEodlqWiw9k4P7OII9cRBfbW5WS5zeKT6TlcigeNqIN/4Kmp
 3aFtHo7ZCFWh3LCTQFscdWFTQ8d2Je0Q6SWr9JEMQ3lGErPZOsk/loLml09U5zrvpor9
 bWrtL04qiVANeLjcratyTIKyp9N/J1VeMyYyrRRM0/2BwVtMSzJMq02/RzEFX5BiSX8p
 QXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLvAARcyNrB9FE7tnstPE0xF7bQTMHHW+vzSbe8afKqB7sUCLTCZOBWMrJIbjrbjcB3QCnfqvSYs7FZ5pmLgaJT/Vbjd8=
X-Gm-Message-State: AOJu0Yz+UoM5A90cQzc3KWrtmfvczQtVRc4D74sQjQGoAgwpreOxnJoO
 oTCDqLKuYQ2WCr0F8fk23evVPivQgxArIYMWwWQ8Co1rKnHw+tHPthH5xhgPY0E=
X-Google-Smtp-Source: AGHT+IFYx3/E9vncuj7oaAR5uDqpsqNV9Y6H5ZBsN9AVeQH6SAIEUBeH3XfzVxK/R1aMQNMgmuPkwA==
X-Received: by 2002:aa7:888f:0:b0:6e7:2dd1:6e7d with SMTP id
 z15-20020aa7888f000000b006e72dd16e7dmr7191251pfe.18.1711300406722; 
 Sun, 24 Mar 2024 10:13:26 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 gu24-20020a056a004e5800b006e6c10fc87fsm2884709pfb.46.2024.03.24.10.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 10:13:26 -0700 (PDT)
Message-ID: <b08eb4b1-c7c4-4248-9681-bff883495ba2@linaro.org>
Date: Sun, 24 Mar 2024 07:13:18 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] target/hppa: Avoid nullification for uaddcmt
 instruction
To: Helge Deller <deller@kernel.org>, svens@stackframe.org,
 qemu-devel@nongnu.org
References: <Zf9GaFSsAJ5AAzKk@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zf9GaFSsAJ5AAzKk@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 3/23/24 11:15, Helge Deller wrote:
> The uaddcmt (UNIT ADD COMPLEMENT AND TRAP ON CONDITION) instruction
> triggers a trap if the condition is true, and stores the result of the
> addition in the target register otherwise.
> It does not use the condition to nullify the following instruction, so
> drop the calculated condition and do not install it as null_cond.

That's not what the manual says:

if (trapc == TC && cond_satisfied)
     conditional_trap;
else {
     GR[t] ← res;
     if (cond_satisfied) PSW[N] ← 1;
}

We have implemented this like so:

if (trapc == TC)
     conditional_trap(cond_satisfied);
GR[t] ← res;
if (cond_satisfied) PSW[N] ← 1;

because the conditional trap step does not return if it traps.


> This patch is not tested and as such sent as RFC.
> I just stumbled over the apparently wrong behaviour while debugging the
> uaddcm instruction.

Under separate cover you said the condition might be computed incorrectly.  I think that 
is more likely the root cause of the wrong behaviour.


r~

