Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF516C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVvf-00088W-Us; Tue, 04 Jun 2024 11:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVvd-00087M-VS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:18:25 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVvc-0004g3-34
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:18:25 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6341cf2c99so636356366b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717514302; x=1718119102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iwwEq//xitEw6lvnECVdWqgsuT4ApH0kwxUUkvpqRJo=;
 b=SnMsFG2qWGwyY4qwfpsqRfVHf/Wyz59VQR3HkbT+1vkVh7kQmUuGif8UAWVwSRNcAI
 4cVpfdkuXGncocvF7kHIKTW3cUdMo2NRWHtNf6mTgYmj6S3rkL2+hjZQFt1WPmmQp8n5
 b390y6oJQLJVWHYHC0/DyL8OFlVBPoQmO9bDNErAGqSRsrqg2rQcW6mIK3NJzQOcLnyk
 MwWqZ/fGcljkOFJOf0HixSJYBiGrzKqu1moPAeg3qQU8m7sJ65SKBPqUNri6ffjFiQio
 gXXBwxtwYminUDASJnij20wHqYeNz9S+BI1sw2SweXlkn/uMVhX7aZ/u4lg3nWa+oVEU
 cBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514302; x=1718119102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iwwEq//xitEw6lvnECVdWqgsuT4ApH0kwxUUkvpqRJo=;
 b=Rj8ihOhYkWqSFyPIyHAnPLKUjAcZo69Q9IXKDOLtepbyVVmGomdenx2zWdzzxVQ/lN
 b9dK0yvIkSTy6fmXbnwOV/wvnEdCKbud74DQ0cFJAQe5bYYyAxg83Atu0Z7Klizif8wy
 +Geg9d4qrN2pr0h6NlyTkFP0+pQqPQZW+VzSVP/BYT0bLTfvZOKBW2gZKuLuNZPEfoWn
 DJ6m1E3P2JrV9PiAwQKEfRLsR7XkM7agV1vFKLQWB7yoXmwR/RTeKh5WFZW/wnp3RS5I
 T17RYPG5EnMgZhSRBKm+cCzS1wy7589bxvv5frE0zW9biL/U1TQQ225jByfPeRtMsmhd
 mH4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6fCnBQoMNI3BHgagX7NEnf/mTlkmLhNzctWAicmbwtMaXE7h/ChWiLYRa5PZAVuO9TuhxEKbGfThs6Ix0yVodoXj/0qQ=
X-Gm-Message-State: AOJu0YwP7q0GMBaiidbxTPhtXtkSaygGGMADc0b9fpux51z5f1qYDioq
 07tCe6fXIE2qSx1bXU5kcB9bzEG6Wyzxa7OIbzFIcpx6VNxyBbnLs/nAZRvj0C0=
X-Google-Smtp-Source: AGHT+IFFYqZJaZRLpu4TVY299W/3XzSLo2XPfDV4NFprBQleNibuWasC5vq0u+SknSDbp/3b2OQFwA==
X-Received: by 2002:a17:907:84c8:b0:a68:6559:cf7 with SMTP id
 a640c23a62f3a-a68655911c2mr698711066b.27.1717514302470; 
 Tue, 04 Jun 2024 08:18:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab85e8dsm629781066b.164.2024.06.04.08.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:18:22 -0700 (PDT)
Message-ID: <a099b5bf-bc57-4401-abdb-b5e6191d3d40@linaro.org>
Date: Tue, 4 Jun 2024 17:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] scripts/coverity-scan/COMPONENTS.md: Include
 libqmp in testlibs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
 <20240604145934.1230583-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604145934.1230583-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 4/6/24 16:59, Peter Maydell wrote:
> Add libqmp to the testlibs component.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coverity-scan/COMPONENTS.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



