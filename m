Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA284CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZLQ-0001dQ-Ha; Thu, 28 Aug 2025 05:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urZLO-0001Vs-Dw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:54:58 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urZLJ-0001sJ-7q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:54:57 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d60157747so5082477b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756374891; x=1756979691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5cuLMkTrGIUfGZK8dOlX1Yo2Q0dConr95R6JOZ3VZs=;
 b=UFkAdsZFxxYGjxtIPE7dVlqQLs+bObkh/HqnfM4qWyp0vCiAcGw2SaY6mz4zueUrFW
 ORWftckvRWtJkhfmApghNznHbPcpqtAlW5ZDkh0bgBSTADq0hRt9WxyPnuqLwwJKV4U7
 do8B7oFOg6+wWs6XfTzeaxvWDrk83xEhw4r+EyIZmGTXaWqfP04TZRvRN2Vt3MoGno5x
 Fidj5VpBdpnDHFe95DBE7lHVwua7Nzj+Crgba0fkuwYHsS2aXE13VmWiDn85/N5lyh5k
 ahHTkIJHqq3QLWglaBs81zr1ZkqtNEx/bs+WURuEUHCnTx7UttTkw6SLWrcdt7GygJZm
 mifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756374891; x=1756979691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5cuLMkTrGIUfGZK8dOlX1Yo2Q0dConr95R6JOZ3VZs=;
 b=elW20m06zdwRVWNxWDbJKN8yPcSuyCB4sku1WZSHVHQ6a5F+1U4RQh/P6W/i2nUqR+
 /CLBJtXhzDNUE01Dom3hVPq/OboISHk9vvPfYiA6Mu6hNkOCYEE2rZCPCqcRwcL3xyX4
 UvBNcsfdyNm6WLpKFsSMMQKPSpltwV6SP+IbBNLRC4FDhmd/4D8kjlQmcBaPIo57779n
 ho028vlU6aUud9xzod7C5nSe9ePkVxhUPqDDAhOoInJ7IJZdBJSJTcPODLBSzzMFcK7R
 5SurvglITueBfqdA43v1aIZmQixnTPCIvZBaw+WyyN4VS3JSOxP4xJEstDHTR2ljTo4S
 Q8jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH/bNgZtJHcVkwdpuzW1rvRP3Qn6cNNwGUXrPUT+ehdnNQXNIx0/bFtk6KHpjssYtbJ7ZsJD3uYI/X@nongnu.org
X-Gm-Message-State: AOJu0YykqPe4u3sFGHGRgQq+EJpHnUzUhIqDsXsBB3ooLokyh9qXLHH4
 mqwt6GKY3qxjVG+cxNd8G9IkQLtCTooQbOBQX/NQb9BqG8cDxACaRNto+2aLf+6gKD83dRBWAjx
 bnXWe1pVyVg3tQKN2CCawU+hMKjAI3empIIXkun6Zrw==
X-Gm-Gg: ASbGnctcNRodKNoDfyfk25MEyTc/0l/S4pQRnvuJc4+W7SXW6DJRXqjfjH1K6ILSFh/
 wDwLJfoOFkK6dJrzcywkUCKHdYhgaoQt0gnRmR2l8EtOpU6TQNJb5YsEMNZtSW1wiMJyHad3ODE
 xCI1KOO1YGhzTr4cBqx4OP1jzouSsGYTVGB9QLi9ryMarY17wwGuK/dK6+l3wbPDzkzPHhtc4n1
 G35+wgV
X-Google-Smtp-Source: AGHT+IH1asPmt3hfFTeApbVWqmC/yn16kREJa7opNBY6lEnwGpSzdsabyq8Lb4YFOzu+WT4KUOeMOXZ2PJtMS0U5HdU=
X-Received: by 2002:a05:690c:9a82:b0:71f:c5f0:3368 with SMTP id
 00721157ae682-71fdc2abbcdmr257000137b3.9.1756374891034; Thu, 28 Aug 2025
 02:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
 <aKctCjv8newNIX71@x1.local>
 <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
 <aKdizYeNGocXvTzv@x1.local>
 <CAFEAcA8dKu3mSuD=rJkwDPcvqQASsOpFPdpG4Ht59GrTb+AywA@mail.gmail.com>
 <aK4tuhRfotpndpa8@x1.local>
 <e4e0b75a-0990-4108-88f9-f49a346f515b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e4e0b75a-0990-4108-88f9-f49a346f515b@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 10:54:39 +0100
X-Gm-Features: Ac12FXwe95w895vt43317GCb5qyjwRxrbzhY060KGeBnOSnWomN4fZy3ED-80-w
Message-ID: <CAFEAcA8o6abCbdL9nPqAfeh2BJmy8KmGeW8hrqqshm+BBriqkA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 28 Aug 2025 at 02:13, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> I'm not in favor of the change. There was a long discussion in the past,
> but I think the following email is the most comprehensive description of
> my point and includes comparison between the two approaches:
> https://lore.kernel.org/qemu-devel/2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com/
>
> So please check the email and reply it.

Do you have a version of your patch which works (i.e. doesn't
segfault) ?

-- PMM

