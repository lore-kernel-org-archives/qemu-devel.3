Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B439C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Xzp-0000fN-NX; Mon, 29 Apr 2024 16:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1Xzj-0000f8-7t
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:53:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1Xzg-0005IN-5i
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dJ4cWTB8DoMvOYumpiBGaxeOIs9zXj2TfLPq8MeZZRE=; b=wxnXMoAfHepsqjrcNWb3NS1cHI
 Nxvt2XAASbBaFYh3dwqjs6ynIxbrjEC/emIjp5CzP4VW9OcxQHgJq2qDoox8i7oqQbc1noNwcJU4i
 LoRSpKjKrLXbw5yOUCB/8bdcH01luST66aPqz4BPvHh7wIx9Gszwox16cuuVUo9ujXa1KjtJ14VuU
 iz7eW/RSarNOJ22TGrF9pS5EzW33r0OHs7dDtz4gIZ99KzKuYjQ2l0FGOs5buAM77BwOfs8LufwC7
 BsvJpcR/w0siKFraF/n5E0Q74BYdJVx3Ze+tudxRT86wEvPZIoujfaO02PXlVOKSBWbZCr18cX7Gl
 pJtxBMnVjnHxsw8HUizFzTBJ7f2CUvTldlHpNdyK438a96VVIb12oBYL+wXeMjPm0+azG6xmRfb+d
 yp+MRSBHt+pJah9bQ3JOPFvYtW4kpb/lMcHsILkqtICQX0UfOvgxi2Y8EyoHlcSnNt7xbe/GjyFQR
 ENDhv2iUZh5smgGfsv/fKkCIJRLXyUNIIlWQMjmAlrMUMKeCL3irxw8lhVOSKG9iUjhpwzG2/lTnF
 8hqrV/cMA7a/GVK8lg6ix0sI9RAXbK2rmpvxuQyxU09BVn5YGnz6brX5lzu+EL0YZClfZRhGU1sko
 wm2EzonCajXkli9BIKoGLL//iBuP+wDzDHVGe5L7w=;
Received: from [2a00:23c4:8bb4:4000:1a44:faa7:2c0:9860]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1XyX-000CFB-LZ; Mon, 29 Apr 2024 21:51:53 +0100
Message-ID: <7b5e744c-7fc5-4bf2-9602-1d2cc97913be@ilande.co.uk>
Date: Mon, 29 Apr 2024 21:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
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
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:1a44:faa7:2c0:9860
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/41] target/sparc: Implement VIS4
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

On 02/03/2024 05:15, Richard Henderson wrote:

> I whipped this up over the Christmas break, but I'm just now
> getting around to posting.  I have not attempted to model the
> newer cpus that have these features, but it is possible to
> enable the features manually via -cpu properties.
> 
> Possibly the first 6 or 7 patches should be taken sooner than
> later because they fix bugs in existing VIS[12] code.
> 
> I remove cpu_fpr[], so that we can use gvec on the same memory.
> 
> 
> r~
> 
> 
> Richard Henderson (41):
>    linux-user/sparc: Add more hwcap bits for sparc64
>    target/sparc: Fix FEXPAND
>    target/sparc: Fix FMUL8x16
>    target/sparc: Fix FMUL8x16A{U,L}
>    target/sparc: Fix FMULD8*X16
>    target/sparc: Fix FPMERGE
>    target/sparc: Split out do_ms16b
>    target/sparc: Perform DFPREG/QFPREG in decodetree
>    target/sparc: Remove gen_dest_fpr_D
>    target/sparc: Remove cpu_fpr[]
>    target/sparc: Use gvec for VIS1 parallel add/sub
>    target/sparc: Implement FMAf extension
>    target/sparc: Add feature bits for VIS 3
>    target/sparc: Implement ADDXC, ADDXCcc
>    target/sparc: Implement CMASK instructions
>    target/sparc: Implement FCHKSM16
>    target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD
>    target/sparc: Implement FNMUL
>    target/sparc: Implement FLCMP
>    target/sparc: Implement FMEAN16
>    target/sparc: Implement FPADD64 FPSUB64
>    target/sparc: Implement FPADDS, FPSUBS
>    target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8, FPCMPUGT8
>    target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
>    target/sparc: Implement LDXEFSR
>    target/sparc: Implement LZCNT
>    target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs, MOVxTOd
>    target/sparc: Implement PDISTN
>    target/sparc: Implement UMULXHI
>    target/sparc: Implement XMULX
>    target/sparc: Enable VIS3 feature bit
>    target/sparc: Implement IMA extension
>    target/sparc: Add feature bit for VIS4
>    target/sparc: Implement FALIGNDATAi
>    target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
>    target/sparc: Implement VIS4 comparisons
>    target/sparc: Implement FPMIN, FPMAX
>    target/sparc: Implement SUBXC, SUBXCcc
>    target/sparc: Implement MWAIT
>    target/sparc: Implement monitor asis
>    target/sparc: Enable VIS4 feature bit
> 
>   target/sparc/asi.h             |   4 +
>   target/sparc/helper.h          |  36 +-
>   linux-user/elfload.c           |  51 +-
>   target/sparc/cpu.c             |  12 +
>   target/sparc/fop_helper.c      | 104 ++++
>   target/sparc/ldst_helper.c     |   4 +
>   target/sparc/translate.c       | 960 +++++++++++++++++++++++++++++----
>   target/sparc/vis_helper.c      | 526 +++++++++++-------
>   target/sparc/cpu-feature.h.inc |   4 +
>   target/sparc/insns.decode      | 338 +++++++++---
>   10 files changed, 1626 insertions(+), 413 deletions(-)

I've applied the first 6 patches to my qemu-sparc branch, since I believe these are 
the up-to-date version of the patches posted for 
https://gitlab.com/qemu-project/qemu/-/issues/1901.

No objections here about the remainder of the series, other than that I don't have an 
easy/obvious way to test the new instructions...


ATB,

Mark.


