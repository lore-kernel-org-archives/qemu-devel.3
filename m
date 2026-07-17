Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9E8C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 06:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkyd5-0006dz-G0; Sat, 18 Jul 2026 02:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.nvura0w3un2tbp8=cdfimh3wrqor=f01nyhaqrmdabl@em1175899.techtravels.org>)
 id 1wkodA-0005PF-RA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:53:56 -0400
Received: from a1i764.smtp2go.com ([43.228.186.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.nvura0w3un2tbp8=cdfimh3wrqor=f01nyhaqrmdabl@em1175899.techtravels.org>)
 id 1wkod8-0004EL-Jn
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:From:To:Subject:Date:
 Message-ID:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=+MlfBlWmy9QNqAM/MUEFOZkkntEtZ6ExVb9Xk9Z7SPo=; b=Uhrz7JbnM70uHP/jf1qr/wbO6K
 tAmDh7Fyi0+G9CJJ0g8Qnrfo0qGxWM/p1cSArFWzh2zcmEn0oy6M2YA5C8TDgFv5yzcP8jb9KvoLA
 JwzX8TuqwoL/8g9shEgx2JfilYaHlcdT8V9so+FZQyOtqonZaTTrI5hwes0MWF/uYDlTrl1Ec1jTz
 GunLOjb5Ys0dX14tk73/w5lvvKm2K1u+4lMunffLZ6kmYoqsnklvEFjhf1MEN1b/0b34PkkDdmBO7
 VQiVOFN3lyAgKcL89NneCD4INCsCWq3RHMwLk/Mtmp0R/r1jHNW9KOqV/1N5zLZ85zJwiIxcg9Z82
 6BvY+QYA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1784318028; h=from :
 subject : to : message-id : date;
 bh=+MlfBlWmy9QNqAM/MUEFOZkkntEtZ6ExVb9Xk9Z7SPo=;
 b=Gxn0AfpA3eAW5NkukJsd2FwbfraFn/SWjOO+DlcyqBDU+v/PmFXsTQHYplgMvCeHmNe+w
 52XQoz5vOuCphHyp8wdDYLS0Z8d7xRok9kmghtwECqVrV6TTEFUGt3uaBjhR2zAL1rrg5uW
 xG59Pzp7LJUbRSsnmR+Joen8qs1/7kvJMtxUb0YDxd1apV/zqH0OGzw3rYX0/rxlnWkdEtm
 nXz+9ApLfcrEnsw6Ws+M+C4ejvs8nI/YZaHLARwwf4BFLVp8+Yst4xgMc0X1Cum+Ye0CCxm
 VSl1ddjNOK795M1XTtpBHfbkvV9TDUYZpn0l9bY3qkEQ5EFRS6vlmZXjR61Q==
Received: from [10.172.235.57] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <keith@techtravels.org>)
 id 1wkoci-beP80S-QX; Fri, 17 Jul 2026 19:53:28 +0000
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wkoch-FnQW0hQ0quM-vSXW; Fri, 17 Jul 2026 19:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1784318005;
 bh=P1s7iP6uuCgnZ0UiEtMpfxv/ULPqxk5+6LXCPe7fwCM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ga8Je9+yGZ9hm8T6biC21XCB9MOV5p0JjAqcLKd3BE6HvHIKqWt85I/qWyIPepUlB
 8iTTw9d2It6tw+OYKjncsqEYv8v/SKhao3N8vgeCVOQtIZ1qDAFb89iiXM7r5kjXR7
 +/AbRNd5fHbWgbcxp1qjE0HkwOTryhNJDrd42cf9WWfcc6ItUqKHSvi8vF38JbDJoZ
 bJT75n6ewb8NctryBHYhTuI8bBNIiFIxAiWl4um3+fZOuslcIBVUoefRTugwJ1g3U+
 ORQhASsFdGJtqURKknuv6e7PeVR10AzEwMzP/dEl2HUZ3K/scrtQ7D3ZQAx0K2qxB1
 xbC5tOkC8+oeg==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id D257C3F097;
 Fri, 17 Jul 2026 15:53:24 -0400 (EDT)
Message-ID: <23fd8443-ef92-43b5-859e-128c6c7c915e@techtravels.org>
Date: Fri, 17 Jul 2026 15:53:25 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
 <CAFEAcA_3vf5vrwoO0cGcdTsykU8uTf8386oyWki3iQ3Bje9Trw@mail.gmail.com>
 <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
 <CAFEAcA-s2xYKG5PiUqFufdgJgMxD1OccbHO9zcCH2+aXwkK70Q@mail.gmail.com>
 <74e5958d-58d8-4519-82dc-52e598eb6d68@techtravels.org>
 <da5290cf-f695-4107-abb6-63d435fefc9f@techtravels.org>
 <648c72c6-48bd-4725-b9d9-862c0dd95e73@ilande.co.uk>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <648c72c6-48bd-4725-b9d9-862c0dd95e73@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: yVJeHU0kyRSD.VbgsFQ57TB4x.Q405RQkTNc3
