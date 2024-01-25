Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1A9C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT3aO-0006Bl-K7; Thu, 25 Jan 2024 12:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT3aM-0006Ax-AJ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT3aJ-0006nZ-4A
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so89836395e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706203932; x=1706808732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=59hk5vLV+YriYiITrglneSa9mhMufI4e7Kn6+RlSZS0=;
 b=jVaQ9Ag84uj3F5n1FRBy3mnqukCZo+3jFMJqjAH9haFmzhBgG3XaHVzl91x0qzfp5e
 i3hvYZHqW1kGj21BYDnUs1o73K/sShoTyqpNgPQmoF2m59vGK0Gbp7rgFsFX0glu93JP
 p7P4GHQTpP7CJAEtieQtf3WpZhmw52d//NQrwh8agX0s3JRgFmryTz5oaTKZA5XzwWTe
 NFEQPPDbollke9HgIjnp1ocQvq0HeSuEG4ewVQtXRBeBmgZRBaae2B+1DIrt2iBfrA1F
 6EUPiDGM4m6zGdDs4GDhaKi05CELPQvipvQO/RvKAcfLMUHD97SzvpPlqZ83Rfz4eggK
 YSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706203932; x=1706808732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=59hk5vLV+YriYiITrglneSa9mhMufI4e7Kn6+RlSZS0=;
 b=OcpNzWBKs6ptLPUkpdLV6dvoZejj5iuDWaGOKPIUstCZU+S0zifct4Q+E9qjqVvMLI
 ORahqOxnXjzQfZH6zJI9P2dPCF+6q12VHEQ9Wggr6uW2oEclGS8sG6fLVGiNbd1veTlw
 4k9NhuJkmM4ac44KHWqD6RPhCXWFOjAvop49SRlaAKoTKIuGAhkIF8x3lGoXHJVpHUFZ
 p0pHE/LnC29whpfZAO0Zk6Uj3A7QDpxD3fk1qQ3WWXa94fMMK5h4LomcbahJgajNYrdO
 kqzN6v2A0/R8JKM1PgjBopTq9DH+u+NPe7u40QEuHjDNTZ1vxgnlsYXI7BGvWu3jNaiM
 dDHg==
X-Gm-Message-State: AOJu0YztjvOhkh24l1EgKeXTHXS6xPe1zk4HfeeAQZ7TEEtUONGVhxrL
 HJcPAr2vAnRgCzdMrhHSKbb6UdyScd4Uuf5mxsqS6+dS1bVb46tYyi5GyRRNkFwxKDWvwqPpw5j
 T
X-Google-Smtp-Source: AGHT+IG0DM6x0aF9JblvHUJ6njeKLX87za7UmhDQ5kQR9S2NdsZigdbbwW7N02S64y5Gt9g01e75eA==
X-Received: by 2002:a05:600c:3514:b0:40e:7232:be0b with SMTP id
 h20-20020a05600c351400b0040e7232be0bmr53461wmq.12.1706203932091; 
 Thu, 25 Jan 2024 09:32:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a05600c354d00b0040e45799541sm3287805wmq.15.2024.01.25.09.32.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 09:32:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Enable -Wvla, forbidding use of variable length arrays
Date: Thu, 25 Jan 2024 17:32:09 +0000
Message-Id: <20240125173211.1786196-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

For a while now I've had an on-and-off-again campaign to get rid of
the handful of uses of C variable-length-array syntax in our
codebase.  The rationale for this is that if the array size can be
controlled by the guest and we don't get the size limit checking
right, this is an easy to exploit security issue.  (An example
problem of this kind from the past is CVE-2021-3527).  Forbidding
them entirely is a defensive measure against further bugs of this
kind.

I submitted a bunch of patches to this effect last year, and
the result is we're now down to just a single use of VLAs, in
a test program. This patchset removes that last VLA usage,
and enables -Wvla in our warning options, so that we will catch
any future attempts to use this C feature.

thanks
-- PMM

Peter Maydell (2):
  tests/qtest/xlnx-versal-trng-test.c: Drop use of variable length array
  meson: Enable -Wvla

 meson.build                         |  1 +
 tests/qtest/xlnx-versal-trng-test.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.34.1


