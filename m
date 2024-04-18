Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B444BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVhI-0003Yy-JJ; Thu, 18 Apr 2024 13:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeffreyalaw@gmail.com>)
 id 1rxUHl-0000MV-Gi
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:06:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeffreyalaw@gmail.com>)
 id 1rxUHj-0005q9-U3
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:06:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e857e571f3so8898465ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713456409; x=1714061209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wWhFiy9waCNyj1AGdQMOBe4rcIvg87i7FEy838sypFY=;
 b=Lf3060NrKWOEI1OTehSKQyn+kaGJxfevaL3QDJUXvHWQVbeYYBRrjBUfWJNwkNtQ8c
 nlrs4yH00f9/PwnV2ver+OAn/FFdFLSRk1DUvRF7j9r/+kgDXiXj1Cy2kJf2iSzOuYS4
 ezgILGZTECURnj0ae5FTGi9a2NZPvF6FsXSUgS/lUL4MOr39hfdb1EovkxIzlGYLfmq9
 2m26zl9oSIlcGZWFTTm7rDai7cHtIspKmUu3njqpZGQMRPfpBLmGAqa9Kw4sLeLMep1C
 Km5+cUl7XjjKZl1b5jPMWhkq21FWP2kscPl8JVSOTN+LHkTv/SNnQFR14ESiiEQ69bRU
 hhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713456409; x=1714061209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wWhFiy9waCNyj1AGdQMOBe4rcIvg87i7FEy838sypFY=;
 b=VOaRSTVtkn+0HJHaQXUvT6gjfx5oYUNbeRKNY1bFucSyjK3gfszC90wcBgcO/bac3U
 ynzrPOwaiF3j/nBkIfy3fH8+qh6cHhUb/9TtkdOzJ/xKRjwb3dEu9oWZM36ZW8+rFhSw
 CH/JLtuD5wqt+MTE3Ki2BI4jZZ2olG+UGzKoEhpQzunV2bgk5db1IbA9XiFqgYGCJVUY
 djCVpRFNLkFHHzrSjw3yF2OEM+67yxiYEZa7z4/TsK36LsSaH/emiODJFPZap8aYODl7
 7EIoT9k/TTjvgAMKJNdul2rrmIu0thdEvPjnb3nIe/yFMfJ6wnevYnp/TPjZ2zjf0Muq
 d0Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa1oD5wM1ydsuZIuTYc3mncMgf+nb7DdaX6ZebB3cOvu1x59THXHm167Bwo6IA+NzWm3qb1uCscI7imX4YrP2XE69Mrgo=
X-Gm-Message-State: AOJu0Yx8om5jSsCq5NE/AJFgvIcSFXG209Ctk/HdDMn/IYXHzrE1T1Ti
 L3y+Bb09J9GgEE38E79U/wGth1Oe1WFeHWxa/7NpqEQfkdZTT1qF
X-Google-Smtp-Source: AGHT+IGFIfWQS14v+ymlR1xvsWZNzQ4A+jyTvavCi/O8emBEF0BOdJyApx0eESyXa9d6hA6sI0m/pQ==
X-Received: by 2002:a17:902:a505:b0:1e3:e39a:2e49 with SMTP id
 s5-20020a170902a50500b001e3e39a2e49mr3016519plq.18.1713456408659; 
 Thu, 18 Apr 2024 09:06:48 -0700 (PDT)
Received: from [172.31.0.109] ([136.36.72.243])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902864400b001e49428f313sm1688515plt.261.2024.04.18.09.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 09:06:48 -0700 (PDT)
Message-ID: <1fc9fdd9-bbb7-4506-bfe5-b31e9331eb90@gmail.com>
Date: Thu, 18 Apr 2024 10:06:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Deprecation/removal of nios2 target support
Content-Language: en-US
To: joel@rtems.org, Joseph Myers <josmyers@redhat.com>
Cc: Sandra Loosemore <sloosemore@baylibre.com>, gcc@gcc.gnu.org,
 binutils@sourceware.org, gdb-patches@sourceware.org,
 libc-alpha@sourceware.org, Chung-Lin Tang <cltang@baylibre.com>,
 andrew@reenigne.org, Yao Qi <qiyaoltc@gmail.com>,
 Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org,
 newlib@sourceware.org, Arnd Bergmann <arnd@arndb.de>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <b5d375ed-283-974a-febf-892760ff855@redhat.com>
 <CAF9ehCVZddmGe0emH8H6ChjuUxia-NOpxa0dCA=5+2PAnvytZA@mail.gmail.com>
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <CAF9ehCVZddmGe0emH8H6ChjuUxia-NOpxa0dCA=5+2PAnvytZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jeffreyalaw@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Apr 2024 13:37:15 -0400
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



On 4/18/24 9:57 AM, Joel Sherrill wrote:
> 
> 
> On Thu, Apr 18, 2024 at 10:46 AM Joseph Myers <josmyers@redhat.com 
> <mailto:josmyers@redhat.com>> wrote:
> 
>     On Wed, 17 Apr 2024, Sandra Loosemore wrote:
> 
>      > Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and
>     remove
>      > support from all toolchain components after the release is made. 
>     I'm not sure
>      > there is an established process for obsoleting/removing support
>     in other
>      > components; besides binutils, GDB, and GLIBC, there's QEMU,
>     newlib/libgloss,
>      > and the Linux kernel.  But, we need to get the ball rolling
>     somewhere.
> 
>     CC:ing Arnd Bergmann regarding the obsolescence in the Linux kernel.
> 
> 
> Just an FYI that the RTEMS Project plans to drop NIOS II support based
> on what happens with the tooling.
ACK.  Just one more note to the wider audience.  I looked at QEMU's user 
mode support for nios2 on/off over the last couple years.  It never 
seemed to work well enough be able to run the GCC testsuite reliably.

As a result, my tester builds nios2 and will run the testsuite, but all 
the execution tests are only built, they're not actually run.  It's been 
fairly stable, but its not doing in-depth testing.

jeff


