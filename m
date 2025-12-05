Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D6D374A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 21:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRdEI-0001T0-Tt; Fri, 05 Dec 2025 16:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vRdEG-0001SJ-Di
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 16:20:40 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vRdEE-0002kV-Ir
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 16:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eosK1Px9rBrsEGmygvM2ZTdW+TshzamoYBFzIrac3hU=; b=0a8rYBrynYALYbMcbJb2QHlFAM
 QqB+7L6U+PpIPepox2f+V/N8lHYZ/GtjQB1xzQZqhE86StVL7wXbCYASv2Aw/sbdTrpn5Jq1gxlct
 j/S3BMCWh6MhGIwbq6khQdYK4tOlkoVOiHTIx3eTsdlb0okONZtm6Ap4qtKReyAQKCPOtqjnVtmc8
 yWXlDd6fVP9dGarp6eU9ozeUTd9jZlolOtG9rr+HKU5qS9we3l48wTgX2esXGpR41Tvfmjo8DPY55
 cn+qN89ylTv8ux3NZuWHnVkksvpavZND47xng3ST2fTuLQlSkoCxRoHTXsjYYr9ly1G3ioCTx3+z5
 fCMVtzLiex7lMLyd0+eLUlbxIYX5dPYdr5PpyDIpqipxrwSZpJdUezrw8q8D2o4jDCCONNnBy38FC
 DwjLpGh8R8wVwT+mBrtgpBVSCnztKpjoqLD9x1s34pMKRbXB1Yn/kwK+mT2XdQtwYiBlog/JCaURb
 qYQAspFQnV9arIlibWFc8SgaUoiUw7o5oHPH9MkLHcklhD9q8Jkb2AXsxXjnbRxwwbj1cNDf/BypY
 GtpTq/Qd0RwzY4Vpyryr6IJxSQqO4Ucvlu9AdKUGXBawaOTQI9bnN2Tshja5Uei027HEpnox9pM8S
 8ijQt9DARpi+4jK+chwaP5wJ0709vi+dXxxn7U2Es=;
Received: from [2a02:8012:2f01:0:c841:1a2:1f49:5881]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vRdBm-0004dr-4G; Fri, 05 Dec 2025 21:18:06 +0000
Message-ID: <ab79a32b-24b3-418e-a2c5-6427cf174d35@ilande.co.uk>
Date: Fri, 5 Dec 2025 21:20:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20251203064336.79847-1-mhjacobson@me.com>
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
In-Reply-To: <20251203064336.79847-1-mhjacobson@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:c841:1a2:1f49:5881
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/1] hw/m68k: add working floppy controller for q800
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

On 03/12/2025 06:43, Matt Jacobson wrote:

> [Please notify me of any process errors -- this is my first contribution to
> QEMU.  Thanks.]
> 
> Implement the SWIM2 floppy controller for the q800 machine.
> (For details, see: <https://archive.org/details/SWIMDesignDocs/SWIM2%20ERS/>.)
> 
> Reading and writing work, and booting from a system disk works.
> Tested with the Quadra 800 ROM and System 7.
> 
> Future areas of work here could include:
> 
> * Allowing for disk formatting/duplication to work
> * Fleshing out the SWIM1 and hooking it up to the emulated drive
> * Implementing the IWM for earlier machines (this could share code with SWIM1)
> 
> Matt Jacobson (1):
>    hw/m68k: add working floppy controller for q800
> 
>   hw/block/meson.build               |   2 +-
>   hw/block/sony_superdrive.c         | 940 +++++++++++++++++++++++++++++
>   hw/block/swim2.c                   | 657 ++++++++++++++++++++
>   hw/block/trace-events              |  17 +
>   hw/m68k/q800.c                     |   4 +-
>   include/hw/block/sony_superdrive.h |  55 ++
>   include/hw/block/swim2.h           |  66 ++
>   include/hw/m68k/q800.h             |   4 +-
>   8 files changed, 1740 insertions(+), 5 deletions(-)
>   create mode 100644 hw/block/sony_superdrive.c
>   create mode 100644 hw/block/swim2.c
>   create mode 100644 include/hw/block/sony_superdrive.h
>   create mode 100644 include/hw/block/swim2.h

Thanks for the contribution! I've applied this patch and managed to get it to compile 
successfully, but I'm struggling to find a suitable disk image that works. Can you 
point me towards both a GCR and an MFM image I can use for testing? I think this 
might be because the images I use here are simply HFS(+) images.

Some initial thoughts from looking over the code:

- The basic implementation looks fairly good from what I can see, but I can see a 
number of places that don't match our code style guidelines. You can do a basic style 
check running "./scripts/checkpatch.pl HEAD~1..HEAD" from a git checkout with your 
patch applied which will pick up the majority of issues.

- Having everything in one patch makes it harder to review: I think it would make 
sense to introduce the SONY drive in one patch, the updated SWIM2 controller in 
another, and then a final patch to update the q800 machine to switch over the SWIM2. 
And maybe even an extra patch to remove the existing SWIM1 stub? The stub was added 
with just enough implemented to allow Linux to boot.

- Have you tested with an A/UX 3.0.1 boot floppy? A number of people are interested 
to run AUX 3.0.1 as per 
https://www.emaculation.com/doku.php/m68k-qemu-on-windows#running_qemu-system-m68k_with_a_ux_3x_guests_in_windows 
and it would be good to be able to use the real floppy image here.

- QEMU already has a fairly good Fifo8 implementation: is it possible to use that or 
Fifo32 instead of reinventing it here?

- It's worth updating the cover letter to include an example command line. I had to 
go digging into the patch to discover that I needed to add something like "-drive 
file=/tmp/Install.img,if=none,id=floppy" to attempt a floppy boot. Configuring 
internal devices can be fiddly: I'm wondering if there is existing precedent in the 
way PC floppy drives work that we can use to keep things consistent?

- When booting a test Linux image I got stuck in a boot loop, both with and without a 
floppy inserted in the drive:

swim2_mmio_read addr=0x1e00 size=1 reg=7 [HANDSHAKE] value=0x8 mode=0xca setup=0x28 
phase=0x74 fifo=0
swim2_mmio_read addr=0x1e00 size=1 reg=7 [HANDSHAKE] value=0x8 mode=0xca setup=0x28 
phase=0x74 fifo=0
...
...

Since the Linux maintainers make use of QEMU for testing, I think we need to get this 
working. Laurent - do you know if the 68K Mac kernel driver works on real hardware?

I appreciate the time and effort that has gone into creating this patch, and I'm 
really looking forward to getting it to a point where it can be merged :)


ATB,

Mark.


