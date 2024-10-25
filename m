Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35954D149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mm1-0001id-Mk; Fri, 25 Oct 2024 12:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlz-0001hd-AE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlx-0004oR-Pq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhTrf8krh6qlx4DUI+jP2iIptj4/eIA7hdP8klGMHA0=;
 b=PGbHrmB6oaWXCoOkBXzkG2zCa3msS59UWx6PTUDPCoPjWy3Eedkbhg0I9k87rGz+ZZyTYJ
 4jI8lA8PrGpFGFFZyNt1lJjSLL6yiyJlksKBmlzCfFM1W7PnXO47n0cT1ni45Eq9Q1oRhy
 GRMd45ekPl+AihTDiChbv81WzjMmHJY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-dX4TcUkINHOQISCH660ByA-1; Fri, 25 Oct 2024 12:02:43 -0400
X-MC-Unique: dX4TcUkINHOQISCH660ByA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99fa9f0c25so151890766b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872161; x=1730476961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhTrf8krh6qlx4DUI+jP2iIptj4/eIA7hdP8klGMHA0=;
 b=VeIX4KAR8KiKab4H7xJb8fK7ijefUpHY4jozrIjSOizp8DcVvX+KKcTeybWRvPR3AO
 8LXsnr4My906eak5SsuzRZLx7EFrDqPudfU2JoNCsodcbXjy6qppaoJdHLEYNWd4XNtE
 cujmPXuYq8o8BDk451ahgOJH+ertkPSBnvUz7pDl2S43YuxQ8FqelmqAeUYQm4Dn3+68
 NcsKvY/mBxN1iAmiIuDsMYVzZgIvb43bXhmzxvMv0rInTGGhVn2b2nKZYmY/dH1xyJsM
 MHXL8DriQAZcB90oHjw7e1kWfT2942nKpQQWVZxmCo6tB/YB1lKHVdM/KA+6Fk+hjo6b
 BaYA==
X-Gm-Message-State: AOJu0Yyc5SOTd4J2ID/g+EPUPm4qb/bDbowPKo2HB3EgdF+5nnUDNA8y
 3/tflvv6zszLFOLXNnrgVcfbkf5dIopkzd6uyYV02LYkb8qDxP9grFI7koAxGkEUUoAEFHB5jbN
 oo4Bi/LAyjR2myM4YlFaryMTG7WEsEBy7Vf5uMASrARIJH+cZnCEyZocrX+fqDuZZHsX9hXV863
 cC12AVvy9NdLVsUARVowJk5SFFVD2VG+yHfqB8eBs=
X-Received: by 2002:a17:906:da8e:b0:a9a:6477:bd03 with SMTP id
 a640c23a62f3a-a9ad275f71dmr545373566b.38.1729872160839; 
 Fri, 25 Oct 2024 09:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJt9cXARG1Y+gPzcX69CGLH9IV3oFHKdXZIlhduNZ0bgg40/03BHx1p1bGDxodLO5CixqpDA==
X-Received: by 2002:a17:906:da8e:b0:a9a:6477:bd03 with SMTP id
 a640c23a62f3a-a9ad275f71dmr545363566b.38.1729872159849; 
 Fri, 25 Oct 2024 09:02:39 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7b5a9sm85495066b.171.2024.10.25.09.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 06/23] rust/pl011: remove commented out C code
Date: Fri, 25 Oct 2024 18:01:51 +0200
Message-ID: <20241025160209.194307-7-pbonzini@redhat.com>
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

This code juxtaposed what should be happening according to the C device
model but is not needed now that this has been reviewed (I hope) and its
validity checked against what the C device does (I hope, again).

No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-8-051e7a25b978@lin=
aro.org
---
 rust/hw/char/pl011/src/device.rs | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 051c59f39ae..98357db04e8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -192,7 +192,6 @@ pub fn read(
                 0
             }
             Ok(DR) =3D> {
-                // s->flags &=3D ~PL011_FLAG_RXFF;
                 self.flags.set_receive_fifo_full(false);
                 let c =3D self.read_fifo[self.read_pos];
                 if self.read_count > 0 {
@@ -200,11 +199,9 @@ pub fn read(
                     self.read_pos =3D (self.read_pos + 1) & (self.fifo_dep=
th() - 1);
                 }
                 if self.read_count =3D=3D 0 {
-                    // self.flags |=3D PL011_FLAG_RXFE;
                     self.flags.set_receive_fifo_empty(true);
                 }
                 if self.read_count + 1 =3D=3D self.read_trigger {
-                    //self.int_level &=3D ~ INT_RX;
                     self.int_level &=3D !registers::INT_RX;
                 }
                 // Update error bits.
@@ -374,13 +371,6 @@ fn loopback_mdmctrl(&mut self) {
          * dealt with here.
          */
=20
-        //fr =3D s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
-        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
-        //fr |=3D (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
-        //fr |=3D (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
-        //fr |=3D (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
-        //fr |=3D (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
-        //
         self.flags.set_ring_indicator(self.control.out_2());
         self.flags.set_data_carrier_detect(self.control.out_1());
         self.flags.set_clear_to_send(self.control.request_to_send());
@@ -391,10 +381,6 @@ fn loopback_mdmctrl(&mut self) {
         let mut il =3D self.int_level;
=20
         il &=3D !Interrupt::MS;
-        //il |=3D (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
-        //il |=3D (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
-        //il |=3D (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
-        //il |=3D (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
=20
         if self.flags.data_set_ready() {
             il |=3D Interrupt::DSR as u32;
@@ -500,10 +486,8 @@ pub fn put_fifo(&mut self, value: c_uint) {
         let slot =3D (self.read_pos + self.read_count) & (depth - 1);
         self.read_fifo[slot] =3D value;
         self.read_count +=3D 1;
-        // s->flags &=3D ~PL011_FLAG_RXFE;
         self.flags.set_receive_fifo_empty(false);
         if self.read_count =3D=3D depth {
-            //s->flags |=3D PL011_FLAG_RXFF;
             self.flags.set_receive_fifo_full(true);
         }
=20
--=20
2.47.0


