Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BEBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsg0F-000242-Ee; Thu, 13 Mar 2025 06:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsg0D-00021X-Mi
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:41:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsg0C-0004wu-4Y
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:41:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso398464f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741862482; x=1742467282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uogxgqw8kXQTkWUXoAqDvaDTKLeiJRymlZ31aZ7qCLI=;
 b=qlLoEC6dpa42ALd1swQKGWMC1F/HHbUM13mX24L8yDO8HQ/bvtsbwbwRpKlWZ//gOQ
 WxfDGDxQz3SW7pBH31NeNagYRW+7qZDBAw+XRo6aK+8+etkXG27RZQ0HgYTB9R/4ZnMC
 Dkt00ehPKEADQv+hJNrxssAiRMFauBpQAOCPhTzC3YXkajWF/Qg+3+ZBeuyz5Tb8l9hn
 CZSnjPk67OEk/M7aTnE2rter8B8l+ROQiaTBSJxgS5cyFsHnPaXa5gviCKdoGULyAsMw
 4oUKlsa6dGy8hjJfDmXZIbogXm2y+ltPWAhf0D5NVTbG5Fk8TjWEA0HaRblv2/lvJ1Tu
 WIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741862482; x=1742467282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uogxgqw8kXQTkWUXoAqDvaDTKLeiJRymlZ31aZ7qCLI=;
 b=Z+t6ZC+xKSGhGtzO4nbHbpCXj7l9GycuksgGmvV0o9zZ9akjklOE7FWJNx44oICS9H
 WLJj3eE37jZOnuu3Lj2wq/JlLaD7SJFRFvZ2szmEvi5ERdyybq1rndyiYJ49009PbwKp
 OqrcM3hBLtzfQuiQdm+ttfIjL6d6D8XkSUf87LvDt8IO4G4UlCW1guGeE+deH8n8Ei7g
 agTTVfO7qyqIjmcygKgFpnLuLEZqNewEnkpZDWZMwoW2dy0FXMPR0KV14r+u0mg0hvMR
 MHD+DwU61p0uawp73/vehCWEfM9nhFDEShiInFuTb8GyodQcalvcOOBBt2/UIawXDlq1
 EQ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs7p/Pz10Gb51+PzLNgVo4B0QLvh8uHH/g6TxDYV48YhE3KWJDm/5NW2wBmldiCjxYtFhX8hsDrLRo@nongnu.org
X-Gm-Message-State: AOJu0YzydQuaPcsk3LgahHU366Cbnz+lNENiC8WVh8X29UhsJYBaFJbn
 F0wHmwl8nQiuJHSJhoJ+1FARhmtroBsZGWpHMZFpeIIThbdzoBaPy9hmPYMWa5Y=
X-Gm-Gg: ASbGnct3mKc8TVVcuPBEzL7uUtV3+nmirtWLhFFTOFyoy8aCuh/+F+n8xvTkWDTW1Zv
 HxgQ4SUXaZXuQ+eEKgIpDSAC84Mki+XIlzkEmvLtmZr5BjWWd+SOLCB4ge53s/XO0d4xHeE8qXa
 wmp8+EIDF51E5X6H+gxtKzEvMeT3rLINyysuQp4fUtWJDy7nXpR+twc7K/N0G15Bweg9oDFiNOH
 4blLm5XPxo/HKkFu0JoqE5NSfNpkWY4423b45X81ZAsEzkAeIHmf4sHefL/7GR8KO3MmOstUeH1
 WpDFZ9G3Ku/UBxbNxjO8Vk84r77wx7KWs0J0iFcZ4gKbYJs6Mpu/Wgcm8eCPCaM1ylcb10cbiGV
 hrfCcwchOD8rRvC8=
X-Google-Smtp-Source: AGHT+IHglwtD/k6GmPHzVWYMZ4EFMmff+m/sOuK65Iz8Mpn+PREh+DrLKCkxiya+HaH7dWCNAMXxNQ==
X-Received: by 2002:a5d:648f:0:b0:390:fe13:e0ba with SMTP id
 ffacd0b85a97d-39132d70bc4mr19234336f8f.27.1741862481992; 
 Thu, 13 Mar 2025 03:41:21 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318afbsm1689675f8f.72.2025.03.13.03.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:41:21 -0700 (PDT)
Message-ID: <f3138658-505e-4222-aa2c-624e11875efd@linaro.org>
Date: Thu, 13 Mar 2025 11:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/loongarch: Remove unnecessary temporary
 variable assignment
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-4-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313091350.3770394-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/3/25 10:13, Bibo Mao wrote:
> Temporary variable ret is assigned at last line and return, it can
> be removed and return directly.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


