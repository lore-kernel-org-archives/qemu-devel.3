Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB39EF483CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4i2Q-0000kI-2x; Mon, 23 Mar 2026 12:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4i2O-0000jm-NH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4i2M-0002Df-3O
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774282912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uDX0HwPWL7FGNk4viqTtC5kayI7w1itzi5OnswqTl5I=;
 b=cFIHjkhsmSzRw9BJ3YTU+kI/RUl5IKPMACeF3pULH8HLccCnkxkx9TG63ZLSEODBv9NFm9
 SkLf7phazAw3pkHxwRRiQwJNaiCS2IpjM5ww0daNwXbUbrQTvteslZJiG+meaFt9YTnAMl
 x/TkehHxHh7McvvHFG+7G5Arsd9yi1g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-q66mTD_aNGWWm3c38nSEbw-1; Mon, 23 Mar 2026 12:21:49 -0400
X-MC-Unique: q66mTD_aNGWWm3c38nSEbw-1
X-Mimecast-MFC-AGG-ID: q66mTD_aNGWWm3c38nSEbw_1774282908
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853a9467c5so31760575e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774282908; x=1774887708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uDX0HwPWL7FGNk4viqTtC5kayI7w1itzi5OnswqTl5I=;
 b=mJtB+ph0yFTXmKEqIrrN9urOkAfKomN2etcpZKCguMpoEne80djbzQ5EUrV2RRIfUT
 AIZPbxIQk/Nhgfug38q7m9gIu5H6XzIurNL3VgIXwIOJueXWr+zgPShSVVfxYBrPd3Xh
 RlPsvRRH6suYERXgjMDio1DCCKWcPun5dyNBYs7ydvJIbYHgMGVKlIX9daqe2Jb721Dy
 E2TMcD3NP8AqbaeJHsZVTQpe9NDd7itg3OxDuz1dYjwkydDmrofMM4vuq7XnXuGS8Voo
 9N2Z3479BiJklUOYqvUhBxhGJtEe32fqU4YniLvUjwnpjWkNWfNgE+KcPiQseCjzE2Tm
 JeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774282908; x=1774887708;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDX0HwPWL7FGNk4viqTtC5kayI7w1itzi5OnswqTl5I=;
 b=ri3PJ9HYPEg6Y8opEFAmpl7cE/NDB8X/y3Z0snlPgaR/+t9//3VVHoYrmQNpMcL7Rk
 vBrtdcvKc61ndFyJ5VQcB3rJfUTiK5V3pI1eJb30Q/5ddWKHG0a1obbft4l9jh8Z+GEH
 zaVTq1lN4daCLo0muYLzZdGA1qczNfjTI5H5tJEJ/gLxR5XCoVMvqTLbImdi5Li1X65J
 f9sed8PWk6xae8oiMdEp5qXdfwnwNmmBVO/qjtJqRokS6EwjlQCJ/rJbPH20clTn/cT7
 qCfxe+Nj3tawwLH8tpHILQRvO7DOwuLvN/3cPudvYlloiG5FEMKjzNGohDpEJp4lV1qo
 Dw4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmuD35xwpiE2iQ/P5T9qzaj+f5ETCMjiyGR7OZUhLq5SJAfdCp20nNI0DPnyCIkDq9gA0Hk1/tueWw@nongnu.org
X-Gm-Message-State: AOJu0YyXXLfm3HgED2be5o1APapa8TxQs+v+Jy7IlAvR+ilB/xgn01xe
 siDApF2JtsXNEGV2YvHPRnafSBgjQj5cHMiYCPCT7zrJdF86GebLxGp1vO6ecEbVsJEGD1lkYM4
 UNdDX1xomtbWgvrR3jlBLMhjL8se/ovicjW+/GMvycPbaWGVeFuIljLkD
X-Gm-Gg: ATEYQzxbkHsNUw6iq1ACsnOV2LRdTjExFoRNdD2eQ4D5XhfnPRkybrch1J1wIHlP3si
 DRQxZkN/MJlazqVeHKklo877Z2t0H8bVY/VsKOOUCMJCeTOeKbu4lQFewbGbC36bRTD1RLw+whD
 c3cahd2ZZiUESs3A35pPc044Ffxqv9ke0WBbMRvTg0/bj6mLCm2joorg6BYVUtedeGFmN2tQo92
 4z6xINrOBlLNya95VC+Efxl4LxBhH901alrSuT1MqQSMD3sw6dXGI72cR/68kn32lEr7EFvZMKC
 tVrLXumM8wepW4XhizOuZy9QsEferKryCj34PlbqEwq6vCmwdA2+dRWc4kipewkdGjq+S716l2x
 oW3CJhcK3QIf9kx7ul9ANr8uBxhY+/7eBAsOLp5/9dLcKS5ksviUVfcZ+GmXZ
