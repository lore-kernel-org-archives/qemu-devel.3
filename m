Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53D4C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZ9k-0003ki-52; Wed, 10 Jul 2024 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZ9i-0003jv-BD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:22:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZ9e-0008Hc-Vu
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:22:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70b09c2ade6so3585166b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720624969; x=1721229769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CPa7X5G++fW8aEmAOJVOGH6thhi06fZeImIhoRzbwt8=;
 b=GNELNsAClJDCV7SC6Ys9s/S1i3vTh/8sLzkjBno0Y45vw4kllCjaEg2zPwkTvB5kvz
 uEhYSR7UDaSQ3pvJRLwYsnOlUTTpFN48HIE1p/OA2aItQFX2aUyGr32Zmbl3HlmBOsij
 dcPNOLbG78qX/Jn+v9m1Qh0J63nK995c5WWng0gf5SSeKg9AQD2ZlEU5+IImRfj4zq5O
 ax9EVrICmKMhgA+7vF3289u73K5u4Vogus8RgoyMZc2xCkTHw0L2L025kJfB76RUTXgC
 1VwAtCJUa0wYuUeAUoeX3D1cs2wICuNqWsHJHaH1mNs9izWdjAv7UfgVw1hs2swGCV3C
 k1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720624969; x=1721229769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CPa7X5G++fW8aEmAOJVOGH6thhi06fZeImIhoRzbwt8=;
 b=SrPS9Ua+ANAnHGhVBRcdaVUcq77X/UtRdd/eRO9fANtat/pXuqdt4o/mslX1JToKNA
 3jTNb/wRaFSUG2iqJYseMOGQsrXLq/cleTx4PnEKC1E8ZVQJ+SNRaTR3tL/cG0GvTcg7
 1I5aaqbDjT9MWUg22pmHcIpzkgfKjAYk7lX+nEknyWhY0Xboss3N3EQsl3ihIb+jIYI4
 DDibbG3s6bFx3pIUMFmdNrg7WjMBNyY0JnTlMK50+AzM/+yS6z0H26kAZFbIRAPYcWcb
 s15W2D6G9PFAhDtevB+TwjtmgULN0UmqdgRpHV3AfeheEchXAQ41rl//LSqdcOxXdbL7
 OM2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3+jQqGtqohmD+pmnur+yUjlPKoRON+w9tAAFiEjVXVApA69LLBTJIS54qQxU7JfGWS+9twpXitWq9gcB7ixzp/mhaRgk=
X-Gm-Message-State: AOJu0YwJcNBIiUNG93Lw9rvPMNobcZQqoNpbbsyTkrWT73BSrv8UVGVh
 mLBTZ9xvP8DIpvNh8ZN5RDGa1RSAqtppH+ngZcssDOWTzARu3KKS/hrLnW095Lw=
X-Google-Smtp-Source: AGHT+IEZkJo3UQfh68v4RFKzbBt+uc8q6KHRd8kkoqe+ovnwQQkuycz/LaG9R4/SDziYYEo0Vhel8A==
X-Received: by 2002:a05:6a00:3cc6:b0:705:d805:215b with SMTP id
 d2e1a72fcca58-70b4364ffb1mr6471727b3a.27.1720624968897; 
 Wed, 10 Jul 2024 08:22:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438997d4sm3925151b3a.28.2024.07.10.08.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 08:22:48 -0700 (PDT)
Message-ID: <498f2e65-2502-475d-bf18-da1996fcad3b@linaro.org>
Date: Wed, 10 Jul 2024 08:22:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/i386/tcg: Allow IRET from user mode to user
 mode with SMAP
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> This fixes a bug wherein i386/tcg assumed an interrupt return using
> the IRET instruction was always returning from kernel mode to either
> kernel mode or user mode. This assumption is violated when IRET is used
> as a clever way to restore thread state, as for example in the dotnet
> runtime. There, IRET returns from user mode to user mode.
> 
> This bug is that stack accesses from IRET and RETF, as well as accesses
> to the parameters in a call gate, are normal data accesses using the
> current CPL.  This manifested itself as a page fault in the guest Linux
> kernel due to SMAP preventing the access.
> 
> This bug appears to have been in QEMU since the beginning.
> 
> Analyzed-by: Robert R. Henry<rrh.henry@gmail.com>
> Co-developed-by: Robert R. Henry<rrh.henry@gmail.com>
> Signed-off-by: Robert R. Henry<rrh.henry@gmail.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

