Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F29C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENbm-0003ja-J0; Tue, 04 Jun 2024 02:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sENbj-0003jB-TQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:25:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sENbg-0007cF-UT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ka94TAQHaS9qvy4fWC4rghetLsHXFN6yDg85DdIgrCc=; b=s8kaHLBI+SC1ILjtG85hDPHAkK
 EDLxU+cvExDyv9PyWcB/ouOudfZsXT0RJU2Bl7xRFOWhjM6MZiWRQ2k2k1544k/e3ej4rPWseChGR
 xdZ6k84+XGivp3LHl0de/OqJURWF8MyeGysLSY70+bBW2+eYsVqFisAATGY5r903MCAp6BUOlLuIi
 GZ/TyuDk8YmNO2BkKw+NNj3mQOUBYHnBSdwYdcz17X2v1Yw2veUom4IvLgWFOpfiqZW+Fdqi0cqhj
 ZeNVsgzTBi8vIQlXGneTx+mWziLC0TS62grqd20aXNORDm0g0PT5XsmumiIjWgV6a66MW96ge6Scg
 /KSOFsPnkYWNWfxQYC9XM/om6zh2LxrvSIa9zaPQPCifzbSEBapuE0FAHZn6Afq3KMhj+5Ck2L8zO
 Zk/dd3DfL3RzQwzYDbiK9fC5Sjlnla8nwptSP6dVsSPS4IKH3S34U1WiFvZROfrYyb4HUszU5c/U6
 zxFWgB0qDjGhF6zRuBuSazqiN9Eqmw7P7mgS9jzDgBHr8WS2b4N2JR5s84940li9g5GHUTr71H0Yk
 6RLkxOaL67V+st61kLE8O+1P4JgM6JwTg2y7wLsnWoPanlruii9/NcWKPDGklVEvbLRgTtPOLPhqr
 3yK/BOiynudwaTZL4bTwozwtoox2P2Mc2TnM1bOts=;
Received: from [2a00:23c4:8bb4:4000:ce26:7186:74ad:2d8c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sENaM-0006xt-Hy; Tue, 04 Jun 2024 07:23:58 +0100
Message-ID: <b19b642c-e5ee-4a09-9346-680caca5a96b@ilande.co.uk>
Date: Tue, 4 Jun 2024 07:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <b7ef97e1-5e3a-419e-bc35-0f51bc18e563@ilande.co.uk>
Content-Language: en-US
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
In-Reply-To: <b7ef97e1-5e3a-419e-bc35-0f51bc18e563@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:ce26:7186:74ad:2d8c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 00/37] target/sparc: Implement VIS4
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/05/2024 22:29, Mark Cave-Ayland wrote:

> On 26/05/2024 20:42, Richard Henderson wrote:
> 
>> Now tested with RISU, using a Solaris M8 host as reference.
>> This exposed a few bugs in the existing VIS1 support as well,
>> so fix those before anything else.  It also exposed a few bugs
>> in the implementation of VIS3, so fixes squashed there as well.
>>
>>
>> r~
>>
>>
>> Richard Henderson (37):
>>    target/sparc: Fix ARRAY8
>>    target/sparc: Rewrite gen_edge
>>    target/sparc: Fix do_dc
>>    target/sparc: Fix helper_fmul8ulx16
>>    target/sparc: Perform DFPREG/QFPREG in decodetree
>>    target/sparc: Remove gen_dest_fpr_D
>>    target/sparc: Remove cpu_fpr[]
>>    target/sparc: Use gvec for VIS1 parallel add/sub
>>    target/sparc: Implement FMAf extension
>>    target/sparc: Add feature bits for VIS 3
>>    target/sparc: Implement ADDXC, ADDXCcc
>>    target/sparc: Implement CMASK instructions
>>    target/sparc: Implement FCHKSM16
>>    target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD, FNMUL
>>    target/sparc: Implement FLCMP
>>    target/sparc: Implement FMEAN16
>>    target/sparc: Implement FPADD64, FPSUB64
>>    target/sparc: Implement FPADDS, FPSUBS
>>    target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8, FPCMPUGT8
>>    target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
>>    target/sparc: Implement LDXEFSR
>>    target/sparc: Implement LZCNT
>>    target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs, MOVxTOd
>>    target/sparc: Implement PDISTN
>>    target/sparc: Implement UMULXHI
>>    target/sparc: Implement XMULX
>>    target/sparc: Enable VIS3 feature bit
>>    target/sparc: Implement IMA extension
>>    target/sparc: Add feature bit for VIS4
>>    target/sparc: Implement FALIGNDATAi
>>    target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
>>    target/sparc: Implement VIS4 comparisons
>>    target/sparc: Implement FPMIN, FPMAX
>>    target/sparc: Implement SUBXC, SUBXCcc
>>    target/sparc: Implement MWAIT
>>    target/sparc: Implement monitor ASIs
>>    target/sparc: Enable VIS4 feature bit
>>
>>   target/sparc/asi.h             |   4 +
>>   target/sparc/helper.h          |  27 +-
>>   target/sparc/cpu-feature.h.inc |   4 +
>>   target/sparc/insns.decode      | 338 ++++++++----
>>   linux-user/elfload.c           |   3 +
>>   target/sparc/cpu.c             |  12 +
>>   target/sparc/fop_helper.c      | 136 +++++
>>   target/sparc/ldst_helper.c     |   4 +
>>   target/sparc/translate.c       | 938 ++++++++++++++++++++++++++-------
>>   target/sparc/vis_helper.c      | 392 +++++++++++---
>>   fpu/softfloat-specialize.c.inc |  31 ++
>>   11 files changed, 1558 insertions(+), 331 deletions(-)
> 
> Thanks - I'll give this series a quick run over my test images over the next few days 
> just to make sure there are no regressions (unlikely as I don't have much in the way 
> of current VIS test cases) and report back.

This series passes all my sun4u boot tests so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I don't have any other pending patches so feel free to take this via your TCG branch 
if you would like it merged in the near future.


ATB,

Mark.


