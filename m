Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EB2C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMDl-0001ZB-PY; Wed, 13 Mar 2024 06:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMDj-0001UF-Gd
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:52:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMDh-0006eZ-N6
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:52:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e966f56c7so2731142f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327144; x=1710931944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBENDcTsobIZMtoBRnjFz4BOBxPuJX6ODRuRyobchIo=;
 b=C4WhBJCc2EEVN13XIJDikH9vIL4PpuHRdbeu5l3k6WbqjRyEvcxWxROtI4nZXvsHuO
 QicevSypYs+62pGwSSpj9wLKS+voj4kpSPmq1AOFaRZaQITZGok9JxtmtEzFdqMPP6qL
 m4I9HkRa0Dux6WGzuaksyK4fLRbtGeQ4cbannu8tcOlzGzpFFq8wrIgncI6cz3Autr0b
 ymcuN13RatCKvmTR/P7WbjQyWW/L2fH7+NrzBffN/Vs969BqKMKyrJfH5nL0p3oHWNy5
 6KMInlGzqk7izDvjZv/OJzdhjV2Q5iRXhwCDxKhUrcrQmZL6j779S7xvzTzvdwJh9D/E
 rq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327144; x=1710931944;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBENDcTsobIZMtoBRnjFz4BOBxPuJX6ODRuRyobchIo=;
 b=S6Y7o39pMQGxP5oTGO3GNeuGJIhmWgBzhCg1+SzDgIXE7hDgmBb4fopBgNg/mxX0Vi
 ojLS0K9n1loR+D0ew5OS5v00WPkjJsgd+0rB/o8cSWjdLmNil2GnR3pr8JakT7SUEkRW
 Z6Isz/R1bmphpV5aemCNsAQdtk2SrHYLY060Z/NlCgJTZBcCU/94QvTBrIjjBaWdKe1u
 03mUPtXbaQN+mNGJm/ymkoLeaKoNkKcqSnULFpQ+gDzmSMV3dYfFAV8CCvTTT7h1+ZXB
 xyLnBshVpYoIn3+9mGpT4Am5S4+H0Looxe5o1f1Cr0E5N5JrCRjz/dtfuD3Vxa1F9nGE
 vz5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl1pJKfwSS2IB4CuXge78EFdEfTQSdLPwBNNspkEX0sD929UmLh/d1YCD1Vo7gMOwNIhbo8vjL/JXdo4uv6nGnyrNaFTA=
X-Gm-Message-State: AOJu0YxKG057qiMPlFhxUXE2KQ2HYRNlntqicz7P6Y4uhBjbvStfKNrf
 Ck1QsOJEV7NuFTwhOs6BMqFBiB8s4oQHdjoTXediN1s8d9lZAY3V64AOsVpvshY=
X-Google-Smtp-Source: AGHT+IHmeC31SiId9INYw6uq12Yx4r9foIrbU0ubwlrMJ50iYEhxTtRmo0snIF0gNbioJwpyO1m9aw==
X-Received: by 2002:adf:e98e:0:b0:33e:7062:4c9 with SMTP id
 h14-20020adfe98e000000b0033e706204c9mr1536311wrm.3.1710327144014; 
 Wed, 13 Mar 2024 03:52:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b0033e5c54d0d9sm11371978wrq.38.2024.03.13.03.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:52:23 -0700 (PDT)
Message-ID: <67ece319-fdd9-4ccc-b3f2-29c823a08643@linaro.org>
Date: Wed, 13 Mar 2024 11:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] esp.c: change esp_fifo_pop() to take ESPState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 13/3/24 09:57, Mark Cave-Ayland wrote:
> Now that all users of esp_fifo_pop() operate on the main FIFO there is no need
> to pass the FIFO explicitly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


