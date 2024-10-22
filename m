Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0929D1CDCF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BqE-0004rI-Aw; Tue, 22 Oct 2024 06:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqC-0004r8-CK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqA-0004NE-SO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u45iLCwaL6UDPFZFrxkclA/Jz3UXse/PWIiVqr58mZQ=;
 b=RR61zs4pLORMz20pcKLFZMssjZQjKQZcDlo5TJtVmV4gdV8/zoPCLcp/GkEy7gW1v+nG2O
 wo7a4oYf787mRzkOgx4ONqD7Im9wmfS0CaaZwD6HFVkhX6ho/kQDQtjljxgm2/cMOFb2bk
 lbZklHvVL4tcohToyQUGA2rHhzBD0JU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_hK7ADmUNLm6XC5qoDbmlw-1; Tue, 22 Oct 2024 06:10:09 -0400
X-MC-Unique: _hK7ADmUNLm6XC5qoDbmlw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso29594755e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591807; x=1730196607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u45iLCwaL6UDPFZFrxkclA/Jz3UXse/PWIiVqr58mZQ=;
 b=Lpy/Yd9hK+UHIl1/8EQW0n19srpPIGyx0POB8Iw5zp5WHI8sU1YNDsIio7iACbfWyO
 etcC6hG/rulEiwjrp9n5aJnm94xfApVtc+fNPEvUEEmln94x0ZLzgeFAPfmlU+uReu2W
 3jeC0QLfrR8l2Mqoc/+5+GGCDgkPh9kYYwK15HGg3K/78Pu6E6Fy17D8S+oltaUtMtTJ
 CQfgXNd4SUi7AFZfTVanT3TWMzJE0JwEx9eEGrkKUTpT6F+LRyOI58m+r8eE+lS7jgLL
 /12He+U2xSBYlcGnnU6s562JmHwbhVDpESSeWLsfgioktlJFxijAMMd4243a6kqIHPiP
 dhYg==
X-Gm-Message-State: AOJu0Yz0fhMazyr1wKDl1gLg6c2sXqfBmlVlf76GSAzYSsFiOu5yI0/d
 hvegL05yOUEYCpdXnPy5nHipJXCOWSHq1KkGxXlCtaSWOdcvAbLD0uReaz8tx++X4UUj8LjAA7/
 6wZZyOoj+7Onof/C+HwKP5FJ4D7EKRL5DCl/IAfk98CInEGru2h8keGn1ZCnHJA2ldaQMPV/mAu
 AbRbdzzqCqW96GacVzh4R2x+8WR4zlYG6egJ8A+xU=
X-Received: by 2002:a05:600c:1994:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4317bd8e3c4mr17016705e9.10.1729591807574; 
 Tue, 22 Oct 2024 03:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH60NolRXgjd8lCXnosS+yJVsDidGmozsXZ3YAcdeEYVg2JuEcF+eJ+c4J62IzOGesgIEaaQ==
X-Received: by 2002:a05:600c:1994:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4317bd8e3c4mr17016445e9.10.1729591807125; 
 Tue, 22 Oct 2024 03:10:07 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58adffsm83761815e9.22.2024.10.22.03.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 02/14] rust: fix cfgs of proc-macro2 for 1.63.0
Date: Tue, 22 Oct 2024 12:09:43 +0200
Message-ID: <20241022100956.196657-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Replay the configuration that would be computed by build.rs when compiling
on a 1.63.0 compiler.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subpro=
jects/packagefiles/proc-macro2-1-rs/meson.build
index 818ec59336b..8e601b50ccc 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -15,7 +15,9 @@ _proc_macro2_rs =3D static_library(
   rust_abi: 'rust',
   rust_args: [
     '--cfg', 'feature=3D"proc-macro"',
-    '--cfg', 'span_locations',
+    '--cfg', 'no_literal_byte_character',
+    '--cfg', 'no_literal_c_string',
+    '--cfg', 'no_source_text',
     '--cfg', 'wrap_proc_macro',
   ],
   dependencies: [
--=20
2.46.2


