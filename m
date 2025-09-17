Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DEBCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyymR-0001GT-6f; Wed, 17 Sep 2025 16:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyymP-0001GF-HV
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:29:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyymO-0004Bm-1d
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VUYOUuO1Qx2ivaZgW4cO82EeeQWxiRxwy7+ubQl90L4=; b=sURgrFzZ0RTIK3X0ul57XOe28y
 fF0dyRcpIm8KcvL8i15ItvWqdk7qhvu0lfy/F0BDi9a8GgAtHvdg+nWHSiCs/bCC1b2MRQj5QuRUn
 xQWEzB4ZNADvM/Q4C2ffbM7MFCRGzCRTa3MRt8f2aNKdw+O7L05UM9TYr8Thlx8v79uV7qlHqkwzw
 gzflP4F7BNVu1J1hdhz/jEnoAt01g222ueH4i1bKpmmKS57YjgCYhN+yWJK8b5Bc57tSeWy9CajYP
 wLjrOhrFepUjnzzfdYiONhxWHMvMz3jb4hNuAWk0CdqEZzBgGXzO3ZSOgPQXETtm+l38+7M3ZQL5N
 DldEExpdpvSTRHerFxgHY609nyEQe+nFuHti3W2/YotwjpkVDTUpTe/zFdKPrMjNaAmfc1bFl/svE
 zrrg8axtCcyfAyaT5r6Gq8wGXMj+O1DtEj8yIFUKo5GF35pYYq22kqakxbbMBY/p+5KA3IWIbArEF
 IFsyhQncoCYmZVFYZ1OBmjeTLED4bRmcoiHCUPzQAgE49/CLmIqEy/Bv7eqtXIIZrbYibokaX09JK
 OIkqP5nKJxYtnAAm+fh0ErGVHNlpu+1tFWskNfOLg1QYOOb1AqTtOkiNJUGA0h7pTESaZId7rLyhm
 48FkdMalhc5o86wYo3b4/sj6GJOZQNNUx3gh6M0hk=;
Received: from [2a02:8012:2f01:0:ff11:26c7:ce3f:b269]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyykO-000ANw-OY; Wed, 17 Sep 2025 21:27:25 +0100
Message-ID: <763f051f-79b3-4f38-b597-cd59c0ca2679@ilande.co.uk>
Date: Wed, 17 Sep 2025 21:29:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20250905115128.376295-1-richard.henderson@linaro.org>
 <20250905115128.376295-7-richard.henderson@linaro.org>
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
In-Reply-To: <20250905115128.376295-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:ff11:26c7:ce3f:b269
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 6/7] target/sparc: Loosen decode of RDTBR for v7
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

On 05/09/2025 12:51, Richard Henderson wrote:

> For v7, bits [18:0] are ignored.
> For v8, bits [18:14] are reserved and bits [13:0] are ignored.
> 
> Fixes: e8325dc02d0 ("target/sparc: Move RDTBR, FLUSHW to decodetree")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 77b2f54fdf..242ec42016 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -226,7 +226,7 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
>   
>   {
>     FLUSHW    10 00000 101011 00000 0 0000000000000
> -  RDTBR     10 rd:5  101011 00000 0 0000000000000
> +  RDTBR     10 rd:5  101011 ----- - -------------
>   }
>   
>   {

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


