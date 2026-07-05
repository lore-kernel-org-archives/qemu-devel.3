Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C89C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUAb-0005ry-Ls; Sun, 05 Jul 2026 17:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wgUAa-0005rl-Pa
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:14:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wgUAZ-0006yq-41
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=W4Y5+txlh9eN0VqxVQfBZcAY0bVr+eOI6cvAuPHrIbQ=; b=QgoyD0+KImgvcguMWb6pahhJ6v
 JTZCLmT/HDMK/5njyh0w5cvDDNvf0prPfpbvp94+9txgjaFuhxOFYibjABDwcb2+WAJHEj8Fxq0LI
 uEEIXTjnb72Ic8d5wcOUO0a4yM0c+LyTtUXB21xW/dF6N+uA2AdSu1zjtG02cZ8/hpp4vPtXhXIWk
 jcj+PRYrY7mRo91IgKawuJ3MNZH0fo92j1UyL5o/y3rQsfUBYsu9huOsHggnhMQiMEz7UUlzhZy4w
 LgVoF/k/Xcj5+3MO9kJhCbvLikp6zmL0yXTKwlPskNorGhQDnA+62vrvfRRWM438nywhziXL3eS8b
 8CtrPua2YvgBMqk3tGYbwO9K3uqjZ5t0aDcmAhxwgf1E18RbNXrCK7fx/52S+OlexJOR6Wl1irjXb
 3GCRX54dm0WHmI+plqieV8q9QloF1bFb0Yl8Rs1jjfH21zCLCtZDwQsR/Ehe4QPbB78TThM7ESK2Y
 qdXSk1F/RUIfX20b3Kl3NSDegyt4EcnuHDZyynpeuY78DQ0YPkhLlSeAk86/5ApjA3gfbKPJykpTl
 6abcjJ7qWd6Z2O1SKUG0gAWpjJ/NA1y2Ihvpkf7Dk12TMXeQ41hGQmzUQxaK7b2wKnYCqxTDHMziJ
 TZZgZkZmjL6E2nB00y19dVdWrAkUyCdX8SXT+4PlI=;
Received: from [2a02:8012:2f01:0:9cc8:2cd7:b4eb:bbd7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wgUAP-001DPo-NY; Sun, 05 Jul 2026 22:14:22 +0100
Message-ID: <24d6a029-5f68-4314-820c-fb1786012fb4@ilande.co.uk>
Date: Sun, 5 Jul 2026 22:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <0403705b-9af4-4de1-8f66-c56befa5bae9@tls.msk.ru>
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
In-Reply-To: <0403705b-9af4-4de1-8f66-c56befa5bae9@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:9cc8:2cd7:b4eb:bbd7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: docker-image-debian-all-test-cross errors
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

On 05/07/2026 10:07, Michael Tokarev wrote:

> On 05.07.2026 00:20, Richard Henderson wrote:
>> Has anyone else been seeing
>>
>> Error: Failed to fetch http://deb.debian.org/debian/pool/main/d/dpkg/ libdpkg- 
>> perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
> ...
> 
> dpkg (and all related packages) has been upgraded from 1.22.21 to
> 1.22.22 version quite a while (on Mar-2026).  Initially debian trixie
> had dpkg 1.22.21.
> 
> I wonder where it is getting the old version reference from?
> Should the previous layer be refreshed to point to the current trixie
> point release?
> 
> /mjt

If that is the case then I think you can fix it by doing a manual update of the base 
image to pull in the latest update locally i.e. "docker pull 
docker.io/library/debian:13-slim" and then rebuilding the docker images once again?


ATB,

Mark.


