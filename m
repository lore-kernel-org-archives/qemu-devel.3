Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC18CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKrL-00059H-G5; Wed, 27 Aug 2025 14:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqw-0004za-2T
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqk-0005ql-LT
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXGy7EdXqKx6CZguMwuDjSBt0K3GaKtkHfQT+xO0/Vg=;
 b=LWK9ANcSoCOCdAyFvfxITujv32Eim6XThjB5LgDFjVMGyFsRmeSmH8f2bxgoH/q4oWIjoB
 lTD+40Vd/k2x0okZ7y6Oi3WbL+jWoQ7mbPwf8lLmwaqsM9HKeWwcOg3y4CFGat/N+xHNZ3
 tOLvS03ibhwCH05hpiUSzWnl/HT9a94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-8boLDQdsNAK8XmETox2XrA-1; Wed, 27 Aug 2025 14:26:15 -0400
X-MC-Unique: 8boLDQdsNAK8XmETox2XrA-1
X-Mimecast-MFC-AGG-ID: 8boLDQdsNAK8XmETox2XrA_1756319174
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5feaso70075f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319174; x=1756923974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXGy7EdXqKx6CZguMwuDjSBt0K3GaKtkHfQT+xO0/Vg=;
 b=jn+ktVHApHM2CqDEvEr0EyNw1eLuhNZVHQAfMmIbCYM18KzCqgsUE63mYAxpUk8HAz
 D0QOaMjFfm8TOmitIgk9WNrJXW5q3gZwe+Sp0Adau1I4yoBMRn2BMVYrcEfF4Cl776Yh
 /5Z5Q2cbhGcxFlED5F1SNPreQpCaE9QNxkRb6aFMyZndia+l6vLCp2w/3ljsIwBC9sMq
 UI1Xj7y4deKUXqVDFr8SFR4ef8nG+A1T8e3jiBNVyQAefR3o39TxpEK91X3VEa1JvM2i
 Q+FZcpepbecTHseDKDALTnRUXcLDanK8R/g2UuBWp0L0VgaLe8OSKOZKt62Hs5/CgSRL
 WaPw==
X-Gm-Message-State: AOJu0Ywcm+0F6kvloD2zynQhnQ9yOM3i07i9LQX2HU9oH6yBAuINtPDc
 i/GjxMsWrIVocI6/8qffVye5qYO+pTnt/vvh03s9efFEFnrHdcO+Z7FClK8QJNbMgK5wd9oy/IU
 YHzHGfd6pmGLGjCJnCs3K/eOFvWCnTvhx1AxlQyjAhN5XeTlSMplVGCb7ovJ7OWnOm6o6LhxZdS
 sAHX2AS4ZGuuVlOL9/o9BERfzaQ4POCSvdgLGbOHcx
X-Gm-Gg: ASbGncu9XstLZaezI/idKFr/mB9h/HdsQcWFwmAsx9JKg9D90uC4cWN/6H6vzg9z4M2
 occeNMFNPTtahg2HE92EycoOwFSV8GPKJFMl1C/xPK7FvGn5RJ/J9NzkmYn7v/UTFbGJXtX3TI3
 yfUBXoO5AnwwR4mKGx1/9tFOv/ph65n6mhLlB22vFENdBphcOBvm4druHZsPMZRY9Ln+tUBBnyf
 ypE575wfB9p8QOxMFXJqJHkiI7iQvFEqrj9ES0VdxuVqH/tricj4moTcGGIEmYBKSbCRxN7Ih+2
 FgiTzZE6sFdO5pCNxXms2catlyY/jRx8Mk7UKjErnRk=
X-Received: by 2002:a05:6000:1a8d:b0:3ca:2bc7:e821 with SMTP id
 ffacd0b85a97d-3ca2bc7ef61mr9115013f8f.53.1756319174244; 
 Wed, 27 Aug 2025 11:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd6Nmzl6Y7EjeWKI31/68NvilIy9S45FMtevcZ8qv3EgHgBGc/rHIEk4VBnCIpvhdc9L5uOg==
X-Received: by 2002:a05:6000:1a8d:b0:3ca:2bc7:e821 with SMTP id
 ffacd0b85a97d-3ca2bc7ef61mr9114992f8f.53.1756319173776; 
 Wed, 27 Aug 2025 11:26:13 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b736bba5bsm9826895e9.6.2025.08.27.11.26.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] rust: disable borrow_as_ptr warning
Date: Wed, 27 Aug 2025 20:25:27 +0200
Message-ID: <20250827182533.854476-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is pretty noisy, but it was not visible until now because it only shows up
if the rust-version has "&raw const".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0868e1b4268..0a83db15356 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -53,7 +53,6 @@ as_ptr_cast_mut = "deny"
 as_underscore = "deny"
 assertions_on_result_states = "deny"
 bool_to_int_with_if = "deny"
-borrow_as_ptr = "deny"
 cast_lossless = "deny"
 dbg_macro = "deny"
 debug_assert_with_mut_call = "deny"
-- 
2.51.0


