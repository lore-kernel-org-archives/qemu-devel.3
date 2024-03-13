Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B92C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMMZ-0004Yj-Qf; Wed, 13 Mar 2024 07:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMMX-0004YW-ER
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:01:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMMV-0008GU-6D
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:01:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-413ea3219feso2769945e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327689; x=1710932489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0BzrODSUFI9ySJT1jpQDTzFW32RTal+uWFqNm0AOJmc=;
 b=Jel92HHb2X2VQW6POEuI8UBJaGX16xSzEFdwSU4rIVM7A6RP/bDfa323f8S/jrnfyK
 c3CfHIzHgocZ66yglbt/3ecYWJOAwj5YEQe70bgXlnht3GspkdxXoVqAL29Hr9hCftB8
 d2i+xBDzJPUNuQrovSAanB6y1gahHzFyiKBnb1mtbgEmdRqBFCNCThLbL0+v3ABxttzW
 K5adKNyFsq8/05gDr7+FWJYzGE5GWq+jymdn0tpjQZNWLYGaN3TP1IHU5+sozkqTPMi2
 aKClu90QfgzC7Z05L4twolH90RBGF77eYW0ZkZw+D69OueVNjRIYnmX0uNVy8WZiTFYo
 NoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327689; x=1710932489;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0BzrODSUFI9ySJT1jpQDTzFW32RTal+uWFqNm0AOJmc=;
 b=Capj3R9IbwQI4eFP2kBmSikuaZtQSG65KD/qxyqsIjEjZZNRzpLju99tVuUtHmyYnj
 8+YliljLd1V66EgWiDbhZ76XBfGVTY5k8q4zhrF8WFgP3qvbnrVtPHrixR13rUNIRpj/
 OGD3schsyvzQgZyV20xFfTgFxyHmW9eDaJ8fGQIoPCo9gqVD9Zy5S44jYafk3jmhDRBm
 K6mAc1hrMqRX3lPyirFwWTBrhGhqmhRn1wBzVv4MX1cEJOmAjqU1v8IEagsJ4nDGnEoE
 CBB/BE+FBA3ZMVM0EAsgB9S03W2UX+N+r9ZwcqTt34roNVRZLwULcIEOUfpTZ44gElpW
 KwmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW81AybF1//muhuqx3HoZGz0Ot7ZKfWE8q7/UfnEhCZt4K8zZoXien2CYVZ9aXjoxe4tjC8OZjYUcJxh0z54kyH9Bp4wMA=
X-Gm-Message-State: AOJu0YyvCJ4nSmhGplZ1h0kSSEyy63anHZDvl/GTOcRim1HAuztsiPuB
 GfdjAy8r7p5O3FKSg/+1myn7criUfQqNLoZcuPAshjE/Xl7rS0i/e337726hrVU=
X-Google-Smtp-Source: AGHT+IE0t1myRhsYNOTkUxeQ9Qw7eVdZDljfacxtz0cps7PLCpH3ZYxCI2pifrpTQlQDenjp8TulJg==
X-Received: by 2002:a05:600c:6a82:b0:412:e50f:acaf with SMTP id
 jl2-20020a05600c6a8200b00412e50facafmr9218587wmb.24.1710327686153; 
 Wed, 13 Mar 2024 04:01:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 fm26-20020a05600c0c1a00b00413ebdca679sm841873wmb.37.2024.03.13.04.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:01:25 -0700 (PDT)
Message-ID: <9077209c-25d8-47af-befd-e65ac30694b5@linaro.org>
Date: Wed, 13 Mar 2024 12:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] esp.c: introduce esp_update_drq() and update
 esp_fifo_{push, pop}_buf() to use it
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-14-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/3/24 09:58, Mark Cave-Ayland wrote:
> This new function sets the DRQ line correctly according to the current transfer
> mode, direction and FIFO contents. Update esp_fifo_push_buf() and esp_fifo_pop_buf()
> to use it so that DRQ is always set correctly when reading/writing multiple bytes
> to/from the FIFO.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


