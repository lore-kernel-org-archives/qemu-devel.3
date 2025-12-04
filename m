Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5AD1CDBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 02:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQyep-0000rG-H9; Wed, 03 Dec 2025 21:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vQyeh-0000km-7g; Wed, 03 Dec 2025 21:01:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vQyec-0002Jy-RJ; Wed, 03 Dec 2025 21:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=orFCOcjalNPM6YdLq+ud4NwpphC3DsEhRiCD/tlSYBw=; b=ZFyIYWBHo51sQ8r2cu+ZAAxP2O
 WC6/JrLLwUNeVAQzxT+fqh+lnglkKn88+9Qbyzzd1C7s+P5f24HhsI0CX2wDaOA9+N/Pbbh6h2wig
 sOhTtqDRFXqJsRQGeH2YeFWLbt2wUM5Jz54e1ovXXv1HaT004obNokb8dxtICpFEOdcel5kFdVQ/k
 t9CT8WeKLETW2PRO/dcZbhVP1zUVQK+bGvsCEyTmwedVCQuydVkwC+TqCiu+PQz4uwzyXFqwgXthl
 rnDod9lnEHOClPAhP/BmSbFJDF+1x5Cd2yf0WtlbDp4MBDpay7gLLW8Z0oXnpp6Y9NQU4XfcOXYc/
 4/Z4pHhYPkdsJHVf0JzLOo0wttkNOGVIE67DwC204w/rNX7q53Is4WYEqITe9iJceYoGfSakQCUSi
 1QkQxpXNxtGvXK1vFa6Z7inVEYlN7KDRXUh87ARPkg68Xd6yNW0CxACXgicEX9ZFAhOkd72ua4oUo
 wilorfOqDGQvQvh3ITd5C6QBuOlvuhdOhie9mIqmhUu1MzkPROSGcet+ow9eSt2CLp3ohVQvk2TUx
 nsUbKQL3AjoccB036AOwO/5bXqC8NKf8Q8hJE/NrTCdfEdpU2R65bi05llyNIFZALsKm54IWYNxzR
 BYd23dIXEx6gw1jvCMD+LkeyCoIE/o2nBvVjwMFZo=;
Received: from [2a02:8012:2f01:0:4dd9:a8dd:82fe:37f5]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vQyc7-0008pP-6h; Thu, 04 Dec 2025 01:58:35 +0000
Message-ID: <c03820b8-7745-4b8e-8e69-a37c872257f8@ilande.co.uk>
Date: Thu, 4 Dec 2025 02:01:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-9-philmd@linaro.org> <aTBccn2LIv7puGzR@intel.com>
 <05f92a77-7587-4441-a252-01e4705a6892@linaro.org>
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
In-Reply-To: <05f92a77-7587-4441-a252-01e4705a6892@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4dd9:a8dd:82fe:37f5
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
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

On 03/12/2025 17:14, Philippe Mathieu-Daudé wrote:

> On 3/12/25 16:51, Zhao Liu wrote:
>> Hi Philippe,
>>
>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>> index 82c3e7c855b..6dc9f64b74d 100644
>>> --- a/hw/sparc64/sun4u.c
>>> +++ b/hw/sparc64/sun4u.c
>>> @@ -683,14 +683,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>>                              graphic_width, graphic_height, graphic_depth,
>>>                              (uint8_t *)&macaddr);
>>> -    dev = qdev_new(TYPE_FW_CFG_IO);
>>> -    qdev_prop_set_bit(dev, "dma_enabled", false);
>>> -    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
>>
>> There's another difference: fw_cfg_init_io_nodma() uses `machine` as the
>> parent and here sun4uv uses `ebus`.
> 
> Ah yeah I wanted to comment it but forgot :facepalm:
> 
>>
>> I think maybe one reason to use `ebus` is because...
>>
>>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> -    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> ... because the parent region is managed by ebus.
>>
>> Perhaps we should add another argument: Object *parent?
> 
> I thought about it but don't think so, all instances but this one use
> the machine container.
> 
> I'll improve the description.

The reason that the fw_cfg device lives under ebus on sun4u is because the ebus 
device is effectively a PCI-ISA bridge, and the fw_cfg port is mapped into I/O 
address space along with other ISA devices. I'm not sure that setting the parent to 
the machine is the right thing to do here.


ATB,

Mark.


