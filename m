Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3701CC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogZz-0003Mb-UX; Mon, 25 Mar 2024 05:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogZy-0003LP-Ik
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:25:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogZw-0004RF-UU
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:25:18 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3416df43cabso2881566f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711358714; x=1711963514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zTmiC1zHYeAByMOWD8l4KePRkRuyiY3CsB5A3iN8t4c=;
 b=xZld0j1B1KGfTDSFIN2mT+nhslEqdtQHzdosS3A1eqJmSt81Cg6yaSk61V1qACN9OU
 hc+jzYG13roRBY6/JIUsA7O5S8KLreguMWUtYb21dc2MFvVvP1J6iGa5x2u+8A+WrL02
 yuHOKHl+fKPNZNkuZZgLfVB3dBfCwiA6H9/fZo1epyDlq+/SvdecAgBrmXjs+7lcjRbp
 wn5WPnMyggVVNHLN8snrNBtTpdEfNt38OuIuSzO44QnZtn6YsIeS3VxBdnZcxY/lt++t
 SWsJh0hYho+Cd+aNtET89T0WRQP8FYKbs4Qp6Ew8Mm2yBJwfM1KUTVtqthqHSLpqM1w8
 yeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711358714; x=1711963514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zTmiC1zHYeAByMOWD8l4KePRkRuyiY3CsB5A3iN8t4c=;
 b=b4gFdCMqhaw+3c1NfAAuBlzAQqAxPMBpfZR2tjUnLvhtapFw4g0oy9vKp7lvpMVJL5
 kQk5eR+qPgCEQdQZpNkci2BDbIMmetY5gmVDCFQEhNJR79c7Pb9ksdl1wG31IDCOs4JY
 QxOe2H9Is2BpGWodCUqErTr7Vu/lAfTJ4myl1H3KvL2I75JAOztnA5MZPQ2Z2PoKoajg
 bKZ3c/27j9drRlchiZwrd52xc6JOALRUkl2gbp1MOJM2Ph2ZCMs08kfm3GYnM5j14IYk
 9mba96HCpMZP8LLD0gK2zW8L3JyzIOHPjJJHT69gnXAKlXENYRb0INrUWKC3ym8WEKhT
 t5oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR291LVMgjl/W7lmzt6B1bzGYZOOahDXjy0uGAohESA7Z3OXX04jd7hwV3izo0cjvE61MsPHjnJkpnYLXGK4228DZj9/4=
X-Gm-Message-State: AOJu0YxIvqGBDwtjF03Hd6Dk04xFGaDB9VfW4PatMT0SjIxK4FUyKRXI
 vKrsjd2Eqqt+R3/iepBIU+GXdb0sAzAHjgMBMGdIGQBrDl11JyWqgnxEr2RcLrEm4SGZxiSqaDk
 qe3M=
X-Google-Smtp-Source: AGHT+IGNuRRHv3328CL/Td9AKjx3q3ooMgJ9IMPiOxriKTUV/PbiyyxpnOXAOsoGlKg9QHSgHLsT3g==
X-Received: by 2002:a05:6000:54f:b0:33e:7f51:c2f8 with SMTP id
 b15-20020a056000054f00b0033e7f51c2f8mr3984422wrf.36.1711358714400; 
 Mon, 25 Mar 2024 02:25:14 -0700 (PDT)
Received: from [192.168.163.175] (237.red-88-29-182.dynamicip.rima-tde.net.
 [88.29.182.237]) by smtp.gmail.com with ESMTPSA id
 ch9-20020a5d5d09000000b00341c6778171sm4614864wrb.83.2024.03.25.02.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:25:14 -0700 (PDT)
Message-ID: <e18687dd-b44e-4436-aaaa-b4f40251bafd@linaro.org>
Date: Mon, 25 Mar 2024 10:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] KVM: track whether guest state is encrypted
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-13-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322181116.1228416-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/3/24 19:11, Paolo Bonzini wrote:
> So far, KVM has allowed KVM_GET/SET_* ioctls to execute even if the
> guest state is encrypted, in which case they do nothing.  For the new
> API using VM types, instead, the ioctls will fail which is a safer and
> more robust approach.
> 
> The new API will be the only one available for SEV-SNP and TDX, but it
> is also usable for SEV and SEV-ES.  In preparation for that, require
> architecture-specific KVM code to communicate the point at which guest
> state is protected (which must be after kvm_cpu_synchronize_post_init(),
> though that might change in the future in order to suppor migration).
>  From that point, skip reading registers so that cpu->vcpu_dirty is
> never true: if it ever becomes true, kvm_arch_put_registers() will
> fail miserably.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/sysemu/kvm.h     |  2 ++
>   include/sysemu/kvm_int.h |  1 +
>   accel/kvm/kvm-all.c      | 14 ++++++++++++--
>   target/i386/sev.c        |  1 +
>   4 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


