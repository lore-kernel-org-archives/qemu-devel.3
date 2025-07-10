Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C62C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZt7O-0001Mp-AZ; Thu, 10 Jul 2025 11:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZt6d-00015T-Gm
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:22:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZt6a-0002BP-Gj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:22:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso750070b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160955; x=1752765755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YdZ8iDB6AC5cm6mXp19SHVqVi/13G8HtSgfA+fNOPYU=;
 b=tOREfT5DWwlAE9m+Y2RMQpnTxqTgcb3L7XAHbNwZ6k8MYET1DYDIkI0lfCT++sOHuK
 +QQ2s6MXJGiqnIBl8jgWjqUAmLbPKpXRBU7sBY+8BpljMNL7qR2qd66aNc3Gn+ZShWCb
 dvuVXbaIQ2MF0tPRIhMPFbDvv7HKZ+ge0ZkLNLOcporGeUYh1Akqg2BcZLLyZt8iqb/n
 if3TuooiP6uqxaThQqoqlhwg+GUMt/TjtRxJiji9IiJe6P6VmF8w38maLQFF4ChI82+L
 Wr6N/IVyHUt136Ef47M9DuZ/NMkawytygt2otzB4c/dQyw5nLzr47UV72v+G/m/Hn6J4
 /8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160955; x=1752765755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YdZ8iDB6AC5cm6mXp19SHVqVi/13G8HtSgfA+fNOPYU=;
 b=olmN5a26V2Q5t+LShfxdzZzqmPEMEkbC9xqB7U02X/eEei+rzKpMUGsnw7rBxVcjDq
 +uuQ8EYrqSq6NMHfeqZ7Sr80DDgoahyA3hPrG1qLOA5TSGyPeezxcOj0IFR94YVSJOCM
 3UahlxQwi45bGEQ7HNG/jwUoYla2DH87ogqQVtAz6dTGit9paO6X1PRFQ3Nk8UwTAXuu
 5xhhIdwqWC2fT96FPv8X1xuP57Xw57TxxbcO5CdO98t1BBC8pjDDMKW3OGc9OHnBWPCa
 4XRJZQyq3tFyiRBL+Cbxcnccn1T3GHhLxwnyKlhjmkDKnrz0bRcEJmT/iIsvCBh9l6B9
 AXGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYc1Wf7GNBRnITCXVgsaPeS9CQgMa3CAy0LlTEaBBkLwmJg9xjbnw2sMN4RBc+nNoOLOF3O30ovVIQ@nongnu.org
X-Gm-Message-State: AOJu0YwUQy+weWOpvNwK/vZbJfXuffI+Lb/z2m4VX2sKjCUcCNPfzbnq
 rp4yHUss8k77XAFBTkn0UEWQYQnglLQKReGnWKuKQ9B0gzXGeE5cv58atauTCJeubdY=
X-Gm-Gg: ASbGncuW2/IQcnXjZkmVN0Zodf6SU/1uBXEWnqjA6AvyNJduDp5U8v8VOVHaGtir6f8
 Kzs1LKW1s5ADM3dChHVAFjNnTiEwvxpeD4SFXjFozJOgmyOLKJbz4oUDHMiE7UyFyY84Vngm4tc
 2DXsb3sOOPcyXhAop0JW1qge1xArjnBynP2G68ATEsmLu9Q0P8quzC2tAeTH5VMrEK6oTwy9tg5
 CR7nY10qOKGU/oZRZQMydje9/QloBdUf5AhJYPF37DwHDW569ySQpOZwDGoxsY56V3jwbL61GXC
 S/RjC1+hAn8J1rVhWrauaOVm+BTwRSf7SJPuFr9hZxj3m1VL2WFM4kOL57N/G9187PNrNOWkZgw
 =
X-Google-Smtp-Source: AGHT+IGkiO1owD3iqWD0amenf69Okrb561DdDwi7/d4ZNJhaWvu1jM8Hv/t2UETX/i04NSHrgT72CA==
X-Received: by 2002:a05:6a20:3950:b0:21e:f56d:e4b6 with SMTP id
 adf61e73a8af0-22cd64d9d26mr11575733637.18.1752160954811; 
 Thu, 10 Jul 2025 08:22:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e063b3sm2765593b3a.54.2025.07.10.08.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:22:34 -0700 (PDT)
Message-ID: <0052f9d2-53f0-4dab-b594-31f5cf723a64@linaro.org>
Date: Thu, 10 Jul 2025 08:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] plugins: fix inclusion of user-mode APIs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
 <20250710104531.3099313-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250710104531.3099313-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 7/10/25 3:45 AM, Alex Bennée wrote:
> In 903e870f24 (plugins/api: split out binary path/start/end/entry
> code) we didn't actually enable the building of the new plugin helper.
> However this was missed because only contrib plugins like drcov
> actually used the helpers.
> 
> With that fixed we discover we also need some more includes to be able
> to extract the relevant data from TaskState.
> 
> Fixes: 903e870f24 (plugins/api: split out binary path/start/end/entry code)
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3014
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   linux-user/plugin-api.c      | 1 +
>   common-user/plugin-api.c.inc | 1 +
>   linux-user/meson.build       | 5 ++++-
>   3 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


