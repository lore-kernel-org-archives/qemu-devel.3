Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77583CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsD8-0002dC-AV; Mon, 08 Apr 2024 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsD7-0002cR-1n
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:51:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsCy-00031C-Ei
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:51:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e244c7cbf8so39339575ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712595059; x=1713199859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eClix6fDP0lidmrjsIFLPsO0szwdHOKGoqRzNuFadXk=;
 b=Xsh6ozrD4eg7G7SCHFywGgXqeFMZmk1BaR7J+GxDq/uFTdaVvqqpiZNmndDbBclIwg
 UlzKb/8KBDNX2oWnJkvJx0k8XGHXvmYChQbzF7zAoIinnVNnSUH8DDZ+kPa0bPojG2E3
 OKmieBAp9u+v7H9o4OpyJsg/ZHYjCW620S1Hi7Onigg/PYpnJxy9As34wjJdJjk9CFst
 tvHy15gyliRDGTgb7quqTXygJ2i2qy1+/v+8uvMbIHR47sIbB0JXY9GkBm6FDFJgWplt
 CJyOQnzGtN/Ei7+anPdWRXwmHXvb82DdgVaJPk1uRCum8hhA2VtRONFS9/QylJOafEcB
 BNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712595059; x=1713199859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eClix6fDP0lidmrjsIFLPsO0szwdHOKGoqRzNuFadXk=;
 b=mFXrN1RbUQNDAZkYXdMBhiElJNchUcE2Dj0wn/orKDO5WTnY4/qKKD4MLP/TxLbMQP
 l3BTgMgVX3XQFlHZVYECa6hX1IMW6zYHrNQvoCb0HMKgTZmFAO60YBB0FlDoN+d50QEF
 xQX4aS447hKD6xP+pcn2ppXYB2tNEOdV5vHWJX6ApGxdmtG0qAPFIoOWIpbsTREfRFmV
 8LmvQfOeqHTvTNt5D7pxTOt+rbvJdHjzrMZWDNFak/aVjzy0enAxJCVvHeq4+/pZpsrg
 ybjejozCmPMNigPfYPs/XlaDGnKKSXg+cMyiBmrErz3udl+xq3Z5liuQJGvDb4Yuw4FY
 z9Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDgJOD7MjkpfZGsf6xK9ij/borocS6XxAQxMps8dyGK2aAkUMjJsC3dHh+FEt+BtaF7bAG0i2hhfymRG5M/bEbeJuNM/Q=
X-Gm-Message-State: AOJu0Yw34ElsG5n40b8TfIlXaRpuVEKArxnKv+2MW6d+j4YS22fTPUs9
 cDQm6/ilGS3wTdvzOUWHx2K46gHi3GqRouobVgxnCVvhD6VhCwvRt7ypDqzzGv3C9gHXI8Ct1Lu
 7
X-Google-Smtp-Source: AGHT+IFDn1nyTVBQZYFzwvy/7ZLg1Wn0RaQkb2k7sEvyyIt54L8ltUkyZATJtMxnsiEzFm1chhHrVA==
X-Received: by 2002:a17:902:f70a:b0:1e3:c610:597d with SMTP id
 h10-20020a170902f70a00b001e3c610597dmr9623088plo.60.1712595058700; 
 Mon, 08 Apr 2024 09:50:58 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lh8-20020a170903290800b001e4344a7601sm2106267plb.42.2024.04.08.09.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:50:57 -0700 (PDT)
Message-ID: <59aee69b-3906-4140-9056-996ca43c58f4@linaro.org>
Date: Mon, 8 Apr 2024 06:50:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] ramfb: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Since the ramfb stubs are needed exactly when the Kconfig symbols are not
> needed, move them to hw/display/ and compile them when ramfb.c is absent.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   stubs/ramfb.c => hw/display/ramfb-stubs.c | 0
>   hw/display/meson.build                    | 2 +-
>   stubs/meson.build                         | 1 -
>   3 files changed, 1 insertion(+), 2 deletions(-)
>   rename stubs/ramfb.c => hw/display/ramfb-stubs.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

