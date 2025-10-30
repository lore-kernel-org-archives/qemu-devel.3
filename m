Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61642CCF9EB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 00:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEGfa-0000nG-5n; Wed, 29 Oct 2025 20:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vEGfY-0000mt-DV; Wed, 29 Oct 2025 20:37:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vEGfQ-0003OD-0K; Wed, 29 Oct 2025 20:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DG4k2FLooCN0pqJoA/l3DEO33TCHVZYUXN3N1Rp186w=; b=Dl3yhBboT9eKB2C1FBQuYQ0EL3
 p6SwYH0aOX+S/F6mT5MDZy8WJeKhId1kgCDkHQ6Ekm8/SVh9nV8Wv9vDcyq+3022STHC79nEAQh3t
 S2cbyZoMySSdDKQNY+Z2Vt7RVhHyqO03CnCGZuT/r8OXIZWyBL4Qijnd8sCNki1Iinv+g7/Rb5P//
 e8I0dm+SM4YD7lUUYIY9x7S2n91+T5jjgPbj0W4mmCChQzUlaGZaQ9S+Ai9kFmIREcMRtBSnBEUvZ
 V5KgzWFDQxU+jKBc6HCZAxzXM0L9XkghmK3k14wtmdi1+/pZ2NXHhLmDN9spgPMTf2q9/6OYgE5t5
 WsgkZZ/REnmIwlSTK04RuRKJUE4SO+toGa4R3T2wjHG9WO9aQwD6FCBuuakTDT4RgwXsRYAcYXUcK
 iG7PxBKuLwA7xIBdhJHCSnJuM2O4PigW+5C04ZF+XV+MfOXcMDo3DABVEP3Ho4fyXhJPmIuBFZ50v
 m2LyUOKoi3GUheQdMZ7pJV4u3/srLObtkStLUDC3eLKknbKRbjUvTK7unUOei7fDGfkWmBac8fgmf
 w1gy2tp9M4UfG1SPUKc0nUOFbP3mwbplWibF9jfPxyMhjLecEwKZ0gc6BcYly9ivBqsEYMko+kZMH
 0szun0WA+LuZvzm0jAj4oW9m733BDsu8fTJSmw/z4=;
Received: from [2a02:8012:2f01:0:6dad:b13d:61b8:819c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vEGcp-0004dH-1i; Thu, 30 Oct 2025 00:34:50 +0000
Message-ID: <2dc5e0d6-2b98-49d6-99ef-8969d58a02ed@ilande.co.uk>
Date: Thu, 30 Oct 2025 00:36:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
 <cad75a33-ddc0-6fbc-c7e9-68e05877213c@eik.bme.hu>
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
In-Reply-To: <cad75a33-ddc0-6fbc-c7e9-68e05877213c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:6dad:b13d:61b8:819c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
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

On 29/10/2025 13:25, BALATON Zoltan wrote:

> On Wed, 29 Oct 2025, BALATON Zoltan wrote:
>> On Wed, 29 Oct 2025, Akihiko Odaki wrote:
>>> On 2025/10/29 6:28, BALATON Zoltan wrote:
>>>> On Wed, 29 Oct 2025, Akihiko Odaki wrote:
>>>>> On 2025/10/28 21:59, BALATON Zoltan wrote:
>>>>>> On Tue, 28 Oct 2025, Philippe Mathieu-Daudé wrote:
>>>>>>> On 27/10/25 20:47, BALATON Zoltan wrote:
>>>>>>>> On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
>>>>>>>>> On 25/10/25 01:31, BALATON Zoltan wrote:
>>>>>>>>>> These memory windows are a result of the address decoding in the
>>>>>>>>>> Articia S north bridge so better model it there and not in board code.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>>>>>> ---
>>>>>>>>>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>>>>>>>>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>>>>>>>>>   hw/ppc/pegasos2.c     | 13 -------------
>>>>>>>>>>   3 files changed, 19 insertions(+), 37 deletions(-)
>>>>>>>>>
> [...]
>> It looks like we won't be able to come to an agreement before the freeze and I 
>> don't have time now to change this patch but don't want to miss the release with 
>> this series that finishes pegasos renaming because of this. So for this patch I'd 
>> say since this is already how it is now and it does not make it worse and this 
>> object is not user creatable anyway so cannot leak please take it as it is and 
>> we'll do a clean up later after we finish discussion.
> 
> As for all of these files I'm the maintainer let me make an executive decision here 
> to keep this patch without Philippe's reviewed-by for now to be able to move on with 
> this series before the freeze. Fixing the theoretical leak can be done on top and 
> since that's a fix it can be done during soft freeze that would give us more time. So 
> Harsh please go ahead and merge this series too if there are no other concerns. I'll 
> then address this later together with other similar issues elsewhere.

I think the issue here is that several people have now raised concerns as to the way 
you are trying to use MemoryRegions (both here and in the raven series): simply put, 
if reviewers didn't see any problems with this approach, your series would already 
have review tags.

If you want to suggest a different approach to managing MemoryRegions, then I would 
suggest you send a proposal to the mailing list so it can be reviewed by the QOM and 
memory people (along with updated code style documentation so we can all use it). But 
with freeze coming up in a few days this is certainly out of scope for 10.2.

For now I would suggest the easiest way to get review tags is to stick with the 
existing inline MemoryRegion approach for 10.2 to aid getting your patches merged: 
it's simply not fair to put time pressure on Harsh to merge patches in this way.


ATB,

Mark.

