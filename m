Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3105AC02193
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjbx-0002Dz-CO; Tue, 28 Jan 2025 06:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcjbv-0002Dh-MY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:18:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcjbu-00053e-2a
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:18:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so60235585e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738063103; x=1738667903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fT2SAbuvKPbKd3z1KkDvR/xDsz8I4RjNHLW+g3/uOgc=;
 b=DpQolaraCLV3AclTON/VVQ45IG/6YQvEHqRRsPX+TagpLt3zA8WA9ta6wd9FTdYfNq
 tgbDozPQxkXBRFP6pqDqICmAMrfsIhvHwKmTtrvrz9nFxOLVEKGMfcWjVcmPQq0Y3VHT
 8SlqKQ+aSjzlqymL5QhdXw5QrPTdIE52+RI3nizj5ADUIbtCfgFt1MoEo6fo0F/rtdEK
 F/LTGjY8GGIFCM5xPBVTAVzaO/KDCPGqnZsz82AlBCYy+Szptc8lJqxcQ0KgAVjYHUzG
 ZiST8tMa1Upf971ZPccXsWJDv3rizWi380ebc1GHAkVAwMa6EDiR+V5eD7nNWpT+H50Y
 bHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738063103; x=1738667903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fT2SAbuvKPbKd3z1KkDvR/xDsz8I4RjNHLW+g3/uOgc=;
 b=B+r5H+Xu3tYBLgEZMUfNlPnBZkGpXF0ZGM4DRMotDS+gBZVMELFbdTfSkSIApTS5B/
 7GLPVJUunqhKeZ5c2tzwDC/kYq1nqKkQ6tS7agbPWJqPjfzC38Cmnk/PqdyS1t7A1zGE
 Nbp9G5rLolVtmOEL2DM6i2BUvt5rFrv/fYniGrYgQfs3oj35q/I6C+Qwyp3GMtF7WXUe
 QCgn6/y5ZheKYENpdwJ6QybA6k9RfQkIcXmNSUO3qvC9Z7m5PQkKSZxpuu/JWaN+ddkw
 Ph/XXI88XXVhDcFz1TB7P0UCs109bSGeqrJ/OAEeyHj53b51HdTPDFu7oRgldxl9PqqP
 spKg==
X-Gm-Message-State: AOJu0YxFZ7RsIc4CYTD5uHsOL+dDZuoucFM9ek+XS5Iw0pGN0jxcqKhC
 dgqOyevttPnIZHSreLzvUVQssGYVdi11u5r/BjrfxyUU3UigiDsg06JN6OcSrWR+5Gb4UD4c/3x
 5N9s=
X-Gm-Gg: ASbGncsRRFb+MXlL+WDw/PtaGzMNruJgsJJPBadTZnvWq3bZRECur9WRWR12MXkqHwR
 jtGDMP2ekLOPAofvR3YSmu0hTMkqogau81Wq1WtAklzlmpFrzPl38mYfoElS6LbVQjuz/n7mwBF
 8/0WCTixTwqNXAuvCO2OuBJxnIfQH/g+xYZcpeNVU5yK8Q06pcaDJKJKc5f87LNyTbboITi2Hmd
 rnDFATJAnzKXLr3dxuuBgd+kYuNmIehj3tfPbVuykfpkcXWzpVJn+/+ej+KlyOK73dNde2ak9a+
 41q8DL0/KvRRpk3I7z0frGm1hQ0tH4TxeGZeBVKs5E1rli8GSTnzP6Y8CKedC8AzFA==
X-Google-Smtp-Source: AGHT+IH+qdHcEoJcFpOtnVud1J3WbJAaKIWKl6fv7LCSJoOys54P6jRa3uzMWf61KKffEYTlHNPhxw==
X-Received: by 2002:a05:6000:2a9:b0:38a:50f7:24fa with SMTP id
 ffacd0b85a97d-38bf57bed8emr46915786f8f.54.1738063102960; 
 Tue, 28 Jan 2025 03:18:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764e9sm14028356f8f.17.2025.01.28.03.18.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 03:18:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] tests/qtest: Make qtest_has_accel() generic
Date: Tue, 28 Jan 2025 12:18:19 +0100
Message-ID: <20250128111821.93767-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

In preparation of running QTests using HVF on Darwin,
make qtest_has_accel() generic.

Note, this also allow running other accelerators such
Xen, WHPX, ...

Philippe Mathieu-Daudé (2):
  tests/qtest: Extract qtest_qom_has_concrete_type() helper
  tests/qtest: Make qtest_has_accel() generic

 tests/qtest/libqtest.c | 110 +++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 49 deletions(-)

-- 
2.47.1


