Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3072AC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 14:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7yf2-0003do-NQ; Fri, 17 May 2024 10:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7yf1-0003dG-Dy
 for qemu-devel@nongnu.org; Fri, 17 May 2024 10:34:15 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7yem-0008ER-15
 for qemu-devel@nongnu.org; Fri, 17 May 2024 10:34:15 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59b178b75bso372581066b.0
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715956438; x=1716561238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KH3MoRtmFfNNLeS/K2TUTG9VTckgrIrMgiMDoJmlnCM=;
 b=XceATDOF1svQUAQafXzWPTwXxjZpbMYISccoeepKWZjEz52Hl1kbSIcKKho+Zdb8+R
 Xh3AjjAbYLY86my8omkc7gQreVtmpElB32J9FOzE+Tzb18c3g3RHODnvgeSZJH2+dznU
 AYuK4vC+4ik+OysJtVPv3/1/hWiI0CMOy2tOaCgqz7GPC4zJpLivCMWFKynKF4inqUsJ
 eRIpfJQzX7t6Z+DUn4dkey/4XN7nWesgwznoG97hkvmBfJazKXkKyP8tg8N2AWxZdJ3y
 QIpPGCIbruZZ3GJyCU2ZZjVy1wkhw0UpLdX7JUfTvt1u5ZT4bIRzJvMYyTdLAFw9rx+K
 LOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715956438; x=1716561238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KH3MoRtmFfNNLeS/K2TUTG9VTckgrIrMgiMDoJmlnCM=;
 b=mhZ69oHV5cOCB63lpt6GRepLOVpxruYl/4jpz1+150KfwV8seNSu/QXqlHDKj8g5Y2
 mJN1Bw/AbgmOwdn9Vur8WvRVQW1hZPqu2glNFiMLF0rQwq7YkfOy4X4KskCLElzq9Ad+
 p8ra+8v+egFIL6LBPp+DnYZ+n5ATlSmpivj3io5NE4v25UlDtYDnWek/g0sLEuOIVymB
 LtmSmG3YgfYEFQPGySWsNHdgCNWnnn9wFKe8p+Pd0G8QwisVXCj2OULTgkmaLmSy5YLt
 FjPrWy1MiI6TgimfEOHlXsovfPFRH1AWTpkS5V5vTKWL5cotX+cU0mfJohxoXxJ/pDzq
 4xzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcqE3lf+8eNgi4Dfn3dVtVazwwPDpGZeV2LS6MhGpPuDMcMR/R4lTLlSP3M5CG5r+Vic+GuqvaV9P+IR/22GXKPK1megU=
X-Gm-Message-State: AOJu0YxifdKgt7/I1Zsa70IYcsuIojHNi4EutvpU+t1Pt5c+xWpFyAko
 XnjEaPX5HTU6udsS7muwmAI8bpJxDll1HkRreq/pm7ts91jlR9PYNepnhKoLVd8=
X-Google-Smtp-Source: AGHT+IHejMymZyzRlzKfk6d4E0FIytScqNktAaca/8qgZuZ08LfIoN0nOft3NbsTbuKggDwaJGgiSg==
X-Received: by 2002:a17:906:594c:b0:a5c:d67a:1e1c with SMTP id
 a640c23a62f3a-a5cd67a1f6fmr627601666b.20.1715956438186; 
 Fri, 17 May 2024 07:33:58 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5cdfed0e27sm259737466b.213.2024.05.17.07.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 May 2024 07:33:57 -0700 (PDT)
Message-ID: <4bcde5c3-6a63-4e33-b57e-a30973807a70@linaro.org>
Date: Fri, 17 May 2024 16:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/s390_flic: Fix crash that occurs when saving the
 machine state
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240517061553.564529-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240517061553.564529-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/5/24 08:15, Thomas Huth wrote:
> adapter_info_so_needed() treats its "opaque" parameter as a S390FLICState,
> but the function belongs to a VMStateDescription that is attached to a
> TYPE_VIRTIO_CCW_BUS device. This is currently causing a crash when the
> user tries to save or migrate the VM state. Fix it by using s390_get_flic()
> to get the correct device here instead.
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 9d1b0f5bf5 ("s390_flic: add migration-enabled property")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/intc/s390_flic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