X-Received: by 2002:a05:600c:45c5:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-486febb5f45mr176192735e9.6.1774282908382; 
 Mon, 23 Mar 2026 09:21:48 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-486febb5f45mr176191995e9.6.1774282907550; 
 Mon, 23 Mar 2026 09:21:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4a74sm353253375e9.12.2026.03.23.09.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:21:47 -0700 (PDT)
Message-ID: <93db1ce4-5645-4e11-ac96-6f30a19277f9@redhat.com>
Date: Mon, 23 Mar 2026 17:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] docs/about/removed-features: Replace 'since' ->
 'removed in'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260323151934.92880-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260323151934.92880-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/23/26 16:19, Philippe Mathieu-Daudé wrote:
> We use "deprecated since ..." and "removed in ...".
> Replace "since" by "removed in" for removed features.
> 
> Fixes: 762c8554394 ("vfio: Remove 'vfio-platform'")
> Fixes: aeb1a50d4a7 ("vfio: Remove 'vfio-amd-xgbe' device")
> Fixes: e50a021a451 ("hw/arm: Remove ast2700a0-evb machine")
> Fixes: 4af2433a81b ("docs: Mention 32-bit PPC host as removed")
> Fixes: 8ebc416ac17 ("vfio: Remove 'vfio-calxeda-xgmac' device")
> Fixes: a80151c9da1 ("hw/sd/sdcard: Remove support for spec v1.10")
> Fixes: 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts")
> Fixes: fc37c122fff ("migration: Drop deprecated QMP migrate argument @detach")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/removed-features.rst | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 557a24679a1..e75db084108 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -782,8 +782,8 @@ without reporting any destination threads, or non-multifd source
>   threads).  For debugging purpose, please use ``-name
>   $VM,debug-threads=on`` instead.
>   
> -``migrate`` argument ``detach`` (since 11.0)
> -''''''''''''''''''''''''''''''''''''''''''''
> +``migrate`` argument ``detach`` (removed in 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
>   
>   This argument has always been ignored.
>   
> @@ -932,14 +932,14 @@ work around the atomicity issues in system mode by running all vCPUs
>   in a single thread context; in user mode atomicity was simply broken.
>   From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
>   
> -32-bit MIPS (since 10.2)
> -''''''''''''''''''''''''
> +32-bit MIPS (removed in 10.2)
> +'''''''''''''''''''''''''''''
>   
>   Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
>   maintain our cross-compilation CI tests of the architecture.
>   
> -32-bit PPC (since 10.2)
> -'''''''''''''''''''''''
> +32-bit PPC (removed in 10.2)
> +''''''''''''''''''''''''''''
>   
>   The QEMU project no longer supports 32-bit host builds.
>   
> @@ -1172,8 +1172,8 @@ Mips ``mipssim`` machine (removed in 10.2)
>   Linux dropped support for this virtual machine type in kernel v3.7, and
>   there was also no binary available online to use with that board.
>   
> -Arm ``ast2700a0-evb`` machine (since 11.0)
> -''''''''''''''''''''''''''''''''''''''''''
> +Arm ``ast2700a0-evb`` machine (removed in 11.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''
>   
>   The ``ast2700a0-evb`` machine represents the first revision of the AST2700
>   and serves as the initial engineering sample rather than a production version.
> @@ -1290,8 +1290,8 @@ by using ``-machine graphics=off``.
>   
>   The 'pvrdma' device and the whole RDMA subsystem have been removed.
>   
> -``-device sd-card,spec_version=1`` (since 10.2)
> -'''''''''''''''''''''''''''''''''''''''''''''''
> +``-device sd-card,spec_version=1`` (removed in 10.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
>   SD physical layer specification v2.00 supersedes the v1.10 one.
>   
> @@ -1396,21 +1396,21 @@ device driver such as RBD.
>   VFIO devices
>   ------------
>   
> -``-device vfio-calxeda-xgmac`` (since 10.2)
> -'''''''''''''''''''''''''''''''''''''''''''
> +``-device vfio-calxeda-xgmac`` (removed in 10.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''
>   The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
>   10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
>   string) to a guest. Calxeda HW has been ewasted now and there is no point
>   keeping that device.
>   
> -``-device vfio-amd-xgbe`` (since 10.2)
> -''''''''''''''''''''''''''''''''''''''
> +``-device vfio-amd-xgbe`` (removed in 10.2)
> +'''''''''''''''''''''''''''''''''''''''''''
>   The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
>   to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
>   is not supported anymore and there is no point keeping that device.
>   
> -``-device vfio-platform`` (since 10.2)
> -''''''''''''''''''''''''''''''''''''''
> +``-device vfio-platform`` (removed in 10.2)
> +'''''''''''''''''''''''''''''''''''''''''''
>   The vfio-platform device allows to assign a host platform device
>   to a guest in a generic manner. Integrating a new device into
>   the vfio-platform infrastructure requires some adaptation at

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


