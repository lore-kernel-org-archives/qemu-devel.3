Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DCDCCFA04
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr0s-000148-AT; Fri, 31 Oct 2025 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0p-00012c-SX
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0j-0000nT-TU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uj2/fxHWeywKmqC1Hm2LMSVtzUGKw7GtsYSGWCXlH34=;
 b=Pjl7ag5UjWWJ+U9dI92vSx0Zxu5RF0foIdKLBF6S06mdhf+kU7hN9Ejdv96eJJJ7xkYcrK
 CIxuE+MZhjimWjTjACDygUMXJzN3P5Vn0WJV5uU8jnXc9kUhN8vxzIOcCTimoOH3uObkrA
 5kzDD6DSvpzBr/e7Gbowo7yarxihIn0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-QWEqF7_kNpubgsHNKsxtVQ-1; Fri, 31 Oct 2025 11:25:45 -0400
X-MC-Unique: QWEqF7_kNpubgsHNKsxtVQ-1
X-Mimecast-MFC-AGG-ID: QWEqF7_kNpubgsHNKsxtVQ_1761924344
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4771e696e76so26781995e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761924343; x=1762529143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uj2/fxHWeywKmqC1Hm2LMSVtzUGKw7GtsYSGWCXlH34=;
 b=B4Jpl0gJEgMae6+7eHj5Ztr7vVl4zzemkfaLsywIGkBQ3WNeWJoSHOWVZM/ACsqdDG
 ai2zIIfo1QEzHpk+ZTvwb6HKsA3TXS8bm1hQ21AnkmO+CYMJjSApQY3SbxYuRF5qxqKu
 9mbHGpRQrTFD0D2CF6BtOZvqyx1SPuKn0OC1vt2JZDw0soWM8Oh8zax3FrUFUsQpVKPu
 cczSMa1MuVbqB+ZA+D7iwlgDwrTWRTGqcuqVqfKrH1z1y/z+LxcRBAsHmQAsl73SuQ23
 wMOfif5zX1UW0dNKLWfE5S14JrrFVdvcil8GM4JLeNcrMgxms06xKhjkubLgQwgBdjpu
 Tupg==
X-Gm-Message-State: AOJu0Yx3LyfjgBLDvqdIuuuu0Q0TM978pML2pUurgLIRrzOhEuFoCv4r
 9tGf7Q61ddCpMX0D8A9iQGXhd8RUFAZjT/Bp8Vd9lduCXlrQ7MKxZr8grgNOsxbClw1mvqiMue/
 +Kjejy31LvSDsZflBozZc8BDJF38/Hqgih4162MHn9e7fUA0kF3c4GXSYL4K3pnp4rPk6NNG5UC
 w0kAmqg15kXn2RckKeUxwGjlc4OOXUBkSdydg9uvnU
X-Gm-Gg: ASbGncuvW2l+EawRbMdpGBEk6GEbAfR77XfdRF+3ZcLFtQ8wjSjhsZWDjhATN+dKAZY
 50ca9JJIT5OXNt5BwWSubYgKOCzFhKZ1UTSqSMC69jTNeOTi3GWVSU3alevBtIrMwIMCC/pIL+H
 153/2L9n6aaYZrhlqMoKGSsSLmhB6fVC+H+2wqsgt7McOfRjUYH1kbIb5kym0isgQfM5ZXN/I+W
 1bK+TK2qFjIhgzxL8oa52oS2YFtZeB5b0DMCkTvgLlmOtpqKUJsLP47HpfIH56CVT4bz3vC62r1
 SC/25vWCBgb1BZH9T8kwYTBdwvnczboFJ2aBTAoXj6BLbIi1Bv4Vpr59wAfLHdXWXlQwDrFxZXe
 a8WgROK5CXu6DmbeuChDAOP5Iwj5iKwLD5oniaanUqqVPCwyVdjr9WFM7bDkPL6BG2MWvnkjxxN
 ueQoV0
X-Received: by 2002:a5d:64e7:0:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-429bd6a4bc8mr3703666f8f.33.1761924342929; 
 Fri, 31 Oct 2025 08:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGszhu8xvVmUXg56hTW6ajlY+QMIjTgUhutkZIzqxDTkpQi2rFzK5izEHH41Qv5LZJPfze+5w==
X-Received: by 2002:a5d:64e7:0:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-429bd6a4bc8mr3703640f8f.33.1761924342479; 
 Fri, 31 Oct 2025 08:25:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48ee52sm2283185e9.2.2025.10.31.08.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:25:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/4] rust: improvements to errors
Date: Fri, 31 Oct 2025 16:25:35 +0100
Message-ID: <20251031152540.293293-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The first three patches are extracted from the serde work; as to the
fourth, I was thinking about it for a while - it provides an extension
trait for Result that makes it easy to use &error_fatal.  The main
advantage is to make it clear how errors are handled.

Paolo

Paolo Bonzini (4):
  rust/util: add ensure macro
  rust/util: use anyhow's native chaining capabilities
  rust/util: replace Error::err_or_unit/err_or_else with
    Error::with_errp
  rust: pull error_fatal out of SysbusDeviceMethods::sysbus_realize

 rust/hw/char/pl011/src/device.rs |   4 +-
 rust/hw/core/src/sysbus.rs       |  13 +-
 rust/hw/timer/hpet/src/device.rs |  21 ++-
 rust/hw/timer/hpet/src/fw_cfg.rs |   7 +-
 rust/util/src/error.rs           | 272 ++++++++++++++++++-------------
 rust/util/src/lib.rs             |   2 +-
 6 files changed, 183 insertions(+), 136 deletions(-)

-- 
2.51.1


