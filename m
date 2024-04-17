Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18569C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxBXo-00059D-Bd; Wed, 17 Apr 2024 16:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nadav.amit@gmail.com>)
 id 1rxBXm-00058p-UU
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 16:06:10 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nadav.amit@gmail.com>)
 id 1rxBXl-0000Wr-6k
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 16:06:10 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a53f131d9deso1994966b.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713384367; x=1713989167; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKiKitg2sB72IethOtqoFcn2jOyCOSOHkFwh1FSKSjQ=;
 b=cWdWO7PDsDfF4xAtzvv8ZwgquaxW6LkdHvtuVf9hmidbtuXN1fYMzQxjwRoi/Z5Ci3
 vKvFKd4cPNAJFVfGF9pSxGoqLfxx60ZslV4RRXDTNJipND1lqkGszwvrxjRHJ6+fR/po
 dN/AY3Nvphc2ZhXWJnXmLkeCrSPj55Ln7+97wsVeZ+Fg3qGf4NqndzuNLbw9ABdmVSva
 fR9y/Xd1gYwsm3ZPBU6c3RxBW455W5omw3Epui0xNfKKMsmIu/Rv0sWC8UPY/rn5ey2m
 e5npREqFyxAFMDwiEVdNTNf8cwtlc10dmXPfHSBMlq7G1kWT0hb/DT4uRS5O68I3Xjxq
 DSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713384367; x=1713989167;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKiKitg2sB72IethOtqoFcn2jOyCOSOHkFwh1FSKSjQ=;
 b=Gx9DKuPbqSYXAJjMhFVTGr8fMwfXea4Oz7v/g8dtTcsS+Dr+u8bIP0oL8Skwlddn8z
 o88KSjAVGfNE6lZs7iMNoPnjHq+29YifekERmbrO97I36ItoXJ+qW/OKrfpEBFvXr9EX
 2+pZiwV+GC2I3NObvwDw0mbrke0G8vELTuZgUEyiFFgevfgsH4Z4OZSr3D2LHm9JSDHO
 oKovIiX13JMYuB1GtVkPWT4gBh9YWpChs5hpH/cWwu2cXsIHx7bSHx+TqUXzWbF4buFR
 Xvp1KgoG5XkYnYeiff91IH35I+oFUsQyN4uyOcEHvah0p62DZoNNAqwzy4ACSg49dUne
 10/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNN37cOX1S3UxyZGZnRYrhnLhKj02yukKE0H0XGixZUo6+VswJchZgc9qqO6nXr3kgqtSlq78CawJUKodWCaRtND9/j3c=
X-Gm-Message-State: AOJu0Yz0fgcyLMUXN3Hoha0k4QYDbChQ6uGh4DEoTpSKTdPuWPpKcaTg
 stVFK3lWZFPdYDv9MXpokOClOImAmhM4e6xCVLqMlkhk3AKpO6Zb
X-Google-Smtp-Source: AGHT+IGHaJ9Mbj8imP80Jh0I8YVQH3u7LRivoczvBAiJ90GsAwWyxPDS5onDP02DwngG3kfdHyvbZg==
X-Received: by 2002:a17:906:36d1:b0:a52:4edb:6db7 with SMTP id
 b17-20020a17090636d100b00a524edb6db7mr318508ejc.54.1713384367027; 
 Wed, 17 Apr 2024 13:06:07 -0700 (PDT)
Received: from smtpclient.apple ([132.69.239.36])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a170906a09700b00a519ec0a965sm8446140ejy.49.2024.04.17.13.06.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Apr 2024 13:06:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: Add 'info pg' command to monitor
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <6D6FB5C3-D73F-427B-93F1-BFD3311F2697@gmail.com>
Date: Wed, 17 Apr 2024 23:05:51 +0300
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, dave@treblig.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <78AA0AA8-3ACA-4B8E-BC36-A0B939F3FF22@gmail.com>
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
 <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
 <6D6FB5C3-D73F-427B-93F1-BFD3311F2697@gmail.com>
To: Don Porter <porter@cs.unc.edu>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=nadav.amit@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



> On 17 Apr 2024, at 11:30, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>=20
>=20
>> On 16 Apr 2024, at 21:11, Don Porter <porter@cs.unc.edu> wrote:
>>=20
>> On 4/16/24 13:03, Peter Maydell wrote:
>>> On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
>>>> There is still a lot I am learning about the code base, but it =
seems
>>>> that qemu_get_guest_memory_mapping() does most of what one would =
need.
>>>> It currently only returns the "leaves" of the page table tree in a =
list.
>>>>=20
>>>> What if I extend this function with an optional argument to either
>>>> 1) return the interior nodes of the page table in additional lists =
(and
>>>> then parse+print in the monitor code), or
>>>> 2) inline the monitor printing in the arch-specific hook, and pass =
a
>>>> flag to get_guest_memory_mapping() that turns on/off the statements =
that
>>>> pretty print the page tables?
>>>>=20
>>>> It looks like most CPUs implement this function as part of =
checkpointing.
>>> As far as I can see only x86 implements the get_memory_mapping
>>> function, so once again somebody has added some bit of
>>> functionality that does a walk of the page tables that is
>>> x86 only and that shares no code with any of the other
>>> page table walking code :-(
>>=20
>> My mistake - get_memory_mappings() is only implemented in x86.
>>=20
>=20
> Hi Don,
>=20
> Your email popped up, so I just drop my 2 cents.
>=20
> If you are only interested in x86, you can just build a gdb script =
that would
> parse the page tables and present the data. It might be less =
efficient, but
> easier to maintain.

Actually, I think I was wrong. It might not be easily done with GDB, but =
I did
something similar with QMP.

You can have a look at some related code I once wrote for similar =
purpose:
https://nadav.amit.zone/downloads/pti_test.py


