Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1131C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ntL-0001oy-Nu; Tue, 14 May 2024 04:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6ntC-0001my-6D
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:52:03 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6nt9-0007Ni-PD
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:52:01 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a5a2d0d8644so1126829366b.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715676717; x=1716281517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85d7B7c0luBfnGNwBgTvYISUTQTfRSZdLkMTn3PSzHA=;
 b=QMfucQTFd9uGGT11epVKRC5HRfZTdOXwwiDJ+E6Pto9miJTQO0gDH2Hd6mVQXIaFDW
 yZ3IZ9VYG0Hp7wRP1DgAs91Gb5xuPCpJVx/VXBKRQmaCHUMX2LYlzAa3fNhBYdfyMO5l
 HUImKGiSZ7a7q9XMmB0mEAE3KqwUCRKa8kMi7nXV/1ab35GjJihSxwSUScEhkTkt/78R
 epZCu4+zwS/sSUo/lszTqq1SFqZEkpr/HGuySjcS/6unwXAarpZFmSkMNrzsDN9pExDb
 a4ycAwayC2IBqVtW1cqsyEOnymnxeGt/RDwMwZhbOPrUxV5MUHLxDOuQtBrSJXkC0339
 D1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715676717; x=1716281517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85d7B7c0luBfnGNwBgTvYISUTQTfRSZdLkMTn3PSzHA=;
 b=nMQphNF49JyTJavD9U6WHhI0sfXAdz2x+rtY1SMWUPtNEjLFJ3CR9L0wm/IeYPVyfh
 v1X2HrEXBBBwdR77I+PKQhEGGFA4NBY5t0FEcgzyvn7Fzyqx6sDKZseofwbhDuv9Ij+5
 /ssc6QCwNdveAoaza/fFQOjy8Tva93hN0Rf/2uGELikyf1j5rnZ11r618ykuzwZ64Oxn
 hiRz53rPyUqx9DBGvAfhylAG7HR+J04OmdAEFqvAFRS6l8D0ktNmFGJ/i5xxgBmwMPiy
 M4sTTPPubrdF7BYsyiXrNGrseevhn2fuyPU/fvLSxdGy9PuDSI+/KDwztbEnr4AEK0Dm
 dZZQ==
X-Gm-Message-State: AOJu0Yy/fIXhbnyVWFGxxG6p4lwjzqwET1BK7pRNRNye7M7wkLGx06W4
 qe0oIj4oFQl4GF5mtJ5d6ljbYQUjV4L9tl4ghtW5vERWmiw6AX79LJl7QHGXhJxPqM+79uzQ+Mk
 1YCY=
X-Google-Smtp-Source: AGHT+IF9w7FcaIr7pojzTHnSErPn2Q+4AKpncGqXuncnBUjHXmRRK58044rNkWU5NWq6k0PONcGCMw==
X-Received: by 2002:a50:8711:0:b0:572:a06e:e3ff with SMTP id
 4fb4d7f45d1cf-5734d6de9cdmr8546946a12.41.1715676717677; 
 Tue, 14 May 2024 01:51:57 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c322c3csm7283623a12.83.2024.05.14.01.51.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 01:51:57 -0700 (PDT)
Message-ID: <ee6df079-d009-462c-9b58-dd2fa1b2c6c4@linaro.org>
Date: Tue, 14 May 2024 10:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/27] Build/arch cleanups, target/i386 fixes for 2024-05-10
To: qemu-devel@nongnu.org
References: <20240512104945.130198-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 5/12/24 12:49, Paolo Bonzini wrote:
> The following changes since commit dafec285bdbfe415ac6823abdc510e0b92c3f094:
> 
>    Merge tag 'pull-request-2024-05-10' ofhttps://gitlab.com/thuth/qemu  into staging (2024-05-10 09:41:35 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 9b089d254a5623baef01f7d0ec37331c1155f1ce:
> 
>    configs: disable emulators that require it if libfdt is not found (2024-05-10 15:45:15 +0200)
> 
> ----------------------------------------------------------------
> * target/i386: miscellaneous changes, mostly TCG-related
> * fix --without-default-devices build
> * fix --without-default-devices qtests on s390x and arm

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


