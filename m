Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9A606A328
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=Fx21mzAT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0O-0000LP-NB; Fri, 23 Oct 2026 12:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xKI01-0008IR-LK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xKHzy-0002ia-Sv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so670733f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1792772403; x=1793377203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/qmhc/4/Izc8apkJZ4pid8E2TMFU1/dQoi5WwtxVSjY=;
 b=Fx21mzATrAM0kXhw0w7wj9QvGmQoRjFGeEj3T1JFA6cxkjwyndoZPloo/ye1zKK/bY
 z8lKeriaSYNcOn7Ur8vdYfq5tTVAjbODnEiUW2DCubP60z6o9OCsYiLLyUFrPWfvFPp0
 osAReEPkLEPsUJTtLilGwPH/Zi3BOcTWYmzyRRdyR685DcoCtKXxv9J8t5u2MPqEHWSU
 WUW9W+oYTcFa2v6KKpg5qqK6r+t1njnQaqkNCmkvJGo+GVfoAZP189KVR9YCk+i1PCa+
 IOEdgzuzRZc5wTsyXwoO8mXUcqqOa+utORocc1xUPhCNE4E87TTj3BI1y8SsB/ftJznk
 Xs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772403; x=1793377203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/qmhc/4/Izc8apkJZ4pid8E2TMFU1/dQoi5WwtxVSjY=;
 b=14NPKH/MlGWUWdw1Cd+HEnSBx+rGBvlgTSBFy/CBHZQkm8dboluG5hfNXXd8ya/CP9
 Ozn9rqgGgwcgt5GNd0/fVqKfI25qT1ybKqlHEGR0TEHNHS0WwvnIPRS1PGSkurnKkH7J
 AA8p70AATGxoyvCxYTCTVnu63SdAW1x7/RLp5rD8MbdQPLFfor86GpCeZLZl1A/HuePC
 GUJKxH8Qh7O5svo8DYJOd7waOjnDaXnsPlBLpTfalgW3lMB9JKJNFaowLSn+mS16fPqL
 cKhmIrRQazhznJl02h2gekVsB+CnEKZkllM4n2vK+ccykgcNCkXrqgAHaybB6603Up5Q
 IfeQ==
X-Gm-Message-State: AFq9FYK1XKhh11t42//l5MkxwVOalB4V5Q/fvkUOJRHjR0WH9zgFR2ib
 wZOOmmsu7AtQcRAPczG7/TW445/j519zmu73VRQwFXKxY2lQT6xxts3GFqRJjKsQbsNafgvXieL
 lallE
X-Gm-Gg: AYBFou2KwdATu9BwwrHDNsc5MBLfhap2DnHuJxbXP9gBJvQLiAi08irotWhwsicHU8Z
 MLE7YooRt1kHLR4gE6eem5sh12RUDKuodxBk/RFOSyCVoTm3mOfzpOykV1pbsRWDRkvtke7+Frv
 svxstIrmHtktIF190H3K1TWrP5dultyFHgAJcRCcV/rN3dls8urUpq2fjjjvA598bnqdnunM+sp
 n9XYnRdCEemzGwGiFet1HDwsKUcZAxPyEqGRTuYLiKFu1ydniOitvVSZMnMYOwBsctF9DPFBago
 c2uwcIr8XR7vR1y8kxFoajEQHqVv/2RIv7zAFHHt8j0raNA7ItpkST2Nt3NbExr746dOmd+XqOY
 rrj3hctj/thsKxtm4zVsxI+MSzNy/JQocmj8UpkpYt/Okpu6kd0xhAzTvV4mplWD8sbf+r/fK+R
 lSBA6PvxhyYMIR8rIafUcEE855AYkhqLcpYcsVhBYjCIhnJLQ5WQOrIugY+21RnAXx89hvP2xy+
 8Bole6D5v/t+Tt/5pAoBbpJWfXSeAhROgG+J7G2efTs4NXUC5af
X-Received: by 2002:a05:6000:144c:b0:48c:7143:610c with SMTP id
 ffacd0b85a97d-48e3859a407mr4205863f8f.36.1792772403157; 
 Fri, 23 Oct 2026 09:20:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a960:ee49:ec13:ac39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d417e6dsm720356f8f.44.2026.10.23.09.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:20:02 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/1] virtio-scsi: fix hot-plug event racing device realize
Date: Fri, 23 Oct 2026 18:19:58 +0200
Message-ID: <20261023162000.2796947-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=den@openvz.org; helo=mail-wr1-x42d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A disk or CD-ROM hot-plugged into virtio-scsi sometimes never shows up
in the guest. QEMU has the device, the guest has consumed the RESCAN
event, and a manual bus rescan finds the LUN at once. We see this in CI
with Windows Server guests (vioscsi) and with Linux guests, always with
the controller on an iothread.

The event is pushed from the plug() callback, before the device is
realized, and the iothread request path does not see unrealized devices
since 8ddf958e8d62. A guest that scans right away gets BAD_TARGET and
does not retry. The patch moves the event to a main-loop bottom half.
The alternative, letting the request path see a plugged but unrealized
device, would undo what 8ddf958e8d62 protects against.

There is no test in the patch. The window lies inside a single
device_add under the BQL, and a qtest or iotests client is served by the
same main loop, so it cannot send a request in between. To reproduce, I
booted a Linux guest with virtio-scsi on an iothread, ran QEMU under gdb
in non-stop mode and stalled the main thread for 3 s in
scsi_bus_set_ua(), right after the event is pushed, then hot-plugged a
scsi-cd:

  break scsi_bus_set_ua
  commands
    call (int)usleep(3000000)
    continue
  end

Without the patch the guest never enumerated the LUN (3 of 3 runs).
With the patch the same stall falls after realize and the LUN appeared
every time (3 of 3). Without the stall both builds pass, which is why
this only shows up on loaded hosts. tests/qtest virtio-scsi passes.

Every release since 5.2 has the bug, hence qemu-stable.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Denis V. Lunev (1):
  virtio-scsi: fix hot-plug event racing device realize

 hw/scsi/virtio-scsi.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)


base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
-- 
2.53.0


