Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C5EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxsYh-0002EG-9e; Fri, 19 Apr 2024 14:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxsXB-0001Un-7l
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:00:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxsWv-0008RN-1F
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8H00RKYrD7GHuBFs3C5JTE5gBpRbC5sKoFu7ikfj1Uk=; b=EnWpC8keQmqz+v5VOcvIytZZrA
 2Ko8v+JWXceJSsinKFZzMJHlWIoHg4wvzjgwnM9/Tp5dbTMvpnstWlMIh1Ri0Fuw7672MrWEeLTp+
 pgajrGHCBUhFT/n8Ne3KCfw6oBZ/RQHQW7aOlvB5+DIlI31r+PUfOaQTgrHBjdFgsF3Y76/5UvBnW
 zPq8BoaH7hA50njenPFRG7t+1mkzR9lPzSDlOtLeIDu9OSXHuCrnceKgPVuZ2q1dwodlygBA04HwT
 +Zp7YQo4aOQqOrHQjkVINBr2NvbLkSXEPN+m6vVeOJ/53VlEThyJHn6k7MR/ZNP9gnQq5Qx10UTKr
 ay13KKH+NAgG5+b9FEDCNaI4ra7s3TzpmxmlznHfUEeOVFmO5ULRfD99aURddKGnsM1bi4V8JTUaZ
 Z7F8/q7ZAaNNucVsyUgMbFQ8+PcGriiSA92xkGH9EfXkDuU/sDYqbgieH60nszOjeFDSLaESGtn6I
 bjZDSNJtiME6UWagY9/2saaVSVW4709JrdqVf8TgSCbbuTvyuwm8Z9N1dYv0KhLLDtldX1nT0nRfF
 zdvPsq8t0Kj7qrW/19iGWVa2JcXcKIJEf0xUCOLSyHrqUhhM34cDv2yP0jJfeGLrgpVkmr7aIU7E3
 S8b7NhNGd5NRJLqpOS8EzC+r4CajCLM2u/rEGiWl4=;
Received: from [2a00:23c4:8bb4:4000:a36d:d178:601a:c356]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxsVp-0003sJ-A9; Fri, 19 Apr 2024 18:59:05 +0100
Message-ID: <46d1e7b8-fb98-4f48-92be-f55085d3da72@ilande.co.uk>
Date: Fri, 19 Apr 2024 18:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
 <20240419084812.504779-4-thuth@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240419084812.504779-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a36d:d178:601a:c356
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 3/4] docs/system/target-sparc: Improve the Sparc
 documentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 19/04/2024 09:48, Thomas Huth wrote:

> Add some words about how to enable or disable boolean features,
> and remove the note about a Linux kernel being available on the
> QEMU website (they have been removed long ago already), and the
> note about NetBSD and OpenBSD still having issues (they should
> work fine nowadays).
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2141
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/system/target-sparc.rst | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
> index 9ec8c90c14..54bd8b6ead 100644
> --- a/docs/system/target-sparc.rst
> +++ b/docs/system/target-sparc.rst
> @@ -27,6 +27,11 @@ architecture machines:
>   The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
>   Linux limits the number of usable CPUs to 4.
>   
> +The list of available CPUs can be viewed by starting QEMU with ``-cpu help``.
> +Optional boolean features can be added with a "+" in front of the feature name,
> +or disabled with a "-" in front of the name, for example
> +``-cpu TI-SuperSparc-II,+float128``.
> +
>   QEMU emulates the following sun4m peripherals:
>   
>   -  IOMMU
> @@ -55,8 +60,5 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
>   is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
>   compliant firmware.
>   
> -A sample Linux 2.6 series kernel and ram disk image are available on the
> -QEMU web site. There are still issues with NetBSD and OpenBSD, but most
> -kernel versions work. Please note that currently older Solaris kernels
> -don't work probably due to interface issues between OpenBIOS and
> -Solaris.
> +Please note that currently older Solaris kernels don't work probably due
> +to interface issues between OpenBIOS and Solaris.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


