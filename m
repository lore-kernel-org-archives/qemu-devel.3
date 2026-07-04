Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714FCC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg87U-000257-GA; Sat, 04 Jul 2026 17:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wg87Q-0001uf-Sa
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 17:41:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wg87P-0000Rs-Ak
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 17:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=MNrT69ag/E3Wm5Es+Ysjb3Ops57xqLuxx7ex8nFzL34=; b=W3MyaMtb/bKE/Yi6PLFt724l4E
 M4FyMZFiVDtPrzFGWRYYoqPlp2yT+mUemcYX0xPhBC5zW7j8pLlbv3puWIsPXb6GUsq6VcHCEQxxJ
 7RkQPfNl5dmTlqVmviP66leUFd+ijjq5iwakpERWfA7HWwxBq8OpnQ+fq6jD7cBT4DJ7MUCr3B7fe
 svz216kkF/wEa8RdU8XV19GacgzE/pWju9IMq28CdeMuB9DtsZsxw6kRKBIJBe3+LDtLO4ybf+nnU
 c1pgJiMclWOWrbaaTOVhC6xpbIIa0aw6bKendvAmvy7ebSPdn1Nx1eZUArbylAQRXZyhjSyTAwr2h
 tgBtanxMwibdlP3x7pac7RvgBFFmReSAC4aD0LGrqxlNGLGuACvKXhIkDpEv1qcDnE3yY42cg+ViN
 6r7F739X9YhYdLS91wubkqN8wg8EInIs6E5+PCi0szzvPiAXBITHMLEzux4LpD/HHgu0sOPWfOeyk
 EAM43TcNXnuJZs8uI86xDMfDRvtJBCgfnNNDwb7wG+X8fRyx8Z6ZT21eTTbq3b1CJ4007/OXfX7Bu
 7FA1XbY5tLB1FsTewxzzTwAur1nCno3HaJq0QaPrAc/hadF0+L/ho1VYwvMe0fqqxOB64roAQVAC8
 SFENI+3oKRZYGw2Jpa73Ig0MxdxkaEmBzSCyCw8UA=;
Received: from [2a02:8012:2f01:0:b3f4:44c3:c2e7:b860]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wg87K-0015nK-BP; Sat, 04 Jul 2026 22:41:42 +0100
Message-ID: <7e3536cd-8f02-420c-a85d-3cc027fcd660@ilande.co.uk>
Date: Sat, 4 Jul 2026 22:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
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
In-Reply-To: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b3f4:44c3:c2e7:b860
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

On 04/07/2026 22:20, Richard Henderson wrote:

> Has anyone else been seeing
> 
> Error: Failed to fetch http://deb.debian.org/debian/pool/main/d/dpkg/libdpkg- 
> perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
> Error: Failed to fetch http://deb.debian.org/debian/pool/main/d/dpkg/dpkg- 
> dev_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
> Error: Failed to fetch http://deb.debian.org/debian/pool/main/p/python3.13/ 
> libpython3.13_3.13.5-2_amd64.deb  404 Not Found [IP: 151.101.22.132 80]
> Error: Failed to fetch http://deb.debian.org/debian/pool/main/g/glibc/libc6- 
> i386_2.41-12_amd64.deb  404  Not Found [IP: 151.101.22.132 80]
> Error: Unable to fetch some archives, maybe run apt-get update or try with --fix- 
> missing?
> Error: building at STEP "RUN DEBIAN_FRONTEND=noninteractive eatmydata   apt install - 
> y --no-install-recommends   clang  dpkg-dev  gdb-multiarch  libclang-rt-dev": while 
> running runtime: exit status 100
> make: *** [/home/rth/qemu/src/tests/docker/Makefile.include:43: docker-image-debian- 
> all-test-cross] Error 100
> 
> This has been consistently failing for me for a couple of weeks...
>  
> r~

I wonder if docker build has cached the existing layers, and since apt-get update 
only runs in the first part of the Dockerfile then the subsequent layers try to 
access an old base image?

Does running "docker builder prune" (possibly with --all) help at all? That should 
purge the cache and force docker to rebuild all the layers again.


ATB,

Mark.


