Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204E2C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5Dr-00023u-Lg; Fri, 01 Mar 2024 10:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg5Dq-00023e-A8
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:54:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg5Do-0006ab-QO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:54:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412c23551e2so10002395e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709308491; x=1709913291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mS35f51VgRb22qx+xNAjjizltE0lviPsot6aYY6iK3c=;
 b=Gu75KfLV24C4BNUsVR0GobVm02sdXGjsGLlWsLm30Du63AHA7qX6igJg99I07k9LjW
 WjUEIfvfhEpqTZhbnfYPNqBfS+MrBdcmvjEyvbIIvBYz5Jl1r7hAOV1933SDuIrjPjTz
 zUtWGNJtxBSMPm6TBEUVVGkNx09AOkSGCDgz+rq3RYdcRpRRy8eyodRi2JjIFA/LWGrg
 PYydZaW5zr7JGYaQ9Qb43GEBlbI0WZ3xjIRSXrKgsUM5cuu21JFv3g7aebSqC8SLbbP+
 iqGbZfvWZ6bPkWAb2/oxJMyqX5T0tKg9wBR3k7/KEjU50BRRbWKJ7THMtc9vF2/P4QVk
 cmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709308491; x=1709913291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mS35f51VgRb22qx+xNAjjizltE0lviPsot6aYY6iK3c=;
 b=dA6a2tOlAnnO8oG0reZoVpeToY2517fqmKG+bbjKeUDZM6iEC30RbcA2iutdtPkt9f
 ef8DN782NVHFDZN1WD9XivffE8ZVRXI75s8v4iRXMqaSsKtQ4i/XQz8y1eur99kvxNVM
 Or93W7WJL8z6ZRl+vBEkeyBa9b6O1C1+dRlv1aB/7SkcCwAWd5MvSy1NkWL+ANyKvPT8
 wlAjp3MQVJCSujjRCMNiGZv0jxYhRVHS5+24SPGHhBFgz/hPHMRQAAXALxxqTVliUZEQ
 bDK1SsHnXRRFXKgOr1t4bBxvXy8K9OrLmCx5pmP3J5vghVDJAwVRmgqtAsBwcekU9vlG
 mS1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0W7eW3yGpjlKmDcnri/wnoU64UMzhNyBpNj967/AAZG9hmE9Zb93LYvPLWU3eGX+XIIrwzEjCNvFOSPV3azDOBU9i8gM=
X-Gm-Message-State: AOJu0YzcvvOF8Q/ixxxl2RyDSpZZx8zpgUDWDjHn0YDEGXmoIL/efqvG
 jrM+hMfqAB3cPHIPkaARtil/OaFsmEQdOVo+u7wMO3NcPazNpC5aAEJRQooXcMg/fupdxRjQNaW
 n3E4=
X-Google-Smtp-Source: AGHT+IF3gGjFp0hWdfEN8lNYBVWeyLOEYHdqfMvhzrhd6bEAk7rHofR9Kv/J+Lpy4aGjG3ytD6uhmg==
X-Received: by 2002:a05:600c:5129:b0:412:b0de:38c4 with SMTP id
 o41-20020a05600c512900b00412b0de38c4mr3121664wms.8.1709308491158; 
 Fri, 01 Mar 2024 07:54:51 -0800 (PST)
Received: from [192.168.193.175] (232.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.232]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c021a00b004128c73beffsm8797363wmi.34.2024.03.01.07.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 07:54:50 -0800 (PST)
Message-ID: <86203a7c-97fc-4f3c-98cf-35268b9291ce@linaro.org>
Date: Fri, 1 Mar 2024 16:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/1] hw: add some convenient trace-events for pcie and
 shpc hotplug
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240301154146.761531-1-vsementsov@yandex-team.ru>
 <20240301154146.761531-2-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240301154146.761531-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/3/24 16:41, Vladimir Sementsov-Ogievskiy wrote:
> Add trace-events that may help to debug problems with hotplugging.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/pci/pcie.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/pci/shpc.c       | 46 +++++++++++++++++++++++++++++++++++++
>   hw/pci/trace-events |  6 +++++
>   3 files changed, 108 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


