Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD2FC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4ob-0004yw-7T; Fri, 31 May 2024 12:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sD4oY-0004ye-OB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:09:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sD4oX-0007Dg-2u
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:09:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-421338c4c3bso2970025e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717171747; x=1717776547; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZJociJhkICwIha+lzG1XPDXZhY/g4ozjgsEbhq1UJcU=;
 b=LFCafKyWTDuHuyupzk+dHVepyscENh1RXbSwsse460zck8oSjZs88ObGOzUQbOXpg8
 tznke7ibj5J8DOsYeQ+fy326PAYDwgU+RcAMhQ3oaJU1t7EztzFkCIgPFFud7CPcrIE+
 WDmCjYvSJYmxjJwktKLGn7fc2CNOCARETg0E2Fs3u2Pi4i1B6rfArPtBi9LebXrybJ8Z
 jcyUhkXMUsETljhK5PrcU8uSlJ4aK0QHiJxUARYjy/oH12+pb1SKMMAa04pIfiisK4t8
 ajNH2w0U6YObUPOORXEoKMSQhr0tmXE7A5gThYYFcai1IGaDLL8YD4HmU6owUAoqzMH0
 s1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717171747; x=1717776547;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJociJhkICwIha+lzG1XPDXZhY/g4ozjgsEbhq1UJcU=;
 b=IX5DV4UmFnHFd24fTxDQGG8+Rr7w1+MqIS3X3b1KZ+bQ5eaVisOZtUqGhDPfZN1xV4
 6tv9SDY2rBZo1ES1IA7YAzghnCQv6go8iw4pUp8fKQNvILC0HC3W+soZd+Ka+hGWGyyy
 r1nS5N9ZI2RdjV990JFOwBzDtjfwgNyLELMW8Uq06acKg3YaRadEqHt6ds3NKI/zLTC3
 TWeOnWoARgp8J5x1s3VSxU9vfSAnEekoDJew1PHkqQg8Q8vdlBCfR2oqKKKVJ/SqtWEZ
 ZvO5Yq3Dq+Sk0N1O+484llZLYecdPhvdMMiR5AJDzz8rNHRWwqkIac0vyVCd0peObm0/
 n0GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV40+bE7yIF9RZE/0GRbj1Ei0CE3glFnRrzzVRCPCwvAUTSLOSZOQkp9veKatEruG3PoZUbw7TyTwzJ4EIhXL7TdAgF6jA=
X-Gm-Message-State: AOJu0Yz9a0ekPKLMep+Du72TDKRIhrZUUYdrZmvQczjCyndPzU3XSOXZ
 cXdlKFlfGlr72P/lHQxlr/NPx3uVIaGQRaKGwnHBnGVWq5F8e/AfXpgtOjNAuCM=
X-Google-Smtp-Source: AGHT+IGIjSVNvQ7U4tD8Stg1MRdEH+C/Tfk87QRPbl1AOyZ0Rl0tnADnZPAMdL3NiOHGI/fyV2s/OA==
X-Received: by 2002:a05:600c:444e:b0:420:f8a2:f2eb with SMTP id
 5b1f17b1804b1-4212e061c6bmr20956285e9.19.1717171747216; 
 Fri, 31 May 2024 09:09:07 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b858424sm29918925e9.21.2024.05.31.09.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:09:06 -0700 (PDT)
Date: Fri, 31 May 2024 17:09:21 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240531160921.GA217456@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <CAFEAcA-gye9B1yJNKyT0fcZzR7TukNvaQyc7QkKQ_1FUGfAaYw@mail.gmail.com>
 <20240531102135.GA40178@myrica>
 <E5197AF2-EEB3-4568-9F25-78622AD41AE4@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E5197AF2-EEB3-4568-9F25-78622AD41AE4@linux.dev>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
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

On Fri, May 31, 2024 at 11:16:30PM +0900, Itaru Kitayama wrote:
> Thanks! I wasn’t aware of it The good news is that after whole day of try and error attempts I was able to
> bring up a Realm VM on FVP. Here’s my version of overlay yaml, cca-v2.yaml:

That is good news, thanks for the update

> build:
>   linux:
>     repo:
>       revision: cca-full/v2
> 
> #  kvmtool:
> #    repo:
> #      revision: cca/v2
> 
>   rmm:
>     repo:
>       revision: main
> 
> 
> 
>   tfa:
>     repo:
>       revision: master
> 
>   kvm-unit-tests:
>     repo:
>       revision: cca/v2
> 
> … and the QEMU options are below:
> 
> qemu-system-aarch64 -M 'virt,acpi=off,gic-version=3' \
> -cpu host -enable-kvm -smp 2 -m 512M -overcommit 'mem-lock=on' \
> -M 'confidential-guest-support=rme0' \
> -object 'rme-guest,id=rme0,measurement-algo=sha512,num-pmu-counters=6,sve-vector-length=256' \
> -kernel Image -initrd rootfs.cpio \
> -append 'earycon console=ttyAMA0 rdinit=/sbin/init' -nographic -net none

Note that the cca/v2 branch of QEMU would reject 'num-pmu-counters' and
'sve-vector-length' arguments, so if this works it means an older version
of the QEMU patches is being used (which also means an older Linux branch
is being used). It's possible that shrinkwrap is caching all the build
files, so I'd remove the ~/.shrinkwrap/ files to start fresh

Thanks,
Jean


