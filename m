Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6536DC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhj97-0006gB-BH; Tue, 05 Mar 2024 23:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhj95-0006fO-7j; Tue, 05 Mar 2024 23:44:47 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhj93-0007q1-HQ; Tue, 05 Mar 2024 23:44:46 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7cedcea89a0so3924811241.1; 
 Tue, 05 Mar 2024 20:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709700284; x=1710305084; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4KaRJF1M763yK9vQ9RbMd9SPVLZiXaWoqRbeDDSUZc=;
 b=jABuAhEnPJhIKuqDZEPFQOBGNrxhyPzmf1Hs/waNFmYitRdcje4+BEVXnJC2/ie1sG
 fzquEMpx5NMWSp+OI57gWjG3hHT90veQ75H8Z/6XI2WhPfsQyCyR5QEqClarJauwV73j
 tmWPrV766xLpTizjwjhtMpZdpHHW8oumonKsd0Dwou0RnKNn9Wm02DB1U+pMLN7PEaEH
 yYgax1HgjuKQkuHZ0GME+xSp8RIXVBmx0BHBdlerXV3pSpK2uNw0tSwvvSc0XZVyMctb
 kfMuNpYOsCC7TlAFIarni1AzeqyThlCO060pPrH4iFM2CHBZHx4Ri4mh2h2H+xyjaVTq
 lXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709700284; x=1710305084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4KaRJF1M763yK9vQ9RbMd9SPVLZiXaWoqRbeDDSUZc=;
 b=icbFvTsGghouIVrtQ2i+pRwiS84QRvhVqpNwqnVUogbpq6Kee53ZW6MsanrWmMRFxG
 Q07OEgzDJ8Snw1xNfWE0XK9XVk2o6GydF3zp0FL9JgecM2Kmm3vg4AflAojHUOoXzAz5
 kJZyqZSImsCW2qkdtHfVoL1o1Z67lYeL0g1JUnVil8P1rGy5QK8EIvA4DEiglD+BH4Nr
 skVu3GKsRrCjtDzu/BMhSq/p2MYNaF/Z4vcfJK+9diKsH83yZpwYfYmNEinXWEgrGFaN
 gUnvXP3nmn6DZsYpzn+q628q05e4gDk5zjBuSgDuIc7y6C16SDyuQXnAnk0Dnpq5XeR0
 AQZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwoECtnjnfQgwxm0tHrXmRmPK4uEwiNoGOSbJkTQSjLDOxFvKW8UoYAcb//wwDQF7xEQz+/n3MOS/aI/oMXaHgs/dRK7M=
X-Gm-Message-State: AOJu0Yw2/7qu142sYT1YPB5NnxhfJlPguNT1uxKVVLGGE2K3Iub2gAHW
 35KjSfp+xPuUwf6YeLB9EO2vR02X8glFLd6kuXJnKPIAaBYuXRIaMveqVxU6YpXNsODzPOfDfeH
 ZU1Q5qJz0wgwqgWl6PFGLfNt+/C0=
X-Google-Smtp-Source: AGHT+IGfvc/z0VIVbfSCujxi0LnK2vF5T7wFLmjuA2n8L/Hm0zJ41usVANXZKxrO/T8fLCYtEiAjWfgpGdBoYIv6ZSA=
X-Received: by 2002:a05:6102:91:b0:472:63c5:64f6 with SMTP id
 t17-20020a056102009100b0047263c564f6mr3689986vsp.11.1709700284058; Tue, 05
 Mar 2024 20:44:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHY78Bq6AdcZPuFRbdShDPvgmgcoB+PKLWqPuOoX3vdJ-NsZ+A@mail.gmail.com>
In-Reply-To: <CAHY78Bq6AdcZPuFRbdShDPvgmgcoB+PKLWqPuOoX3vdJ-NsZ+A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 14:44:18 +1000
Message-ID: <CAKmqyKN2W+xXUKxex_HfaNgMhGd-=q0j5cA6pssp2Kh4y38rSQ@mail.gmail.com>
Subject: Re: What riscv tracing tools do you recommend and how are they
 accurate for measurements?
To: Nazerke Turtayeva <nturtayeva@ucsb.edu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Feb 29, 2024 at 11:21=E2=80=AFPM Nazerke Turtayeva <nturtayeva@ucsb=
.edu> wrote:
>
> Hi everyone,
>
> Recently, I was planning to measure the performance of my application of =
interest for potential RISC-V hardware. Hence, I started my simulations fro=
m Spike to analyze dynamic instruction traces and instruction count, nevert=
heless given it does not support multithreading, I started using Qemu to te=
st my app too. However, it seems like I cannot rely on timing results of Qe=
mu for comparing different implementations. Accordingly, given I am brand n=
ew to the Qemu ecosystem, I was wondering whether I am missing some importa=
nt mainstream instrumentation and tracing tools that I can use for performa=
nce evaluation of my target app in other ways. Particularly, I want to unde=
rstand implications of adding custom ISA instructions to the performance of=
 my application.

Hello,

QEMU is an emulator so it isn't great at timing analysis.

QEMU is useful for instruction traces though. If you use icount [1]
you can get a deterministic-ish setup which is very useful for
instruction counting during execution. I'm not sure what custom
instructions you are adding, but you can test if they reduce the
number of instructions executed. Note that QEMU doesn't model timing
though, so it might not be an accurate representation of real life
performance.

You can use a plugin (see [2] for some examples) to generate
instruction, memory or other more specific traces.

1: https://www.qemu.org/docs/master/devel/tcg-icount.html
2: https://www.qemu.org/docs/master/devel/tcg-plugins.html#example-plugins

Alistair

>
> In this regard, do you have any recommendations on where I can look?
>
> Thanks,
> Best wishes
>
> --
> Nazerke Turtayeva
> Graduate Student
> Electrical and Computer Engineering, Computer Science
> Email: nturtayeva@ucsb.edu
> UC Santa Barbara

