Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03379E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 09:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ0lo-0006Hl-BP; Tue, 24 Dec 2024 04:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQ0lm-0006Ee-M2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 04:00:02 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQ0lk-00059b-Td
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 04:00:02 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso3736970f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735030799; x=1735635599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oDKAIsmdLW19i/P9mWzEU69w0622+vUKQ9SUjFLyolc=;
 b=Gmfk99K6BhOcym6qebKHtRRAl4kcnYPOoWcrGPBosFEJa9/h7FD30wpGXOMm56eknA
 KAXrWMG6CFciHhkS+PrPLsGqHmpyWZKXpM9nw97NmbktMD1XnBubiWNGJkPtmb2tWoY6
 4Eu2wrD1PfhDdTNr85Pb26LmownxL9zS76Apm3QFDYXnwM1YrJhiDt+RBCiyEn0DE/Gu
 MEJPAr1HzrSyv21KOZZ2Duviwo6zAeoophTm2P/dmpGIVR0SyolJ68R1ERvt0p2ap/SE
 eQ65LZtIbK1aj7AnmsIo5E3E20ZGjlnK6yS1cmqAPUYP/v1nnE/kzBWGkkgy8SyiSXIA
 q6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735030799; x=1735635599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oDKAIsmdLW19i/P9mWzEU69w0622+vUKQ9SUjFLyolc=;
 b=neJG2CCYEMQf6pcgoVb/4y5kWrRy9LGAn14EVFSf1IljFyOaXy3LekAbwkxXyOfymD
 d/cctiyLLv5VXA/ZdIAe2SN3gx3G8cCVTKarplmFrEjFkDtW/jch5rCSKG6p2z0hpZM4
 XToX4fcHwol2bLiXbSeON9AJMxHxdmndzWP+3rNvQXTpDj22ABEVVfJo3z0OoHS1uf9S
 H7pVT4seTJ8XJLqQsRXyey2P4EBfH2WnzzK9CK+q+eDJXEpS6TqTpNrhQJIDolQRwofP
 OCf9OxJgJ1TbNIO4nq9YUb+2pDX01i1m+EgmjmCx8F5a/HhaQXyN3YDyLQjofyeZZoMI
 IaOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr+OX2aTPIZ72KhDZrT15GGlb3JRArwnINq9EQNudyDAcEuHefkACU3SqUTGI+zi49AIc8rAx3YESP@nongnu.org
X-Gm-Message-State: AOJu0YxeXZH5msx/CWDgJJi0EAc1EKdVYcVbLiVCvxV3aRmdbhiWKajh
 rRuXsWVgx4YQDE0sdsn6CpQoMLJnatq+TfGbHSGJv/dMUyIf0XqPyZl5URdF040=
X-Gm-Gg: ASbGncv4scbtf+nhEqQTeEZkheilKbMLpFLyJOGTn52EhoFZzG1XGZvhbfgJu6euSeL
 2iYgGBa5AS/xhp6u//mG31cvoFwfQbgVKO1wl5KqGDeGzJasm8GRagphLWDHup7DBCzZzhF/YJc
 Lwougm/1kAChy3f9SRSn9HrokOWrsCh+zn8A3yIq5llsi8Eb790Lj+601gArTEU96Hk2hxPXbum
 QidQYKaBmNjjJ8xvIgHIQezhKVI+/zIjqxv5rmHIUGNn7I4uQx0V9/wdaWVt0t9bSw=
X-Google-Smtp-Source: AGHT+IGzx9Fr6LzLw001ZnrZ/4M8B/V4vexPOqZ1tjaERzbRyOQA73dSUArFNyYaHzdLDB2vdU54cA==
X-Received: by 2002:a5d:588e:0:b0:388:c75d:be97 with SMTP id
 ffacd0b85a97d-38a221e27bbmr13802325f8f.11.1735030798956; 
 Tue, 24 Dec 2024 00:59:58 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm159476685e9.44.2024.12.24.00.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 00:59:58 -0800 (PST)
Message-ID: <98696813-b2fe-45aa-a759-25764435b7c7@linaro.org>
Date: Tue, 24 Dec 2024 09:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
To: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 Lei He <helei.sig11@bytedance.com>
References: <DM8PR13MB5078933D25141B3F23ECA782B3022@DM8PR13MB5078.namprd13.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <DM8PR13MB5078933D25141B3F23ECA782B3022@DM8PR13MB5078.namprd13.prod.outlook.com>
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

Hi Gabriel,

On 24/12/24 00:46, Gabriel Barrantes wrote:
>  From c808fa797942b9bd32221594b7eef690a7558b14 Mon Sep 17 00:00:00 2001
> From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
> Date: Mon, 23 Dec 2024 14:58:12 -0600
> Subject: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
> 
> Do not propagate error to the upper, directly output the error to
> avoid leaks.
> 
> Closes: #2714

Better to use the full issue url to ease downstream backports
where this commit is cherry-picked:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714

Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
> ---
> backends/cryptodev-vhost-user.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost- 
> user.c
> index 43efdf9747..09bfbddb47 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -281,8 +281,8 @@ static int cryptodev_vhost_user_create_session(
>          break;
> 
>      default:
> -        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
> -                   sess_info->op_code);
> +        error_report("Unsupported opcode :%" PRIu32 "",
> +                     sess_info->op_code);
>          return -VIRTIO_CRYPTO_NOTSUPP;
>      }

Arei, Pi, Having CryptoDevBackendClass::create_session() take an errp
argument would simplify the call chain, reporting the error once in
cryptodev_backend_create_session().

> 
> -- 
> 2.43.0
> 
> 


