Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C240C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwK9k-0008KS-CK; Tue, 18 Aug 2026 09:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwK9j-0008KH-1d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:47:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwK9h-0002WJ-B6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:47:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso6188966b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787060824; x=1787665624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hhW2vglOZGKG2CAkbSfYtHiyBcC9iCWmucq3V4qjFZA=;
 b=nnKhU4cQT89PXCfDiPdhL7TRs0TCa4c0/RthYudK76vaEA/7Tnw9nXLUxQJk1OewX7
 dsnyLiG6MWMYwR3SWVRrzjb2bVGgMQH1n3V22U4MF7qZvSASfrQiz2QFRTsSu3vC0Gwi
 weGTr3vgbgevjTVrmBJKBm+3vZGWBzSx0WAsKzTABjGOxNScvUIqNZ6T+DJE5ciCiQ/A
 Nn0e4ZlYxxu2hC/aLobZxOMdwTrMZ6rTmLiNHf7WIGQGGKgjjtOmCGc9Oi5OPo5wgTZT
 LnENKex80/z7uIkO8WsSvafhBMpc6ZJQKj1tnVGAQzFethvff3tyqm+ZhbJMz+7UczvE
 +cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060824; x=1787665624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhW2vglOZGKG2CAkbSfYtHiyBcC9iCWmucq3V4qjFZA=;
 b=ExBWxQPrxSEfW9qT01+I258IWcIcihoBP2+kvaiUJHwK6KdE/Bxu5pYPZo84HLUH0R
 /N0fkJmGicM0Ivw6v9b258n2HcrAuOzl6X1G7xSSSBFlI6Kz1SnpKdK/7lQf47//yMyK
 4t2PF+sRXfy8eKAdCSG4xDiv7DeQq6Kh8SvbLceszJVYd7LIcyJkp+cIIV6ZNCZheYV7
 PZIPPO1AM6W2uL1YDsup972wu/Bp09luCr+sVGqefD5He57FFcAr2Y6Mnyvi8vuXVN5X
 MQNMXw7VmdRHPWfzIspFevgB7Gi50yUeDrT/rIowOwYZx2ImeLzNBTJ5P/sr/gO5urt7
 Qi8w==
X-Gm-Message-State: AOJu0YyzRQtD07/DWfMApCodeAGWWVH+BRXUFhQUyyCd2PNkyBvh8wR7
 +hh0+ZLXOCrTvZ1WutMMDI5lUTJb5bIIPtLn61uUq62sV21eHIzSLeomAnD4yUZk7h+vSQ==
X-Gm-Gg: AR+sD10E4VCHe9wmg1aVpnrqXv+IBElmCjHFbgXw7oN4fk5cUz/ZMg69VLi+c6vTBAg
 xPkyEngH5gLF4y/uEBYD6f5/lOXT0M4EtBKRcGAsCPHwqEzHrkn0wAXSQaTDt/eNbl0toI0d/in
 BaSu8IHnE5eAiuzInqdFYrUKe07n5vPf1Td6JPpHfo4VnZsB45EtDKnJRPMyc2asN0NN+LfcoAm
 Bf6I2WyAbSL5I2ClTkVzy+A3yVJjXMFe3h6gThsxXSW8bMkjXB+p1sa5BsU/BL/aLPqaCG9tese
 GvMdjjDm6BdK8sfXLVUvH5/CHVj+mfvwnZgYwkMMH9XspH80BDzlPAmlUxZlcUefVnhfjlIi5Zm
 15ckOn+EsKJGLiMxmmcYAK905qqo7283BbeJdikf9wvSycKGn3sDGE3wmeSoQ7o7KfagsEfK2ZH
 r4XqouOFrRHObSlNyfJNeAkYiazwHXmQXovtQtbkZzRrl+SS361qz1
X-Received: by 2002:a05:6a00:ba8e:b0:851:c21c:4146 with SMTP id
 d2e1a72fcca58-851c21c4deemr7040652b3a.0.1787060823782; 
 Tue, 18 Aug 2026 06:47:03 -0700 (PDT)
Received: from colazcyASUSlaptop ([2a09:bac1:76e0:3d0::26b:c3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6ff0a13sm1620529b3a.59.2026.08.18.06.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:47:03 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC v3 0/1] the org.qemu.Display1.UIInfo interface design
Date: Tue, 18 Aug 2026 21:45:42 +0800
Message-ID: <20260818134543.654949-1-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=colazcyg@gmail.com; helo=mail-pf1-x42d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the `SetUIInfo` method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This RFC adds the `UIInfo` interface containing
  * properties as staged display settings.
  * property `Supported` indicating whether console UI info is supported.
  * the method `Apply` applying staged settings.
  * the method `Reload` reloading settings from the console.

Changes since v2:
  * added a read-only bool property "Supported" on the interface.
  * switched to typesafe getter & setter.
  * documented each property/method individually.

Test results:
  * qemu:qtest-x86_64/dbus-display-test passed
  * qemu:qtest-x86_64/dbus-vmstate-test passed
  * qemu:qtest-x86_64/dbus-vnc-test SKIP
  * manually created a virtual machine
    and successfully set its refresh rate and resolution via `UIInfo`
  * sphinxdocs build passed

Chengyang Zhu (1):
  ui/dbus: add org.qemu.Display1.UIInfo interface

 ui/dbus-console.c    | 71 ++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

-- 
2.55.0


