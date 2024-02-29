Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE9DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdzV-0005ya-A2; Thu, 29 Feb 2024 05:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rfdz9-0005tz-Nh
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:49:58 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rfdz7-00048B-SZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:49:55 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6e49518f375so301273a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709203790; x=1709808590;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+D3fAJZ2s8jBhrFy8IzN9yZY5HZfsjO9OcRirnbfZog=;
 b=BfEMGFHk/qTdTs/rzzERTX6fZpton2klntsUbRR286+4U4zdwmTdIELI4UCGYd99YL
 sPgUKYYBb7SdTzVxoCehnTysi9/6GaVYC3LvVTZatuzF5eizL/RwXTb3MH+qV/5bv5Xq
 wLODoY13mD4dKDMihIaTfCum7Tk7Pxyt3IiUb37YlRH/MhpV+ameg20Gx9LF/OsPan0b
 GDITaySXZr5hna02P5Iecmd1/Oxv2YeHQ+OVgwSbO77ZDrh0Y3Xqnt65yv41ApuKBCie
 5flbBkz1/wTzku2flpo4ECBSYHHFLybh/bfgrpQkBbsAU5jqctfIc/KDwmusDaiTIRdg
 A5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709203790; x=1709808590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+D3fAJZ2s8jBhrFy8IzN9yZY5HZfsjO9OcRirnbfZog=;
 b=kuhj2De6EcaNGeVmq+eFTEz3zBrhYaqQ5226LZYnrVvEEzMMpFikbEbQSKyFEDOAlA
 xADGIxcz/AHPTurkPrEFyPomMj+5AYMGJ2vpO7XfUUBcwJA8tpbJP9iftHPddtl0+pL7
 BNyQdYTdntR/6y9A3iX/E6GXcC4Z0B51MohUo3VYBxBW9Mw4nWPpa4T4Z8sSHlHxzRUS
 t4lOWM4DHRObv6ALgH/QlOP6ygzlyVrxcmoaAHCnZesFM7VbQeM3kns6eMekHlkFZRgg
 +TFoB/g0N0sFbYXlUovtj9/bDigAHiHeQKwc2fLp2c/kJNNspJ3qe9HOyYtfe2RD74z/
 /Imw==
X-Gm-Message-State: AOJu0YxZuOfxYEissK+DFYe2K2r//P8jZSE08vtc5VDcz+YSZ4asNhn+
 Md7AW3fhEdUCBnuHAeOvjQmhp6BvqPiYG4RP/TcrtKOAMxIY8g7QEAbbaTGrzH6KVmo84NTXFEY
 ktorcobTKgeMK3VX896cZUvQtzICCNP/Vl4Phcg==
X-Google-Smtp-Source: AGHT+IGK179407aT6LY5YLVHNqcU1UGrbqNPsPX4r2XyYy0U/9Tv8OXVCvZAEqS8XhkY/+ITRX++bFBMOA38AYlcR1I=
X-Received: by 2002:a05:6871:b0e:b0:220:a0ba:6bc8 with SMTP id
 fq14-20020a0568710b0e00b00220a0ba6bc8mr273566oab.55.1709203790277; Thu, 29
 Feb 2024 02:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
 <ZdQzXQwYNOxMOgGp@x1n>
In-Reply-To: <ZdQzXQwYNOxMOgGp@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 29 Feb 2024 11:49:39 +0100
Message-ID: <CAGNS4TaJQ6MVrX9-SijSdDAX8pRYFkYr4SkES63ZE4WSisqNRA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Support message-based DMA in vfio-user server
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, jag.raman@oracle.com, stefanha@redhat.com, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

I actually failed to carry forward the Reviewed-by tags from Jag,
Phillipe and Stefan as well when reposting even though I didn't make
any non-trivial changes to the respective patches. I intend to post
another version with the respective tags restored, but I'll give you a
day or two to speak up if you disagree.

Thanks,
Mattias

On Tue, Feb 20, 2024 at 6:06=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Feb 12, 2024 at 12:06:12AM -0800, Mattias Nissler wrote:
> > Changes from v6:
> >
> > * Rebase, resolve straightforward merge conflict in system/dma-helpers.=
c
>
> Hi, Mattias,
>
> If the change is trivial, feel free to carry over my R-bs in the first tw=
o
> patches in the commit message.
>
> Thanks,
>
> --
> Peter Xu
>

