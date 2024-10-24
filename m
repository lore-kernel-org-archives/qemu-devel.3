Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75421CE8E6B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x3y-00046s-FB; Thu, 24 Oct 2024 08:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3o-00044L-FJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3i-0000Ga-6y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+Vr9TnjLU2a58qM6D2/5EPfpLYLf3sVQLHOXY3Mmj8=;
 b=jP/7IfsBkuIdQ2b8MDWBlWXC43i2mfF7pM27SM5Qiml8GOZ17FNjHHo7KYduXTYl1rinXV
 LzsKKx3NKyPfIzz7ygam2hcqLHMqjWah5N84bk04Y0waNt42N3nlalJW68q2gMEkefTDWF
 ZkNjRUA+BilL6Hv7fnCFD4yM0lE+FOs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-NWEwh1eYPuWWG0-rBhUz4w-1; Thu, 24 Oct 2024 08:35:18 -0400
X-MC-Unique: NWEwh1eYPuWWG0-rBhUz4w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so472089f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773316; x=1730378116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+Vr9TnjLU2a58qM6D2/5EPfpLYLf3sVQLHOXY3Mmj8=;
 b=KiGYAi3ysongmIBymH96dvfErcvXmf2mQ0PphcqyvfxgfjKSyouZNhJQ8DmWAOF/ru
 MTjGZjYk/UHQDdR3LqPN6Ql1PYE/F6jAug+EmX6WWHTny4jg3V32Cf7kzPgQGKtnjQvj
 Qp7UMEhbUY9DqGlXV3pFCvVG4TCvnacCZ/WrEbb+MO4Igi3O3UTftnSxNIzdifLbeyQ8
 OBQ/ID0DeE2yRnLd1hWa21+vY5T9fDVJod3T1IG9bNTE3QmciEs/8pXgwC07lVvVkqpg
 4FAF7WsfTUIfFDJmbj0K//v3+hhOmMTTYJgNTojGvtwzgJdHtN/VGflMPZnWg3AiaPh2
 E7Jg==
X-Gm-Message-State: AOJu0YxCEVbwgeRyz8K95cHyUMqbmWzIhNSPfb1SQJShHRgMh1WZTEQm
 Bfw4xBxI2eTXRx3JH6fCs8vQ8Q7S5eDuIbTYb4hjQcENaSaDPcm+/uFNVg/6Ae1v2m8KZQpzI2z
 dxZpiOSQLjq9FOkkYjvQsXka1PLiq9A99g4+AhxZVQ0CfkfJLTQxcrQuNLJE8qCgGK0KxA7rUU3
 bzHSmzAjyDbrTQsIzQxS+CWy+0O5jIAqJpDlVL9dg=
X-Received: by 2002:adf:e9d2:0:b0:37d:5282:1339 with SMTP id
 ffacd0b85a97d-37efcf070eamr3848254f8f.22.1729773315749; 
 Thu, 24 Oct 2024 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxcjOSz3oNAY6VJ5ana+D4U6vJOiMG0aZ4VJxxxDOwIDu05XhzApGjxglWUG8GKHlEnGRsiw==
X-Received: by 2002:adf:e9d2:0:b0:37d:5282:1339 with SMTP id
 ffacd0b85a97d-37efcf070eamr3848235f8f.22.1729773315229; 
 Thu, 24 Oct 2024 05:35:15 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9c6b0sm11171449f8f.109.2024.10.24.05.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 7/8] scripts: remove erroneous file that breaks git clone on
 Windows
Date: Thu, 24 Oct 2024 14:34:58 +0200
Message-ID: <20241024123459.59350-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
References: <20241024123459.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This file was created by mistake in recent ed7667188 (9p: remove
'proxy' filesystem backend driver).

When cloning the repository using native git for windows, we see this:
Error: error: invalid path 'scripts/meson-buildoptions.'
Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128
Link: https://lore.kernel.org/r/20241023073914.895438-1-pierrick.bouvier@linaro.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 scripts/meson-buildoptions.

diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
deleted file mode 100644
index e69de29bb2d..00000000000
-- 
2.47.0


