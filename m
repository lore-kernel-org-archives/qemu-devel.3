Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83B6C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQz-0003Zi-Sy; Mon, 06 May 2024 04:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQm-0003UD-VT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQg-0002NB-Nq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTEjkpuKyY2Y+K0Igbw0Rw9OKqigSJ52nD4y0sLqCyU=;
 b=hvOrH4B4e6D/KyeJXkyzYiZryFJIvnCxtnlZp0hS0hMnYzXvBJC/sp2dso6SsmPtundj0r
 wRnthhE3qQGUZR0D3X1CXJO1fT7hfudIKrGBBkoYE6rDnMc2IgH0PeC8sFWoZ7B6zRNixS
 ODnwrBqDnB6WWKjA9UqgwrCb9Cl/8TA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-t2nTA3O4PGWBGcYkpDJkdA-1; Mon, 06 May 2024 04:10:30 -0400
X-MC-Unique: t2nTA3O4PGWBGcYkpDJkdA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59cdf2141eso37363066b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983027; x=1715587827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTEjkpuKyY2Y+K0Igbw0Rw9OKqigSJ52nD4y0sLqCyU=;
 b=aPQGEuW5XnN0aH4I6mPA4stcXkNFtSuL2UbIcb//orcW6JpoWKRT5f2KsXgM4iQxzb
 SKeJdZXi0mNmLfUahD1noPB5+pbYunImwO8I9bJkg0zrs97sMEnbSfXuRZV3zJbt6/U6
 /zFZ1rFKDyrFG3XHRgnxQaNcdljQASbtc9s0p0R3dWJqEb/VI2IAQmAlMcD/s0c0r2Fp
 u2Rw0rc4Z7ZAOA1rX/A4Usc+c2vc2vd6/c/UFmxaK+/ZWomOAar53Ww2fXgoOphASLDj
 iMSL9fniJ4WNtHCIzyZcKgMLqyGt13f2SOLCBlZ5hib1/V5/BwXjnkMO14vfhX2phq4n
 hlTg==
X-Gm-Message-State: AOJu0YxUxzsm5ejsiO9N2oS/0GF9RON3iVEwJDrSgek8Aq/Uv9Zx0MOr
 +bMlw3zguJTEVcPbuLWezM6RIbpshJXvxp7S8+N3zFh8N/Z8WyveE6F6kPm5RrzrSxpsoes4Jxw
 dQr9pg3yknviHALuU6WTthlL1iKWcmyBItajmkgoWoAs8h+BBGlh9d8/IO7JpCT6JtTGcus5au/
 gUaJ6aYSyT1husQsApV1tqfMxOtf1p6gaSoYEs
X-Received: by 2002:a17:906:f59f:b0:a59:aa68:9992 with SMTP id
 cm31-20020a170906f59f00b00a59aa689992mr4250255ejd.18.1714983027628; 
 Mon, 06 May 2024 01:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEawiz1EwDd+R8fBJm7KEmllnR6/h5hC5rj8opA2121ZKVB5Riiyn2POpP0cbahUMZroWuFLA==
X-Received: by 2002:a17:906:f59f:b0:a59:aa68:9992 with SMTP id
 cm31-20020a170906f59f00b00a59aa689992mr4250231ejd.18.1714983027200; 
 Mon, 06 May 2024 01:10:27 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 hg12-20020a1709072ccc00b00a59b6eed3c4sm2047529ejc.45.2024.05.06.01.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 09/25] target/i386: clarify the "reg" argument of functions
 returning CCPrepare
Date: Mon,  6 May 2024 10:09:41 +0200
Message-ID: <20240506080957.10005-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2cd7868d596..7efd12cbe7e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -937,7 +937,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
     }
 }
 
-/* compute eflags.C to reg */
+/* compute eflags.C, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
     MemOp size;
@@ -1008,7 +1008,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     }
 }
 
-/* compute eflags.P to reg */
+/* compute eflags.P, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 {
     gen_compute_eflags(s);
@@ -1016,7 +1016,7 @@ static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
                          .imm = CC_P };
 }
 
-/* compute eflags.S to reg */
+/* compute eflags.S, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
@@ -1040,7 +1040,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     }
 }
 
-/* compute eflags.O to reg */
+/* compute eflags.O, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
@@ -1060,7 +1060,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     }
 }
 
-/* compute eflags.Z to reg */
+/* compute eflags.Z, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
@@ -1090,8 +1090,9 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     }
 }
 
-/* perform a conditional store into register 'reg' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranteed not to be used. */
+/* return how to compute jump opcode 'b'.  'reg' can be clobbered
+ * if needed; it may be used for CCPrepare.reg if that will
+ * provide more freedom in the translation of a subsequent setcond. */
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
 {
     int inv, jcc_op, cond;
-- 
2.45.0


