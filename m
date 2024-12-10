Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82B2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 19:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5X0-0007Ny-56; Tue, 10 Dec 2024 14:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5Wy-0007N2-0J
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:04:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5Wv-0008Fj-Vt
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:04:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a736518eso66393315e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733857460; x=1734462260; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OGkjgJoVOIfscBofiFo3Qdxd7d5Imd8MkB+b0+Zyxa8=;
 b=oSjXRpE9+zdCcS56MJMlYW4c1Xx5kU+HlnCiiOhKURpo6QFJq3TGERNiCYD5qp1vx9
 cUBRrrSXUFiJlY4ivf6FfBn29gjC1JpBXC4sSlQl0lkoLlqCpuBymTDX3qAfbYzyEGv7
 qvuG0kQOPKbKBw6YZ81PaAJxTMbsaBXix+abWiNRHHY089j0rO2aH718Z77bQ713hnoA
 g/79EtoIMwMiSG9t9m7dFAA3fYfhrNIOIO7CCc1q8jx35DfgcDllyO8gC2jETmJHPIT5
 EVcRik3NDtC4qFK9nPwqf0C7VVrimdc28DnEirPCZQk8RuxkLoaFxnk8AILRLzrRUHLk
 EbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733857460; x=1734462260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGkjgJoVOIfscBofiFo3Qdxd7d5Imd8MkB+b0+Zyxa8=;
 b=wFxB0MXD3sz4llyCj3xyvj77dlCP9q1s0FKBesgWoM+kc6VS8A/pvkQavYuDo1YOnP
 WzE2UxtNhFKd5erwq2I4CrRRi/8oT1VrYKutSy+llzVOq9zdUL/Z3uUHgIJupaK+cpVA
 6sXkSNDxI5btPE2i29syy9IdXrVFtEDvK4VtPVTEQfU8CqyP3buE3+DkZsOpHVz83ORV
 j1FfG0NZ5raJmrkBu0p/REfMorUqBJ4NEWAmEtwZ5cqwV4U8vU3IrQSEzz9Rqm3+ozlU
 b1NbZvMmAGEAqpvgBzQaR+YEYfAgUMhK9BZwSGXOKNgbs0s77/gXc7qOQVhqP7f25TM4
 Lzdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgeec7qNI3TzNKClQ6xXEakpb7jFSm38O+pWoH8yL9qZ+Hqe864bPSvut+lZvwDNTX7lxk5qSnqTDx@nongnu.org
X-Gm-Message-State: AOJu0Ywg6R+/qVu96Y8K8KvfzHIw5c5oCHDb2F6T8oz5qT90sPwYODhf
 MqYRPvq30EiDI8oYguyrPKQZt8lpYc4Zt6fa9uim+Cwc//hEVai3bsMVuuZriz8=
X-Gm-Gg: ASbGncswScv8qGMWVIYihQP0MlHH7Hidxr7z1HUcnw4qV5XM0C/78SrANsWbEdLnbpI
 EL308tNqpmhLl2hg3j7n9xE86RS8nvPc9mrMxZWZUzF/Ho3qrkV70+m1ljNQ/HpJ4fnm777cbex
 Jp+QurhGgBV5mW3WUcRJVgZBD0m6L989MGGliD/pwkICFMRbjtE/xe/5azaFCSLxuokqmLIEHvd
 /aIpXWI8IhnHDc0N0SpMKY2EHm5AQFMxKdfkwsewXEcnIsRFGud
X-Google-Smtp-Source: AGHT+IGvBRJU5VrvHHgELZZRyrW8eCUnsJp+fWL4M+Lzf4Iil54EchS3zFf3fpkiiJ2mrmbyb8g3kw==
X-Received: by 2002:a05:600c:458c:b0:434:9ec0:9e4e with SMTP id
 5b1f17b1804b1-434fffba059mr67946935e9.30.1733857459913; 
 Tue, 10 Dec 2024 11:04:19 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b158sm241081475e9.8.2024.12.10.11.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 11:04:19 -0800 (PST)
Date: Tue, 10 Dec 2024 19:04:43 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v3 24/26] hw/core/loader: Add fields to RomLoaderNotify
Message-ID: <20241210190443.GA1212502@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-26-jean-philippe@linaro.org>
 <ba650cb5-488c-4127-a307-ea16c9e44b5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba650cb5-488c-4127-a307-ea16c9e44b5d@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
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

On Thu, Dec 05, 2024 at 11:21:19PM +0100, Philippe Mathieu-Daudé wrote:
> On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> > In order to write an event log, the ROM load notification handler needs
> > two more fields.
> 
> IMHO it makes more sense to squash that in the "hw/core/loader:
> Add ROM loader notifier" patch introducing that API.

Yes I'd squash it if we decide that the patch 25, which needs this, is
useful. But it's possible that no one actually needs it so I left this
separate for the moment.

> 
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v2->v3: New
> > ---
> >   include/hw/loader.h | 2 ++
> >   hw/core/loader.c    | 2 ++
> >   2 files changed, 4 insertions(+)
> > 
> > diff --git a/include/hw/loader.h b/include/hw/loader.h
> > index 0cd9905f97..73f317966d 100644
> > --- a/include/hw/loader.h
> > +++ b/include/hw/loader.h
> > @@ -355,6 +355,8 @@ ssize_t rom_add_option(const char *file, int32_t bootindex);
> >   typedef struct RomLoaderNotify {
> >       /* Parameters passed to rom_add_blob() */
> > +    const char *name;
> 
> Description of the loaded ROM.
> 
> > +    uint8_t *data;
> 
> Or 'blob', blob_ptr. Maybe declare as 'const void *'?
> 
> >       hwaddr addr;
> 
> Now easier to document, where 'data' is addressed in guest memory.
> 
> >       size_t len;
> 
> Size of 'data'.

Thanks, I'll fix those

> 
> >       size_t max_len;
> 
> Still unused. Drop?

Yes

Thanks,
Jean


