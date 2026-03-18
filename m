Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AA8103E18D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rgL-0007A5-Rg; Wed, 18 Mar 2026 10:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgJ-000752-Nk
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rgG-0005zp-J7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8296d553142so3245746b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843327; x=1774448127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAF+Ctc/n8rztxL19g6KwtSiXS2fa1crOXpQVEMXVww=;
 b=DE6eC9/YrMniym4F98gkQ5ZKsibGuD4ZhZIp17+jyG518FZKWORlPnCbKtCRFqULOK
 WqlI2mJTnsh7vsB+1gPKbcbZUy0nlAnUzlNy/1yy+1G0pg1D/JxT7N9A9TM70tJvS9Vu
 l616OGXmbX2bi6R5aQJYJZomrbxeXXs05LrvRwDaqg5Lge1zNrmbOSNAMHJkEIac/uHl
 hYe7IU6X6QErne8znbS3bDSDotstPy4OWuFvve4Jr4HHujl1vbCcSmOdVMXT4YP6BYLn
 8docSr7W4OHPm06Q1leO40MOm/yVOy9RgN72rFRDUk+hmW5ohcOwW31VgnMhKlqmEfzR
 ghbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843327; x=1774448127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAF+Ctc/n8rztxL19g6KwtSiXS2fa1crOXpQVEMXVww=;
 b=gOYWjrFP7UQJtDtjKYCkCtgRDzwNYaGhNmA3T0uatG18Grvmab3Zl7++jxtv0T/VIO
 peKloqrUvYGe3WRhrHxfns9tKV9dd9aOoxdbFMUbbrDvhZyAtmyQJvxP9ga6IiaUPhrs
 lEi3IPdyVNibclVrMTo6YcZbeDPQeuhYXXEB76R2/+F9LbH1U56DM8qDm3n/h9Nl1wbx
 Z1LwMkh6/PK/Z4a34i2J1MQSwCviK7V9yVs3lQI3+pLE0zBEDMQYXbJIBPM3mFlQzCtu
 L2s9j9oWzgFe6rBV38THgmWKOL4AewToJR7SthH/pMuTjgkQwhWjEG6NI5WHpFxnwxzP
 NRTw==
X-Gm-Message-State: AOJu0Ywqh+2F/J5PeIMTOD8Ro4sK8hFFZ8g52cIdr3R6eslehq9E/LPC
 YLCNWY09RA9j/OBUjqaxXNQnmOfCSsRwxU6BGn4aPmIRVmPbvVbmt2QWlCn0TGHB90s=
X-Gm-Gg: ATEYQzzlrwQig/XZi+Q653IjUFXCE/uK/9EMHizuk28GFEW8RVtXV3PkT2rKGsGv2xz
 r38QyZV3/3XHx9JxzgDwkbxMI38YRgCXNUIsyTULpmEEgwlb9D6q6UUq0SCvrMZXjOTMc+4bHE1
 HG7zd4pDmzjdamXFYARfYSNsEGfXfNG2VYD+0lbbO4Jo+HNXFaUlPeEEQI59ynYTJmbFEEfa73I
 Bx0G3GsnJaAbnwZpsGw98fe5+A6Nbrq74PIFdod43nm2M0GhjQFoTxdjpdxAjC0HS8m9/vnXoq5
 Zn2QmUTJoLIXpC4kPOWkbaZU7Z1Xey3Az+VQRJp+TvpCZDERAqu8CWCwMPbms4STQfGfpH5+Hpy
 qmnFdbTIT4lFYzwJ9+WYEN3DebN5dNqn9YihoaEy/3ZZuC5MO8etljux+rYyX53bs8Q5sZHHSl7
 N442E0PVD6GJIZ+EMBG3xjFMbOyxBCRbKPbfrDAI5drcd1eM3ryzVrDXn8HXMT0dRwRKG6/YYfa
 BekdqqCYJaU7tPRtQ0c
X-Received: by 2002:a05:6a00:1d15:b0:824:ad1e:3b6e with SMTP id
 d2e1a72fcca58-82a6af17eeemr3305363b3a.49.1773843326639; 
 Wed, 18 Mar 2026 07:15:26 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6af06bd7sm2927272b3a.0.2026.03.18.07.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:15:26 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
	Corey Minyard <minyard@acm.org>
Subject: [PATCH v3 2/4] hw/core/loader: fix error handling for get_image_size
 callers
Date: Wed, 18 Mar 2026 23:14:11 +0900
Message-ID: <20260318141415.8538-3-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318141415.8538-1-vikingtc4@gmail.com>
References: <20260318141415.8538-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Check the return value of get_image_size() and report failures
for non-mandatory file such as FRU image.

- Use ret < 0 to detect failures in getting image size.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 012e2ee4fe..fd875491f5 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
             g_free(fru->data);
             fru->data = NULL;
         }
+    } else {
+        error_report("Could not get file size '%s'", fru->filename);
     }
 
 out:
-- 
2.43.0


