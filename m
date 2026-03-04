Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56409EB7EB1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhou-0002Jb-S5; Wed, 04 Mar 2026 03:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxhot-0002JR-Iq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:43:03 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxhor-0001OK-9R
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=OPcQzGIK7kK5QgRwxGhnPlNq4GA64GVvkzSWmqM5bfM=; b=cx1c6dNgccThN5w9LHq9LcA0h1
 4rjXQ6fKvcGK8pWLVQRdVtmGn/wD6TlgUQPEo8WniUhTrDqTJiPnTz7xTwX5DWF6jcAOikUqCq1zo
 BrjSVqa3H7vnGvL8lNYo6KdB5juF01u5PXPf0068Dn9cuZqqADuS+KiRvv2lvOxAWxWreNkEotJQg
 OV9oE4hIfY/MM8h3+AVm4jr7HC68Hl5rohlZ+yMHDRXEQMi2jMu1DY6HpbotBf02RCjNb1k/lBT2F
 BRoswx4QSLsaLu7fyVqjgttdobcblLaiLyEMlwx9nhtZMe7d/8Xo5+5pNrxWv19eAxhNOsE0yh1bw
 GQYP12FVvtysr4Mh8j3/iKb1gM7aJLJHUXrUxBzeuGMhbZHB88WGnrOY3p5TD89i1DCbQFhbp8nUC
 RLmnz9FUMhVjCcTtxK+wdlf0ICZ6t5LZQA5qRu/8BBHVa9ZbP6JRNT8zLbnLFSFzzHUg9jqwoWb6E
 2Elzz2ddTyoxFII62tNtrDomJFFNUuqSluWret4FhCSMUiBaRY0klQn9bqK4xHjnybotCK1GcRtWE
 eoi7CrsSddvmGrpIRGAURd+kGZAQEFcjmYrNpqISKjYWw+TU/62I8/04nVtqb7Jrz53coCb8pUThI
 uSxbsf5aUNOulC/dHXZCjR3JLHpPzr8q/PY4kxzh4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 0/6] coreaudio fixes
Date: Wed, 04 Mar 2026 09:42:54 +0100
Message-ID: <4717540.LvFx2qVVIh@weasel>
In-Reply-To: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wednesday, 4 March 2026 07:16:53 CET Akihiko Odaki wrote:
> This series contains two fixes for coreaudio. See each one for details.


Most of the patches in this series actually just do plain refactoring, which I
personally don't care for at all.

It would be therefore helpful to make it clear right from the patch commit log
whether a patch is just flipping names or really changing some behaviour.

/Christian


> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v8:
> - Rebased.
> - Link to v7:
> https://lore.kernel.org/qemu-devel/20250124-coreaudio-v7-0-9d9a4d91db37@day
> nix.com
> 
> Changes in v7:
> - Added patch "coreaudio: Remove extra whitespaces".
> - Link to v6:
> https://lore.kernel.org/qemu-devel/20250124-coreaudio-v6-0-11fbcb6c47cf@day
> nix.com
> 
> Changes in v6:
> - Added patch "coreaudio: Remove unnecessary explicit casts".
> - Link to v5:
> https://lore.kernel.org/qemu-devel/20250123-coreaudio-v5-0-6873df4215a0@day
> nix.com
> 
> Changes in v5:
> - Added patch "coreaudio: Improve naming", removing verbose names like
>   outputDeviceID and audioDevicePropertyBufferFrameSize altogether.
> - Link to v4:
> https://lore.kernel.org/r/20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com
> 
> Changes in v4:
> - Splitted patch "audio: Add functions to initialize buffers" from
>   patch "coreaudio: Initialize the buffer for device change".
> - Changed the message of patch "coreaudio: Commit the result of init in
>   the end" to tell that early returns happen when there is a fatal error
>   or the device gets unplugged.
> - Link to v3:
> https://lore.kernel.org/r/20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com
> 
> ---
> Akihiko Odaki (6):
>       coreaudio: Remove unnecessary explicit casts
>       coreaudio: Remove extra whitespaces
>       coreaudio: Improve naming
>       coreaudio: Commit the result of init in the end
>       audio: Add functions to initialize buffers
>       coreaudio: Initialize the buffer for device change
> 
>  audio/audio_int.h       |   2 +
>  audio/audio-mixeng-be.c |  24 ++++--
>  audio/coreaudio.m       | 206
> +++++++++++++++++++++++++----------------------- 3 files changed, 127
> insertions(+), 105 deletions(-)
> ---
> base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
> change-id: 20250109-coreaudio-c984607e1d8c
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>





