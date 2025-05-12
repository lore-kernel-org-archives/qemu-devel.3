Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4518CC3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uET50-0004l7-GP; Mon, 12 May 2025 09:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uET4y-0004kr-P8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:20:24 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uET4x-0000CF-2Q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:20:24 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70a2970cb70so34942577b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747056021; x=1747660821; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6mXSmKnTBYqnw6m5hNsXXkTA9MVJrHT3pRuFmCuTE0=;
 b=addIOlK8BkOzWRNeccTJhAJLq0jGnr+ZWvwoCdSznz7NhBZF9dmVzfwBiBCrichPCM
 FysyWb4X9BfWhqEsXXGFTwdC4ogk27CvUAr8hZP1ewjAc8Mtj/2MtKOoARIcWj8lFitp
 JkmNh0UnZkqwAqpQE+mt0LLKtvqpagltv6pNRXSEu3uQNCtZl2HQVTMw4JAAk7/GnSd3
 d+8D+XY9SPinIKwyYiil33y5we2JmmAR943tUg26Xwrgm/Ue5VQn+tVX6sqBkgi5cAPH
 XVIYGEiEXcY1rr8K1XVqiedQGA30G4liPb/d7wnaZhIP/u6/YjWJFX0nEKjy7OeG/FbK
 doyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747056021; x=1747660821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6mXSmKnTBYqnw6m5hNsXXkTA9MVJrHT3pRuFmCuTE0=;
 b=YYMGeLdilVtDnRwj73AE9Rq7hAOYN2PKfsUZMBwFPQp11JcmtS/48pwkEjlBMfFvGK
 9zvpOs1xy5x6R3sMUtzxPtrc4YkEOOPwPXem+BDyW3ul5rtrKvhxGQeXZQGxkSrlROAT
 6vqO7JeLYEU6rmdkhPu41YMvNMdH9Zhm2Gi+vyFYtno3YP4nbMd+KUZA6+5YTO3EOaN3
 6ltsCJNSq6iiL4v4Vzw+O+2HpijTtRtBRjugRL5UsL04fXk97DRr9P3HCASPuC0ehRVz
 KgaPW0jBLlLH9UywJxkVdcem3WqPqDZMN/UI9CKADlX7uN/13T8IN4avvBA6W+stw685
 wr1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOmCq3EYW20/g48/BX+nzVYP6IxhzGrbcsPz4JJD7T+xNzGrr7VrZ9y8aVjMiGsO7weKNKUowt4rvh@nongnu.org
X-Gm-Message-State: AOJu0YztyeXs8yG7qoR++tZxzuEnFx4ljTViKVq1rUQacc1fYkzCALwE
 HDKeXTxvhO087jT1j3kKthIicfGDtIOjQkL8OjOS7r5wMyJdicUZk3wG5MFETRUUi48zwuBuR4q
 6szBTtqr7wWl3nvbohoTprvxA+5bfPtMhR1ALmA==
X-Gm-Gg: ASbGncvtRaklhwxClTWQbB6cYZgLSqnx27hRkzQ/uxh/9+Qnb4VIF+gFgL1Qvfg61ZN
 32e/a2KiWe4Zqb3PVOR4i+UaX13HG1oz9IGe6z3R4lpzEagbe2t+HGYM9Hz54muAOv2ZqNtxkJG
 7k6FSNKI+5u+RFH/r9gO+/A6kOnH1hgS29EHh2fj6t6pDD
X-Google-Smtp-Source: AGHT+IHHwAuKSmPnpt0bJib98HLleSQjMG4R8Fmh9e7yKaDau6L8VSxMC0tcObRTF5sKbGfXw2kkXWwnCiZyUwuFSWA=
X-Received: by 2002:a05:690c:6413:b0:708:b7fd:bb03 with SMTP id
 00721157ae682-70a3fa1b23emr184731487b3.13.1747056021378; Mon, 12 May 2025
 06:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <D9NUVWSVJKHN.3T7M6OPALIGYC@gmail.com>
 <aBh-tXqR6RqXvx9D@redhat.com>
In-Reply-To: <aBh-tXqR6RqXvx9D@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 14:20:10 +0100
X-Gm-Features: AX0GCFtCMDOwVIR2sw7giNOztBUkNDqgN5o21abFni5TiEpEZf8CB9ouBw6s63A
Message-ID: <CAFEAcA_giWU5xC8GqjbvQUV7K-M_1iKrKoQBvB9Xj3qtLRZtxg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] usb/xhci and usb/msd improvements and tests
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 5 May 2025 at 10:03, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 05.05.2025 um 04:03 hat Nicholas Piggin geschrieben:
> > I would like to get this series merged, but I realize the mass storage
> > change to relax packet ordering of a command particularly is quite
> > complicated and under-reviewed.
>
> I can try to find the time to have a look at the series, but given that
> I'll have to familiarise myself with the specs again, it might take a
> while.
>
> > Would there be objection if I made a pull request for Guenter's
> > patches, the hcd stuff, the qtests, and some of the easier / reviewed
> > bits of msd?
>
> That makes sense to me. I suppose I can also give a quick review for the
> initial part of the msd patches, at lot of which seems to be more or
> less just refactoring.

I've now reviewed the hw/usb/xhci patches, so I think you
now have reviews for everything here except the tests/qtest/
patches (3, 4, 5, 7, 8, 21).

-- PMM

