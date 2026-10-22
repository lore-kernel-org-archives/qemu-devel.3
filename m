Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245F606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=ZJaW9lms
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0u5-00045W-4O; Thu, 22 Oct 2026 18:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0u2-00045H-Kk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:04:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0u0-0001eJ-Ow
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=p4XdaWqDEtDRgCD1QttnYJ6acbdjJbKuBqoe2U5LNb4=; b=ZJaW9lmsLdcHC8KK8brWUAoOGf
 7ca4PIPYzZFG8sP8/0OU7Q4f8ZNmPT7dr/2Vh+DLgdspJ4s3i0jX87o3GMbsQrUIgomvNfSbZo098
 igmr1R8iYLeG+llj+5ZVX2h6Moe/km1An1t9D3U+nRwM6FK3TV6+zSPoHMa4WOXmyAd2tlevmMNaI
 mkKdaLSy5+ehJbzv03G5ecfPLeoRrozT6nkLQ5JZsuON5unq597DQ2/t0wSHTTGB/vxCwMCf945BW
 FqNNZHlO7DqCTtb9g6C8kv3wMeccFl9N84INOIVswSrwtfUHrc4F44AdRO2bXlKOrT7pwwT4HNw5u
 pBwJWmK7gJB+EsYb8JFpPYWqK3gdIfl2xxEOKz8bl+w1rjtPxVtDq1edCTkSzFbsLWIyCgcIs5Nwb
 CoxZR0MUoiTWHpCkp6ZYSVtQzmXawuRRj+tXtDfpC2GjGGaOR6xnfQuMll2W7DsY6q723ppiA2gBF
 u5O2V+XvBuew7xIgwdEjlcLiG34cFE9b6KZZUkBPTHRW5dcF5ca6Ho+ggQhPUsUlyBb7NxXSigPto
 43Fh+n/jN3o1qcdoIlK4Uq33ScbQRgZ1XEHDcCLSQ6mktqGtovZbe4c1MfCKpaBHFrz1kxew1gdn9
 4SkbZUBqw6Vaw3UM7+sfIINJC79unhNl9ldJ1r0ZU=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0tH-003GBe-IF; Thu, 22 Oct 2026 23:04:03 +0100
Message-ID: <5a545dc9-a6bb-4a02-8577-1d01acf74bcc@ilande.co.uk>
Date: Thu, 22 Oct 2026 23:04:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261022070059.3861291-1-stian@itx.no>
 <20261022070059.3861291-8-stian@itx.no>
 <6dd0a00a-eeb6-4680-b1e5-a2518b604fdc@ilande.co.uk>
 <1fd05452f9af78f9d54546b752a389fe384c2939.camel@itx.no>
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
In-Reply-To: <1fd05452f9af78f9d54546b752a389fe384c2939.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 7/8] target/sparc: Allow block-init stores when the CPU
 has the crypto feature
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 22:35, Stian Halseth wrote:

> Hi Mark,
> 
> On Thu, 2026-10-22 at 22:01 +0100, Mark Cave-Ayland wrote:
>>
>>
>> Hmmm. Feels like we're getting a bit blurred here between the crypto
>> feature and other sun4v features, however I think we're just going to
>> have to go with this for now.
> 
> Yes. The approach was discussed on the list. As Richard mentioned,
> ideally the sun4v platform could be used, but since it's incomplete, it
> would require a lot of work.
> 
>> Presumably no other interesting ASIs have showed up in your tests so
>> far?
>>
> 
> Thanks for the review, but your question made me think about openssl,
> and I found a real problem that I didn't see before. Please don't apply
> 7/8 and 8/8.
> 
> On real hardware, a store to ASI 0xe2 at an aligned address also zeroes
> the rest of the block. I measured it: the T4 zeroes the 32-byte block,
> the M7 the whole 64-byte line. Other offsets are plain stores.
> 
> glibc's niagara4 memset depends on this. For zeroing it only stores
> two of every eight words and lets the hardware clear the rest. QEMU
> does a plain 8-byte store, so with 7/8 and 8/8 a memset(p, 0, n) of
> more than about 120 bytes leaves stale data behind. OpenSSL from a
> Gentoo stage3 crashes at startup because of it. So 7/8 only turns
> the SIGILL into silent corruption.
> 
> And then I found a second gap..!
> QEMU rejects the FP form (stda %f, 0xe2), which OpenSSL's T4 AES code
> uses for large buffers. OpenSSL probes the CFR itself rather than
> AT_HWCAP, so with only 1-6 and -cpu ...,+vis3,+crypto, AES-CBC/CTR on
> large inputs gets SIGILL. SHA and the other instructions work fine with
> OpenSSL.
> 
> My suggestion: 1-6 can go in as Philippe proposed, since the feature
> is opt-in. I'll withdraw 7/8 and 8/8 and send a separate series that
> models block-init stores properly (integer and FP, zero-fill as on the
> T4), with the hwcap patch on top. I have a memset/memcpy test that
> passes natively on the T4 and catches this, so that series will come
> with better testing.
> 
> Sorry for the churn, and thanks for asking the right question.
> 
> /Stian

Ack. I'll let this settle overnight as it is getting late here, and aim to send a PR 
for patches 1-6 tomorrow evening.


ATB,

Mark.


