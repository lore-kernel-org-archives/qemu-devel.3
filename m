Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4BEC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpxb-0006Ux-KS; Wed, 21 Feb 2024 12:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LyzWZQwKChY9wx430EF01w92AA270.yA8C08G-z0H079A929G.AD2@flex--nabihestefan.bounces.google.com>)
 id 1rcpxT-0006KX-3P
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:00:36 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LyzWZQwKChY9wx430EF01w92AA270.yA8C08G-z0H079A929G.AD2@flex--nabihestefan.bounces.google.com>)
 id 1rcpxR-00036V-Et
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:00:34 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc74ac7d015so8718299276.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708534831; x=1709139631; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=U+91MPSIGWth4xSmqUgGqGxd2uWLtvNeacGTv3UixX4=;
 b=Vl/ZC9o7hDXakN9pi9OEeAPTi0QuK5IU7HxsCcDXZmDceA7+rMZb1NOD/R7DK9iiWa
 /BxeYYL/r9vVn6ikJO/ZCK+lWxbozklmArgqvniNP78HwoTVE8m7QsmoIePu0nD6Tsci
 6uNwu3sHxfcCfOIilBrJRnG25YxdGzU/VanDedVeD28z9GbQofW8Me0hP0gjtRl41EIH
 So0pJSujeNfWxQkgpP0LVNcrwiNtR9w+F48EbhAVvwB0b4uoUmPN4GoFyUNDkX9AyR76
 ThaFurZoXLhDX0VXZfPstJEM48cR/IIfwEPwGTTg027NTFtBgCm6ANTUpGg6tsHxkWD9
 4Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708534831; x=1709139631;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+91MPSIGWth4xSmqUgGqGxd2uWLtvNeacGTv3UixX4=;
 b=CEfA5Ju/f/L0xymb18FIwoHjbL4QkgpnTEsom4H9TuFCBwTk0/w7jNS/lINKHkHrEM
 AJOCk8pHqaAsEInMaPx6TXr/4oO63JlY9MFEPHzIrKahwKBifWREyxPeBuD3VCNHqwjS
 Ckb7gjQ0QBb/mEqjD3xQoc77Y/nBn0vdJ/BBLy5NADdXn+N46olCHp1dNaQrq1KWJDP+
 KlFZe5PLYQrZRqyE5QPTFwl3n+JPK0qm76oDKHcQh+8FNcwv0hFkqPlX845fWk8002xO
 FtBpozjZBmX5K4A2d0ZH+YAqn94fvtF3LSebnh1iGS4xvKtiYFNJeDmeHvUiGtKDeADg
 IQ/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIK4RgMcECzBUEDY7FBGkuYIzdYiQIYkca+pMv+5gY8CnOwS0fpF4Q8My2MVY1HsC/EjuTMY+AlCWroyjiDgLx9WZu+50=
X-Gm-Message-State: AOJu0Yza5vl1IZcXCZzvf2sDX9AITT57Ne+IceVL1Y8IgvQ/TppidjEV
 ZNYsLD5+OmTfVfaxqtP671chDk4n//iDBkX3b3szoThb8P4LAT1jVAUC7Xz5lN303EP35mD9t5J
 /JRaWziYbPJCdF+5FgKcPKx5Anw==
X-Google-Smtp-Source: AGHT+IGLL50KNNxSTEmqnQzXjnxzzo6itOUyqwJbkwaofglKbKOm24A7eoP00VsctuWcg6pwVzvafGqGMLx83airR68=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with
 SMTP id w1-20020a056902100100b00dcc79abe522mr771617ybt.11.1708534831526; Wed,
 21 Feb 2024 09:00:31 -0800 (PST)
Date: Wed, 21 Feb 2024 17:00:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221170027.1027325-1-nabihestefan@google.com>
Subject: [PATCH 0/2] SMBIOS type 9 descriptor implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, eric.auger@redhat.com, mst@redhat.com, 
 imammedo@redhat.com, anisinha@redhat.com, flwu@google.com, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3LyzWZQwKChY9wx430EF01w92AA270.yA8C08G-z0H079A929G.AD2@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch series implements SMBIOS type 9 descriptor, system slots.
For each system slot, we can assign one descriptor for it if needed.
In versions later than 2.6, a new PCI device field was added to make sure the
descriptor is associated with a certain device, if provided.
For ease of usage, qemu-options.hx was updated.

Felix Wu (2):
  Implement base of SMBIOS type 9 descriptor.
  Implement SMBIOS type 9 v2.6

 hw/smbios/smbios.c           | 142 +++++++++++++++++++++++++++++++++++
 include/hw/firmware/smbios.h |  17 +++++
 qemu-options.hx              |   3 +
 3 files changed, 162 insertions(+)

-- 
2.44.0.rc0.258.g7320e95886-goog


