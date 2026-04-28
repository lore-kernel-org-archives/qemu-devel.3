Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD15FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlkn-00080m-J7; Tue, 28 Apr 2026 12:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PeTwaQQKCiANGENCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--rkir.bounces.google.com>)
 id 1wHlkm-0007up-Ds
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:57:44 -0400
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PeTwaQQKCiANGENCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--rkir.bounces.google.com>)
 id 1wHlkl-0005w8-4y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:57:44 -0400
Received: by mail-qv1-xf49.google.com with SMTP id
 6a1803df08f44-8a5f6110c1cso275651596d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777395462; x=1778000262; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G0D205ZkxHd8IUf1AxmpRxb/OzMC8JTsQcR7hIJtRys=;
 b=bKjrlD4gDdT4ZrYuCy+HYNqbZSz7B36K/IWUhCsRlOT4ZwvvASM0a44JiczkDs+8O3
 ZtNW3pM2tJAc7B7Fb7XakGEa+iIs8W9tn/dom9ag83C8/C+CqiOcWcKG3ykdl7zeI12p
 LH4eNOqRHMlR6VTUHdx+5nZwVv6i0syYOLgWdSVYcZLf1bbm2g+96eeNZQMBjNT1Q8df
 7DG02SSqlCSTcMBszitgEhQ2ohejXkYCsIYMudHY4Gt2eRJvPEy2yVLKMud/lYR8/RhC
 aKiKB90WvKS2sO5xGWAaBVTtlrKO7/IY8AgOnQEqURBkmQIERpBLSs/OYO8XJ5o+wvUX
 rQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395462; x=1778000262;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0D205ZkxHd8IUf1AxmpRxb/OzMC8JTsQcR7hIJtRys=;
 b=X18mEQYQhSqCdV/lsFM+WYYFYllaD0Ay+Dxlii5SIKonzkiKEqnTBVWigrKB1c1dQr
 2MOa2disg0emgUhYn010qPGsbuk6poOzpoKxEQdmpuf+ZO9x5IBajQRfA4+daFXHalV6
 psbC1ERe8u7wqTwXL72uOUUq6psPt+TUnIKOMAx0CqepSQGHVQ9U4u3TfuYQLOh8WV3P
 PQxRszetO256BkrMqbFiqwtZB3YLH4m0uoXVxA6rBvCLx4d40AZ6WTkyvEeE5RsmYoFQ
 1J5Rc559UWtNOBMEjibTxl/5lThQ046+4IhG/g/9eEqLNCXpQpaq9Ls9Y6n//3H2NtKj
 edUQ==
X-Gm-Message-State: AOJu0YxIxqm2pR7PlAR6DmbR1ajrX9DsNsv+mN+jM1trYSNiNQd7sOEx
 /5+GEw7lOjTn6iBYRUgM+hUxi+imV6LnUnzYjuOdq3j1NBfDTxs5LQfCOyGJ/XCr4gFquCzHAQ=
 =
X-Received: from pfnw7.prod.google.com ([2002:aa7:8587:0:b0:82f:5a4:a02c])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a804:b0:82f:761:2b49
 with SMTP id d2e1a72fcca58-834ea81252amr30731b3a.49.1777394749716; Tue, 28
 Apr 2026 09:45:49 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:45:43 +0000
In-Reply-To: <20260427154441.1918536-1-rkir@google.com>
Mime-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428164545.2782523-1-rkir@google.com>
Subject: [PATCH v2 0/2] improve qom debugging and fix a dangling MemoryRegion
 in rutabaga
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com, alex.bennee@linaro.org, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f49;
 envelope-from=3PeTwaQQKCiANGENCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--rkir.bounces.google.com;
 helo=mail-qv1-xf49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi, this series of patches fixes a dangling MemoryRegion
in rutabaga and also brings the debugging changes I used
to locate it.

Changes in v2:
- Updated clearing of obj->properties using g_clear_pointer.
- Moved clearing of obj->class into object_deinit.
- obj->class is checked to be NULL before obj->free(obj).

Roman Kiryanov (2):
  qom: improve use-after-free debugging
  display: rutabaga: unparent MemoryRegions in unmap

 hw/display/virtio-gpu-rutabaga.c | 1 +
 qom/object.c                     | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.54.0.545.g6539524ca2-goog


