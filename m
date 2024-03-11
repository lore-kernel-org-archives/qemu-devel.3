Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05CDC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlr1-0002lS-35; Mon, 11 Mar 2024 16:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjlqo-0002US-Oq
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:02:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjlqm-00016V-Ec
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:02:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33e6aca1ca9so4590509f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710187339; x=1710792139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ruTEjpvZ+xyIIVSLQflUQm/xr4ydkgbbQvvEsU2xJRA=;
 b=ttQnyRVgyO2H2E1v1qtxuXoKFPZATS1Xx00ORQ86Osqb1UxtMJw5yV2I4lTcOWc2bv
 0lCeP8+GvzOVTVEvRLpseUSkVEZ+6nxrVOFj1IxnWWoLccE5cXNWWu8P0B19WVhgkrd7
 nqtvEl04TthBvybDqPBEsbP6Oj/9F4uGLFXi/+HbkTvcgqzxD+AkXPDJQaR5o+q4cJ3H
 caF0wnxwdex3SOwlfyb8LUsJUDUZWce/2kerubIGj9+lnekh7YsgxkyvpzQU4KFSGEGC
 KRUG4rfImpEIFZZJHNp+XvXmnHSmsKueGEwVawbg4ytWz97l8k/qjFnv4MoUJjoGe7wF
 ki4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187339; x=1710792139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ruTEjpvZ+xyIIVSLQflUQm/xr4ydkgbbQvvEsU2xJRA=;
 b=r8Xpsoa2DYAQcAK5kWuwmy3CGdyA1tT39MGZMHhmNcvlFeA7p1XBSuMTigQ5CIK1Us
 SWNlq2bhDUlcCRkizsswdkL19j195Yz0P3Db2Ttuqx4O+WkN2KslbvmubqvFOV/ITVEh
 u+6aC5H7WDy0KY6oGfzkQoS3oeMtNwG0qD5404Fm6mUnShNIHbnuo4RucrJWsnTSO6l2
 6BrzjplGDSKSQrm/SxHKbFLdn82uEjUz5n/33kHfRB+Qv60VZfav4OXLe56h9ojhln1K
 fJmrOKzUPJL3MD9l//rL5D9v7lF3F57FvvDHFz7cQYkcYY0OJUSntndPBAJ6yZsgz9jD
 Dngw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Y2qCV2L3/AL21+tB7CIMT4lnUUvb27HKP8vfE9duYia6jIjUtCp+i2fpr9f5ye/bKNi9o7M1XB8jCSunIfbxEUcvm/s=
X-Gm-Message-State: AOJu0YzuFR4eKRPtwKud+snYMUn4XfV9JVXHGsEKQRezoyNRjs8Jzw9g
 pT3ksEmqL9Qz+Swq1YwypayGhpRR28KKj52ThmHwXzmiAkxejceNJkqFNi9aHgs=
X-Google-Smtp-Source: AGHT+IGbvWcwIb92GTHEXaJCcsB2ogji+yQl/wlKujArGnfRMTL11X1jMYpHygvzvoMvAk+K12aJ2A==
X-Received: by 2002:adf:e40d:0:b0:33e:66d8:95c1 with SMTP id
 g13-20020adfe40d000000b0033e66d895c1mr5279948wrm.25.1710187338781; 
 Mon, 11 Mar 2024 13:02:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d59c9000000b0033e22a7b3f8sm7044891wry.75.2024.03.11.13.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 13:02:18 -0700 (PDT)
Message-ID: <351a73eb-1a4a-466d-bbbe-8edadff40324@linaro.org>
Date: Mon, 11 Mar 2024 21:02:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/1] pci hotplug tracking
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240301154146.761531-1-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240301154146.761531-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/3/24 16:41, Vladimir Sementsov-Ogievskiy wrote:
> v9: I was convinced, that adding new qapi interfaces here is
> questionable. So, to conclude, let's still add two convenient
> trace-points, which may help to debug hotplug problems.
> 
> Vladimir Sementsov-Ogievskiy (1):
>    hw: add some convenient trace-events for pcie and shpc hotplug

Merged as commit 61586c4172.

