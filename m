Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A943109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Z19-0002zc-LY; Tue, 31 Mar 2026 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Z14-0002x6-Qp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:20:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Z13-0004sB-0P
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:20:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4888244e9f9so70255e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774963219; x=1775568019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohAWYYOPoezuaXSWOFgisCaDLAMCR62aVpyAHH86ztw=;
 b=ocI3ZHxnMpul7t+HSk9YISOjSMA2sE38nhOpMqbMQQQz4EcxZNeQBl4foP/kZ8sRb/
 0PLP7Pf5eg1sidT02puIItyXKMrL8g/p2o4RQLA1Ks153624qLm2JIVVZSvUY7e8/3r5
 pEAp/fcGszeHFoaibWoTUx1PBdQQpW2pa34tfGQTA0EkIemDQWJBRu0o0uOZAoEWv9b8
 rimeD94xBhas9FAmY45zZtV7l7Ujf+uW4Jx7VJYDaw6ZW3Za24dNL4Vrxb3U6AlXUEic
 R+3SGnFaJfgzzyRqs9mfjQaVxwOzgaq8XxieSRbR4iqAtE/xtOmdVklUneiuqO0D0XHc
 zbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963219; x=1775568019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ohAWYYOPoezuaXSWOFgisCaDLAMCR62aVpyAHH86ztw=;
 b=ItZxIWU7R1Z/Jp7hBAM4fuFItPHOxRqjoJgPIR0PcVJ4tMwA5spclMs4RSTO6+YSzZ
 QT58keJpoowFOEE5MaXSb6/43JEFdZCF2sYRPnYOF7gcfLFLDY7Es2uX6gF+tDixsc37
 ctfVvgGS3Hvxfx3+rnGmt4oARytBdXNIltqI0cad6y9agzOtyY9JFci/MPnbXur565Vc
 XZF/KN6JsChz33XniSWiD3aoaqMuf0MWS9qt9yLicD3vxfRctIQ3LQqtmpa0JgksKAOp
 oU1KlJdM6UAh89IQMdtqT6zFyUOq4+oVbkip/V3QAq8hFuQ7NWofn9DlcKzGQFwpR1Ps
 ZtLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9XoIjeWh+g+0d0buMleXY/LYphVGuu00Jx+4GwVClhqpiwNWrej4VP8gn1rlX7d0OdDVrrpX4BjP@nongnu.org
X-Gm-Message-State: AOJu0YxN+W/HYy0ouOgUyGZDYY1CGf0G387fAKN4DjMbLoMpNxijei+Z
 hw35nJPEvsQyLxyVe7RXsUR5T5A4ei61GWUy2rDupNF81jbudO0N78qWVxyLb6KTRjs=
X-Gm-Gg: ATEYQzx2mdAa9KvH6/a7NI3DCCR341/Q2wVLDXhDFCXv8N9tQzeGxe3UUYNDjhUomKH
 Zc7q410A/GpcvcPCgyp2AIINMUnSxMOCSDey74TyLB5rwfNj1OfYKaxsPbra/LfSFUAkJlECUJq
 7GNfDhn3Px0xfySHKj5recFEbQ4J6CoACj5JraZ1F3+b0GjlkBbK0z4M7qQ1j7QN0OU72YN712n
 FhHk0Fi7teWVdVYzuGMDsRsZ21m6o0UKQ05WQZKe2BqHzNlXDioavRu3vW98HG99+/IebDzmoDk
 t/XoNwJ6ysdkcNn9SSq3AI3914B8lRMNsOyl2Fhemdsl4wI73DcPfodtKIdH7PoYRyiaFkEpx9i
 rX+IIVOGgzsI37391NFCII7kFrJ5P+kjQBMk93NHfW4+zbub5+OiS1OHHMkX7ibqgvnyh7uYbJw
 YMxs+3DvhPOQ3A26QlHyQHOWzkdDsiJznixw8Ij9+iZVej17i+ijU0csdxWS+tozPeZl4f
X-Received: by 2002:a05:600c:43d4:b0:488:7ebd:78 with SMTP id
 5b1f17b1804b1-4887ebd0102mr19769605e9.14.1774963219450; 
 Tue, 31 Mar 2026 06:20:19 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm47732705e9.15.2026.03.31.06.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:20:18 -0700 (PDT)
Message-ID: <886b2e1a-9781-493d-8d85-d2f492d52701@linaro.org>
Date: Tue, 31 Mar 2026 15:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/pnv: generate dtb after machine initialization is
 complete
Content-Language: en-US
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260327124136.983955-1-shivangu@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327124136.983955-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/3/26 13:41, Shivang Upadhyay wrote:
> Currently, the machine dtb is generated in pnv_init(), before all devices
> are fully initialized. This can result in an incomplete dtb for the system,
> as seen in bug [1].
> 
> Fix this by deferring dtb generation until machine initialization is complete,
> using the machine_init_done_notifier hook.
> 
> [1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> ---
> Changes:
> 
> v2:
> * moved pnv->bmc initialization to pnv_machine_init_done.
> 
> v1:
> * https://lore.kernel.org/all/20260324135026.247418-1-shivangu@linux.ibm.com/
> ---
>   hw/ppc/pnv.c         | 58 +++++++++++++++++++++++++-------------------
>   include/hw/ppc/pnv.h |  2 ++
>   2 files changed, 35 insertions(+), 25 deletions(-)

Queued via hw-misc tree, thanks.

