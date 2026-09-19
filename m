Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F69C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qqw-0005Ak-Kw; Sat, 19 Sep 2026 04:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0005AT-EI
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:21 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqo-0007HC-M9
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:21 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso19364445e9.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808112; x=1790412912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sVIDxMipN7YpL2oyYDQlS7+ScjY2/jWoiD+NtutxMX0=;
 b=A11RrXKs6/2fCwuCUeKAYmCPZU/Nv4cUgncJuf4i6iDyiX8xJdGHNCoVbIdHB/MpHU
 430leIVeYQ7aBginl21ZyuThy4mT8c+MPwDBYiNsTiKMet5iuoXFTGJzWK6Lqd0vk8dH
 MtYdoI+yKQWwBqxhSzNNfk/nkzibmrZrMDZ21IDFPhSVRTZ0ibUrCwnpVlnOEpdf5I4l
 a+jL5bXCNrWPb5VxxAdhmIramqHcQ/toXYVegwJ24XVsu4bTw4ynUEGOhaoQZ6pKshwn
 S5I/eod/F1MJTe7Ch3ZLSBzGt05fmcxKYcRlJM5NlyBfGlf3wS5mYXmniDTDtfisfPgM
 rnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808112; x=1790412912;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sVIDxMipN7YpL2oyYDQlS7+ScjY2/jWoiD+NtutxMX0=;
 b=BclpCzfiFryNOHlnt6L01P3Hdtfl4TNcM6n3dyPQhEbyzwKGrxtsIWCn+SJ2jWuTTE
 d3BX9v2GBq6OvOfFlBpEQ9XLFYN2Kl/nMe2UolNxduJHyt3G8gvQv4JD1ocWgTF/bBPn
 hN84kDWnaanfuWl0E87WDleDyK0TsO2TdUhpYNgoTRRwsJ7wC4LMWfDogZibyVHop/tH
 Et2vZ/PLliShLs84I7tgJUMo6rlFLxLv0TJtemfkO2aE5xOvwPHJU8TQP7hlkaO4WJPu
 UhTuFpDWrQQ66qKKA8qcQqL6omNrdkm20/S2fVrMUD/OcstlikVreT05i/5XNPqr6WVr
 hT6Q==
X-Gm-Message-State: AFuF++k9JSgMZF5/SNQzbeYuOQjdGHyoUmm+KTP2OiarqfZVtwN2Mafp
 2CRQS3T2m4d6cgwJ6abbxstW7MLjUnPGvYD+UgRl8CnFE8i1GYByMQyGTAOWofUZYYMy6LCwCfH
 E67BA7qE=
X-Gm-Gg: AYBFou3B0jVN2uiRdF6LOfVU7lo2SRyWnEalxVV+cVF5MOLGIpIVE6f9JnELtCNDFat
 EmyNKh7sJNwxivshEUsMsEWUL/gN+uNapJa2NA7VTJyBl060i9Ul8FJOFNLdMFwEVvfTtY3dw0X
 wreHxrwJFIC9w6uJESEA+8NWqCFTW/mDOx6mWievo4ZgwkYmdE/E9kUm9IPxUPhwwiUwopwEu3l
 wBjV675OVEwXqpIS4QG3k8AbEnBvpa+10RslSdQOx1Tw3OpQ8nc6tJvlvGQPd73u2XNkwC9TUKz
 hKUducBC/X18L75VAk1aVzVAqBkPwaGEdOGwzbdajLzGy51nrzx9xihBHw8oQU3Oxzkef0F14gc
 PSUoCZttLCYifPT7Rsp65KAVQ9TGHpAc8qo2ztHpMwAWSLHEDwme4D5Fae2eUrlTSvlooFjEgGa
 MntIAHmkBHjZxssnv8u6CIkUhVe+93JXNU3tDaGoIm9Si/Q48eO01DfBTvRymNB/32GfFNRedrK
 ooSfYe0fPbwRFueeRG+HPLtHPBMLo41paaMvrDiQVoTT2QDtoF7Sx7W9taKev1clCWMhNevXy6L
 k3h0YrNyaIsfCzMTEY8BrZoi51B4pXldux85QTRC+gg82JazEQkdNeTn/2+6fHTgtOvNVrSeNtK
 /QoegZbP0LleNNwkr79tDnFpQXecXYOxPdQ==
X-Received: by 2002:a05:600c:a085:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fc5747887mr68834485e9.30.1789808112027; 
 Sat, 19 Sep 2026 01:55:12 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:11 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/10] virtio-sound migration
Date: Sat, 19 Sep 2026 11:54:47 +0300
Message-ID: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The following changes since commit 
b36ad6a0510aee81ecf6087b59f412b9bccaa369:

  hw/audio/virtio-sound: add missing vmstate fields (2026-09-18 10:20:20 +0300)

are available in the Git repository at:

  https://gitlab.com/epilys/qemu.git tags/virtio-snd-migrate-pr-v2

for you to fetch changes up to b36ad6a0510aee81ecf6087b59f412b9bccaa369:

  hw/audio/virtio-sound: add missing vmstate fields (2026-09-18 10:20:20 +0300)

----------------------------------------------------------------
virtio-snd-migrate-pr-v2

----------------------------------------------------------------

Alexander Mikhalitsyn (2):
  hw/audio/virtio-sound: remove channel positions field from
    VirtIOSoundPCMStream
  hw/audio/virtio-sound: drop unused struct
    VirtIOSoundPCMStream.flushing field

Volker Rümelin (8):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields

 include/hw/audio/virtio-snd.h |  26 +-
 hw/audio/virtio-snd.c         | 716 ++++++++++++++++++++--------------
 2 files changed, 424 insertions(+), 318 deletions(-)

-- 
γαῖα πυρί μιχθήτω


