Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4F3C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXeW-0005vn-Vt; Fri, 24 May 2024 12:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeU-0005vN-Bd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeS-0006vU-Jd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TUAjBtvVc0NHozSAi4DVeoPzm0ELYup6xGPYuGVoL84=;
 b=Y5It6wm99Mtxm6rDK5I5DgO8OsRvJCpONhpuHh6KBhAqkUnWnxv/EzRc4I5zEK0yncB8pG
 9nL1ZrSvCAGdIPw0Iah39X/kd/8yg0SdvqEzZ1sTbL9iVrEpfD2Qyvms8XMbjy2qkVMtI6
 KuIfBrUm4QvTg3E/RqNdaX8QgtLcawg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-6j-rT2m9OuGeyh2qEDlq_g-1; Fri, 24 May 2024 12:20:11 -0400
X-MC-Unique: 6j-rT2m9OuGeyh2qEDlq_g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5222a0800f0so2462290e87.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567609; x=1717172409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUAjBtvVc0NHozSAi4DVeoPzm0ELYup6xGPYuGVoL84=;
 b=puwAWU9KWLurnMfXGum+mR3fnX1i/aozihFpa0biqQOPUK+4y2xnEzSWD2gYM6hKAd
 SjiTSvpxHard7RO7D1VBN3zeLKz5gcoeOwrnEPWo0IdiDmunWugSi5vFXSiz4PCA0ook
 8typWqUrBuv/YWYkH8FKWUUWS9ZzI3F+DYa6dS3IzUaa/DABxXzSHCMEsZHLjXaa8BwA
 KRMuDbJPy7Sbgs+au2CoMM3fgpp5uECEEH3E/4luaKxgbfuvAyRs818zyIQtwzDn+Td5
 A8F+jA/rzig9sOrcrZAJdlfMbOV+MIHSMwpwZz8KT0ZC1yoNYR0QZzzKQiJZxYu3fvQS
 vVBw==
X-Gm-Message-State: AOJu0YzR/0AVnTVtrNExbWXsUD4SfzHqhi2PHQJfDTpkP0jjU2AFpobm
 GWRC2+xFItFwQMrx9sMMcIaQKzCa0XS4x9c7/SYcWzo8uL6hrH7dcusQl8JQslF3XrfqnZ5Sbbe
 DbnChtr08IrCFeYKIPs6a4bxwBWctv/TnSeUDkAzmLqTbJgy9e/uNzwGMHJoQH17zNntyavRBGZ
 V8VouzDUnrbf+DzWe13HOnu8kBa7RYSTP6MnFd
X-Received: by 2002:a05:6512:3443:b0:523:9003:88a0 with SMTP id
 2adb3069b0e04-5296600605bmr2158156e87.39.1716567609166; 
 Fri, 24 May 2024 09:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQpAMcKbdL/wtSJSqPe83HrFWZP8b+t0/ve5yByI1o+Lg7po2KUd8nOkxUC9M8500BhTWb5Q==
X-Received: by 2002:a05:6512:3443:b0:523:9003:88a0 with SMTP id
 2adb3069b0e04-5296600605bmr2158122e87.39.1716567608551; 
 Fri, 24 May 2024 09:20:08 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5297066b207sm210886e87.166.2024.05.24.09.20.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:20:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] meson: small cleanups
Date: Fri, 24 May 2024 18:20:00 +0200
Message-ID: <20240524162006.1271778-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All found while looking at Akihiko's issues with declare_dependency(
objects: ...).

https://patchew.org/QEMU/20240524-objects-v1-0-07cbbe96166b@daynix.com/

Paolo Bonzini (5):
  meson: remove unnecessary reference to libm
  meson: remove unnecessary dependency
  tcg: include dependencies in static_library()
  meson: do not query modules before they are processed
  migration: remove unnecessary zlib dependency

 meson.build             | 2 +-
 migration/dirtyrate.c   | 1 -
 migration/qemu-file.c   | 1 -
 audio/meson.build       | 4 ++--
 block/meson.build       | 4 ++--
 migration/meson.build   | 2 +-
 tcg/meson.build         | 8 ++++----
 tests/qtest/meson.build | 2 +-
 ui/meson.build          | 5 ++---
 9 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.45.1


