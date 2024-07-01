Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F275C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 22:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOPlA-0005Uz-FH; Mon, 01 Jul 2024 18:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOPl7-0005UW-L9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:44:30 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOPl5-00031o-IF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:44:28 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cdf9f934fso3653899e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719873864; x=1720478664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P5PrX7Mf/uUnupEbVW+b7PDHyiggb6/C3MHTxe8hmSs=;
 b=Cku4se9W+D5Q2PcxdzbuMLbAzzip9sflmqT7e4jI8MCK+ahxdQG4xuiR7Dhv1Xh7Pi
 8M3tODjic0J/koYfVnv7NHQVAJtenK8SylzCBZTYoDuSfVcVVLSS+gzOIV47DVf+QE0G
 Tv6xGv4wjnyXHiZ9oPZcyH1mrMj9TONjBLis06+KbX3/YkI9bd8qlKWSXU3vO4+cvY5g
 C3c/GcRXWewOx2pFA0s3O598NRuVUPRsYCrd9ue17wUfpbma6I7llLWPYAG+KNuTGPh3
 Vip4U8X3J/aUY6SuipdzBTiTDtwUFfcXC8GqJeNtzFhVSw8KhCwAmPV52/FqxpX192hd
 fs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719873864; x=1720478664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P5PrX7Mf/uUnupEbVW+b7PDHyiggb6/C3MHTxe8hmSs=;
 b=QT5baxwp46cH65E21K/KiXWZyozwZOPqJcJQeviLhcBDusV8I37DWzFmoqgZ/FqIfx
 PnEN84gCdW8XQw1FKYmAYh/ha6QmbAqASNz6vxEY4lfAN4lLzRXlzrcBCVoF4ZHDtBSj
 6pqn4CplU/3FK7wsyPcUskoRWrq7Xnkh+Qh/ow01aotbKlrEWUZUed9cMqaHCcIqngHj
 mxM9AvYWqSUa02AjDfTk+xYJy78Z9RtNAcvAEjqW+wQkONB4ut+se4E/ufHxWt8EOVTF
 fwqz3Z/kJsDgjjYJHZNbqZ/ZKeRydUXqRruDR/pJBJnihCEeOt+1m4HjUONKeS/RttMr
 Bgkw==
X-Gm-Message-State: AOJu0YxPKkwYscf3ZLx7ruxaaWSv5HXW91xK0ERyjKcWOBWzVlArk5j1
 MaoSAYlzawxuHIy94AJrKbjfwpDfayxfaJ73Vro140uxigH057pI33muX1Aq
X-Google-Smtp-Source: AGHT+IGCO1KLkxlsTsh8WUidlGFP1OF4KX+DPy6pH829DSJkzsU8858klanFcWRr8vEYi1+YHzFmuQ==
X-Received: by 2002:a05:6512:2315:b0:52c:db75:9640 with SMTP id
 2adb3069b0e04-52e82701721mr4566344e87.48.1719873864067; 
 Mon, 01 Jul 2024 15:44:24 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab3b154sm1590903e87.259.2024.07.01.15.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 15:44:23 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: [PATCH v1 0/2] xen: mapcache: Fix unmapping of first the entry in a
 bucket
Date: Tue,  2 Jul 2024 00:44:19 +0200
Message-ID: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This fixes the unmapping of the first mapping in a bucket of a mapcache.

We also add error handling to qemu_ram_block_from_host() to bail out when
xen_ram_addr_from_mapcache() doesn't find an existing mapping.

Cheers,
Edgar

Edgar E. Iglesias (2):
  physmem: Bail out qemu_ram_block_from_host() for invalid ram addrs
  xen: mapcache: Fix unmapping of first entries in buckets

 hw/xen/xen-mapcache.c | 12 +++++++++++-
 system/physmem.c      |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.43.0