Feedback-ID: 1175899m:1175899aieqF3d:1175899s5U9-VI9CJ
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=43.228.186.252;
 envelope-from=bT.nvura0w3un2tbp8=cdfimh3wrqor=f01nyhaqrmdabl@em1175899.techtravels.org;
 helo=a1i764.smtp2go.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.209,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Jul 2026 02:33:20 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mark,

Thanks for engaging me on this rewrite.

I built an automated harness for each OS reference disk. It mounts the 
disk as a CD-ROM, creates a blank HDD, and uses pyte and regex to drive 
installation, reboot, and login.

Multiple HP-UX versions, Debian Linux, and NetBSD 9.4/10.1 all boot, 
install, reboot, and run successfully. That provides strong high-level 
confidence, though it does not rule out bugs.

I have run the tests hundreds of times, both sequentially and 
concurrently, to expose timing or race issues. The full suite takes 
about an hour.

I do not plan to distribute the images or tests because of licensing 
concerns and required preprocessing.

Thanks for mentioning those debug flags. I'm not using them now.

It wasn't lost on me that I wasn't including any relevant executable 
tests. When you say functional tests, are you talking specifically 
/tests/functional/hppa? So similar to test_cdboot.py, changing machine 
type to -M 715, downloadable asset/image? This does bring up where we 
point this to? Like is archive.org acceptable reference? Whether it's my 
harness or the other, we still have a few challenges.

Finally, I overstated the not bootable case, and this should be not be 
problematic. Linux/Debian and Netbsd will work at ANY patch level, but 
HP-UX (which to be clear doesn't work at all on the released existing 
710 model right now) will only start functioning once everything is in 
place.

Thanks,
Keith

On 7/14/2026 5:43 PM, Mark Cave-Ayland wrote:

> Hi Keith,
> 
> Thank you for your contribution to QEMU. I found myself in a similar 
> situation a couple of years back when I ended up reworking a large part 
> of the ESP SCSI emulation to fix some fairly obscure edge cases booting 
> Classic MacOS, so I understand how difficult a task this can be.
> 
> If you would like to take a look at my series and cover letter then you 
> can find it at https://patchew.org/QEMU/20240112125420.514425-1- 
> mark.cave-ayland@ilande.co.uk/, but I've summarised some thoughts below 
> based upon my experience:
> 
>    - I focused on using a small set of reference images and made sure 
> they would
>      boot upon every commit. This was really helpful as sometimes even a 
> subtle code
>      movement would cause something to break unexpectedly, and helped me 
> to find
>      extra edge cases I had missed.
> 
>    - Keep changes to individual devices in separate commits where 
> possible, and also
>      the same goes for refactoring/renaming commits and changes to the 
> device
>      logic/functionality. Often these commits can be merged earlier than 
> later
>      patches in the series where the reviewer may have more questions.
> 
>    - Not all reviewers are familiar with SCSI, so writing a good cover 
> letter
>      explaining each part of the series will help reviewers understand 
> the changes
>      during review.
> 
>    - Run your local tests in both a normal and --enable-debug build, and 
> also with
>      asan (--enable-asan) to catch any memory errors
> 
>    - Adding a functional test if possible would help prevent future 
> regressions.
> 
> Similarly for reviewers I should note that the LSI SCRIPTS engine is 
> quite complex: in effect it is almost like a separate processor 
> executing its own programs (SCRIPTS) to perform I/O.
> 
> As I remarked in my ESP series cover letter, it is almost impossible for 
> someone to perform a comprehensive review without being very familiar 
> with the controller and its datasheet, so when attempting to review the 
> series, I would probably focus on looking how it compares with the 
> existing lsi53c895a code which is mature and working well. For me this 
> would mean that adding notes explaining any unusual differences between 
> the two devices on the commit message would be extremely helpful during 
> review.
> 
> You mentioned above the problem with implementing new helpers causing 
> boot to break between patches 5 and 8: is it possible to bring in the 
> new logic/helpers a phase at a time (like I did with ESP) to help keep 
> things working? Perhaps a temporary lock to enable the async helpers to 
> work in a sync manner temporarily could also help?
> 
> 
> ATB,
> 
> Mark.


