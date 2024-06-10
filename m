Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B1EC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjIM-0005GN-H0; Mon, 10 Jun 2024 13:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIK-0005Fo-N6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjII-0001Zp-3l
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4217926991fso22680755e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718042336; x=1718647136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/MMfDTHbOeqWhvwxfA43olAt6Wf8BeX3AAZr81nVQes=;
 b=xPHdeFJ1Foc2fan3BIQ78EKmMyeNf4X03EVjbr0Nt2lx6Y/QqfjCoqPluoSB+Qc/vn
 Tr9gj/MSR0zBN0Y8oWivIJzXjfUi1z3epCt5KVJjNxfILEF7lYzVr+ZLBoBdSMpeCAty
 qUBxQNPPle/BEY/sEnoSCG+t+t9ajFjMEhXNwDGJgls6rpvKXGljWnVsdUYKdtFij5ET
 pckq9OKUSQNTY4HKqqS8KDjn8e7yPpE+hiooct70kgZp2UMCJQrDsUhrlPG3BapRK5Dw
 /ENajMPwCuIU/UEzwSOh1P07+uCD8vjH0osjCAce8PqXBpaaUNtCCSiW5eHLNbqQXMIg
 4s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718042336; x=1718647136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/MMfDTHbOeqWhvwxfA43olAt6Wf8BeX3AAZr81nVQes=;
 b=ST0b8MW7d/zhm1Q12gg2VsOMeYRLAI4DmESekoesNs0X2Y0CNdYOm2OTFafHRflWwO
 Bvx61WmsIkDeNTBqiJEvJ+XkKlPiPt6vciPj66EoWxQcZlVIwmdB6Rsz9m2uChXZ178K
 H7us5+jLQdwYFHLDVE8ZtwszgZnG8TqJDzX/nhBz3m7qRLvuXElEvbIqlJMoRYaa5Ij7
 cqJMXcxRzHIE+9+YMEqtYHO6qS6fNUM4ib96mFEE6H0x8hUW7cWadtHwnOWyYdPcLggV
 ySUi/KhqMJlBM4Y9F8OWfpjZg1N/MXqZ+mWTGwfbk90JtfflB2Uz4MxVfF6tzAXjum2K
 FHzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7W0w574NmRtb4vqRGTrtI0BSkCKZrosYJfaZMvUI8F73P4Dqp3qYgt7U8BnENtxK0MvlgoJW60zqJy2buA87OpHzPDHM=
X-Gm-Message-State: AOJu0YzL38mEku46GqQu89mdpZtrewVCEKcUi5fmy1Eeb1uU8WewfRGW
 Y9KT8NzjO9I0Qh90cn4JT+nJuf3lfTFwSUMupE2gCCJEYMMK64M/03tGtwNx+r8=
X-Google-Smtp-Source: AGHT+IEtZ1DrK3RPSKW3HnT8LgMjCfherVZCHXe3V3jvkZ/MqB4cffCxrLiTxBdmtIB5460Qd2unDA==
X-Received: by 2002:a05:600c:4f96:b0:421:80e3:dc8d with SMTP id
 5b1f17b1804b1-42180e3dd32mr41601985e9.24.1718042335802; 
 Mon, 10 Jun 2024 10:58:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102af1sm183741885e9.16.2024.06.10.10.58.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 10:58:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 0/3] monitor: Pass HMP arguments to QMP HumanReadableText
 API as JSON
Date: Mon, 10 Jun 2024 19:58:49 +0200
Message-ID: <20240610175852.21215-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Current HMPCommand::cmd_info_hrt() handlers don't allow
passing arguments from the monitor. This series pass them
to the underlying QMP commands as a JSON dictionary,
easily deserialized as QDict, similarly to how current
HMP commands receive their arguments. Thus very few
changes are required to port to the new API. As an
example, the @x-query-s390x-cmma command is ported.

Based-on: <20240610063518.50680-1-philmd@linaro.org>

Philippe Mathieu-Daudé (3):
  hw/s390x: Declare target specific monitor commands in hmp-target.h
  monitor: Allow passing HMP arguments to QMP HumanReadableText API
  hw/s390x: Introduce x-query-s390x-cmma QMP command

 docs/devel/writing-monitor-commands.rst | 15 ++++++++-
 qapi/machine.json                       | 44 +++++++++++++++++++++++++
 include/hw/s390x/storage-attributes.h   |  4 ---
 include/hw/s390x/storage-keys.h         |  4 ---
 include/monitor/hmp-target.h            |  5 +++
 include/monitor/monitor.h               |  3 +-
 monitor/monitor-internal.h              |  2 +-
 accel/tcg/monitor.c                     |  4 +--
 hw/core/loader.c                        |  2 +-
 hw/core/machine-qmp-cmds.c              |  9 ++---
 hw/s390x/s390-skeys.c                   |  2 ++
 hw/s390x/s390-stattrib.c                | 30 +++++++++++------
 hw/usb/bus.c                            |  2 +-
 monitor/hmp-target.c                    |  8 ++---
 monitor/hmp.c                           | 11 ++++---
 hmp-commands-info.hx                    |  2 +-
 16 files changed, 107 insertions(+), 40 deletions(-)

-- 
2.41.0


