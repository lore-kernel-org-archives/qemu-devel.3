Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB1606BB80
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rfc1149.net header.i=@rfc1149.net header.a=rsa-sha256 header.s=smtp header.b=QbVEB0dO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8yX-00081B-9p; Thu, 19 Nov 2026 15:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xU8yU-00080M-On; Thu, 19 Nov 2026 15:43:18 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xU8yS-0004AX-Vm; Thu, 19 Nov 2026 15:43:18 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 7C4D580022;
 Thu, 19 Nov 2026 21:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1795120991; bh=Kxh/9iUEiTAP1N0zfbJrs7VXXahADwaQC9JvBnY1pgY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QbVEB0dOnXcSrihZw0mG6V58aCQ0z4OQtq5XA3NUiXtxGdtgp1ljcjwHtham3Fnvn
 FS9mbw4F2vW9KToChI429DCPj3K2ccwJ4PwhQ2mJIn+LTpKSyq2FKX3IDDh56XCGj+
 idiTpwHu8R62f5EEYXlwrcBPDRkojAGjnDcd+48St61ZiWikYoGav2UpLzfsdVNVea
 +aJHtmIm75aH/np9cekOVypYTQsrHTZZH8nKx1XLgDZDo4Kp3xpajL3QdXc+7sE8BK
 DpBGOO4hKiThxlLEQ4+XCuGfETQbAuKSZEc6wbgjqQdsdAf7YMGfMCH9ptbNdKJvPj
 V3gDw/7/9gBRQ==
Content-Type: multipart/alternative;
 boundary="------------R4k7Hlh3fqRqL0FstqYqq4gC"
Message-ID: <180968ac-7e12-4e82-9720-fd4fa2fe2bfd@rfc1149.net>
Date: Thu, 19 Nov 2026 21:43:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine
Content-Language: fr
To: Mohammad Odeh <Mohammad.Odeh@EXALT.ps>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Bin Meng <bin.meng@processmission.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <179449578952.8382.2790865629085512841-3@git.sr.ht>
 <87eccnzofc.fsf@rfc1149.net>
 <KUYPR02MB9572B8DF47187FC6F82DC5CF95792@KUYPR02MB9572.apcprd02.prod.outlook.com>
From: Samuel Tardieu <sam@rfc1149.net>
Autocrypt: addr=sam@rfc1149.net; keydata=
 xsFNBFIIj5wBEAC107z3W0GPbpJNrjdAu2V9Ll6CrclxcN5XvQqxgS9USnOj5KKFiSAvoG03
 ubvNSjTmfdhJFd++2ft8bAbo4nxVnDEDTFKkY8eYtkDLgZ+wmMsR1rRz54H7wroHYqzzAeW/
 WFBGi4GrgtYyRiqmbmR1FTN/v6LovWJoloi7VD9j1IwYZ+GJCEDo37goO4ix7tml3WDRly+b
 bSM5cJd0vViH3xl2kAnytCWFsRLQ6hKicjGNgTrLSwpERzXPd/TmDcqr9lMxfxPvPk1bvQ9r
 cuudgattfzHUWs3KMxqHohNICkMmh7GGsWCwBQTBzZyEqWHZOUYY1cr0bB3ZQQy5tnn9Ml3a
 BHPrWP68JEnAXdpZfG1wC+h/yOXT75GssL1mHqXK9Nkpp8mHITsXctOq7OFTyj6n/rWjBwH0
 TgaApGm9qmL3AZp5w6USgarDuiBvzQOh3Gg8uFMmWtyjIAkWl5n2Y0GeTxrjlcUDUj8ANy8C
 CvjPZ4rsks93CRHd4FpPPMpARRWW/lYc2XvbVeKMPAshnVgTCxR5jYS4Qh+hWkOqD7Bil8jj
 eENziINVGHJzqdrDFtg8Nb5PlWqcvCM/Ov5fMQyBf7PifgQ8urBVspaGPLYZEThUXezSbiNe
 2YvV4fKkKo4PZT6jEZKPbT6nF0GyEZ6Sbo8/KSOr/Ma3cjQTuQARAQABzSBTYW11ZWwgVGFy
 ZGlldSA8c2FtQHJmYzExNDkubmV0PsLCjgQTAQoBOAIZAQKeAQKbAwULCQgHAgYVCgkICwIE
 FgIDAQIXgDEUgAAAAAAQABhwcm9vZkBhcmlhZG5lLmlkZG5zOnRhcmRpZXUubmV0P3R5cGU9
 VFhUXxSAAAAAABAARnByb29mQGFyaWFkbmUuaWRodHRwczovL2dpc3QuZ2l0aHViLmNvbS9z
 YW11ZWx0YXJkaWV1L2U0ODkyN2EyZjlmYjRiZTMxYzJlOWIxNGU4NjNkMzRjMRSAAAAAABAA
 GHByb29mQGFyaWFkbmUuaWRkbnM6cmZjMTE0OS5uZXQ/dHlwZT1UWFQyFIAAAAAAEAAZcHJv
 b2ZAYXJpYWRuZS5pZGh0dHBzOi8vbWFzdG8uYWkvQHJmYzExNDkWIQQdNtkkizPcq3ulukR6
 MLz0Qrj3wgUCZ6TNBwUJHSELawAKCRB6MLz0Qrj3wqb9D/9qDaGnv+SMIzt9KH8sD8mZHi5J
 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
