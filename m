Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E28C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKpZ-0004QI-Bf; Tue, 23 Jan 2024 12:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rSKpT-0004Px-RR
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:44:55 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rSKpS-0007ov-3T
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:44:55 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dc261316b0dso3432792276.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706031892; x=1706636692;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cY+sbWdyrY3TPUbLY7/g3QAsx2vYqWtXyWuZMFZGBSM=;
 b=DNrHdCjcSNkTSIBT4QA4PYcsvws6uUilD/CZyGxy+rE6Md+B2TPcrnFA7R8ldWtk5T
 rCX+xqOibAXc7IGZ2Hpb8R5b8alDJcq20Tkl25xwv75PVQHUbNrgpOjP2rwD5AVQ76Of
 AedNNFEO6lKONVtHyeDBklDYfC1bBACnZ9aqYoXBW6iR+I1A/3r1/EyOuUKM8RQdD1cY
 //Z7CymDz0L2K6FqR8HRxWv8nO9s2z8V9SpmnwVOSIo6MLO7Mz1hDRc/zqRv++gvl/at
 rkenm9ovi5SoiWHS7BdTrUZ7dLzD8eeonG4Sm15TWEamj3uRBzJM6QGoh1zBFU3+uMOx
 jDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031892; x=1706636692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cY+sbWdyrY3TPUbLY7/g3QAsx2vYqWtXyWuZMFZGBSM=;
 b=SskrX/FubSIC8xmfc6sU0OrxxJSmPsKmPKBKdU28uMUQAZCiKzuWD4LK7O0NVIfT64
 5A8a8HB7iitVbRQguZX0omZT/3BshJs8UcDk98tvT1B0PiCK/QzeSHHWSprNP1mvGcEE
 8zfD9Z3U4laR9exPmFDOw7iPm7AjxVtxGD4xQcn4MULeSic4rUTASNKb3r+Jx0iEPFXV
 ETdsOGt3AI0tkI8IJGtHuS3KfrkohonedNLOmhILR73Z/CDtTsqscRwIF8JFXLIUdfE2
 RlVtOTq3cfPfBZYVv2BXEIzcHnnIGL8rweCEeUEgvUjdIDlbtMXs17FUONMhdYpfxeRL
 a9LQ==
X-Gm-Message-State: AOJu0YxGEaPqgGlTzjDozVZEi7qr+nw69VEXzfhViOgCEGzp+8oMB4bA
 +u0LC1QcEZo/aHFPR1MoiIB+zjd0nzFKQ1yJi98P7aKA15gjssIL/OW3lBcF5fITyYXkRBu2jGr
 2QmPVwVPbKj/wvJWiaiojUnWyvKsmmHnBvXHozg==
X-Google-Smtp-Source: AGHT+IHrvbB8Z4AgljPrAziLFzaZXeq2n1A/jS2UZT6t2stQe5/1WjAKFQHfnCB2ItqIfRZET3vTDvT6QQOTe2zbRp0=
X-Received: by 2002:a5b:1ca:0:b0:dbc:e3ba:2f55 with SMTP id
 f10-20020a5b01ca000000b00dbce3ba2f55mr3658430ybp.112.1706031892514; Tue, 23
 Jan 2024 09:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20240109102930.405323-1-me@deliversmonkey.space>
 <20240109102930.405323-4-me@deliversmonkey.space>
 <CAKC1njSLR614zQk0_DAgYN1jjdg=0eUa7N1AEwwXZVNN6BwjmA@mail.gmail.com>
 <3cb918ca-27cd-4f1e-8738-306dc5280f42@linaro.org>
 <CAKC1njRXPi1Roch=T+NwQk-TOzN=gSjmPh2KCVsemKdex9CamA@mail.gmail.com>
 <5b6571d3-f654-488d-9dc5-0d18ba542e05@linaro.org>
 <CAFukJ-Cf51kS17BOCkuPpxGXS+h4-MENKqBH5EW7Bj0mz+KPRQ@mail.gmail.com>
In-Reply-To: <CAFukJ-Cf51kS17BOCkuPpxGXS+h4-MENKqBH5EW7Bj0mz+KPRQ@mail.gmail.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 23 Jan 2024 09:44:41 -0800
Message-ID: <CAKC1njTJMWOoBoXeAk6ScCW0Y7CR4=qiErdTxVzf6qn_+XFL3g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=debug@rivosinc.com; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jan 20, 2024 at 11:14=E2=80=AFPM Alexey Baturo <baturo.alexey@gmail=
.com> wrote:
>
> Hi,
>
> Having the feature to run binaries with pointer masking on qemu-user is r=
eally nice, but I see this patch series as an initial support.
> Obviously there'll be more patches and fixes for pointer masking as soon =
as arch tests are ready.
> I suggest supporting qemu-user in the next patches, but make sure we do t=
his before claiming 100% support for pointer masking.
> @Deepak Gupta what do you think?

I think that makes sense. Thanks.

>
> Thanks
>
> =D1=81=D0=B1, 20 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 10:37, R=
ichard Henderson <richard.henderson@linaro.org>:
>>
>> On 1/19/24 09:40, Deepak Gupta wrote:
>> > On Thu, Jan 18, 2024 at 12:50=E2=80=AFPM Richard Henderson
>> > <richard.henderson@linaro.org> wrote:
>> >> At some point pointer masking will be in hardware, and the kernel wil=
l gain support for
>> >> it, and there will likely be a prctl() added for it.  At the point th=
e kernel finalizes
>> >> the API, you will be able to enable pointer masking for qemu-user.
>> >
>> > I am sure I am missing some important detail here, BUT...
>> >
>> > How is it different from aarch64 "top byte ignore".
>>
>> It is very similar, yes.
>>
>> > I think commit: 16c8497 enables top byte ignore for user pointers and
>> > by default for qemu-user for aarch64 target.
>>
>> Not quite, no.
>>
>> commit 0e0c030c681730f3ec55ba3b223b608a8f3e8282
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Fri Feb 12 10:48:51 2021 -0800
>>
>>      linux-user/aarch64: Implement PR_TAGGED_ADDR_ENABLE
>>
>> is more relevant.
>>
>> > IIRC, user <--> kernel abi is only needed for pointers that are passed
>> > to the kernel.
>>
>> It is also needed to *enable* pointer masking at all.
>>
>> For aarch64, TBI has been enabled for user-space since the beginning, bu=
t that is not true
>> for riscv.  Therefore there will be a need for a syscall to opt in and e=
nable pointer masking.
>>
>> > And in the case of qemu-user, we are talking about the host kernel.
>>
>> No, we are not.  We are always emulating the guest kernel.
>>
>>
>> r~

