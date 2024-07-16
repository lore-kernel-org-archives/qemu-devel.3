Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926D5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeZe-0003lh-Ah; Tue, 16 Jul 2024 05:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTeZb-0003hV-Ui
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTeZa-0006Ay-Ga
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721122453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TuFgJAiaqaiYIKjf76Zp2Be2tXV0AfqSqjMt/8eq9G4=;
 b=G55hgfFtNIRUsfajRlgQrmM0fKr0CjWZsHoeLEUsXfoNelXvQ0tqXNvAChmh3vRS6IYoU3
 WzDpPM86NZ/QpSPiW73ZW56DUdZbo8RgxPhh7hs4sCXrSiKjtx5csZgwSCXTUMHMvFKwd+
 z6JHd0O4OmT7LynZbRrZOKAnX3u6+Lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-qNwiAaCfOTWktu_2E-lJnA-1; Tue, 16 Jul 2024 05:34:11 -0400
X-MC-Unique: qNwiAaCfOTWktu_2E-lJnA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36805bfd95aso2649610f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122449; x=1721727249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TuFgJAiaqaiYIKjf76Zp2Be2tXV0AfqSqjMt/8eq9G4=;
 b=COrgJiBGk/GgS7OaIVFKaTqJWOMiVZCt4WZDtWZ2gLz5mTyuyE/0Q7LM1+cxEXftk9
 fX58tGBr1tv6sSZbRQovwcEF+XKnO1U5/Su9PFCQxh88E99o3d09gCZKdwa4k2MAC8+z
 meX7wyafkLnqfpyOx5u+EeyMiFcJmCUudaJqxeEOpcBRG+84tWupGLo32bsLVQwxgEKP
 cFBnlDrzmdk6tH1Ra4tXxrb/RdZTj/cFswDPkK31xgsGISRn8phhOleBECAVd5hTKOr2
 4wR42is/F84UApFBj6UizBJ+mQmLN8AL49pMx7CvM8GCqDL4mdBghxI37S/UmoxpXuoV
 PQ+Q==
X-Gm-Message-State: AOJu0Yz51ZWuOvpZnJayk9DDrVckpf60u2mMX2HNCtrlPIFoUTU13Hpa
 Ii99Vu8cT1lcjI10tZU0kfMutBuqVcTW8eAAMIwPRahq5hGa21Gi7uOVo1urC0eIUIRsP2i/8yC
 6/X/HbECdL/NQCMM9oDHjWcU79/YFW1BACdnu9pz+bEL5dvaqctNLvQpmVtCrOMCLp7nepKqJ5i
 yonB0HCVfq3jCC/OAPzLu3JCSiiaKK1v0LPi2g
X-Received: by 2002:a5d:548a:0:b0:35f:b03:bf45 with SMTP id
 ffacd0b85a97d-368261138famr1013490f8f.24.1721122449644; 
 Tue, 16 Jul 2024 02:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqMyJRfPM3kWOHwJH9yhHkpRnwRi/On+uzsj2kMjsmUK23apnIrlivd/zxmygdpypfnkZ/yg==
X-Received: by 2002:a5d:548a:0:b0:35f:b03:bf45 with SMTP id
 ffacd0b85a97d-368261138famr1013473f8f.24.1721122449225; 
 Tue, 16 Jul 2024 02:34:09 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db04581sm8565987f8f.97.2024.07.16.02.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 02:34:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: taisei1212@outlook.jp
Subject: [PATCH 0/2] first batch of hpet fixes
Date: Tue, 16 Jul 2024 11:34:05 +0200
Message-ID: <20240716093407.194065-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extracted from the patch that TaiseiIto <taisei1212@outlook.jp> tested.
While not sufficient to fix their problems, this is a step in the
right direction.

Paolo Bonzini (2):
  hpet: fix clamping of period
  hpet: fix HPET_TN_SETVAL for high 32-bits of the comparator

 hw/timer/hpet.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.45.2


