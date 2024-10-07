Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74727CFB44D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrMQ-00034u-5t; Mon, 07 Oct 2024 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrMO-00034X-Ga
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrMN-00051D-16
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728321445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D0gGHSNo18p6FxsfZGAMp/W+mhqxLc6e1bw79u4cBZU=;
 b=jTqyBdJ9sgVTyH3ssy0UyfGAeHfMEtEg4hyD7Zm8mfulEH2NLoiXk8gooJxYqKAHB7e37W
 i2iE9UThVA2la2srYVl668fu2mwtN8IN5oKGzvtBsaJa85NVWUPe+1n/5nfPGDjcyBemWp
 XFC0hwnz+ayvlJf0qGn3y5XhCL2tmQQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-vKXb8e2qNwmxX6hPedPmuQ-1; Mon, 07 Oct 2024 13:17:23 -0400
X-MC-Unique: vKXb8e2qNwmxX6hPedPmuQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8bso29940135e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321442; x=1728926242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D0gGHSNo18p6FxsfZGAMp/W+mhqxLc6e1bw79u4cBZU=;
 b=FmQCffkXqp9oP1LBscXxx1XCBvKDFh9f1yjXb8IhX7CQlwu78wTCKzNPAtVTC6nGVy
 xmSwBvsE8RbQWZl+q4Flei+4km5Kw5TUeNFvePcFIKLWuuTnCV3n0c6XzuO+6UfPvJze
 lWEsA+hkSAg1QQiOikck7hboSnrCmYdYQ7LDRKwtlFcSI23u62YzDxvclSL1O+ae/CQ1
 TVjcGh9aM05vSH3k62e5hk/bDpJz3J1f7+xFrxY2ed82wfz8LZJCtmpX5gNoVrToJBsK
 NjASb18TvU89zLcxbbWCZh+9vbtr56tl4+OynXnHOaAvfb56KmtDkDCmtAvxTcR69LkW
 /hnA==
X-Gm-Message-State: AOJu0Yz8Ka//y7woN25uZT/Wr1XwpZgqbYIz0ZpcuDDnKZrlNXojHSDU
 45xE0omlnv5/dND3Z39hbFvp73tWFweTNUAGOltxB3Z2xiPQzWSxJDvx9LB50UEZB3YWPaiJeuu
 0UFHhyBdBDeDMXb6uXsvT3R/lVuvknD1ojw+f+tkO8UgYaRNzB6rBm6jfBH3Zf3QvV7yuUvnrgn
 F4ZWOrRRDPMjoT8Xa30f/5Cm6soj9dMCLpoR7ZB3w=
X-Received: by 2002:a05:600c:524c:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42f85aa1987mr69200285e9.6.1728321441715; 
 Mon, 07 Oct 2024 10:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdoTjGuJLHgTKA8Gc+exM20JnQCwaQbzfnst5F2wwSvXovNO7S1eIeDypCLRhKfXKVwUz4XQ==
X-Received: by 2002:a05:600c:524c:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42f85aa1987mr69200095e9.6.1728321441192; 
 Mon, 07 Oct 2024 10:17:21 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e5cbsm6101946f8f.66.2024.10.07.10.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:17:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
Date: Mon,  7 Oct 2024 19:17:11 +0200
Message-ID: <20241007171717.1436982-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Right now only Fedora 39 and 40 (with updates) are able to compile
QEMU with Rust enabled. Full CI enablement requires further work to
reduce the minimum supported version of the compiler, and is not a
requirement until Rust is turned on by default.

Since a CI job based on nightly Rust will be needed later on, to
integrate clippy and have a heads-up on future clippy warnings,
adjust QEMU's 'refresh' script to customize a Fedora 40 dockerfile
with trailing text that installs nightly Rust and compiles the
latest bindgen.  A matching CI job, using --enable-rust, ensures
that the toolchain is installed correctly by the Dockerfile and
that QEMU builds with Rust enabled on at least one platform.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Based-on: <cover.1727961605.git.manos.pitsidianakis@linaro.org>

Paolo Bonzini (2):
  dockerfiles: add a Dockerfile using a nightly Rust toolchain
  gitlab-ci: add Rust-enabled CI job

 .gitlab-ci.d/buildtest.yml                    |  13 ++
 .gitlab-ci.d/containers.yml                   |   6 +
 .../dockerfiles/fedora-rust-nightly.docker    | 173 ++++++++++++++++++
 tests/lcitool/refresh                         |  26 +++
 4 files changed, 218 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker

-- 
2.46.1


