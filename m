Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2EBCD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snDeE-0007I9-9m; Sun, 08 Sep 2024 04:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1snDeC-0007H7-OG
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 04:51:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1snDeA-0000ox-Tn
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 04:51:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-374c3eef39eso1862019f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 01:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725785507; x=1726390307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jLMKTiCDW7cz9kLRx8DicQHXeXl6MiRGRqAavwHZXuQ=;
 b=bpNb9V9Z2FlvH9Jgb1UGrZyaKP1pb5AtkmG2TdirJjXa0J5Mcp3B3sw8LGLCi3l1l9
 sD2vgbxkvUA2MYdt967HjVLeUPc7mPNNb751BYb1g6ap5FKqrfmx+XwT/6yARrXE5C5k
 YRVEoUCNqrqrTpgyczuq6jqpqNlVYm0SjE06jYcZZRgRDFUTbnMy3iNym9bNYUcnu8pU
 GAtaZvU62bOtQGhSBALOZDr9+5+PRqwKF/T05ElhKbFY5b1GGN/tnyaZx8JrtH7010ki
 am+CpGU1W80QExnutM/0bd2RuAczREL84tVS/0mM4xBL2vpkm8GSzr3ZT+jtGNk0cAIc
 KiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725785507; x=1726390307;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jLMKTiCDW7cz9kLRx8DicQHXeXl6MiRGRqAavwHZXuQ=;
 b=fYAIm+f6zutY0BZ1MQhDp++tTMCo935avQCCApWLyWzoxS7OcU7BwnmkxM8B+rQyKp
 j2WUgvD3EolIpJAwwCqXJrv4cnfsBGZU8BoBxD1Jt/WhsHqN8/yLYrFSCwSkjQ++FKid
 q2a3qAYWkmakPffO4Ox7m6TmzHZgPJ86edZRWAZSkQn6ARQhYYYio2l4gdKWO4AQYx6I
 kI3AD6oAIZrYCWZPzWFohwmAyAtuXr0+abw58mKRU/Oiifd8nKfv5wpLtjKpgeIYrQ40
 mu0lhfpMS5YsjcsYgCdjY57Gmq487HcWkwxGuD/ejJMoUqPViBHi5iq5oi3CJ9xgnYmw
 siWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM6GZFuM/dB03hjN6OGI7pZooUFsSSjc6erMxFnGS4VNAi8E4C6cSYKZhvvvh0onx1HCZPfQmF5g7b@nongnu.org
X-Gm-Message-State: AOJu0Yx2gC4se7zzTtvm3nQ0kpp/cuj9y79kvUzKI6hDUotvTkEwTFFV
 Ow25zhEX69IXj3zJ46yFAwzZ+v+/Z5ey4PmLdL22LIocdApTpe5RbUFDuWptO7s=
X-Google-Smtp-Source: AGHT+IEI9musqmjvQB1sCYe970DFty0tcH+flOQyXcWC+FjbeEzeiVrg80BdB0lUONhNIg7g6L1GXA==
X-Received: by 2002:adf:fe82:0:b0:367:8f81:fa09 with SMTP id
 ffacd0b85a97d-37889674bdemr4299668f8f.47.1725785506447; 
 Sun, 08 Sep 2024 01:51:46 -0700 (PDT)
Received: from meli-email.org (adsl-42.37.6.2.tellas.gr. [37.6.2.42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956650fdsm2949972f8f.25.2024.09.08.01.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 01:51:46 -0700 (PDT)
Date: Sun, 08 Sep 2024 11:44:14 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Joseph Kurape <jkurape@gmail.com>, qemu-devel@nongnu.org
Cc: 
Subject: Re: Contributing to Qemu
User-Agent: meli 0.8.7
References: <CALcAbx6pnqwB2TRJMOGu10ZkY-6STOJX81ZGeUNarfXwV+fPvQ@mail.gmail.com>
In-Reply-To: <CALcAbx6pnqwB2TRJMOGu10ZkY-6STOJX81ZGeUNarfXwV+fPvQ@mail.gmail.com>
Message-ID: <jhkm8.uh7rl3q19uua@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Sun, 08 Sep 2024 10:28, Joseph Kurape <jkurape@gmail.com> wrote:
>Hello,
>
>I'm new to open-source, but I've learned C and Python.
>
>I've read the 'Getting Started' guide, but aside from signing up for the
>mailing list and getting the source code, it doesn't provide much direction
>for beginners.
>
>I'm looking for somewhere I can contribute. Could any maintainer suggest
>any issue they need fixing or offer general directions on the best way to
>get started?

Hello Joseph!

First, the bad news: QEMU is a sophisticated and complicated project, 
and I would not recommend it as the first foray of serious programming 
to most people. But the good news is, it is still possible to contribute 
without being an expert simply because QEMU is composed of many 
different things.

The usual advice is to take a look at the issues labelled as 
"Bite-Sized" on our Issue tracker:

https://gitlab.com/qemu-project/qemu/-/issues/?sort=created_date&state=opened&label_name%5B%5D=Bite+Sized&first_page_size=50

Take your time looking at each of them and you can choose something that 
looks approachable to you.

Note: I see that in many issues people say they want to contribute and 
ask for the issue to be assigned to them- no need to do that! Focus on 
writing down your solution and sending it to the list while following 
the "submitting a patch" docs: 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html

If you have any kind of technical question you should ask on IRC, if you 
happen on any developer being online at the same time as you, or on the 
list. Do not ask people in private because not only will less people see 
your question, but most QEMU maintainers only pay attention to the 
mailing list for QEMU related discussion.

If you have any more questions feel free to ask!



