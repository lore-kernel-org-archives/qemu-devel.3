Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B786C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkpe-0007az-SC; Sat, 25 Jan 2025 13:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkpb-0007YL-SA
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:24:31 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkpa-0005lU-9i
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:24:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so32838185e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737829467; x=1738434267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pH3VkzWRrKZh00NIZob72P+uiwg9X9nJj4i2oUk43n8=;
 b=OzA7OUmcQJ5iNzM+n+76RzQu9y3dSElehfvJH1UqWTRdXGHtWmmCQqz66Z6FoXW9bz
 WAtGjrgkpwiNFX0ez9Seafbmig081G3h6Wqpy/vbFQEu1qFbzwZVmoeRAIkho4ShlkTr
 pIowzt7ql77XQyr7Fdpd+Xk60T3Us+8pR6yU7qebAiFLmYnHb7XOuEdSllpSbo6k/W3K
 oSNq7YD2/m+LsVK56ECH3YrE7K0v+cgrqMAKta6SM+PDBb3k+Zi4yd072ncJ9S1NL4Ip
 Iq4a/GDpNoUmeDJdRIyTfSoHAfqc+0c0I7+z0wghpOcO6CVm8QtXCXY+VmiqKe9lrr9Q
 HXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737829467; x=1738434267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pH3VkzWRrKZh00NIZob72P+uiwg9X9nJj4i2oUk43n8=;
 b=EnlGvjU07avSIQuRs6wwEddDrxpJEPA3vF4p46sWjYgWrgkJOHslWSzB/gQYd0GHgm
 UqU1GHuM6sRDq55uYQYg4s+rn5VK7e4b1Lu8oe1QRBvYWeL8IJR1cv5V+FCRCR5dorNy
 ITrz4eHWQexRcRuqqEtFO0yXF+TWTXV6F5+WU+2t4/AWM2PY3H4cy/Go9//WoHLS//d+
 Rhxq6RWToIKQDusZqfA9A7WXmCGcP2vZvAJ+r1i2mTOXKOZXXufe7/UDRO20npWBhKcD
 A3PArcvZr0O1rrhVl3o9iyoCHdl4T2Fw6uuJH6whh0wRt2hvdUycc1ayNPLy5vs2Sq8R
 3zgg==
X-Gm-Message-State: AOJu0YyJR5SHWJWfGVW1hwRaHHZ3DBmys9PZ1mQzCpNkD1N3pspaHkKj
 e+YkPD619MWOWybzoG1t7SUxKlRwKA4k0Zxag/21rRHMlJitH2aKPe7jNqdDdQe49GqL6imb5RB
 JLsg=
X-Gm-Gg: ASbGncub49oqYhCJJ69k95xTi6yrNzvhDAj7t9FWnNvzJRJvozUhAQNMonMn5HNV6EF
 wPMQsj3mkTTuk71tsacR0GGDiYiUjBaLAnlXp0GWHY5+Ksvv48Ym4Eo/Rh8cAHzAAlgNm5tmAho
 28m4B9Q9uyiWOlpuHGhrx5YxQhUpM+iaYX4JbFFw23T8n8FvgvsNlZcSdZwQhe2lJijpSdIBkAm
 Fzy5nZP0hhZ6PAALDZNyc7ms7kqBmBWyLJ5V1jdBL69hay+Szr3wsUcoB1Y68NyNuDIK+Y0bs+E
 /Ke8LjxUlevE7SoZl3NEU1Y0qz3jw1LM6KyuIuLepzz86Qm+e8nB9AvDVucV
X-Google-Smtp-Source: AGHT+IHB5Fsi7Lh6m6f08iKGCCTXgfwFX8GZ07kqZVQQkfWrLQoj29fPMPLVsRikNmK1GyhB8/tHug==
X-Received: by 2002:a05:6000:18ab:b0:386:42a6:21f2 with SMTP id
 ffacd0b85a97d-38bf5655f8dmr33689314f8f.10.1737829467675; 
 Sat, 25 Jan 2025 10:24:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176538sm6045863f8f.8.2025.01.25.10.24.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:24:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] qemu/timer: Clarify QEMUTimer new/free API
Date: Sat, 25 Jan 2025 19:24:23 +0100
Message-ID: <20250125182425.59708-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update few QEMUTimer docstring and add a
sanity check during timer initialization.

Noticed trying to understand leaks in QDev
Realize -> Unrealize -> Realize transition.

Philippe Mathieu-Daudé (2):
  qemu/timer: Clarify timer_new*() must be freed with timer_free()
  qemu/timer: Sanity check timer_list in timer_init_full()

 include/qemu/timer.h | 12 +++++++++++-
 util/qemu-timer.c    |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.47.1


