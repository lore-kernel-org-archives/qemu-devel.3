Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FFDC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 10:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbdbG-000819-SB; Sat, 25 Jan 2025 05:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tbdbD-00080t-Uv
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 05:41:12 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tbdbC-0000mc-1B
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 05:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=MgB5KtFtlG64H6cZgJVdZsuaoUEIJKjAIaeCX1fJ6j0=; b=RRMDF22gb927p/mKs91NWZLZN7
 UNoUbIn51xWtFw9oDlb/4bUpgeiuz49aUGB7X5M+GfNn17Sty7rRA9iNSE+qIEMNijCD6uHd7B6Qh
 oGLQVxMyYYfef2kLCKI+4TgyJPIcU6FfnButnmCuODbRToG0gu6Ef1LNIEeMFoGGC1QZolJASCFbS
 b4hsrV5HgKyvAWrkZ+V70HPUVo3ON4460KW/oynCgAS2/SLbtM/QWT801n7NmICeXC8mByiv3vzOg
 W5Rp4RyOnPsAoOgsOj6qnfhDis3wXcRGGdv4pwOLBMrjzTjlOHXcRin7O9BJh7aF39IjsMFeqrZTF
 sTgYi0JZCqk7HCAQDW7BEJDTujRtibLh6cptqLEFTBgi4L0+fNdlmrCNdXvPaVvENpeJxvveVqp5F
 FSiRQMbffJ9nJgQ5rQiEcC23CaRoqh9UkBWkIXLc4x8KgVMPdwAs+mR1lbjvemfGC3E4GeqJFPz+q
 g4TIyfhEOT214pVDT97BGC6jV2chGuPZ2VDea2Ydj4zfemFDOHmi/Bpg4zpB0DcVL35/HLe0RgXXN
 2j0V/+YwmdlkUwZHGhSDO+l0RgjuMsubiIFLXqGO+YXGWmkoLsncHpiwd5DNcvEqKKJ+GOQFlRM3D
 72zjxNN8RbTTu6+/OwH7Lbaa9XWMtDGW7MjVjtJDk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v7 1/6] coreaudio: Remove unnecessary explicit casts
Date: Sat, 25 Jan 2025 11:41:00 +0100
Message-ID: <2917255.Mg30ljiku8@silver>
In-Reply-To: <b9116fa5-aafd-4dc8-8b31-86b079f1ad9c@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
 <4562400.zP1BOZzIia@silver>
 <b9116fa5-aafd-4dc8-8b31-86b079f1ad9c@daynix.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Saturday, January 25, 2025 6:58:30 AM CET Akihiko Odaki wrote:
> On 2025/01/24 18:39, Christian Schoenebeck wrote:
> > On Friday, January 24, 2025 6:12:04 AM CET Akihiko Odaki wrote:
> >> coreaudio had unnecessary explicit casts and they had extra whitespaces
> >> around them so remove them.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   audio/coreaudio.m | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> >> index cadd729d50537850d81718b9284efed5877d9185..0b67347ad7e8c43a77af308a1a3a654dd7084083 100644
> >> --- a/audio/coreaudio.m
> >> +++ b/audio/coreaudio.m
> >> @@ -309,7 +309,7 @@ static OSStatus audioDeviceIOProc(
> >>       UInt32 frameCount, pending_frames;
> >>       void *out = outOutputData->mBuffers[0].mData;
> >>       HWVoiceOut *hw = hwptr;
> >> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
> >> +    coreaudioVoiceOut *core = hwptr;
> > 
> > Well, hwptr is void*, so both versions are fine.
> > 
> > struct name 'coreaudioVoiceOut' should start with upper case BTW.
> > 
> >>       size_t len;
> >>   
> >>       if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
> >> @@ -392,10 +392,10 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
> >>       }
> >>   
> >>       if (frameRange.mMinimum > core->frameSizeSetting) {
> >> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> >> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
> >>           dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
> >>       } else if (frameRange.mMaximum < core->frameSizeSetting) {
> >> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> >> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
> >>           dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
> >>       } else {
> >>           core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> > 
> > Those casts are actually necessary, as AudioValueRange's members are Float64
> > (a.k.a. double) types.
> 
> Explicit casts are unnecessary. Implicit casts still happen at every 
> line changed with this patch.

Wooo, I wasn't aware that QEMU doesn't use -Wconversion. I am not used to 
that. To me it makes sense to warn especially for things like implicit casts
from floating point to integer, as it would be the case here.

/Christian



