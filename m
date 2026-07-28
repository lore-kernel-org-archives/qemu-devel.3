Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B218C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobQb-0002Vg-4C; Tue, 28 Jul 2026 02:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobQS-0002V4-Eo; Tue, 28 Jul 2026 02:36:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobQQ-0000Rn-1C; Tue, 28 Jul 2026 02:36:28 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6aG7O018226
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 15:36:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fRFurx2Z5LH+Pawe210q9Bfgc2WoDLeYhKOrZvSx05E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785220577; v=1;
 b=UM5ZSzmQ+nRYPHP33z1pL3dnQAWSoqtWzbaZJcj3Zt9DqQp7KHEmBJoIIF6T1g+R
 e19yvVJ+qaDYqDVTLRLDdjB23xU9EWjVX8JrCXM02Adv4MNPcMuXz6nGtDe5FPLD
 k0gDNtETdpqhqMyMaWKXcmRqi7NSRQiBzeN/8uU40WRaTu1J7DfmBn9AnE0JGig3
 xNNVhalhJzN4BP8TDWKnwf30PGkE00OrAp0O45rkXYA/cdGS8tIrFmf7kwgxvD5x
 fmFIAHySmHMuxGEZMTFFgXc2rTsIuJSeKewyjo+s65qtjg1OyngkNcLTMei+cRC9
 u00hJqhUFxOwkChVHxzZQA==
Message-ID: <83c6851e-480b-4a4d-baab-943b1d6d38ed@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:36:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Remove the bytes_pp field
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-stable@nongnu.org
References: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
 <67e4bd46-447d-4ed1-8e51-8583a46e8d8e@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <67e4bd46-447d-4ed1-8e51-8583a46e8d8e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/07/28 6:17, Michael Tokarev wrote:
> On 7/19/26 14:35, Akihiko Odaki wrote:
>> virtio_gpu_do_set_scanout() validates the stride field of struct
>> virtio_gpu_framebuffer against the bytes_pp field, but bytes_pp in the
>> migration stream may be inconsistent with the format field, which
>> pixman_image_create_bits() uses when it accesses the framebuffer.
>> That validation is therefore incomplete.
>>
>> To avoid the trouble of synchronizing the two fields, remove bytes_pp,
>> and always derive its value from format. Removing bytes_pp is safe
>> because no released version of QEMU uses its migrated value.
>>
>> Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>> Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
>> ("[PATCH] hw/display/virtio-gpu: validate stride against width on 
>> scanout")
>> ---
>>   include/hw/virtio/virtio-gpu.h |  1 -
>>   hw/display/virtio-gpu.c        | 27 +++++++++++++++++----------
>>   2 files changed, 17 insertions(+), 11 deletions(-)
> ...
>> @@ -1219,8 +1227,7 @@ static const VMStateDescription 
>> vmstate_virtio_gpu_scanout = {
>>           VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
>>           VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
>>                               scanout_vmstate_after_v2),
>> -        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
>> -                            scanout_vmstate_after_v2),
>> +        VMSTATE_UNUSED_TEST(scanout_vmstate_after_v2, 4),
> 
> Can we send this field when doing migration to an older version?
> When doing migration from older to current (with this patch), this
> field is being ignored, which is ok.  But not setting this field
> on migration in reverse direction means the older version wont work.

Removing bytes_pp is safe because no released version of QEMU uses its 
migrated value, as the commit message notes.

Regards,
Akihiko Odaki

