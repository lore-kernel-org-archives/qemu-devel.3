Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E6BC001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 08:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx0gy-00042g-LS; Wed, 17 Apr 2024 04:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nadav.amit@gmail.com>)
 id 1rx0gu-000429-Gq
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:30:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nadav.amit@gmail.com>)
 id 1rx0gs-0000bT-TY
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:30:52 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a55323f2ef9so317056766b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713342647; x=1713947447; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7fbq7rP8fEuCV+Lwws9gmPYzMJZrPdHDLuBHpR6VoA=;
 b=F0eb01AAPOCN75/EP0gqDuuwXk1NYjWaTsD9R9nrLdqnTK+qI2LeJmAEaA5HJUXsWe
 vR2b8AY9dHLsXes7Q1mjd9LT+a0UGtrntlEz/glk17Hk5Pqz0gBpQ0BqLvlCMLUKfbxl
 1AeourOFw1WJxdWsk1sJLhtKPONxvBFv+81LUyNgqM+g/Cp7fTZVSW73ZfuhCoxlKDaB
 PJmUG0e0JZsDzJAVN/Qh1HqdQuJ9AXYTMNZfXjQ0rYfU8Apu+mMIExac4kGVJ8eYy/1u
 qi1w+xOvTAoSOMmIgujj4XJold9hOdynqCC17CjPIJhkHljOHve8ykkK7iExyVMHZ8K9
 tGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713342647; x=1713947447;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7fbq7rP8fEuCV+Lwws9gmPYzMJZrPdHDLuBHpR6VoA=;
 b=UQg50LVXO/csamrN9XxFoLHit9DbRRbwp1kP0ScIHR7xH6oYwF87VJ02p2qPvf+N8X
 LkTsE2TUnvfGQbrb21w6UXRfAop2bbTFOH8UeNwjVfqtySLlu7mHOrypHTFa5j5oTZDu
 MeWIA4tkLeouNV4Gfn4Bgi3pL1vMf6AvfDPPcCfeRe79YpO1NVN258xFUkxtGQktqNQM
 GpzeWomW/fMnJMgXqh3kJHI0xKmj8/lDfSLJ+qSPUFJ0Znpuc2/NSvBXDqa+xbjj6ad2
 hCZp7CXPhEXTfgZqPzJcQR5hHa3StHZG7L7cSqmNMxDUuArFWs+P6gE7XmztkgpzsIO2
 ZpCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBRLdktuEJjgFXPU7v0EDQTDtC+I4QmsRfdwWL+ambEfw0vW/03jHTD87ozSSfyaKLvQBdhZZDnoApQ+tmUzmD5i85Nq4=
X-Gm-Message-State: AOJu0YwQ6NjrFquyIuTzH5otvZlOpGDdRIa4Vg9yXZcvE4Kmz5SRif5L
 a1OY1eQ6EEZV8QTxpaBm9giJtgsKF3RH1ps2qhpTnVfjofPGMEWn
X-Google-Smtp-Source: AGHT+IFqrF6BPqG0X/Q2K+taULheOo6Ymd0rXjSckqEH5aLZCsAl6OLe65RfqmXdaDI0xPbDg7opAQ==
X-Received: by 2002:a17:907:7208:b0:a51:a329:cd76 with SMTP id
 dr8-20020a170907720800b00a51a329cd76mr12604934ejc.13.1713342646773; 
 Wed, 17 Apr 2024 01:30:46 -0700 (PDT)
Received: from smtpclient.apple ([132.69.239.36])
 by smtp.gmail.com with ESMTPSA id
 hx17-20020a170906847100b00a4e1a9e1ab4sm7857274ejc.157.2024.04.17.01.30.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Apr 2024 01:30:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: Add 'info pg' command to monitor
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
Date: Wed, 17 Apr 2024 11:30:32 +0300
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, dave@treblig.org
Content-Transfer-Encoding: 7bit
Message-Id: <6D6FB5C3-D73F-427B-93F1-BFD3311F2697@gmail.com>
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
 <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
To: Don Porter <porter@cs.unc.edu>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=nadav.amit@gmail.com; helo=mail-ej1-x633.google.com
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



> On 16 Apr 2024, at 21:11, Don Porter <porter@cs.unc.edu> wrote:
> 
> On 4/16/24 13:03, Peter Maydell wrote:
>> On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
>>> There is still a lot I am learning about the code base, but it seems
>>> that qemu_get_guest_memory_mapping() does most of what one would need.
>>> It currently only returns the "leaves" of the page table tree in a list.
>>> 
>>> What if I extend this function with an optional argument to either
>>> 1) return the interior nodes of the page table in additional lists (and
>>> then parse+print in the monitor code), or
>>> 2) inline the monitor printing in the arch-specific hook, and pass a
>>> flag to get_guest_memory_mapping() that turns on/off the statements that
>>> pretty print the page tables?
>>> 
>>> It looks like most CPUs implement this function as part of checkpointing.
>> As far as I can see only x86 implements the get_memory_mapping
>> function, so once again somebody has added some bit of
>> functionality that does a walk of the page tables that is
>> x86 only and that shares no code with any of the other
>> page table walking code :-(
> 
> My mistake - get_memory_mappings() is only implemented in x86.
> 

Hi Don,

Your email popped up, so I just drop my 2 cents.

If you are only interested in x86, you can just build a gdb script that would
parse the page tables and present the data. It might be less efficient, but
easier to maintain.

Regards,
Nadav



