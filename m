Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10635F589D9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuop-0002Gc-9F; Thu, 23 Apr 2026 10:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuoG-00025u-EI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:13:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuoE-0004hH-OF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:13:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so109745565e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776953617; x=1777558417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TvH65QbAvp8B/9Rqo95l65ztoKih/x1ELMtq4S1ebzU=;
 b=CF1KJ+e31CDp+2ui6XgXehC7egZ6xezB5Q4oigTYfsB4Qj6wUvzoxq4HfEjri+lzQP
 R+zdSRC/2jxF+GFlUFENK8CeeRKCNysH6mMOafcqp0xGmPexVsizFZ5+T7scig4+ic23
 AZr5ol++CuRgcvb/C2ctZ/5KbNeVjlv9BP+dLRZiRDff+ywa7XFWz91LzIcUiv+7hRqD
 7sF1fr14BLQe3eKBzZZZzJwiX1XNFlF+at6gUwfABxQGHGawmNE/AWWNMQa4PbWMmNNR
 jo35C4VR5lGxrb0ElFm/4j6iyWqgvocS4NUMExkFUwvWl7QQpgO/qMOQBMW4eefhzjPF
 Twzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776953617; x=1777558417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TvH65QbAvp8B/9Rqo95l65ztoKih/x1ELMtq4S1ebzU=;
 b=svo6qn5abO8zJ36VHrDjKJOp73bvu1JWQ3jFSI3zMQIhz6OIQHNbMKwnJ0+dQeUPcm
 ErmRk++AcTcM/8zzCpSJVZ0KRyU1Qr+b+zzxe4lYh3QQe6UXZ+b79sAFa8WxoVv3GVyk
 RpHfjkYj0xjuzSER9ADjAyADEs6P5dQaF79rImiNgFqvmZZ9q8lw/eIGpN4Sfbawmx8Z
 tSnP0F7mYP7d0aiOioNl4Ekxq97+5h58br4fZVHu1e3BYD9YLRzCtZ919z3642oYmUzH
 UoIoWb4vo5Pbi/RUqiY1Ahfr0j9SQsfrlxbYsuuLFAf1ruoMjKCc5Iqv9UUaNaXFBxRC
 6M9w==
X-Gm-Message-State: AOJu0YynShYB+eK/j10B97Rg6sZ/r7bTndFwWBOC16dDCxCw/84A9REI
 K4Hl0MhUBhACdfW9ShvneZaQkt5rBdgyzqvyMh9p1O2pw7QV6k7ENgVEbSonitlyJlfsuyEJRHo
 wdutka8Y=
X-Gm-Gg: AeBDieuIKkBFE1LyMGk8yj6zqWWvTcMdhpRuomIQZiakPwKad6oQ3JC1ij23+4jpvCs
 2m9/HOSdNbOMGBFfB/DayjEQMO/7q8+Utz93qVEDTx9R+eGRYbjGfsZhDN0q4U8ZozaCORxWfhx
 UPAVpnnN47budNDElcR4ZCZBPj4BcRjw4qbLlYGGNIH/FyWXDfXnxIx7WEFrrIQudYxzfP23y5X
 ULjhQL1BN+0j0AP8ZhGZQIYaOD9tHSx6SsJirra6u76XmYSKRH1JbUZ8Rz6DwOkxKLCDZjqp5nO
 10fS3CBMJRPQO8+37OZ2nXyQ5ow42mlm1DcgvxV3fMlejIU5a3K3mFSnNv7vvSNKssqj04pBrF3
 /TdHs89cqvILeSwnvXJhm7flC6cReSTfT1BzK1ehRmZfIKWidqQQhpA1ELS6TYM9t+zt5zR5bI+
 aqPmOuqG72XMyyHVFzdUbVPaVhzKAXgslrwhZEWJm3ruZuYCTPZUnbg4LqH5PblvA+TUdcPCp1f
 tHR
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-488fb7844c5mr430918455e9.27.1776953616647; 
 Thu, 23 Apr 2026 07:13:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm14438127f8f.15.2026.04.23.07.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 07:13:35 -0700 (PDT)
Message-ID: <0a99894e-48d3-413b-84ef-48bc754345b9@linaro.org>
Date: Thu, 23 Apr 2026 16:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/s390x: Compile vec_helper.c as common unit
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand
 <david@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-7-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423135035.50126-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/4/26 15:50, Philippe Mathieu-Daudé wrote:
> In order do build vec_helper.c as a common unit we need to
> replace:
> 
>    "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"
> 
> and update the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Unrelated but could VLL / VSTL leverage the Int128 type?

Self-answered:
https://lore.kernel.org/qemu-devel/20260423141245.51344-1-philmd@linaro.org/

> ---
>   target/s390x/tcg/vec_helper.c | 34 +++++++++++++++++++++++-----------
>   target/s390x/tcg/meson.build  |  2 +-
>   2 files changed, 24 insertions(+), 12 deletions(-)

