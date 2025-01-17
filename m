Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34D3C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq9O-0004G2-8C; Fri, 17 Jan 2025 12:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYq9M-0004Fn-Pj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:28:52 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYq9K-000770-QC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:28:52 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2156e078563so32847165ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134929; x=1737739729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FogQALS97iJ4jyyHuwnbahFIptxhN64hjUIw+g1peCg=;
 b=HMa3UEENDUtEUsDWWBtOt1n2PW7EXCu+BvVoXW67S2Xqmc+/0s0ADfontlMJsnaPtJ
 uL/0T8TVijnfYUfQB2JCiAAQef/v00f86YdSUBICvjiuRI0dNzO9QlZDUYIAB1+ngTT+
 q9kjS+y4oLtPDmN8aobTAAMq3SOcBMw2OLjgmGFZWOMYtCjc0Xqfzmb5U+3OmlJrZZv/
 /ybR9yfdjhOPDrsRTRXidCNjC+pElR7cgrxp7ek9FZO9UCSWl5lxa0jvZklCBZqdAGiw
 Ffn8oUAD0NHGXJBDIBtU/cmlIChH9HepbuwQoqILxztllcxwGe79v6j4kBGWxstVIFvf
 dzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134929; x=1737739729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FogQALS97iJ4jyyHuwnbahFIptxhN64hjUIw+g1peCg=;
 b=gSruRWw0XGGrQI4++LC0UBEzq4XnI1a2QrZjY+YrNeAYC+ugMUKCezLgxNw7Ras0kk
 onWezPHZYlybt9Zh6cb9N0sNBCNBfnbr4Y3Ib5tQjvsxYOWlqLgEwYg6bnx/i6/EeJ5q
 cVVNWBSxoDZ+IGo6rH/8C+uvCCxZmLTkhWWW7F7O38ZTxocDl7duf0zotCbD+7NMlSbl
 tyKikN9hCEiEtdzGGHPfvrtLI+Uk0mA8DK4dh0UKU7Uq5xap2ZZI/w3WeRFRAXjLqUn/
 iVmE3W1WuiXWxGiAQP4FVoEg1SEnxFEPaqCSK8RiHV71+3oBStZyZz7l8rpa20WS0B3L
 A7kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3RUJ5xbeyQ3z8F+ZLIBBYgkefxUk3MbObkllj3uKV3COXYhE96LLRD89Ms36F3LzD1frueEgbkzzf@nongnu.org
X-Gm-Message-State: AOJu0YyVrrK980QaOVN1N17ObSPxKy3FrVzqv9+ndLnyTdMDXYdui+qh
 tuovOTI8nVx202+ZxIsZ+JFGuCKfXmfYttOXjnWUJCVixBBocHJcIcF2KQ==
X-Gm-Gg: ASbGncuYmeUZP2p5+/BZ95tNeAz2KqsdAajWqG/kJBP81kl4EflLF09ZQqvbXuAtc5n
 0rxa/tKFxfwt38HYl1HPgjnXjXlBVn5Bg54YDTRZEAEpCql4cfWrVp8+zGLJcNMOMXj1D+jClEr
 XkWRuyyPtBHCVtcF2yUHLbFAbmANK5/t0rmNCSaHd0ptCBXUavXF9NgyHHYnEgCTNPEEQdwP/n1
 pUy9rSeHbttw/2iHTaoM4KOZGkQG2yyZ4anCnYUdBSyitk3dPC3RnOC11Z8FkVnvcZeqIXbH2V8
 zLr442hHs+2L078=
X-Google-Smtp-Source: AGHT+IG4CNTSPvCuKmfoeEVKELfZ1H1ceYI79IHRtyA7BZNbM9zwUgs4VFjIz80gZUHc9GxDhE20RA==
X-Received: by 2002:a17:902:d501:b0:20c:9821:6998 with SMTP id
 d9443c01a7336-21c352c798emr60589715ad.10.1737134929355; 
 Fri, 17 Jan 2025 09:28:49 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a8a2bsm18658805ad.142.2025.01.17.09.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:28:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/pci: catch a few error cases
Date: Sat, 18 Jan 2025 03:28:39 +1000
Message-ID: <20250117172842.406338-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Hi,

These would have helped to catch a few bugs I ran into / created
recently, so they might be worth upstreaming.

Thanks,
Nick

Nicholas Piggin (2):
  hw/pci/msix: Warn on PBA writes
  hw/pci: Assert a bar is not registered multiple times

 hw/pci/msix.c | 9 +++++++++
 hw/pci/pci.c  | 1 +
 2 files changed, 10 insertions(+)

-- 
2.45.2


