Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82DDC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YUw-0003zv-5o; Fri, 18 Sep 2026 09:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YUt-0003zd-1S; Fri, 18 Sep 2026 09:19:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YUr-0008K6-1q; Fri, 18 Sep 2026 09:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=41TQMwYy0Qbw042I/rVmL1V+yeuo8Hluto1ZQyNvicw=; b=SOeObvtWQsYQqHDpBZ/IVNs9Va
 tvwGTAnte5I3pGYAMlMKnTJJ1fjiDOpCi3O7Q8eaZzGm7L7FHP/EbR29KEzrws95IeN8Cb3SpW5cc
 A1M+Y2adAuMwmPVtj1egfmdzsJqdmlLYznHf9RU7iOnu5AwVUiQG/UAloTbuqI6Q333s+BswU1OPE
 fWWJTsTw5rzf8LtS+nA1+Q0DtQf54AfS0dtPFGpOm3W/R+gx9l4UBTsPEztbfFNQUR+0FQ1wHo3j1
 uq63N+4j+VKOFtXw8iRHxX45WWW+qAiBiUwvGk+64Vic2/eWKlspY2cAAimqBVtVA3gCPhfj0tgUp
 MDKe7+dzbpGhbkABhZBrG2X1Jo8rib42FdlTPG7RRHaRBo71DqQRaY0V3j3Tg50eQ/DiWSbwmTsGB
 aV8faFoK8hKq2YZa4Qw8MHHE3CVypP27NNbttp4Qyje1oYFMUOslfbP3bDOWcuncQvphjaNTCy8sZ
 S42MCaHopRuccA+mqLiJfdi7u5pfrF0MVTLJYDdB2+fjni+fFVQVQ26ypXG8U5tBuDykti3RpabKc
 DXqqDM+olkIwzKnatm/oRISliFbyfHIF4jTwHWT7DttyGI0B35mXZAkCNlxqt2UVHnKXK0S314ETx
 yt3shtQkRq6VKwF1bMoWf24wYJM58rjn2MdmZ8Zvo=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YUI-00EgRy-25; Fri, 18 Sep 2026 14:18:46 +0100
Message-ID: <3cc35c1e-febf-4ea7-94d2-e9191bc4acb8@ilande.co.uk>
Date: Fri, 18 Sep 2026 14:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-3-kirill@korins.ky>
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
In-Reply-To: <20260903115229.95811-3-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
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

On 03/09/2026 12:50, Kirill A. Korinsky wrote:

> OpenBSD writes zero to an edge triggered decrementer, then enters idle
> expecting its interrupt. QEMU defers the already due edge to a timer at
> the current virtual time, leaving the guest stalled.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   hw/ppc/ppc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b123b4cc1c..d99e47d532 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>        * an edge interrupt, so raise it here too.
>        */
>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>             && signed_decr >= 0)) {
>           (*raise_excp)(cpu);

LGTM, however since this is core PPC code I'd like a R-B tag from the main PPC 
maintainers above. Chinmay/Harsh?


ATB,

Mark.


