Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E55F532C9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 03:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4sES-0005lX-R1; Mon, 23 Mar 2026 23:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4sEQ-0005lB-Mo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:15:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4sEM-00063R-Kd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:15:01 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35b88a4f123so2364019a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774322096; x=1774926896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pEUpRc7fApmZhbOt/d3g5lcXqKPhP0JyIByYyIZC9w4=;
 b=ohB/Tde/bppErnQ6/5Wi3HBrr/KdRVDseys9PWt4ymdtP0lg7WNZ7gKN337/MdHqE/
 YjB73IHXoKPGrT9iSM0madlo/Sa9NozsZZlzRyJmaZ8JfDjw6C1xwtJO8AX71trB/cCx
 oP3aQKli2m3aofLjuxTZ0SUo0BGsVJ3oi5vdt6e2xidWb0XlqNl+dJ7dcnnxyWeA6BBb
 xsGQWqWFewWK83iKMiCzNqxiHK4vFEPOSd3eUQ+ufcJLpgwGT/myDjpf3fyMeFkB6O27
 TIsyf4DyAE0hW7PIK5/3zo0jvPqLpe4dK5xQ8UlqrF3msSRPjYN3oojVsT0hOKWIiKLb
 6JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774322096; x=1774926896;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEUpRc7fApmZhbOt/d3g5lcXqKPhP0JyIByYyIZC9w4=;
 b=jIqXIfWCVcpFBsLj3Eqbdw7NY4ri8K8PLo8CpQlOW6mi5Yj1BO1gb8MNDA0mJRAer5
 LlgpRr238J4Gsq0PlYWHlX2plXLz1+1/fhOz9cJkZHFj92zRRtbqZ6jtfEfe1vx1i1/B
 GMEC4Ast9EZ9iy4T1IulDnnozqI0kmO+SzGpNrhdcPNqawAgBE/rrd+XvM5JOTnCeaLy
 TEswYYXjWjE/ma+66C3lWfKAm7wCgFB6NcWdHYUFllz3rsQmnzM6Oir34TOR4Yq5aYY6
 DrUiXblPw3k/0BqYkIga02LFBqlKm7RcfeafveNiLRAd2uIrVYwV+h7xlrHKYXDeJuHh
 /MzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE9wJqPE5bHsxry/0/W73ruM96ZjhEGX6dMkPViWYPy+Yklm51muiBMSnsU6BntL5hGGZHW5i8EatK@nongnu.org
X-Gm-Message-State: AOJu0YyQc/uc4yz1etqZzOSzdsBv+VrwIvfUT7Ps6D6hwCwdBF5/YyKo
 rVv3w+VRV15QYq1Vwz0FMbHbTjyCE+10p8UEV2qSxZnazwMfE3TADXIRFfdX2BumQno=
X-Gm-Gg: ATEYQzzhBYiuyzsGZUMzgGDpml/Ro0Gz3c5aglqyUPWJ5lZUYEG0trVDdCXS13PzZCq
 IeDn3Q3oUFLdaQvYjNNJgiCdQqITdy5xgtrAYSd9x2z3YAnM14hXsOQde4Z4iJsD7A4xhrF/hWX
 fOLTI7tpJxaJo/MdBZ/B0geTqcbzuPxVlVeHerxuZlhE5zvE5IojD3txZlHuYGBlETqswTwChEV
 sWPXDBLX+hF72PKr7sPca1MS9MGXmaZWPd44HJi/GpeQJuy88XiWHgXANXeQ/YHEigMElnoHcfo
 ddlX9FpHi2m+yDjHUJ6Iyi+WVyYH56hxvNMJGAqrBGw51XLy845rFJOSbyGJjJxm9QjEFXJTaCv
 ZnxoMCZKQItSKIuQ9mFuWrGcG6VBTcA1R5LE21f2H8O47b0ayGSbEn6vq6TZ5t7X/6ldrIDeVCe
 MqJZPTjnZXnprx1L+b2Uc3pnZe7hle4U3Wg0Q89eh21BgfXsxg65QRDsDaLU3Yz+YcsS0P
X-Received: by 2002:a17:90b:2686:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-35c00873a7emr1211398a91.12.1774322095848; 
 Mon, 23 Mar 2026 20:14:55 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031403e4sm611721a91.6.2026.03.23.20.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 20:14:55 -0700 (PDT)
Message-ID: <cf2415ba-1ced-4455-84cb-fbde3a121686@linaro.org>
Date: Mon, 23 Mar 2026 20:14:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] docs/about/removed-features: Replace 'since' ->
 'removed in'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260323151934.92880-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260323151934.92880-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/23/26 8:19 AM, Philippe Mathieu-Daudé wrote:
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Good for me, do you want me to pull this patch, or you feel ok 
integrating in one of your series?

Regards,
Pierrick

