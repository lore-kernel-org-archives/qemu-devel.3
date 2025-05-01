Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0516C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWLv-00022v-1s; Thu, 01 May 2025 12:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWLi-0001kB-6I
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:01:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWLf-00049q-Gy
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:01:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224341bbc1dso14799295ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115277; x=1746720077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JQjBwBGPQO8t0XHagIegPy2L7/pMF9rZ8N/LvRT4mfo=;
 b=sprt2db+2S/OqFoHw/Si+9rdrCcxAQL1wm0+ra3v08RIIR66fjOHPEqvO9YG9lKnpa
 Iv+0vFg+CilpiMk0VHOT+XT6zeDZv4wS916ar9XJi6mmJJPiIfToe60OaN9DiyuAaHiW
 8xEh5TqEMPomhxLt1yVVN1m5XDlL4LdrSZuYmtisn+iJPslgQCxzMSXzDcNsFAuiBrYc
 5Spg166iSB7omfPqaLRYPbZB9boKPHuuCqMPi1ud1lgPQxTIG0W+0SGp6RljT/C/PYgK
 hHlHQrDaCVcY/2TnTq7W9+GWvrtfDsfJSaef3QveZefArf+3bOhXH0MLXrU9i25QSwRV
 +mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115277; x=1746720077;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQjBwBGPQO8t0XHagIegPy2L7/pMF9rZ8N/LvRT4mfo=;
 b=bjFd6lDFFRin0Aw82vDfn0XG+v8qYTzcnSprMS5Us3COQe4/rl6T4d7chzajUyESqz
 YUHBtMSruBBkyQaLn9IU7P/z4F+gUop5ocIRY0umr9sSe0gQE44JSCurK5dxOavz6R8k
 cIe2PNC1+bDXwuxrh0hBQN6JhrUbkZRwhcrsZCh4wDy4ALjeIOf87UIIMT1N7O4znCzV
 Jqo9MLVPfgXiuDtGdwjDrzeUkLGI7TcLY72qmHsDLM7Vp/RiHP6MosPsHupFOA83F4/H
 zgT2+wphTq4aH6nM8ERHmscW0edu17J97KpYWgKyHRBuLMk+GI9KyQTbLvByKe5b/BaL
 UAKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYESL7/FM8rFURoB1cLDO11V3sJ/lQ5rW4rbBM6jgeVCco2PllKl2LI8Tkd+WdJYQnnPf75oV3azzS@nongnu.org
X-Gm-Message-State: AOJu0Yw9D1xhJ3K6WTCU+ExTTzYR5OD5ucRhGhDDUHRbMvqfzY+Yy0Ic
 tiQe/PT7h980myjmHW+u9wOAh1MBMSGvltpSk2otoy7yEtD3DLk1zQFNkUq4uuFXqklsl1qRTgM
 d
X-Gm-Gg: ASbGncsamhz/iKB2XpHUrFNW/8mlPT1EfUdK2DlGIgrR2NTeYKKzGpWIotjXXKFMm9e
 l5y1Ah+Qrgz3qmDzvXDqspyLIQBSGtk+etqet773rTTNmIhS0pjoyR3N29x1DXT+kJYoB9scaoZ
 xxw2if/z0XXuUwab7Qpj9U7SfGAyhtyi6KeRXO02X0OVUjmxRytX+QgAldCmUpqtboInbFX8Adm
 or8D34WG4w9Z4iPfYpMYH+m854zDEIM5z/XSnU4Dn8dqAIRt7TfCtEuKZBvCgXfgh1gYpxdsndT
 iB2xOsL8nJtiN56P2W4PAlvdBOTTFTz5i80EaQu7PLaogQCNgpZNhQ==
X-Google-Smtp-Source: AGHT+IExx7H9UJ5Un4YCvT5NTCfXYvLG04WBmdstwlofIA6FgFZZKIjHuRZcEPJaIkP94ovchbG4Ig==
X-Received: by 2002:a17:903:11c5:b0:224:c46:d167 with SMTP id
 d9443c01a7336-22df34d5cbbmr117518275ad.16.1746115277608; 
 Thu, 01 May 2025 09:01:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc7b214sm8315565ad.183.2025.05.01.09.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:01:17 -0700 (PDT)
Message-ID: <79297337-122f-40f7-8960-b6483693096a@linaro.org>
Date: Thu, 1 May 2025 09:01:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] accel/tcg: Use target_long_bits() in cputlb.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


