Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A96E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 22:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMabd-0000qe-1l; Sat, 14 Dec 2024 17:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMabZ-0000qT-UX
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 17:27:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMabY-0004v8-1O
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 17:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=iAW1Y/96QoalpJ2Nb+wdUicojFfIapRrCEmL26tmNGI=; b=bbeFnpvf+T8kHqoblZnM8g+6Uc
 pbD473WLyXo0wRX0qEBb5G8F0VkBtBcfBbGCeSwZry+fOIhBmZ2yRvu5hBNurK6wpl6ZwsLb899pn
 crPjJz9gNqSx5+t9b0HSdIFz5BXdBQ9RB7YCa86Xy/b8/fr1imSBi5fla86weBLuFqC9einDyH92z
 B0rGFbfnNgGdsTU+FAxz8n6WHEWFsk1EfGcYH1rhDwu+Jd34MlzqNN3Q8KrXNtFd5NCJhY24zgWSh
 tbW+VpHrVxgkwasrF3c19JOwPLXnriDSuwlcXOn1LqcntkNGLKdIO6yhhFhcdxyvnQ8f8TixsG3jD
 jNPzUgIr3zCJsn44vYC9Qvwqi9YsBG+oqyCCRIYAw8C5wQIngf4cCJpl8+UJ2aAfS8rMx/fhMzIa3
 eriWowwi12nbk6eZqyts/y/XrlffmtJ8GCFNALr9htuehBTiIonnvX6RmSOWp6RF50fFf51EOTZxY
 Beawzhk9YGBjoOay/QTNAGQLf5r8BFPpFHi1cM3FKMg/muwL8EsjSnpdAT7gZuKEPN1ubLeJfapDn
 0ea5ovcbESYKs1U/muBjYlkj5t5dv6FkVbvCTGCiVUgMOhPisP4jLofPXKd017SeQ8OTaMTcXEvr7
 UIhNtEQx3Q91tKJou2wuQunGbUCbG280C92j2V8Dc=;
Received: from [2a02:8012:2f01:0:839f:b883:9bde:613a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMaau-0006YR-F8; Sat, 14 Dec 2024 22:26:44 +0000
Message-ID: <23e50b5c-a7e4-402f-a615-0e8ed6717c8f@ilande.co.uk>
Date: Sat, 14 Dec 2024 22:27:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-15-mark.cave-ayland@ilande.co.uk>
 <df9030cb-cc19-4d2b-8d6a-0acb7b8b32ca@linaro.org>
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
In-Reply-To: <df9030cb-cc19-4d2b-8d6a-0acb7b8b32ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:839f:b883:9bde:613a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 14/34] next-cube: add empty slots for unknown accesses
 to next.scr memory region
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

On 14/12/2024 13:32, Philippe Mathieu-Daudé wrote:

> On 12/12/24 12:46, Mark Cave-Ayland wrote:
>> The next.scr memory is now effectively unused, however there are 3 separate region
>> accesses still logged that occur when booting a NeXTStep disk image. Use the
>> empty_slot device to capture and ignore memory accesses to these 3 memory regions.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>>   hw/m68k/Kconfig     | 1 +
>>   hw/m68k/next-cube.c | 8 ++++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
>> index 0092cda4e9..aff769b30f 100644
>> --- a/hw/m68k/Kconfig
>> +++ b/hw/m68k/Kconfig
>> @@ -18,6 +18,7 @@ config NEXTCUBE
>>       depends on M68K
>>       select FRAMEBUFFER
>>       select ESCC
>> +    select EMPTY_SLOT
>>   config Q800
>>       bool
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index 76ecf86ed0..95d01030cd 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -22,6 +22,7 @@
>>   #include "qom/object.h"
>>   #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
>>   #include "hw/block/fdc.h"
>> +#include "hw/misc/empty_slot.h"
>>   #include "hw/qdev-properties.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>> @@ -1239,6 +1240,13 @@ static void next_cube_init(MachineState *machine)
>>       /* BMAP IO - acts as a catch-all for now */
>>       sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
>> +    /* unknown: Brightness control register? */
>> +    empty_slot_init("next.unknown", 0x02110000, 0x10);
>> +    /* unknown: Magneto-Optical drive controller? */
>> +    empty_slot_init("next.unknown", 0x02112000, 0x10);
>> +    /* unknown: Serial clock configuration register? */
>> +    empty_slot_init("next.unknown", 0x02118004, 0x10);
> 
> IIRC the 'name' argument of empty_slot_init() was to log accesses,
> but apparently the patch has never been merged.
> 
> Maybe use "next.unknown0/1/2" in preparation?
> 
>> +
>>       /* BMAP memory */
>>       memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
>>                                              64, RAM_SHARED, &error_fatal);
> 
> 

That's a good idea: I'll use a numerical suffix for v3.


ATB,

Mark.


