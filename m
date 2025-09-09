Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9913CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw51R-0006Gz-2w; Tue, 09 Sep 2025 16:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uw51O-0006Gh-8Z
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 16:32:58 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uw51A-0006ps-Jn
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 16:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zgw+PIRkcysXCXb6I5/YyttJxVBOJGoSPRV/gP8U2y0=; b=bwuNsX5KgJiJ3J0nBARbsb+tzU
 GtxtAjNFZEuzdCPWO5Qqr2JhOWUAo9uH2Lx3eZzrY/CJ57xqfubisDov/keEuM0Lras7HRFHVEHqe
 cDeUF+xHUE1I+uprz4KNgeLrsVGCDUthnamC8NrH+U26AorAWbnwExIcyTGIbj4u/Zm43c0L6wrVJ
 /IWpccB7MSbJUOvViiYmqLqsvDibzPeEbKZbZsZmVzTmrNDO1dTDTcE3GdxuJUXHLA4J3QJzHc7ca
 uGombMRJN/OxC3c9K5BhURCBKCHl1Lymw+EAS1ynnwwT3VrSLkWal42/OqH4wlr4Qkf9AJHsG2ol/
 LyM50XgCwE5mTmgiahpByVmxYxzfioFtSJU7aZhyoZCQ0thMOY4t9180HVBc/O8V8Rerx0nUhE6hm
 YrqUvhXrF32A+WHN4mrpFOrjqUDTSj9hnd6gMT+y5rREZDHNPSWDdwnzBEP64jTJE1ELOhFO6uz9a
 88V6tpVIbIiVnpRK+VcJXUNkRU3CDk/fnZOvy8x0syvh4DCCifOSPm1EtHG+UOhfl/7P2KAORbSAV
 STlZvMYLCpwvxXGyuFoI6Ve2ZckByFpK5HwJJ2bxRAsAhFkYtO+fcC/BaDLCSqKBYiQXE6qdZ2aFV
 TMUt+aSZyR4tYabzqod4txNgw2ujr3VM8TYCn9wPU=;
Received: from [2a02:8012:2f01::15d6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uw4z6-0003pB-UW; Tue, 09 Sep 2025 21:30:41 +0100
Message-ID: <27f8b4bb-8db1-458c-8489-876662ae40eb@ilande.co.uk>
Date: Tue, 9 Sep 2025 21:32:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>
References: <20250909074817.84661-1-thuth@redhat.com>
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
In-Reply-To: <20250909074817.84661-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01::15d6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] tests/functional/m68k: Use proper polling in the
 next-cube test
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

On 09/09/2025 08:48, Thomas Huth wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> The next-cube tests currently sleep for 2 seconds to wait for the
> guest's display to come up with the expected results. That's bad
> since there is still a theoretical race left here, and since there
> are two subtests, the whole test takes more than 4 seconds this way.
> 
> Looking at what the firmware does, there is a better way instead of
> blindly waiting for two seconds: The firmware is writing some values
> to the FPU registers during a test (and never touches them again
> afterwards, so we can be sure about the final values), so we can
> poll for the right values in those registers to know when we reached
> a state when the display is initialized for sure. We just have to
> also make sure to not look for text anymore that is only printed
> after the FPU test has been done by the guest firmware.
> 
> This way the whole tests finishes in less than 1 second here, and
> there should be no race condition here anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/m68k/test_nextcube.py | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
> index c1610e58456..e5e1c69dcbd 100755
> --- a/tests/functional/m68k/test_nextcube.py
> +++ b/tests/functional/m68k/test_nextcube.py
> @@ -29,8 +29,15 @@ def check_bootrom_framebuffer(self, screenshot_path):
>           self.vm.launch()
>   
>           self.log.info('VM launched, waiting for display')
> -        # TODO: wait for the 'displaysurface_create 1120x832' trace-event.
> -        time.sleep(2)
> +        # Wait for the FPU test to finish, then the display is available, too:
> +        while True:
> +            res = self.vm.cmd('human-monitor-command',
> +                              command_line='info registers')
> +            if ("F0 = 400e 8400000000000000" in res and
> +                "F1 = 400e 83ff000000000000" in res and
> +                "F2 = 400e 83ff000000000000" in res):
> +                break
> +            time.sleep(0.1)
>   
>           res = self.vm.cmd('human-monitor-command',
>                             command_line='screendump %s' % screenshot_path)
> @@ -56,10 +63,10 @@ def test_bootrom_framebuffer_ocr_with_tesseract(self):
>           self.check_bootrom_framebuffer(screenshot_path)
>           lines = tesseract_ocr(screenshot_path)
>           text = '\n'.join(lines)
> +        self.assertIn('Backplane slot', text)
> +        self.assertIn('Ethernet address', text)
>           self.assertIn('Testing the FPU', text)
> -        self.assertIn('System test failed. Error code', text)
> -        self.assertIn('Boot command', text)
> -        self.assertIn('Next>', text)
> +
>   
>   if __name__ == '__main__':
>       QemuSystemTest.main()

That's a cute hack :)  I do wonder if we risk missing anything by finishing the test 
early, but then again it still isn't possible to boot to userspace so currently we 
don't miss much.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Note to self: I must try and find time to finish off my DMA rework series...


ATB,

Mark.


