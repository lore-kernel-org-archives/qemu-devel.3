Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3F8C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkSV-0000Kx-DH; Fri, 02 Aug 2024 01:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sZkST-0000JM-0q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:04:05 -0400
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sZkSQ-0000WY-HV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:04:04 -0400
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
 by mailout11.t-online.de (Postfix) with SMTP id 7F69B215CF;
 Fri,  2 Aug 2024 07:03:57 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.28.154]) by fwd87.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1sZkSL-0nREAb0; Fri, 2 Aug 2024 07:03:57 +0200
Message-ID: <79f6f143-0dda-4630-89ea-8d3a8ca4dba3@t-online.de>
Date: Fri, 2 Aug 2024 07:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 17/61] virtio-snd: check for invalid param shift operands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <cover.1721731723.git.mst@redhat.com>
 <9b6083465fb8311f2410615f8303a41f580a2a20.1721731723.git.mst@redhat.com>
 <21a0899b-cff5-49da-bda5-f53e12cca234@t-online.de>
 <20240801042204-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20240801042204-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1722575037-DBFEB20D-F38A618F/0/0 CLEAN NORMAL
X-TOI-MSGID: fad0e566-2d0b-45e3-8c2f-5dae0116f71b
Received-SPF: pass client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 01.08.24 um 10:22 schrieb Michael S. Tsirkin:
> On Sat, Jul 27, 2024 at 08:55:10AM +0200, Volker Rümelin wrote:
>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>
>>> When setting the parameters of a PCM stream, we compute the bit flag
>>> with the format and rate values as shift operand to check if they are
>>> set in supported_formats and supported_rates.
>>>
>>> If the guest provides a format/rate value which when shifting 1 results
>>> in a value bigger than the number of bits in
>>> supported_formats/supported_rates, we must report an error.
>>>
>>> Previously, this ended up triggering the not reached assertions later
>>> when converting to internal QEMU values.
>>>
>>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2416
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Message-Id: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  hw/audio/virtio-snd.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>>> index e6432ac959..e5196aa4bb 100644
>>> --- a/hw/audio/virtio-snd.c
>>> +++ b/hw/audio/virtio-snd.c
>>> @@ -282,11 +282,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>>>          error_report("Number of channels is not supported.");
>>>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>>>      }
>>> -    if (!(supported_formats & BIT(params->format))) {
>> Hi Manos,
>>
>> this patch doesn't work as intended. I guess you wanted to write
>>
>>     if (params->format >= sizeof(supported_formats) * BITS_PER_BYTE ||
>>         !(supported_formats & BIT(params->format))) {
>>
>>> +    if (BIT(params->format) > sizeof(supported_formats) ||
>>> +        !(supported_formats & BIT(params->format))) {
>>>          error_report("Stream format is not supported.");
>>>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>>>      }
>>> -    if (!(supported_rates & BIT(params->rate))) {
>>     if (params->rate >= sizeof(supported_rates) * BITS_PER_BYTE ||
>>         !(supported_rates & BIT(params->rate))) {
>>
>> With best regards,
>> Volker
>
> Any response here? Should I revert?

No response so far. It's not necessary to revert. I'll send a patch.

With best regards,
Volker

>>> +    if (BIT(params->rate) > sizeof(supported_rates) ||
>>> +        !(supported_rates & BIT(params->rate))) {
>>>          error_report("Stream rate is not supported.");
>>>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>>>      }


