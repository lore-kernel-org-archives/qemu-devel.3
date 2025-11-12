Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4642CCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIyr4-0006Bj-BC; Tue, 11 Nov 2025 19:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3o9YTaQcKCu4dQlYTUcWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--navidem.bounces.google.com>)
 id 1vIyr1-0006B0-S8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:36:56 -0500
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3o9YTaQcKCu4dQlYTUcWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--navidem.bounces.google.com>)
 id 1vIyr0-00034P-Dd
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:36:55 -0500
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-7aac981b333so261732b3a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762907812; x=1763512612; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=XF5QCz2w7Wo8yveXbpKLKcqlo164Vd8YBvUWimrXBjE=;
 b=rP9Z3YMbWd2X1RNeLnWb8ASRc6TOeAEiwRGUg1JgcLCyw/OCdbBI3kVJvNvdrKK+Sa
 wpqcUGDWS5jYzjbcsfi0eifbw8Dy8fnr1saDgFZd/4pUQ8y97ZCMCOUtCOKm7JiV9F6k
 bC5aS6yu2S+s1/ewNIbp9dIjoNveaAo9mum6isv5iCi+iAS+G3IJ/6ai84YUNn3vENOI
 cT77amD6cRR82vbSAZ00DVXOiAQlQchtbby0aOzB3OpO0ZroDK2bsds+dlYpKVusaRrL
 qhl+Y7SRySN45Zy3bikcse/c2/qU7HhkqzL5MZsQmzuOuTcKAHWiW9Ntt7s1sKSnFd1V
 tcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762907812; x=1763512612;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XF5QCz2w7Wo8yveXbpKLKcqlo164Vd8YBvUWimrXBjE=;
 b=n0GYNXRULtNp6LX/hIVJJvs/dkfx7zCXEP2L/Y0RYhJmLc1nQFRxyDSCp0ZR2nmvt0
 N5ojtqJR+0eEbazq322zLbtkav3oE9qnze4p2Y3am7KJg64A+uQ9Pn8Cs8eQrk/uXH1c
 jCh8mSHO+OAI9OZ354DWHby/jOBFd65gw/w+UvPb06b3Ab2JRdBGEHCekf1V9KTRQrHI
 gHlUiKdD9w47FwwZ6WxCg2CQrzeddtzpZaMilcUtjUw0rlYlJkI5x6HATtvzlsmsVdwC
 +DJEp3V2rH6o6P35RH0Gbee56FC9YqK4p8YuZ9eaywq/LA+JasvSKJb6VA/GK0vVDzoD
 S8Iw==
X-Gm-Message-State: AOJu0YwjgY8PtjPUKuvGXg9eZU5EEULuz2aQacL/ky1ORi6oSh0aqNNm
 tL7ZICuWwitNqVbARB+0PXNXZISv1pBWpzcnSLLla6n3FCwiNHKAqFKyxtzXCnsNt+m7+07pMGM
 jzWzd+1ef/VlmcKl5TUF4MQs/lJYbEPmy3rE6pHL8E3CFU3ocDZ35M0Y3hBHz1SNgbUJbM0Dolk
 Vwc0HyRpA/l7QCRWFPEC8/RWask4fu2RufOEgMTkOv
X-Google-Smtp-Source: AGHT+IFS+1Awe2bHBIOX7bvu4irdyzEUVoauRgyNdy7p3tcZKtmIc7NrsywyjiEOebeZUz0dNod9YOrNm+2S
X-Received: from pgwb19.prod.google.com ([2002:a65:6693:0:b0:bac:a20:5f16])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734b:b0:342:f5bc:7ce5
 with SMTP id adf61e73a8af0-35909b7598bmr1141283637.19.1762907811624; Tue, 11
 Nov 2025 16:36:51 -0800 (PST)
Date: Wed, 12 Nov 2025 00:36:36 +0000
In-Reply-To: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
Mime-Version: 1.0
References: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112003637.1984547-1-navidem@google.com>
Subject: [PATCH v3 0/1] tests/qtest/fuzz: Add generic fuzzer for VNC
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, alxndr@bu.edu, berrange@redhat.com, 
 pbonzini@redhat.com, bsd@redhat.com, stefanha@redhat.com, farosas@suse.de, 
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, lvivier@redhat.com, 
 zsm@google.com
Cc: Navid Emamdoost <navidem@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3o9YTaQcKCu4dQlYTUcWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--navidem.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alex,

Thank you for reviewing the patch and for the excellent feedback.

I've updated the patch to incorporate your suggestions. The new version
uses the generic_fuzz_config.argfunc mechanism to dynamically generate
the VNC socket arguments, which aligns it with the existing pattern.

---

Changes in v3:
- Removed VNC-specific logic from fuzz.c
- Created generic_fuzzer_vnc_args to encapsulate all the logic for the
VNC fuzzer's arguments.
- Used g_mkstemp to create unique socket paths.

Navid Emamdoost (1):
  tests/qtest/fuzz: Add generic fuzzer for VNC

 tests/qtest/fuzz/generic_fuzz_configs.h | 50 +++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

-- 
2.51.2.1041.gc1ab5b90ca-goog


