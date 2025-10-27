Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177B7CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKcO-0005XJ-KN; Mon, 27 Oct 2025 06:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDKcG-0005Us-4F
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:38:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDKcB-0000js-7b
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:38:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so22126865e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761561490; x=1762166290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWmlF7+vyrZERgeszuiIIOKjLCZenDx0ckDEkY9Y/kw=;
 b=Gy6krtuuOrnNkT3JDjDl/PknjENGMy9tGmqPs5AuOzV8ZzRQ9qfRgcI7jqhQs2Bs2Y
 sLQGJiI9yslDFiGM1sAradP3cGeOOpIn6BsVCowhiyc9aCChjeRORx2p2/FmBWwPcvfL
 OVyIviMoDj+k2xtf7cBo3PgJZ8NkVb/jlviclke5PUtWy3p6VENyl9mp5Z/UrCmn+AC6
 jMznrMhtypiGeb7Mmmkc4z1+f2WucYj3TSQco5940jRtwTyJ5cMpM3yP/WLgplxGVTSv
 iLCs361gwd+X+FPnNXWyM0IzNaJVYfqDjixo9I67scVgqPgB7l38crwEXK9HErqTKhgA
 2P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761561490; x=1762166290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWmlF7+vyrZERgeszuiIIOKjLCZenDx0ckDEkY9Y/kw=;
 b=EXllCaD5iYOQrxvM2pvY9+dJ9Q430CwjFShVJEPlVb8Yzggjg5lsx2T+TQ1RRspUQv
 tedtOZINgHkd+vvk6BhMSoXDnE6KAqrlT6rBbGf8PMOakpuJHl21uLOHZ1w45bC0WIbc
 PMpteBYGXbyZyo0jXi9VJwUuEG8URTLniIGrId08OPJDbNs+hbIi5QR/HTQa2mtrGdwC
 uXX6FVVbT+Lu3RDwf8+zTbpFghz+axYArtYWpTISMXpHrlV+ZD0uWEVUOkmTOS9V0VvP
 d+qKRW5px9PJxN4CscS6FZ3NjDaNyiKijm5QYn22vz+6DyIeQl4N8v6JmGmDYzP9bxUk
 UEXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO0qrCHxjzwTGKvWycq68UIIw8KJJeIUKaP26fCAwtfJqiZkfxrnoCt1j3W6dKpTm3fUVoXIy/kCdT@nongnu.org
X-Gm-Message-State: AOJu0YwhJ7ypNJlQOrlsHHIyAww78fvGet+2fQgi/VYzutjrvDC/4rrr
 +AdCxO+j+A76Ihahfo93NwTtvNgTsWreC4GuSAFsVBvEeiskBlMtKtVnCMufa8Y0+v5WFtQfH8h
 l1k7hPDU=
X-Gm-Gg: ASbGncsHEC9c3eFRgsrwa4WBz8ctfA+qDaNz6AM/kkUr/2jWh3ECPajbiEPW82ZAsqh
 QMh28jhjzSinwOXsAZ0DFoPqWp0E+x+6aFTXqgEocTKTZ52wqwmno8PiaXQEUqK4JJIGZJE6Xw1
 SlyxkJ99lu0Sw2tzQjSBdkAl8Uke9s2DBDFKG/rdTmc2Zhd4b1s6dAnOhWNoRYXWSiV7A7NlvNP
 mfQmpv6/FGlqOOBsJAOA/LY1bjTgsgq+bvQhyJGagu/9efmw1YnXeU7GHXqJgpnmnYUsB1flrhq
 EaATVCU48iNbzT51Q3W4VGuGh5wJ4Z9jP4VWkXAyjhvtXkIhXnD77UoBNctUHyMtW6jrY6DqRRV
 31LAIARX1Chg96JYBtzrMXZRAUqOcHgRZp/kFVs+mrQmAESPInmCuvaotjEFWfN7xCKzD4KLAAd
 WnIGYaj/Bz3K/VOSnjBzSEOMTNERTgHMXIkqVcn7AMVCiMVVaR
X-Google-Smtp-Source: AGHT+IEHuzf3RTrfkbmkP6KwZTSn5MqM5Hl3yyEoisOPc+Lo1T6zA6UZNZHPhYM/goVSxgz1FWoHKA==
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-47117903f24mr244627195e9.20.1761561490419; 
 Mon, 27 Oct 2025 03:38:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035dc2sm131756505e9.5.2025.10.27.03.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 03:38:09 -0700 (PDT)
Message-ID: <d4c918c9-820b-4a9a-bb9a-72bdc0df617a@linaro.org>
Date: Mon, 27 Oct 2025 11:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Remove an unused state field
Content-Language: en-US
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>
References: <20251027075232.95262-1-clement.mathieu--drif@eviden.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027075232.95262-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/10/25 08:52, CLEMENT MATHIEU--DRIF wrote:
> dma_translation has been moved to x86-iommu and is no longer referenced.
> 
> Fixes: b6b49c2cd6c2 (intel-iommu: Move dma_translation to x86-iommu)
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   include/hw/i386/intel_iommu.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


