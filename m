Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D93FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 20:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvLmB-0007fN-CX; Wed, 25 Feb 2026 15:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvLm4-0007f2-2g
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:46:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvLm2-0004k5-MG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:46:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837634de51so809625e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772052380; x=1772657180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mD5M9KqnmbznmzWZViDIKBhV+uvJ9sMPczpqJFD9NQg=;
 b=BKl8miGxUql/YuNg8m0JoYzbeTaNzNmt5VRQX9L75YG9IY9IGUc4a/qIVOLCiqumWO
 VuE9Y7eiED9BvogaA3V5q9oNVB0RDdmX4Jy1di8cpGu+Ypmx8R46mM3eNvf7fgDNdEDF
 TYS4FyWjz2Qd7YjH7G+AoGofxz3ZAYMKxpv/1LNu7bNkSbJ7YgQe9XeO5y8Tbzl65bvQ
 wwwHsg3i1jaCOFRXzHvOz9d7pkK9OPnd9AbKT9kN3gvu0+TsAGYnelI0mbgvfTiP07VJ
 dNrYX8JJou/o/BHyJ5oWz0bVVCaaob4Z87yWErTqQmIEtKKWgONCkIdh7INKmDXy/dsU
 GJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772052380; x=1772657180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mD5M9KqnmbznmzWZViDIKBhV+uvJ9sMPczpqJFD9NQg=;
 b=HTTdP7BmHjaXWRc3bImNLbXCHM//B+wIAf3BulkshnarpQOIewHy3VuAzdBN+zy3Ac
 P062rUxuX5Tlc5VQoLQXGQLhh97z8EWm3UCJVCF2GXVlFYOWOgDUmDo0DmbGHo/rJMBE
 xfmzePg23KwBu64tt/k5Exhsq7hqQnjeNemScPjUcNyfXEgg7aVeEbwiEGvyATiL+Rlu
 rn3L0jpxszGGzeXrNqWiODQluKOMvTNwmNTi0oqB2F/IgwzJcj1V53JdFiFp05VxQL6/
 SAqNHV/86UxHlrbXqvUf06jcDiMXExIx7JpMcfuhQgPZZJQpaqi+r6eYPCrWiEYV8VLR
 odZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzyyW5esPbUc/vtdLp4O0w7o74wW8S9+3sWd6eIms3KE7hrW+dR7Po4MuIwPwPjLWvsOi9YguLCQvA@nongnu.org
X-Gm-Message-State: AOJu0YzsW9S0fSZkIWbMqq1Qkea1zfVmHOch3HudqEG/1N/7yr/pSjzi
 y+Dm+lcszek78MXG59PQuvLBtW9U9KfoXvLzwWJdrD6Ar4EIakM2eZLXXRENjIIylPg=
X-Gm-Gg: ATEYQzwmDvKw+i59wlhthD8FbTv7JdMF+2xqH2PdacxSiywwrAx6GYxbvEMRDy3DSxK
 bNZEMfJWD9qLPwjNHO7qZv0Dmwr1wvJiYM5nP8Ae0iHhPM4uX8uxFUt/ZPETXaIgBJ8IjTWLyy7
 w95d72TTKsFH6vSFlbFoPlx/aPcJPy9wDFP/dLkEvZHNFimlRJJzWMu3bkVFL2V0nv/Zpib6fe7
 hNnQE9X0Ty0iKbeH++mx0LknEHtvkHT1TCFSoC0yfeDzuhRopdu7Q0RhsMQC26zOa87EMGU05E9
 2q0OuKuVO7fMcWp1rONintk1X0V47jcKpLlWGgAXPLVE/nMbGOcJUSnco+jXmf/joG7+sBohyKe
 duaWJUz2bDCCCLtm2pc4/gHwzTybby244wbYWBFtvcK+6dE/e/mfgZJ6IIrV5C95JHRI2v4ZvQZ
 U0MO3O1pG1X3s/5jtdRtNrYknphcGGnyTPQ3W8udJkGhT18Tj6dlbajiCneDUX5POJyw==
X-Received: by 2002:a05:600c:1386:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-483a96087d8mr324495295e9.14.1772052380511; 
 Wed, 25 Feb 2026 12:46:20 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm90169165e9.7.2026.02.25.12.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 12:46:19 -0800 (PST)
Message-ID: <b977bf55-ffa8-49ef-8f45-1d57efab1eaa@linaro.org>
Date: Wed, 25 Feb 2026 21:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nitro: mark CPUs as non-resettable
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: graf@amazon.com
References: <20260225173223.418262-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225173223.418262-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/2/26 18:32, Paolo Bonzini wrote:
> Based-on: <20260225144532.84673-1-graf@amazon.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/nitro/nitro-accel.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

