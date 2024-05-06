Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F077FC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wk9-0000Wy-6i; Mon, 06 May 2024 07:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3wk7-0000WY-1P
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:42:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3wk5-0000x5-EI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:42:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so962365f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714995767; x=1715600567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PXdB8+QIO6SMSbA2Z9lG3FeNC1/imepdGXxFob/hIKs=;
 b=uoJThCddjYg+alqTL/lB7g7OKSPp3PnIdrbdfLGgVy0MGAasAT3f8boHGXB9jdp9H3
 siHUYF7ZMDZzZC9GX9Ff/B0wUie8WPe0K8mHZDtjmWLZWByz97g1SF9OmWAXAi/hQpE4
 k0zFbfaA1FnzXPuUDj48aLfNtb3cV3SYxDj2rbNUtXAV7HNhKW0MclY5dFHX7RIKGIs1
 HLq1YlPFSp+z/agjQn7s4TMhPg+c/8wc9DX7HNv3nLJulfAxSYoNbwx5Ka3TAJk88fF7
 JbfZMlsADbZgXajRHkTI2wikVK8UR2S7Eg3iX2DwJ/rY2bYMgWdChAXkQeLEkXKdJYG0
 TaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714995767; x=1715600567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXdB8+QIO6SMSbA2Z9lG3FeNC1/imepdGXxFob/hIKs=;
 b=FkzhTZkm+ux7dzZoIdp+DfT0VmAFJOU2Spa8cu063igWJDe6e1v8BvFQ8kTXvsQaCE
 da1X15OZgOwGHYBLdtJ/VEXwx4bTJGVFDQz9e4MZgI61TlkSyredGH8SRzcw5ezaiCEZ
 qIuf4Cxdm3bAYjMWxp9aqRgvlI7maARc5sCMAvbV16DFRUIwj3o1ir5FhhNmgoYgVwUM
 o4Wb0DGlco+x35oScTDc9kxsdNDPdI9eX90h2vxIwJclGZJl34ih9McI2SWpJKFiVjOB
 7IOZZaMsll5L+9LiQf6c3QwvwfYeHdJ29fXpfEhTbhSMiEWM3zKTnMupyg7WZK9ZSgei
 3Mpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCcT7QZjZbTnDr/sFX4I5xP4888xI8CSKtt64bGznQriB1g8aEcyoVoogQhnXibFQ7U5mkIWyW1WNRFdJTQdnhwth7HxQ=
X-Gm-Message-State: AOJu0YxrQ9FC/ngWhQo0A1LbCo2Ut37Pnbb9l+a7a9Jt8C3DMeKx02eK
 bP1gDMlFBvZA0W2HbQETpcUXTcst86Od7CslmzFRbsQLj1kmgKiGxBRKlsLmTdQ=
X-Google-Smtp-Source: AGHT+IHCzkV9WQPZeN0lqJt9qDUM2a/ht5daURp07Z3M7cU3JZpOp5O6Z/T9h79pxhfVnrwtx17AiQ==
X-Received: by 2002:a5d:66c8:0:b0:34d:13c9:eb52 with SMTP id
 k8-20020a5d66c8000000b0034d13c9eb52mr10857175wrw.3.1714995767598; 
 Mon, 06 May 2024 04:42:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 c16-20020adffb10000000b0034f0633e322sm3405545wrr.38.2024.05.06.04.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 04:42:47 -0700 (PDT)
Message-ID: <0a93eda4-6935-42ad-9601-2d6430f4ed8f@linaro.org>
Date: Mon, 6 May 2024 13:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qemu-options: Deprecate "-runas" and introduce
 "-run-with user=..." instead
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240506112058.51446-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506112058.51446-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 6/5/24 13:20, Thomas Huth wrote:
> The old "-runas" option has the disadvantage that it is not visible
> in the QAPI schema, so it is not available via the normal introspection
> mechanisms. We've recently introduced the "-run-with" option for exactly
> this purpose, which is meant to handle the options that affect the
> runtime behavior. Thus let's introduce a "user=..." parameter here now
> and deprecate the old "-runas" option.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Add missing part in qemu-options.hx as suggested by Philippe
> 
>   docs/about/deprecated.rst |  6 ++++++
>   system/vl.c               | 15 +++++++++++++++
>   qemu-options.hx           | 15 +++++++++++----
>   3 files changed, 32 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


