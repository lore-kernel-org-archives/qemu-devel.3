Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8048FED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMZh-0003Mj-OA; Fri, 24 Apr 2026 15:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wGMZe-0003Ln-3s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:52:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wGMZc-0001Rq-LL
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gKRT1qiVdtBdALb4qSJJlolxZxBFt77ePs7lJnp/HAU=; b=eMI6C08j5vP4rYHGXFK05KFELx
 YcbTV11eUgpeUUkg1xTSNv7uW/hziWGk7qyCS9C6z7Angq0DajmnTuDJweeUR7q43arjThW3Bbb65
 Q9etBuV9iKLR2DvzcL6bfUPLb7peIEzwaIEL/Dp8O98bV/GstTWT2pm9Wa4DgQ1sZhK/Kuc/VpqfC
 CQIJC7clrhOYxvc/CepdA1zZ19onnVMxLi6opTc4/sK/rT9WtareEfaijVViUZqk/95CqKOZebU5t
 XsG6nYEGq0MzDHAYSLXoK00hhR6r8+AqrBjGOL0y8ym8kUrQ2m4v3WBEHiP5QLxIn1wjxeIOwAsnI
 DxCJYc8rXOMZV0wO4CQ4Wr2+DBriQ04vQeSZ/6IIsG+MRzLATzCJB8glkW5HI/2tCg31XEvD+JMcW
 JRTexffM4kpRjVnexOhSRvr+PQopDyDfBHlvgkZWL8J5zWzSjI+k/J38bOvgF2Hr7Cl8ViHP9XFY6
 OuTcsT3exx0M38axckpdYY2BZqbdFIFsY9olO+WqzTKOtg+1QNTdOfH0h38mqy1l61rlg/oufOf1V
 ug0L0yjfRV+xQPhELF6l57C1/bBYUMg99mhRLQmbBPlsaH+vh4xF/6l7p4mljsQ9/kPyciBHwtTny
 BRs1mCLW3/d8eXAqsNCdl64xx2ilGvAerOQKb6Lc4=;
Received: from [2a02:8012:2f01:0:2328:2cf6:f0ff:43f1]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wGMWR-0008zZ-Tb; Fri, 24 Apr 2026 20:49:08 +0100
Message-ID: <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
Date: Fri, 24 Apr 2026 20:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>,
 Elisey Konstantinov <elisey.konstantinov@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
 <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
 <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
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
In-Reply-To: <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:2328:2cf6:f0ff:43f1
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
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

On 24/04/2026 12:51, Peter Maydell wrote:

> The "New World" and "Old World" machines are listed in our
> MAINTAINERS file as "Odd Fixes", which means:
> 
> "It has a maintainer but they don't have time to do
>   much other than throw the odd patch in."
> 
> In other words, there is no active development work ongoing,
> and nobody with time and interest to investigate complex bugs.
> If it happens to work for people, that's great. If it doesn't
> work and somebody proposes a patch then we can review the patch
> (as we have done for this one). If it doesn't work and nobody
> proposes a satisfactory patch then it will likely remain broken.

I'm around to do various small bits and pieces, but at least for the short term it's 
fairly hard to find the extended time that bugs like these require.

Note that MacOS X before 10.2 (including MacOS 9) appear to be timing sensitive to 
the CUDA interrupts, so that might be another explanation. You could try 
experimenting with increasing the delay at 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/misc/macio/cuda.c?ref_type=heads#L537 
to see if that helps?


ATB,

Mark.


