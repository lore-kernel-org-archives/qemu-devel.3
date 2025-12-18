Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D89D6E2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJDM-0004sO-19; Thu, 18 Dec 2025 13:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJCa-0004WO-5U
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:58:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJCS-000866-S3
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:58:12 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso9210535ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766084282; x=1766689082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UR4VBWc6DNMU5FEXIgO5B86S7nSMtq8yuL3goSAcQvo=;
 b=kqrU7ptIiQtulRdvnHyAfavvz9o3fnFvI/EkWw/fj5SszcO5RBd/whG9c/mqee3gCA
 XY70coKTOjqAmEw3qtgPmAUFEwFZsnfrCu3P+dSA8rBI6iLWkipi/0nth8EJHlNe1WZK
 mn9KpbAIWFQaeuIrCihGXLM4dec/SIE8/D/Gr2gVRa66MLlrrfWxvIQQ+oURGyHqfqAi
 hvZ1IQmJ4Uwt6xQiodPiiSOo6FMFKgvlBCQsjK+0bU9VR+kQscqLcOyJdUaz9+xVp8xM
 Inho7XKuyAxOI94/qSPHjFThFhUJqliw15NoQ7P5CCQx8KhA2fFKh/JpTrE2vdLlcTF3
 vAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084282; x=1766689082;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UR4VBWc6DNMU5FEXIgO5B86S7nSMtq8yuL3goSAcQvo=;
 b=Q+GDNHwhX1Hfk6EYLiso/tTD/cMXF7gvGfybSg4ybIiWLkF7E9wHtQ3H5pbm69FVrF
 euYH5Sj9y5Mc9196RdUXqfu01+w5U75fmMoMl4UdnIsMfmdfhpZn1Ja27mYxDTGYi+lE
 m/wvALpms1jPfyTcJBLxTFvxofbmjngiOR0u/JYUGe7HA+kVSSQPEHF4Rz0oHTTBDR6d
 AMyMhWN6r9CiCNai3K/wY0pAk/pqZ5i0rD1HwNiRyJ9sKdrgeyhshLjmiApIHOpwell2
 IQphaQXLu29A1GZ1L2HUZkeOuqPAPphsQH0cM6EvfkGI+DvmZsl/QqOE0Lv6/TtswG2o
 L3PQ==
X-Gm-Message-State: AOJu0Yy7Wk2h4G82Q+wr6haNfVc4PhLyhJkXebcGNOKUs9bIULMy7c1K
 88dAp7h0mRHmaVfejtTUxe4nxYZFWLP6f12m32Vu+Non3JgQ+x+SSwuU5lXbI4M2CiaDqSAAau+
 zaQ/rECI=
X-Gm-Gg: AY/fxX50UD/OwmcytNEbxn+NUsnPIlTe63gL2qcsXwkO+Jg+BdvMKYaHOG2478TNJAR
 33mudgTdaV3bYXh7QOygc82LfdYNmkUPxr5AkElNX4adYhQdpYrNiKWGS7i9TpVHRDNqU8pq4fO
 zlJK3xe/WaBjARFeFONg6aNYFtily49HDQU3a3GSimF4p9nF3Os/OxUhGst+3MfAJhapJIRuoJ0
 mZ8dNlfFboFYfgmVRPCZ5dITtVH41vwH47Yx2yIPznjZSlAHZ43CApfnrYG5/GdqLHr7TH4JC5s
 9ej2rhyj93RxG3TENTLAepb7u7n9gqWaz5Kwmx1PD+nmfSdjyBiFt7LwBDXsZB/9WJhOWaeANgp
 2Ko86YZtG6HRq2EnZTDe1aTLEOWr5myZFaXy8foCm5bCzEtDFg/0ohrdZiqKq4/KBT2gWjrhfI6
 IdVRzRnpEioHOzB0IyAefP0qdhvqLzKw==
X-Google-Smtp-Source: AGHT+IGVoR5bxa3uzCOZA1NzcpxQLJraqjq5DFM75hGK4+QysLWXRdJAxj/5hovgBZ+8b4iFiuZZ7g==
X-Received: by 2002:a17:903:2f82:b0:2a1:10f7:9717 with SMTP id
 d9443c01a7336-2a2f2c4cea2mr2317145ad.58.1766084282325; 
 Thu, 18 Dec 2025 10:58:02 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d20dsm128565ad.67.2025.12.18.10.58.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 10:58:01 -0800 (PST)
Message-ID: <4d5ac5e0-c0d1-486b-bac0-4c50c0d0cbc0@linaro.org>
Date: Fri, 19 Dec 2025 05:57:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/char/serial: Let compiler pick serial_mm_ops[]
 array length
To: qemu-devel@nongnu.org
References: <20251218181812.58363-1-philmd@linaro.org>
 <20251218181812.58363-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218181812.58363-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/19/25 05:18, Philippe Mathieu-Daudé wrote:
> No need to enforce the MemoryRegionOps array length.
> We index by device_endian enum, the compiler will easily
> pick the correct length. Besides, this allow further
> adjustments in the device_endian enum itself.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/char/serial-mm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

