Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6839C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOfC-0000nw-9y; Sun, 23 Feb 2025 21:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOf3-0000jQ-Ik
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:38 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOf0-00018F-Cn
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso87689215ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 18:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740365852; x=1740970652; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hw2IJtY7IZ4KymZBDBvHYBuimc9dyqnwvi3DV/6wYZ4=;
 b=OsDgsHliNJVD0Fl0l6yIYFfrHSB2JK7EarJK+M+v1gWQBkPuS8sKLFIkNsSxhktmYg
 jCB00cmGRPGY7kgZ07l31WoiYTDXMrOyi/sD3PCyBtzSoPX2mIDBMyR4Ljmra1MJE/QU
 aul116oaKlMVtqNex9KmQ9UfUOmFTzz3VrnFvkLPAicG6B7hnesm3N4mythDkPwjsUvo
 MhdRw5HQW82N4U6KJqmUCKCQLm3PdjhoW9vJdMhfzm4KpJiT4MP1YkVYac0FMRtKE5sk
 kPvyUXTRJ5h+nN93VMbBf35UnB+14ZNjQ7PBhuOEXrIgF96VKn2TFb9n7EmWO/7D+va5
 fT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740365852; x=1740970652;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hw2IJtY7IZ4KymZBDBvHYBuimc9dyqnwvi3DV/6wYZ4=;
 b=NVfmLGKpXLyip0MamXAW7Xd75m/6PgwGGxPzcoQV0tcci2ZiaY2bGdtVKXkDGrRQ/T
 RxlCJ57GWi9vegD70jZUsECqKIyisEjGXNZPigR12TMuDyuik3Ydelamk/VwE7g8jq1b
 GX4HJGSC/5sx5oXjLha0dprwZf4s+70aH8qjyU1QAfssnuMX08kf+DlMrhgcg0HxXPOq
 Xut69YFwluX2lN/a4+pPrIqVrtjjZRTYK3JRSEB+gzK9Af9Uu4J4M9k396kzZbIyHfX6
 hAMCw0R8EPAMl24Yl7MrXpawdfR27CY0oHQPIaC9bu2fZkYoQySLVn/NdPGLC+4EAt/s
 iJWQ==
X-Gm-Message-State: AOJu0YxZ7M+h1TdN8cyLFcK52YJquJVKXqHdZyr9He5L8gmoDPG8TY8f
 0t1rV/jS98nW7+gMrscefDKx0frreXQCOM2psDmIpfvZhHM2eMrw5bGcY8nwZaqw5DtbWfHXzmT
 a04rCb2bZzFwB7VlbaKxjAnK7W0TdQxhg+xE7mrhtGsqtsdWbMwfVaF3S7nQLShapQBcVTtaxto
 qHKCdk5zXqtzXhZF92IqEE5VmkLY4RtEcQkAH4F5CXCw==
X-Gm-Gg: ASbGncvoFmLzWLaeIVuew871dQI45qkTQT2dkqdg6KvKfEvupkZtM07KD2vjIZ49bmR
 fmi6goNndyCxbwm2e793+E1s6CuUf3YFNieqPziWvaibNuE0GlzJ6Wr+syL2ZAq75C26ml9EXG3
 ai0x+Kn8FxnjWLCP6wdaJ4TzIli33xkXEuxz7KAqBaFbwfUfsaBasRTh9dc3vza6fUKuoUhW8mD
 jllJmRQ+OBQ19sKXfTyImRM18kyMmEZdpBL5FaxDOCJPSLZK9TRx8b/ILtgwhbOlTUmaUp+Ds37
 DkyW0fHAZmz+usN+cLglLbwZFAo0DeApud/dz0Qv4VSqycV+Rk73knde
X-Google-Smtp-Source: AGHT+IEvfJYbVNWjl3OPsGEGsSGTWhPVIPMaxJfevR427D7l08PpIR/lq8B+Lpg9LT4zLWpSbTzS/A==
X-Received: by 2002:a17:902:e5c4:b0:220:d69d:78bd with SMTP id
 d9443c01a7336-221a1199349mr166506835ad.51.1740365851678; 
 Sun, 23 Feb 2025 18:57:31 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490c2sm171660665ad.47.2025.02.23.18.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 18:57:31 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2 0/3] riscv: AIA: refinement for KVM acceleration
Date: Mon, 24 Feb 2025 10:57:17 +0800
Message-Id: <20250224025722.3999-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reorder the code to reduce the conditional checking and remove
unnecessary resource setting when using in-kernl AIA irqchip.

---
v2:
- remove the code reordering of the riscv-virt machine since it can't
  work with NUMA setting. (Daniel)

Yong-Xuan Wang (3):
  hw/intc/imsic: refine the IMSIC realize
  hw/intc/aplic: refine the APLIC realize
  hw/intc/aplic: refine kvm_msicfgaddr

 hw/intc/riscv_aplic.c | 73 +++++++++++++++++++++++--------------------
 hw/intc/riscv_imsic.c | 47 +++++++++++++++-------------
 2 files changed, 65 insertions(+), 55 deletions(-)

-- 
2.17.1


