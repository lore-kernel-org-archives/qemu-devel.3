Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F052DCAC5AC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0eme-0006mR-Ee; Mon, 22 Sep 2025 07:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emd-0006mF-65
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emV-0001mp-35
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nWERQs0gx68cUky6thZXziNgeqaYxglGqCt+cI8zA0=;
 b=Y+H1w3PedivZ67olxiwAWea8HDgUAXQG+4Y21OrWpk6fUox72OvRVDJhTURSRs9anSH0NO
 qQPFC7DsSU//2nly8XkV0S9Hh9AmGf5s6xB+Cmf4i753h+2YhsC0Fs6QrV+Y7ofPJpYgKd
 jQbQWPym40gwGGo35e6G/7hE0BFZylQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-BZdGLgBeOuSmrUOdqizDvQ-1; Mon, 22 Sep 2025 07:32:29 -0400
X-MC-Unique: BZdGLgBeOuSmrUOdqizDvQ-1
X-Mimecast-MFC-AGG-ID: BZdGLgBeOuSmrUOdqizDvQ_1758540748
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd9a66cfbso32915385e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540747; x=1759145547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nWERQs0gx68cUky6thZXziNgeqaYxglGqCt+cI8zA0=;
 b=KTRebr21Zm5DY5nfKScHKtIQh31DzTMh/E2WtbjK01lOtOtkGxYGskxjKUNjqt2mZR
 l/Fdy5KLnI9SB1EZwSiNpDp31FHslPHB/F4WcP5o2w5X20x7k7VhGnkYqyABAsO7ehAW
 W8lYPclFcOzOt8VoybTTsRdipH2gMbuaNwyQPCAJh831l0kh8SlBP3wQg2umzVC2KSSG
 hqGL/iv4T2ZDo4b16p3THKD/YSFF+z+XLNF5Wup+WSIv1jdfFAfmXSAgx9Lj/rByn+Ae
 zgZZvc8ItdKXh0nolZ4h3SyS3OreR3J8TjMGseWflXokCgYPG16AnsELK3KXc59etdUn
 pEGA==
X-Gm-Message-State: AOJu0Yzh8Y1/S5Ao64MxRI4lMkBbn1i9Oi2jF47/OeZmsxQJ2sfxLV8R
 Km74g5lmpYsu+tPvdl0I444dx8oHv6/OaLq0e3SF0bPL/a5XP81AVf49X2bC+9HO6vqeswfyzaa
 nX82ToViER4Fl7IKv5dqcCCmIthuFehQ7s3EVlqWeq/LW5ebDNMkleuIaeOTvlK8P5LxUanKxVf
 YD3qIM4J7jb15eQd4YPdrGv/jjJ2KXbRDd/3txYZPQ
X-Gm-Gg: ASbGncvv9VwR2kTT3XB4tnc5BJeR5MPWug0vbhHN5z/lbrXxeB/lxibeme6fMYNHlW8
 6ko72nmTYwxOkZnljWpzCCPR8EtjfQ38m/qxwUmi+MY6EVKm2B+gGfA4q0ygIgskqwY2ZxkDL3e
 5KmgNhB+gV73taCH92G+O6D26Rlm1PmgDxHsrCX6q5tbJr7Z5N6M+Ve7b4Ba2h6Oc9aZPWmDFYg
 sSHuECopPsb0ADRmvkTuRvviWD9GDmss8qu299IbTSDIF249wdAgx6eooddmYSUvKpVwHur7JBv
 xokkNfLLKxMKVIYwSXpg5grWwtKeh1N9xbrvcRIXvVD+f5teKiBM/Ddrzt6VIjZV7gRA9RdeZ2C
 p8L+JgFrKOQ7Kq92L8u+rgUgEC0nHkyL1+JAmX4ceE6I=
X-Received: by 2002:a05:600c:4f11:b0:45f:27fb:8017 with SMTP id
 5b1f17b1804b1-468a10cd520mr139094355e9.5.1758540747090; 
 Mon, 22 Sep 2025 04:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFl+GdkVjdTZ0hNgRfqR0pPSpzItE6wpEzF5hhiKrstG/6GfqDD6Sm8KkZXHLsXBd20GkHDw==
X-Received: by 2002:a05:600c:4f11:b0:45f:27fb:8017 with SMTP id
 5b1f17b1804b1-468a10cd520mr139093985e9.5.1758540746600; 
 Mon, 22 Sep 2025 04:32:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1afbb26asm2059215e9.8.2025.09.22.04.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:32:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 2/4] docs/code-provenance: make the exception process more
 prominent
Date: Mon, 22 Sep 2025 13:32:17 +0200
Message-ID: <20250922113219.32122-3-pbonzini@redhat.com>
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

The exception process is a second thought in QEMU's policy for AI-generated
content.  It is not really possible to understand how people want to use
these tools without formalizing it a bit more and encouraging people to
request exceptions if they see a good use for AI-generated content.

Note that right now, in my opinion, the exception process remains
infeasible, because there is no agreement on how to "demonstrate
clarity of the license and copyright status for the tool's output".
This will be sorted out separately.

What is missing: do we want a formal way to identify commits for which an
exception to the AI policy was granted?  The common way to do so seems to
be "Generated-by" or "Assisted-by" but I don't want to turn commit message
into an ad space.  I would lean more towards something like

  AI-exception-granted-by: Mary Maintainer <mary.maintainer@mycorp.test>

but at the same time I don't want to invent something just for QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index dba99a26f64..d435ab145cf 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -292,7 +292,8 @@ TL;DR:
 
   **Current QEMU project policy is to DECLINE any contributions which are
   believed to include or derive from AI generated content. This includes
-  ChatGPT, Claude, Copilot, Llama and similar tools.**
+  ChatGPT, Claude, Copilot, Llama and similar tools.  Exceptions may be
+  requested on a case-by-case basis.**
 
   **This policy does not apply to other uses of AI, such as researching APIs
   or algorithms, static analysis, or debugging, provided their output is not
@@ -322,18 +323,19 @@ How contributors could comply with DCO terms (b) or (c) for the output of AI
 content generators commonly available today is unclear.  The QEMU project is
 not willing or able to accept the legal risks of non-compliance.
 
-The QEMU project thus requires that contributors refrain from using AI content
-generators on patches intended to be submitted to the project, and will
-decline any contribution if use of AI is either known or suspected.
+The QEMU project requires contributors to refrain from using AI content
+generators without going through an exception request process.
+AI-generated code will only be included in the project after the
+exception request has been evaluated by the QEMU project.  To be
+granted an exception, a contributor will need to demonstrate clarity of
+the license and copyright status for the tool's output in relation to its
+training model and code, to the satisfaction of the project maintainers.
 
+Maintainers are not allow to grant an exception on their own patch
+submissions.
 
 Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
 ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
-
 This policy may evolve as AI tools mature and the legal situation is
-clarifed. In the meanwhile, requests for exceptions to this policy will be
-evaluated by the QEMU project on a case by case basis. To be granted an
-exception, a contributor will need to demonstrate clarity of the license and
-copyright status for the tool's output in relation to its training model and
-code, to the satisfaction of the project maintainers.
+clarified.
-- 
2.51.0


