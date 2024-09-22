Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C3BCF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 11:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLDr-0004xc-6O; Sun, 22 Sep 2024 07:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLDp-0004x6-Bi
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 07:57:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLDn-0001kY-I3
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 07:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4frdvPwgJ+kiRi8Yuh/O4hxXpitZpmRM0nyZ2nU7V7s=; b=YLQ2Vy9OsXmq8QBTs2fH2f6GK5
 henW8Hn3FmPE57yCQcxwQZh5YsA5dxSEqvMk9I+qd4gfo6r/nvSm2B534t4imSnLLaTnAVzJ56uM7
 pyv5iZy+bo56ZkRkhDWSWQ3Lujt8MYhlUXsDkCLwUW7xRTb8PtTc5wyXgHLaQtyO62TSVTWCtTfSV
 kzHfnc0E5/cr+En15faUoW0K0ErG3OoOwbm4IYmSXAtE3mnxulIG36hgsc7KdJUFQN+2rp5ly8cRG
 R3OD90jNiaOadKdR937RIw8iRPIE6wjxpYUBT+gxBo+qcPf1jNBu/uBQsqXcLxVlpyhkLCYdbx7c6
 FTG4SYOWaQSF3dbfh2XXD6T3fH6MOoh5LkZniM3Inl+dxQSjPbjFMZuzeJDyiFDeQu3SpzO8hWLOH
 YXkDhx+zR9jB9WNcrgJvuOjYfPzyV+XuO6uMliBNMpNjeSlhG/hwefjjIfK/JbJlxaBz6VSQGfj3z
 A/SWw3yOlNGf+wp/1GLf2NFW3vWXKuy8XzTnd7yz2V5rELesNEhYHWYVuBpsML2+wyq8vlmi6FM3r
 fz5Dq7XAPzH5j0mat4Gb1GK40LfBVLJ5fnewkd6ViuVLuEQvwf7n+Z8oCkmL4KFtu0juKmhBOWg0I
 IHKcSUTMpdNUK1kGKOT2joSbPxkSwdfSqppRoc72M=;
Received: from [2a00:23c4:8bb8:7000:41b:8fca:3a2a:2286]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLDZ-00092u-1q; Sun, 22 Sep 2024 12:57:37 +0100
Message-ID: <eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk>
Date: Sun, 22 Sep 2024 12:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Igor Mammedov <imammedo@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
References: <20240814115736.1580337-1-ribalda@chromium.org>
 <20240821164553.63007e25@imammedo.users.ipa.redhat.com>
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
In-Reply-To: <20240821164553.63007e25@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:41b:8fca:3a2a:2286
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 0/3] hw/i386/acpi: Pre-compute the _PRT table
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

On 21/08/2024 15:45, Igor Mammedov wrote:

> On Wed, 14 Aug 2024 11:56:08 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
> 
>> Today for x86 the _PRT() table is computed in runtime.
>> Under some configurations, computing the _PRT table can take more than
>> 30 seconds and the ACPI timeout is violated.
>>
>> This patchset modifies _PRT() to return a pre-computed table.
> 
> To be sure we are not breaking anything boot tested it with
> rhel6.7/9.0, winxp, ws2022

Hi Ricardo/Igor,

Unfortunately it seems that this series (and in particular commit 99cb2c6c7b 
("hw/i386/acpi-build: Return a pre-computed _PRT table") breaks my WinXP ISO boot 
test case using the dc390/am53C974 SCSI device.

Current master hangs when booting WinXP from a dc390 SCSI CD just after loading the 
kernel device drivers and displaying "Setup is starting Windows" instead of 
proceeding to the "Welcome to Setup" screen.

Note that there is a separate timeout issue caused by a bug in SeaBIOS which is fixed 
in the SeaBIOS repository as commit 2424e4c0 ("esp-scsi: indicate acceptance of 
MESSAGE IN phase data"). As the QEMU SeaBIOS binaries haven't yet been updated to 
contain this fix, I've uploaded a pre-built bios.bin to 
https://www.ilande.co.uk/tmp/qemu/bios.bin to help reproduce the issue.

Once the above file is downloaded the issue can be reproduced with the command line 
below:

./qemu-system-x86_64 \
   -m 1G \
   -device dc390,id=scsi0 \
   -device scsi-cd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=6,lun=0 \
   -drive file=winxp.iso,if=none,id=drive0 \
   -vga cirrus \
   -boot d \
   -trace 'esp*' \
   -bios bios.bin

With the ESP tracing enabled it is possible to see that WinXP appears to get stuck in 
a loop trying to send a SCSI command followed by a "Bus Reset". Reverting 99cb2c6c7b 
allows the WinXP ISO to boot to the "Welcome to Setup" screen as before.


ATB,

Mark.

>> Changelog v3->v4 Thanks Richard:
>> - Make link_name struct static
>>
>> Changelog v3->v4 Thanks Igor:
>> - Add missing files to tests/qtest/bios-tables-test-allowed-diff.h
>>
>> Changelog v2->v3 Thanks Michael:
>> - Code style
>> - Add cover letter
>>
>> Ricardo Ribalda (3):
>>    tests/acpi: pc: allow DSDT acpi table changes
>>    hw/i386/acpi-build: Return a pre-computed _PRT table
>>    tests/acpi: pc: update golden masters for DSDT
>>
>>   hw/i386/acpi-build.c                 | 120 +++++----------------------
>>   tests/data/acpi/x86/pc/DSDT          | Bin 6830 -> 8527 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpierst | Bin 6741 -> 8438 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 8155 -> 9852 bytes
>>   tests/data/acpi/x86/pc/DSDT.bridge   | Bin 13701 -> 15398 bytes
>>   tests/data/acpi/x86/pc/DSDT.cphp     | Bin 7294 -> 8991 bytes
>>   tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 8484 -> 10181 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 6781 -> 8478 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 3337 -> 5034 bytes
>>   tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 6902 -> 8599 bytes
>>   tests/data/acpi/x86/pc/DSDT.memhp    | Bin 8189 -> 9886 bytes
>>   tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 6688 -> 8385 bytes
>>   tests/data/acpi/x86/pc/DSDT.numamem  | Bin 6836 -> 8533 bytes
>>   tests/data/acpi/x86/pc/DSDT.roothp   | Bin 10623 -> 12320 bytes
>>   tests/data/acpi/x86/q35/DSDT.cxl     | Bin 9714 -> 13148 bytes
>>   tests/data/acpi/x86/q35/DSDT.viot    | Bin 9464 -> 14615 bytes
>>   16 files changed, 22 insertions(+), 98 deletions(-)


