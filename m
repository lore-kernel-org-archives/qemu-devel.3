Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B06C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 09:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saB8z-0005By-H2; Sat, 03 Aug 2024 05:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saB8x-0005BN-Oq
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 05:33:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saB8w-0001Je-2U
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 05:33:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fd69e44596so29300115ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2024 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722677620; x=1723282420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DtSe1LGY1zs26bYsLaiYqbZlc6MwT/mSuOTWJzgck20=;
 b=JyxcUbNBK2LDA0Lda9lRZQPxZVhzoFZ7vUAHHn8+xAyVF2N9LREeA7+VrXs+2ZtUeO
 VSOyTjOJpc3MCoYx0PE/jsxvP1aJpD0fTprcn2CKN4/8iBDu3f/0bB0Yen0YoY7GW8La
 8gan5pNNHsJPzpu3ASsESYZhXk771lwcn9iCSL4Wn8OwlolXbNDs/jkEdiZ5nkDIJNTk
 0jgYkx2Z+ogmgLEYFdKP68rY+gLfB4FSZxK7iAn7aXob+GPPldjP4qOWURHrAQRaXgFS
 fXWkR7ICJuhFwJmOBYyYZQdRI0moX1npj6Jh5nVcDWVng2QbsbQTaKwAx/46PZ+WldMM
 nk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722677620; x=1723282420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DtSe1LGY1zs26bYsLaiYqbZlc6MwT/mSuOTWJzgck20=;
 b=rncruODqZfjsl47K7UkvgTfpbdqSYbqufTxaa4vEPj9/sVRW/W2ZNhgAaXiyHhR+TN
 rwVhWT3cdl/v8bl4+cM+vdrF0vW5+ve43P72zeiYdybf0zBtkkd2JWCsdFmEgExeFdIx
 O6cKZbXkSXX629mvt1NIVjF+vgjPZWw6ko/sSycoOMls121czwijczujE27lOMP3njLW
 aFrLiot3CIEoYh2vKOgRx+PDVE/u5ah3fNB/tOg4yHzn9HWhUCjNUcGMZhF+OFbWSY52
 w/16ebV+V8Z+DZBFPbcFCpKTyPtdKUSHpvA3+QbSPk7dV5QRbze5j1om45gQdjBzdyJw
 mHCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWPO9ZcCVMDy/MUgS7yy5GOmQXUptMT/AmTjUhrMjDCsE0pey3p8/9KLCbFNZPXc3FxJ5GWiBNDCQJFff9chFZWWkl/GE=
X-Gm-Message-State: AOJu0YyfBZ+/fNlIM+GIVdBkow2BsbreoEvgnu8o46YjP2yG8wQKaQ/U
 QZsv0lgMxQ0AHvGvO6R1S4UETArYC+3eW8DXmKk3LGX4uLhOzGVeru0adVJxkZA=
X-Google-Smtp-Source: AGHT+IFKBerlsDyk8trES6oZaVfbuiff2doNZFbbryLnUFcnRJnoy9Cz31TSrZ8Vf2XtEsBBPIkd1Q==
X-Received: by 2002:a17:902:f650:b0:1fb:d07c:64cd with SMTP id
 d9443c01a7336-1ff52492003mr116342115ad.21.1722677620074; 
 Sat, 03 Aug 2024 02:33:40 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905e6b6sm30421745ad.140.2024.08.03.02.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Aug 2024 02:33:39 -0700 (PDT)
Message-ID: <720adf5e-0cd0-4b9c-b851-baa7d51c7e53@linaro.org>
Date: Sat, 3 Aug 2024 19:33:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] bsd-user: Implement RISC-V signal trampoline setup
 functions
To: Warner Losh <imp@bsdimp.com>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org,
 Mark Corbin <mark.corbin@embecsom.com>, Ajeet Singh <itachis@freebsd.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-16-itachis@FreeBSD.org>
 <e336b442-cd6c-40ac-9a48-3f9356bd0c48@linaro.org>
 <CANCZdfqKRVR+1p_zADs8f_3Bi4F4y2Pa4fXCNLhi2_JBkMeZrQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfqKRVR+1p_zADs8f_3Bi4F4y2Pa4fXCNLhi2_JBkMeZrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/3/24 10:04, Warner Losh wrote:
>      > +     regs->pc = ka->_sa_handler;
>      > +     regs->gpr[2] = frame_addr;
>      > +     regs->gpr[1] = TARGET_PS_STRINGS - TARGET_SZSIGCODE;
> 
>     xRA, xSP.
> 
> 
> So to be clear, this is 'use these constants rather than the raw numbers for the array 
> subscripts' right?

Exactly.

r~

