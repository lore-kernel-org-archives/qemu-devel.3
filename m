Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1424CFA47E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3iu3-0000nd-E3; Wed, 23 Oct 2024 17:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3itz-0000me-GA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:28:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3itx-0007ci-Nr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:28:23 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7163489149eso159761a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729718900; x=1730323700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yh1w5tbQ3FNJQ+qQrBU+8HWVpwNff9U55VwWmmd3WgA=;
 b=fg7QZh/jxKfA8VF5e9/9atR00Zv+ntiViGif8zTPYtuXiAGEahb0FgDS9xfOK5V8vK
 ghAqx9kVLNuATVvqt+2HBUYSFyHYNEjqfKJOapXHoWlcZWigfBuyy5fMlIdBOkBmbKdU
 1/tvhxh4sMn0gMWKdUXS3x3oylGbeJn/qX8YZKe3rLhKk0a34qM2gpcJWytT9WXIabf3
 NnWd4G1j0lZ8U2dQcubMajqDJsKkRT/vd905OrkjZ38gV1auniwxfhuXJ9j1eXYnKi1V
 I34uLPcFMGnFJngCJCy8wNU4AHTXxo1EcbbEWSEKBklPlx/xts2eiYAJqw4IjZ8HzeOt
 23iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729718900; x=1730323700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yh1w5tbQ3FNJQ+qQrBU+8HWVpwNff9U55VwWmmd3WgA=;
 b=aiB+F8X9DX7Laq3oeNSkxT8UGxzzo+X5mBknVCLKoIBQ6mLSv9gAqnd3+z725PjVLY
 NOsbZ3EGpvlKdsqv3zn+5jv05rZekTdUV2Yh0YWP63HO2MWGow1Mis77YNKccOGTpRW3
 V4ngbewh+DuT0dCJjh9cZslE2zxYt0MGYCH+I6Zl0lo0lHndHPYvwHmsIMfe/OQ4dkQR
 /24Xh5BHwRSTE+5AldcrvjzRZRcj03RaHCDdINev6VW8rYVoLUaPtQbv3fNVNbSOwozO
 7GWb9UgG35PQotvHVdg5OOsRVm3h+gSrKkf4+B3YHYv1ombwFf0j0fAUmJG74cjKUKMm
 XSWQ==
X-Gm-Message-State: AOJu0Yx+9v4Jy+v93qfBPf8MHpS4NEEHntckYVCtXfCmPbroLoE9i6TX
 O69FsYfCu+Hw0pLQkrMqgucRKRxiPFRviUFS/DVd+MW1/S8zFH7MgN4dDZKArApk7TIVyiZ7Ydx
 bz+FwPQ==
X-Google-Smtp-Source: AGHT+IHPrjfyabtkjj9M/SNSF7ELMiTqfnTxP2eBBzoM1ZRcw3ymDO0CIoUYvq8verzQinORpkqQMQ==
X-Received: by 2002:a05:6a20:9d8f:b0:1d9:762a:ca5f with SMTP id
 adf61e73a8af0-1d978ad719emr4583312637.8.1729718899952; 
 Wed, 23 Oct 2024 14:28:19 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafab5esm7228137a12.17.2024.10.23.14.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 14:28:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 0/3] build contrib/plugins using meson
Date: Wed, 23 Oct 2024 14:28:09 -0700
Message-Id: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Contrib plugins have been built out of tree so far, thanks to a Makefile.
However, it is quite inconvenient for maintenance, as we may break them,
especially for specific architectures.

First patches are fixing warnings for existing plugins, then we add meson
support, and finally, we remove Makefile for contrib/plugins.

Based on the proposal of Anton Kochkov on associated gitlab issue.
Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710

Plugins are now deactivated by default on 32-bits hosts (since cf2a78), so we
can enable with meson without worrying of warnings when building plugins for 32
bits.

Removed patches for individual plugins.

v2:
- removed warnings fix for 32 bits as they were incorrect. They are not needed
  anymore as plugins are deprecated for 32 bits hosts.

v3:
- do not build lockstep on windows (it uses sys/socket.h)
- build new plugins recently added
- fix warning in cflow plugin
- tested it builds correctly on windows/macos/linux

Pierrick Bouvier (3):
  contrib/plugins/cflow: fix warning
  meson: build contrib/plugins with meson
  contrib/plugins: remove Makefile for contrib/plugins

 configure                   | 18 --------
 Makefile                    | 10 -----
 meson.build                 |  4 ++
 contrib/plugins/cflow.c     |  6 +--
 contrib/plugins/Makefile    | 87 -------------------------------------
 contrib/plugins/meson.build | 28 ++++++++++++
 6 files changed, 35 insertions(+), 118 deletions(-)
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build

-- 
2.39.5


