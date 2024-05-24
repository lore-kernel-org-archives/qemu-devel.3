Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F7EC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVy3-0005Fs-8c; Fri, 24 May 2024 10:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVxs-0005Cm-RC
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:32:17 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVxr-0003di-5f
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:32:12 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-60585faa69fso2164150a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716561129; x=1717165929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O5ZSCjiBtlTZKUUcTHYMRt+4hXXZamOOLUTb9HTXEQM=;
 b=Cwj03OZ9/8jBS/U1Obxh+XET2EtV9PB13DV4jNAZGv/xKcyAzc8tOGNkMCgbMzkCQS
 2LiLvLIpynk2HzYtTOyqPhxoO7/jKx85KVM3ZxAwnVuddHKjOEhZiSLkrl0Iv8OG/qCp
 eH40SWFmmWZM7DvRNb6Bhu3VmYxk2m1InMX5KBymy/le2++S45zmvb7HQFanMf3I7IMO
 KcHas28B0sP3j3wDIlapnS8zWQcjFkmGUlaEvnyLHCY2DEaT3HU69pNXDCYeFKngC0yQ
 zAx0LCGO8XHeLovWN/zBygsKxQ3ngLEECAFiVN0g9Y3miFQfGotVMj6JhajN5tlcndDu
 op5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561129; x=1717165929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5ZSCjiBtlTZKUUcTHYMRt+4hXXZamOOLUTb9HTXEQM=;
 b=hHXcsvQkLKu3ttgyhs3aT9wHpUWlKzffPhFIOugyrbTs78u2hzfUA00agp7rII79+B
 gOT4OMenW0xt6qeJ4gYBXYEe8+UaOiHqvaaM7bAW7Rs3eraqyGCjYf+Op7Y19738QjU7
 l/D2CeQPUmFkn9o8rpFzq/T90J8iBcdqE1Udni47bTF4y8EbwiyAUPM6IUli9lyhbGKy
 ROZSkSxHXnfzzuQaUeTDnUpEZ3n+/R74X+/ISmddjJ2eeubtUVEwPX+T9G1kGa57txL6
 8hVrQSO9cP46g5ig538bghPCra39E6Gn+NIyzpRN5wtfHyB1274d3ahNM2J9JYh3ZX+V
 MhIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5pveXWDhFxtRSizHa6xGBh3qnZWx/aAf6kwyhWOSopRNrNobbWlQhTjjKSHi80vIVzONyaTzuxsFqPIdoOBL/ovkulF8=
X-Gm-Message-State: AOJu0YyvIwli0KLzZwV6zyjH1kKo+Zlx93mf+HQ5ZwMtzNmD/j1ui2ik
 Hhr0H0bclFB15I9DJfnnpzuD9Drhdh5pPvEhmXTLY0zAk1TDiPSa99KbxKX5F6DTOJxrz17eWsi
 v
X-Google-Smtp-Source: AGHT+IHJyugLSVrt7esyO+VY64uhccoA7S9LKReNr3zffn2jMt6khRzXHsi0k/EjQzyEa0s5tvPzXQ==
X-Received: by 2002:a17:90a:888:b0:2bd:efc4:a9b with SMTP id
 98e67ed59e1d1-2bdefc40ad6mr5772952a91.8.1716561129116; 
 Fri, 24 May 2024 07:32:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6126fasm1454229a91.26.2024.05.24.07.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:32:08 -0700 (PDT)
Message-ID: <26a7be0b-6bc3-4c0d-b986-13fd0295e642@linaro.org>
Date: Fri, 24 May 2024 07:32:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] target/i386: raze the gen_eob* jungle
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Make gen_eob take the DISAS_* constant as an argument, so that
> it is not necessary to have wrappers around it.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 60 +++++++++----------------------------
>   1 file changed, 14 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

