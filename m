Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDFEEDE9B4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7Mi-0002yx-1h; Tue, 10 Sep 2024 16:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7Mg-0002xr-Gs
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:21:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7Me-0004jX-VN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rJfsBPYe3ffSfQf5YPA9CIW3HW6M2N9H2270t4VdEuw=; b=ud6p/oYI/lns1Riherwael8eHS
 eLH1gdhq8KOyh8m5eUfd4N/RU4OdJECEu329PYxBYM7ujDOQH5TQZpqPKc7Niu/RKVX2zXJiOqu9Q
 CjhKwpV6TDAlb4N5YQrJ9Wol4bhL5ZjiosQBL51ZLa874V+n/w2d8CPabem4aNSdLVWafrcMDaadZ
 sI6vDzKJOKwHxsgTQFjmGs0vxTRPR9m4GtGcRUEID+KRxhrwJJGaRtpFoQ1H5FSleQjp0BqlzoF/x
 HnQWYlo/OVK5cObh1Xc5hylvTingrvwZ94C8HJQp/3I5OgyKMBBn3HnM2JJ3W/ff8R2Ll9DSCoA1B
 JFk3s6w1K8hCLcqmaU/GoK+USpH6BpDb0nzh4SVB5byRVm2CmaTpP1F3bend+55oF5LMRpj4CpLrk
 o/FhvHHMyeSXK/FRjXVgnOS1sdO9t4e7lEa57LzDUxw+mHL9/CxYnlYZF/3lQenYKabQvEHeo/bj5
 Q9VQp+l0wO80+bfy4l+uC5kd6uOAmBUwjp+BMwBP+mkc2Uc8F8T78c20CMKjaDFqxMl2retAiG0Zc
 Pk2ywprPg0S9L4+TlYCGISATM7DwMpKd2AP+mIzUM5NyJmMKDGAaraUEN53uTdBBqWrMvclfcNSdZ
 cOOfKMTPlBGBnB2o/5SQsdxkwMZk/dvd7FdqacaJI=;
Received: from [2a00:23c4:8bb8:1400:b001:a616:651c:c1d5]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7MV-0000mJ-Ae; Tue, 10 Sep 2024 21:21:23 +0100
Message-ID: <c5141d98-1592-4832-b289-2b4eddaef92a@ilande.co.uk>
Date: Tue, 10 Sep 2024 21:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: chauser@pullman.com
References: <20240909180712.651651-1-richard.henderson@linaro.org>
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
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:b001:a616:651c:c1d5
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 0/5] target/sparc: emulate floating point queue when
 raising fp traps
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

On 09/09/2024 19:07, Richard Henderson wrote:

> Changes for v5:
>    - Fix stdfq advance_pc.
> 
> r~
> 
> Carl Hauser (2):
>    target/sparc: Add FQ and FSR.QNE
>    target/sparc: Populate sparc32 FQ when raising fp exception
> 
> Richard Henderson (3):
>    target/sparc: Add FSR_QNE to tb_flags
>    target/sparc: Implement STDFQ
>    target/sparc: Add gen_trap_if_nofpu_fpexception
> 
>   target/sparc/cpu.h          |  30 ++++++++-
>   target/sparc/fop_helper.c   |   4 ++
>   target/sparc/int32_helper.c |  40 ++++++-----
>   target/sparc/machine.c      |  25 +++++++
>   target/sparc/translate.c    | 128 ++++++++++++++++++++++++++----------
>   target/sparc/insns.decode   |   2 +-
>   6 files changed, 178 insertions(+), 51 deletions(-)

Should there be a:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2340

somewhere in this series? I've not had to look at the FP exceptions in this level of 
detail before (so unsure that I have any suitable test cases lying around), but it 
looks reasonable so:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


