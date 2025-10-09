Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6121CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQA-00089z-WE; Thu, 09 Oct 2025 03:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQ8-00089a-G2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQ4-0004JG-Co
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cRZKuLYf1PeX3kptJkawumw9y9xmtGwH/7o1mOtoO4=;
 b=SOclfsWJtNiKMp/YymH/n2MelCpcyxKycOapDyj9ug3/bXpauso4HDy2DhuAUsxZT3jWfe
 Quq9UD2n7psdYXSQYQriRWBdMrPS8N89KhXpZuABxXeTBvJzI/4h7e9MDEoshEGyuohfbN
 wOYPRTsDklrvlVdamGRqYw3GxMeR75E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-qUKCnBPrMCiCfb967RRbMg-1; Thu, 09 Oct 2025 03:50:31 -0400
X-MC-Unique: qUKCnBPrMCiCfb967RRbMg-1
X-Mimecast-MFC-AGG-ID: qUKCnBPrMCiCfb967RRbMg_1759996230
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso684956f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996229; x=1760601029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cRZKuLYf1PeX3kptJkawumw9y9xmtGwH/7o1mOtoO4=;
 b=fx+uuPTFHw6rv8g582ybYz1oi3TuNHbqIcz35HMA7dIHyriBQGH0GGUaaxEB0FswD+
 XDK/l6XuaAza5+hfMU/7H6w1IcR5Hgs/NmXQM3Nhm7b3Dya+El5klKbFAl6AVhDUdyu7
 EatnKksiQqpXn/ycsNmjLURIWxkfPyVWfVBjokUVLzeg5UYG2w5ro0tr2sfqgReNH0tI
 F7W/XnOzThjIqgWI3EWNKppFzAz8fyU6imghi45ss2/+YBn3zLZVuadcrIbq7jpvshl9
 m9nuN34C476PYCZBFM2di9cv3tACJor9SYBwjO/welvBkLVCqore0kwov8FYKMlEpvFH
 K29w==
X-Gm-Message-State: AOJu0YyjP3SZRtQsCqo0gl8yPlgdbRnWzILuBMVDt7TH44uGRaXv1pBQ
 5BkGvVxNR8S7+VG5snX6CAo5qCg6EsgkvQIY3l63tkBMmpUc6y5bcEAJFEoVkfgS/NCG31OBYSO
 4iKuAf4DemOkpRff4bleGpxlAheaXC693rAGTw/NgK4UVHO3haJxoa6Muhe2JOS+As2ARWBKaQ6
 aKWE30eLXKEt14CWbfnyTZE3MDb1fM4H/yJa+ojVSNq7c=
X-Gm-Gg: ASbGncvYS+lo33lYE9tUblrDipwvxidCat+y33xaYpLKNFwf7fIiB+xVB1/sHIjvbTL
 9tZWKHZKYJOZeEcGgTyV+PslC1DcTWClTJs3AuK/wAs0Zv7FRtBG+o27v4Hia/t3W8nGgf+QY8+
 8rYztyx6WMAJ4ApaIJd+l9wINf/vysWtUmYmKzahJ/aEkGdjdfTM+wvqupUw/Q+p9a2A+s9NUJC
 3kjOyMQs8Fyov6m/Bfmf1tPBrkTwRTGGDH1wndN+PREcZ2V7OmP1LCIdhwzUeh+ks3E+in38OH2
 y3duK30Umt/+vTdMDdQFE7OgAdTAG9lJrNXUs19IaC0oz5rjE/1NODibxTRCqXUDxmJ82ycil/O
 J0ldxkqLynPZX+ps/OzrKMhDq++uPebvVBugaxAaXn7VIuGKE
X-Received: by 2002:a05:6000:2c0e:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-4266e7dff05mr4046067f8f.29.1759996228950; 
 Thu, 09 Oct 2025 00:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkyTYv6M1S+Be8mcKj6gGA7rEyjy70kpY0Kd4YeHH4v29SLgbSy/ofY0SsqMsMwBIheu2ZWg==
X-Received: by 2002:a05:6000:2c0e:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-4266e7dff05mr4046047f8f.29.1759996228534; 
 Thu, 09 Oct 2025 00:50:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf09a0e8sm33914095e9.0.2025.10.09.00.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/35] subprojects: Remove version number from .gitignore
Date: Thu,  9 Oct 2025 09:49:51 +0200
Message-ID: <20251009075026.505715-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Get rid of all the version numbers, and use wildcard matches instead,
because peopl will repeatedly forgot to change these versions.

Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/.gitignore | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 58a29f01204..0b5d9634094 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,21 +6,21 @@
 /keycodemapdb
 /libvfio-user
 /slirp
-/anyhow-1.0.98
-/arbitrary-int-1.2.7
-/attrs-0.2.9
-/bilge-0.2.0
-/bilge-impl-0.2.0
-/either-1.12.0
-/foreign-0.3.1
-/itertools-0.11.0
-/libc-0.2.162
-/proc-macro-error-1.0.4
-/proc-macro-error-attr-1.0.4
-/proc-macro2-1.0.95
-/quote-1.0.36
-/syn-2.0.66
-/unicode-ident-1.0.12
+/anyhow-*
+/arbitrary-int-*
+/attrs-*
+/bilge-*
+/bilge-impl-*
+/either-*
+/foreign-*
+/itertools-*
+/libc-*
+/proc-macro-error-*
+/proc-macro-error-attr-*
+/proc-macro*
+/quote-*
+/syn-*
+/unicode-ident-*
 
 # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues/14948
 /.wraplock
-- 
2.51.0


