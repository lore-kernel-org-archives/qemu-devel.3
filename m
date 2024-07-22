Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDE2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVw8T-0005SS-1i; Mon, 22 Jul 2024 12:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVw8R-0005Lr-91
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:43:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVw8P-0006RB-5D
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:43:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so32139475e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721666612; x=1722271412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7TtHrl9rQrselaWy83peZcth3CnbPxV5LK1Nw2zxaDw=;
 b=zpgZAxzun7MmHVDCsiV0OBI/A2LADi0M2yjGfe0yYgzqCm8ZvluV3oSMuVfF00pi09
 AOwhC+eOFQXg9zeKLvMz3TNq6E/7PofXzahejiA38orwpCOOrqKuoal/fhUtq/VunZ2p
 manic6tjm9+QJnIenVde794eYB2S2hQinFY0EMNzSmznxe5W4rurXKvHIx8kmcibZzjW
 6rd4lwXMG593soCRj29Q56QHqDmqjEdxXK1cifqyyWO5wSXSlWN/sdrE53ps3nhvbj5/
 tI79xv7XnaVx4KVTGosNJ2BUo7ylJK/no+/b3To0ndWCeLUVgB70HqKCIQ76hNpIjb2t
 ScKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721666612; x=1722271412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7TtHrl9rQrselaWy83peZcth3CnbPxV5LK1Nw2zxaDw=;
 b=YiW5q40l+SG++TLf67zRtnCCDdW+uzk21+xSUFygdr5T1wfTig+dP1zDFyMYUQnsd9
 tUiJCvL8GIpCwNkTicI+hWwAVcGbKAG3wYPgnO+Fchiur/sPB6Ywdy0d46iT43Ezn0bl
 Jn+8WksLKJBGCxY+/r3aPW4RYAhuX1L/FTEt1vu2wVGZRCmEXVkqq/KRmrs7EvhaDYmU
 ew1fiqxN8OkExH6wpcHlsdJvgIn9LLesdsvRK/AngNuqDncMsZUakJH8hxA3zFqYBZ+z
 ijuEVivODA+D9xMXTmToKtO6Z80DvF08y2B+YVDScia3P3p/ableAEZORhFqI4yhfcD+
 +tTQ==
X-Gm-Message-State: AOJu0YzFigQQVlkQMEJE0ftgSuoOwmlQszKudagC4TfKK2Rdj3ODC6bH
 Ra+Gvs5dUn1nqbEc7q/8/UVv9W9rkS5SlMX9/utQnvZG6XFYrpKJxxVJzFxJQgM=
X-Google-Smtp-Source: AGHT+IE3Z+VgPiNNfzLv/KHYJe6LPDVPEVwVALgyCzLrL9ZdVZ2NlrnhyNSoV0Ta9GvXxstWauoqDw==
X-Received: by 2002:a05:600c:3d92:b0:424:a656:66b3 with SMTP id
 5b1f17b1804b1-427dc5292dbmr57433275e9.22.1721666612312; 
 Mon, 22 Jul 2024 09:43:32 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d9193350sm120374305e9.40.2024.07.22.09.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 09:43:31 -0700 (PDT)
Message-ID: <a194f976-aff7-4aea-989e-0aff693d6dbd@linaro.org>
Date: Mon, 22 Jul 2024 18:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of machine core
To: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org
References: <20240722164412.1163414-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722164412.1163414-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 22/7/24 18:44, Zhao Liu wrote:
> While working on a series of CPU/cache topology work, I became
> interested in the machine core component and would like to help to
> review more related patches.

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d9811458cb0..0c55fe72611d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1879,6 +1879,7 @@ M: Eduardo Habkost <eduardo@habkost.net>
>   M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>   R: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Yanan Wang <wangyanan55@huawei.com>
> +R: Zhao Liu <zhao1.liu@intel.com>
>   S: Supported
>   F: hw/core/cpu-common.c
>   F: hw/core/cpu-sysemu.c


