Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B1CC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 16:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucOUn-0004NS-GI; Thu, 17 Jul 2025 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNnF-00068k-Uc
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:33:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNn6-00065r-MW
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bo2gcJBAz23xI1Wb75HYRsPNMDHPTR6LW37J2KzOh1c=; b=0mWA8v4DyQcyxKN3PXlpJWYgwV
 40UXEiKRN9NClRpqUDsQP6QlIhqjUYTSa0TQo0/xJdutI8bemTj/QRRNAtIIXGxKL0r79GIw2FSXe
 ZqVW0Z/ILb1xLn1BgUcC4RnieO+mxGbVs+3LDqUV4uIn/x52CE/rHtc592He2mECSMjPBYIYFq8rX
 IykctMaqQ3g8L5gz9CNi/f8ScC0g5aH+HPpy8wOwjHF+iWiA4g12aEy6rZmRW8uFFazjTrfw2vPZT
 7iMiqioeY316Cg+3opeCDyuVcUPWJZbYEyWRHzWMOLHDmrqJMiLPAnKijvCvSleo9Dv/PgZ2ASNJg
 PCr+RsYZlXyeuiYpKDQYQELq0WBcEUqFVEe99liGoI9YP3tSQKWvWycmLn5f7CoYy+YnrM88nBZp5
 M/wojpKwGrx3q0Rg4nLq/MtjZKzWz2IwVU0SrWUjMS5xVlba371lkNI/+13WT//+sGJ22iSzsDbfX
 P7EE6/D1AQwS5FLdK+weBzqPhN+3zXVv0e50GuB9bwJaNF0j4fGmma78VsGD1XiU8wfDzNLyZrMei
 3jWa3cpSs1EJC/Cau89ji+bZcgP7R0Ar+YI7e3pEvZj/NB8CE+HXTIt6pbFFtKIbvilbII/phdsSV
 SvFqKnbDkCv0IBGftFvM93RiqV5+KPWWwcta4kUgg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNlL-0003m2-Nt; Thu, 17 Jul 2025 13:31:00 +0100
Message-ID: <89d04983-956e-4fa0-b607-951522b2a731@ilande.co.uk>
Date: Thu, 17 Jul 2025 13:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
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
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [RFC PATCH 0/6] Fix building of sparc/sparc32plus test cases
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

On 16/07/2025 11:54, Alex Bennée wrote:

> We didn't have any reliable way to build sparc test cases. I have
> found someone who ships a compiler but the binaries still don't run
> due to the need for CASA.
> 
> I'm posting mainly for those who actually care who might want to fix
> up the remaining cases.
> 
> Alex.
> 
> Alex Bennée (6):
>    tests/tcg: special case sparc test cases
>    tests/tcg: special case sparc32plus test cases
>    configure: update sparc and sparc32plus target compiler detection
>    tests/docker: add sparc-leon-cross container image
>    configure: enable the container fallbacks for sparc/sparc32plus
>    docs/about: deprecate add sparc/sparc32plus-*-user
> 
>   docs/about/deprecated.rst                     |  8 ++++
>   configure                                     | 11 ++++-
>   .../dockerfiles/sparc-leon-cross.docker       | 40 +++++++++++++++++
>   tests/tcg/Makefile.target                     |  9 ++--
>   tests/tcg/sparc/Makefile.target               | 45 +++++++++++++++++++
>   tests/tcg/sparc32plus                         |  1 +
>   6 files changed, 108 insertions(+), 6 deletions(-)
>   create mode 100644 tests/docker/dockerfiles/sparc-leon-cross.docker
>   create mode 100644 tests/tcg/sparc/Makefile.target
>   create mode 120000 tests/tcg/sparc32plus

I think the basic Debian toolchain for 32-bit SPARC is working because it is 
currently used to build OpenBIOS, so I don't think we're quite at deprecation point yet.

Let me have a look and see if I can figure out what is going on here.


ATB,

Mark.


