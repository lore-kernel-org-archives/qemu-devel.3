Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68EAC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 17:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLRIi-0000fX-NO; Sun, 23 Jun 2024 13:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRIb-0000et-UY
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:46:46 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRIa-0003S0-5K
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:46:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-71910dfb8c0so739998a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719164802; x=1719769602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pxiHYkUya/+1wFMZscZhTkjh8DQ5y9fo5j5+nxXu5E8=;
 b=yEY2dNaB/y2RMuYbkdlh+/yW6oPeJP9N6RWhLH1WC8qfIXDo/VHGqt7bgIpw6+dOfn
 3V2RFgstNDZsQPEP7jFUpEuhRki/cJuKE72ZMUX+o8X3nytJDsDqx3vra32wo475lcIM
 aCNRO43uJnobtaoL2MF1kaUjQOntw898N+73sRPTJcgMdV2G0L/9iS5TgWx6l4GHyDOw
 JSczCmnsDebT4Qp58dbbYZnT1mG34MqTw55TZksfxtatCvOB4NCI67f3TgnJFSXDKbcz
 GHHqABzc5cVA5NkJXmAQqK7pyOtO1fond1pAmnDKkD/RCnY83KkcX+GU+j5pvmb083VL
 4GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719164802; x=1719769602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxiHYkUya/+1wFMZscZhTkjh8DQ5y9fo5j5+nxXu5E8=;
 b=R4+PZU+tVaL3GRd/lFPBu0Nrxwxsg1HV/6vRX10vRkJCsoRfhW8ZUx34kvxifMw5bp
 BwA6AMnYCau1PE+FORq4qW5RgLCdTKJrO1IFWLghZYufu3Ndw6kT0Kvdr8snvGVSlcYv
 21w2ew56GFrr6g+Umtd2+yQR95NkSeEwAdxwPnaUN38A0vdwkARVb3Qipzrzx2Ku6V47
 gX2oTvVIF9cn+WEcO0U6iOocsbhLe312ty8JPmjaii2O7u4qzdbJ0KzUJvL5428gCdj7
 SahlOIYuO0FBMOixOWqmYH8J7nJMbtjVSjCarIHft+lteCye+aZdfriTi4vfuqeDgu7m
 rRVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjPzKjHujs1PEB1Tnl4ZZr9QnKc+exSA2lKtOutkb070DAq6U6zJMCAzIKr0oRW0jT7T1JSuxfxajPOTCZuEfakmh345Q=
X-Gm-Message-State: AOJu0YzMhyTYh7fsYfBXLbuhEsehKQABrk7WhprJZfaXfupNUHRV94L4
 mU7Ym0H3MUIjxkV16+LE4KkiMnh6TLBdLtpqYc82oTKPTmcIL6yBE4TzbanZAcE=
X-Google-Smtp-Source: AGHT+IE+DFsFViOawh7V4RqW1317pW0PvANWfl4qyOWrunYnjjuqmiQtaGyYV378a540p9ynMnxH/A==
X-Received: by 2002:a17:902:f54e:b0:1f8:5a60:842c with SMTP id
 d9443c01a7336-1fa1d3b6eeemr38264435ad.5.1719164801611; 
 Sun, 23 Jun 2024 10:46:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb3037sm47505385ad.264.2024.06.23.10.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 10:46:41 -0700 (PDT)
Message-ID: <87e5c820-76ef-44bc-be5a-788bc11183e8@linaro.org>
Date: Sun, 23 Jun 2024 10:46:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/18] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 6/22/24 05:06, Peter Maydell wrote:
> Hi; here's the latest target-arm pullreq; this is pretty much
> just various bugfixes.
> 
> -- PMM
> 
> The following changes since commit 02d9c38236cf8c9826e5c5be61780c4444cb4ae0:
> 
>    Merge tag 'pull-tcg-20240619' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-06-19 14:00:39 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240622
> 
> for you to fetch changes up to 3b36cead6ecc0e40edb8b2f3e253baa01ebc1e9a:
> 
>    hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine (2024-06-21 16:24:46 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/net/can/xlnx-versal-canfd: Fix sorting of the tx queue
>   * hw/arm/xilinx_zynq: Fix IRQ/FIQ routing
>   * hw/intc/arm_gic: Fix deactivation of SPI lines
>   * hw/timer/a9gtimer: Handle QTest mode in a9_gtimer_get_current_cpu
>   * hw/misc: Set valid access size for Exynos4210 RNG
>   * hw/arm/sbsa-ref: switch to 1GHz timer frequency
>   * hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine
>   * hw/arm/virt: allow creation of a second NonSecure UART
>   * hw/arm/virt: Avoid unexpected warning from Linux guest on host with Fujitsu CPUs
>   * scripts/coverity-scan/COMPONENTS.md: update component regexes
>   * hw/usb/hcd-dwc2: Handle invalid address access in read and write functions
>   * hw/usb/hcd-ohci: Fix ohci_service_td: accept zero-length TDs where CBP=BE+1

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


