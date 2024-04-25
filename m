Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD32C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwS5-00085J-Vz; Thu, 25 Apr 2024 06:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rzwRw-00084N-Pv; Thu, 25 Apr 2024 06:35:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rzwRu-0006Sz-US; Thu, 25 Apr 2024 06:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3KaVcoed20peGvvN5OKLqfoyIej63lOoNGs60HnM+hs=; b=ULpbyymmLHQDWo64KonOltyTFQ
 zybOeNuyNqOUzHtA5X7TvJt3ovx75n3tbeN8YegHFn3cdoaNj7M7m+9+m2xT0cYi0uGcy+n7qoWQ3
 qCRE5KgQeXsgjIoABWP6Z0wy71sxPZdT01MyvtC+HKthQtvLaJ8Yudk+dTpggfm3gslHYeqM9t2SI
 IoiRWkSpx6c7lb1vdOEVSUIY5xB3Z2b4fCrFFyrrZrUt/RGJDYHE8oWEuW9nWIbAbXVfkSDRI56kb
 uipNF0nJrzIh6CDCOD5RNkvzshBwc6B9oWydUKTGwVhc9NoVIHiVOIHe/rP7ACzgqWgPSRowJYbNa
 UWKSJsdp23y31q6aFuTd67JdMg1Gd3Os8CAwvJN1bnPuxc2KNkwubWHWizMctRIxRJ+ekENoPU48S
 IfKdHztp0lDWxfsgeRNhCC3A/q0R4/iZIXhwWuLRSwF7E0KM+IHIE1DITxXPNXBl6iG5aWoA3DuqF
 MALI44cBvYoMIPaKJwRoseZM0jaX5wmxTh7JAYN8+/Si26zceC/GD3U/rhE8ZTGLYo9oRCIcmZeEW
 iMquFJDG+b9lWHsOLuba0mQtgy1XS1LCT4QbjLLYlv7PPdHbP4/zwlm5aXc4TNT8CJBqa31s+kJpP
 eFdeeGYaOyrua35iYZmFO6ixsFbZCaTsXMTW752Mk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rzwQn-0004qD-M2; Thu, 25 Apr 2024 11:34:25 +0100
Message-ID: <7cf079c4-5549-4e62-9387-34ffb7430f7a@ilande.co.uk>
Date: Thu, 25 Apr 2024 11:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
 <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
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
In-Reply-To: <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
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

On 25/04/2024 11:04, Manos Pitsidianakis wrote:

> On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 25/04/2024 07:30, Manos Pitsidianakis wrote:
>>
>>> On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>
>>>> On 23/04/2024 12:05, Philippe Mathieu-Daudé wrote:
>>>>
>>>>> On 23/4/24 11:18, Manos Pitsidianakis wrote:
>>>>>> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
>>>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>>>
>>>>>>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
>>>>>>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>>>>>>> Since VirtIO devices can change endianness at runtime,
>>>>>>>>>>> we need to use the device endianness, not the target
>>>>>>>>>>> one.
>>>>>>>>>>>
>>>>>>>>>>> Cc: qemu-stable@nongnu.org
>>>>>>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>>>>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 only.
>>>>>>>>>> It is unconditionally little endian.
>>>>>>>
>>>>>>>
>>>>>>> This part of the code is for PCM frames (raw bytes), not virtio spec
>>>>>>> fields (which indeed must be LE in modern VIRTIO).
>>>>>>
>>>>>> Thought a little more about it. We should keep the target's endianness
>>>>>> here, if it's mutable then we should query the machine the device is
>>>>>> attached to somehow. the virtio device should never change endianness
>>>>>> like Michael says since it's not legacy.
>>>>>
>>>>> Grr. So as Richard suggested, this need to be pass as a device
>>>>> property then.
>>>>> (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org/)
>>>>
>>>> It feels to me that the endianness is something that should be negotiated as part of
>>>> the frame format, since the endianness of the audio hardware can be different from
>>>> that of the CPU (think PReP machines where it was common that a big endian CPU is
>>>> driving little endian hardware as found on x86).
>>>
>>> But that is the job of the hardware drivers, isn't it? Here we are
>>> taking frames passed from the guest to its virtio driver in the format
>>> specified in the target cpu's endianness and QEMU as the device passes
>>> it to host ALSA/Pipewire/etc which in turn passes it to the actual
>>> audio hardware driver..
>>
>> The problem is that the notion of target CPU endian is not fixed. For example the
>> PowerPC CPU starts off in big-endian mode, but these days most systems will switch
>> the CPU to little-endian mode on startup to run ppc64le. There's also the ILE bit
>> which can be configured so that a big-endian PowerPC CPU can dynamically switch to
>> little-endian mode when processing an interrupt, so you could potentially end up with
>> either depending upon the current mode of the CPU.
>>
>> These are the kinds of issues that led to the later virtio specifications simply
>> using little-endian for everything, since then there is zero ambiguity over what
>> endian is required for the virtio configuration space accesses.
>>
>> It feels to me that assuming a target CPU endian is fixed for the PCM frame formats
>> is simply repeating the mistakes of the past - and even the fact that we are
>> discussing this within this thread suggests that at a very minimum the virtio-snd
>> specification needs to be updated to clarify the byte ordering of the PCM frame formats.
>
> Agreed, I think we are saying approximately the same thing here.
> 
>   We need a mechanism to retrieve the vCPUs endianness and a way to
> notify subscribed devices when it changes.
> 
>   I think that then, since the virtio device is mostly certain of the
> correct target endianness and completely certain of the host
> endianness, it can perform the necessary conversions.
> 
>   I don't recall seeing a restriction on the byte ordering of PCM
> formats other than the CPU order; except for the ones which have
> explicit endianness in their definitions. Please correct me if I am
> wrong!
> 
> A straightforward solution would be to set an endianness change notify
> callback in DeviceClass. What do you think?

Well, I guess... but why propose such a complex solution when you can simply specify 
the endianness of the PCM frame? If you think back to pre-1.0 virtio where everything 
was done using target vCPU endianness, why did they not implement this solution back 
then to solve the problem instead of mandating that virtio-1.0 onwards should simply 
use little-endian? Clearly specifying that all implementations should use 
little-endian was the deemed to be the best way to solve all these issues.

Have you raised this issue on the virtio-dev mailing list? It's worth explaining the 
problem you're trying to solve there, since hopefully the person or persons who 
designed and proposed the virtio-snd specification will be able to give you the 
correct advice.


ATB,

Mark.


