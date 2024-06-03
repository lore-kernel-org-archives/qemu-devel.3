Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D66C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6mA-0003Ys-Ee; Mon, 03 Jun 2024 08:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6m9-0003YN-FN
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:26:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6m7-00051Y-9P
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:26:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so24451455e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717417611; x=1718022411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+4xoFkXuoV+BJOlhvNor/nOVXI08aOWzvEQg9+tGyjU=;
 b=wAsjU430P/9wD6rhbuz14VQ4rSYmC9ecmbrmEe8YDiZSRdyg2MumxZDgzjqXJ0+yfI
 MRPUcLIo0pVGdYCCXSP1WdZVkquXCaU7C8V0d/pU9wlYPOn8C7TpP7Z3RoWfslVYVtRU
 EZHqqsSfFmODhNGEL3ocnBrmgdH+X03XcRdislCWRqNbX9r+YyAksleOZZy7JoFn4VZb
 xAVj4YoUnwYJ/3lvfXSrtYVNsBP14JEuIKW+PjPsAmzO3TCB0PPzeUECGVdn+rUQLwDa
 CPOivMDRRL1qF1Jo8Z6eHGB1b1n3X2GW20ioPmAWEJzGH1dGjTXTtaLBtNaD95cvZv7h
 qz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417611; x=1718022411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4xoFkXuoV+BJOlhvNor/nOVXI08aOWzvEQg9+tGyjU=;
 b=RtuJixa7nLx5ujvp77pC64v61OUmvul6b8j7dGhBBrfzhV2bonFSPw2o/LhMOMuw5M
 KJ5/i0ewP7CRjLAdHFxq6zcJ/cphmZhC5MmpOH2HZW8itECUiSsMR1J2Xx4bLysiZXCj
 yDZ3ngkbo/tbFy3DMnsY7OlgUCF/4YSfCHdUowNu45QqyqX82a8yHL2zdfnxBKJcrtMk
 rRH+wqpa0qAdwGq6EWln94WrlGLOd+77dx++rqdMbSmCZiC36VW1vH+xzB406AeC0oSY
 qUGGx+KxxnXNN5vuR2RRCyo4FtIm/T95mkayFqkfx49uXd+Hdl67tYB8ldN4kW3wA0F3
 3DlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxzpycLQcu4dLoLu3q+rLksrNRYX0MkEWEBWGcnmLOeeaH06RDDwDFdYBMmlROCrS2puHs2Pb3ZNkuln1NYva2a05A1og=
X-Gm-Message-State: AOJu0YzxkC6EAO6hITAB/gLNl/bHdl////95HZbNI9cru8Sp4tSsVLxS
 53HvZG/0pOTzsHkiD6orRpACZFU1On5jb65jTwWdWwK5FMgErekZDY/k20mRJOU=
X-Google-Smtp-Source: AGHT+IEJLqDe5TjAm8AErPnQFWndThyjHOomHE01A/bq/XVHqBE16LtUOM3YdvYyPrLv49Qb8CkUkw==
X-Received: by 2002:a05:600c:3b94:b0:41b:4caa:554c with SMTP id
 5b1f17b1804b1-4212dd322bemr82729655e9.2.1717417611358; 
 Mon, 03 Jun 2024 05:26:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213860126fsm68175775e9.40.2024.06.03.05.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:26:50 -0700 (PDT)
Message-ID: <d5680124-827a-4b03-838c-77754a84599c@linaro.org>
Date: Mon, 3 Jun 2024 14:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/32] hw/sd: Add emmc_cmd_SEND_RELATIVE_ADDR() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-18-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-18-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/7/23 15:24, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index dd60a16f8c0a..5ff132139ea9 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1053,6 +1053,25 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>       return sd_r2_i;
>   }
>   
> +static void sd_emmc_set_rca(SDState *sd, uint16_t value)
> +{
> +    sd->rca = value;
> +}
> +
> +static sd_rsp_type_t emmc_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)

"emmc_cmd_SET_RELATIVE_ADDR".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +{
> +    switch (sd->state) {
> +    case sd_identification_state:
> +    case sd_standby_state:
> +        sd->state = sd_standby_state;
> +        sd_emmc_set_rca(sd, req.arg >> 16);
> +        return sd_r1;
> +
> +    default:
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +}
> +
>   static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>   {
>       switch (sd->state) {
> @@ -2194,6 +2213,7 @@ static const SDProto sd_proto_emmc = {
>           [0]         = sd_cmd_GO_IDLE_STATE,
>           [1]         = emmc_cmd_SEND_OP_CMD,
>           [2]         = emmc_cmd_ALL_SEND_CID,
> +        [3]         = emmc_cmd_SEND_RELATIVE_ADDR,
>           [5]         = sd_cmd_illegal,
>           [19]        = sd_cmd_SEND_TUNING_BLOCK,
>           [23]        = sd_cmd_SET_BLOCK_COUNT,


