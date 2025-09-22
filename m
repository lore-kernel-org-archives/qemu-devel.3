Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3558FCAC5AD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0emf-0006nH-QW; Mon, 22 Sep 2025 07:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emd-0006mP-S1
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emb-0001nX-7m
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY0A/YfZlUaLnIGRsHFzhtH794obkBvpbyO/zZH1MGE=;
 b=II3SDx+jibRHkZFtnG2PvxdrxbDzl8TSg0QNtpaK8LMUenclA7CZ2PhNtP8Gd+k5GP4bgm
 a4EpaBPNkxE0V5Ivei2XGPSc2nIce5BK5oHZF5x1rxZYAiIB8b0PTD08l+Yv8K1M0XqiMI
 x5aKQBzMv2xzWEGvXqutMqKLuEw+Jes=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-JrjgbohaPdasl1XiNvf4PA-1; Mon, 22 Sep 2025 07:32:33 -0400
X-MC-Unique: JrjgbohaPdasl1XiNvf4PA-1
X-Mimecast-MFC-AGG-ID: JrjgbohaPdasl1XiNvf4PA_1758540752
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de07b831dso27100235e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540751; x=1759145551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dY0A/YfZlUaLnIGRsHFzhtH794obkBvpbyO/zZH1MGE=;
 b=dB6g6uAChfgThniEoEGqGJJvUAhszBspqzkj5wcgZ7LbWfL4GE/MIBBqaSZfm4yrj2
 13cZqGBG+ADNFphpVTNyfe46v22EpQjluhTJFa/n5VXrk9+ujOrNAyOHPfmxthJRZC+c
 hWrp2g3roGLZZ6cvD7pgD9vp47sjZUW7qoSjpwu/a4mbqzuchF1jO9NYGLv8KaH86bPx
 FbJItNTmbOHQu0ZHUo6FpBfdgGvNgiJZ5o28HxgbD9sUtKYOg0apxG19//eeuUMra5b1
 v21bV/fdTEJ3tvVV4LBQlJlbGEBEm37I3z9X0P8AON5cHl5MfblIsRZypeDRmZ1bhQPh
 BBBQ==
X-Gm-Message-State: AOJu0YziunNKr4Q8RJ5FC0lJQfEqyE+vd27lInoVvAqRqWKmSunVHLpE
 F4+Tr4/fqGbhLRhN+mxAw7BO6giJWYmimkXN7vRm9H3qklT62rvF7X2P1WOnd1G5bFSTfKW71rr
 0S/+ql3+XsoEl2I5kM8cjSSzVIXr9gN83Chnmi8XEYbcHQyuWvdRtAiqMujyerAk7WG8iiJlKle
 k7kFnUovyWmjGqunTrD2nQq1KgpfOBbgsKkiEMuIIj
X-Gm-Gg: ASbGncs6yRKpEchpF2e7m23k3JQrduVxqNozuMjuJ39I/l6CV/yPLQLteFPy+aDKT5v
 ZsUCaYNfDQnjn02bG72OQuWZsJn+xj0dDSuTkjJYafO311bMfXaApwXUSdv55eO7dlGqU/NatXI
 HnXpNPGdSAX0U6qwIfev9CIbMYw29LOXD4EUgFVyEQEYhlx8oSoIst4tZ735iFHVOwgnJzOw6gk
 kOOsofCnZrIYMGU4a6PvFplL0kFStIECP7hWJL24Bq/a1I2uzknSHpixEkhbS/THBVgdkQaq6On
 YoyGCtEV/723pWrwLkOmNbhjlICOxTFBv67/ehImGUKllNZjjqnYs6oBOvc2GWWr6eH9F+Z6qjf
 ACWGOLPIQ+U8ALSMidNyke+r3RbHD/N/1m1QeLofYjkc=
X-Received: by 2002:a05:6000:1889:b0:3ea:4b52:af6f with SMTP id
 ffacd0b85a97d-3ee7c55296bmr8888753f8f.9.1758540750647; 
 Mon, 22 Sep 2025 04:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1q2r8mkc5IUdSiS6stXeaLnmGHcIJ2njvM/yCmU7hetYiC6Dme2Zvqcp1ilFyUfoaDtgF/A==
X-Received: by 2002:a05:6000:1889:b0:3ea:4b52:af6f with SMTP id
 ffacd0b85a97d-3ee7c55296bmr8888722f8f.9.1758540750150; 
 Mon, 22 Sep 2025 04:32:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f3252260csm149377605e9.2.2025.09.22.04.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:32:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 3/4] docs/code-provenance: clarify the scope of AI
 exceptions
Date: Mon, 22 Sep 2025 13:32:18 +0200
Message-ID: <20250922113219.32122-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922113219.32122-1-pbonzini@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
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

Using phrasing from https://openinfra.org/legal/ai-policy (with just
"commit" replaced by "submission", because we do not submit changes
as commits but rather emails), clarify that the maintainer who bestows
their blessing on the AI-generated contribution is not responsible
for its copyright or license status beyond what is required by the
Developer's Certificate of Origin.

[This is not my preferred phrasing.  I would prefer something lighter
like "the "Signed-off-by" label in the contribution gives the author
responsibility".  But for the sake of not reinventing the wheel I am
keeping the exact works from the OpenInfra policy.]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index d435ab145cf..a5838f63649 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -334,6 +334,11 @@ training model and code, to the satisfaction of the project maintainers.
 Maintainers are not allow to grant an exception on their own patch
 submissions.
 
+Even after an exception is granted, the "Signed-off-by" label in the
+contribution is a statement that the author takes responsibility for the
+entire contents of the submission, including any parts that were generated
+or assisted by AI tools or other tools.
+
 Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
 ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
-- 
2.51.0


