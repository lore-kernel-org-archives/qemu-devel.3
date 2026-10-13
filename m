Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3623DCC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGjkW-0006SF-UP; Tue, 13 Oct 2026 17:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGjkR-0006RW-Fa
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGjkP-00014F-H6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791925759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Wte4V1TByA5GTAm2TYb+/xzeqeQov+hLeOuK1bDb8U=;
 b=Mq+SXYD3YiJlXOg/nuRUVWmJf+sakWrzFbFNW3z3tRM4VZDuLa80NUi3ch/GdBWtF/jpPr
 x4DgM0l1QVUz/IWGAzEtyQZfYp8rwnObkcSdEDQ1NeSqpU6LtVZOr6fUhd8ZIKlIeGrn/1
 9iUDV6sQbePNfh3L98aZjHYoXzbzUMs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-3YNgjFiyNtiJieXzDb24vQ-1; Tue, 13 Oct 2026 21:09:18 +0000
X-MC-Unique: 3YNgjFiyNtiJieXzDb24vQ-1
X-Mimecast-MFC-AGG-ID: 3YNgjFiyNtiJieXzDb24vQ_1791925758
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-535213e3a7aso73962591cf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791925758; x=1792530558; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Wte4V1TByA5GTAm2TYb+/xzeqeQov+hLeOuK1bDb8U=;
 b=BksDXlj6riuvhL98EM3kX2cV9HEy904MiMLf4XBt18LdYNviaQst4UkyXFLBXopX61
 Pbe76otNo4vzPHbZmXrSqMCjvlzkcDadZ8tKCZiXO89CXVKNioU5PhMtuG9UttdWojdM
 e006MKNdTJexlMmPz+XVc3D7uz54QhRNyIwnHdRN2Q7gaNcBm/O/s6tGV8A8LRnANJBF
 jkwJxjrSE4iAjQ/uivDRb6iDwEYLlM0GJR8DP7RM3WTtBTd20Ti83wLORrkkQx2hwpFY
 96hmD5evVhpA3/HbqfX+G0Uz+lN8Ecwk4RabxD7zn3bhlKytmnTLmi8h2xsfR70ZKkHG
 1Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791925758; x=1792530558;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Wte4V1TByA5GTAm2TYb+/xzeqeQov+hLeOuK1bDb8U=;
 b=lucmkAVc3I5V+BkVtjBrMK5IOniO3pssziYM9n4l0TEk6xAbQp4XTJwuDw/xBKebpS
 +SFSNapJt6fi3LEPymnlOSPWz6r9UPI8Xq+F3OVTtbGOBgiywK4vkbW/SGHKjxtw9Qnx
 tJCdg1SZ0qs0Eob4rqtruAE7tdUFHBHBSrlOUmPbJAWbu5Yy+9l3DowvtDZT0qLrFXPU
 i4mjkSizbj+KDTChzG82TvY0WXmjjnkhs5rD7IsMaii/fVHNX6fTbx9m+UwueQRtRXf7
 vHZQC7vFFJHac/qwDfQqQpbldsWRYBFlUoOMxFXb14r+CWbbvi+EJYTYSb+EWGgtcahj
 difg==
X-Gm-Message-State: AFq9FYLdtc9amXJNROW3OJh5La4ccz5yz1pXdXEAB6UScTnfDO1LKj24
 0BeeYeUokqaIinklXSZNZEXt7S6KxR3nHoeMr5QRTD1nfOMFL4fodld/Qr+KlMMgNS3VVTN4Mph
 CJc8UPNi+vT8z8g3c/pwHQd4zuLxN8HyFmydpJxciw8NsfvzJHxwlldwb
X-Gm-Gg: AYBFou2Y47NeyEhvCLpSla+fw+K61kbNUTkP2YTOtHaC8yxGXnfZQEIrxeYisb1yl6f
 k/7vDpmntJQiXO/qR2xO80vKQAduOemmTpWQt7hkPEOuYa/FqreDVCbQSLulETzUpAe8R8XeXOx
 dM1GakS6lt/NyA4QGnP8GC+UUXtHrlA83N/bWxoXZFglHuYsxoHDscWi6TG/CcP3GcmyPT0FI6/
 zScK0QiSrTM3OCYnXo+KaHMW85ozkL/r4Ab0SURFTDihf/ArhpiILvssdidBnq++3vx/GpdMc1i
 pJWsA1Y0nCAiOxx5yS7t7n/OKd/lQVdpwhhwWgzEQ/HXWyN22ZJ0tTeU1excTe+/jan9YYg=
X-Received: by 2002:ac8:5c8c:0:b0:535:27ed:9793 with SMTP id
 d75a77b69052e-5359f494d00mr221367811cf.3.1791925757706; 
 Tue, 13 Oct 2026 14:09:17 -0700 (PDT)
X-Received: by 2002:ac8:5c8c:0:b0:535:27ed:9793 with SMTP id
 d75a77b69052e-5359f494d00mr221367341cf.3.1791925757119; 
 Tue, 13 Oct 2026 14:09:17 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b277938sm111107751cf.0.2026.10.13.14.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 14:09:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:09:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, mjt@tls.msk.ru
Subject: Re: [PATCH v2 0/3] releases: build and run any QEMU release easily!
Message-ID: <as6d-7bwBOyz88hq@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Oct 11, 2026 at 04:27:34PM +0000, Pierrick Bouvier wrote:
> This series was inspired by a recent post from Fabiano to provide container
> images for migration tests:
> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
> 
> The idea to be able to build and run any QEMU (past) release with containers was
> in my mind for some time, so I gave it a shot. Finally, it was easier than
> expected to obtain a single dockerfile (with a few hacks) that works over all
> our releases.
> 
> The oldest functional distro we can find nowadays is ubuntu 14.04. Because of
> this, the oldest QEMU release we can build is v1.6.1. Previous ones require an
> environment we can't get easily today.
> 
> Images have the absolute minimal content possible. It's only qemu binaries,
> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
> tool included. As a result, images have a size from 240MB (v1.6.1) to ~1GB
> (v11.0.0).
> 
> This series adds 3 pieces:
> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>   Ubuntu version when building a given QEMU version.
> - A script build_release_container.sh which automatically detects which ubuntu
>   version a given release should be buildable on (based on date). It works
>   great, and the heuristic works for all our versions.
> - a script generate_release_links.sh which creates wrapper scripts automatically
>   using prebuilt images (hosted on my dockerhub).
> 
> TLDR:
> $ ./scripts/build_release_container.sh v1.6.1
> $ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version
> 
> $ ./script/generate_release_links.sh qemu-time-machine
> $ ./qemu-time-machine/v1.6.1/qemu-system-arm --version
> QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
> $ ./qemu-time-machine/v11.0.0/qemu-system-arm --version
> QEMU emulator version 11.0.0 (v11.0.0)
> Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

This looks pretty useful and also generic, thanks for working on it.

-- 
Peter Xu


