Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A8AC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F3p-0002mo-HS; Tue, 22 Apr 2025 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F3e-0002bp-Rw
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:57:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F3c-0005JW-I6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:57:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so3611835f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333826; x=1745938626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M0u9pwmzYMZ/cSxP6F9W22HKx60q/7Y66wIX3zWmbVI=;
 b=huHOPO1lbB5KSkN9d8ROqK/aLIU4IZ1ZQjOMpoAPYxYeWQ3H2csO3yZ1DNhrFtkwhi
 uO8t++TUlHYmEeu16VLCQ1XSOHlMwbPwTJC4erPuy4w1WBpq0cJ0D1mez5nODOYWRODr
 4fScYTGL0GDudDi6RyavJHfv7no59iqti4BKPS9qgq6zWBV8KGJHEoqBmrW/woB/eBas
 KzDPCixim8znANe6djjYUs2qECTEUJl5qT2w6A7gvrOsacPH0v/AMbM8yfEIbYDasEtl
 aiHWtaiIAfaUSxcevBGU2Jr2Pm86gA1CQNvWlBzNqbVCFQV2T0Ax4XdAJfEaMYh32QOk
 ParQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333826; x=1745938626;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0u9pwmzYMZ/cSxP6F9W22HKx60q/7Y66wIX3zWmbVI=;
 b=MmohD9OD28FJmEe0HfP3C6hA2WMuX43msYidmsW6yszxPxpndhar57qji2w3gp2rO3
 d+y4chWw0OF0xq94/vL58avoiep62pgmGSOWeBLIn1d5Y/VQ7Q2X+EUgmlJt4fZxo19h
 9iC/pJYR0WN/5bdgDd5sw82FhxElS8+UtgjgsIXmBvU5ccG325dUpv6A/rQaBHO6MwJs
 bR/E4VXcYBiOQstjVy4iO93m5152d6j/HrvbIvQZM7Ahv+xnsP0qaUhO02E/e/61CTeq
 6GRBNa6VPOuV98KJ44vcnIIyzII7CeCOs6eQ2YEzggKzBrYeOEzhhsomWCyoL2FjYG0r
 grFA==
X-Gm-Message-State: AOJu0YwJbVJDin1G3K1ItFl+ZCcB/0Qk2De5FEoW6kXLnvSmHHgW0Jgh
 yPPSIlOMgSA7Etp+KyUy+NTNrCEwwoy6vTgyG8Amdp6esuRle+1vhc43WRch4xHcARlDf3Yf3yc
 z
X-Gm-Gg: ASbGnctfryZJTxZxqxpTor/sDrB1reLBIY5MOZd9FyGdMjVnvyaYyTOdcwEkHJ3/hFO
 psz2WpbVMFsxNjISvsptf9W3liEWvMjkt4zpGNN9hhk3Mc+/N+SCfcufAw6bzMUvl2uRZxNh3l5
 h8j33q57F4R7s1+UkB3FZ7dHBCnosn4uvYPOdejbREOcxSuFCsG3d/cUknDVW6nJ53HK4Mhob7c
 7d08c2ArRzMrWxX9aDzW9FXovvqIRR2ZPVm9jMH0BPpvy/4bQ7TAnASGd2qzQy7azKnQteOiXbX
 AVTeJLrRbfFZMlEREOf7mZSlAKQ83pIbm0DeWVO3kZj+nSU6OLQ0Upd+FhsQaWKwqtiewZ9aG8g
 4+c1ybqPa
X-Google-Smtp-Source: AGHT+IGKVunBS6NwVASJwryoOKSAGLeWRItQ0tdo6LW0wdWGSss7Cm+aA9wKGGgUykghXv6PPS0oEQ==
X-Received: by 2002:a05:6000:178b:b0:391:9b2:f48d with SMTP id
 ffacd0b85a97d-39efba6d7f5mr12816209f8f.33.1745333826276; 
 Tue, 22 Apr 2025 07:57:06 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4332f8sm15273825f8f.40.2025.04.22.07.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 07:57:05 -0700 (PDT)
Message-ID: <70450631-f372-4e4e-bbf3-7ff89004e460@linaro.org>
Date: Tue, 22 Apr 2025 16:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 01/19] qapi: Rename TargetInfo structure as
 QemuTargetInfo
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-2-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250422145502.70770-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Cc'ing Markus

On 22/4/25 16:54, Philippe Mathieu-Daudé wrote:
> The QAPI-generated 'TargetInfo' structure name is only used
> in a single file. We want to heavily use another structure
> similarly named. Rename the QAPI one, since structure names
> are not part of the public API.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   qapi/machine.json          | 10 +++++-----
>   hw/core/machine-qmp-cmds.c |  4 ++--
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09e..6889cba2c75 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -275,15 +275,15 @@
>   { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>   
>   ##
> -# @TargetInfo:
> +# @QemuTargetInfo:
>   #
> -# Information describing the QEMU target.
> +# Information on the target configuration built into the QEMU binary.
>   #
>   # @arch: the target architecture
>   #
>   # Since: 1.2
>   ##
> -{ 'struct': 'TargetInfo',
> +{ 'struct': 'QemuTargetInfo',
>     'data': { 'arch': 'SysEmuTarget' } }
>   
>   ##
> @@ -291,11 +291,11 @@
>   #
>   # Return information about the target for this QEMU
>   #
> -# Returns: TargetInfo
> +# Returns: QemuTargetInfo
>   #
>   # Since: 1.2
>   ##
> -{ 'command': 'query-target', 'returns': 'TargetInfo' }
> +{ 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>   
>   ##
>   # @UuidInfo:
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3130c5cd456..0e9ca1b90e2 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
>       return params;
>   }
>   
> -TargetInfo *qmp_query_target(Error **errp)
> +QemuTargetInfo *qmp_query_target(Error **errp)
>   {
> -    TargetInfo *info = g_malloc0(sizeof(*info));
> +    QemuTargetInfo *info = g_malloc0(sizeof(*info));
>   
>       info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>                                    &error_abort);


