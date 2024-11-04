Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D780D132C9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xTi-0000uS-0o; Mon, 04 Nov 2024 08:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7xTg-0000u3-UA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:50:44 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7xTe-0003yo-K2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:50:44 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 289E64E6010;
 Mon, 04 Nov 2024 14:50:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id WwPF66PyngO3; Mon,  4 Nov 2024 14:50:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2EC34E6000; Mon, 04 Nov 2024 14:50:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0870746F60;
 Mon, 04 Nov 2024 14:50:37 +0100 (CET)
Date: Mon, 4 Nov 2024 14:50:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Robert Beckett <bob.beckett@collabora.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui <ray.huang@amd.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
In-Reply-To: <87o72vdxtb.fsf@draig.linaro.org>
Message-ID: <a61d825c-6088-e324-ac20-a4d27ad55592@eik.bme.hu>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
 <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
 <87ldy2ho24.fsf@draig.linaro.org>
 <7b4c6712-ed37-4973-88ef-5ef5efdfa232@collabora.com>
 <87o72vdxtb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-53429874-1730728237=:86824"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-53429874-1730728237=:86824
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 4 Nov 2024, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>
>> On 11/1/24 20:16, Alex Bennée wrote:
>>> Also what is the subtlety behind using both stride and bytes_pp in the
>>> calculation. My naive thought would be:
>>>
>>>   fb.bytes_pp * ss.r.width == fb.stride
>>>
>>> Can anyone enlighten me?
>>
>> GPUs want image line size to be aligned to a power of 2 value, like 64
>> bytes for example. This aligned size of the line is called stride.
>>
>> GPU's DMA engine operates with a predefined granularity when it accesses
>> memory, it reads/writes memory chunks that are multiple of a stride.
>> GPUs almost never support memory accesses at a granularity of one byte,
>> like CPUs do it.
>
> Ok that seems worth covering in a comment. Also what is going on with:
>
>    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
>
> and then calculating fbend from offset + the calculation? Is this
> because we need 2 full frames of storage? Can that ever change?

Stride is commonly used for storing data describing 2D blocks such as 
bitmaps so maybe not comment worthy but could be mentioned if you think it 
makes it clearer. Here's some documentation with a figure that may answer 
some of your questions:

https://learn.microsoft.com/en-us/windows/win32/medfound/image-stride

(I don't know what this thread is about, just stumbled upon this message 
and thought this may help. If not then sorry for the noise.)

Regards,
BALATON Zoltan
--3866299591-53429874-1730728237=:86824--

