Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759ECCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkgW-0002Gd-9w; Tue, 12 May 2026 06:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkgV-0002DJ-H9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:49:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkgT-0008N4-Qi
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:49:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so90786755e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778582992; x=1779187792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/rAUHy5Q47gybSESJJWoqR13PpzsY8CoUQJphBxxo8=;
 b=ORFk5XHRelXRXc0DwSSZ42/VfG2jcsl+VtMrSZpwyK733wbsJquBr/pV6ar2G+Vgp0
 PkguiL54bV+cGFX/3z5cPP/gtB5SxUoz65sscf3FecGB3EkOfp8Yd0eQlMqFdd+Rwfsb
 oQ3mpmlHrQxCuE/ikaD8TuMqiIdydgmVcbu/xhVJwfsNnHcj6W1+Jqv8dRnk3mf8kivr
 1B1wo61v5S7zop+9QTjLWtECKOcmIR9PIndSaRFNNVoJxjzzrAB4rjgGdhT9xbDKvzYw
 T9rTqXXzyEecUmTlfo8XxqVaOz1/GFyxi0NNMIm+PXeau9l1teWzVTBqblpJ8nxUN/uY
 0oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582992; x=1779187792;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/rAUHy5Q47gybSESJJWoqR13PpzsY8CoUQJphBxxo8=;
 b=HvmGHGpoYfVHLr3PR66TrhQCOK2wm4ckpj672uE0PIaf70CoOvZC2QFW/ZLtAfq2Fz
 KEd5fuXY+mLhVaMsuHhHd+2asQ+DwJ1r3Ew4YRylkwD0vsUHQWl4kg/iFY5O46O7CA+b
 tvyY/LL65FLbn38vtoeagy5ztVKobBh2x0wpVuPH/1BsAAAznzK6SUOuUW0oXTBNCXWO
 2PvVPm2WfjN1WvmYlR7SU/xIaGz9j/EDpSDYSM3x1BzFGMjzRC/gUnrgkX9lh+NbiPRA
 wQFElp7cHPhOC3uck/iQQS8lnVAetFIC9f0yT9jFmePa/0WbD/mmaqHleG/g5mF85yYD
 40+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qa8UTEXP5q/q8c3uBeB0kS3EDPUgKl7eWycnlW6hjZp1dQ1l1PgA/WJ4TPk0bd1YOj0Ym3A9omqCf@nongnu.org
X-Gm-Message-State: AOJu0YxktD6vZWnv6n8DjQgIsDNKbKSeT6cBXH+vG/4GfvO2b38l7vHl
 WwxO/VUoH7mRLUsHF1tN6ekm1oNXr2TRN5QbeDuIqcMJkckbfuZiYaERuqz/y2Y2eTg=
X-Gm-Gg: Acq92OEm4zZ8MhGcvR9MtrO99+bw8x7lfxNsOjdzwS6wPhbtE87XdSgNIX962QqHaMi
 Lxltf9NdL/v7nYx5NG6ngkd6l/cPNvw1RoUXkAboJ+fTOT1Beyh4k8OE2+rB40Q7i8pYvA3uoc3
 JzbbHA58FOb9hFb5vNsGljS3tuYJDSIexzGOWwcaCMuAoKj5EtC7pz8siaWFuX4P6QKccEtBCXt
 mx71EPueHxOtnCqAnoht+AQV7GS/yui0wtFkb+vN1C4p/fKR6y7xL0BQLe26ZWUfHSjFQY56+AO
 m4Mk4btkgd945b8vY4gJvuwFx0Xa+ACkrBfOZ1aRZkbsyD6daZA0OIdo6SYoLkoqJ8OpTVyiULH
 638I6Dn8xSEap8P+XGsTwA31N88pV6F8/Iqht2PuKqWDFwaprKpu233l7l5xW0yMCUvFiUMlFDS
 vqgHEWyOGRdS/Wzv5oXE5oBB/hYKUujHY6s4oYJgFttGTNKUptE/TZwww3EzUpUVeLgQ==
X-Received: by 2002:a05:600c:37c6:b0:48e:7f22:d90 with SMTP id
 5b1f17b1804b1-48e7f7de432mr155431275e9.4.1778582992160; 
 Tue, 12 May 2026 03:49:52 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e62a2desm17111615e9.9.2026.05.12.03.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:49:51 -0700 (PDT)
Message-ID: <719b50e1-40e4-4e56-9837-9f205912bd18@linaro.org>
Date: Tue, 12 May 2026 12:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/intc/arm_gicv5: Avoid NULL dereference in trace
 line
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
 <20260512093856.3197700-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512093856.3197700-4-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/5/26 11:38, Peter Maydell wrote:
> In the handling of writes to the IRS_SPI_RESAMPLER register,
> we call a trace function, passing it information about the SPI
> being resampled. However, spi could be NULL if the guest tried
> to resample a nonexistent SPI or one configured for a different
> domain. Move the trace statement inside the "if (spi)" block,
> as it's only interesting trace if we actually did a resample
> and potentially changed the state of the SPI.
> 
> CID: 1959593
> Fixes: 33185e1d64e ("hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

