Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8344BF3C266
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbQ7-00029w-AH; Mon, 09 Mar 2026 10:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbPz-00028I-0L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:17:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbPx-0001YP-7V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:17:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-485392de558so6508025e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773065827; x=1773670627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RzcFdQyDDkDjYGuDFQKGPnMB0uLqqM6lBzvZCh67Fks=;
 b=gnhPjip2UCqq7bvlhYDHR3wr95USxMArNwHowhio42hDKcFovw0se8yuoYD8cArZnM
 YBYIhQ7EJdWCli0zAP9waTxbsSodvNF6rMhgr/dyFITueH3EggTmk+Kd3VMnbQz+Mgxd
 9J73X6GuvO9eOU+iAitZblY/qQ7G3YMIZP33U4Ai2teaN3SVdKKPhptL/8cUhj+dT7p6
 Aycx5HTjGh/xChPqxEgkJg1J6WBtXV0iM6jrw48DymStH8k/uSOPdrV+60fJzvZZeW/9
 WnVqZ0fyZdTMZKY3uC/AlfP3MC6ixDTZ7kjnbSCVopD71UDYHFnC6IJDTSdrN3g8qURK
 XV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773065827; x=1773670627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzcFdQyDDkDjYGuDFQKGPnMB0uLqqM6lBzvZCh67Fks=;
 b=t2v1MthNdoDpvtZm7MZDg5p5VspwrVvaqyCSEDJlVrGpT5hYS0Xt/tLZQcRm76RbNj
 6N5SG0v2vinRnwNAROC/UjwiO8xwTnvWn24BqT3ZCIDO8pZeb1iqy610ldlv0R0Ws8x1
 ZJJI2t3vaZtW8H0aOZDa2Bq/VXLYlgYANyzRlix4XnhQDjNXpJvf6Ta/URaCxKN0X2He
 k2ldQeaG1f8C8woowMwxF69OI3EkFQfUAR5kuJuJ2d/Ej/ocXY7/d3QUx9GRuEY5KtTc
 S+xrHs/EmPgDwtWd9DUJ3L46aVxHDCu08Ut5hDs7X/IPxXPvQidzO27gPYrJh8ibYH8F
 u4Sg==
X-Gm-Message-State: AOJu0Yy+zvMn9KqNpQwUVLraHFjMJQzWSjxgP+V8GxZ6drC+txH82oS8
 jopJ/gMf3zRVdK8E3WuQNOWY4fpsfHUxaQSzPLte5mTNyiTAGpsFN8p9/IG969e4J3g=
X-Gm-Gg: ATEYQzy3Emz1y2nhlX9nMWIGTlilaK3fQyiroXBpXMrbmVMvzCsqOl7qHFBGZRWamU5
 U4hCDC9/eX15L5OOiUSSFZTQEnFUicPrkA3kmxy46LbgwILlQkLm076Zjq9HrnDIR6iR4ZKvVGu
 zJPKKbeSRlrggQaEqQ8rbj2eCJ3BPQ+Eb54pkjlyihxNUFeH/OF+SyAHdtDu0/EB/AcVATYFuEq
 K0ojvlbSUU9nQ4RUwkfx/ASO/CsRsH+0LrT7c/Wqei84eUpGqfyrCkWKXxw3eYq3/qakDWKr4tN
 Z1WbIlIIEs7r14BXlP7zgaHaIlJfUm12WjTQQKk50xuSmAvUMY/AQYr5oXx+Fh3Xo0mLvNhyLzy
 wKpoA/RpcMJTygig2Nif9eLc2KzwFHugfogGxoLzD7Xc1LXGdi4KliJucmdJyxvF//+hoE3gWUV
 wQo5mzZRIiyQwvvlpRWnoeO7VQZeISFRB4kwdvVXnu+5xSda11vTLhcfU4KR/oE0VF8sfou84=
X-Received: by 2002:a05:600c:4591:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-48526979de9mr181585025e9.29.1773065827234; 
 Mon, 09 Mar 2026 07:17:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853588758fsm73192895e9.4.2026.03.09.07.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:17:06 -0700 (PDT)
Message-ID: <6f0e971d-0cbf-4662-9eb4-a3185b267f6e@linaro.org>
Date: Mon, 9 Mar 2026 15:17:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-snd: remove a redundant memory allocation
Content-Language: en-US
To: Roman Kiryanov <rkir@google.com>, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com
References: <20260305042523.335493-1-rkir@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305042523.335493-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/3/26 05:25, Roman Kiryanov wrote:
> This change also makes its lifetime explicit and
> prevents NULL dereferences.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   hw/audio/virtio-snd.c         | 53 ++++++++++++++++-------------------
>   include/hw/audio/virtio-snd.h |  2 +-
>   2 files changed, 25 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

