Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB8EEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snytV-0005cA-Vw; Tue, 10 Sep 2024 07:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snytT-0005be-CH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:18:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snytR-0002BU-CB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:18:46 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so5171428a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725967123; x=1726571923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WscQcz9sCJfr8O9JWAgh9yO9vqwg8AiJbs0BmE3K8MY=;
 b=yu0mn6NX0V2UE1r44EWs61stlNNToSj+0WgvTlaE7Ccq/SPlRW0YZzeVZCO57H1hnK
 5A7e/fdqKQql6ZvKCLh1Qc460AbqC4LzyspyEQmUt8v3PWcINuo39LbrXiVcbZFNnQEa
 z20h4Za1Ao6egzGPB5Zk/n4vudCS4Caf4gfHbnxECwROdRN0+P5LYSZ9GYVwMWrhG8mm
 NCuitGv6dIezQ33Pn5jsgAKmPZkiIPCRo3dD+MKujXy0M3GyA3rfdfqpMhYQeGBb7Kwo
 IHxMA8YMEx/VIaGSU0XKgwwV41RMghvyZkJZ7cL0F+cn3A3D60MubPUyHmaV4iFXOon7
 iJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725967123; x=1726571923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WscQcz9sCJfr8O9JWAgh9yO9vqwg8AiJbs0BmE3K8MY=;
 b=geG0zFAUqHZiljVrqejT+uBmZHLv4twox/Uy+Dt5kvl5vz1C47haKkafnA3o73Ua+N
 zgn0ylLkOVlWc1cNBLLzRY7Xqzf7VikWeDaMaAj50X1/jCnDjEzfJBDe+npzRTU0YeCH
 /6altIFfNP/b2ptdNDk9jdVkrSy2wC0KYYyOQ2Ncpfo5cIS7xu2AuyFEq6NyGbjhukKE
 tRZlvBK6qKhQvR4QkCDxttzVYpjC+YRKQLr/suEp1hNFlfTp8v9xvwN/mtOO9w+jn73/
 0QllwiZvuOgF3DO6QPd9K5IKmR8KtOraCHrAgGPTaKLpEuMngH5r0ej0hptCe0rjQUeW
 hecw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+ARIJm9gcwQey7OE9xSTxhzsmcsheLwmaple896yrC6NARXI1dHim8WY8tLd1vb/q2vJOJfjoqgKn@nongnu.org
X-Gm-Message-State: AOJu0YxkWl8HdGp9pbxuW+Rkr4sabvRwk997sq5ljVKDxXcxsDNIFSdR
 U6GN2y8H4pTJnzXXiqrTEZ7Di3Zow90wH6gUsQrWhTIqWupLLtOfyx4EREJmhGn1yeGKIYioS96
 bp9ZljtkYPwMsZFsiNsNfz8AKG+4FCSdR/YplUg==
X-Google-Smtp-Source: AGHT+IHtQ9P/OIDfKoQUjca/ssv5WmH1BkciQ4ugz5pdb0V+IeWRHD54MGhYfhWa81Y6B7HyaW/yU4d5lF+y8mNNs4I=
X-Received: by 2002:a05:6402:2707:b0:5c2:5d97:ec9c with SMTP id
 4fb4d7f45d1cf-5c3eabff54bmr7791456a12.1.1725967123194; Tue, 10 Sep 2024
 04:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <5f193fa1-89ec-4424-b6fd-c7ae1a4beedf@linaro.org>
 <4942adc4-68f5-4d26-acfc-f47f531c9c43@linaro.org>
 <b04d662f-0ec1-4c93-a67a-d0e77df271cd@redhat.com>
In-Reply-To: <b04d662f-0ec1-4c93-a67a-d0e77df271cd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 12:18:31 +0100
Message-ID: <CAFEAcA_SHQsD__V19dn_csDRt2Fx7uq8opnkpDCQqQ1MDv4KAQ@mail.gmail.com>
Subject: Re: check-functional skipUnless failure
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 10 Sept 2024 at 08:37, Thomas Huth <thuth@redhat.com> wrote:
>
> On 10/09/2024 08.41, Philippe Mathieu-Daud=C3=A9 wrote:
> > While looking at this, I'm surprised to notice has_cmd() actually
> > *runs* the command by calling run_cmd(). I'd have expected it solely
> > checks for binary presence and RX perms, avoiding unexpected side
> > effects.
>
> It uses "which" to search for the binary ... that could be done better fo=
r
> sure (especially since "which" might not be available on all systems), bu=
t
> it already was done this way in the Avocado tests, so at least that's not=
 a
> regression.

So it runs an external binary, but it doesn't run the command
being searched for; "which" won't have any side effects.

-- PMM

