Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E022C98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9bqG-00055P-4k; Thu, 24 Sep 2026 01:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x9bqF-00055D-AO; Thu, 24 Sep 2026 01:17:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x9bqD-0001E2-K8; Thu, 24 Sep 2026 01:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=112LuYUY1jz/6nhZ4Gzrau2WXry5p+x9GgkH3VM36l0=; b=yd+hdjASMyVSWgDsHmmrLEy2HY
 5jgepW59lIxjudd8AeMWCNOGdbk1tOBCDGA3sbVpZYI8l8bLigk8iJmFXcM3+KCVM38cO/KkiVnjy
 othSjcJFsHLlqj0/4Ynjit7rWU3xt/2s4qvThKXHLid4TMOpWKLp1VpsZSaYt1H+Nt5F7uHAWZPkt
 ALpMSeCOjWObuD0pMtjxgcTfGhuwcFAkQp0JA2cgjflxvBfzfmJdhs+uRM+YPXsUPbZ7qpL2kghgp
 4+6CQnGJhG5fTwAyAaLMgTn7Khu7gXNM9eWVwWjlWU/R7WSE1ZP8KMkMgE1s27EFEujvqDEgX63ip
 9A2EAeHj7FoFfspT0T8FD5psxkMXjjWF/7InUHLUkwNaWpXvLU5TUxem+SMG11o8DSFfgzAKUxt9n
 f/yliuYASmYBQzOWXAADKrIgBDraiWMCctNoZkLnHkPJQLLog+ZlzI/N/yJeIZQZHcu3c6VOP/Pa3
 5umRkUAueY2bI1MKyR9e1cwCt2rvStBSfD43M3hJUTJvh+bPIcFNKLXUYcticgbPy7z9bQ+yLavsU
 2fiXy30TKL2H4bDCv7AB7MAiZG5Yqls7o3PPN9T7kzwkSaMG454IsYOGlPiZSc1YEXXlIWEirlVzy
 7FB5ezf6PKbkx3fCS57YiG7xcZ5JdArNzDPGJIs3o=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x9bpe-00FUyL-2x; Thu, 24 Sep 2026 06:17:18 +0100
Message-ID: <e6f1816d-354d-445c-8658-cd76778bcd98@ilande.co.uk>
Date: Thu, 24 Sep 2026 06:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-3-kirill@korins.ky>
 <3cc35c1e-febf-4ea7-94d2-e9191bc4acb8@ilande.co.uk>
 <a5355ab8-bafe-4c1e-989b-dcb05ec1fca3@linux.ibm.com>
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
In-Reply-To: <a5355ab8-bafe-4c1e-989b-dcb05ec1fca3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
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

On 24/09/2026 05:19, Harsh Prateek Bora wrote:

> Hi Mark,
> 
> On 18/09/26 6:49 pm, Mark Cave-Ayland wrote:
>> On 03/09/2026 12:50, Kirill A. Korinsky wrote:
>>
>>> OpenBSD writes zero to an edge triggered decrementer, then enters idle
>>> expecting its interrupt. QEMU defers the already due edge to a timer at
>>> the current virtual time, leaving the guest stalled.
>>>
>>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>>> ---
>>>   hw/ppc/ppc.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>>> index b123b4cc1c..d99e47d532 100644
>>> --- a/hw/ppc/ppc.c
>>> +++ b/hw/ppc/ppc.c
>>> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, 
>>> uint64_t *nextp,
>>>        * an edge interrupt, so raise it here too.
>>>        */
>>>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>>> +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
>>>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>>>             && signed_decr >= 0)) {
>>>           (*raise_excp)(cpu);
>>
>> LGTM, however since this is core PPC code I'd like a R-B tag from the main PPC 
>> maintainers above. Chinmay/Harsh?
> 
> Thanks for your review feedback on this series.
> Chinmay is on vacation till next week and I had asked Amit and Anushree
> offline to provide their review/test feedback on this (considering this
> 2/5 generic change). I see Kirill has posted v2 based on Amit's review
> feedback now. Since it is going to land in 11.2, I think we can give it
> a little more time for review feedback (if any), before pulling it in
> along with other PPC patches. Let me know if any other concerns? Thanks!
> 
> regards,
> Harsh

Hi Harsh,

I didn't realise we were still waiting for a response from Chinmay, no problem to 
wait for their return. Assuming everyone is satisfied, I'm still happy to take these 
through my qemu-macppc branch - let me know if that works for you, or if you'd like 
to take this patch separately as it's part of the core PPC code.


ATB,

Mark.


