Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACE8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjb45-0004P9-JT; Mon, 11 Mar 2024 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb41-0004OJ-Uc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:31:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb40-000133-IM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:31:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-413286f8985so4743955e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710145874; x=1710750674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XAGz2GSYkPEX3GW+XUG01Wvu9biyCO46QlAuQLovS1E=;
 b=MdPtZr4elqDGvBxl4B48IogRCqAvmXmaN+VaHx5/2dpB7oII4KDxaE0M6f0JdIRUq+
 CXzYskQFuHXuz84/yG5GSwHYTF0U4qvCQusqUEp8ENxpty9DnXZnVE7iBIvkgsOMIT0t
 2Dxokh3P9zm9NiuJkSGZN743zXwPcjr0Y1VO5w1GKpxlYpquhuoRKdqg43u+534XIGIt
 clQHyy4h9N/N3EmSET0MIGVLzdGjn/TAERt+rJv6MgAw2mYJT1O620WHPwTbVkaZkOSV
 59FYkG+YYF8+q3AGjhto+xCVKo9JNeqysb2n0M86fBensz0oKkLu4REK7GWg5vC2zomM
 tvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710145874; x=1710750674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAGz2GSYkPEX3GW+XUG01Wvu9biyCO46QlAuQLovS1E=;
 b=rEhgSRchoqWsylmjsLVlHDbeAHX1tLxVblRw9ul7wmobMSsAS/dZp7Y8FZgJpkcMwx
 cA/Ye05uiV7CpZkSMYRWv/ENrzplwa8O+9s8yVOHqnxcEdifahc1Mu+OC9hi+XFNltpq
 k6L/1BNPaCJIb8/RUd23kAueaPj2q4Tew3igl4+GzVALu01lIQU7dcel9fMc1a67NV6v
 2RiWK0vg5Q8mWZFP2hNnFGKqa3YTKZr45vRzpe72MHnq6z9vOYVxMQYQvovKlbaPq1aM
 yfG6uEQHSJqVrgP5JhA/+BQZQ2y2CS3noZHtOVMK0+drDZvWFCYcl129vZiJXsP4JTcz
 RQQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvKazDamxtKiVxchMKvQvHpIHE5CXD58n0T6zmj7M2ytAl/00BS5fHq2vwltleH3lDAfsvjO7FArotqt+GEWwdy2jqjOo=
X-Gm-Message-State: AOJu0YwOxyw53u7eMvAT5w52nDUmHCDuwAADHWSf8zOUT1mNdWCV44ke
 WPu3y2mblLkOumVb4PJPHUaCEsiinoO+TxRtsVTAFMl/k1uW0chzUbb91IZtoNk=
X-Google-Smtp-Source: AGHT+IFZusE7E9P+2on+Sr89T2ebJhzn9azbJg2pKn3OkIAUmjQ8kHIgmCtjKhnj7DIU/u7aAwiLQA==
X-Received: by 2002:a05:600c:358f:b0:412:dc89:20bf with SMTP id
 p15-20020a05600c358f00b00412dc8920bfmr4231837wmq.31.1710145874547; 
 Mon, 11 Mar 2024 01:31:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 ay4-20020a05600c1e0400b004132ba7fce4sm1408267wmb.48.2024.03.11.01.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:31:14 -0700 (PDT)
Message-ID: <d3a45fef-f42f-417e-bbe5-f93edef19ae0@linaro.org>
Date: Mon, 11 Mar 2024 09:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins/howvec: fix use-after-free
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240311060456.218190-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311060456.218190-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/3/24 07:04, Pierrick Bouvier wrote:
> reported by coverity scan

Reported by Coverity as CID 1539967.

> ---
>   contrib/plugins/howvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
> index 2d10c87e0fb..5be91f6fc5c 100644
> --- a/contrib/plugins/howvec.c
> +++ b/contrib/plugins/howvec.c
> @@ -168,8 +168,8 @@ static void free_record(gpointer data)
>   {
>       InsnExecCount *rec = (InsnExecCount *) data;
>       g_free(rec->insn);
> -    g_free(rec);
>       qemu_plugin_scoreboard_free(rec->count.score);
> +    g_free(rec);
>   }
>   
>   static void plugin_exit(qemu_plugin_id_t id, void *p)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


