Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58A0C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 11:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt3Fy-0004Bb-Pt; Fri, 14 Mar 2025 07:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tt3Fv-0004BK-EE
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 07:31:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tt3Fp-00061d-Qw
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 07:31:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39127512371so1284316f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741951862; x=1742556662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jVV5h/jIXZqiAgtmio49BLZrORRofLf2ETuk9e3Xg48=;
 b=j5XcK/IbqZxc1J+PNA7kFqFOIlasJts6aLoQm8iVyELS7ipCplNaXSxngRraOOfYu1
 CfMlzYCNLl4G58O0HH+yM8ozDOAJhFe9xeeYmh/ThMHVwbG/vzAcSsWdVXSMkUqar7X4
 fH+bkqv6YIRWLfECGlQJ3x5IRKbZulI1IeGj1+fNjlF7GVdM4XZJRqvyOCoBEfwV2V0m
 Z3vNly7jZOC4jiDUZ8LXLkGnl07lHDOqwGOYiO0JbFscnsUmixLP5MMhLVq+fu1pveUH
 zjeagu+4tfbHT88ysBygK4zWTwCgEaZUtDkkjBENJLz2hwXmh7uRJFTTxbQoODTfp9NO
 ejXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741951862; x=1742556662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jVV5h/jIXZqiAgtmio49BLZrORRofLf2ETuk9e3Xg48=;
 b=uZ/NOKFEDwddcLKgF+QB0W8xcKIWHGe8m56/RDzZRaJx3IG3rwrv5rFuXdgtcdJCIm
 avNYWYDw8F9afzPgUIyW7u6Uf7nrRoJM6hfz5uwlUqyZc1L7nbiD7rT0GLKCZhLvMY8j
 1oRGs23sPSYUJ4AiZHEQaOemHLnqxPea6rrCgT0TGFUWx8eOEIbNYBk5NX3q4S4rsAfJ
 8hrBjdLhh1g30omtN5M0X40dXM+S9v5JIaEh9vqr6wlCIdOpVmq+39/f8BekMTjoY+9I
 8SXjuWp01eNqqK9dDkVgAIrdsDqQVomK6bOyS8fZDhjrbgoKubw8+M0QwIVmpM1u4a1v
 RI+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoQRXqNMCi/LyrrUugKfevzii/o0xFNuSq9vxSRPYPMZicuvuKYblhc0a5ccZecHNwVYCr0sWlNbNn@nongnu.org
X-Gm-Message-State: AOJu0YwJTHd1IuGs6bgHp/PJ/rS2VuhIuInQpV40NAVmViVgwg+hhbgA
 k28kHsednSi4fkuVycuxSVSjK1gg6oUiCnZkOcdxARlErSZSh1/lEBS+uzCJbRw=
X-Gm-Gg: ASbGnctNm2Nz3/NzPfVhSYvrSGZJRlfI4969C24YmxiBEud/DSExCOVMijuJqEyYzrd
 aRVn8v7hCdZPb4uKR1giPFk9jl7/cshnRThX0SnpR+cdAEFsXLYPvtJEPSm1QxqxvjH5lZDJ/H0
 2XgCKjmjt4W6pFIqfMGeYiDK1npu986jTkITqF5kSWuHzI5mMf3blXAXGhNSCNEg/uj0nfJ7y0C
 gH59+AMoicvAziUGQffhi+0uz0kim++ZmUpjijOhe39zIxV6R3dmAe4yPnH0D9Makb88MPne5LZ
 O4sqXCQMTdXCReeFWjEGVoEWcb2KUWpYzGPatRpa57NHutD9Jw0HzKXFKM135gK5mmfikIM+DBN
 WwuTe8e6uwQ==
X-Google-Smtp-Source: AGHT+IFb6+IosAp12yJSCusTD1PDftgKmyuXg2/YUhZvzt81dx0KZzuM4J6GJD0l5unXtc6doCjfog==
X-Received: by 2002:a5d:6d02:0:b0:391:2b04:73d9 with SMTP id
 ffacd0b85a97d-3971f511669mr2612208f8f.49.1741951862527; 
 Fri, 14 Mar 2025 04:31:02 -0700 (PDT)
Received: from [192.168.1.67] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdd0sm5250362f8f.77.2025.03.14.04.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 04:31:02 -0700 (PDT)
Message-ID: <aab4da63-071e-4e2a-a9eb-4847b7b42d7b@linaro.org>
Date: Fri, 14 Mar 2025 12:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/loongarch: Fix error handling of KVM
 feature checks
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250314084201.4182054-1-maobibo@loongson.cn>
 <20250314084201.4182054-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314084201.4182054-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 14/3/25 09:41, Bibo Mao wrote:
> For some paravirt KVM features, if user forces to enable it however
> KVM does not support, qemu should fail to run and exit immediately,
> rather than continue to run. Here set error message and return directly
> in function kvm_arch_init_vcpu().
> 
> Fixes: 6edd2a9bec90 (target/loongarch/kvm: Implement LoongArch PMU extension)
> Fixes: 936c3f4d7916 (target/loongarch: Use auto method with LSX feature)
> Fixes: 5e360dabedb1 (target/loongarch: Use auto method with LASX feature)
> Fixes: 620d9bd0022e (target/loongarch: Add paravirt ipi feature detection)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>   target/loongarch/kvm/kvm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


