Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B5EB7ED7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 12:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxktq-0001na-SC; Wed, 04 Mar 2026 07:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxktm-0001n8-Mc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:00:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxktk-0003q8-St
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:00:18 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B615C596D97;
 Wed, 04 Mar 2026 13:00:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ToSyoKNsUyJT; Wed,  4 Mar 2026 13:00:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 55507596D95; Wed, 04 Mar 2026 13:00:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 539F7596DA1;
 Wed, 04 Mar 2026 13:00:12 +0100 (CET)
Date: Wed, 4 Mar 2026 13:00:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, devel@daynix.com, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 3/6] coreaudio: Improve naming
In-Reply-To: <3933555.kQq0lBPeGt@weasel>
Message-ID: <e804942b-cc4f-a0d9-0894-aaac890d08b7@eik.bme.hu>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-3-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <3933555.kQq0lBPeGt@weasel>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1916004963-1772625612=:5388"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1916004963-1772625612=:5388
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 4 Mar 2026, Christian Schoenebeck wrote:
> On Wednesday, 4 March 2026 07:16:56 CET Akihiko Odaki wrote:
>> coreaudio had names that are not conforming to QEMU codding style.
>
> coding
>
>> coreaudioVoiceOut also had some members that are prefixed with redundant
>> words like "output" or "audio".
>> Global names included "out" to tell they are specific to output devices,
>> but this rule was not completely enforced.
>> The frame size had three different names "frameSize", "bufferFrameSize",
>> and "frameCount".
>>
>> Replace identifiers to fix these problems.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>  audio/coreaudio.m | 188
>> +++++++++++++++++++++++++++--------------------------- 1 file changed, 95
>> insertions(+), 93 deletions(-)
>>
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index bc9ab7477b68..736227eb2b7a 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -43,34 +43,34 @@
>>  typedef struct coreaudioVoiceOut {
>
> Leaving this lower case?

I think you can just drop it if you never refer to the type with struct 
only as the CoreaudioVoiceOut typedef.

Regards,
BALATON Zoltan
--3866299591-1916004963-1772625612=:5388--

