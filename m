Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1CBD5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBsj-0006Qm-Kh; Mon, 15 Dec 2025 11:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vVBsh-0006QX-0G
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:57:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vVBse-0003IQ-Qj
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:57:06 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29efd139227so45020655ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 08:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765817823; x=1766422623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2D/M9pS4tQzD+gT2u2FtxZqrTAXQBgjnmRFagEtchos=;
 b=RqSzS7saCoOpYmWpAayzDsDkNz0Kt97fuC0JeBNQX73LXxaKrVGTU3LRHhs/VMpEt+
 IK2S4MD5mZXnnXpFxjKYiF5mt7Asaaj1HLmA93P2NyIs5qQsS/+3DZLfrZKf9TYSQaup
 3IQII53udqxWqChC6RSq78PHXT0V2AQQrop7BgOr2Qr37vKqenripCCcyPsO+mItqxpm
 5ITyI4psOcX+uoiyLNHCmesz2ICR85DE6XXIITJh1Sz75l/aBx8dvIPyQwbvVvnayrkF
 1znPAjgPtw1m1lDNFJoDjRXTvdMAnSL3rklmCQ9wW7nTVGFeDXuGIO7sqtJS+eBVvD70
 mwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765817823; x=1766422623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D/M9pS4tQzD+gT2u2FtxZqrTAXQBgjnmRFagEtchos=;
 b=socH/22Ocl351rQlEi+9zfZMyDxuBraDAvsB4CDHVF9tZfNFaLg1SV0aeAVhf+VxOZ
 8Wp8d41Q7B3YbZFSMN1GKbxE1wQMrvPLZl44bnd+icsmqJq8HV63NCCMtURARLPIFyZN
 A8QkPPqS+QFR3bRzpG3Fo6RXkl3JNaMOduY+KFUpcMD8sxfBTgRFW/QZcdzpxdgRtbQE
 iGgbDoEDY/VGglV9TCBfz7syzq2KY2tEtelmrmtzqn9sVZul0V/TMDa32rUqbuIlvH/y
 scC7bQ7ZmgV77N/w2NGsaTxi+zfhbu2omGp6E1acGicBVBoH7XBDQFWElqyID2iLT8+t
 cynw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk8XnefTyyhPFl35PtQxnCnMEjAGqw5ZhMuNtLOSC5EbQy8Y4mrKZW4JvrZRy12pzTucJ7tFo57zDo@nongnu.org
X-Gm-Message-State: AOJu0YxBPyPsDFZCdHz4XSs7OmDyQysve5zAIfgFXYdL3csAP6BioNA3
 ccsOXYFA0Qt+vdqptIKxBUUbDp7GwkWdoi0f2eW5OmSqeGGmuxvfQLqv
X-Gm-Gg: AY/fxX4Cb4W7iHYS1pTUOKUJOKsvnwuFMd0fmrKGxdoo5RZM9FEoJyQ+a9lxm8C9qeI
 kG4GWUzGOoz3ll+5Q4qx0vBvFhwQFvB/7/eAasfOG7k1VwSJqMVqqllmPbkXI4R09p+6YfuzqZ/
 Ll9UKYI689MHyaplVzCg/VeTQXNl8xu35QA+5ond1I808GZidawZdOGKk/TnOYgsbOqkAPvdfJr
 4M1X7mNpSDopb/08CeQwSRBHfrPgI6qogok6G5oWlIRg0ywDtyUHuzfz7MsWUST1bz/5a9OLa16
 FcaxF5T1Crgo8cf/Wgry8KTev9DBMA3dtYHtW1iBft5L8u085Upf6sdTE09IIZELFNVxsI00qlW
 il329M0oV4og6La/Xt1285mwG9izqPhonlDdI9JU86AI/1/ZBZHRUA0W9Db8NKbFO6BJfyhSgxp
 A6vGFzTGtMkBN5AacQPSTZMb4=
X-Google-Smtp-Source: AGHT+IEG7fFsd6FuD4aqNqTPCuKt4+9h6ymiCV6U1oEYyGEDrSJbTbN0Y1t26g09rRuCDdM99fyDdw==
X-Received: by 2002:a17:903:1b4c:b0:29e:9e97:ca70 with SMTP id
 d9443c01a7336-29f23b93498mr128236885ad.25.1765817822793; 
 Mon, 15 Dec 2025 08:57:02 -0800 (PST)
Received: from localhost.localdomain ([116.86.160.247])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38c74sm140084775ad.31.2025.12.15.08.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:57:02 -0800 (PST)
From: phind.uet@gmail.com
To: Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@linaro.org,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix Windows build issues with newer MinGW
Date: Tue, 16 Dec 2025 00:45:10 +0800
Message-ID: <20251215164512.322786-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

This series fixes build issues when compiling QEMU on Windows with
newer MinGW-w64 toolchains.

Patch 1 addresses a redefinition error for ConvertStringToBSTR(),
which is now provided by newer MinGW versions in <comutil.h>.

Patch 2 relocates qemu_ftruncate64() to a more appropriate location.

Nguyen Dinh Phi (2):
  qga/vss-win32: Fix ConvertStringToBSTR redefinition with newer MinGW
  util: Move qemu_ftruncate64 from block/file-win32.c to oslib-win32.c

 block/file-win32.c        | 32 --------------------------------
 meson.build               | 12 ++++++++++++
 qga/vss-win32/install.cpp |  2 ++
 util/oslib-win32.c        | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 32 deletions(-)

-- 
2.43.0


