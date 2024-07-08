Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5C4C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiT0-00067v-Iu; Mon, 08 Jul 2024 03:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sQiSs-0005dY-KL; Mon, 08 Jul 2024 03:07:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sQiSq-0004Fa-PF; Mon, 08 Jul 2024 03:07:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fafb9a33b3so15460175ad.1; 
 Mon, 08 Jul 2024 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720422425; x=1721027225; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlVTUIKaYOJSgq8jSLVoBvWZ83hlvBD8pkZrzq61tlU=;
 b=NvSe2YjNdvy90VsWwzW8OkMi4ms3N97Qmxch6v/S9fray3BvTxnrkL7d1ExMOVUb95
 8ssyD9f9iYoM0X4iBytydTlji+hBvf4sWBTldkXqYwk+vJfyKJUy2tf6zEUz9zOl2u8R
 pMwxnLp4gwJwW9mAKr1dKX6sMsyguja5gYQr78QNAp1bAMjz9cJTHs4L4OgsDxfBmkP0
 3+3gXDlpDEwRkJn62rj9vlatAVxsRGFVT0AJXm8VvmUw3sHGVYaztkMxPYv1okwcIuZc
 4Lo2HpbUCYSW8TL8Y0Odopk6sbA3kUdA8m0CQr48JalKCGkBZ5cUwQ53cfcyfUI5v4Tq
 jPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720422425; x=1721027225;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vlVTUIKaYOJSgq8jSLVoBvWZ83hlvBD8pkZrzq61tlU=;
 b=gzQj+iugMBLsb2slVt4Kc3bTRm0NhfSFYiI4GlqfUZjcWi65T1yNUJRhyG9LjTAMOc
 hNu6R1KQ1JBXBjgBo+YRmASHO7tUKZ7BKXFpXh7PBM4U5TfFiAl1dQMXrVqomkB4905f
 /diL1thqSDwBKmRJGZ1KAN66euZ/+nmbMNt0pcCJ/VbEjDQ/YES8YtQRLGVSLV9PT/7T
 exK9HYgH2OA9qdwvibXcom8hxMyhn/AcZMJh8t5PyB9ZhZTGVhC5z42QcXdo8VBNSXJc
 S1mB3PAwN0tXBmMfsNY9l640AEvrRuO/DKShZH5t3shZO19jPvhciZAEw7IZrNrhH1Wq
 pRmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzHGnHsabLVtTcmlyJN7wKl061JYqy2Ma8L+PIjJdTcPiM5X6f6ZwODKkxxGdYcN0m3tPEeUzqNRa1A34EMDx3ET0y
X-Gm-Message-State: AOJu0YwXBZcdriDDpYCYtPfvu3J8SujOQhfEVDgJ5vLIWvMeGJXIhKcE
 xI8Ic7TKirhaLMFxzQeiqz1+2voIKj3cu7w3mZVCt8G6lUgfQbzVdcbndGZJ
X-Google-Smtp-Source: AGHT+IG6Vobob8l6e2lZbO4LC5m4epMlULVvexqD92wIk1K+qQF1YLJfXX1C7dP7PA9+rZCfdEIlnw==
X-Received: by 2002:a05:6a20:2586:b0:1c0:f23b:cadc with SMTP id
 adf61e73a8af0-1c0f23bcbfcmr1569822637.35.1720422425606; 
 Mon, 08 Jul 2024 00:07:05 -0700 (PDT)
Received: from localhost ([1.146.34.14]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15991d1sm179380725ad.269.2024.07.08.00.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 00:07:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jul 2024 17:06:58 +1000
Message-Id: <D2JYUJXKDPRD.3DRAIXV5VMA3P@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 36/43] target/ppc/mmu-hash32: Remove some static inlines
 from header
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3b3cce4a39e0debbf6fa29d4a2ead3014898cb93.1716763435.git.balaton@eik.bme.hu>
 <D2GKNUSA4XP0.35L5LIXFHYBTB@gmail.com>
 <0ac3436c-94f1-4210-6d3f-6086a664cb90@eik.bme.hu>
In-Reply-To: <0ac3436c-94f1-4210-6d3f-6086a664cb90@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Sun Jul 7, 2024 at 6:18 AM AEST, BALATON Zoltan wrote:
> On Thu, 4 Jul 2024, Nicholas Piggin wrote:
> > On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> >> Two of these are not used anywhere and the other two are used only
> >> once and can be inlined and removed from the header.
> >
> > I'd prefer to put these in the .c file. Probably calculating the
> > base once would generate marginally better code since it would not
> > have to keep reloading it (since there is a barrier there it can't
> > cache the value).
>
> These aren't even used anywhere but one function and they are inefficient=
=20
> becuase they would call ppc_hash32_hpt_base() on each call. Next patch=20
> even removes base and calculates pte_addr once before the loop, then it's=
=20
> quite straight forward what these read from guest memory even without=20
> inline functions. I see no reason to keep these inline functions.

Make them take the hash base instead of cpu if that's the performance
issue to solve. And open coded access can always be converted to use
it.

Thanks,
Nick