In-Reply-To: <KUYPR02MB9572B8DF47187FC6F82DC5CF95792@KUYPR02MB9572.apcprd02.prod.outlook.com>
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_CSS=0.1 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------R4k7Hlh3fqRqL0FstqYqq4gC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 19/11/2026 09:49, Mohammad Odeh wrote:
> Would it make sense to rename the shared model to |stm32l4_soc| and 
> make L4x5 and L496 sibling variants under it?

After thinking more about it, I'd rather not go as far as stm32l4: the 
L4 family also includes other "families", such as the RM0394 
(L41x–L46x), which differ significantly while this model follows RM0351 
which covers both L4x5 and L4x6. Updating the header/description to say 
so (as for stm32f2xx_* being used by the F405) is probably enough. If a 
rename is still preferred, a separate mechanical patch before this one 
would make review easier, but it might be seen as gratuitous churn.

The abstract stm32l4x5-soc type already lets L496 be a sibling of the 
L4x5 variants. What seems more important to me is to make the 
variant-specific features class parameters: the SRAM2 alias at 
0x2004_0000 that I talked about, GPIO port I, and the number of 
IRQs/EXTI lines.

   Sam

--------------R4k7Hlh3fqRqL0FstqYqq4gC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 19/11/2026 09:49, Mohammad Odeh
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:KUYPR02MB9572B8DF47187FC6F82DC5CF95792@KUYPR02MB9572.apcprd02.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">@scope { P {margin-top:0;margin-bottom:0;} }</style>
      <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Would
        it make sense to rename the shared model to <code>stm32l4_soc</code>
        and make L4x5 and L496 sibling variants under it?</div>
    </blockquote>
    <p>After thinking more about it, I'd rather not go as far as
      stm32l4: the L4 family also includes other "families", such as the
      RM0394 (L41x–L46x), which differ significantly while this model
      follows RM0351 which covers both L4x5 and L4x6. Updating the
      header/description to say so (as for stm32f2xx_* being used by the
      F405) is probably enough. If a rename is still preferred, a
      separate mechanical patch before this one would make review
      easier, but it might be seen as gratuitous churn.<br>
      <br>
      The abstract stm32l4x5-soc type already lets L496 be a sibling of
      the L4x5 variants. What seems more important to me is to make the
      variant-specific features class parameters: the SRAM2 alias at
      0x2004_0000 that I talked about, GPIO port I, and the number of
      IRQs/EXTI lines.</p>
    <p>  Sam</p>
    <div id="grammalecte_menu_main_button_shadow_host"
      style="width: 0px; height: 0px;"></div>
  </body>
  <lt-container></lt-container>
</html>

--------------R4k7Hlh3fqRqL0FstqYqq4gC--

