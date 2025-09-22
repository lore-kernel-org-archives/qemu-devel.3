Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560FFCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0emh-0006pP-5X; Mon, 22 Sep 2025 07:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emf-0006my-2W
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emc-0001o6-JO
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmjCvKE2KZ9MvOeSVe0nK+7Cl7nS+ztuqS5eW+FOHnE=;
 b=G/oYxy608QP2q5X1F8aHhitpMCXVktnNkjetxG3DsG92jpSgLb14YMxCPm5DGBtrg2izLC
 d9lEdzU7iiLADoQykWwJ1zGMz1anHutLqBAnNYwAMMSIudUEVnrTQ4oMAjJMBfzv2oHThg
 j4nHQ7PBg8pOKNd0t+Gl+8/aXh6nslk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-feVeFghdOS2btcoKNguC-Q-1; Mon, 22 Sep 2025 07:32:35 -0400
X-MC-Unique: feVeFghdOS2btcoKNguC-Q-1
X-Mimecast-MFC-AGG-ID: feVeFghdOS2btcoKNguC-Q_1758540755
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45de07b831dso27100745e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540753; x=1759145553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmjCvKE2KZ9MvOeSVe0nK+7Cl7nS+ztuqS5eW+FOHnE=;
 b=wVHB5o8NJK8vB+BKeILPsiJQCRDJ3ScZbInyGZzkYUh+9BzPSjkvhFOcaPFfD2H4q7
 X9cLlXyqDT2r9Sodz/Gg8oXsbOVAg6nIYxYR7DN6LYpxgF8LczwgJFXSZLl8Q3sQyKCW
 RXcveNoEWSnIBlZ20+VOcFndG/NeZZEa3ihI6r0ClDqyFxNoeRs6VLzDs5kAJ7Dnc01a
 Q1bAOmmKc9ADFxRxgf4mMm9hqiX2Swwuv/lA9saP6yNRFAAlU7xy2vU0q/3sHzX0Swia
 v92FV4f+KImcn5zjsOPHVQwIeZG+W80Ajm/7gZMP3dZ+KW9TT2EzFR1/5Fm3tFUVNWE9
 +OAA==
X-Gm-Message-State: AOJu0YzUbdjm1DdmQuuEjTKWIsRuO9lhOco3gBPivSmdqPpMtMxAngUD
 dWj+BJaDoqjqAVroBqrStLabcPDaQHcvxN2CqAfVLaXFA75Jsc3WX2SNB4ZTMIt/DBx3EOSi84h
 R0MfC2eKer0c5uCLsyCfTJAr+b0vY71xj7tMjvMUsfJ/AtGDA6UFWOiEXBLD1vd44l/VmWfQ/Ae
 wEswwDJ6U+OeucDueKx7JZgT6m2zeB8+0dKPIdVfmw
X-Gm-Gg: ASbGncvqRziC+kUB4MGFKtoN4ubmJ93Ga+I9I+Oim4b7Ydvy0mI3z+V4d1+D0tjo2oq
 pom09YeYUAqxCObLgiS50sshMynJtc5nczZ/Yvjfr9Z8imKLnnfxs6xtwogv/G589BxjwOXfYxc
 52eqQqqCdLWRCvxQvcp//Vjskqt6jtrmaqsEga4ByaPn4Dj5Bm39nR4apJ3wvDSzccdrchAvJlN
 cI4D8el1pRA+D87bwFSuiBMfsFloAkdMlNKFVIXVfq9ylUIK02M7JsxtKe/IMF1YBZNsU+4Ujuk
 e0EbygoPPXXsNc/fAHTbHWQigyAXWpD1Edwwasqf1HvpCLKTuY226EED/YGByd7Zee6SdAbFyAw
 LwOBmk5/K4wbkn4YExUXJWEnBN5KgZ2Pk64HWTfnh3x0=
X-Received: by 2002:a05:600c:a02:b0:459:d645:bff7 with SMTP id
 5b1f17b1804b1-467e7f7d5bamr124393085e9.12.1758540753533; 
 Mon, 22 Sep 2025 04:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi17/in/5G0gZol21kyOHEaafc9QQG6REn40VOx75k5tCgBGk5jQS3l5BfyYqQmU1HUgw8JQ==
X-Received: by 2002:a05:600c:a02:b0:459:d645:bff7 with SMTP id
 5b1f17b1804b1-467e7f7d5bamr124392715e9.12.1758540753071; 
 Mon, 22 Sep 2025 04:32:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f5a281f1sm198444195e9.17.2025.09.22.04.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:32:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
Date: Mon, 22 Sep 2025 13:32:19 +0200
Message-ID: <20250922113219.32122-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922113219.32122-1-pbonzini@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I do not think that anyone knows how to demonstrate "clarity of the
copyright status in relation to training".  This makes the exception
process for AI-generated code both impossible to use, and useless as a
way to inform future changes to QEMU's code provenance policies.

On the other hand, AI tools can be used as a natural language refactoring
engine for simple tasks such as modifying all callers of a given function
or even less simple ones such as adding Python type annotations.
These tasks have a very low risk of introducing training material in
the code base, and can provide noticeable time savings because they are
easily tested and reviewed; for the lack of a better term, I will call
these "tasks with limited or non-existing creative content".

Allow requesting an exception on the grounds of lack of creative content,
while keeping it clear that maintainers can deny it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index a5838f63649..bfc659d2b4e 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -327,9 +327,17 @@ The QEMU project requires contributors to refrain from using AI content
 generators without going through an exception request process.
 AI-generated code will only be included in the project after the
 exception request has been evaluated by the QEMU project.  To be
-granted an exception, a contributor will need to demonstrate clarity of
-the license and copyright status for the tool's output in relation to its
-training model and code, to the satisfaction of the project maintainers.
+granted an exception, a contributor will need to demonstrate one of the
+following, to the satisfaction of the project maintainers:
+
+* clarity of the license and copyright status for the tool's output in
+  relation to its training model and code;
+
+* limited or non-existing creative content of the contribution.
+
+It is highly encouraged to provide background information such as the
+prompts that were used, and to not mix AI- and human-written code in the
+same commit, as much as possible.
 
 Maintainers are not allow to grant an exception on their own patch
 submissions.
-- 
2.51.0


