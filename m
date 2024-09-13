Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B33CFC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9SA-0006G1-Ki; Fri, 13 Sep 2024 12:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp9S7-00066a-Ms
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:47:23 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp9S6-0001ds-5z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:47:23 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d3e662791so59477966b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726246040; x=1726850840; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pz6WxGzES4RPJdz+rq0VyAzhMYB+4zn6azXaqw44G/I=;
 b=CKqoyekwpcJyFjZ8ZYvaq8PZe3KMsGSbGlotYY7VEmUEZNtNz6Eb57JhtAbthmDaD3
 6FYWfrJqEmwyRlana7jINPtDwFjJROXwO0qQNsb5bEtxsL1PSvLu3rpWygexQindYlZN
 PwLi/HI+EFD7OBYc9F85sYm0yRPMe+/HUNz4inmYWpLkiIS0ONcdz8mrPzHJqjYKfYAj
 NkVMFn8P99zHsR4HNKScNxXDqZKigPXOm79GY8g1sRwBrs+v55y8MPaWAdifCMmDhbdH
 tOWJysNbOMhL3ReWJyF5aACaaSMak9uqe3aUmFmPH3rZEpffYdTkzzz+zS6CSL0qGjlS
 NYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726246040; x=1726850840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pz6WxGzES4RPJdz+rq0VyAzhMYB+4zn6azXaqw44G/I=;
 b=hbNtT4cbAMMIMTSC/cWsV6cIRnQmOkcGG4QQiYwCJ+xce8FzpR5MDec0CiQK6E/V5K
 P/URPDKjO+Qw0CUppDjvzWem3aN/iGFaLC+IspU0zUgk0bOvDq5DSqk8tWms+i245Zay
 a2FW2nzInPa2E7lV0jjxgt+7uRRG//nDnCJ3JgcuRhC9172t1xJz4F+FS12XyEc5BY9U
 UeP8L0tNiNdUrNTL9WQvv0W5VW1oHCQI/7yvfMjaQyiC0AORWmR5sT/uHehzMyXgdMog
 WJqnGJXClpkH4KtKyt2ym+ZWa8lOD9870M1dfDa1hqw60hlkNQMGOHNFSiEPMlGFYIyr
 8NkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz7MVoddQP5GWUm6p+KOEq3QSZ8mn6F4Z6Oo1tvE4cIbz7YWrnCmpdrbrrPtzInFGkLG3eZ3RtweKE@nongnu.org
X-Gm-Message-State: AOJu0YxFiC6vrgh3ixguOkqZEmJi3sONUB1oWfIXwuRuOAl9YAQF7jjo
 5GrPpCLvh39Q8jwXDlcLZKRO7AlUGZ/KK4eZ7LEB1vTznNd6DU5uXrCvTINQ83XNKJnqLO6DfE3
 w74CZ6wEiaOEo64D27PRwEaYHBwQcp6KOVzT71A==
X-Google-Smtp-Source: AGHT+IFdygFnvEGre8kyT9nMXmagg5Grn1/zhLSAye7sNHDbpBcV8eKwP8a09iof5pm99gFXmn9d4SLba0O1anSDI94=
X-Received: by 2002:a05:6402:1d4d:b0:5c4:14b7:b3bf with SMTP id
 4fb4d7f45d1cf-5c41e09687bmr3133236a12.8.1726246040178; Fri, 13 Sep 2024
 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
 <ZuRgV7lS75BpDUox@x1n>
In-Reply-To: <ZuRgV7lS75BpDUox@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 17:47:08 +0100
Message-ID: <CAFEAcA9kSi1id2SnQWEPyM44GvSH=tPqf-Unhyk92xdy+xZkJg@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: Peter Xu <peterx@redhat.com>
Cc: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Fri, 13 Sept 2024 at 16:55, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 03:27:55PM +0100, Peter Maydell wrote:
> > Coverity is pretty unhappy about this trick, because it isn't able
> > to recognise that we can figure out the address of 'bounce'
> > from the address of 'bounce->buffer' and free it in the
> > address_space_unmap() code, so it thinks that every use
> > of address_space_map(), pci_dma_map(), etc, is a memory leak.
> > We can mark all those as false positives, of course, but it got
> > me wondering whether maybe we should have this function return
> > a struct that has all the information address_space_unmap()
> > needs rather than relying on it being able to figure it out
> > from the host memory pointer...
>
> Indeed that sounds like a viable option.  Looks like we don't have a lot of
> address_space_map() users.

There's quite a few wrappers of it too, so it's a little hard to count.
We might want to avoid the memory allocation in the common case
by having the caller pass in an ASMapInfo struct to be filled
in rather than having address_space_map() allocate-and-return one.

-- PMM

