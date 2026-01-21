Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA25C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigC5-0003lD-CX; Wed, 21 Jan 2026 16:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigBh-0003hC-KA
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:56:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigBf-0002jZ-TI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:56:29 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so9421675e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769032586; x=1769637386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RFQ5tLsE4Pvp9hwTYhPk5yuRFAPBbf6vBV3ze3TZIK8=;
 b=YhqShzgF0MH+DU7aOHW4TpJtxHMwcS/1GEaym0D69MD4MtXBQAmTWGW9jVr/JDCFAU
 IprwMuIji3M/HcPeiQ3roELdEVIDx2naG7zYEkiOukpeXBZ+ZxI4OiGtQOA96BGT4X6A
 x4EpUL/3FBKioTvnPStK6odkPYOmv+RXDe2iqVV9iB7r3eBIlw1FkpZKeu9225D385wd
 Hw6+f8Mb19Crb3lN7r/HKg9fr7ckPEL4KrT/Pc+/uAqjSXM8wKAByTh3Ttq2UAKr0s20
 ahQt3zpCM90nuf+wnau490rHKCtbT1lbkYfsXgh7GWvF9YkBaxnP+dySRj4xFpd7CTOX
 11Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769032586; x=1769637386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFQ5tLsE4Pvp9hwTYhPk5yuRFAPBbf6vBV3ze3TZIK8=;
 b=PEXWtdAS1k3U3IdmcWDNYW4jOET4rMaevUv3T5QqR+Ajetzpgz0Aml16BWR9zQ4UgN
 gGYP7xMAuTRgIwJbLR2FK2DbmjZp9QIbF+3GgglUvmLGsm01I2v5bG45XyMjREud8riY
 qCE2TdqONKjkZ4GMfvgHqQirV5RPF5t/dGASIlmkpt5FMQAcbvo0mlGeo6NLJwvmt6Ah
 RRgh9tKSDPDqbKDYuwCN9hE9jvzCkF3XMUi+tMnReyBOAfLuJCB9pek6tm2ci0s72r/w
 1EvG0UkoKl5zWcR3SZkDU1xy70qeemzrDOQA9YEaMyALbe+fd+ouiZg2vtmt+LlGMC5a
 Yh4w==
X-Gm-Message-State: AOJu0Yx1NxRr1AE1UoFixa9AyjYhPh9EqV9rdYvlu8qOuPIk3qz1gopj
 DMSblo4iz2maL8el34tUGhqbJfs4WQXjEB2CbHh6tuAgbGoRzAjiPdEaJNL8I3BE9xb85+RWEPi
 nNxz/8Qw=
X-Gm-Gg: AZuq6aIvbcGHqsqbfnGlP6TmVWc1zQ38AgSrPqzd4alY7jvfTrvnEPobkl6k8Hm0vIM
 rVr3Ka3M/i24knJ8X2gEp3UdwCOV9/OWjWWm4v+blCELPTSkF1KX/h7TcTKWLaSUQRjXbIvvzzX
 WOR/8ZMIwxGv2eDZdFONgQozvWxPidjX327/ncZNahfp1Y6pIPW7wxtsORVIGc5vJGGSqZp7oA0
 +dg21qzxBam3ASl9P2AuSDw1fRdOz/jqPCkGAn0xOC6EUUYyazbelIOYoU1KcqmNEgNvtq5GsdY
 5aGmJmHexINyieZHsQ4SX6TAadXqa2b0w5Ma2gb9nau1ifM2Dl+QBvLH5QnfKL4dkJxCYVc41gh
 4Vm7M1ZHnALmmDrnZBNjy7weYlt1BoZvlzBwMJikAKYz6xuLGymnbLGPgcf7tC9EkQwY4weFvG9
 VEACw0HKTk+BnC52rNdqnbDAhHWlo3u9S9OmqNGDCgCjw9kHZYjkdiVzysLLI7fLIP2/Qt3CY=
X-Received: by 2002:a05:6000:25c2:b0:435:9538:939b with SMTP id
 ffacd0b85a97d-435a5f60043mr1736192f8f.8.1769032585740; 
 Wed, 21 Jan 2026 13:56:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597719d1fsm10503951f8f.23.2026.01.21.13.56.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Jan 2026 13:56:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/2] dump/win_dump: Build almost once
Date: Wed, 21 Jan 2026 22:56:20 +0100
Message-ID: <20260121215622.92966-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

v3:
- Dropped Nikolai patches, rebased again

v2:
- Rebase on Nikolai patches (included) to avoid rebase
- Add Kconfig symbol to only build for x86 targets

Philippe Mathieu-Daudé (2):
  dump: Abort in create_win_dump() on non-x86 guests
  dump: Build stubs once for non-x86 targets

 dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
 dump/{win_dump.c => win_dump-x86.c} | 20 +-------------------
 Kconfig                             |  1 +
 dump/Kconfig                        |  4 ++++
 dump/meson.build                    |  3 ++-
 5 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (97%)
 create mode 100644 dump/Kconfig

-- 
2.52.0


