Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5DACE8D6E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srE1u-0005db-Nz; Thu, 19 Sep 2024 06:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1k-0005Cj-Dl
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:45 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1i-0002HS-ST
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:44 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso7020141fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726740281; x=1727345081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmS1/Ofwu6iA+fLaTig1MjOvX0L/Q3AH1i6riQXDoWE=;
 b=XjCmCc8dlGxNDmSE+DOFThJ26nq4m9dM2aOeCWkwIV9IxJig4/0MZPfN0NDDhb8lox
 encGuZ9YuCDN3oQAGB13Dmf8ZLElaFcFSbPoFgH7iY31TKOCKM6kEX6P6SZMSlCWzKfw
 23cj+1IARfWBGKAk417COliH8G+GSS2Rt4mbRH/RXzv9lPFOVVpvI8JhXvN9+1Y1PylP
 Y8qkzgPwcMSxEAjuCyNMCohFEpygFHsp1SxLHOh8d80tIjNS7yUBZy+VmvF+k4Yj3Nl6
 M9u9rv4hVO8tnlleM8Luw+SZNOxhOZnBy4WGdPXbgcQ4qulPaVpnxBku+GrkXw8lEA4N
 hX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726740281; x=1727345081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmS1/Ofwu6iA+fLaTig1MjOvX0L/Q3AH1i6riQXDoWE=;
 b=FeF8ju9XIiKTufp9KxuCzRr8IxEtD7fAeLq9SPO2pMgFR+iOrjKwL/02p1Aov0pNur
 FuJuCjvZEWNYHwdo/ROP3OBXuh0J/z9RqFIWVLhW0HaIb+BhehniyYiY/3qVBCV/PYJU
 ADLMU9CK0twMoc5M/uFxRsnBbEQirJvW5LEMvJ9FrnVdscaiA+EFZzyIi7+INqFePndx
 ajfUWmVT8NauVj44FfBEDrdtS/VF7BhQand1ILObLIKif8UAeGJilMG07162VPuVsayO
 9qVw35KanRn5hIyyUCaZYN0B/twQH8b7Q/j0tDwgGRL1UYjZohoQbWpOQqF7wu+WXusz
 XZxg==
X-Gm-Message-State: AOJu0YxizKBRUp8jkEOf3WiEGWp7c0WBknECeJ9PJMmrEAENd/Q7VcyD
 V6cGzCkW6l2caNcrjGecryBBIcifINODVLJMdDJ2PxuXBWKmbxV4SelW7ilTaFLpDcpbWUvsEsJ
 KPjo=
X-Google-Smtp-Source: AGHT+IFJsjPOYuh+DPTgXxo7KkE/1XrPEs2WFn9xsAtbTaIH9XlvVOJSiC18bAMO45GbVHp/9iZilg==
X-Received: by 2002:a2e:84a:0:b0:2f7:5777:cf14 with SMTP id
 38308e7fff4ca-2f7935c342bmr108841901fa.35.1726740280905; 
 Thu, 19 Sep 2024 03:04:40 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f3aaesm701574766b.53.2024.09.19.03.04.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 03:04:40 -0700 (PDT)
Message-ID: <ab10b656-c389-47cd-ae20-3287e1f73688@linaro.org>
Date: Wed, 18 Sep 2024 16:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: qemu-devel@nongnu.org
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/16/24 20:16, Heinrich Schuchardt wrote:
> +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);

Using mxl is definitely wrong here.


r~

