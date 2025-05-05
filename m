Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uByNM-0004e8-Cq; Mon, 05 May 2025 12:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uByMt-0004Vt-W1; Mon, 05 May 2025 12:08:38 -0400
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uByMp-0005Sp-3z; Mon, 05 May 2025 12:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1746461282; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Sa1AHpNozxVqWgAjltW6qxp7lBlPeZRnKiuBAY8gAlS03u/etuH+Ri85yMxbJH6EsbfXHVrLHF3Fds6ACQC7dQc4b2BlhxZ6SxLN+I6+EoSWvAFwqeP5QXhkIiRtG31+GXyoDxnNgA+d4mUHdwcVYtQ38kHz7ECZIGadQeZLizc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1746461282;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MRu4koP0AbX4A/Br7S0YZFP5LEHT/gY/8jVoiSA73y4=; 
 b=fRwVyQX95iUeJIin9vW3kiFFvL32CLJ40r05wgXV2NqBQQ1fN+85lHBTKggQPnuTa6OwthQHl7/LfYc+RzrdAgBufSTsowh2w0myoHbWgppPOV227xZL0jvjVHxX64LHYkpFndQ0qyEXXEhONeHkAdSN8Laf1dIlh3L8m/GURqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746461282; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MRu4koP0AbX4A/Br7S0YZFP5LEHT/gY/8jVoiSA73y4=;
 b=Nif/Sp1ambmfvvmKirH5g1CoshiHECwOFpDvsQ7XxHVc3OR/9rDrGuRp8CzU3aQA
 d83ssG8OFVwUWitPeAcd9QHGCDN3vDbJOmwwraPjnKectIkXFjOJf4PWyVdyUru0rol
 21om7TSPt8S1uL+sPtPBJKLNeVvcHG+1YM/u+iEU=
Received: by mx.zohomail.com with SMTPS id 1746461280721249.7034648286616;
 Mon, 5 May 2025 09:08:00 -0700 (PDT)
Message-ID: <2e72ddae-2198-41ca-a31f-aab583ea4be7@collabora.com>
Date: Mon, 5 May 2025 19:07:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-7-alex.bennee@linaro.org>
 <9115fa7c-ed94-449d-816b-a13125275dac@collabora.com>
 <cdc4d710-2b7a-44fc-b58c-78a81ca83b36@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <cdc4d710-2b7a-44fc-b58c-78a81ca83b36@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/4/25 10:20, Akihiko Odaki wrote:
> On 2025/04/30 3:56, Dmitry Osipenko wrote:
>> On 4/28/25 15:59, Alex BennÃ©e wrote:
>>> Seeing as I've taken a few patches to here now I might as well put
>>> myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
>>> it's not my core focus. If someone with more GPU experience comes
>>> forward we can always update again.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   MAINTAINERS | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 661a47db5a..f67c8edcf6 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2636,7 +2636,8 @@ F: hw/display/ramfb*.c
>>>   F: include/hw/display/ramfb.h
>>>     virtio-gpu
>>> -S: Orphan
>>> +M: Alex Bennée <alex.bennee@linaro.org>
>>> +M: Odd Fixes
>>>   F: hw/display/virtio-gpu*
>>>   F: hw/display/virtio-vga.*
>>>   F: include/hw/virtio/virtio-gpu.h
>>
>> Thanks a lot for stepping up!
>>
>> This reminded me that I wanted to propose myself as reviewer for the
>> virtio-gpu patches. Will do it soon.
> 
> Thank both of you for stepping up.
> 
>>
>> Akihiko Odaki is also good at reviewing virtio-gpu patches. Wondering if
>> Akihiko would want to be added as reviewer or co-maintainer of virtio-
>> gpu?
>>
> 
> Yes, please add me as a reviewer.
> 
> I guess it would be better if Alex add you and me with the next version
> of this patch or add follow-up patches to this to avoid change conflicts.

+1 Feel free to add us as reviewers in v2 of this patch. Otherwise I'll
send the separate maintainers-update patch along with nctx v12 patches.

-- 
Best regards,
Dmitry

