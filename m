Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9ACC3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3nI-0002Ug-By; Thu, 08 May 2025 12:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD3nF-0002UV-WF
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uD3nE-0006jo-Bm
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746720494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DCgHBpF4pW8RkW/ksATuKMY870mEGDmPAa1Rk6eyyNM=;
 b=TnQmP3Erw1qnJ4HvUtDotu49kvtUn+JOhcRfzmJVc8jZeiIUmXBf1fALYzNCZDc/3xKavr
 9AOICrl9rrqgZN4qktnun97anLaPOPvPKieMzFMDbNc4u49qtVv5zj5JmhOqDLNRSnjmqw
 0qrH46TSadfDOtbBaKkVpVois7QQg2Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-e5eIUyVBPdW7YM8z9ePuqA-1; Thu, 08 May 2025 12:08:13 -0400
X-MC-Unique: e5eIUyVBPdW7YM8z9ePuqA-1
X-Mimecast-MFC-AGG-ID: e5eIUyVBPdW7YM8z9ePuqA_1746720492
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acf0113e311so114883066b.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 09:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746720491; x=1747325291;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCgHBpF4pW8RkW/ksATuKMY870mEGDmPAa1Rk6eyyNM=;
 b=NPFEagwhOrNW+Xg7DaeHjfYunQJ8j34cLYTp4vLVkTckMbdExXEhpWQIx7T1iOtRB4
 WRtIgms92RNh2B+ssXaRpocA4idmyCHT/PhYb0zLJ0YSFrNvaGugLkgCu2pAR2RSSWGo
 eO2N5r1uGcpBSE+jL/My3QZUte8wd4S0VFk+TWvwxvRLTI/2XNTSXIozGa+Zo6RW5XGV
 uEpRcUpt4CcstpLs/WHy6SScQIwm+edRZEUhWER8lIR4TAWiOjBySar4XpWrZ5yXm7Is
 65yC/4SX/bSslWCfJh2g0mR8F/ha+xAFp2r9BkM2EjyeYcITeg8/P8Vc6MWsdXflLASb
 oEbg==
X-Gm-Message-State: AOJu0Yws0lnKDwBfiysVM796L2YR7c0DqLBjyPlHYWEQcXlnL/e4amEW
 yhfDgZTml87kfjk2lo+2vAVmXRYaLZxFI18yqg7flYPYLpdSSEv3OKxsEqduGajmGilQoMjA53M
 +M0zbmjZCwGq7bcRpj5nByg9yCRmbhUbJKFBjvhuC8dDjo0Vo/t5R6f+Hf+qd
X-Gm-Gg: ASbGncuQ111Bq2+Q8/zqULgPu/nckKrZMkxtf60/pG40aZMyPWx2u+8tmc70y0E04Li
 ZgGpl+1xTEz0Bp4OkhjWuSqVQD7w3Iwbok6Ild3sgC+xltUBIYHdesuPfq7T5cEhVBonGFN4ChJ
 Fp6ZRTvO2uD6uQIVRUOMmTP9FP9qzqgWNkTmGw1iyYHSbeofNLZZc1ikkJe2gDRlt/d2mxh7oR2
 MvKvNPO8MLuqKbFNRLCAA4v+Eb9u/YMKdZREO/An+jym/Bdw2bm17VxOmzAwOM69I9DiounHWuq
 MwDbhCK7Q6nm
X-Received: by 2002:a17:907:940a:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ad218ed3b8fmr28855966b.15.1746720491493; 
 Thu, 08 May 2025 09:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrcIgo4zgnTBYbZwyKWs9R86ZgUWWYHLvRJxSlpVgCAMBucz97HLY/+4gnA+N4f0YxjDCFw==
X-Received: by 2002:a17:907:940a:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ad218ed3b8fmr28851466b.15.1746720491035; 
 Thu, 08 May 2025 09:08:11 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.161.39])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd219sm5289966b.141.2025.05.08.09.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 09:08:10 -0700 (PDT)
Message-ID: <70e9c1a7-b586-41f3-a500-347483f6c1d6@redhat.com>
Date: Thu, 8 May 2025 18:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] Rust, wasm changes for 2025-05-06
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <CAJSP0QX0wL1qJzfMoH6Di+QY3K9ML3HTLeY2gXZHNNJm_jDTTQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QX0wL1qJzfMoH6Di+QY3K9ML3HTLeY2gXZHNNJm_jDTTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/8/25 16:26, Stefan Hajnoczi wrote:
> On Tue, May 6, 2025 at 11:30 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:
>>
>>    Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to e6b9b79c3076777b791f72ebdbc9d37ad8005fe9:
>>
>>    gitlab: Enable CI for wasm build (2025-05-06 16:02:04 +0200)
>>
>> ----------------------------------------------------------------
>> * ci: enable RISC-V cross jobs
>> * rust: bump minimum supported version to 1.77
>> * rust: enable uninlined_format_args lint
>> * initial Emscripten support
>> * small fixes
> 
> I'm not sure why, but the following CI failure seems to be caused by
> this pull request:
> https://gitlab.com/qemu-project/qemu/-/jobs/9974291215#L4684
> 
> Please take a look, thanks!

It is a transient failure; it reproduces 30% of the time with

    meson test --repeat 100 func-hppa-hppa_seabios

even without the pull request (commit 
a9e0c9c0f14e19d23443ac24c8080b4708d2eab8).

Before finding this I had already sent the first half (which should be 
safe since it's all Rust code that isn't compiled on that runner---and 
for hppa targets in general), but if you still have the merge commit 
perhaps you can push it?

Paolo


