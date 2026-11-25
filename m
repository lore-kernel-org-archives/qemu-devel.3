Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EB606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rqa0k8a6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW4ja-0001z4-UR; Tue, 24 Nov 2026 23:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4jP-0001y1-N3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:35:44 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4jO-0008Pr-7O
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:35:43 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6e560e00a86so3500582eaf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795581341; x=1796186141; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jZvuic0AwvUtQfyNQ6yV/Fd5ZAtSRIvydlAiRw1FzZg=;
 b=Rqa0k8a6RGaPgS9wzDv6GFku5Nau4WFIxIl3UDYorWHiBE6pYvsq4MHf2sR4wrG4u9
 85ueYoKLZ8qKCHIM5bHsDqyrjBd2f+XhtaDXM/IPunsOVSBh31P1RBzMAJSEmzyJodmu
 oPfCfmJwCowEkj6tN3EOQtUMS2oTRi51/iCXvNCQMH1q/2ByZM0paSjFv2xR1VKSISkm
 kmvfurKmsPJERbCuX5Ykn7fsKvCNR5w1zuUXb2+J7jpXUUYtF8SBolBpPgC8Iz0YvEuC
 u3YIWl9gXj1Wwu/0YEHv1QIlajmmHayRL8MzEIsfgNevDZ8irPcuATjaLXj7yclMSfAh
 5bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795581341; x=1796186141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZvuic0AwvUtQfyNQ6yV/Fd5ZAtSRIvydlAiRw1FzZg=;
 b=N+gGf9XkLwn/jXiHTpIoC+aqAA1Ne/bDO8PbTTp6sbJw+5DyQIClomBVYZjFvFkK+w
 JHIn5gxnGyY44+c8dIhsFmogzjSeGae3A4OodXU8bm3OchGHGP7+hh4rN2Khzvq+KP5l
 D/n5uxR20hOZr+Ix3+YYtwMJFIiMwfbXElK0xI/SZCxojUGQkPp+vwLltFLf1aNawyBz
 aJ5U82NrGm9nZp8NdacXuiLU3b6C3IJQedKrsvssz4/PnCogx5IQZeypo0wmFcBA3R+l
 9J/PmHR8/6gzRH0DSsmjysPphEexMyNzvOHbiOEtRzCJPvc94P5UxPlXGzoaHMkMv5Yn
 KBAQ==
X-Gm-Message-State: APuU4Z/p9RK+kTdGDojcvxag/O5mlRRhbOUcMcd4NURLZlkQ2t6uadAf
 NDV3Pl0mCzJUdEHC9+L/AX0pkuThavVThALBhWz9bDjS3um4DfEfoEdi
X-Gm-Gg: AZFdTZcfliwONuuNB6TB73wgClOfCea/gaIaPKO589z/leOMXDsjgclR3xDz5o7q5xT
 EXKWomcGyIv6PBZRkjMoUcIrpMPB26oqc+MVi9GrUOCzVOiu/a2OVIjSVribN5Ho66+OoRWcEpC
 ZaICZIWZ6z0hR1DHFD1PyYi1IIHb68MeowXAEAV0zHtTJUool0byYan8HV/Dbsrr29s8b6GKEWd
 r24K3nYXSRg7GGtuf8z5fu9vNMm448v01JTWrb4JCGP0IkCCTSCwZ6UJ04NfXhOah2aQm8eQKFM
 F81+V5YSC1yDQNX/3UPVu5v4Es02vb+OI4MOdpeSkYHvMP+dt4ut/YrKpRglkz8iNdIPi+WAMSx
 Xf42kH0rdLFE2vsfERTU10mEBKeXmb+Mw0Ceul3+KwSfVYWeFoNlbtt5BGNWctNj2CqGTkEaISU
 25sPUlXYiOBOluV5SWU556WqE8CwmhiMJ0bIoMZd1aGXkvaqxYzBU6/pH8Un00GU6IUJiiUlcdD
 YsnnU00AY/RYDsk7LIgFPg9HlEwJFDsixh/3DzeiaIfvb/4gT/sCA8ZYVQJgNNlboHSs7pj5Og3
 DOPNKdbWflu8U1ngc9Te0Ooj
X-Received: by 2002:a05:6820:a006:b0:716:c870:7ee1 with SMTP id
 006d021491bc7-71b395c1589mr11433304eaf.65.1795581341037; 
 Tue, 24 Nov 2026 20:35:41 -0800 (PST)
Received: from [127.0.1.1] ([2603:8080:a00:9759:77b:471:20d8:44bf])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380bdff9sm11183745eaf.11.2026.11.24.20.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 20:35:39 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Tue, 24 Nov 2026 22:35:32 -0600
Subject: [PATCH v2 1/2] hw/net: always validate the interrupt index of the
 first RX descriptor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-1-cd18eec4f369@gmail.com>
References: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
In-Reply-To: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795581335; l=929;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=Vw4pYloR6EmSZCd63gC0q3AyXkDpFkN/hBVUxSl6/cw=;
 b=sUfbnwpaiSQyvMogi7KR4tgjI7Kx8HB+7pkxlsoxjInkP4p8NbGQ4AqDVUycvlb6UaTDNXpZG
 J6fWW6JrryqCvdXsON38TfMMVJ8fBRXq8iUypJnFQNpve+LzHcu/Iij
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=xmphyr@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Made it so that vmxnet3_validate_interrupts will always validate
s->rxq_descr[0].intr_idx.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
---
 hw/net/vmxnet3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 24c551a054..58bb7fb869 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1367,13 +1367,15 @@ static bool vmxnet3_validate_interrupts(VMXNET3State *s)
         }
     }
 
-    for (i = 0; i < s->rxq_num; i++) {
+    i = 0;
+    do {
         int idx = s->rxq_descr[i].intr_idx;
         VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
         if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
             return false;
         }
-    }
+        i++;
+    } while (i < s->rxq_num);
 
     return true;
 }

-- 
2.43.0


