Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E61D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ5r4-0003Ek-B6; Mon, 01 Dec 2025 10:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQ5r1-00038W-FA
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:30:19 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQ5qz-0002iq-1n
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:30:18 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7baf61be569so5142007b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 07:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764603015; x=1765207815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gxownif5Rg3Pz4TkelmQNHcl6OncwRZ2Ez4bbV3G/w4=;
 b=QZgMaahOTne+JnAAv6LdpuM/wcFY3Sh7CyWfH3VFxVaZJQp69FJJ2cVQqzbm+tPLYm
 W4zj4g6/YyBgZt8GkJywckx8GDoAs6WjdjFBFPXhi0uEMqW9axxlOt1ukyPW9vGPMh6t
 crm811c3mpxc6ApHm/TG5BD0v3L0P9k4fyG6zo6WUKEcHNNCFG2mfH3d5DfNluaLFWWd
 /eA6esbm8WedIDYWBipJJk2dmR97QczoRpKHv3ZO0c/tWx3w8aJbmjUB2xTY/O/voeIR
 6SVj3uoA0IZzy1uPEvQ8Zq1RnJzCuosVUkrLUg+6LlLvzTCyikW6ARoOplrCsqgX2nGZ
 tlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764603015; x=1765207815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gxownif5Rg3Pz4TkelmQNHcl6OncwRZ2Ez4bbV3G/w4=;
 b=Peef+Ol9BGJfO/4dH2ldY9uDb4y7yeW3jCbFRWO1x+I2b/ZXJ/PyMQeI3WlTd5nwRy
 1Z0zxdaaDwP9VHQzteubDHqTK2cAxNXVOjVjIZc0zwiX1uOfUXkDsEwK9+nFm80efr8V
 7gT9aQgDGoJdFfZsmmqzv/dIUBJxzEL0OnHr8KJlqmE/e55qvmNnZ0mlj/ARkJS/8cbU
 dBfKW4jgqDECZvTeNZxYT3aCUV6RkAeh2IWSUZIE6tyMhbqiRIvXXNexg05SUF9bgPZw
 fz+Dh1PzrpHA5xzESLJO4uURwrpinku4pStLQ0KfxlcEepKIUiDEzLaieaO1xgVcgfHO
 DoSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Oy3Levl2pL4/v2Sqcu4lpOE3Bmhc0MobrLsHZ0zo+tHE327/Ir+s6ZOmuJzUSaaPTzXg7r5v4AeO@nongnu.org
X-Gm-Message-State: AOJu0Yy7tkmGT3uFPZLrOwBsMGoXAKLGZehBNIhlMWDSHtpDCLJAcrL1
 OqMbO7UT3VokKqDu6c+9Rb9qu2vGF6Tbv8cpsfkHNbulRmxf7e0bopDgvQ/nwrZBOhk=
X-Gm-Gg: ASbGncue/IjW4DlOHdFDCQMvASanp3RJGq/6uKF0f6brO8qMBxvv/gnOxNqqDvZ7BCg
 80AvybWrZaM75Uf7pEgtLu5dKi1E/87jrQpHo/xNyKfNnjvQl23D3E9ZyP3WMiKIZurrrfIz9oP
 9rkv0VpPBBJsysOCxIgeYRa4dZJ7DdONK0mq5mXlDd5eQgC3GaxDg/Gk4gZXsC8YFLiewDB1lUs
 PyuC7fFV5ByCK5dtPhQ/od1BOmmtpLFavCXe/j5u9yX7Wpw9zpBGju2XcHmdxh94xvJ2VRmq3/x
 5fBDHndryqi8W73xkCtV135MrNnL8RV1P5GXYedSNBvTAHI45R6+frVD1/JAxef/ObT44M1AMy8
 RjseqngJJuAwmmVjL8sZ31QUXpaP1IBzYVASQaeqh6QMNflhFATx23JCA/voTDJ+YXtpD9oUbQV
 3yi06EAZujAd1o6pAtL1fHlQE=
X-Google-Smtp-Source: AGHT+IGUhmz7bMVGL64TYRFq1a0iDY6jPnNVptjbc1RsfcL63Pa3mWTlnjho3GsExwz7EG9Kkfqlhw==
X-Received: by 2002:a05:6a00:a17:b0:77f:2efb:11d5 with SMTP id
 d2e1a72fcca58-7c58c2ac1bdmr39665631b3a.1.1764603015151; 
 Mon, 01 Dec 2025 07:30:15 -0800 (PST)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15e7db416sm13723812b3a.41.2025.12.01.07.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 07:30:14 -0800 (PST)
Message-ID: <f362b8f4-4031-444f-8ff3-1bebf87be586@linaro.org>
Date: Mon, 1 Dec 2025 07:30:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] plugins/core: allow reading of registers during
 discon events
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251128164220.3985408-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251128164220.3985408-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 11/28/25 8:42 AM, Alex Bennée wrote:
> We have protections that prevent callbacks that didn't declare
> themselves as wanting to access registers. However for discontinuities
> the system state is fully rectified so they should always be able to
> read the register values.
> 
> a1688bc86ce (plugins: add hooks for new discontinuity related callbacks)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Julian Ganz <neither@nut.email>
> ---
>   plugins/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index 8f8bc7219c2..b4b783008f7 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -119,6 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>       struct qemu_plugin_cb *cb, *next;
>       uint64_t to = cpu->cc->get_pc(cpu);
>   
> +    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>       if (cpu->cpu_index < plugin.num_vcpus) {
>           /* iterate safely; plugins might uninstall themselves at any time */
>           QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> @@ -127,6 +128,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>               func(cb->ctx->id, cpu->cpu_index, type, from, to);
>           }
>       }
> +    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>   }
>   
>   /*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


