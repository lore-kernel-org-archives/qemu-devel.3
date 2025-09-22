Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342E7CAC5AC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0emU-0006l3-Si; Mon, 22 Sep 2025 07:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emT-0006km-0D
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emQ-0001m2-3x
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RJsPurcUhETQnVe1w4L58iY3pZt2bn1MFBYexwubz8g=;
 b=amAgeGv1v/5hHAfarfOYyy/8ZxgSQPHE7j/QTHrX1zA0JxsPr2bGjaP95HC48q4Jdw2C/x
 cU1B1zoUaZsoJ2y33BcG6u05w8Gerw4Aw1yy97R4d9F6b7TDIgfdm3LbfLlISxSeh8Mkgt
 CQFwKrzcJoFsRKQM/lJmMMf2V9Te3ic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-qUKrluAoMBKTxhyMY5e7FA-1; Mon, 22 Sep 2025 07:32:23 -0400
X-MC-Unique: qUKrluAoMBKTxhyMY5e7FA-1
X-Mimecast-MFC-AGG-ID: qUKrluAoMBKTxhyMY5e7FA_1758540742
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45df7e734e0so40925765e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540741; x=1759145541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJsPurcUhETQnVe1w4L58iY3pZt2bn1MFBYexwubz8g=;
 b=HjvOKfe3K/rNF2es7gABBPcHggY7//XWmn6dmX8Yg6M8tUfQGXLH1lenJZfBCJOWc0
 z9H36Prcnzs7YC/e9vV0Mn+cKEqTUXD/6KLSp9iT2rjIoJCfcL4mFGaCI2AvmiPXrBYL
 MyUWcp9ng45Y0BlhSylzJpmbWVqBTjiBwLOcsQEyWFdWE9Oy3IEL7Dh+asNVJX3VzBgL
 6miOOGdHn+aH5G1CtyNA856Wa99YNti6x8ngFBQdHsx8XQlf8ag7wyNfyhE72agjYIUv
 2POT/9k8Ke2Etfmx2aiGmUaVzrfBmTkoWbl1HQiWxGVpIPFX+iM0oKhnLs7b7Xp2JYKV
 /qsQ==
X-Gm-Message-State: AOJu0Yxi1bAv2d4CxSwQIU8IJll1Ri1Nt1PrWfGYCJJSPmZCbehTdkai
 UcM9z7VXjue0tIBIWfrHDNTRyTVz7rbFzrhNBxISjH93lvdrpBth64u1Sfr/+X8VsEBGPS+RgNa
 uG+KEOo9N0mN/Bon9dlhVVfh0MRF0KiFVQ4cIxM17JTbDMh541a+Nwwktkt/W8wbNKUypldYAuq
 kF19DybR1dsI3VQfgA+eWzH7vtoaxHJLpu2o54nsei
X-Gm-Gg: ASbGncsaOowEivovFys3rMIJLWal4uQkaGfNoVDzGtkk8SRcMU9Ws4uxfF26laegWOB
 AOarkb2zGagLPLsSU2GxolreZxeJ+slGqZYyGjVpdS+XkNixNHtA3sJxIOj0lzKhlj3jHHPp2nB
 cZjO+SzU38mCVpifIiozMTNvTLXVVRsSCvmytgEsuyxQ8X73H7eXrZSbgAf6bNciLSA3Ca0JsZl
 IsR6Gbykah95d/QGX6GtZ+3tzfcaJCdxMXQEf4421iegYfNjVtzm/HAZSq2+2i5PtSdOUIXs3to
 P9B7ivSnrKmZ9DOGZmD/Fs6U3gN/s86nroTfwFqmzPMLlaOuBJqb3kLh/kD6egM3aFGBQwdg03W
 IFnKZXyGh6XNHt09KGfELmRT5xHLjx2aOcJb/KaP96+A=
X-Received: by 2002:a05:600c:c87:b0:45b:7b00:c129 with SMTP id
 5b1f17b1804b1-467ebda8e61mr108969605e9.35.1758540741273; 
 Mon, 22 Sep 2025 04:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Ns+BEh7lx1MQeRGg5tBLKCkuv99COrfjyMkdrBtZCk96q9wmtUAMH/R9xyRWMEuNLWO1OA==
X-Received: by 2002:a05:600c:c87:b0:45b:7b00:c129 with SMTP id
 5b1f17b1804b1-467ebda8e61mr108969285e9.35.1758540740846; 
 Mon, 22 Sep 2025 04:32:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f190721esm196975625e9.10.2025.09.22.04.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:32:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 0/4] docs/code-provenance: make AI policy clearer and more
 practical
Date: Mon, 22 Sep 2025 13:32:15 +0200
Message-ID: <20250922113219.32122-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These patches contain three changes to QEMU's code provenance policy
with respect to AI-generated content.  I am sorting them from least to
most controversial.

First, I am emphasizing the intended scope: the policy is not about
content generators, it is about generated content (patch 1).

Second, I am adding some procedural requirements and liability boundaries
to the exception process (patches 2-3).  These changes provide a structure
for the process and clarify that the process is not an expansion of the
maintainers' responsibilities.

On top of these changes, however, I am also expanding the exception
process so that it is actually feasible to request and obtain an
exception. Requesting "clarity of the license and copyright status
for the tool's output" is almost asking for the impossible; a problem
that is also shared by other AI policies such as the Linux Foundation's
(https://www.linuxfoundation.org/legal/generative-ai). Therefore, add a
second case for an exception, limited but practical, which is "limited
or non-existing creative content" (patch 4).

Paolo

Paolo Bonzini (4):
  docs/code-provenance: clarify scope very early
  docs/code-provenance: make the exception process more prominent
  docs/code-provenance: clarify the scope of AI exceptions
  docs/code-provenance: make the exception process feasible

 docs/devel/code-provenance.rst | 46 +++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 15 deletions(-)

-- 
2.51.0


