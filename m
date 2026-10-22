Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=q0oBx0k7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK06v-0004df-DI; Thu, 22 Oct 2026 17:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK06r-0004dN-UX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:14:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK06p-0003KU-IQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WQJ2SHhG+54Pe61vKFjdUyLra1AowDil2IN15WeKuZA=; b=q0oBx0k7LQIcmHROGc5VzcYzkR
 QovQmhuK3JjEEmJQBp0B+X7JVqSLwfYnTCUjrvhzIXemx6nxSOq0chGvgCORkUZYGR6KlcEeLvZC0
 9mv+WeRTN6zs/CFlNPFh5IXz4FA1FPhaptLmC1SpeuXbi7i6JH/ItxP0H/+rEWXH+PrPmSwSu6S+r
 b1SWkj5uue6VCj35D7rclDomKVh3FRDshYI4Dl178meZLWPUpntSo88ebaaprS9DIZDQEuLMkxdjv
 DXkzDzlNswf6C6nbquShawdqjjkcY//+y3QwtyJu0jaQ3E5B4aeok/AR7Lq/f/HEyYabZ95iWBVLr
 OZWfM7o/rJkL7gIH95aY81i4br3nwK0HbWhcbzKIqAOtHukIAvj6z14uVpwtYo3hhmoJDjcGXQJwL
 LqSq9HMJeFR1gxtkBhaR3oWd4V5SP19zwv+njjO9lfXei7CDHKDSt9FfMKVOAqo1hgXw9q74NgPT/
 xvaOPxLkWWE2e23MQk0esGKDbh6RRUXRCxEeBnIxpNsxnWCQe2cS4nzx05CebIUmotmou5NygZa/4
 J1vpRCDXYCqBiPt0DVejaeyZ49LFCH8IruKeeKnqnDgPy1Ne91vcBOpEMlqyrmyOjb6Dqc5obCQ4o
 OjcgU3YcL587ucuLDwcAFmamGcfI8tD+BT40t4Lj8=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK065-003Fhq-TU; Thu, 22 Oct 2026 22:13:14 +0100
Message-ID: <c94faeca-b6d7-4742-8927-a7573e774983@ilande.co.uk>
Date: Thu, 22 Oct 2026 22:13:55 +0100
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
 <20261022070059.3861291-5-stian@itx.no>
 <b31c544d-b369-4d42-918e-ddafda444d78@ilande.co.uk>
 <03d991dc43d5c7bc91a0bee350a11bdd8e499fa9.camel@itx.no>
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
In-Reply-To: <03d991dc43d5c7bc91a0bee350a11bdd8e499fa9.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 4/8] target/sparc: Add the AES key expansion
 instructions
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

On 22/10/2026 21:55, Stian Halseth wrote:

> Hi Mark,
> 
> On Thu, 2026-10-22 at 21:43 +0100, Mark Cave-Ayland wrote:
>>
>> Please can we match the existing style in translate.c and remove the
>> indent here?
> 
> Noted for v4.
> 
>>
>>> +        TCGv_i64 dst, src1, src2;
>>> +
>>> +        if (!avail_CRYPTO(dc)) {
>>> +            return false;
>>> +        }
>>> +        if (gen_trap_ifnofpu(dc)) {
>>> +            return true;
>>> +        }
>>
>> Question: is it possible for a 64-bit CPU not to have a FPU? Even
>> more so, one with
>> the crypto extensions present? I wonder if gen_trap_ifnofpu() isn't
>> needed here.
> 
> Not to my knowledge, but the gen_trap_ifnofpu() is checking if FPU is
> enabled, not if it's present. Every sparc64 CPU has an FPU, but it can
> be switched off. It's mentioned in the OSA 2011 spec.

(goes and looks)

Yes, you're right. I did wonder if the FPU registers were simply being used for 
storage (as opposed to carrying out the instructions), however OSA 2011 indicates 
that these instructions can throw an fp_disabled trap which suggests otherwise.

So it looks like this is correct.


ATB,

Mark.


