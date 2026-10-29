Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FB606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W86N2ypV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYsZ-00086O-O1; Thu, 29 Oct 2026 18:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xMYsU-00085u-5L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:45:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xMYsS-0002X6-0T
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:45:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a56e05568aso187365e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793313942; x=1793918742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OK4jSEF/maHghR4gdRJrii9mhSE0OUUhA+ip3XcnLsU=;
 b=W86N2ypV/bdBlgb4CzgC8m42GbWezdRzgSV89DSCIHGI7AnOIGeDtsYqIc+jTb9TAi
 2ed7tPHZZ5Qj2y4pjH7LiUzEy28cCVs4GEDQ/BFOUOsSuNpk8RGgFsvWkRhAEp4Tikhv
 2UJs5+cP8342oKCigX8USQU0uCUbSsKQJvIXqndllX2iDxMb5c4zsQU31EGSm57B2h9/
 k29IEk6XI8PSrfObjnwb/wlEf18VNeZiahZsovicQaZIdPVpLwDchWqhFE2x819WKBID
 qG2mDe5+dkzwSyGo+zH3An3Kd6dB+P48oQyngBcP1sCLNihfRZbbgRk+UeartnqueS/Z
 o1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793313942; x=1793918742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OK4jSEF/maHghR4gdRJrii9mhSE0OUUhA+ip3XcnLsU=;
 b=c+a4enG6hHEovq7tz1KHPHH+4g6lAhc6metNJ/MHL5+4qqehKrSsJ76r9d+9jXiNt/
 AYB0lqif9JAdRzZx4O5MjT6vXEM3NUItTYdyiRoVZXzMp+qklvb09sDMloHa7ZjsLXpy
 CkJ7bjOWU5C5SCsX/MMg1YPLNbtGVQU+AmEj0ymN5uJJsLpYbuBhW1JPF7SxJDmwUiAy
 C7zu+Qxqkm1GHqlrA8bKrvx8oGshnC7/f5OKTs1cBdt+ctnX4udJIL+IiuOCHRdFoscS
 vfyiAsu8iWRl1vzXLSDu3lfD7AYF+jQnRXw+dOSC6ylYBzI+zeGy5heSCbvzJ88bxbPV
 QcOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxpGzX/i0TVoIXqDde90tYqezFDzJqBBwHy3EeTsCdh0HLkcUnUCoB6eeg9+oeQcssWl8+RDx3VVD7@nongnu.org
X-Gm-Message-State: AFq9FYLLK+tAu99uXiWQH4h2VCY/u/tSnRozP58ByFcOMR8JLz9JbSxY
 CMQ4tSb92HF23SNKKQ6zx7QQmHQ1HB+B2HCak0UjO6JNxMINshApBi8A
X-Gm-Gg: AYBFou3t75pdtMKzDgEdDPdeE6vBs2CSmi5vJiCappK9xqzcvm4tswwKZxjsNGDzeD0
 WrwU2DpclV/+4qtnJlOmVbO652p/EkVBfqxnVGictxQT/2oTtvqGUVsE6qwzd0nIzyAxoaE2bVI
 D1N/2ttzvRxr/iqy3Q01P0Xtk3XYMc/wOU0H9IDafPhM7HewovfFKxSwT1J5Tbby7c7FC+zjyNq
 mqAEiRR6kRrjVd/QVywMqutk3VqzEILfrAAMuct9modk1wfQvT2hE39a1MVAvlFP1ZgMq/ctFVt
 TDkkitNHgUy4aLglZ6ORMY4lmdikrIa8v78hevRbeQk2ecv8oU1Xb+ZNJCbuiTE5H6zddaBKwVF
 LiZequ7xwWkwNOr/K7hfQTsVhlrgiMUjg1XqlEGiYa8OzZiCIsTPIpmTqOr5BcMB7txRWBimmwk
 nf+L6X957t+YhSofSzsK4sQa+KhrsoeHOpXff2fwps9O95B8KxRDcpR3I7QuQmVhQlEBvsQQN2O
 ix7+1CWyzIwezLZO/MZ91GM+4+0417UTbvQ5hf57T31SZNjNJsgMX585+gto3/zyhO9JOB5Mb2J
 AqoavDoxtShkVKHWo3I7ULuyZSPLtNCSuN17ZIh12+2YzdZh7roIvlP91vnQf86i
X-Received: by 2002:a05:600c:c08c:b0:4a0:1e9f:64f6 with SMTP id
 5b1f17b1804b1-4ac12193b17mr7901535e9.0.1793313941476; 
 Thu, 29 Oct 2026 15:45:41 -0700 (PDT)
Received: from AtiePC ([2a0c:5a87:5006:4800:78cf:63bd:d449:f7bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a762bc1sm4925985e9.4.2026.10.29.15.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:45:40 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: richard.henderson@linaro.org
Cc: mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, danielpaziyski@gmail.com
Subject: Re: [PULL 00/78] pci, vhost, virtio, iommu, acpi: features, fixes
Date: Thu, 29 Oct 2026 23:44:56 +0100
Message-ID: <20261029224459.4573-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <0fc36ee2-60da-41e1-ae21-41e0ff21b156@linaro.org>
References: <0fc36ee2-60da-41e1-ae21-41e0ff21b156@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x334.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Please revert commit 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it"),
for the reason explained in https://lore.kernel.org/qemu-devel/CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com/

The v2 is at https://lore.kernel.org/qemu-devel/20261028213800.236067-1-danielpaziyski@gmail.com/

Sorry, I should have made the case as a reply to the pull for greater visibility.

Thanks,
Daniel


