Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C2C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX3x-0002QF-14; Tue, 01 Apr 2025 04:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzX3o-00027y-9E; Tue, 01 Apr 2025 04:33:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzX3m-000158-6D; Tue, 01 Apr 2025 04:33:27 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22401f4d35aso103121775ad.2; 
 Tue, 01 Apr 2025 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743496404; x=1744101204; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLVE40W/XGAQOr1jx4pd9tNsIM2lcVMwDaZ/6pQHw7M=;
 b=cL0AUYPGvSqZn+rmBnsWCuFcEyprm6wdevr6yb9qMAqt6r3GMVrLmHyMYKzGJBdbU3
 hDNir2yDwlRlnf88BxHkQLq2pFzAGKzJyTZmB25nN5EqCdM/BzujCH6OrIjk2DTCflIr
 PV7P8qoBT8QjWq/zDEX3/lVfrqj4JBW4ecySF4AxE4rMA+sLQ27ghz55IHZLeOCWPUEP
 l0ViLCp2NwE5uMbzxQk6kOXb41nIab8tpIOhURKtbtTJd1anDiq/24TmpQ8/EC5YIl1A
 GT0IAjCon3bjFSeBtDbdRJR2JVkEzVMsEoi6/bX05unWA9ViCmdwSvIUzTWLs7le9Vg7
 5hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496404; x=1744101204;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JLVE40W/XGAQOr1jx4pd9tNsIM2lcVMwDaZ/6pQHw7M=;
 b=EjQzwxdKkU5AMh4LkTbve2hyn6i+WXo1GRecdcXtPZhRhKsCvKtQuE9evcjj+KnEa/
 80g2oPt1GeHU/OpmSVkiadO506+FQe86Z1PxNfmBhO84ehiQruDeJEdTK4dGN2jooGf1
 jlImFj1v9LbPG/ao67VOnB85JfvkLGHuDToA8TTzyH7DkCg8+OnqVszombHH5iSvWraB
 KGKq/hZR1Ab/43hucPCV7C0aKwrQ488n+cUBEGbTKT8Cx04ePKcyfFmPes9lt71Giz3u
 olsK1QgWudDjSWiRsxMwZYGcXfkkSHlEjw2X3uNWNFJp69Usy2hfAhYcldtEg0Ix75Tc
 mmHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ3UPYEN9muJlIYdXE9qx2zd6+a3xg4O0g1aQ2c1uzMrq0v9PN9BohGYuUR/3qw+AR1ClMyGgkyg==@nongnu.org
X-Gm-Message-State: AOJu0YypCPT7fY9CqEvx5eaTKAVx14scuhs/7E0EyiX3SVy62yQOH7SZ
 L6KHqecB13vGQ5BOGrFzCYW6rE/f4o/qBnD0kswNKxFv2WzcFhoYsORxwQ==
X-Gm-Gg: ASbGncsggC27vfL2pG0rKXGGKViweJW6xIP+ZcS20nUcFzGnQhL2irQz9jkn7HJozzF
 i2ZV0GMVZKGOshCwCIOMiLzdf//lgvOPDc+YcXAc3VZUo5VmF0GCzb8YIkKnTqSd/dzqF/iB531
 7vqLxqyKeyrsk3iqcNzoE/Fpixls08sh45s92z5C+cgHKGAa5kAXHVcOKoUTgIOiBlaOEcp72R1
 nPzZGnzIGzc/iMzBO0nlXDUV5Cq51WqwkY4u7T/Wm9MHSziR64qoeyc8BgggHjP3Say8uPXdFHe
 7PzdAAE7iV3hGuYJMF5lLZBY9/m5V2a9+sGSMdU=
X-Google-Smtp-Source: AGHT+IGFrpxEeEP+/r8JVY9uDZOUQIt+Lg5IEjpTv/hLRlKRWB4k95ae0Ccz4gLdU88efGCAYfx9bw==
X-Received: by 2002:a05:6a21:3408:b0:1f5:8754:324d with SMTP id
 adf61e73a8af0-2009f5bbf98mr22861094637.9.1743496403871; 
 Tue, 01 Apr 2025 01:33:23 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b679f0csm7587258a12.3.2025.04.01.01.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:33:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 18:33:19 +1000
Message-Id: <D8V5W4N51IMU.3GNZNC0FK5KKN@gmail.com>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 0/3] translation performance improvements
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250331155423.619451-1-npiggin@gmail.com>
 <6e647368-9fde-4c7f-ac17-d4c4e46fab3a@linaro.org>
In-Reply-To: <6e647368-9fde-4c7f-ac17-d4c4e46fab3a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

On Tue Apr 1, 2025 at 5:40 AM AEST, Richard Henderson wrote:
> On 3/31/25 10:54, Nicholas Piggin wrote:
>> I've been struggling with these couple of performance issues with
>> TB coherency. I almost thought deferring flush to icbi would be
>> workable, buta note in the docs says that exceptions require TB
>> to be coherent... I don't know what requires that, maybe it could
>> be worked around?
>
> Which note?  Anyway, qemu implements accurate tb invalidation for x86 and=
 s390x, which=20
> means we don't really need to do anything special for other targets.

In docs/devel/tcg.rst

On RISC targets, correctly written software uses memory barriers and
cache flushes, so some of the protection above would not be
necessary. However, QEMU still requires that the generated code always
matches the target instructions in memory in order to handle
exceptions correctly.

>
> Compare aarch64 "IC_IVAU" which (at least for system mode) is implemented=
 as a nop.

I'll take a look at it.


>> Another thing is PowerVM runtime firmware runs with MMU disabled
>> for ifetch. This means a fixed linear map with no memory protection.
>> Is it possible we can enable goto tb across TARGET_PAGE_SIZE for
>> ifetches in this mode?
>
> No, there are several things that assume nothing jumps across TARGET_PAGE=
_SIZE, including=20
> breakpoints.

I see. It did actually work and run fine, so I wonder how much effort
it would take to cater for these issues. I guess for this rather niche
"real mode" it may not be worth bending over backward.

Thanks,
Nick

