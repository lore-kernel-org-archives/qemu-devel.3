Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD00C4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoN2-0004Rc-2K; Wed, 07 Feb 2024 15:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoN0-0004Oe-2K
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:18:10 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoMx-0006kE-MP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:18:09 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a30e445602cso43926166b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337085; x=1707941885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8PB8djkmNdrvA9adwd3shY2ds256lGobCmvIuundPOg=;
 b=dhbBhHAZCrsuqbRrx1hJfXhZX3i7pSNKUs9ipTF+p1J1SwkpdwL2A5WJATyLQAzz3a
 GwWobOxXKUXnSiEXlymiREXxyR0vpfreg+xfN/untApAstP4vBbDWRlkeJxfWwibYulK
 5H/hxKBUfJB7GeoqQ8q+h62S0X9o8TInAC9C84eXPVlJqu2VhhAi7hJay6Xm3K/kNtxD
 y2+kv8ssKS6pm+8nlPA4ex+QZL7vDhioZXNPn+00TJRkPA2EaoResnrJK8vHnyoy/OMp
 XlcxgCBNSC0Fz5ot8hKoGI3FlIog5a2cGu5CCYS5EybjcyytJtztC9+87rYEooYNMqX5
 H4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337085; x=1707941885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8PB8djkmNdrvA9adwd3shY2ds256lGobCmvIuundPOg=;
 b=RAUGRvqIfbnozW3W8rTNfmBjqzEUaayeW9YzQeKa8BbScqc5t2ATP0s1Uuq5axjxnd
 jDYNyUn4BLrjEmmdCKqwJUE5NI+xkDCLG3OgUUf5qPW/jwOfLcUPBdPcbTF88tPLMlrp
 rAl+Rqagxks2hBUY+CH52ZTTwSSp3Uq93Dabtlw/XTJOc669s1ap2AYo2AexGXNPUCpY
 IO+opPSg0wNzeKD1+GKDHWYdCTmHgjKtIwAwvrn50ILqBfzNEv45pW2D73dHNSgzVM1s
 Z02u/3Z2jaM4/OnDJhCUPpyYlj+sSW3SlJJqb1gq5EfN2pEgDBgl9vhmihdas3XMtw6P
 8ZzA==
X-Gm-Message-State: AOJu0YxEmdpn/ysGzcARvDtnOvP1ouue9UIX+8YRryJfUCJjXIaT/jcf
 C6ZoCthDmBcHxED4R8fo3SzQf8SSV46WCFLr9xtEP2oIBnyiVK5I+kU8tTber8c=
X-Google-Smtp-Source: AGHT+IG/qKXSnX4jYUp+gXs23ZVAuqTEU7ShctQawAa0vCv/jj/Zqv9MJlXv04W3T1lLv4UycezrRA==
X-Received: by 2002:a17:906:c30f:b0:a38:9911:cd2e with SMTP id
 s15-20020a170906c30f00b00a389911cd2emr581537ejz.3.1707337085029; 
 Wed, 07 Feb 2024 12:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXlqOSqPixR72kM9WCI+IU1Pc3xFEYQ5mzyHeqwwjj32okH2x61EAh4VA3rrs1fvCoEKS1DSfG9GzDFo2W4ZLmKMRIwtoOUOcYpQE7Phc4yeDVvicv8QQwDkrYOnmb1sjiCYK4ROhN/f1mdgqwF/Q6xg7M=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 hw16-20020a170907a0d000b00a36f28baa8dsm1108764ejc.111.2024.02.07.12.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:18:04 -0800 (PST)
Message-ID: <616dcca6-1c06-4b07-ad42-e56f234f7ce5@linaro.org>
Date: Wed, 7 Feb 2024 21:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] vfio: Add Error** argument to
 vfio_devices_dma_logging_stop()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-8-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> This improves error reporting in the log_global_stop() VFIO handler.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


