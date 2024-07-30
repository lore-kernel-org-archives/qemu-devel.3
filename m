Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A644FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgJv-0000tQ-57; Tue, 30 Jul 2024 02:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYgJu-0000su-9z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:26:50 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYgJs-0000uw-Se
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:26:50 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-709428a9469so1917905a34.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722320807; x=1722925607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwLs8dIzAEQWSJ1FTO5xVoY1SfxFvWL954nUQkpOc30=;
 b=G9Blfo9CnDaV7764dhGfWApAOtcihGQWbdQaEQZGxEaGfhqJGEOaFEW6hxjXQRxv7A
 AbntibvQY7pPW1bwNXh3eHk/YwfHhl4jA9nsggK0LVL3MDRgeU29k4vWgtP8CtjQh2xE
 qY65W7I6wCwPg/gw2oeRVbGE8+NkccOOMZIgE2DPQ0fbqWwsaMGQr7Z3QLdjoMex0mf2
 zUjET5o9LOy+ax6qEuH8wlhBmjjRNycXJT2TeER6jRYyr8hM7BE4jzFzW1evYIXtoksS
 oiqChmTd3SJ0mJ+1rlWSeMAUMyd0Be7JQaOBsSdIoRid1muHMbD1z5/sbN6Bm/Im7l5V
 fEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722320807; x=1722925607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwLs8dIzAEQWSJ1FTO5xVoY1SfxFvWL954nUQkpOc30=;
 b=OBJ0fGySB7eQSYK7+7O91GAdIIg7Gi2IYhg1PV6VZ2QYeFdLEcQ0NRA+ecJ/gQQO+s
 x3WcE5k2dx3Umq+Huv20VbVJTxBWWDPQi95chXj2cm4PH1myuqSXfIxbS9IErtYrRg4l
 ysG73i2FzVbQ+kOuqp9IXOKk7y6O8Zz/4RvZoWlhKkxyrZNErk9c1xAmhUK9G+r0hR8k
 KdHhbOZzAmWIURPmaFzB87Qqts7q+gDNxGp0tQQC3B6SNkMpYNaUjvXonjT6/pOn9Y6E
 YeZw3WYR9AUv51Plkqmw1CsOkk/t5pE77h86pXJ6tjisnFlxC+3XRo8lE7142tqJAOW9
 4tnQ==
X-Gm-Message-State: AOJu0YwR+AsBfd3eh8YPIpysbdLPtUI0eZ3qYSsW9exN0Cz0myh2JDWV
 ev1agydxU17+dGEj+ITjpLvLyal+IGGHZeZgFRN/6L1WPxoKtjdcMIjutDsZJKqIAqWM/62lyxx
 su38=
X-Google-Smtp-Source: AGHT+IHB6/mxzLKIEs3upeGP1tukEwIzDHL98LXyn+51cHqJ2SGn3viTV4SzCNGPZs2dqD6jIcb88A==
X-Received: by 2002:a05:6830:3697:b0:709:45ad:8552 with SMTP id
 46e09a7af769-70945ad882dmr13419773a34.7.1722320806478; 
 Mon, 29 Jul 2024 23:26:46 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:3e4:c598:8b5f:3919?
 (2403-580a-f89b-0-3e4-c598-8b5f-3919.ip6.aussiebb.net.
 [2403:580a:f89b:0:3e4:c598:8b5f:3919])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9fa5937a7sm8213973a12.87.2024.07.29.23.26.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 23:26:46 -0700 (PDT)
Message-ID: <91ed2cef-db2d-47b3-9141-1d0826ff0588@linaro.org>
Date: Tue, 30 Jul 2024 16:26:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] linux-user/riscv: implement indirect branch
 tracking prctls
To: qemu-devel@nongnu.org
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-10-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729175327.73705-10-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 7/30/24 03:53, Deepak Gupta wrote:
> +            /* set or clear branch tracking */
> +            env->ufcfien = (flag & PR_INDIR_BR_LP_ENABLE);
> +            tb_flush(env_cpu(env));

tb_flush is not required when you track enable properly in patch 5.


r~

