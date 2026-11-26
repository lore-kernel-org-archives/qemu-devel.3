Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06538606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=glzsuvTL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaa8-0007aY-HA; Thu, 26 Nov 2026 09:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa6-0007Yz-Rv
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:15 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa3-0001eq-J0
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:14 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so6611679f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795703769; x=1796308569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=13GD1T40aUPl/To+BZkSLtMp9pchyXRus+oaugKqoHQ=;
 b=glzsuvTL1CoL5djUmO6JawOAjFdBg6ydmYHQmZPiX+JtVSL+Qwh/yCI0YK6dgxSaCY
 zkjSDf/2XYkshgXivyaSX24tKWoRMXXl7cwi1KqJyL7Dhs9mZrTDpY/hfmf/Vp0zaRTm
 fKaFtz75ocpXAJyTP/vpGSwbEIVb1pZjVtlaNc5gvEz6MVApLCbT5V3iZUzK8ELM9FnN
 24HXhhupOVykCFOemyMPwMMSma77hrSWISed+1a+jtT1JDXTnn0kcEgGxzFOL/Jw/Mtm
 AT7iojp72zyScUkysQC/gqJQcbz+/bHHkJWP+WY/ROjZHDBbo7DOE37XdjGRHXgS6FGW
 r8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703769; x=1796308569;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=13GD1T40aUPl/To+BZkSLtMp9pchyXRus+oaugKqoHQ=;
 b=qRb/VUy3XqNj6C56I5SlbH4WPsSJv9wPkci/2oBtAgTlRSEjPpD1CCdcwoTM7D/tcu
 ZuwECq+YC2bL/456BjyrHgVrjaDdgWgPswxcuB2vHadaYp0aZT5jvtYW8M0GwTaY7lyn
 6N6sN1afQLqLMls24BUqgcj7QeCfZnivdRMTohPMehN/nIVyytKzrmh8hxf7za6otoIZ
 VTSqSUPYupy63qYdNYAattppeDMygKviOQ2ojYXTBGx58eGn5JcETQaa2JoabA+y+Gs7
 q5RYhtopz9bOEE85Y0Qvnx1Wz9ihBYwNBPZ3jiTXESPcUu8BHXjtFmaKA4enmCkc4Pvy
 e0lA==
X-Gm-Message-State: APuU4Z/zHSvOOaGasoL4OssqZ7dBzI3rA77OA8oafWnlTVFIPfa46UgG
 oufhVF6pkCxdJPIHCInPjv3gPANVKV+eIPg4pbzudPF53hP7KTuvIdWBY7Jt3G6OoRE=
X-Gm-Gg: AZFdTZcvp/VA0xMldw9wCVKf9MOzGAcTHA2s6qZcMuqphEv8vB64PqT8WehT+2RlAj8
 Qlk0GAbcv82c7E2mh8Aw6IAO3w/xRYFE9amGtUtuNnoenW+nmGG5pORfomlJygcHyoq6b20Tf3Q
 OhYVcUu9cw5aVBgjQw+E5OCIOHsq0C+eWrvhApVsId7wqplYcDMswbOpE2PNngCr60SBZwqgb1O
 cXWDRYlr2vfnmZX7FEY57S/gqsnCTN1wQ0oxrQIc1VUtT0lUx6Kl1D9RDeWJuByL5oaiTRKD14S
 W45Rnxutdft3Mi9seHz42iJF/SuKsM3vxglZAnGGmI9b7nxwSdCXW74ND4N7NoNLPHCOLvmVI6B
 CoJ9j3B/RmYtVM8UM0ZtGIVppi434PxKZxbvk+74VHdtB+evlricKqbAeLYLW6wjqwddyuTn4BU
 IGfP+0lBpTpRrY6MlLcoWLKMU5UcDaoIZ5zD92GeUlr1inI4Yqn1zqCWoL/b3X9OtsoQrWcpE/m
 Uegm5H/j3NBN0M04+VHHC56A4TcHdpya6MUbAV60X0DVpOnFWM8/QoZQlG6zRvXrm94UKlSmTMa
 CIMd/PmTlRYErv5Y/JlbvbA6JcoKFr0kZScYm2TAG7Y+3xT+Ug==
X-Received: by 2002:a05:600c:3b99:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4bb8880b984mr497296635e9.14.1795703769269; 
 Thu, 26 Nov 2026 06:36:09 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm49023025f8f.21.2026.11.26.06.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:36:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7499A5F874;
 Thu, 26 Nov 2026 14:36:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Chao Liu <chao.liu@processmission.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 0/8] for-11.2: testing, MAINTAINERS and doc fixes (pre-PR)
Date: Thu, 26 Nov 2026 14:35:59 +0000
Message-ID: <20261126143607.2374676-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Just collecting up some bits and pieces to slide into 11.2. Most are
already reviewed but there is a v2 for the virtio doc and the
cpu_io_recompile comment can be dropped if no one looks at it.

Alex.

Alex Bennée (6):
  MAINTAINERS: update Daniel's entries to be consistent
  MAINTAINERS: make LIU's entries consistent
  MAINTAINERS: use consistent capitalisation for Alistair
  MAINTAINERS: update security reporting links
  accel/tcg: update stale comment for cpu_io_recompile
  docs/virtio: add note about virtio-gpu acceleration

Brad Smith (1):
  tests/qtest: remove unused prctl/procctl headers

Marc-André Lureau (1):
  tests/functional: use immutable tuxboot kernel URLs

 MAINTAINERS                                  | 44 ++++++++++----------
 docs/system/devices/virtio/virtio-gpu.rst    | 12 ++++++
 docs/system/security.rst                     |  5 +++
 accel/tcg/translate-all.c                    |  6 ++-
 tests/qtest/libqtest.c                       |  6 ---
 .mailmap                                     |  1 +
 tests/functional/aarch64/test_tuxrun.py      |  4 +-
 tests/functional/riscv64/test_milkv_duo.py   |  4 +-
 tests/functional/riscv64/test_tt_atlantis.py |  2 +-
 tests/functional/riscv64/test_tuxrun.py      |  2 +-
 tests/functional/s390x/test_tuxrun.py        |  4 +-
 tests/functional/x86_64/test_tuxrun.py       |  4 +-
 12 files changed, 53 insertions(+), 41 deletions(-)

-- 
2.47.3


