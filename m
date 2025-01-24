Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC7BC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGAK-0004xI-4Y; Fri, 24 Jan 2025 04:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tbGAI-0004wr-7Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:39:50 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tbGAG-00034s-9k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=3gXulzKvx3RyBE3nox0FGbRlHJdAXgiBRZbCLOJ8qO0=; b=BrJO91ibcCoTUm+rvWGIGpqa3q
 93CawyI9nvDmdYrjtX7VjwG3aaKO/AqLk1bvIhX69YYt3w/Gd9IkNJ/UhVJLYPN+yzeBiCjYU78Fu
 HRfBGcLeombphloVIrDVjnnVI9nI+tJbUauw9o82PYxmDKUHTrz/OGMyVGB1YYaILbEISmGl0uSuo
 rmmBteriTMYo9o/Rerb+wS+/XpwLrrOGJzgU2eyJ44j0tTY0znqI2dFxk8i20fqZ9FKWSnRM7stPN
 XI63EMEAFNawq8pTGMKqJjGedthF49bME6QNC2CUZhLgiePUEy8FO4QeLMLdDZTDRpKMm660vINca
 flhz7y0KAU+tM8CceNOpyAvv4HEyNrnaz7qriBGbJ7z+g72OlJXGnXg2MYKm1L8qHmD94xF98EUDV
 wvsHT/JvT1zFvJZhzIGsfrgOx3wYUjPBGkcDKxI7HSaa5ZPmdhOHYPTwsqEbhr9+lMQOFTc89UMfT
 iPSXat4N4WncR2Yxta+ficjq274Fnfdf/begA/bVpts9XjvFAWCW9zsIU9YZXG0ySgch0RkKNoQ6i
 1S34mSo1dauKKrTRZCApozVf4EGimlPjh4V7D5nWI+dTdNwbX+L/T7Fz/8VI520AjhTK1EUsDIVfL
 CYxl5dostNzvO0o+G+ov89wg9+ju95btcHPXkDm58=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v7 1/6] coreaudio: Remove unnecessary explicit casts
Date: Fri, 24 Jan 2025 10:39:40 +0100
Message-ID: <4562400.zP1BOZzIia@silver>
In-Reply-To: <20250124-coreaudio-v7-1-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
 <20250124-coreaudio-v7-1-9d9a4d91db37@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, January 24, 2025 6:12:04 AM CET Akihiko Odaki wrote:
> coreaudio had unnecessary explicit casts and they had extra whitespaces
> around them so remove them.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  audio/coreaudio.m | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index cadd729d50537850d81718b9284efed5877d9185..0b67347ad7e8c43a77af308a1a3a654dd7084083 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -309,7 +309,7 @@ static OSStatus audioDeviceIOProc(
>      UInt32 frameCount, pending_frames;
>      void *out = outOutputData->mBuffers[0].mData;
>      HWVoiceOut *hw = hwptr;
> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
> +    coreaudioVoiceOut *core = hwptr;

Well, hwptr is void*, so both versions are fine.

struct name 'coreaudioVoiceOut' should start with upper case BTW.

>      size_t len;
>  
>      if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
> @@ -392,10 +392,10 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>      }
>  
>      if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
>          dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>      } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
>          dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>      } else {
>          core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;

Those casts are actually necessary, as AudioValueRange's members are Float64
(a.k.a. double) types.

/Christian



