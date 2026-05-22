Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B9FCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMt-0001Vc-JU; Thu, 21 May 2026 20:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMq-0001V4-J5
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMo-0003En-79
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so43973095ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408231; x=1780013031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PDGuQ2v76g5jAoiknd6c7KU2tqrx5VzNJSrO3FkLtI=;
 b=UR6GV6NVGW/6Fb2SAmpAHuiU5X3ucSKLSkRRZZCWNnfgFDS3+rPC9pIF5Qouu6oNgF
 ydp+u3yWk0k+xUzmLt0SPyPTPG6UJ1kz7z3b+d7+wYVciK5bsED8sJBimpt8N29k1Vrm
 +Eiu4LAlO3nuGFwig2imaTbmxINwb9Y30+XI+ZNQfuWSnD+gGFMfsgJ7r8E8h8BWMnmu
 DknqlVFJogiuG/aM9CLKZO4J5WywIe9PUpl1G+acq2ZYl6Majb9bcMoeMG7q5GEE5sw4
 yjPXacnHhBsHXS3tC4fn3gjV9zM95wrNdfYbpQT9D0fRUPNXWGs6xuv8QznuAU7tXHIj
 LuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408231; x=1780013031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8PDGuQ2v76g5jAoiknd6c7KU2tqrx5VzNJSrO3FkLtI=;
 b=G+BqyHg7M26F8qaUlZSueA8baD3BQpXi55dB8yj+o/+sGTvSaTR5UuWHgdu0+TV7cT
 /iShXQgKUoiA+FpRCKHZOQ/rFIoUq7Egr9YxHcaf+ANoiOCOk4q+0u6B7jjdH9NFxO7F
 /0VoobsoAVffqZwhaZsMRTu2cCHXeUJ3xQI/ksi8JFjiI/voiUXhvVw/LA/OlCKU0CD2
 KhK6Wr3WU+IsgqDERcivwy02MBRfmdB5kzPi9QEA8YNFfQy/W7PJUJG8f7jfP9vJiNhH
 xqCXVLyCN4VlA+7imWGe6UCQ3SL+2x46xqoQxTcHV8d0oUV/JmVekFzU6hIQ9QmHkDvF
 82gg==
X-Gm-Message-State: AOJu0YzsHytxhtQf3NEGWJKtqRAF49dVIE35uqBqeveGjw1gG1ZyOU9q
 GmOzfkb4L8MPCVS7l1oqfZzZODpuva32UV1p6giAcvDy3D65/fs0ToibrY/LClBN
X-Gm-Gg: Acq92OGmNwULvoBZCbK+1BVcDSpKZ0EtCs/9HIOK40v9sz4qfDtpTVSTwOubN/gPFVl
 TY4k8d15w4O/vgGPcGyeX4lkr7kOuKQ4mdPbWJQPoRtUDJ97EZMopmIQbjD4Etp6We5+hvm3Gq5
 hM4UttqPCdRQv9W2ZuCKUeBHmgiIyRwWEPnZt8bvZWJkjW7aWl1A31pYMvw0uMsWcfUxVQ7i+jM
 pnJI5VwXZLpxBNHqhL/lg2yCr87uetV5ajcQc8ZBfcjuHF54XFtnhuCveotMCsqcM0MhiUBZPLQ
 9C0DCbqXZ7X2s57pK7MSuh5mwQ78HTj45fPH0ihezUS9qMFA21C8m+nPAtejXgWDDyhcSiDsRGF
 Pdk4Q/GcCCRea6bCrrd81K8TzxOx4UiprG9tPhloU5ywPrdcq5TNwmFc51lrsYZZqNtZtT14I8O
 Fz74tqEnO19r/pcYajfb2x39bVWThGa8e7WtYPUeB42w==
X-Received: by 2002:a17:903:24f:b0:2ba:4e84:966 with SMTP id
 d9443c01a7336-2beb06dc34dmr10809255ad.36.1779408231501; 
 Thu, 21 May 2026 17:03:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/48] MAINTAINERS: Maintain OpenSBI Firmware
Date: Fri, 22 May 2026 10:02:41 +1000
Message-ID: <20260522000324.23255-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

Mark the OpenSBI Firmware as maintained by me (Alistair Francis) and add
Daniel Henrique Barboza as a reviewer.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260506234243.1873782-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a90daf0308..cd5c4831e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4055,6 +4055,8 @@ S: Supported
 F: hw/i386/amd_iommu*
 
 OpenSBI Firmware
+M: Alistair Francis <Alistair.Francis@wdc.com>
+R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
-- 
2.53.0


