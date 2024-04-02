Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9561FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcXE-0007RO-3H; Tue, 02 Apr 2024 07:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcWy-0007C7-6V
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:42:23 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcWm-0004MZ-ST
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:42:18 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516b80252c6so356091e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712058113; x=1712662913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BISYgdJZgbaoxWfND2YHwNbdMlY2oH1lv5EQ9dq4bcI=;
 b=A3d9ytkLUYk0sIkvis7t3aqbsn3VKwU1u20voesHy4+2Z1ZbKUZfg74+vNlPMEdJuA
 s2ZJ2ARt8eLbGpJr2q0y7DQyPe913ZtLrjRrLAIFZXbgbZCRX7bGKY7CzKu4wk8XsNkw
 e2Zj/RvS2CeCtoeuVkU5/m6pw7BbphkBX1hlsCxX7DCVelsuZW2NjaLvqRim+zXEaefi
 S2Ft17mr80pYGUurFHIarg4Bq72YG11VwGn1J8dK2aNfmn9tyRJQ7RxSNrl4LTxKzsFo
 x5wy3W62m6yHzx9LkxOeCrmjTmwtm8XpODpwUEM7wLuHvFwn1ujP2xc3FU+0WmEHgta/
 rT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058113; x=1712662913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BISYgdJZgbaoxWfND2YHwNbdMlY2oH1lv5EQ9dq4bcI=;
 b=t/2kXpJAc6KPv8OB6rX+7JBp/uwnuBp0GKNgvBrs1MmtkNH8MQV3DhEumfaSKTPk7Q
 6AVR3rH5csQVRHSI5YYETK9flTQkfOwAXFVyNWWSQ+O6Bq6ntJsEGKXIZQ4BmZWuAgm+
 N5OZuJoFauf6VecaHRR5BomVSbC3mqrY5F/0jAJW8RANOIgJhHEC9Ct1UEsZpQdyLAvF
 wBGPudt4wSVUQNShiT3D+rIdmKgkdt9OC09A8+XtJudfQ+q1myc11gB13/1oiYCM8+0e
 HfvGx368WBCF1RLV8eD2TcRms6hOutDZF5PZ24kLUknBJY/rJCL7AWMXjPTw8T78dLLP
 jZ9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb1F3CmNR/ZMOD2pCki1rVeBdjt3xMZmRNuGhEG8Y+ws+A8BmDZb/DlvOATYoilHzADuY4b3CDirQrFhD3+xERnsyglis=
X-Gm-Message-State: AOJu0YxNwmFV0Hjua5nM9jOW6jG1UCaTIjEZ6/Gc3D64NRUs0YxLJYhW
 TaFemTjpxdfXJZUnmvs3ofsjzATVvbBRUu2W9IITXKiWDjB7ncD0hNouOmXy09pLRDzMwWYwg8U
 Yo+4=
X-Google-Smtp-Source: AGHT+IG2yCPwP7FZYbv/3Jh46WyriLmWjPniXaY7yWc0+hwV/BfYf0WTi+8nbaoRZEkKgtNwRQM4Jg==
X-Received: by 2002:a19:431e:0:b0:513:bad6:cf03 with SMTP id
 q30-20020a19431e000000b00513bad6cf03mr7382440lfa.16.1712058112811; 
 Tue, 02 Apr 2024 04:41:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a0565123c9700b00515cc918069sm1526805lfv.150.2024.04.02.04.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:41:52 -0700 (PDT)
Message-ID: <236b2bba-2f0f-46ef-b0a3-50ae3b671f1b@linaro.org>
Date: Tue, 2 Apr 2024 13:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 2/4] vga: move computation of dirty memory region
 later
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
References: <20240402113408.18048-1-pbonzini@redhat.com>
 <20240402113408.18048-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240402113408.18048-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 2/4/24 13:34, Paolo Bonzini wrote:
> Move the computation of region_start and region_end after the value of
> "bits" is known.  This makes it possible to distinguish modes that
> support horizontal pel panning from modes that do not.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/display/vga.c | 50 ++++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


