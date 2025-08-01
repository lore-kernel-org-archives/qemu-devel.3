Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2326C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhf3J-0002o4-Lh; Thu, 31 Jul 2025 21:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhf38-0002jz-R4
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:59:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhf37-00051s-3B
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:59:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2403ceef461so3075905ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754013546; x=1754618346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8w56caJZNhQbvSIKEOy5G4jKMyWAzGqewRUsVLkSok=;
 b=Ur5/xmx1iH99ajyhD9hVm1nV0mvsPx2CBUdRPW+XIniS4MQO8910VhzEfDOlktW1V1
 Y55F6QetEvLr1JHKV6Sy3zTtChS7x++y0tZ59jqJlCmY6I1AIX4Gam0AGGesy1gleZAJ
 Td/QfY1RGwzSu0uKbQZkDreOdK4zMFnOaACLZD3WQNEyc3NooDRg8crWIV3OuZ8XVPFC
 SG4lv+wjm79ZVSwYWcxKMWrP5ZgRYluiLZ5gBn8hDVwlsoqTZ7oFRldurCtwyTYO93XC
 ov0mq284um2s2vyXan2UHx8dcruW336HBZYaq6mQR8uhGHJ9jxZFGGA7KigP+tQqeEO8
 wmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754013546; x=1754618346;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8w56caJZNhQbvSIKEOy5G4jKMyWAzGqewRUsVLkSok=;
 b=C2TpfG1JqJkDLefwQI2fHd6oKEMGo7bRsqgUYwcAPXV2ExkvyI0dv4tQfyOeXxDV21
 cVLW6FotaS9XHFeiV/LKnirD564p62BnE+EJm3bo6HP3yftDeye/hSBXOPTTVGlJWy5k
 ukSWAKdWjkryCyK3GPJR8oU8aeX3HaFkhFzPFZ9JsMv4bFZDIgKUStMikzLdtj1y59Mw
 aL5B5UqdArqupknnFi8ZG6vmQw81T4/uRcjRy45cLdTydrx/g81fjXXS0/Sg0WI9lGMp
 hoBb+h6MYqY8yw86dTuw1w2f2z+pyD/BkkrSJu/JA2rPkfv9NapGU7bSuCPRT6DWUZcI
 YKcw==
X-Gm-Message-State: AOJu0YzwSmzCYSOZ/2npf9g/SQbZ/CpT2C94apcMdwQYpLs8NqYO+7Ez
 wh0PDQU6v5dpc+P3wNXAcrrAKGRpdsfd2NVPV9XWzHvucsj8ZrYW2VNnmWbafi4rIs16Ge+5VV1
 gG47gGGQ=
X-Gm-Gg: ASbGncs9agli9XnlG9J+OivQY6ZC4XSFD5O3NeZMR2dvlvMwCDk3pM4lBEJrimtEpTk
 plE+UU2672Wd0YPF5PzPYouz4S066Ajqm2BnAatZebEOv50yHdUMSyIY010fWXEuVFG4KEesthl
 GvhYr5IqKW2okxsXrinl3BDo9tUKk/Nymwz6ISSGV4+SXO9jdkfqcsCTQGnbBNSHf258RzSQmQb
 5dK80D841rleoooWV+3/N8Zu+25+Gn148cjWZSwFFLue/6lyJJJQDt7/OaxFMSfrjrm+MmvbL3b
 pUCr3UHimNTKxVl1vgpVKINXSSe8YS6vLY90tedGSKRIINqwUFTNHYp8pQcEv+h+FW3swb6/SPC
 9QDqCAjrfiCNGCOGb2CLWM3TnLmSWl6OYAjeoWYKl6EXl9x4Ul4s=
X-Google-Smtp-Source: AGHT+IHviSUDaPtK2zBR7uoGtCyna+u0mQG9z4DRD6NaxqVIDV0igaTgp11lINomTj2zB5x/Nb6qwQ==
X-Received: by 2002:a17:902:dacf:b0:240:80f:228e with SMTP id
 d9443c01a7336-24096bc60f3mr131789695ad.52.1754013545652; 
 Thu, 31 Jul 2025 18:59:05 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ac9021sm29117705ad.195.2025.07.31.18.59.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:59:05 -0700 (PDT)
Message-ID: <fd07252f-9c7c-442e-90a2-b6300da1c92e@linaro.org>
Date: Fri, 1 Aug 2025 11:59:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] target/arm: Reinstate bogus AArch32 DBGDTRTX
 register for migration compat
To: qemu-devel@nongnu.org
References: <20250731134338.250203-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731134338.250203-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/31/25 23:43, Peter Maydell wrote:
> In commit 655659a74a we fixed some bugs in the encoding of the
> Debug Communications Channel registers, including that we were
> incorrectly exposing an AArch32 register at p14, 3, c0, c5, 0.
> 
> Unfortunately removing a register is a break of forwards migration
> compatibility for TCG, because we will fail the migration if the
> source QEMU passes us a cpreg which the destination QEMU does not
> have.  We don't have a mechanism for saying "it's OK to ignore this
> sysreg in the inbound data", so for the 10.1 release reinstate the
> incorrect AArch32 register.
> 
> (We probably have had other cases in the past of breaking migration
> compatibility like this, but we didn't notice because we didn't test
> and in any case not that many people care about TCG migration
> compatibility.  KVM migration compat is not affected because for KVM
> we treat the kernel as the source of truth for what system registers
> are present.)
> 
> Fixes: 655659a74a36b ("target/arm: Correct encoding of Debug Communications Channel registers")
> Reported-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

