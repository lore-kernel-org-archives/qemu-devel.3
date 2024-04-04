Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73557CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 10:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsKKw-0003Uv-1l; Thu, 04 Apr 2024 06:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsKKr-0003Ug-Ap
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 06:28:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsKKp-0000VR-Qe
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 06:28:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4155819f710so5979395e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712226521; x=1712831321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1bZRJPaQ8TBPOxj+WNFY7mnhG9Pvt0BGQ/yId5UCjo=;
 b=McYrH4+qdy8xM/FgWLa3so9wnlSxKrxTelYmEJDubivTXEpOaUz5FenJej4hVZEfL5
 H2VBQ0xbwfKhnIKbMgZtbZh7jq42RlaCkFA9Uh6CFTczP+XodOq+u/pE1lUoHLo70Fzl
 LAJu7AFuC9CwCmwSE5h6DsmakRchUpddDpfixJIC7h+9R9ljt99G+17fzuHqSc0x6cdX
 5kxG9jfUuQNwviBpjFz5ReoL9RvndQVdRzPsAy3oagT60c4AmIS1eW2EJs5UDDxf9Kx4
 igBmZwQV1Iq821iQFqMLwBFCKUKxfvRv+gGewlW59SYh2UqZkHqWEJ8TcEli6+OUmYfx
 0eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712226521; x=1712831321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a1bZRJPaQ8TBPOxj+WNFY7mnhG9Pvt0BGQ/yId5UCjo=;
 b=BguqEBNnAfpNnC1jrIdFfPMFc/TuudytWpfoPun+oFtOxb/Wq4VQ9OdBSqZlQkjoWT
 HOcAT3b02qqPucIS8PgH4SdYLLrJgh9ni0Ta1FHY5CJKx3tEpR2cckiIDIbdTv3xbuf6
 krbZlPBUaGfyp2LOGcxF1xquG7PUveR8C2M9yDjVvLF4nRq2XMgrouUCL07dHOCFQSIn
 WNeQdIXKaHMiYxfSU8pHPssLhapjEiAlbV2VzgHzdrG+nShfQR49RVPHxmbdE64vQu3T
 nM6i0h0KRlwd4qxexK54hdrUO/+E5t1RsiIpYyQ2yZiaAApMUbxknfw8rxV+87PS+je2
 YMaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3PJavTtg/oCknwmW2r+lezrlLIRzsskPKGQXUPSAVUgbvbWC7zVi7khxnqWsfECT40UPh8GZlU6wegECzgiMtzMenfa4=
X-Gm-Message-State: AOJu0Yx4toOisRimeppF6+OYVhJ/42bIMdxwXBVIWorHuTWwHWeCibt4
 989hfJFBqJ+1y2ZunIlloLTPX3WTKMw+XjLL/fk1JE1vNC5JNbKmw1GXeVI81wc=
X-Google-Smtp-Source: AGHT+IGngWxVVsltawlkib2cJ22V1YGa9KD1PawznkJoZqGdnB8Yf2l+SvyAs7qB+gwEv6l5ovFfuQ==
X-Received: by 2002:a05:600c:56cd:b0:414:868d:1cbe with SMTP id
 ju13-20020a05600c56cd00b00414868d1cbemr1864052wmb.9.1712226521487; 
 Thu, 04 Apr 2024 03:28:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 j7-20020adfc687000000b0033ec9ddc638sm19615681wrg.31.2024.04.04.03.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 03:28:41 -0700 (PDT)
Message-ID: <e6e59dbe-66da-434c-a9d8-1038858b70c7@linaro.org>
Date: Thu, 4 Apr 2024 12:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] [for-9.0] esp: avoid explicit setting of DRQ
 within ESP state machine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Mark,

On 24/3/24 20:16, Mark Cave-Ayland wrote:

> Mark Cave-Ayland (17):
>    esp.c: move esp_fifo_pop_buf() internals to new esp_fifo8_pop_buf()
>      function
>    esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in
>      do_command_phase()
>    esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in
>      do_message_phase()
>    esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phase()
>    esp.c: change esp_fifo_push() to take ESPState
>    esp.c: change esp_fifo_pop() to take ESPState
>    esp.c: use esp_fifo_push() instead of fifo8_push()
>    esp.c: change esp_fifo_pop_buf() to take ESPState
>    esp.c: introduce esp_fifo_push_buf() function for pushing to the FIFO
>    esp.c: don't assert() if FIFO empty when executing non-DMA SELATNS
>    esp.c: rework esp_cdb_length() into esp_cdb_ready()
>    esp.c: prevent cmdfifo overflow in esp_cdb_ready()
>    esp.c: move esp_set_phase() and esp_get_phase() towards the beginning
>      of the file
>    esp.c: introduce esp_update_drq() and update esp_fifo_{push,pop}_buf()
>      to use it
>    esp.c: update esp_fifo_{push,pop}() to call esp_update_drq()
>    esp.c: ensure esp_pdma_write() always calls esp_fifo_push()
>    esp.c: remove explicit setting of DRQ within ESP state machine

I have to prepare another PR for rc3, do you want me to take
this series?

Regards,

Phil.

