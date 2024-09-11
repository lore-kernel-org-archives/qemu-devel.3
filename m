Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8CBEDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE5C-0000QG-2z; Tue, 10 Sep 2024 23:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE5A-0000II-7o
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:31:52 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE58-0001PV-Pz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:31:51 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d87a0bfaa7so4587978a91.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025509; x=1726630309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ndKhSvloyzegkP0RpMVLvQiTZLy+tPoJvuo2voBzA/A=;
 b=H32SaXug6m4IvV8rIUG3Mn1q3ZxEGIHxgPUJ4bEXEH9M88qkA6kQeJp1CyMnXfYuad
 QqQX2CrRZlfqNiYkrSCHxcDWQm84rXPuetRnjlre88cXKj0vrVQMxhUZnJDD6GCM7tyz
 SqzMWg+TMGO0pWxW7CA+PoXnyzXhvTqSGx9OdonZ6p0tRg8B4/YF46fUwXGygYpzNdjZ
 C27E4dng2JRU7nQGigtnhIdXeVWlv2hgZzSSoYNB8bpreUaC26m+sRRg6joZHHwp6tYp
 TAi5BbzzIAMGe28XNbAmP7ty2cx6i15Jzs1O4A4fyh83LSKaPycpFz6QvxI8Lfbvc+DF
 gq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025509; x=1726630309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndKhSvloyzegkP0RpMVLvQiTZLy+tPoJvuo2voBzA/A=;
 b=C5B7neMIP3LHkw2hgkhHThkim0r2XfottjKH2vlOu+cVOqmp58ungvTq0xJBxH6Isf
 6anaK8PxVDM9fuHE/zD3i9C48kcBdJoazF8Bi/N9dmfNCvKgEqjX8AjTheLzOpUPg1eZ
 MtN+u6Idhg8nS4ZL5X8zTw1fx9KxleOT+fuy5t8shlDzAcKkENXpCWxZ7vx32oVNcRhJ
 9/1eNRy15wPZpLliGISYLZoE+Zrvu7f6jckJOYLrDwsECQHccDZvkWuwbWqs/m6ojpoU
 848OUPZ42MsZd5otJpoYw8kqW66SnCZoR95HTo6DoPl6v4LgSJbd/vbMpo5nCcYIkiE/
 mczw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDyXFbOzHzvUc7ZJoY8lSvM6Gkdh5cIkOca2oCTB0DsZUGKTimotI/O+eQTHQhKw0gtpKHXpSc/SB4@nongnu.org
X-Gm-Message-State: AOJu0YwazD3QG3BuZqslg34YqjFRUOot1ssDYp4GBxXd0q/y3doE0Knq
 qvuYd2THysnW+MVkZIlAd0/xysJh/r6aHW2R+onPFrwXPenh88oceY+YOrVaYn4=
X-Google-Smtp-Source: AGHT+IEqCN0tijmMGnbry2vX5+FKiNpCjgsxCVGI43cRvhKhw3Ed6d2CkUwshGeWjC8nHB6AfICJ+Q==
X-Received: by 2002:a17:90b:1084:b0:2cf:cc0d:96cc with SMTP id
 98e67ed59e1d1-2dad4ef0be1mr17402607a91.9.1726025509049; 
 Tue, 10 Sep 2024 20:31:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc03d1f5sm9297580a91.26.2024.09.10.20.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:31:48 -0700 (PDT)
Message-ID: <e765240f-c89b-47f8-b0a6-229a05dbf20e@linaro.org>
Date: Tue, 10 Sep 2024 20:31:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/39] hw/net: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-30-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-30-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/net/net_rx_pkt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 6b9c4c9559d..0ea87344745 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -376,7 +376,6 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       net_toeplitz_key_init(&key_data, key);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

