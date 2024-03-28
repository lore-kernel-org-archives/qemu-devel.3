Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB79C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqSc-0002Po-9A; Thu, 28 Mar 2024 10:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rpqSC-0002BE-DL; Thu, 28 Mar 2024 10:10:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rpqSA-0005Cb-MC; Thu, 28 Mar 2024 10:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZuA6NT0jNMphZQh64B+Okobf3QD0+Z1fOnMjG1hAqI=; b=DsHJEgd/iAyEZtEPdH4HTvYGE0
 4ALQG8ha5S9T/BjFKfgoE/qGpMB6bs3BZovL6DI6P0OzU1tZAJhq0TIiP2yNkznDgV2zOdHDT5p1k
 5FeCV/www8dEsNHHE6qP4BgjmAxVAbrTb021F0wFEHQuOkgj/2qQGdJ3n0POXC9bRsxPkuj2YfYDR
 zNV1WD9i/rffy4RE6PAhg4DCA9BjmAUzAUVkh+sgnrvgsRrKwc86xuXeFknCZwOeFa3t5e7oHOxuG
 Q0dz4oPI+cjdmwrDE2ewS/XkcRYZ7J1z93mijjfIn//To62lEL1At6lhnNzN1OKVNkmqoL08Mv0dQ
 kj7gzKjcENmXF6JzDTg6AZEZGOe6osiNBjGdsPw3iK2wdHTvuTADv8y0zHfcVobslhaA2SD6g4nrJ
 pteng8VCY79lXm/vlv09S4oqZytQcBigpQcYuaI6K4U+xi8Wcz3ofBvMdMod6wW/NBfAxsI2l2hMu
 JmIv4FXuxnCyahJJoGRpZ8UhttJdJVBGgVbblUQz9EtkOqJ4CEIzLaMOhZWqI/DEAgaAsXWE9echk
 SAmBtvRNoCVJGS45mGrfKUj4CoRscQFLXlo4eRgCEWrce86eYosfLwuAnZ3Qe0LHlbJnNCLrTZGOU
 aulMRjzsSB/zWOAFvNUI9gLUnORMUGuV0XOsnk8+4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rpqRB-0000Gd-HO; Thu, 28 Mar 2024 14:09:01 +0000
Message-ID: <2dbf45c6-33a3-4ebc-a78a-75305836022e@ilande.co.uk>
Date: Thu, 28 Mar 2024 14:09:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, devel@lists.libvirt.org, richard.henderson@linaro.org,
 mst@redhat.com, thuth@redhat.com, qemu-trivial@nongnu.org
References: <20240326125104.90103-1-imammedo@redhat.com>
 <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
 <vyepknhyulwvmyypt74i7gvu4nqqqzhgdj2fxi66rgdnipi2co@ildhvlycqf2v>
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
In-Reply-To: <vyepknhyulwvmyypt74i7gvu4nqqqzhgdj2fxi66rgdnipi2co@ildhvlycqf2v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
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

On 27/03/2024 07:09, Gerd Hoffmann wrote:

> On Tue, Mar 26, 2024 at 01:30:48PM +0000, Mark Cave-Ayland wrote:
>> Heh I've actually been using isapc over the past couple of weeks to fire up
>> some old programs in a Windows 3 VM :)
> 
> I'm wondering why these use cases can't simply use the 'pc' machine
> type?
> 
> The early pci chipsets of the 90-ies have been designed in a
> backward-compatible manner, with devices such as the IDE controller
> being mapped to the standard ISA ioports.  So even an historic OS which
> does not know what PCI is can run on that hardware, by simply talking to
> devices using the standard ISA io ports ...

Hmmm that's a fair point: I think the pc machine has a PCI-ISA bridge included, so 
ISA devices can be plugged in as needed. The reason I ended up on that configuration 
was because I ended up chasing down a regression, and wanted to quickly eliminate 
things such as ACPI.


ATB,

Mark.


