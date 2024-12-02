Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FBED7830C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4G6-00050q-L5; Mon, 02 Dec 2024 06:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tI4Fy-0004yd-Pp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tI4Fu-0005B9-WB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733137576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=epCOQ4jQIaJ5d4pHL683hSqsE8Ow7X/ht8e7hANUPUI=;
 b=Fb9sjiV1FGaCpS4PBVC/RjvZAjxwUVOrDCW9HPx0obQYXdWKBrbLKJO8UFWBSSPy0cy+Kc
 8iFN/QECJPWTtP9fVplRgL0YvFX2yisOdzVioCH1V9Df7acN+HLd7hiq876fKB1Ns06X0N
 ZEitLH5rJd76bhjMd8NpUVXm7NUgUU0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-UnhdgncBOUWDcStPA5cjmA-1; Mon, 02 Dec 2024 06:06:14 -0500
X-MC-Unique: UnhdgncBOUWDcStPA5cjmA-1
X-Mimecast-MFC-AGG-ID: UnhdgncBOUWDcStPA5cjmA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6676f4361so389996285a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 03:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733137573; x=1733742373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=epCOQ4jQIaJ5d4pHL683hSqsE8Ow7X/ht8e7hANUPUI=;
 b=kvl75dMZf3qF2NmCqcyTMEkFqeBzdo7Cs+QSNhMTPblKvv68OtC6K0iqbRBOrw632t
 q1/+AucuPD8Ks6BuO6OXcPDB2mTar5lcrYRGcO+i6UszmIv7h3zhjcB1w463YuqOVFuN
 z8lqqcgOZGJgdM67s/RlDXgUVLlUZhEg2LUFktUnS959AgxkYk4J4rpd5WjS5IS2O08L
 PyZL6zPxk+Vo/1pGGoeIjtZVXjQXSLElAlhvyGso9Kb6JeL9Wgi18jUVR+fPPQCSOF1B
 SZvBXZLIbnfSFk7qUrZtXBONE6HPo6VmKfSsmnLC4qZ4DeltRyUifKKnMxLI/CdqgX2G
 RZOA==
X-Gm-Message-State: AOJu0YxYTyl69Q1LaDEZl5k4DY2t3rrS+Qs551M4yJ9JfyyhyIihIBl4
 bp9l9UJX6X1KFf9g4sbZ3CmD5nOJ/+xbutrU0DXhZg7E79ouBDB86AdYgCbQL1/H5xFRe4lD/sq
 vDLUNt4k6JdotrfeADYkNOOritQVhWaWQrsKlViDZ62KWHdovpwCoZX49TML/wkTqcMzoiD1DoN
 yV+YiS3VswthVpipCbv0LkV47kjW+sKFl/4P+9
X-Gm-Gg: ASbGncvNun+9dj5OSctzLSyv9o9nyzRS1onnOTnRfcmlMS3XnEloNlTcC79c4mxxwAG
 aLmlyy378TmNsw7lS19SXMLFSLS+Pre42tUDiLURC3a2eDnezCo9qjTaNhbLKlXRgvizCE0CqLM
 vO3ST6LcIzHUODP7JCUKVu6tuhJB8PX6dO8WavRcF9a+v2DR594UnM/VLAEbcSnsZaY1imp1X2b
 RZBZMWVvw1fUaiqzM0RV2pOugSWT7ut0WeHMN32bnWkSya7J0miG9mYY0IXFARbO0xQFNrLlnK7
 lHE=
X-Received: by 2002:a05:620a:372c:b0:7b6:6756:eeef with SMTP id
 af79cd13be357-7b67c250b04mr3906372485a.1.1733137573259; 
 Mon, 02 Dec 2024 03:06:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDENL5CcPzE0h10w3feCErXg76ZgbzoTd5RIXbk+A506Mt9tSp+TL/MXzvzscR8vxILuuLdw==
X-Received: by 2002:a05:620a:372c:b0:7b6:6756:eeef with SMTP id
 af79cd13be357-7b67c250b04mr3906365585a.1.1733137572598; 
 Mon, 02 Dec 2024 03:06:12 -0800 (PST)
Received: from [192.168.122.1] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c4b05sm391103685a.122.2024.12.02.03.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 03:06:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH v2 0/2] rust: safe wrappers for interrupt sources
Date: Mon,  2 Dec 2024 12:06:07 +0100
Message-ID: <20241202110609.36775-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
They are QOM link properties and can be written to outside the control
of the device (i.e. from a shared reference); therefore their Rust
representation must be an interior-mutable field.

This make interrupt sources similar to a Cell<*mut IRQState>.  However,
a Cell can only live within one thread, while here the semantics are
"accessible by multiple threads but only under the Big QEMU Lock".

Therefore, this series adds to QEMU a specialized cell type that checks
locking rules with respect to the "Big QEMU Lock".  In particular,
qemu_api::cell::BqlCell only allows get()/set() under BQL protection and
therefore is Send/Sync.  The code for BqlCell is a bit long but most of
it is lifted from the standard library and almost half is documentation,
including doctests.

Likewise, qemu_api::cell::RefCell would be a RefCell that is Send/Sync,
because it checks that borrow()/borrow_mut() is only done under BQL.
This is not added here because there is no use case (yet), but Zhao
is going to use it for his HPET implementation.

I am not fully satisfied with the solution I used for mocking the BQL;
I have a prototype that runs doctests from "meson test" but that may be
better left to Meson itself.

Paolo

v1->v2:
- change debug_assert to assert
- clarify meaning of active-high
- allow declaring vectored interrupt source
- fix documentation wrt threading rules

Paolo Bonzini (2):
  rust: add BQL-enforcing Cell variant
  rust: add bindings for interrupt sources

 rust/hw/char/pl011/src/device.rs |  22 +--
 rust/qemu-api/meson.build        |   3 +
 rust/qemu-api/src/cell.rs        | 298 +++++++++++++++++++++++++++++++
 rust/qemu-api/src/irq.rs         |  91 ++++++++++
 rust/qemu-api/src/lib.rs         |   3 +
 rust/qemu-api/src/sysbus.rs      |  26 +++
 6 files changed, 433 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/cell.rs
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs

-- 
2.47.0


