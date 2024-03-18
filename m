Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C01C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBDN-00080S-PI; Mon, 18 Mar 2024 07:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDJ-0007xx-W8
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:34 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDI-0006xl-GR
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:33 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513d599dbabso4538082e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710761490; x=1711366290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fDmCLBD//ZweQwGs2iMb1fxkUila8cEUmpEOfPUyJd8=;
 b=N0qpNtuSfB4WhMHTvC/HeRQqmsXJGNzOxm4RyZWprVeTNAXMRlAZh0t3Rx5nZpts88
 /o1y0zWv5B4Y8TlhQxDgmVRXkas1sUoFnjNJFo+6l0we4Jpz6XGfc4ib6TwgsltvCWxl
 HVQLsTbDLWuhzMTuIZt3+3VDFgwiHQzOc834As5UjgSI8id+0OEXU/pDhOrJBF0+LinT
 SPD+DpDVnuUehb1DF79a86VU6nl/MCJ95MyX/nPt6Ix67ds1d2D+SX1mX0aJ/7h6Mq0z
 HqcobrH1evKPc9HJjkMPzm1HX8hg3nIapJiIfhjBdSDWwa8dBY+5nuvNQlnuUvlDpN1o
 qpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710761490; x=1711366290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fDmCLBD//ZweQwGs2iMb1fxkUila8cEUmpEOfPUyJd8=;
 b=SX4IkHv2Z+9HkOOfTZ92FiaelTxe2H9ElABQjVkI66twqqm+hEMOl5qnqhtMiQX73R
 MGhXyyx/R9Rt/aQzoDME50sED+77epQkFmiXRuDrtRnMDBToW+Oj3cVz3BMBRy1wdDx8
 AvmICgTYu1py/EkZbX7opCGUIxY8SKsln67Mylm0pqYGDODHWtyOevUNKBmMxKqMF8lE
 tEDTR6D4dJN+u4x02ajkBiO6NQ2ymFXtsoC0j4Uc9Jeq2PkZQ+9UFnnRJCl7RKty1+2J
 J7QK0mDJAt4LEg1jvmXGWr47OvlvDE9Z7Hy+nLsX0XLIGiJ/iWxDrGCOhzxpCSIC8mNv
 EPpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRWc+TWokHqtx8sO4rAZYi/hkmGc7QHqcd00MQZT9hsWDm861cJEldS9wSfWubPoVkdd/V/+M7/f5FNJe82/NCOHh9l2A=
X-Gm-Message-State: AOJu0YwU+lQc6EqDpLJQKaBrjq5m54rVR614Mxu2XpS7V36jfDo1z7gR
 tX666ivs5Pk38dSK/q77x4D7SUZHy1Vvvd9Dy5YtxoZchbLwRJSV6Mr1xBLgWGM=
X-Google-Smtp-Source: AGHT+IGHZXOh0v/VNKSEJVVd9oxS9VsQBGoPfRd1ayUWAzkXjpuxXWWa0EnUzEJfoLNbqGycj4+t3A==
X-Received: by 2002:ac2:596c:0:b0:513:a944:704e with SMTP id
 h12-20020ac2596c000000b00513a944704emr7513142lfp.63.1710761490153; 
 Mon, 18 Mar 2024 04:31:30 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 h11-20020a5d504b000000b0033e7a102cfesm9575335wrt.64.2024.03.18.04.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 04:31:29 -0700 (PDT)
Message-ID: <4f718ba5-4ca3-4412-802e-54e1c57668d2@linaro.org>
Date: Mon, 18 Mar 2024 12:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 3/3] ui/console: Add 'rotate_arcdegree' field to
 allow per-console rotation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240318100543.78846-1-philmd@linaro.org>
 <20240318100543.78846-4-philmd@linaro.org>
 <ab5892b3-38ec-43c5-9c82-8595ad4c77e0@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ab5892b3-38ec-43c5-9c82-8595ad4c77e0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 18/3/24 11:36, Akihiko Odaki wrote:
> On 2024/03/18 19:05, Philippe Mathieu-Daudé wrote:
>> Add the 'rotate_arcdegree' field to QemuConsole and remove
>> the use of the 'graphic_rotate' global.
> 
> I think QemuGraphicConsole is a better place to put the field.

Good point.

> 
> Regards,
> Akihiko Odaki


