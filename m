Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B002C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTNY-0007zk-3h; Wed, 26 Mar 2025 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.david@gmail.com>)
 id 1txT46-0001Oo-Fm
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:53:14 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <valentin.david@gmail.com>)
 id 1txT44-0008RE-VX
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:53:14 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso569759066b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743004389; x=1743609189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m5NLbHuXWftdly2P1faiDSCHD437CVQun8BNy/q48I4=;
 b=duZBp/VnOfJdSqdG+2RaYoUX0O8mgCdYm4nCitufGY25t3yuU7R7n7sEc26qhN7EFi
 6tuFKcGA1K7gX9iSkZr1r5OEk2zejSotnHf/6tI/ORUgWKgB36w+laz8rE5VdcJlJiWB
 n6+bXcgpjm17FXMU108I8yTPUgKtvd4A2RsdpCjucjf1WXT0jHfHdTnUkzjeVV7hHovo
 ttuMYUCXs/4S3TgjIMafg9mPIXFbiY20zLPQsKyRU6DNgPRHaRqKGLSABRBPnvzehwww
 +AoGCUh3jXAN5yOUKc8LZKRVnTntbQMv/ncn6TvVmKUrXMX1HvjVvvRhqQFfYl3yhaou
 XZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743004389; x=1743609189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5NLbHuXWftdly2P1faiDSCHD437CVQun8BNy/q48I4=;
 b=Xy2X4Vk6DSZ+7pq+bGkgE4yWeL7XdBPcXztWYNjBNrtsP2BTtEjUoCRBYhez4yQbTW
 rePyda2Ru5jTONOZVZ6P5LQNvtYo3BLYZCrIOiMB84TMf5rLZnX+C8k3eK7xfM/XWZk6
 l6lfMRuoJH2e9R4UkH3CgIaiMq0ZJcJ/JdRhQpNwlKUmXpvSlLONbcsRbX+uAAsjavKa
 pXBk4VGIpiIK4YUEBA8Hb6aAXd0QbDFLdQ68sFfVOTdwNGKqbu2PAd7+CR+K9KP0K/2/
 wVlOoQ+QQ4dMf1+mFZAtYUOtmhUBc1uvxDrL+Hsar4Cn3JvMmSiB8mcPYy/HNpQCY0en
 V1QQ==
X-Gm-Message-State: AOJu0YyKzL7Vk5Nk/997nHUI+EBQ4hDPjpPQ1GB08EpAbCh18UdJhI06
 0CV21iGgJv4cfLiyricYeubQGHFJvaSWzZ0o4xnJIGCsl97g1hERbwgLm2gm
X-Gm-Gg: ASbGncuXxXNgMSTls2+fJ6ctGqPTLC5j//wldks9/Hmot9NMR35DSgsJZuJYGNpk1Gx
 8+/1q68nTurigf+SCt8lgKPdWQ8pbleOHqEr/YR2TR/5mTz36uJb/5zS11aWhAiYjBVnM2PnUcI
 MQJO8pJbb1ePUp8amiwVyoROCGWPqSTzWm0xqIIxLubllgL4DJv6/8N9fXEWbxx3s+1A37p8es5
 is3ql/GgGuTvYdXPKW24AwPVVWK55lmzSlSVxx1f3VV7Iz8He1eDki70EAM2IU5WVaXWeT9R+1Q
 /ohp/kxz1i1CTKoc/t+AHTEGaRuz8FDKAbP9Jdj/O3DP8w0=
X-Google-Smtp-Source: AGHT+IH96hE0yaXhKl0swiG3a8tkv3pn1qPEfYhhf9lQJDhisFARA68EmQmobT2HbamJ0Jt4pRSaAw==
X-Received: by 2002:a17:907:7296:b0:ac3:2ba6:3c37 with SMTP id
 a640c23a62f3a-ac3f24d6810mr2177200166b.46.1743004388922; 
 Wed, 26 Mar 2025 08:53:08 -0700 (PDT)
Received: from valmont.froyen.eu ([2a01:799:31b:3400::1e6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd955aasm1051430266b.180.2025.03.26.08.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 08:53:08 -0700 (PDT)
From: Valentin David <valentin.david@gmail.com>
X-Google-Original-From: Valentin David <valentin.david@canonical.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Valentin David <valentin.david@canonical.com>
Subject: [PATCH] hw/smbios/smbios.c: Add missing NUL terminal to string from
 path= parameter
Date: Wed, 26 Mar 2025 16:52:54 +0100
Message-ID: <20250326155254.2273939-1-valentin.david@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=valentin.david@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Mar 2025 12:13:15 -0400
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

Without it, it seems the data gets garbage at the end of the string.

Signed-off-by: Valentin David <valentin.david@canonical.com>
---
 hw/smbios/smbios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 02a09eb9cd..7522e9a172 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1283,6 +1283,7 @@ static int save_opt_one(void *opaque,
                 return -1;
             }
             g_byte_array_append(data, (guint8 *)buf, ret);
+            g_byte_array_append(data, (guint8 *)"\0", 1);
         }
 
         qemu_close(fd);
-- 
2.48.1


