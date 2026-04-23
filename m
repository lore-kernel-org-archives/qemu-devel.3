Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B72FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyOf-0005n3-Is; Thu, 23 Apr 2026 14:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFyOc-0005lt-Vz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:03:27 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFyOa-0005ZG-1B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:03:26 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2de831d2b20so5455989eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776967402; x=1777572202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2dxn0WMrqvKqs3p8nkU2X7bmDqRObx6LQxESo5qD6I=;
 b=cGyXB/WwFhGo+57CywCcdmkQrsjfoSf7B/pMqfo/h2/bGdUm6EvUU4kXYNX6Ttizgr
 oX/2ovD809TLK3xLMIlyVoA8kuLV48RttcR9aRqB1ByWX3UKFWxfO5eFax/ohhY3Iejj
 EbL40a5KpMD53oEah4EMjXmMmE3rjn53mOnLjLp/WZo19wKdb4dQeQBX/R0sEDMRe8Wl
 truw0EyB8HAUkuoRIdHas9KdWSI/sONTUSbaBLKprSosFKqd/W59BEprZHsfALWHt/TF
 qglReisLCqLR5AQQFBIuTBpyHHMFAWApj1GaTFxyOs3KDt25MfKIXqzQBgDI+lyMVxjA
 hvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776967402; x=1777572202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A2dxn0WMrqvKqs3p8nkU2X7bmDqRObx6LQxESo5qD6I=;
 b=Op16G8eWB2T9beNPqpxS7DJPwDfq1TwErLI/pEhe8DtSQnA2nfHdRAWIGXjezLn3lo
 rpwfDNXfk66PICqqe0ixF9mBn88ZpUy8JbKNgitu9brI4HHIu0Lk6K/Au1NVWlojKqqN
 CfzhxPWUyD52Q9gg9K5soO0mP/klxOx8hpBCFLOthZKoe1oCKrHI98TcaxU/M4kwIIRs
 IqRx3JRPRyHksw5WTD0WImu3cesytCw9rc0B5K1y+ZM5OJl+Q1k/P8KLFeByzxSBLypi
 zSXDKl99Y0kd2o5R7C8c/owKPrudfZqRQLPqMVNiT+uTa2PS5IB2Cmuh0OT4f6gbRg1b
 y8SQ==
X-Gm-Message-State: AOJu0YyP79JF4gOLVyU8yJhhBCzl9OhddPvTJKDcQwEvdqa/fjFUSf9z
 DW0jBfGtL5R9KKpEBwGdd274mJM5Mcf2LAnpEXCRbhpg1jF3nhrGsHFcbnpehlaq
X-Gm-Gg: AeBDievjnHQ778VlKPaZavrXPAgrEnOgXS1PkADKJbKOH4OY+Sb8kNevDtAjxNRV0Bd
 NS+2cyxllYKZqjB9tvEqkMB9RVrz3HT6GRN5KWQaMXGkQ8rOuJjTWkTPRSF3roiT4MYsNqaNLTO
 zJQuSIbB92BoivfAMrxepCJDkVEZKkndVFuiHH6mDrJgU0WeI/5U1nqV1rLM6l/4oPmxJe4NbdF
 zAiPpkQZSk1fMuJISw8k8zQB8DmpoHnMBK+9aAiVbZOxc3jHRfFUp55H/BAuAZc6OnV9eY63RYF
 QV8PZ6+jtZqJHdNiCMlNKKPqi1adX8eD6b+shEBJlsU+KpxfZ5Q0+kM3rgEFg67nBFNVTmbSSW/
 mQqWzxW7hRfRfQZVcl0gALfSY2ldgjK7MKWkU+QXS42i3+8tfbS4uFcnc5Ni2YKjcwbO0d7Bl1t
 fb2/e+VXktTSI2lS2l3SHxJMx5hUlYDIrDV7vSxGUyLu6osejDQoSDDg8NA41g5SuM
X-Received: by 2002:a05:7301:4094:b0:2da:a813:a613 with SMTP id
 5a478bee46e88-2e478a31c4dmr15139257eec.22.1776967401760; 
 Thu, 23 Apr 2026 11:03:21 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.177])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53dcb487bsm29131271eec.31.2026.04.23.11.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 11:03:21 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v5 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL
 display
Date: Thu, 23 Apr 2026 15:03:15 -0300
Message-ID: <20260423180315.53821-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317182049.33848-1-lucaaamaral@gmail.com>
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132d.google.com
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

Ping (second). This series has been on the list since March 17 with
no review on v5. Marc-André gave Reviewed-by on patch 1/4 in v2.
Patches still apply cleanly on current master.

https://patchew.org/QEMU/20260317182049.33848-1-lucaaamaral@gmail.com/

Thanks,
Lucas

