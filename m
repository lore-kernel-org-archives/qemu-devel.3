Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF3BCFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxp16-0006f6-OL; Mon, 07 Oct 2024 10:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxp0q-0006YM-O7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:47:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxp0o-00043h-LJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:47:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e06ba441cso622328b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728312411; x=1728917211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdfWcOh8BtgGLvYstlQB3dMBoMPbHXXX7hSKE2bXj98=;
 b=rIDqEAvbEzu5kkCR1eW6WZ9I/gaKziIzfCoWlG09tdVawBzBETtVnaU45xB2ZejQWe
 d+OOegsv4QTYh15cF5yrW2ihDGbyji5RBBoruqssiw6bi3EwbGvObemXRBz091kKLS4O
 T3nlN86ob32ALU7i1xKmQScOLiPbhWDr+L9MYiwQaWzy7vwjImdOa6sWcvLn9ZeKpvEV
 n8PC3bY2iWsTM5Pl/0eOxTT2WtkFE6VMGxHsoaDBlgg2ksScjI1Rqe6O99h6foHtpx7C
 jmOAVp8UX4R6iUywnv4NEuEhIQ7Vi7wW2iA7RrRNunx1bBc/JIq3d4u5C3VTHHziOezP
 dHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312411; x=1728917211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CdfWcOh8BtgGLvYstlQB3dMBoMPbHXXX7hSKE2bXj98=;
 b=v2KmyZXUhjZuAQq+XMe4m80iG5j6MMjewLLxVkXUQY4lsEtebGfz9zX4x1YHy9IGjO
 SwXGPXx3DVcttH88cCO+DPHI+gOoMZxM1XuXo+Gpi/OKy39psaApbP1K8U6ExKeOi8z2
 HtH67KmXkuWjfI1E+kIZ2Ec4jXv7VyGBlrPo19n8+rIJ/ZsUKmWtnOonX2ZssDZXAb0h
 6iiGM4jXix/3VPvisNzQXXJeprbGlJwDgJVJkhWoF3l/ptGY2lmnnSQGf6SuTlfzR4Dl
 UgOY0/q4g37E+CxjCZzOTTWhSSfmSllSUTHoeBcHQ7mxThEgfmQPmq+2ipDgdNK6v/a5
 gdjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAAnUMHlK5f5Nrh9XGd00kkIt0z7MtWfY+0WGNyN22C8PbDbUKsuPBRsbUd+0xncY6z7LliowjLOPf@nongnu.org
X-Gm-Message-State: AOJu0Yz04f8GsFf9ZVrw9AKnvdjhP6Rc2rXtsjg8aVMU8krYN/C++ro0
 t9d6q9gVrNdvkwsSQ0Adb5HsGuDqXfel6Uhqefz3wjHjNnp0sswCOPBldVGAgqw=
X-Google-Smtp-Source: AGHT+IEYHuexO7NgwtaltWEN7heelGdfvEqNUaLljP85laH8zFWt4E7fCAoh3CtWc5sKvh1VhbxiPQ==
X-Received: by 2002:a05:6a20:d70b:b0:1d2:bcba:70b7 with SMTP id
 adf61e73a8af0-1d6dfa55cd3mr16722504637.27.1728312411167; 
 Mon, 07 Oct 2024 07:46:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d7d439sm4451856b3a.213.2024.10.07.07.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 07:46:50 -0700 (PDT)
Message-ID: <74a498dc-d30b-4355-bddb-e29934722c23@linaro.org>
Date: Mon, 7 Oct 2024 07:46:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson: ensure -mcx16 is passed when detecting
 ATOMIC128
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-stable@nongnu.org, alex.bennee@linaro.org
References: <20241007084342.1264048-1-pbonzini@redhat.com>
 <20241007084342.1264048-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241007084342.1264048-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/7/24 01:43, Paolo Bonzini wrote:
> Moving -mcx16 out of CPU_CFLAGS caused the detection of ATOMIC128 to
> fail, because flags have to be specified by hand in cc.compiles and
> cc.links invocations (why oh why??).
> 
> Ensure that these tests enable all the instruction set extensions that
> will be used to build the emulators.
> 
> Fixes: c2bf2ccb266 ("configure: move -mcx16 flag out of CPU_CFLAGS", 2024-05-24)
> Reported-by: Alex Bennée<alex.bennee@linaro.org>
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

