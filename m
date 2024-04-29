Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6BBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Rac-0002CF-OH; Mon, 29 Apr 2024 10:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Rab-0002Bw-Tn
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:02:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1RaZ-0005Zg-WE
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:02:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e50a04c317so23282915ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714399358; x=1715004158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+LyTHw7+Za44mHuA4ENezZyqAcaXSDbTyr6yt2mNs8=;
 b=ePp0OLe1dRis24Uy2wVYuB2FOhF+oNOPrwkoaALe05UZqoMNskDE9Jxz1Ccl2FD6DM
 XxvNpL2Ea3TZnTvgurhXtcQTEIZCZIfVb9X9yCTQ+mjmZMNIqdIPk7R98jP+TzimR8eK
 m+wj+2z3iXzi0mHAdJMv6EDncGrKiLEoIogR1+3JBaqsGQrxo2VtGZFw9/wrSmtwBf7h
 jMmOd5v3goJPmv3c52NCQ49zVFI9ZWu4wZfcDL7/GYnW+e9OB+GKjtOdY+voYGmVSlfL
 hbYBd+RBOfUaUVgoQ+CwT8CSSgR5JAeIi5hAsoco1v6PPJUJoOueONhjk2zkyagu8Y5l
 bm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714399358; x=1715004158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r+LyTHw7+Za44mHuA4ENezZyqAcaXSDbTyr6yt2mNs8=;
 b=EcgsnW9BHfp6e9vILBSByJYEkNng8zI9leMmdDDsyioBha0iCzr3gbRqfmzlCH+/PX
 G4oLcuTbJR55eiugNXFQPH/lBvvGv+qKysM7xrqem1OLLCq3LxGHlTIIFsBxbJT6r0jB
 ABHMvYCJIdySAyXbXCouCjT9Wkf6eljGPR1g0AMcZsj24ZHXrySdxByKWtP3HLhOsNMZ
 9N4LIEsUM72yY0fn4Z9sue58he3UXjpyPt/hIm+4Pdx1Sj1887aKBtN3TS8zkttEMTA2
 K6vzWJrY03JJVgqfhS6fYlRd1X83t07p8Ua0IfgraioPRNkdp4l3xGK7AtzW3214gdbi
 H6lA==
X-Gm-Message-State: AOJu0YzlK9CR3LYTgb58FpxmnhRt736Hmx4xXB8hlNHVopvkIcdYzvq9
 LX4l7/ZgoFaZ3TR5Y+YzRMfOU6ooHYbpb+9u1+ri9IfH0y7g6RGE/Qau2iuI2oU=
X-Google-Smtp-Source: AGHT+IFoZeLE0QFUFQVDMrgoaMk9BzpgjYkhfBrPU8TK2q+xGQV+tQVJg11NcClB2YOXXZUOE9qwYA==
X-Received: by 2002:a17:903:32c5:b0:1e4:9d6f:593 with SMTP id
 i5-20020a17090332c500b001e49d6f0593mr12235958plr.36.1714399358249; 
 Mon, 29 Apr 2024 07:02:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001eab3ba8ccfsm7972642plc.285.2024.04.29.07.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:02:37 -0700 (PDT)
Message-ID: <518df837-3349-4cc0-97d4-a517889ce33a@linaro.org>
Date: Mon, 29 Apr 2024 07:02:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ufs queue
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 zheyuma97@gmail.com
References: <cover.1714360640.git.jeuk20.kim@samsung.com>
 <20240429134136.GA306956@fedora.redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429134136.GA306956@fedora.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/29/24 06:41, Stefan Hajnoczi wrote:
> On Mon, Apr 29, 2024 at 12:25:37PM +0900, Jeuk Kim wrote:
>> From: Jeuk Kim <jeuk20.kim@samsung.com>
>>
>> The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:
>>
>>    Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240429
>>
>> for you to fetch changes up to f2c8aeb1afefcda92054c448b21fc59cdd99db30:
>>
>>    hw/ufs: Fix buffer overflow bug (2024-04-29 12:13:35 +0900)
>>
>> ----------------------------------------------------------------
>> ufs queue
>>
>> - Fix ufs sanitizer vulnerability
>>
>> ----------------------------------------------------------------
>> Jeuk Kim (1):
>>        hw/ufs: Fix buffer overflow bug
>>
>>   hw/ufs/ufs.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
> 
> Thanks, applied to my block tree:
> https://gitlab.com/stefanha/qemu/commits/block
> 
> It will be included in my next block pull request.
> 
> You are welcome to send pull requests directly to the qemu.git/master
> maintainer (Richard Henderson is on duty for this release cycle). If you
> do that, make sure to GPG sign your pull request.

He did. I have

     Merge tag 'pull-ufs-20240429' of https://gitlab.com/jeuk20.kim/qemu into staging

     ufs queue

     # -----BEGIN PGP SIGNATURE-----
     #
     # iQIzBAABCgAdFiEEUBfYMVl8eKPZB+73EuIgTA5dtgIFAmYvEScACgkQEuIgTA5d
     # tgL3Qg//R3IcISQqqDaJ/ySzKGmkyohJSc6ySLYvla4Aki7PV+um2Dx/XNS7uG2b
     # d3Qz4m6QaOKsocLfldRTn2FxVK238Rp5HNny5vc0kGRdwpR514B7aU0FhpT7qObS
     # wbbgRdDddIBIiCFLhtXtg5/TK2h32VxGrVI6llX4gmd2VzqM0e4xeG1Oj8rZseOY
     # SAgvDv68s1YwlO1p1vPvst/H+mUKYkqtPN1mjfCIn5tM6ss8kCLUnKjqGAg1BnSN
     # xwaGrqqOlzQK2+aV02eiItiow8evU/h+c9eiTnBo/EvBwjoBn6flNXABWXFENnmP
     # JjVIFeiNzSFhBPDzO23GXviuEt96j5lrcGYR48HYMZfEbJNpblXzWvEGMZWnXNgx
     # Q3cpcarZ4vSWIflR9OnCSQaGLA0Ny6YqLbmrM/oD+v67EITafKKc+flmiF7DBASB
     # fUoEsdffdA37LDtygJb7hfUhvPQWWAujmGzZ1cDP8Oa0MhT7aiD0Z/WqhhjVQbM0
     # iLiCDDD0cc0pmT3vw3EnEjKjnSkY3H62Q7pnYHiQgij4Ls/Rdd/P7OkSd0aI82t0
     # TooWGZJnyf8rjAzY2cEB1Twrhmhuyt9NnGxip9W8JsQBZMLabD2CahOm83zsk7jZ
     # 3fOONz6XrW2ttFkLZcRd4x4YjKONjEXsSX2ZrXTZ5t3USz/VNvY=
     # =Vwyi
     # -----END PGP SIGNATURE-----
     # gpg: Signature made Sun 28 Apr 2024 08:16:55 PM PDT
     # gpg:                using RSA key 5017D831597C78A3D907EEF712E2204C0E5DB602
     # gpg: Good signature from "Jeuk Kim <jeuk20.kim@samsung.com>" [unknown]
     # gpg:                 aka "Jeuk Kim <jeuk20.kim@gmail.com>" [unknown]
     # gpg: WARNING: This key is not certified with a trusted signature!
     # gpg:          There is no indication that the signature belongs to the owner.
     # Primary key fingerprint: 5017 D831 597C 78A3 D907  EEF7 12E2 204C 0E5D B602

queued for the next merge.


r~

