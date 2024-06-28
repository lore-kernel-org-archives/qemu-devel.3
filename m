Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1FBC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN69I-0004YQ-Qo; Fri, 28 Jun 2024 03:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN697-0004Xk-Q1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:35:49 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN695-0008Qq-1G
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:35:49 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52d259dbe3cso298274e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719560144; x=1720164944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3URTzRJ/ow0K/7w7IQBNSLOI9ylapWNfe/vXXjJ5tbw=;
 b=FH4ZFk95fqcJwx6qjMPe9YnDIwilQxby2pCG5a4XdfSWOshQF2ZXhdOIeucV9TrPMF
 OUGTWyd4xL3vfVwVKpJhYhIEaSzP4C3U88I9PlgLG6ul0Zj3v9nspNXlMV6kyaJJSkI5
 cJW5+s6wW1roKXnr2mD3WgTGe3NLWqOKn8m1/U1DcXFW0kekOgqotq236e2+okMCSW+r
 4NViccyb5pv+E4UtPh4kZJ0pfoR7qxUYU0P2f5wK8SsWKzhz97hc/WZt7yfnDwc0IIju
 bTjTxDKaZrTV5OzJ8UH6HQ51xyE9eTPsUM3TyzrXiDL/jebZm9sWFH0xYjuYgWCUQiuj
 ClcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719560144; x=1720164944;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3URTzRJ/ow0K/7w7IQBNSLOI9ylapWNfe/vXXjJ5tbw=;
 b=BVJO/MYrHz/5x5SXkdPLt9oN7ViyhLxNC74kiNmdPjhnBsc1HFxrsAY2F/xvchryuL
 IkV4FBWCOpcfycmmGbe/gTAetqcZ/E0uCm4b/J+q4PYr7+OYPGEmZRZFyOlJDQRjPbiE
 Ji/WtGhLWrQ7GaKw1OA+IN7AagKktPa5pCJqUPHPwO3pnvpMvmyaZaF5iZ0hHfgsfd4a
 k7ibwreZQOZpTSElBbLJ0n5d1xXpEZlJXWwa60KRVrRB2DF5DeaKfzy9bPjowtuUoiLF
 6VguO3Xy+PpWUSu5rGHtMFIPgZxWxLhpbGYksIbDQk+okpXxtwd3o/nrzHmZUthDFIy3
 7PWA==
X-Gm-Message-State: AOJu0Yxp18jW3g1B8v+FheFVGbTIBETrp9eWTUtJ4YlnnGG++mBB1yKE
 5n7f8BBYamTliLBJGSrB8q6AIAFlHRVVOFRMHtAd4BWJ8Yn8yiJd5BSiZusBQ9nilDcL1d1txE5
 aLv0=
X-Google-Smtp-Source: AGHT+IGkV8XDVFQn2g4Zn1GorzLOu7F1OSAWkhvXT4SvShIk+5V60cuVymxZfwJifoOJVCssQXvU2A==
X-Received: by 2002:ac2:495c:0:b0:52c:90ba:9705 with SMTP id
 2adb3069b0e04-52ce0641504mr12044883e87.49.1719560143798; 
 Fri, 28 Jun 2024 00:35:43 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b098b4dsm22139755e9.29.2024.06.28.00.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 00:35:43 -0700 (PDT)
Message-ID: <c2ee1c9f-4443-43c4-ae4b-539230db141c@linaro.org>
Date: Fri, 28 Jun 2024 09:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 95/98] hw/sd/sdcard: Add mmc SWITCH function support
 (CMD6)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-96-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20240628070216.92609-96-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 28/6/24 09:02, Philippe Mathieu-Daudé wrote:
> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> 
> switch operation in mmc cards, updated the ext_csd register to
> request changes in card operations. Here we implement similar
> sequence but requests are mostly dummy and make no change.
> 
> Implement SWITCH_ERROR if the write operation offset goes beyond
> length of ext_csd.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


