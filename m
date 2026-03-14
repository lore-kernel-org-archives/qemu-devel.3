Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332A310706DC
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 14:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Pbe-0003EH-66; Sat, 14 Mar 2026 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PbP-0003CZ-Fm
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 10:04:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PbM-00058O-3b
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 10:04:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so29632625e9.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773497062; x=1774101862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTxnv949vJZsjDtoQLSWF3iSXsx3DG0DOsK/qpJww1Y=;
 b=fT9o6jzeyx/VEYjHXivAwXmQdKOG9kNtD4CZwsHfHMp6orBy4zX6Gz5i5ZvQOFo4Am
 41u3pFoJ4kY1okDUpCeLOH11ouq8PC3XrgsWpLg/lhTTkDjb6v17JXY+RIiWJhMCl2FW
 DH0XtpRmqY1JXP53q2i/5uc2R05ryHZM7aNQWaf0GXJcyeEC7+/3/oUqZO4Ugp1wQtj8
 mFiQJCZ3WzCI3X/yHPWRRFmwWtMC4o/TAkLBotKOF7APa24jhhowJGA7DxXMyffKrQcH
 KQi0hK8JPyRbRKpeIHruz1FSlRFHtt9sUGrk91giHGECYeBzO/pmD8576QT9fqYP/jDe
 ZJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773497062; x=1774101862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTxnv949vJZsjDtoQLSWF3iSXsx3DG0DOsK/qpJww1Y=;
 b=D+hA34dRNyUQ/sFzBSxFccL//GZCZ49WYPkinvSeqcYxticurbZyIt+IkaJoiAVKzQ
 E0Wbdao0aU43n880gbokSivINuq4rnV2DqowKS6Uxgvs90TqgfaiMBk+o5pjhEZs4mU4
 +D/2xmMzQSN4YlKOk72RbblnoW2X1w2pUo0VFd+G8TxWxlvqDEjPAFPHShABytyvRLU4
 1d3tKD+50sgBIvwcpPiVn+/hPGmrvxSwQl8DEonVsNQ/aey9bQXecVf59sHuliH8J2oP
 tv/kb6zKzvvmszOOOdP90Xc+hF36um8Auuw0zsfZ0jip/A4M2U1iM+RFfSPjWybqgcAT
 dbiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyOmh++EssY757t5BzpoKjSrr7Wd/cIQVg9AJ78Wxe0zyqmSnRHJkUQFJgbkLNkav3Em3IFxJv0F5H@nongnu.org
X-Gm-Message-State: AOJu0Yw3QVjUnohWGlzzFIUyNj9mDozp/bWtQcFVNOU729w3b+htn0A5
 y9gzjqifImXu6iZgrA1T6ZIxuNS5BbIVej1jqX5ak3Mdk4Ju3lT3+f7Utxft7WcHY38=
X-Gm-Gg: ATEYQzwBKQN5QdNdlVbm0W/meAYK3XWd9k4th5pWl5DNjNKlS38Ph+dNGiA3zYDoyl6
 y+zpeKT9IuE0OtOgiAfo60gEfpmuVUkO0CLWLtXw3rgCf3e0jIqMFgF1ArtsNCusaswQEiRZP2G
 yL8uHtKcpMFV/8QRGEyKsbsWvTSd5X9dxnf6mSDVUh/s4JcxgePnwEe0hskNzhShzsfkxXfoqPH
 MkHxbL1aDaeTW/JCDJdreN4O0MIzIRQcBBrtWozdnmHNr+nVFDmY/PuPIH1lqQhCaTMneEN3F/x
 N8JPu4WteMePMS/n2huoGlAUS3uQOeUfUcJ+U1F5ZVcLRf77TnTWIPtcvDkxZZIykwxYCfuGcLz
 1y8g2ezzQ6mbTJ0RD8cIUyCwpa0LS+T/tncvVpwf+N1dBKkJ8VchDh/bx2OYavSz3X+L2hKFPWx
 JeQwGcLzdEZwX00dvqWTP5smPJxOSGpt3uip0fmkIiCn7pNJHubuE989zW0qlKxqz7JQ==
X-Received: by 2002:a05:600c:8a0c:20b0:485:54cd:6e4e with SMTP id
 5b1f17b1804b1-485566facebmr86956935e9.18.1773497062070; 
 Sat, 14 Mar 2026 07:04:22 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563903bbsm76868695e9.0.2026.03.14.07.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 07:04:21 -0700 (PDT)
Message-ID: <68f5185c-17c7-4d41-8190-c0b003aaef50@linaro.org>
Date: Sat, 14 Mar 2026 15:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] MAINTAINERS: Update the s390x maintainers
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-3-thuth@redhat.com>
 <19204615-dc07-4bc7-b662-f44ac3f23f97@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <19204615-dc07-4bc7-b662-f44ac3f23f97@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/3/26 17:02, Yodel Eldar wrote:
> Dear Thomas,
> 
> On 13/03/2026 06:34, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> I'm going to move to another project next month, so I will not have
>> enough time to take care of s390x patches anymore. Fortunately,
>> Cornelia volunteered to take over the job of collecting s390x patches,
>> and Eric and Matthew offered help to back her up, so we can keep
>> the "S390 general architecture support" section in the "supported"
>> state. Thanks for your help, Cornelia, Eric and Matthew!
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
> 
> Our correspondence had only begun recently, but as a QEMU user I
> had been enjoying the fruits of your labor for much longer (though
> I did not know it at the time). I'm so grateful for all of your
> contributions and the help you so kindly gave during patch review.

I couldn't say nicer, so +1 here :)

