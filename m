Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9F2E65D26
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELp5-0005XT-WD; Fri, 22 Nov 2024 00:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELp4-0005X0-DK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:14 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELp2-0006RC-Q7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:14 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2967fb53621so1326767fac.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251791; x=1732856591;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/mj5STtdNOKwZ6na2qZV8OltqZ/IvfmSBSoshKYJDn0=;
 b=acyJko6zlt36Hw1UdSvJF907wGo3PFds0UfjpOkXMjKiQbRfvaPt5cmjInKLLdRxTq
 NP+PvQDfkOGLCgBex0xqQpCSy/NbwoJjCL6/H/wXeR6/jPyZ04Yo7aBWw2KDDWK63ZbX
 cu1zZ5CrC+6d8Gv3/h5la7N9laex9b79Y0zzpKenZikFMC828NVDDcrY+B3Dpk9yoGye
 Hc0n5iHlmcOsQXwr32+wWdgn0W9QerjTk24T3u0kfJwxiSL2kFDTWZYAig29ebdzt60l
 Vht0nuQB9/W8QgwtPCiQZrLdUDBR2igasxn7cmoQ7kEDkeAd8d3F2SE8AoZHXcb3TLnJ
 Xy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251791; x=1732856591;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/mj5STtdNOKwZ6na2qZV8OltqZ/IvfmSBSoshKYJDn0=;
 b=i1L87Pb/uUi7HSfwM9odfc7MTJrpokGJF1Y9egSoO2tGYmdWV9WobHB0E2RzAj74bB
 o8vlm1GWB8FL9dAtkTa7616h3NtdkwzwumBvRk/utEH+3eVWWGnVVAoE/2rUk0sShMeB
 RkXdcs2nsbCFTwToxIQVKld3ReOcSm7W1Sjw+b4oTDzXVTjbcvqMpooEwrqqSK//xlsj
 tAMuj2xBAbAXmP+/i5yGnYtxWBgexAfVoCOkAGlC8XMRi+K+PNrTiBM8444gegaPp0OQ
 cu1AuQbF6h5vEy7sIXKTXCsQkvi/IkNh2WGUqz98wsXcGTXJOEowUOkHR65xdVxJ6N3Y
 nR2g==
X-Gm-Message-State: AOJu0Yw8uMZZrBj3YpIq7m25yhR0BysuIUPi/ZeGLJSMGpqIlFxHNA91
 2fyi0lviXZ8pdyUWsacCNlkzAjqh/Lq9K17IDYJu7LPF/QQ6uaDh8usezCqFy6q9rioxVm5z3aq
 E5V8=
X-Gm-Gg: ASbGnctgGt1EwWVoWfgaz94+9i0Nsv0mYQdHdGj12GGKXS19DR78LWgDX6FeCFvuhgB
 EBdQO6WRqeYRqomeri/ouex/6hiH/VYYHDXvu6SoHOG+WIgemmNtcO0iwEnEv6I+AR4Odft8k8O
 56R7uKVWHcBNE3LsY2p4MuWZ5Zumq3Ies1kkooxMy7L6OAlLAUVBU/2ImCrBNrv67Pm15ZdoYZM
 vGy9biEwOVUzSq3J6mmNt/scSTxeZLp3BaMrOBENxF6WofdS8m4jQ==
X-Google-Smtp-Source: AGHT+IG+gpS7u6MGMrYXA6ogX7//f+Kh1FZ+vbo9rb6mwcTul2IueZlyeBd/wAZkCnsT5g6PUA3Wog==
X-Received: by 2002:a05:6871:e7c3:b0:297:5c5:7ac1 with SMTP id
 586e51a60fabf-29705c57b6dmr3276430fac.4.1732251791444; 
 Thu, 21 Nov 2024 21:03:11 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-29724490f17sm229432fac.6.2024.11.21.21.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/6] virtio-net fixes
Date: Fri, 22 Nov 2024 14:03:06 +0900
Message-Id: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIoQQGcC/1WMSw6CMBBAr0JmbU1/WOrKexgXhbYyC0FbaSCEu
 1sImjjJLN5k3pshuoAuwrmYIbiEEfsugzgU0LSmuzuCNjNwyiXVVJHX4AZHvOSlFsooQT3k32d
 wHsetc71lbjG++zBt2cTW615g5V5IjFBSS13bvJqf7MWaqcPx2PQPWBOJ/zSW56vxrHGvqkoYR
 qn0f9qyLB95XH0h0gAAAA==
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Most of this series are fixes for software RSS and hash reporting, which
should have no production user.

However there is one exception; patch "virtio-net: Fix size check in
dhclient workaround" fixes an out-of-bound access that can be triggered
for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
can be applied independently.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20241111-queue-v2-0-2f7883a1004f@daynix.com

Changes in v2:
- Dropped patch "virtio-net: Fix num_buffers for version 1" in favor of
  fixing the spec. See:
  https://lore.kernel.org/r/CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com
- Added a Buglink to patch
  "virtio-net: Fix hash reporting when the queue changes".
- Rebased.
- Link to v1: https://lore.kernel.org/r/20240915-queue-v1-0-b49bd49b926d@daynix.com

---
Akihiko Odaki (6):
      net: checksum: Convert data to void *
      virtio-net: Fix size check in dhclient workaround
      virtio-net: Do not check for the queue before RSS
      virtio-net: Fix hash reporting when the queue changes
      virtio-net: Initialize hash reporting values
      virtio-net: Copy received header to buffer

 include/net/checksum.h |   2 +-
 hw/net/virtio-net.c    | 108 +++++++++++++++++++++++++++----------------------
 net/checksum.c         |   4 +-
 3 files changed, 63 insertions(+), 51 deletions(-)
---
base-commit: 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5
change-id: 20240907-queue-f425937a730f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


