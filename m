Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6E9C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 06:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZmO8-0001AE-5W; Tue, 13 Feb 2024 01:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZmO6-00019x-T6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:35:26 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZmO5-0000b7-HC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:35:26 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d93ddd76adso28656125ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 22:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707806124; x=1708410924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5ESf1ghr+WOnA74iha/4RkoDXSWq7s5UqdPqTrfx5w=;
 b=D6YtjqtsQmEcVrcisJhg7BpQD8MNLh5QVcOUWOuUQy2dMdgrR2w/7jKv2ixhBQ4zRk
 Qu4K4w1nWMxt3LKEQoRW7u74yUTFa9wzJq402ru0ennjF36VRqidGbfNInvWDq+5R1E0
 YzPhAmk9sbWGX1//CVerQURRiuBpViUkLSNbQHIeYvpzqkJ93NYeg0a2PLrg1f4arZq9
 fHuZqsC3VXkE6VgWfR0hBqLtCZeXy4eC488tDJQpWW6DdPXGaI7FHqKlg4ePTk0bm4Tb
 jvFv79U0KsMKwbF8PHDEpXtUMJ2/TSXLxU2akhOs4SGXo/2Hd8uLeCh0tsomgiQTg2tt
 kuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707806124; x=1708410924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5ESf1ghr+WOnA74iha/4RkoDXSWq7s5UqdPqTrfx5w=;
 b=Q8RUjPXz3vOYVdvPRm+Jgg/BCePqjJJQbNld+pHJY41uoDt+xwCUB6QUmbbk8PcDgS
 in/sxCo+wDSjhY+G6zj+k0l90TXkdM1isym5ESa++q+24cs0N7zrrTQ2vMZ8MRNddNWV
 F1JjB2+SFUuT699jRKhgB8rJOe2Ikl9kGs5FgANw6fH3Ad18+/cegtw4bHYRrms5aCbZ
 tU2G9sKSE7hc34dcIqFnMaGv0cJmb/m/hjP5mn6zozzMIP7I9FfzMOm8cQE20Y7Kcy6S
 75dDIQmQ2FHME98vKSMn6HpjE9gec5QppK9+nQQgK2TkTVQuVJep+IPHzZlWb0UBT5mU
 4+rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7etzPlwvnSbUWGIql+b5kZlkY0QN2XUdIyNqDPDiAkxQ5uANCyi8LK+ff9DrIdOSuRlxWwOGRVHwKLULFBDiNYAiIUX0=
X-Gm-Message-State: AOJu0Yw3H2YY+v9mayDvUwMqbUJJyuHw+N3PM9GvHzdVWnp2BetpRlp/
 YyY8jTZdevEEQ4KHOMIA5jU3vYnmHwPzRjyK9dMEfxra21iVmFSWpRGc3MlmQf8=
X-Google-Smtp-Source: AGHT+IGVb+u0Gq4xDohESpV0l9jBX3UVSfIl1IF4nwF4+Ia1mnWEIwCKCYnzZUoNr0dIUyTsjtynzA==
X-Received: by 2002:a17:903:32d1:b0:1db:28b1:b1ba with SMTP id
 i17-20020a17090332d100b001db28b1b1bamr2665748plr.9.1707806123695; 
 Mon, 12 Feb 2024 22:35:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXiihdLgkvinkBDGHdCpYkKmDdtijQB2GpkfMUIyTkxGkJFtKu0MWHZADsgwWAFJtjJg5Z5YOC1OpsB0sfJvip+4tsKu15AXoDe3r8cY65coDSStq41L/gR
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 km14-20020a17090327ce00b001da2926bf46sm1364935plb.4.2024.02.12.22.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 22:35:23 -0800 (PST)
Message-ID: <357294ce-5958-47da-9b69-13b820c2109f@linaro.org>
Date: Mon, 12 Feb 2024 20:35:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/usb: Rename NB_PORTS -> UHCI_PORTS / EHCI_PORTS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20240213043859.61019-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213043859.61019-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/12/24 18:38, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>    hw/usb: Style cleanup
>    hw/usb/uhci: Rename NB_PORTS -> UHCI_PORTS
>    hw/usb/ehci: Rename NB_PORTS -> EHCI_PORTS

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

