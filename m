Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGMu-0003WO-4K; Tue, 23 Apr 2024 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGMr-0003No-7Q
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:39:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGMo-0006Hy-OX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:39:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34af8b880e8so1422118f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879564; x=1714484364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRmlVrAbXm9MsfLg3NdIT0gvkeeUTybe4C8JM+d+i68=;
 b=q6JO8myZVjSJdWPzJzGQJxSjkxcXaT8bcKBh2q/IZ9XZEJPLoUOl3g1lv0wdEZ+xmt
 4De6S46b/wTxCOU/SecYg8Rl2zPg7JWMTgtGxij6OdiFWVYl/XuWBJqn++sAgJqEikJN
 a8NJZYCBpeTTYxUMKI2K9om5PXo5B+CAn62YLMuF2uZCcvbiUJC4ja4hEjOdje0uD78L
 Z3LK1EFvIR8zzRxwlZjjlecaQyjLa7aF8CLirF88jZp4KxieDIW9AVPBuE9pBUD8FqAi
 rFSP3xaq7L2LcGMmh5kHeUbcShA+cyzow/aL7pxmJBm0yak2xOOWPaF2pVmFc+fWJvZG
 ozNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879564; x=1714484364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRmlVrAbXm9MsfLg3NdIT0gvkeeUTybe4C8JM+d+i68=;
 b=YD4HBKan2u4VmuDKFMpnby04b86yNq/sbV3f+tKt0GtK5wZHtLY4+X4eFqAiZ+D5Xc
 Q6WzXOJEKOJPqJlSTmqqysxpN82k3q0ZVy7FxVyrUeOTk6HvbDiShDBKdtyjoq9s9Ylc
 iHrSYhvpS3Cv9YChvX3UbWkowbbHO+DNBarILSVhiIKk5czkQY0qNTKu3Sb0j41r5+1J
 T23kyzz+V9fM716PViKFllvgVJ8Lg5oMgjy3Cg8a/2F7HeQN3xbuSh7kbZkcXH5lW+Ep
 SlUIZeZrSEmef3/u4TsGmowNoXu0efTNENYvkz5YQqrDJUQEb1WBNqD4qbe5wDRMrUG6
 D2RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9sRn1xnJIN2o3e0CshlacsezYEwxW14Mok4bp2QeN7kvuCJOgE0iVV8JbCQYHvm68t/KoOMKBIB3YGeTLcW2Hdyimvis=
X-Gm-Message-State: AOJu0YzQrwn84Ynb8fA4fMwJvjNRiZRLhfGMBra7Tu4Yb0Rvd/Oc+D42
 PnMzj7Yqm9GT0veaQ8s4ziD1F2zdi67Ux5AOxmMtdcWwKIdfoMIJTSIeQImRIb0=
X-Google-Smtp-Source: AGHT+IH2+O0atvYD42dWclkpYSAAk905+Ihyo4lfs1oPNJ2j47Z/w7fwrORjAM7lFeswEyW6ArhQzw==
X-Received: by 2002:a5d:4b03:0:b0:341:b5ca:9e9c with SMTP id
 v3-20020a5d4b03000000b00341b5ca9e9cmr1590837wrq.25.1713879564244; 
 Tue, 23 Apr 2024 06:39:24 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 l6-20020adfa386000000b00349e2fab2a2sm14828610wrb.12.2024.04.23.06.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:39:23 -0700 (PDT)
Message-ID: <e672c7be-7262-43ae-a4d8-f158b9f157a5@linaro.org>
Date: Tue, 23 Apr 2024 15:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] loongarch: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-9-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-9-pbonzini@redhat.com>
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

On 23/4/24 15:15, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with Loongarch.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/loongarch64-softmmu/default.mak | 3 ++-
>   hw/loongarch/Kconfig                            | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


