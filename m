Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6194C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8kz-0002Tv-Am; Fri, 25 Sep 2026 12:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kw-0002S5-8w
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:38 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kt-0001Cl-Kq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:37 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0af40d240so619790a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790353594; x=1790958394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=58y18f27u1vovrwsYgHk1lhCiaHKNQzWDqCNhPCLBUA=;
 b=C262Cdlg6Jv30Z+UB109s6ihPT18gXYjKMGlf+ZU3H5atc0ll0ezoPftPOhvQwPiiv
 pilAKOfegCXMvMFokU+AZj2Wo4p6uybCfUpY1K4TDRHGE65bFyD35FRYjubotnjAuKzr
 r+9NBO78ElQRmXQrHhL60BsAmKFFghJRIRj6ZzgetKsmLu0mp6eHG6M/u1AQvRcQb+Fh
 9vtSmOlbxO3NqFhAghRYuPuKEqRDDd9JoKIhvy6YK6igkZokaEkG9kQFvNjOak0IZzTp
 uQF3FyiS+ToieX38WE7ezLuvRmMHcqbyFPiEzII8IgZni8KFg9T0NqHIjie11OmGgVXY
 Tp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353594; x=1790958394;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=58y18f27u1vovrwsYgHk1lhCiaHKNQzWDqCNhPCLBUA=;
 b=SU38kzemrFTYSGHgFzZNbwThwoQG/nWrBbBmVuTBCGvVBcvH/LFRAJiwoQY/eLwfR+
 QhjaaxqhDW0k9xK2S/4LYAB7SbJnjZaf7gx8xinyew6MUMYyISzm5Nb4DN2aJrdycU36
 UaDbBeAPaG4kmMYVWLB+Kx5Vq1jKmnEBocFkSjFKNvUVKp+03ffNjweS6QCqQgYtPJSP
 6G2C2Qn5MDu02k+urEMGx8IVsMctESbjPGt5Zl+m81IdRNfalGpQV1AAnnHxX15BmDp5
 Vt3F2zhu//h68ipDiDLpdzrkSEZaLShS95ZEk9xbNJGixQ50WtTH6ppO9ziwbXC0yx1F
 mNdQ==
X-Gm-Message-State: AFuF++nvB42YKOUcWZ4KQdj5SsTwxJvr/HLwEiJIr0srifTdU/4F7DaP
 0cYmItvwRbG0Ld5gqezKB4SrDEhKisOl0UoaDpcNSuxiVgw/EL3FD3Dmw0CAGMGsOngbsolz9wm
 0s6hB
X-Gm-Gg: AYBFou2LCuCsuLjFxPDvRNt8CRkADKto1LKhh16ZuQpg7qpGDVzQ99CWHDJiqZkDTKQ
 b44ZjKRYSDc1bKPm18Sx9if5YBDDI7JhPBz0CB57/vJ20frtd0rQ1Nk0e1lD6InEzMUJisF6XBJ
 XzhYA8f0HPWHD8SQtu6MSDWFcJqlfi2Y0EuOalqUspLoeomyS3j+Hd/+ZKniIAweUHtfgJT9fvp
 7CI7vRd7eLkiC+KZAcBRZ8Zkp6wnT7GAavQ2V1peaAVyrWQudD4aErRZoaKTnDFtxqdPSsLWzns
 4yF2CbTVKzeEsNvKZ4I7mySpSFhRdbyXPOS3loA6yofo9nbSMeZFfLuFqoj2uNchCcOevmygQHE
 xujASfMRLljSNOcdu+PKTa22bh9LFUXNLGVNCfaCwqk0IGXFyc05pVH0vSWFDJ7ogogMde2PZ/K
 p5KqRqpxH5m6+Zax0Ct0jCaoWeEEvYyfs4+Wjb2t2hwMIOkNUkAVjfZraYwzhW1qJRQfmsMOcS7
 LYwDQCPOrH0CacwvxY40/MKDQ0LnQ==
X-Received: by 2002:a17:90b:5410:b0:3a0:ac34:f7be with SMTP id
 98e67ed59e1d1-3a0ac34fc4dmr3332238a91.4.1790353593752; 
 Fri, 25 Sep 2026 09:26:33 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm11464809a91.13.2026.09.25.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:26:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 0/5] target/arm: Implement FEAT_IDTE3
Date: Fri, 25 Sep 2026 09:26:27 -0700
Message-ID: <20260925162632.404001-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes for v3:
  - Drop helper_tid3_udef_el1, because the entire tid3 space has backing cpregs.

r~

Richard Henderson (5):
  target/arm: Rename isar_feature_aa64_idst
  target/arm: Enable writes to SCR_EL3.TID{3,5}
  target/arm: Implement SCR_EL3.TID3
  target/arm: Implement SCR_EL3.TID5
  target/arm: Enable FEAT_IDTE3 for -cpu max

 docs/system/arm/emulation.rst  |  1 +
 target/arm/cpu-features.h      |  7 ++++++-
 target/arm/cpu.h               |  2 ++
 target/arm/helper.c            | 37 ++++++++++++++++++++++++++++++----
 target/arm/tcg/cpu64.c         |  4 ++++
 target/arm/tcg/op_helper.c     |  2 +-
 target/arm/tcg/translate-a64.c |  2 +-
 7 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.53.0


