Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DE7E68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQh-0003e4-QT; Thu, 31 Oct 2024 00:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQe-0003bP-Tc
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:00 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQc-0004pY-UC
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:00 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso388287a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347497; x=1730952297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njeHlPS1UvDHI0dHkOZk8rvt6i94v/W7laKq7UySnIM=;
 b=JzZOmVclvLooWgo5QSYOns/4x7NWLfWP9GnrYGq6tbRg/jmYpamxy9dVB74mmwY1t2
 xgp6MtCeIxL6YyFPeFzQww+4LZDNP41oDmCp0XI4yYUOqFTVzKBJtNtj9qz0IxEmfWax
 zXvZyUuiPNDChNmdnJbDQlIB4Ny0avqiZWfnmE1viQuk03rPLOgTFMp0auZx5k33c/Wx
 cXyfd0wh7HJtxCRgrUVcs/dBQ0n8r3sDtwyz8XoVChFRxjl99kVE+76WNgHZgbjDL/rZ
 zn+gAyL6SIzZ3S8cEN/4njWV8LEYJnfkrRsDKVhtHSS1ZRWFApEfEWV3d1m3m+2W1f22
 9WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347497; x=1730952297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njeHlPS1UvDHI0dHkOZk8rvt6i94v/W7laKq7UySnIM=;
 b=Qro7pbAbDBWv1qdrotRrarUZAdn8gqjsPQ2KMWz6tQscwEOcp5ED8OklLtkiGnH8df
 Rc0hYnDGU78lutiumJKvQyQ5iC0UUMPQ9gPpXbwrRl65o1TRuJf/IDCOqVckInpTQusP
 c5KtWJEejviKb2ZsoxmpCNsTGFwqwrN6oBiyoaRk3JKRMSVTXgFaPSDACOVWcnp5WCFV
 UwGORe+HBSQeyd1lwk/ucJvEwvDYCWLq/KJvyOHH6/aclquPZ+s57Tz4Vu3DU2TUdo0z
 adu8jL76xxSx52U/jrcRGlA485rjF19mHscU/pHmuem+jXbMEzfEtSI5BtdNSCSXmxUF
 36Bg==
X-Gm-Message-State: AOJu0YzPLK9k2uv3UgrLaUCKLF+0HpCUT2ypXnUCStTKi+Hlnca0ETHw
 3Jp/XjZeDzNH6oZkXWIqhynDmhBh0t219wqcQp0AGIx45iFyI/Sf/1abUMCPyUYa8iR11KXrKIi
 3XtVWOw==
X-Google-Smtp-Source: AGHT+IGXvHOS0yU16i74618zHhJXoSd4NN9X2CvpmbDDMkWmfg/y7mI5sERLC29xPOX+IyUKKhQ/3A==
X-Received: by 2002:a17:90a:df0b:b0:2e0:f896:9d6d with SMTP id
 98e67ed59e1d1-2e8f106fd8cmr19013294a91.16.1730347497564; 
 Wed, 30 Oct 2024 21:04:57 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:04:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/12] scripts: remove erroneous file that breaks git clone on
 Windows
Date: Wed, 30 Oct 2024 21:04:15 -0700
Message-Id: <20241031040426.772604-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This file was created by mistake in recent ed7667188 (9p: remove
'proxy' filesystem backend driver).

When cloning the repository using native git for windows, we see this:
Error: error: invalid path 'scripts/meson-buildoptions.'
Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/meson-buildoptions. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 scripts/meson-buildoptions.

diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
deleted file mode 100644
index e69de29bb2d..00000000000
-- 
2.39.5


