Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5C5C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZbf-0000dV-Pq; Tue, 15 Jul 2025 02:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubZaL-00005l-Id
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubZaJ-0002VC-02
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752562573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yNuDNUb8sgDdCltxRTw4gin9fX6EQkmxTEt1nRxR+Y=;
 b=iIh71jf5pRIF/e32so943JUrhI/WkraceLHwmx/W+UHKeJoiRTuQOP2EfxfcLj0YVuu+sI
 /AwDHlh1ofvLPJJC7WWN+sYnVsWDPBRBvrpQLFLkwqO43sibEX1g3NeS4lnQIV9CsKZy6n
 tAAVRQCMSuenrk9Lr9lPB4y+OSYt8+s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-ASJWJ-CjMcSHU6LQO_2xIA-1; Tue, 15 Jul 2025 02:56:11 -0400
X-MC-Unique: ASJWJ-CjMcSHU6LQO_2xIA-1
X-Mimecast-MFC-AGG-ID: ASJWJ-CjMcSHU6LQO_2xIA_1752562571
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1865925f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752562570; x=1753167370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7yNuDNUb8sgDdCltxRTw4gin9fX6EQkmxTEt1nRxR+Y=;
 b=JJNXSkk5MtpJhNLnrCeNBsKodLWJCCA9OyY3q6AGsqGJAofDXETnBuzkwr4J+xPqag
 QisXnYBVfMFTkYTb5c7j3ijhx2ZJUCR58ZfWZPv+D6I93ouDtwOlmcg7s4/1ZRcotocn
 vO7M3EuDKW8rYHFtfirCGFuTZOJy2keBa/HM/m50MUUvLrdq4o8cTFj0TPyC3tYU1Kvf
 luNu5iuL6m9Mfx8+rSRw60XnHbH8eQ8XFoGE5aZYq5l/QNoZvJJEhGrI7exp6k5Z+ZqI
 lzutw9blrGK5RJzWvLJw32k+A5Y2pcystgm3TGpA0AphKGgB44Px0mDHVngzt1/QnK3I
 nE+w==
X-Gm-Message-State: AOJu0YxFwXOxIF5Gv/oZu97R/whCG9HoEYrlqmDFiBoY1nn4znChtxfv
 BthoOx6HBo68erRyXmlVCi3z58Chw+E0ghCuHjrHcuQ0n5a/OujLKjOpApi8PgUIi6akv4sGuqn
 kYrH/v3s1G42j9+DWYbqKZUR9WDjAUerNkaLeTFyM100bE9oSLvsMgzpm1N+wqkRE/zx4Lctkbe
 3pkALkakMWuYWS9PzQASNbxdciVEsQ57uQ/w==
X-Gm-Gg: ASbGncsXoHK4rlduCqNcD3V+SJoL+QGDwrwXa1nbJy8dgr1lnX8ngf7J/BBBDHIZLVG
 9ijPIfuIej36BjwccPDLE/1cqQ0phV24SN2CWA71rl5D2+mdsfh9VgH7b25H/f1S/tys02hNPaF
 FOTbf9THjwxUZuEWCVwwZz/EtOXZpztqYsmcCuTFDmyKbwTHA2UbxLBVK57d5c+FzTsL8XpLP+v
 bV7EZnEWztvIPI+xYHE8Yj6a7Iob4XAXCFc6u1+EX5iCzDuH/EbwtQkrStbG53YN43NnLoUPqaZ
 YLxU1VItj9LHbGGpX5EfEA4S2RxC8b3I
X-Received: by 2002:a05:6000:1882:b0:3a3:7387:3078 with SMTP id
 ffacd0b85a97d-3b5f2db1241mr12134708f8f.4.1752562570246; 
 Mon, 14 Jul 2025 23:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcz4f47+TFKf95QeECfPiWVpN6YlsiQRUKmw/NqwqBmCEDKUvsADoI4jOr+ASD6mfHDNDYxQ==
X-Received: by 2002:a05:6000:1882:b0:3a3:7387:3078 with SMTP id
 ffacd0b85a97d-3b5f2db1241mr12134686f8f.4.1752562569798; 
 Mon, 14 Jul 2025 23:56:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5easm14162312f8f.48.2025.07.14.23.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 23:56:09 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:56:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?us-ascii?B?PT9VVEYtOD9xP1BoaWxpcHBlPTIwTWF0aGlldS1EYXVkPUMzPUE5Pz0=?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Subject: [PULL v2 28/97] rust: bindings: allow any number of params
Message-ID: <d60816f7f317e52bf382a5cc0bc29b41f5864929.1752562442.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
 <04130b3dc5af620213a90d300933517b39f43bba.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04130b3dc5af620213a90d300933517b39f43bba.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We are going to be adding more parameters, and this makes
rust unhappy:
    Functions with lots of parameters are considered bad style and reduce
    readability (“what does the 5th parameter mean?”). Consider grouping
    some parameters into a new type.

Specifically:

error: this function has too many arguments (8/7)
    --> /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-api-tests.p/structured/bindings.inc.rs:3840:5
     |
3840 | /     pub fn new_bitfield_1(
3841 | |         secure: std::os::raw::c_uint,
3842 | |         space: std::os::raw::c_uint,
3843 | |         user: std::os::raw::c_uint,
...    |
3848 | |         address_type: std::os::raw::c_uint,
3849 | |     ) -> __BindgenBitfieldUnit<[u8; 4usize]> {
     | |____________________________________________^
     |
     = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#too_many_arguments
     = note: `-D clippy::too-many-arguments` implied by `-D warnings`
     = help: to override `-D warnings` add `#[allow(clippy::too_many_arguments)]`

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 057de4b646..c4f1f755ce 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -13,7 +13,8 @@
     clippy::missing_const_for_fn,
     clippy::ptr_offset_with_cast,
     clippy::useless_transmute,
-    clippy::missing_safety_doc
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
 )]
 
 //! `bindgen`-generated declarations.
-- 
MST


