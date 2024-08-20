Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F1FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMHH-0004E1-DX; Tue, 20 Aug 2024 06:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgMH9-0004Cl-Ls
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:39:43 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgMH8-0005po-4M
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:39:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5bede548f7cso3452727a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724150381; x=1724755181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JDvNnQTvDSh32A9jDGuqBTXfgR0G/e1o6MYBxxG1hBQ=;
 b=eQzTBgmYihC7AWVhh10WTyNQ0ZwuCOwdtXqPyMnlMw5YnXdjxdy9pGlqC+NVAf8nPN
 o9d2E6MwcMSuUnVJIglOXN8Xl6WCwVuaftUsR98pFmdx5p62FKamYCqOiZ4+5Y7Zb1Xd
 c4oDfteoqutd9upPy+r+vq2v2POjUpgtYRnal83odPIhdVDiZw1N8plhK/j4JCXm7Nvk
 8yu7zg0ysutj5Nh6BeDPBk68wblQfOmiV4hvCONASEojjuo5Qdx20E/n6qqx3Ys/kMZo
 0Zk/Q3Zpdvdn3NOA7Fh8Q4hFcrocTfULRNuAFpBOlpG30ZRCwbwOfoXoOo8HAaMizwWP
 nuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724150381; x=1724755181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JDvNnQTvDSh32A9jDGuqBTXfgR0G/e1o6MYBxxG1hBQ=;
 b=LFlpuHd/0cNmKnDIKR77wags/WGAPi3kH8LzPfpbPi6SNa1qYfuPU1byVcjy3JUbVb
 NnNuFiei6QkblsrswrfrBGVQ0X8Pq7nybGdkFADyyHSmxB99ZLgVmB2HpP5fVlqA2KZU
 NZ9sIUbCySxlTDHZR29IfVHsPCcuCSFn0XxXo7sReOse6HoMcSkxE/ehxPUiA8YGLRvX
 H7JMgFTxC0xHZMeO7yas6Fijiu1L9wrhTI5/ETxjnMMDztovVAmjHvpvgZDO6W8e3fZw
 zGYGj/hzmIbbGWjuhlVO4wnTaYYKLQmo0q+JOjK83nGscuvdDl/poT6of2HJIAT66XnY
 duYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYbwxNZFuITY1t8oY60Wdmz6+uFx1/ZiWHG8g4i4cEaAzxtKdYfQwVpKW7u/wPpgO3VcK6MP12sRrRSFPM6Jwov11Ka2A=
X-Gm-Message-State: AOJu0YypniV+uHQZptX1wr9Yton0gdvIzT55I7snLQ331aT8jdUwX+fv
 83Zk5TFydrcCeR66/EI2Hiz8pd2ljw2PezcbIwVJjDFa/0o51Nvt+oRDFCum7DqtNjBQa7g+E44
 n
X-Google-Smtp-Source: AGHT+IHer8sYgaUfE/LrJgzwGzZfvpxnuwO0C3ralML75WvUgbtmk6bptLIFa8o/sgyGTgv1DyIRIQ==
X-Received: by 2002:a05:6402:34ce:b0:5be:ee30:9948 with SMTP id
 4fb4d7f45d1cf-5beee30a06amr4531652a12.8.1724150380558; 
 Tue, 20 Aug 2024 03:39:40 -0700 (PDT)
Received: from [192.168.223.175] (84.21.205.77.rev.sfr.net. [77.205.21.84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc0832d2sm6565334a12.97.2024.08.20.03.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 03:39:40 -0700 (PDT)
Message-ID: <eb9ecc66-288d-4fc4-bdfb-95594774bdf6@linaro.org>
Date: Tue, 20 Aug 2024 12:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v3 0/2] hw/i386/pc: Fix vmport option handling
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Joelle van Dyne <j@getutm.app>
References: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 17/8/24 17:24, Kamil Szczęk wrote:

> Kamil Szczęk (2):
>    hw/i386/pc: Unify vmport=auto handling
>    hw/i386/pc: Ensure vmport prerequisites are fulfilled

Series merged, thanks.

