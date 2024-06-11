Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAB6C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 07:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGw2X-0001Os-A7; Tue, 11 Jun 2024 03:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGw2V-0001NW-Ip
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 03:35:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGw2T-0001J1-Cp
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 03:35:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7041082a80aso3122145b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1718091327; x=1718696127;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09cka9s4MKyetRo2SV4RQJYVIynwMxUVDHcLYCc/dwk=;
 b=d8Jn0eShxq1lQd85jaZd9xIj+14NNhotM4wKuP3/QUTdkGseVwg696x69L6xfSYAlZ
 GBkidCYxpMbYHYSOIUuei13VZnMq8sP+CL0cZSswRdGH8mN/dX58IStJapIT9a/KdFhF
 BcMKDvSM2K405Q/zgs9PfVE4dVcl4s+e0KTj22xAzZHDedX5C+0iAtPRayPZqBUfrPgg
 VUk66XopLfIso8pQslewTisiZdRQ04ZvmS978TjuCH2h9y0whQID6BueQaqGL4L30wrm
 EZCe/x9cV90YrxH+vsyR9ARDpt9chddgn7J/24yHxVeLVMHtGR1QK3uQlXUyCLs9OR1Z
 3/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718091327; x=1718696127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09cka9s4MKyetRo2SV4RQJYVIynwMxUVDHcLYCc/dwk=;
 b=LRRqgARBc9ZuZNF2b8fUBLHWPNMWrMH68HJ8F508Nt5p8GnL8a2+TZrJftemynEn7T
 AFlWyyQaJCDlOwJ1EZL+AOV8YlitBhVJigVWmQTzsA8+E7WvqTYYLgrrh11OejwplOyV
 dLt6HQA2fhWT32Zn423mFLdEh+i8XKmj2cNh/1H2wfp3unliQCOllTmXlzUI0MtH1fRq
 gDkSfPKFMSpfJcgnJo4xmuC+gwxUQnQ1kC904/p75BgtOFVM55h7mqyGww8BvobXTGKb
 25fagxQ4K6RRJNGp2VNtnH47XJKvz1WvbaixvJ7OhDOOwOSKaS+sk7yeEcycYQ7K9JL4
 icmw==
X-Gm-Message-State: AOJu0YwZyEbSCNCAZTFUYXAAVs49i5ed6/DJqQQerSXuR2NMQ1J+51/Z
 5wPE5Q1Qqvm/wq1Ee2EvCWTS9VeCPimr2lxSR7sDPQ/88koCgBOB/jYkJft5bEo=
X-Google-Smtp-Source: AGHT+IGy0QxiXeGhlg1YKY/DuwE1wXuDUESz8GUF29+CrRd2onYVfqGOehHdafI7diq0luElxEb2hA==
X-Received: by 2002:a05:6a20:8408:b0:1af:dae8:5eac with SMTP id
 adf61e73a8af0-1b2f9cb8dabmr12487777637.46.1718091327546; 
 Tue, 11 Jun 2024 00:35:27 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6f298102bsm56212025ad.73.2024.06.11.00.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 00:35:27 -0700 (PDT)
Message-ID: <f8020f9b-45de-4dca-a35d-b26fe91f8962@daynix.com>
Date: Tue, 11 Jun 2024 16:35:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ui/cocoa: Adds support for mouse cursors
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 marcandre.lureau@redhat.com
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-4-phil@philjordan.eu>
 <dd047370-f0ed-4b8c-a251-037e82f64986@daynix.com>
 <CAAibmn2-JApae_MFX+Wy8MuzkCLuE7DbgmgVOko3f7WzZGoozQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn2-JApae_MFX+Wy8MuzkCLuE7DbgmgVOko3f7WzZGoozQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/10 23:00, Phil Dennis-Jordan wrote:
> On Sun, 9 Jun 2024 at 11:06, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     Thanks for working on ui/cocoa, but I already have submitted a patch
>     for
>     this particular problem:
>     https://patchew.org/QEMU/20240318-cursor-v1-0-0bbe6c382217@daynix.com/ <https://patchew.org/QEMU/20240318-cursor-v1-0-0bbe6c382217@daynix.com/>
> 
> 
> Sorry, I missed this patch set - thanks for bringing it to my attention.
> 
>     The difference between these patches is that my patch does not use
>     warping at all. I thought reversing the mouse movement bias is a
>     fragile
>     approach that depends on the details of how Quartz works.
> 
> 
> Hmm. So, I agree that the relative cursor implementation with NSCursor 
> is somewhat awkward. I'm not sure it's as fragile as you make out as the 
> behaviour of the APIs used hasn't changed in decades and has plenty of 
> existing software depending on it. Still, it might behave awkwardly in 
> the context of other apps warping the cursor at the same time. I also 
> definitely think host cursor integration is useful and valuable, at 
> least in absolute pointing mode - for example, when the host system is 
> itself being remote controlled, and also to avoid the cursor being 
> cropped near the edges of the guest viewport.

Can you elaborate more about the remote control scenario? I don't think 
having extra code just to fix cropped cursor is not worthwhile (I even 
feel a bit awkward to make the cursor overflow.)

> 
> The CALayer based rendering makes sense to me in relative mode though. 
> For one, it avoids the complicated event offsets. The cursor cropping 
> actually makes sense as a visual cue when the cursor is actually 
> constrained to the guest viewport while mouse input is grabbed. And 
> because the guest cursor is decoupled from the host cursor even after 
> ungrabbing, it makes sense to continue rendering it even when Qemu has 
> relinquished the host cursor.
> 
> I've therefore reworked my NSCursor code on top of your CALayer cursor 
> and change notifier work so that the NSCursor is visible and updated 
> with the guest's cursor image when in absolute mode, and the CALayer 
> draws the cursor in relative mode. Because of the chain of patch 
> dependencies I've staged it on gitlab here for initial 
> feedback/testing/review:

You can add Based-on: to the cover letter to clarify the dependency, and 
add "RFC" to the subject if the code is not ready to pull. Please look 
at docs/devel/submitting-a-patch.rst for more info.

Regards,
Akihiko Odaki

