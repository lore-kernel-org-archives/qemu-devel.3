Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B96C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxbW-0002k2-8Q; Tue, 27 May 2025 12:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxbP-0002jS-O0
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:56:35 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxbL-0005eg-Ti
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:56:35 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af6a315b491so2787245a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748364989; x=1748969789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9HoMnGcyPMc7FqxPyJYTk8MFInNqFKxibyqB/7yjpP0=;
 b=sgzOF7CCpP52OM/lBe+OqQr0GNuHRXGBk2PjzbrG+FC5luMb5g0bzBFx/YGx8v52NV
 g4Iyyixd39bLAg31hYtIvlUpcQj+Yj7GGKNkggz223zZBdSEVOUSu0xpI8unUA1gkS1X
 FGdgJmJxrkPTisEe/bJr8WcR/JEghLIPTHaVR4Z8+rnjKIqgL8YBAUxQ07jb3caMb7Jb
 QOeULipeC702vwIkH8TlMsSBvLYuXkpN3lN2eM93a5vE4q5EL6IxdA+OjXynKKkIWrB/
 CD4ai0/OHNI+TfnOI2vWZuoBiyAAGOZSAcZ+DEFWlk8kMGzD6KZRGOMBi9XYvlswMaDn
 oSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748364989; x=1748969789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9HoMnGcyPMc7FqxPyJYTk8MFInNqFKxibyqB/7yjpP0=;
 b=t1t0nFWXBt4I3wOEHOSlk7ISMSxib1TiK/wDuWtitGgmeF+UkLpqw+3EnacKr6VlKF
 +fyTOFLJKrmF0xOnk5tV0EUB7KCDEo+ALo5yszRJGxCHmCnhQzeCeaxL88JPk4J3s1Bd
 wsFCLrnqmJcMUPKltePoMRuaDd+l+EuvBOxEsuFeNHMiPe8Q1zjiLeB1Zv1ArrlXrUnA
 7Xn0beTj/wXTvKy+ZaI/O+yxEPcHBL9KpBvz6RPEOIEu/88DCSDgXso3IDYKy41GHXfx
 wAL3jTPubW6Fw0ANn/vrkQBmayvWwHvolITMgiRsxON9h2RGdXwMBRBdperI48ZlRY/A
 kZ/Q==
X-Gm-Message-State: AOJu0YyL887ypLPZodQnPunvWAgZ1yWzcN9uXjuyfXlLwx+KNMVUguxS
 AfGPgz7bYX0aeKYXHiMS+ZuyVcKh32c5BB2QBC5Kxbh+KssOj+u6doQ5vv5Mk7BMZcg=
X-Gm-Gg: ASbGncshb2gRNCx8pPCPNOf/uT4n0z3pugDlIZgQkRphWRz2lilA4huRACRwf41mHej
 r41HANwPh9cLJzrToYq+DaH8mZjCJ4dMoYLmcT7ff2G6QkKdRCg2XwtMcE1RtyHm4PqjrOb3p1T
 AxCl5Jz6cFeHkEm43Ic//hyHuE1MPT2++MCnXDwIGG11rcwbAIxzjVow1cxK9R8wUSks/hWoviv
 u1SK5RbjyRJIQ1K3eVM2facfnN6+JdmfTw3H2vbjeVEoeJ+T4rgrMereFU4ECgekSjr03Vcb0vq
 g8cHZXthm8uHPCRoeM9kgXNw2S86GY1CUXI5gQFXkY45E639nBGzUY/dZ3GFLBsCG46qVCkMCwM
 =
X-Google-Smtp-Source: AGHT+IFXDZhN1y7g7tDqkfDiJKKH4JuunQvffx1/U/KLVYQH7uDj6O7/1/KAcfd4BuIpeQ/ndRB+8w==
X-Received: by 2002:a17:90b:4b06:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-3110f328a38mr18648441a91.19.1748364989032; 
 Tue, 27 May 2025 09:56:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3119c837344sm2448418a91.45.2025.05.27.09.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 09:56:28 -0700 (PDT)
Message-ID: <47dae9a0-1a32-4d07-ba2c-1b777d21cad3@linaro.org>
Date: Tue, 27 May 2025 09:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] qapi: make most CPU commands unconditionally
 available
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-10-pierrick.bouvier@linaro.org>
 <875xhmqo5d.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <875xhmqo5d.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/27/25 4:38 AM, Markus Armbruster wrote:
> You took authorship from Daniel.  Intentional?
> 
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> This removes the TARGET_* conditions from all the CPU commands
>> that are conceptually target independent. Top level stubs are
>> provided to cope with targets which do not currently implement
>> all of the commands. Adjust the doc comments accordingly.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 

Not intentional. As said in v3, I did a mistake and squashed this 
commit, so I re-extracted it during an interactive rebase, "stealing" 
the authorship along the way. You're welcome to change that back under 
Daniel's name.

Thanks,
Pierrick

