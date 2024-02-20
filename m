Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BEDC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTUw-0000hg-SW; Tue, 20 Feb 2024 12:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcTUt-0000bq-Kc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcTUr-0006SY-83
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708448492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t3gi63HKD4tZ/vK2HVX61Np9VUvJ8LOzkFMNQ9xObNc=;
 b=S9jsKh9UfDnaO/dtxaueKIIzyR+7sHpUL86HdFR2pU12LE7weFSaRZtZ1KzVqhVE9d6LUm
 6m074pmZuWo4vru9NqnBqeyoImHnokOoWORjrrlI7DHMBFU44/Sc75PF9/8yZ4hMvjb+SX
 1Prhaym5JLZlAu7L8TGS6AkKvK4hAmw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-QSm79QepNZCX3RnUkS6Ayw-1; Tue, 20 Feb 2024 12:01:30 -0500
X-MC-Unique: QSm79QepNZCX3RnUkS6Ayw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a00a4a9986so408904eaf.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708448489; x=1709053289;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3gi63HKD4tZ/vK2HVX61Np9VUvJ8LOzkFMNQ9xObNc=;
 b=fej8nTQWlxGWDIJ5pFzFMHrGR1wucBilk4HYMkFzgyL2zVrBq2bATaKSxe8brmynnD
 PnRWQK6yflIy9BiOOJcatlQvC+LQMZ+NY3D2ECeghdC3u90BvqZA+Bz2pRolWt+8D75y
 gPDDicEye0SVYO+kE2YJbB40nNjmZAr8/eewRz6roLfnkTYQqCs6V+SKE13I27k1X2IJ
 Kuzca2KQFLv0kYFN8NIUXXKQc8xGaKaZ9mroEe3Xy+C4RDn00jAvqRWaqyh/Z6iEDAwz
 JZuSGiFqBqZ2odTqnYddz8IANy/0meSy/ybMzA4ZvQNa0MruBm38ClKOhSBrgWgm5TvM
 qDkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU44VelUZge6pxe4pbSnnnB4RYAoUIK/fiaSuBYN2PRKZiYBUHAL5GlEVJxaBYsvoFWPUBlfbHsTd9e5/tLwbrwxaYzDI=
X-Gm-Message-State: AOJu0YwRzYGLR27563vm8KlD/eitaYu/V7zh0ulSzm2LadKH8V5cuNAd
 ULNDu/6C74iIlN5gGBGsDiYRlydLaanfQyWhlL4+wFjV0GnRIGFtipHhhk2FTOX4OBcyHj9poGh
 yjAjqXcDp/LrAtqEwJdvUzjFa+8kuWJurFslfxny9+lwnQB95J2cz
X-Received: by 2002:a05:6358:109d:b0:176:7f72:36af with SMTP id
 j29-20020a056358109d00b001767f7236afmr17284375rwi.23.1708448489490; 
 Tue, 20 Feb 2024 09:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/a4V7svHqbpgjmbUtAYdTR2cjEFxgF/NlT9HzWsPkgB38+d4kI+60gyDqQObe6fEd+7GZbg==
X-Received: by 2002:a05:6358:109d:b0:176:7f72:36af with SMTP id
 j29-20020a056358109d00b001767f7236afmr17284340rwi.23.1708448489074; 
 Tue, 20 Feb 2024 09:01:29 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 c21-20020ac853d5000000b0042e1950d591sm1491752qtq.70.2024.02.20.09.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 09:01:28 -0800 (PST)
Message-ID: <0726d0f4-ded9-4f9b-92d8-611aefb71762@redhat.com>
Date: Tue, 20 Feb 2024 18:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Drop msys2-32bit job
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
References: <20240220165602.135695-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240220165602.135695-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/02/2024 17.56, Peter Maydell wrote:
> MSYS2 is dropping support for 32-bit Windows.  This shows up for us
> as various packages we were using in our CI job no longer being
> available to install, which causes the job to fail.  In commit
> 8e31b744fdf we dropped the dependency on libusb and spice, but the
> dtc package has also now been removed.
> 
> For us as QEMU upstream, "32 bit x86 hosts for system emulation" have
> already been deprecated as of QEMU 8.0, so we are ready to drop them
> anyway.
> 
> Drop the msys2-32bit CI job, as the first step in doing this.
> 
> This is cc'd to stable, because this job will also be broken for CI
> on the stable branches.  We can't drop 32-bit support entirely there,
> but we will still be covering at least compilation for 32-bit Windows
> via the cross-win32-system job.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Minimal patch that disables CI, for ease of backporting.
> ---
>   .gitlab-ci.d/windows.yml | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 5c1e385dc89..8fc08218d28 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -131,12 +131,3 @@ msys2-64bit:
>       # qTests don't run successfully with "--without-default-devices",
>       # so let's exclude the qtests from CI for now.
>       TEST_ARGS: --no-suite qtest
> -
> -msys2-32bit:
> -  extends: .shared_msys2_builder
> -  variables:
> -    MINGW_TARGET: mingw-w64-i686
> -    MSYSTEM: MINGW32
> -    EXTRA_PACKAGES:
> -    CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
> -    TEST_ARGS: --no-suite qtest

We could maybe merge .shared_msys2_builder with the msys2-64bit job now that 
we only have one Windows-based job left ... but that's maybe also rather 
something for another patch, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


