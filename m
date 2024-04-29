Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F06C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Y9V-0005g9-8E; Mon, 29 Apr 2024 17:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1Y9T-0005fw-U4
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:03:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1Y9S-0007B7-4p
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TgzwqTXiIFqKQ0LN3cZqpX6TjDKJzQ4agypMlPmMmi4=; b=J905Bhw6NeLe4dA2cAdVmBJlWK
 OHnRQ7RFTT1yW8BtaZ0ZkrAPhVigk09TwaC+T3GwlSBtOEbdy6eVZJboj33vslWeA6ayuyNawDzGf
 NIoAX0Jl9co2qN41V1evNnblFyMsTHyBOeOHf9cqnBrDThysygclOjI73dfA3QTnS1LpeWtT2GA1D
 k3G1+3ga6IL1vGuYIIKcCZYXBbHWF2fay0Mpx2hCfFEn096Yrg9WFbYK/3Drk65iPBdymuu5jMums
 URzhXy7PW6yjdF0qNOXWUS0AZPdQFYXTVcU6FUM0/lr7o6L9k9G4i9VRaMKF3xB5hMYRf8H+8DY9B
 ml9HOXkdRScdmdV3O4qbFRMZW8XTLSMlnPjrEbPiZDVmydwxVoE6clOQi1igk8RY+ilmGhiHkvalU
 Nx8XeSZ1xZ6dtZt2bNLhLo2gd5rQaY99qmQBKkKI3lFFudaswsILmWwn7BePnNwO+c+jGndT0AyTK
 bglrSVEOKFBg+reX3lYkzSFtlqNQYnkG2c7bTaTpuR7y+NmNnmvXA5WsvzV+Eoz8LumkHLnq0JXEs
 NphLI9HNjGx3Y6rbSu9s8v+59/7/cQ3M8XubQMv0VbOdUxM1QigL5ptfk75kg8ojlVeq8BVFpylko
 YbqWJjxcbSkBzTbydKv0ZCMLJgGvYfrxvV2O2Iv14=;
Received: from [2a00:23c4:8bb4:4000:1a44:faa7:2c0:9860]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1Y8O-000CK6-Ng; Mon, 29 Apr 2024 22:02:01 +0100
Message-ID: <821def5d-ab57-4c95-b628-4b99c269600a@ilande.co.uk>
Date: Mon, 29 Apr 2024 22:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
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
In-Reply-To: <20240419084812.504779-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:1a44:faa7:2c0:9860
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/4] Sparc CPU naming and help text improvements
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

> The Sparc CPU naming and the corresponding help text is somewhat
> confusing for the users. We should avoid spaces in the Names and
> provide clear information to the users what can be passed to the
> "-cpu" option.
> While we're at it, also remove the "+" from two of the CPU names
> since this character is now not allowed in device names anymore
> (and was worked around with an ugly hack in qom/object.c so far).
> 
> v2:
> - Use "Sun-UltraSparc-IIIi-plus" and "Sun-UltraSparc-IV-plus"
>    instead of just adding a "p" at the end
> - Drop the sentence about NetBSD and OpenBSD in the docs since
>    these problems are likely fixed since a long time already
> - Added Reviewed-bys from earlier series and updated the patch
>    descriptions a little bit
> 
> Thomas Huth (4):
>    target/sparc/cpu: Rename the CPU models with a "+" in their names
>    target/sparc/cpu: Avoid spaces by default in the CPU names
>    docs/system/target-sparc: Improve the Sparc documentation
>    docs/about: Deprecate the old "UltraSparc" CPU names that contain a
>      "+"
> 
>   docs/about/deprecated.rst    |  9 +++++
>   docs/system/target-sparc.rst | 12 ++++---
>   qom/object.c                 |  8 -----
>   target/sparc/cpu.c           | 66 +++++++++++++++++++++---------------
>   4 files changed, 54 insertions(+), 41 deletions(-)

Thanks! I've applied this to my qemu-sparc branch, along with Peter's suggested tweak 
to the grammar in patch 3.


ATB,

Mark.


