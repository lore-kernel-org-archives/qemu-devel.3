Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8282C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxpXo-0005Sa-NQ; Fri, 19 Apr 2024 10:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxpXQ-0005Hu-9f
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:48:30 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxpX6-0003BR-Jl
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:48:27 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so2741308a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713538085; x=1714142885; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rum7/05VR8/3rDFwNsPvScnIehKxDExlXkMRP9v15vk=;
 b=zVTsU60Gt0K0tZ8f/8wfXM/KcE4ppWpMFt4BVR+0xbXYSt9YukKn8Awq7UPSwN4g8h
 ilIfm34U8pUk51/oFApmkkjs5CiihCcoXwLvlyjTHq/V1fQSaU67T1AdMam056SPMc4H
 NuZFAQ5uEv0BjoCVg/wN9SONp0SuYuT0UeTDcd9KU/P+ekyqEWY2lKkJZ52sprPM5XEg
 gEmeUIQgod+rI3kxmjpRwcAM+wyGii1ATfxMY8EYASmL2gOFNSkqcmieXRjsjmiFfRG9
 hKbH9/wtDtAr/gdmYM0cm9fP7b6NoCW+1umEyEQSDbbV/6LZUf9DktYigxARsrvfopTs
 RvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713538085; x=1714142885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rum7/05VR8/3rDFwNsPvScnIehKxDExlXkMRP9v15vk=;
 b=aBbF/dXpTDTHWrFhfb1fB8f9MFPnbvCUNBkoEVNnHhcAcGIyao4cJbTo+ce2tMrq/H
 ONZ0b4ZSZMoYM5N60JtppkU+nGk0tbdrmMoGw6gtvs1AqSxTl92SQI37v4fmsP9xHRJr
 inUtH1R7E4aD0a3/hYLhTyGaRWARxCD7GUMsj/jX8aae4ZHB185wssse+GWbYXcv/0cO
 QVPe+P8Zd8ewZjDHw0li2XtjtbquCng3S2prHcP+5r21cg7zbXLKsS/TLw6xHw218JaO
 ScI0KtKT5LnT1bXtP0m75rnGz9CrV+eOsEKsmHLU3YHxpl2ysnw8FCamZ2wSf4VSbBE3
 mE2g==
X-Gm-Message-State: AOJu0YzvmnfQiJBl5FhgymzOeDkMwMTJJ9KOtm8bUCmGBFYvlrhnIhYL
 4azcV7LVh0wDCrcnOE6xZ/xcRJflcKOCGbO+5WNtJwJeBwV0fkwv6tKh2sjc7IBgQZ0QE6OBD2Z
 iL3H5AyW1WgiQ0fYQDf7q/wEx76KgMXm8TzSJwA==
X-Google-Smtp-Source: AGHT+IGGfrdYG2V/Uh2TIDo6fqbTueXtch6l9BTXltsFzrUTsI2mbela9X4omtLhwfoflo2MssQ2WyDFgcyMNi5/jyE=
X-Received: by 2002:a50:d606:0:b0:56e:2bf4:fe0a with SMTP id
 x6-20020a50d606000000b0056e2bf4fe0amr1690095edi.35.1713538085308; Fri, 19 Apr
 2024 07:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
 <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
In-Reply-To: <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 15:47:54 +0100
Message-ID: <CAFEAcA-nLjJoqujX-4kW4kWrrWbaQ037jGCNG75OB+KJybe8Ng@mail.gmail.com>
Subject: Re: Add 'info pg' command to monitor
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dave@treblig.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 16 Apr 2024 at 19:11, Don Porter <porter@cs.unc.edu> wrote:
>
> On 4/16/24 13:03, Peter Maydell wrote:
> > On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
> >> There is still a lot I am learning about the code base, but it seems
> >> that qemu_get_guest_memory_mapping() does most of what one would need.
> >> It currently only returns the "leaves" of the page table tree in a list.
> >>
> >> What if I extend this function with an optional argument to either
> >> 1) return the interior nodes of the page table in additional lists (and
> >> then parse+print in the monitor code), or
> >> 2) inline the monitor printing in the arch-specific hook, and pass a
> >> flag to get_guest_memory_mapping() that turns on/off the statements that
> >> pretty print the page tables?
> >>
> >> It looks like most CPUs implement this function as part of checkpointing.
> > As far as I can see only x86 implements the get_memory_mapping
> > function, so once again somebody has added some bit of
> > functionality that does a walk of the page tables that is
> > x86 only and that shares no code with any of the other
> > page table walking code :-(
>
> My mistake - get_memory_mappings() is only implemented in x86.
>
> In doing some searching of the code, many architectures implement
> mmu_translate() and
> get_physical_address() functions, but they are not standardized. I also
> see your larger point
> about replicating page walking code in x86.
>
> I imagine you have something in mind that abstracts things like the
> height of the radix tree,
> entries per node, checking permissions, printing the contents, etc.
>
> Perhaps I should start by trying to merge the x86 page walking code into
> one set of common
> helper functions, get more feedback (perhaps on a new patch thread?),
> and then consider
> how to abstract across architectures after getting feedback on this?

I think the cross-architecture abstraction is probably the
trickiest part. I would actually be happy for us to drop
'info tlb' and 'info mem' entirely if we have a cross-arch
command that gives basically the same information -- we don't
IMHO need more than one command for this, and we only have
multiple commands for basically legacy reasons. And for the
human monitor (HMP) we don't need to keep things around
for backwards compatibility.

thanks
-- PMM

