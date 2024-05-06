Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91853C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3za3-0003bF-Ls; Mon, 06 May 2024 10:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s3zZy-0003al-MT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s3zZv-0000Xa-NS
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715006669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r4IMUI1cggfAU+LsiLUGxeeA7y8FTnw1s8bqs3x7z/w=;
 b=NEeABj+T+XiF5RggzDGBgyuFfhoTpK4Oep5ZuQLavntqumFVyDsq24WGB5XAttgHZ2vt2y
 i7ICnJ30DEZ8xds0GhAkcmuswi/4AFffPepUdS46IbiKIef1Gm19khOqwv4YKzXc87Jm6a
 oWvM+L5coofRA3GfTy+ypLhp+M+JJ8w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-MvkptNb4OxiS_aPdg6JzMg-1; Mon, 06 May 2024 10:44:28 -0400
X-MC-Unique: MvkptNb4OxiS_aPdg6JzMg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0f87048e6so6194066d6.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715006668; x=1715611468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4IMUI1cggfAU+LsiLUGxeeA7y8FTnw1s8bqs3x7z/w=;
 b=uqnvcTiNlTM0Tcg8ETeK0bfaU540HlpZiOVpwxWqKjfyM0d+USUJMwPtb6aX3zrg6Q
 ViAU7Mr6M5UHqpRWHFdXp7MxjsBnYxcmifngy0DAizgskEmfIdR74mYcv7j0Rjeh3oTs
 6MM2ak2/bLNaOEFnstxnTjBkbFLuB1RMB5npEkWmvrbN6/e/61TohQ38eEt4NIJ+ir24
 LI7wbGTG2BkkhzE8qdiKKJjXsZg5usUTQ/tSQFVJeQqc7zmYUkv1fc8XQ0pTuYE93N6k
 OfjkVyBskjGyI1PnCuHL2LSePyrQTfJy2JCPB9lKAxm2d/quNWB51+vyGL6/owHs25aD
 VWtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb1Ce5y/KBtLcNGsNjXhpZ6I7f4soA7N4NySe7B4wqvYDvaI5/S5c0DZ6GNnDejl9+c8rg0KvinaRHRCbpcuX6CftoGRo=
X-Gm-Message-State: AOJu0YwCUDI5hxa/sMU0MfLakIcpdWa05LKGlve9KiOo8puVW+YLl/uz
 J9/lqbecV2iHQAKgblTGU4jzoF4pe4Zf6qpU/D16e/z7Yao3Yyy9ycfnvL+2lIeOknEGOLQL2NZ
 XCLwRPptfZl89WaqCOUzuyN5kybp8Kko7i1HcoDNVFXG45dEvGqmG
X-Received: by 2002:a05:620a:2549:b0:790:e856:7cc9 with SMTP id
 s9-20020a05620a254900b00790e8567cc9mr11600450qko.1.1715006667566; 
 Mon, 06 May 2024 07:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfL3HiTUS+hqjqsQjfldVC248fqr2KuSEJBs7rUzAeZ6De8qv3PvQ/w3zz/cGoXSLoKx2zww==
X-Received: by 2002:a05:620a:2549:b0:790:e856:7cc9 with SMTP id
 s9-20020a05620a254900b00790e8567cc9mr11600413qko.1.1715006666791; 
 Mon, 06 May 2024 07:44:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 s6-20020a05620a0bc600b0078ede411c92sm3940284qki.27.2024.05.06.07.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 07:44:26 -0700 (PDT)
Date: Mon, 6 May 2024 10:44:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
Message-ID: <ZjjsyF_ZMIPGqcci@x1n>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 28, 2024 at 08:53:36AM +0100, Mattias Nissler wrote:
> Stefan, to the best of my knowledge this is fully reviewed and ready
> to go in - can you kindly pick it up or advise in case there's
> something I missed? Thanks!

Fails cross-compile on mipsel:

https://gitlab.com/peterx/qemu/-/jobs/6787790601

IIUC it should be the same for all 32bits systems that do not support 64bit
atomics.  Perhaps the easiest fix is switching all *bounce_buffer_size to 32bit.

Thanks,

-- 
Peter Xu


