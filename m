Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3CBC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaTz-0002KI-PM; Thu, 30 May 2024 03:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaTy-0002IM-Eh
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:45:54 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaTw-0003LD-Tx
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:45:54 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e724bc466fso6543731fa.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717055151; x=1717659951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HUg/pmw7ECobPYf4Dm9VVMYq+h562j2y5POy3LkzTJA=;
 b=MbaDrTg7SWgPkCSw2m8QdBHjCweLGoGwldxXaMPmSkZlF3MWamHFvnYP6cowVjLDGG
 VKItGNT9oyDgK9zi53t8M3XxFADrjmrEqNV3qrN0I3Y+6Ul4da/BKr/XVHs8I4gf4aLq
 p8rcQf7fPbuMVwaX8rrAyoc3DGxZTIkVrtm4C2RaVMKME2qHq1FpW0JwI2w1bCrnLcyE
 YLqcqMxfXqOv0HiEo3fw07XfZ+HzKBQPSGLlnMjoyYM+za2JAtvhMWKvMJpTCzeuN++u
 EMOf/Fv08YTHGjsvsyhn5n8rMqRgLzoQYJrRK8KaVcIUJb0rAcWT3ZXEcyt7THoIABDL
 XwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055151; x=1717659951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUg/pmw7ECobPYf4Dm9VVMYq+h562j2y5POy3LkzTJA=;
 b=T0WaL7IBA7Vw3D+2CT8TL/cCCCsUZx4UXLUvo1ZQ47nHTdfoWJY/O3eXl22ZkcCw0I
 10WHcoD0RzCZcLrT9d9G8c0WUIVnJTmArZljYiELPdDqLwxhgEfuidNJxJJc1DS/2HqR
 1WFdpAaFQk/qDOovIvyQ8YD9zd7MAlhYYNnC+FIZghDWVN6oI9j5RCsFyUT39GQJoHHB
 jE6WUXa27D4L7Y0V2Dew1uU+JR6LZA+C3K4+Kp+03zYdgp7YB/d0KAvMKTfvxJjeSLbx
 Vcm/Hhbj4j24wVLL1TBVX46vPjwCV4TghMZNJSM7pgnHS3HHAKHGWMRm9RQTwblRGzkK
 tCKw==
X-Gm-Message-State: AOJu0YzBUSNuM9RYJzbMHLIOl9PbDXLagw6oWnyClihuNccwwmAUm5Q+
 YebewgNNdBijDI9Dp/YSc3TGKZhHKFCSDcwyd6Tay57NlVVCvS1p4eyRqI7dn6r2Bc4Cxygbakd
 V
X-Google-Smtp-Source: AGHT+IGrCxbBsA+yWr+byuvDlgX51uGQgTXbPSsva8JjoIx/kYSGLYK8khMX6TwsEwzTaqfKPm8RnA==
X-Received: by 2002:a05:651c:2116:b0:2ea:7def:dc93 with SMTP id
 38308e7fff4ca-2ea847d4d87mr14569941fa.27.1717055150697; 
 Thu, 30 May 2024 00:45:50 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a878sm16570186f8f.43.2024.05.30.00.45.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:45:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
Date: Thu, 30 May 2024 09:45:40 +0200
Message-ID: <20240530074544.25444-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We are trying to unify all qemu-system-FOO to a single binary.
In order to do that we need to remove QAPI target specific code.

@dump-skeys is only available on qemu-system-s390x. This series
rename it as @dump-s390-skey, making it available on other
binaries. We take care of backward compatibility via deprecation.

Philippe Mathieu-Daudé (4):
  hw/s390x: Introduce the @dump-s390-skeys QMP command
  hw/s390x: Introduce the 'dump_s390_skeys' HMP command
  hw/s390x: Deprecate the HMP 'dump_skeys' command
  hw/s390x: Deprecate the QMP @dump-skeys command

 docs/about/deprecated.rst  |  5 +++++
 qapi/misc-target.json      |  5 +++++
 qapi/misc.json             | 18 ++++++++++++++++++
 include/monitor/hmp.h      |  1 +
 hw/s390x/s390-skeys-stub.c | 24 ++++++++++++++++++++++++
 hw/s390x/s390-skeys.c      | 19 +++++++++++++++++--
 hmp-commands.hx            | 17 +++++++++++++++--
 hw/s390x/meson.build       |  5 +++++
 8 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 hw/s390x/s390-skeys-stub.c

-- 
2.41.0


