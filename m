Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1811CC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqph-0007s5-U4; Mon, 08 Jul 2024 12:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sQqpV-0007Y1-Nr
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:03:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sQqpU-0006xY-6C
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:03:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fb2936c4ccso750565ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720454582; x=1721059382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HgKbQzZMz4AaCr+vkOiDWP2hLiq6mq8M/IaRAJpeiHc=;
 b=VceL++PzANuTQNz2V39Gmk5Qzx2SLE8VVM6uqROnzIGNqHNaPCloVsuyE4QoDL0Mrt
 fO/xLeV9gdKDjv+q5VXgzqC52bnKNXG5UFoZq7lUSn1GG8RuisNkCNzrZZBUaPEk4dFR
 emnEPCyYQ/dSNZkaBQuvtmqywvKXLEzOzgj/B4kYUezHhtfGfcS9NjEGwPJF1f74TwJm
 vIi44jIc63SeiZfEmUGXvGAHpsZr5rnuliILZucX8Imz1OxSEyMrLV8vEwj7UJjFu3Jv
 7wxeINlNkg4RaL6UI+e/Lej3O3aQmJnjSYNGnDIZYPkwTTMXdPh1i5g1s7xIxw/pCNlw
 WkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454582; x=1721059382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HgKbQzZMz4AaCr+vkOiDWP2hLiq6mq8M/IaRAJpeiHc=;
 b=QPWAYtw/zKzBenaW6+Ojf+vDfy7i+XIavCakwDh2au++Pes74RdtYwvdDmKnAZrz1I
 9oA5Q14HjQxVqCROcbaNY8hPtWUFmKyJlhuZXmpTFtFmbmrBNfzwSP5cG7wipNf83ilN
 /5/vMQcqzx02tArjvcZGYKYYmYOmvEuQyNkNEKt6aFVjhRBSER37uS+KkpRFjP3BmdMb
 igvHqGcZD4e4N+qmS4dZQPUFBI02A5TSvndqKCiKBEQgew8bC94G9cvgFGWH4vHtCN0K
 LwBLNHQShVLU9Q54Ef5GptVJmDYEBBujyOqzOYwVmIOdCoTZ3+bkZkki/Txpog/kgZGE
 OSEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqkbtp9Le0+efXJvwdS4X0lJ7+r78m+oZ35RRftUvvz3UGwEQLCwSt8Md6zqZc96ciYCyhpeALqlECyHj+GUrr/Z9YtHo=
X-Gm-Message-State: AOJu0YyBEo8NRRipJCA5/8nvP9MWS/6fLEb2ui1tCqbnuhfBix+JllMo
 OtMVhJmNcXLg+gEqRUWKw8cQGka4TQ8/osXm2whNAVPE28Nk6b2ESIeJJsCDSjL9hQRMba7nj2B
 KQ33o2gg32dPkm71VsluRpS9O22yes7i6LTdp
X-Google-Smtp-Source: AGHT+IGScupyFUGrkq6wdqfcEE+fHoGzTS9dNe4Ot3VuWr5nOp3+2u/uGeWaC8EIjznhYMZafsrkkvhVsXQi2ZBQOZM=
X-Received: by 2002:a17:902:ed8b:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1fb325bfb91mr9333705ad.3.1720454581367; Mon, 08 Jul 2024
 09:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
 <20240701211531.97637-1-rkir@google.com>
In-Reply-To: <20240701211531.97637-1-rkir@google.com>
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 8 Jul 2024 09:02:50 -0700
Message-ID: <CAOGAQeq_s3iT6m9m4gwhuD5BFc1FwM7hHTNvq9htAB4NA1u=kw@mail.gmail.com>
Subject: Re: [PATCH v4] Add timer_join to avoid racing in timer cleanup
To: pbonzini@redhat.com
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rkir@google.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Paolo,

could you please take a look?

Regards,
Roman.

