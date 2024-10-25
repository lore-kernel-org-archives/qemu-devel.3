Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA170D116FB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mlr-0001dQ-R5; Fri, 25 Oct 2024 12:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlp-0001Yx-1H
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mln-0004mV-2Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=my1BNlvD0bq7YqmljScKQm6jXcf+70EOh6w75o23M+w=;
 b=YzaRxR6Vpf1ILf8W22e2GoLylHPapDtf0Tx2tlRk2jPwCJm+iklWRoHPjT1+Cz54kcpl7K
 isk0Iz1UEmU8zdrf5SRZpv66LMwNgAXRolFOXySQfLj7sqVsGn4p4Q5y48IQ3hCY7L83pT
 CpeBlYOMVgdL6PO7vM8o0tkX3rTnuo0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-CZUBCKq4MvCVzJRQNCK42Q-1; Fri, 25 Oct 2024 12:02:33 -0400
X-MC-Unique: CZUBCKq4MvCVzJRQNCK42Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a99fa9f0c25so151873866b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872151; x=1730476951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=my1BNlvD0bq7YqmljScKQm6jXcf+70EOh6w75o23M+w=;
 b=V+GTtLphY1fXuvmzi2PwSalgTGnCRn1Cw2QYOo84I9CnQZdiUAbr9BrRw30WmTq3QE
 lNItckbtGSZfkESO8q1AKjnY0fjjDb9XqRaNgOVe2XPK9FV0hccyRf55alIsp/IOzk2Q
 PFTWKqdVQOYdV/qbuLpHJy91Fb4oMeUCpo01uvtja4f5hIUNmruO/RyVEHGw6ngvRUfb
 0itIlkszOEqpvhUKrz8zHEdHz/YDZ6muxW0Zq0mzziArIbLKytY9KKktigiYte6sIScs
 S+9GMUSPoVqzw0D079L1Y6d63PooZRuzh/nMduL7vJMLuWqHGsBJzK8PtmgKNWEMZON+
 qj0A==
X-Gm-Message-State: AOJu0YziqwGMRn5MkQV6bCSEUEvQbo+CbtChTHykAM5ZhppTFLPH3R38
 ofa4vjjMe5QMOZz+gfwwHFLMSR4Xy1zRke3jUiB1/YWpQdybcPoihNKXFOQMYQpo1pr64wXBM+v
 5FTJ+Mxj87p5B8wDYMpsolY0KZTtbCfH3u/oqjj2rVkd3Ey35zPoh5iyW5Bj/lGN36dbz7Tj9Jn
 7oo+ZnVvcNdej+aenNOjej5Y9dTcXUWernZKsvSSc=
X-Received: by 2002:a17:906:da8e:b0:a9a:6477:bd03 with SMTP id
 a640c23a62f3a-a9ad275f71dmr545271366b.38.1729872150941; 
 Fri, 25 Oct 2024 09:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH186Ru82zC7u7sKHihGHGrJe37yeYvhaAYIWHCvCLRUJGODQuajGTT/T/7ZkNM6LOBTxBhww==
X-Received: by 2002:a17:906:da8e:b0:a9a:6477:bd03 with SMTP id
 a640c23a62f3a-a9ad275f71dmr545264166b.38.1729872150235; 
 Fri, 25 Oct 2024 09:02:30 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f0683edsm86084566b.93.2024.10.25.09.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 04/23] rust/pl011: move CLK_NAME static to function scope
Date: Fri, 25 Oct 2024 18:01:49 +0200
Message-ID: <20241025160209.194307-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We do not need to have CLK_NAME public nor a static. No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-5-051e7a25b978@lin=
aro.org
---
 rust/hw/char/pl011/src/device.rs | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index dd9145669dc..f91790ff185 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -102,9 +102,6 @@ impl qemu_api::definitions::Class for PL011Class {
     > =3D None;
 }
=20
-#[used]
-pub static CLK_NAME: &CStr =3D c"clk";
-
 impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
     ///
@@ -114,7 +111,9 @@ impl PL011State {
     /// `PL011State` type. It must not be called more than once on the same
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
-    pub unsafe fn init(&mut self) {
+    unsafe fn init(&mut self) {
+        const CLK_NAME: &CStr =3D c"clk";
+
         let dev =3D addr_of_mut!(*self).cast::<DeviceState>();
         // SAFETY:
         //
--=20
2.47.0


