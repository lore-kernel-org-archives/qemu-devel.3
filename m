Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5FAC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtucn-00056R-2D; Mon, 08 Apr 2024 15:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rtucj-00055u-L6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:25:45 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rtucg-00033M-7A
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:25:44 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-617d25b2bc4so34718467b3.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712604339; x=1713209139; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0dj4lWZbPdQcqM3xySrovRFPblAtf4kRy61h59sink=;
 b=XMHtjlZyzqWtMeWaoRwYkcZEJK+KVgtVmxbjU2zgNwihiZsM/0GPbvUjt8Th9Ht2hE
 0DiES937zSYcbQQGHlAABDhDLH977VftmWIoK05iReKjWo20ZOSI6U2gZ6DsSHSLTTCG
 quusNl4PgHtKgnPnFRpFD/sp/LlZcOlwNWuMrxEwbnUgZ2+NunZuh6/1seJxjlqTtPXH
 BfNrHT+rzVYJbHjQaUq2fsYcI4tcGdmdEoQRbkXO5Ue5ZXw5z/GV/SiUHIfT08ViEezn
 GSPLAvWdV9GuZ2Sx5IhZlxLrlqP2MXHegd9lvKdG3y2Mhh6YQj93BXDxZbua2rEjcfOc
 SeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712604339; x=1713209139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0dj4lWZbPdQcqM3xySrovRFPblAtf4kRy61h59sink=;
 b=mapGVkEf75NGkrmFithNFkOZps0IkAZ6szvqituHdB1Zsq500ijF/liNbZJXnNfF9F
 93RDu67poraLoVhRW4ryGD9jPsE68aSFT8V2xuxp36CQ1elaALkgXSr2y3YULKoqmZTI
 YQBxaZ+nmeZt5XDmotKFi5j3B7qaNFK8pQBFg3vTbmT8B+rlabd1tB6qrh2+8VHjjwNz
 rXdMc+LaohB3FJCgvyEc2qXGdcIW1FAnnHhOr2DGGJ3l2g9ewWTVOW8PUVBz7xG0wEzS
 ksjaAjEJi//HH8JxjEs6K9h1d2WkjK9oFbwbda4nk0yPGXwdFrGE5kGRV8w3Y+zsg4ew
 FaQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW710pHLUdnK4ubX2STEGKP0LQbMPbBoOEXwqKNyiSXAbT9Dm9s+ndjTrDD3psEO74tVPjgTMJA5L9LH9UaqRhySAdcg4=
X-Gm-Message-State: AOJu0YynLCpvTbophnbjOEH2YogdD3HGuCLneit5IElUlCKy0GvU00BS
 5OQgLD3b1PUAUns29wQhTOTDQvO5j5olo/QO9jz20A0jjPaHJh9lQUUjsf/Rsy+DWSMbwFMfkip
 in2HCRnvamUl/CwUrZjAnqiJoROY=
X-Google-Smtp-Source: AGHT+IGxl12y83NERWyhSdGQKjDblf5yXEtJjkafy90r6xznsdRv+NAHFKQ1QsCQRJA9KlGe60C68tyJcZSMqXNaLuU=
X-Received: by 2002:a05:6902:2b0d:b0:d80:68d1:b826 with SMTP id
 fi13-20020a0569022b0d00b00d8068d1b826mr10122047ybb.6.1712604339445; Mon, 08
 Apr 2024 12:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
 <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
 <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
In-Reply-To: <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Tue, 9 Apr 2024 00:55:28 +0530
Message-ID: <CAM2a4uwMomHgYVQvRV+3UjsjTkE-BOK=zn8Rgv5y7OGjy0HfTw@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=mindentropy@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 4, 2024 at 2:23=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:

> This will not work (yet) -- CPUs do not get reset as part of the
> whole-system three-phase-reset, so using the exit phase method
> is not sufficient to avoid the reset ordering problem here.
>
> You need to use rom_ptr_for_as() to see if there's a ROM blob
> at the address you're trying to load the PC from, and if there
> is you use ldl_p() to get the PC from the blob; otherwise you
> use ldl_phys(). Searching for "initial_pc" in target/arm/cpu.c
> will find you the code that does this for M-profile.

Thanks for the tip. I am able to see the program being loaded based on
the dump of rom pointer in gdb.
Now the problem is I am loading a binary file (msp430-elf-objcopy -O
binary simple_test simple_test.bin)
and due to this I will be missing out the loader loading different
sections in the right parts of the memory.
The reset vector which is supposed to be present at 0xFFFE is present
at 0x3FFE in the binary file. How can
I fix this? Should I revert back to elf file loading?

-Gautam.

