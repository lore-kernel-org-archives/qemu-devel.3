Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5489DD3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oQ4-0003tD-4U; Tue, 29 Oct 2024 11:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oQ1-0003sn-Ky
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:46:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oQ0-0003kH-8A
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:46:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so40227935e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730216763; x=1730821563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cj753F+hvTDyLj8bJVVZzpyE5puWDfwyIGxtEnBX27s=;
 b=XtMVcW2n3kFM9BO40tI/YDLkQGrwY+dCREECV89NfNXrLm4U1uqs9LHxlsl//P1mvF
 KpXS50sCOu61iQZ1w0OG9xSRP0Gl2b4k21AFe/Mm33U8AShrlgH37LvvwGFim+/O0RXz
 leCxO0PhEtOGKetZlI+G66fteyZSjEap9Sgwns8MbXs1udWfsdHjQZ47YaARxARJ/QdC
 MvM7EDlE0HaAMUu7IYxZr3Ji/PhylpQ5zdU79lbKbmiAWan6m0QOjETgC4CDQpjHEwfS
 4cmOKl5nbigeBvZ2JJ/u8olKPbIrbKZjifz254P4ynNPaOetd9nsquUL2K+QSDALc/tL
 55dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216763; x=1730821563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cj753F+hvTDyLj8bJVVZzpyE5puWDfwyIGxtEnBX27s=;
 b=Gc7vCM4BHPf1LWqf/cRvpFKs0eDPHq9gl+PRx/tad1I3WtKkf0bOdDPRwcQDvPcEeR
 58qE8TrTSGETT1Cec+gZTfXDIVoph6OubNRVWN53VUAmgklEvltmC66k3rdLbU4sBbSQ
 ywTw/OVXAjrwa/XYojW9XBDl4E4PlTLErp0GEXT6qMz2nssc8MY/3MG5wGsVnqCHlW9B
 znkwXvvROq/GQLOualXpN4zQVgRsdxZkbTUABoNwVwO3x60xg4A6/zzBr8xn1sdx3Xep
 /GP8S7W1te2JmqgTt7JlHA0Vr4h2jTZy00vLqitShJ8FqV64KedTka7MrksPxcWPTezX
 udTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWOE+1r04pmyDCzd72/HGKiee6ZCtiznNnT/+qMQW1sx6kDVQ6GhlBlerFTsue4VfinYvQA33n1Buq@nongnu.org
X-Gm-Message-State: AOJu0YyuuAlbetJIRDTde1r4u6Qck4+qNc0JqM+L+1QyKqnStxua4jGa
 qhghUnTwWfDbTBLV8Ymmn+xkjrNWOD9p95he+hjUreGvOWmH0Rs28gvXCeIHFa5+QoBcrY0DPed
 L7iP7jw==
X-Google-Smtp-Source: AGHT+IG3g7DH46FlmnjkT9ZZaJVkz4hrFMzqOIXB4ykMuPWTIJicxZHqMzvMsFjLTIrccxDPgm43GA==
X-Received: by 2002:a05:600c:314f:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-431b55e6087mr22929095e9.8.1730216762646; 
 Tue, 29 Oct 2024 08:46:02 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f779sm177001325e9.18.2024.10.29.08.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:46:02 -0700 (PDT)
Message-ID: <5985cc17-c123-496a-a6b8-23c651a97f68@linaro.org>
Date: Tue, 29 Oct 2024 15:46:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] target/i386: use higher-precision arithmetic to
 compute CF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241028151851.376355-1-pbonzini@redhat.com>
 <20241028151851.376355-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241028151851.376355-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/28/24 15:18, Paolo Bonzini wrote:
> If the operands of the arithmetic instruction fit within a half-register,
> it's easiest to use a comparison instruction to compute the carry.
> `
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/cc_helper_template.h.inc | 37 ++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

