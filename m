Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9621CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0imj-0006u0-D7; Mon, 22 Sep 2025 11:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imf-0006tW-3m
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imc-0003Vx-7L
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758556133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96gXYKr77d918ni3I8qxfNdbU0gmWkPucw5ND1bSmNk=;
 b=DQmlysQuMcLsUnGmUb/5f2KUcBOXtEIhGxwPgwy2vpNHzkltCNBY0NqLBtbISRsdoO7VNH
 Zibl2099AutW9C/BgrxGbgYn4cQvJS1WwhXHqPBj9eTy1PjIxl63s0kXcdDAXfW9/qYlf/
 LUVKDdvLkVebTqA9eah1sQEcKseWka8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-f1A-87IyM1K8swnDv4OIcA-1; Mon, 22 Sep 2025 11:48:52 -0400
X-MC-Unique: f1A-87IyM1K8swnDv4OIcA-1
X-Mimecast-MFC-AGG-ID: f1A-87IyM1K8swnDv4OIcA_1758556131
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de13167aaso56438075e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556130; x=1759160930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96gXYKr77d918ni3I8qxfNdbU0gmWkPucw5ND1bSmNk=;
 b=I1XCJm/glrEX9dAr3A9y/2J5fp+hN8JDtmhNXvMaA+zyRbSVXflRgKEdpUmwocmR8L
 mg1RyK9xcDDy/alVhF62HV0X+JbIaEkTkVNA2QnIMNxXqT5mtTP8NaoCJRBX+oQtlx/Y
 1rkEWX/De/MGnpNqxlXJ5wQfp52oxvXeZoobUUDTIjvh/FuXCgoXHFPwXj+r2yq+Dq+3
 GZsH53m7cdUdDGGnwZQEqGoQZfuBVNdEKO9hAWf1/vXexMPBD7Pnx2LWrOoNkPc859oH
 h1ubK8+bYcioWXg+a524QyTGjHNaThrMvOQBBidiHxq+Mup2FGqwc/UavNspoa9XjgvP
 kXtw==
X-Gm-Message-State: AOJu0YwyjAt5d6GKOLFDy/Ybk0t0pgSjcFpMaJ9iNMRzVBfgxEFZzVYa
 RzGsWxkLAC8w9+r5Fh34QNYuDDV5Av7SaGPCtOnhOKKCZqLMX1pjLl3ImlUD1zxZEEP/rY3Mbwf
 FPWqrJz1VJi4Cf58gKFsT5wIK2n4NuZTRhFNnmQRcAiqiplsFc6Rqc/Wfb3zs9uTF/bcFt4Emwr
 UkeTW5EfoqQneVtwXg5dySwqpGAT/wAmH+z2/ajP/6
X-Gm-Gg: ASbGnctvl4xttQPsUKjH3/biMONv3hCV0pFLIuAjVkI0n6D2Jq/1Wp+DOhjATSkk2N4
 zUUQ4929Hcdhevb7TvaFYVIY0t6fCb1OTTGC12TmaJJwtmqJAXi3icdR8r7skpVDeLkYAikvX/Z
 hK1AuCXjTKWuS3fYor+y9xVYQGycFeBl59207cAYXe/ZsXPciVEfk0KmYq1sBUT1l3hs8dV2d2h
 4tEXDxXeVIVjCM7KaRy6IOlY33g1ssn+BNzR2YVkdJSvv4lCY2i7ssDzFdflSSfslIwT3sLasD1
 HnLC4JgthTsAaUqDHmHzMXMGUTMzgQdTLbWLzGwjtPc5NmgqJDpJy3fGa8fSKnpU7Jnua/T1wsx
 efRnzIQ8e1BoSzPv+9dMurxTIFCJyXgoz33sDwEoQ8Pw=
X-Received: by 2002:a05:600c:1f90:b0:46b:9ab2:38d5 with SMTP id
 5b1f17b1804b1-46b9ab23ac7mr66353875e9.31.1758556130311; 
 Mon, 22 Sep 2025 08:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOlvJeOm57XZgdFHV//Rn4kg1t0Z9BKB6T1xg6mD8gacxElcgyQohoQTUJWNQ4s9sA25bAhA==
X-Received: by 2002:a05:600c:1f90:b0:46b:9ab2:38d5 with SMTP id
 5b1f17b1804b1-46b9ab23ac7mr66353565e9.31.1758556129860; 
 Mon, 22 Sep 2025 08:48:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139122cb5sm243774455e9.8.2025.09.22.08.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:48:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/3] docs/code-provenance: make the exception process more
 prominent
Date: Mon, 22 Sep 2025 17:48:41 +0200
Message-ID: <20250922154843.60233-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922154843.60233-1-pbonzini@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

QEMU's AI generated content policy does not flesh out the exception
process yet.  Do it, while at the same time keeping things informal: ask
contributors to explain what they would like to use AI for, and let them
reach a consensus with the project on why it is credible to claim DCO
compliance in that specific scenario.

In other words, exceptions do not "solve the AI copyright problem".  They
take a position that a reasonable contributor could have, and assert that
we're comfortable with the argument.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index dba99a26f64..103e0a97d76 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -326,8 +326,13 @@ The QEMU project thus requires that contributors refrain from using AI content
 generation agents which are built on top of such tools.
 
 This policy may evolve as AI tools mature and the legal situation is
-clarifed. In the meanwhile, requests for exceptions to this policy will be
-evaluated by the QEMU project on a case by case basis. To be granted an
-exception, a contributor will need to demonstrate clarity of the license and
-copyright status for the tool's output in relation to its training model and
-code, to the satisfaction of the project maintainers.
+clarified.
+
+Exceptions
+^^^^^^^^^^
+
+The QEMU project welcomes discussion on any exceptions to this policy,
+or more general revisions. This can be done by contacting the qemu-devel
+mailing list with details of a proposed tool, model, usage scenario, etc.
+that is beneficial to QEMU, while still mitigating the legal risks to the
+project.  After discussion, any exception will be listed below.
-- 
2.51.0


