Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64085C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 05:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcILN-0003Yf-32; Tue, 20 Feb 2024 00:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcILK-0003YM-BP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:06:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcILG-0005Ls-A6
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708405612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M87Ia9CmtgFb0IUX089a21xxM8F56o6mFGRF1nzxB6Q=;
 b=G96/im54aDTSyFKIx1J7hZT/X503kUmy3dGxT77Ib6bWI7N3FS8b6tz+74es2XH3NR5YVZ
 ElRt0H4p4EgQAhFR24I0RtHnECoRLxWeHH4JQsOLoaCzJgc1uMeCbqjMWEq+6EY6a6DwKM
 WeerMqq79KmVxCJSvHsrSowm8lX2xr0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-svTeHB7pNlqWhgoHhmOAHw-1; Tue, 20 Feb 2024 00:06:50 -0500
X-MC-Unique: svTeHB7pNlqWhgoHhmOAHw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso1374637b3a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 21:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708405609; x=1709010409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M87Ia9CmtgFb0IUX089a21xxM8F56o6mFGRF1nzxB6Q=;
 b=dy270/2hVSNYyy27pCQS6w1r9f8Fij5EiYxqhGpqK2sE4c+zKYwkayBLt2Y5TaI7oU
 u+fex1ix+4UC52csDZtHE9c29B0uYYIOdVlSra7dr0njYq91i9sHNM0VNh00vNw0AzFD
 HAXdaxhIQWqEHyWvtwLFfAFiZt7Asvh14NcgZbXDFwO5LkT3VCXyYiBAgajZZMNNqdUE
 o73vPX9KzUTz6559A5ogKoDLPFgk0dh6WmaJY7iNu7qLk/W2t2Czk2yTjbzqAcxjGkWX
 aemZv+/0HHdKnYu0xMCXnOPRofyQwfVFEVZc0QmjvJ6F+oKL8useTl3QVSmMiasdv4Rv
 Xxug==
X-Gm-Message-State: AOJu0YyUNgjF1wIDvwSU8qOouWjVApSZeSsGY/FRFq8aIu1MWv+bPzJo
 aMCn3GsW3YZ2vErcxw901ksB7I1Kkk1AtZt6R19kH1HhYlOkmlpwguxxU23iuFCug1yuUQK8+hZ
 O1oRZo20gvsGlZUc5lfdQhkE93OZ6EBRxOQ6jBEyLUSGhP/7L7EQ0
X-Received: by 2002:a05:6a21:33a1:b0:1a0:b393:8d04 with SMTP id
 yy33-20020a056a2133a100b001a0b3938d04mr1377855pzb.6.1708405609304; 
 Mon, 19 Feb 2024 21:06:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3mg6UdtO8hwCSgNzaBSVbO7OxkPWF82mz1FdVqJIvV+HlV+DX1wWYHg2TEY+x614EQGpNuw==
X-Received: by 2002:a05:6a21:33a1:b0:1a0:b393:8d04 with SMTP id
 yy33-20020a056a2133a100b001a0b3938d04mr1377832pzb.6.1708405608984; 
 Mon, 19 Feb 2024 21:06:48 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 kn14-20020a170903078e00b001d8f82c61cdsm5234344plb.231.2024.02.19.21.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 21:06:48 -0800 (PST)
Date: Tue, 20 Feb 2024 13:06:37 +0800
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, jag.raman@oracle.com, stefanha@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v7 0/5] Support message-based DMA in vfio-user server
Message-ID: <ZdQzXQwYNOxMOgGp@x1n>
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212080617.2559498-1-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Mon, Feb 12, 2024 at 12:06:12AM -0800, Mattias Nissler wrote:
> Changes from v6:
> 
> * Rebase, resolve straightforward merge conflict in system/dma-helpers.c

Hi, Mattias,

If the change is trivial, feel free to carry over my R-bs in the first two
patches in the commit message.

Thanks,

-- 
Peter Xu


