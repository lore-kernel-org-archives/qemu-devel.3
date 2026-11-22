Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C6606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EEcykg63
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAlq-00020h-5q; Sun, 22 Nov 2026 11:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlH-0001ov-Jv
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:56 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl4-0001Wd-OW
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:43 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6bab10844b5so366814a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366181; x=1795970981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SjCBFXPEPa2n7DTqPPWuC0cHPQc8UHQfnWzummTxEAM=;
 b=EEcykg63mSDhGKEeaVX5G3zvk1UsmnmlcoJE1jy8b5o5NySQnljeu3PqEv/U7i2biD
 Hrg0iNnKE3V8ldOtvepzAJy8pICcaz9zJnGmIRBSEXLPD/mQyM+7vO/SFwgzq/afF/J7
 3G/SokH4qzTE5Unab2+EZM3y3Gfzo+TQcU+M32uS6yaNZr122krvSQeGyOrTBe32Zsc2
 u+hnwREDdh7133lg1m6btrkk4KhKU3Epkhb5zjoNFW4TqtQMk7a5A0gaJULU+J7fspyh
 Mu26obvBeGvMqnC5BKuO3ZkAZUCZd7IltiLNbOALCTbxByK1uFp/VsEQrzbXsIxYYZwB
 /CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366181; x=1795970981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SjCBFXPEPa2n7DTqPPWuC0cHPQc8UHQfnWzummTxEAM=;
 b=mlleH+Q0xh+25NPPfbCXFSahFVfC15P80XBAA9jYI2D6MckMLr9y3VZLi/tXtMSB7F
 FHF2v7t+CfQN9vKc+8q8x+Pj72lgjALC/NubHYujs2d1COASzlewhgFP2LA/nCg75x+w
 iDPtoJk5oWg5iQgkP5XxgUpo39oSUGfmBHkkg6xdWFacqyF0RSCHWN36am5v56qRwLrB
 Tt9PMOlIiSfQhbQeyF27xljbe8Omsk2Zc7d2Ng5xTAyw8cxwf2ONR1gAzbS15Q7o+HnU
 cjn19dOl877MIKo3c20vAIw8TsIuqt73SDfuH0YCbCsZxUqyU981gaaZ3jRi4F7eebJc
 33Aw==
X-Gm-Message-State: APuU4Z8d06cx1ScY/oip8nmbsyvx92Vdy7tey577YTH0MwdBrX5/Bwqj
 HvnG9QYmiq/iabFSvwlvxSrRM/ckf9Xql8ELORRLZJ/3WUQjjXTrh6anND+okfxh0Io=
X-Gm-Gg: AZFdTZfef0DoRbltuzdDUDCbhwfS8jJKVhTKIThIv9QOFmhrd4cAAecA+I7ZM//SJu9
 Kw171/sPXyi/ntPcVxNWNJ/oUvy5qOpHBGmsjnEdxcdiZJIVA58y8KlH5ykDYM6RtBFC1413qHZ
 HidAY36HQsOR3mBTfZoieje6ww+bhsScTpwtug5j49uC1ZfXiEXrl6b07eYVxzjP9S+WrzeBh/5
 ZHAPFP14qq8EYd2IxHoOUJX3mlp6xcJ90KxB/NFT3E0tqA+KMhg9AMyW+msd8aFiFRSkG6ykNeg
 MqFpgiaYSugv+8XxEEnCgYSNnao7GOPcK2236ep4xNU7NE+hoE9Eydyb0UZlSqtPmDSxQR2rRyP
 fiTPD1KxBh988c53oBHD68F3seNWiTqwbQV1XuzR7NC+9muGcFFMVdCsY92W9DgjbRDwbux1Eqx
 PYl0oQPs39k2xXC5cl/8eRz9dYrMWdaoCU525E9TlwhLMgxaDir3RR497tY/Nhs3Vm1yLLxSoav
 A8IGU/JYLmm2nNMhc07YzYGOv1RRu/sEcCQmjH7tFxC1LWRPpHnS+Q6lmP2RwoHiyTNR/WcBDw8
 2VWyEPfszdJAM26O6C7VRCDkkI91suGFeHVdIwpXbtU4eP8Rfsf5vB3TOJ9b4FlsAECN/qV3SA9
 sExZZTk4qcmIoc6E1Zttr0xIfJCMsCXdW1aqKAdc=
X-Received: by 2002:a17:907:869f:b0:c4d:31ca:e316 with SMTP id
 a640c23a62f3a-c51318f0558mr871915166b.20.1795366180776; 
 Sun, 22 Nov 2026 08:49:40 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:40 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 06/10] iotests: mark 149 as Linux-only
Date: Sun, 22 Nov 2026 17:49:01 +0100
Message-ID: <20261122164905.59680-7-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test 149 requires Linux specific dm-crypt and cryptsetup,
so mark it supported only on Linux.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/149 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 6dff39a28a..7b7afbd539 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -404,7 +404,8 @@ def test_once(config, qemu_img=False):
 
 
 # Obviously we only work with the luks image format
-iotests.script_initialize(supported_fmts=['luks'])
+iotests.script_initialize(supported_fmts=['luks'],
+                          supported_platforms=['linux'])
 
 # We need sudo in order to run cryptsetup to create
 # dm-crypt devices. This is safe to use on any
-- 
2.56.0


