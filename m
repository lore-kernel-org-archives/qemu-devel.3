Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89470C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 04:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq42p-0006qk-KB; Fri, 29 Mar 2024 00:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rq42o-0006qK-7e
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 00:40:46 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rq42m-00089w-7R
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 00:40:45 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso1084610a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711687242; x=1712292042;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsaGwaV7nF+8RbnWlokdh+Q1cPay/RhZrHquJUNVc3U=;
 b=FssTz3el8mgaD1mrOWgl0fSyJeGEqT+uDaDQAxsltMrTd5VSqeuKNV4jNo2S87lDfn
 JZCve3mLBtMCPjB0NsNut1S3jDOSELiGdyW5IJDVsiMSAJ1fCrH8FIBnhAIREiKr7qoP
 CPxqPhhphXWbIGkEh4lLiPT4wQcrkrpT/nXYBHTGsLNlD5ezGe30xT7EDROy+QY5Edqx
 tMSRmsEXt3oRLhqM/q7EO6q1IEITfRPF1tgBMZS4ymdOJhjlg3MbiYVb35de2TjScUzh
 nXAMzSfWrkZS4wYpNj3zH7AbfDEib8HAwCNH1Ovrimo8Qu7DpP+qreTTir3Oaxn1iDrV
 1LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711687242; x=1712292042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsaGwaV7nF+8RbnWlokdh+Q1cPay/RhZrHquJUNVc3U=;
 b=ePWwYZVx6M/wKk+1VsriH6Ld0Mzo0cquRzVPdGtahkeVGAwOh7fKUoeI39Vk//cDGf
 2DxbmJgGDaEBJESID7WACNSvxNNDiEOXbgxId0k2EmLgqUUY+Y9RY79mvysgvEeuOgkj
 5RuP9m74YED3ngYJjWu5BXK6aXXtptMGEQArBFPiiNh+zYF1RS59L9Hi9XUEGElduuZz
 N2M/prdQg/Ar4yyewSpEtiHQnuFUU9IhuD9TF7pHv/9c3v6lVRgLWknvjAeGRR6BI3V3
 bepvoabZMfaijWJBp1UQCjtYxpko44LnSvGVGvjvkLamJ/3nRhIM3xwy/Gb1ggdb4f57
 X8dA==
X-Gm-Message-State: AOJu0YzHXV7Yf9TMWzHcHdBbIEFsQS3/u+Ba6bc1Gxlc6LPwRpGDPbuc
 KyvoWtR6q2P9qZim2JeXnh3mXcaTzZgpY45XZcCDYXm93+a08OCHojfejFCihMk=
X-Google-Smtp-Source: AGHT+IGgSNHHomnT0i9H8u0qW1lFBPzib/0ZiEI+dXQgGh+YUJuxAs1E7UWB6Pw/j4ak/ZtmXJQEYw==
X-Received: by 2002:a05:6a20:7347:b0:1a4:aecb:317b with SMTP id
 v7-20020a056a20734700b001a4aecb317bmr1325011pzc.33.1711687242036; 
 Thu, 28 Mar 2024 21:40:42 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a170902db0800b001dc01efaec2sm2516058plx.168.2024.03.28.21.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 21:40:41 -0700 (PDT)
Message-ID: <099bd787-53fb-478f-9d0d-2de419583786@daynix.com>
Date: Fri, 29 Mar 2024 13:40:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu Display Coacoa Patch Serie Qemu 9.0 RC1
To: BALATON Zoltan <balaton@eik.bme.hu>, Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com
References: <26c7f97e9ce7fc10de24da84aa10638a@mail.emailn.de>
 <2b4fcc6d-6e23-2ac9-7f55-6b488e327cd3@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2b4fcc6d-6e23-2ac9-7f55-6b488e327cd3@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/03/29 6:44, BALATON Zoltan wrote:
> On Thu, 28 Mar 2024, Rene Engel wrote:
>> I wanted to discuss this topic with you again, there was already a 
>> patch series that worked well under Qemu with
>> Pegasos2/AmigaOneXe/Same460 and AmigaOs4.1. The option zoom-to-fit=on 
>> should be used to adjust all resolutions provided by the guest
>> system to the aspect ratio if there are no Virtio GPU drivers 
>> available that allow this.
>>
>> In my opinion exactly this option zoom-to-fit=on makes this possible. 
>> If you don't want to use this option you still have the possibility
>> to deactivate it. In Qemu 9.0 RC1 not all resolutions are stretched 
>> like in previous patches e.g. 640x480/800x600/1024x720 etc. but this
>> is exactly what we need for the Pegasos2/AmigaOneXe/Same460 machine 
>> with AmigaOs4.1.
> 
> There seems to be a bit of confusion about how this zoom-to-fit option 
> is implemented by different -display backends and I'm not sure what is 
> the intended behaviour or how other -display backends handle it. Maybe a 
> single option is not even enough to describe all possible preferences so 
> another one i.e. keep-aspect=true|false may also be needed to cover all 
> possible settings (don't zoom, zoom with aspect ratio kept, zoom to fit 
> window even if that stretches the picture out of aspect ratio). For 9.0 
> ptobsbly we should go for consistency with other backends now as adding 
> new options is not possible during freeze and then resolve this afterwards.

It is indeed something that requires a new flag like zoom-interpolation.

> 
>> There are also problems within the resolutions with the mouse pointer 
>> where the screen output flickers it currently affects all patch 
>> series. I would be happy if we could find a solution for all this.
> 
> The flicker may be due to the resize algorithm used by macOS not giving 
> the same result always. To resolve it maybe yet another option may be 
> needed to not zoom to full available window but try to keep the zoom 
> factor some integer value to avoid fractional scaling but I'm not sure 
> that's the best way to solve it.

Flickering sounds more like a bug. I appreciate if you can share some 
recording.

Regards,
Akihiko Odaki

> 
> Regards,
> BALATON Zoltan
> 
>> I'll leave you 2 videos so you can decide for yourself what would make 
>> the most sense. It shows once for me the working zoom behavior
>> which works very well and the behavior with Qemu 9.0Rc1 including new 
>> Cocoa patches.
>>
>> Qemu zoom-to fit=on for all Screenmodes 
>> working: https://www.youtube.com/watch?v=dnJ3W8egAFY
>>
>> Qemu 9.0. RC1 zoom-to fit=on not working for all 
>> Screenmodes: https://www.youtube.com/watch?v=Ddq68ViudrA
>>
>>
>>
>>

