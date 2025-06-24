Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADE8C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 16:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU66b-00055D-BL; Tue, 24 Jun 2025 12:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU66X-00054t-AD
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU66V-0002Wj-FJ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750780954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oGDKkGGH4utY4WloGhQwH3yjf3wz8W+vm0HYQ12snAM=;
 b=Bw8isOR+Fwbj2dDVkDthSDtW+jCAOEcVXLHEQ/h/zEuK3R5cJXZqAFlS8QahwUV+6gcJ/q
 jatRsIlCC75Q6STzXckfcDF/KHMIFFUdraebkd+Vids6B5nTKMjmoUE9Vc9FhEnIHMyts5
 6UYhmy/9TKk7NwWELwX39WiSA4ZoIgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-W-h_2u32N2O-NbSN6LoUXg-1; Tue, 24 Jun 2025 12:02:32 -0400
X-MC-Unique: W-h_2u32N2O-NbSN6LoUXg-1
X-Mimecast-MFC-AGG-ID: W-h_2u32N2O-NbSN6LoUXg_1750780951
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d64026baso3804745e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 09:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750780951; x=1751385751;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGDKkGGH4utY4WloGhQwH3yjf3wz8W+vm0HYQ12snAM=;
 b=dXW8MiOOwQmrynCwC867TaTjVsEUMdp2lnDaOELw4IfiY5q7iklUU1lQ0foytpCqzG
 yVwnzn2yXxqRhoWUU0KtYvD1IWEEPAIGnSIFuH+JhXrYd9bz+XeJoTgayMpGUrD+PZOx
 Wby6sMM6EAy+kJj4XRsgSNnGFfMl74kniNBloeS4eTv/f6jwKeQJKVGvwKJw23kgnm0G
 aCyTbrSEQ4nTD1ZowoVk7/LFj003Ffp2hb5+/1CSI8of7otFHoosCMINdEnx4CHYUrnf
 zimqyzH1hTc+y+JtFnrnrZACw8ltjMGLtkfQpb+21FXkaa57xcvArwCCaAn8NZWc/nq1
 Lojw==
X-Gm-Message-State: AOJu0YyxoEesNcWx0yMb3Fo0LO4XoK5UR5Mlf0yscYjPdWcy6chDKAgV
 Vha3cTrO9y+upl//V4s8V5JBaz70rPcAB3ntCdKXV3alkbhfkHv5yjtWS2jDO9L0P/k97Qakyn8
 7LApvdWhoBhioVfEOvK01h4wC06OoMhXqKyyt5/6JGdzSZd4D6x0F/z8C
X-Gm-Gg: ASbGncskCWw2yoohUjDjdSSAe5Nfz4E+AfAaDa++DfCBTbMjR7Lh54XvM7R9Fe7kOYb
 5BjT1CDgqjafTcv9P5ulMFmi3+kCFfokn3liZV1kHReBspE/lgas0LztIW5gAItjH6eKAwycKPt
 Dt7u7CB4aRu01kSBUBiH8KwuiwNiYD1zffpnSI4vB1mj8D1VZMeWP9CIXWUiqUnhq2pIGgmD/m1
 aD6VDQB7JV69UJlQzhk3XmJsjDzZj4tLLRKJxdjBFeKSvP0gMUbGQDr/qSTxJmYkoFdN6HLV3Vu
 by5UxsrGQTwI3t9B/SwboLH4T3YHVb66AmBIdhMnBUfIuws6xkZTngboqaUwMco=
X-Received: by 2002:a05:600c:c4ac:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-453659be428mr151525325e9.5.1750780949365; 
 Tue, 24 Jun 2025 09:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsgJtIF/q+xXJakrr8bFVkMSVf0pfMg7rpGlzl8v/qqutgG1JfZaIKApyeILm9MV3RHWA7DQ==
X-Received: by 2002:a05:600c:c4ac:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-453659be428mr151522985e9.5.1750780947265; 
 Tue, 24 Jun 2025 09:02:27 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45380fd167bsm2575875e9.0.2025.06.24.09.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 09:02:26 -0700 (PDT)
Message-ID: <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
Date: Tue, 24 Jun 2025 18:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Warner Losh <imp@bsdimp.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/06/2025 03.46, Warner Losh wrote:
> 
> 
> On Sat, Jun 21, 2025, 6:01 PM Stefan Hajnoczi <stefanha@gmail.com 
> <mailto:stefanha@gmail.com>> wrote:
> 
>     On Sat, Jun 21, 2025 at 7:59 PM Stefan Hajnoczi <stefanha@gmail.com
>     <mailto:stefanha@gmail.com>> wrote:
> 
>     (I forgot to CC qemu-devel)
> 
>      >
>      > Hi,
>      > This might only be temporary, but the CI is getting HTTP 404 Not Found
>      > for the following URL:
>      > https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/
>     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso <https://
>     download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/
>     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso>
>      >
>      > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848
>     <https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848>
>      >
>      > Stefan
> 
> 
> Time to bump the version to 14.3.

Hmm, while we're used to refresh the CI images for the *host* environments, 
it's rather ugly to see images for the *guests* of the functional tests 
disappear. Maybe we should rather remove that test if the URL is not stable?

  Thomas


