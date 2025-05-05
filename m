Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0766C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBkwS-0001oK-Dq; Sun, 04 May 2025 21:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uBkwP-0001nb-OT; Sun, 04 May 2025 21:48:22 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uBkwO-00020T-F9; Sun, 04 May 2025 21:48:21 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c0b4a038fso2589301a34.0; 
 Sun, 04 May 2025 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746409698; x=1747014498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rt1RVdUv+SXhF6NFAs0h8VmaaP4dkV5k07Nk0TOpO8E=;
 b=anyGCdp6NwtWVwBBjNcJUMmY5LUmHBtqacWLFCLm1Vj1z966GGwvext4hFf1TalOS/
 1QeV6LARpd+3L41sqTulg/SYDdMWSNRbsLVkgphCKEOk/DsX0EpQY9pqeE1dY943yBW9
 wG4Tr9ncYCMHU+N1Fz6d2oGru6CqujMOtG8o8L4g4pfzjveq2jSELGJlLo0OILH95goj
 oxSQKRmi7RGH4XTl8iUJVy56UJ7jvXYbsJp4Kwhim74hibBCTzxUhJAsqdY8szYMsjFZ
 Mi7ENcfSkX2+s2gyc2aJwK5++msHmBakCJ2t8RXTwKT0dTJzB7rPtZjxW0sCW1gU9caa
 A/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409698; x=1747014498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rt1RVdUv+SXhF6NFAs0h8VmaaP4dkV5k07Nk0TOpO8E=;
 b=JBqb5DdYWYGVYGJ3nb5FU4o520MVylxkSt4piqVcDsZ+KJ0CG+91J8QRsXr/utygw+
 /DzEMjp4iJ52FUmVOXb+BcEqfGe0ii7eBgNbuYL2npjjrN7PKRpb4vIPnIBcLTWSQblj
 16YI+QiSMWCoBQPAbAWfgcwGMoa+hSA8K3otxLLKCRVIkNIZ+kCJ1DC2UTi0KBCpfxQX
 IfajvWDCfN6CmELe38tCwRkZt8noWm+MocqrK5PIVv3AFpKufAxLcThNfmB9W91kzubo
 rgb3Bc/wZazghz5/zQ4l9ONMxF/zfp6muIJODsL7kUSIfoWNKAgOxCQ6KhDqK7Nkm0/l
 T1eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUERNlKPWte3MelvX8sd+Eox3BNqmITnDWVaGagBGiT2lRZcnpoGzInCPuf6bkANPvwTwQEN62ULg==@nongnu.org,
 AJvYcCXl1LL0VOO7Xf3aq5p4WI2jLH98tuTqzV9teDjrsBSJyp0dYdaMyWij/2E+eQ6rUxVq6CbSv2RdpoEplQ==@nongnu.org
X-Gm-Message-State: AOJu0YyWJQQn2aNpfyCDAJvX3khRTfqmkuseha94Zwn9YxNbn5VUfnlk
 5groTU19wgREQO88EUe1PhA8VLAmjc4SMR+BoxuBkAWJ/PTOAiQrEkUu7RiECjJrSWqZFEx3wdJ
 rWcFehCF2hYxRxPeb8EncEWmGc78=
X-Gm-Gg: ASbGncvYXRRzGZe8dBS7eyOKJK1MR0f3RN5cajslGt4nQBmr7TIPSewM7HExqRG7MHE
 JFYfAb9pObtlA+1pFaWShQrFq0Cp+gIg3PTwPiJpbqQ+9bZibViz+cwbHZ0a5RWIWxOeNkDCvjb
 K7lCjp3sgQAlVyLV/Nu1QNf9I=
X-Google-Smtp-Source: AGHT+IGujzd5XSNOrG8MuQ2o0yNZREQcmv+j/eH2vS82K/TtFsCaCYRKK0z8hkzWpjZBuLHbqe92Y3jDWhAXaj4A/0c=
X-Received: by 2002:a05:6870:a54c:b0:29e:1cd8:4a0f with SMTP id
 586e51a60fabf-2dab305b6dbmr6135386fac.17.1746409698230; Sun, 04 May 2025
 18:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250428022934.3081139-1-timlee660101@gmail.com>
 <CAFEAcA9tUdcunWBrtbxXhkjjrABM_EN8ZC+HKUNG0nWoOjPQ5w@mail.gmail.com>
In-Reply-To: <CAFEAcA9tUdcunWBrtbxXhkjjrABM_EN8ZC+HKUNG0nWoOjPQ5w@mail.gmail.com>
From: Tim Lee <timlee660101@gmail.com>
Date: Mon, 5 May 2025 09:48:06 +0800
X-Gm-Features: ATxdqUHLqRU0qLgN_wbM7lIOFpo2xrkYsY4xnppRxvv4BR42HfzObnz6oLHGjzc
Message-ID: <CAJG6D+jz94O9nQp8jLTWApRqTSzNCkXSYFAC-kLp1i6OV_kOGA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of
 NPCM8XX SoC
To: Peter Maydell <peter.maydell@linaro.org>
Cc: wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=timlee660101@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

> Is this worth backporting to stable branches?
>
> Applied to target-arm.next, thanks.
>
> -- PMM

Hi Peter,
Thank you for taking the time to review this. I believe it is worth
backporting to stable branches.
The string "cortex-a9" and "cortex-a35" will point to different
ARMCPUInfo which could cause some features to not be applied correctly
in specific initial functions: "cortex_a9_initfn" and
"aarch64_a35_initfn".

Sincerely,
Tim Lee

