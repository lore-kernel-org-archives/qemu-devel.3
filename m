Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4083ACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKqp-0004uA-U1; Wed, 27 Aug 2025 14:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqj-0004r6-0S
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqX-0005nT-H4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VRifcALC9HJ5+Foto+SzUZAG5giZgk0/3Sb7XWLpHo=;
 b=ZqayalvHQeBfPfv2ZnE7y3LASosTqqcP3m0Dn1o5ksTRKGpowzBfHNU4yTCodafFTx+tZW
 LN+aMwhP6IMmyi2ApeJ+q1IUOOXP4COlt8I0bTBN7as8AdMWn/5tDGVtOzxJhNIGM7Ao9I
 urn34EfL6dPXvehgxoZQ25VbNsmIKRQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-SI6635G5OVK_DlhYMPsvdA-1; Wed, 27 Aug 2025 14:25:59 -0400
X-MC-Unique: SI6635G5OVK_DlhYMPsvdA-1
X-Mimecast-MFC-AGG-ID: SI6635G5OVK_DlhYMPsvdA_1756319158
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c9bf5c8b12so77433f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319156; x=1756923956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VRifcALC9HJ5+Foto+SzUZAG5giZgk0/3Sb7XWLpHo=;
 b=O6gA4duI62qO3TMeQDBJhCW0O/ioCZ45QjrTe/A/+BaAOtIEn5B4RrbGx5l9Tx17jT
 9h4gOJfI0QX1x56AmyUX6DltZzkUQRemGQR7JjBjgUZLfv8iJS9UgOcsFXidTIVk0i9+
 2pYMXnmSKNd+/CXnkN5+UYXCO2eIl9fdaZpU+xR1REdUXzpEuqjl4jOWm78gRXCciAfU
 ErTF27oQZk+pRSXuOWiChvCmvkAqRKKlDVfUMa12vNiVeJZWOTsdBKlz7odFl4ojNrMb
 5OZsaS2j62Hviyhni+fZka9gYtheC2U4nHqsx7kujXJvbrNnsQQROmTfEGbcJMXxo+ZD
 c0nA==
X-Gm-Message-State: AOJu0YxCKl2u707ZGq4Y+xHfZCmCiRqkVLhpgV7WkOFWKOPQFMjZaM3N
 7dhgvZnwubQYqVDgK3plT/GaGuRQn0GWJWbtUUXzdkZaAxWV/JCHhXccIe4ztbO+zsH4mKysFd+
 8x4/ycI2DVLapS2O0ziQQ/5kJMz5ELO29eDZd3LCE9N50czYlDzg7Z1P/LBEQaYUbTDUYYMS9tj
 wifAZxWdAxhgMRWOtda+iUldbmvm2xHB/AW1cP+nGO
X-Gm-Gg: ASbGncs2wosWDqtmzLRCg/iR43ANM4GD7Y9Jk9bTkRiIlhLJq4CTxcItuO6rbGKKUSw
 hFmElwl97Uel4brCHkNolitN1Dwb9ktDqfnla/qK4incWZfm79CbKMJ8H4XrkNLPrBOqsKdGny3
 BFd+HNzv1GaAHVKjETA+DtrShSVsm7NgKHZA8yt4FPVY32Y+2Nj2lAXjUW7cEO7bUdgSLd9yXE8
 pOkpF7O4dKyofYC4+FvVEY1fmTSu1NQivvi+eg+Dpk4Vy7LTOFZxJyOuqYBcsuRYZFH0vsVNwto
 zx6481VDFSBDzZbczBcxy1zMX4Saa1vnRUrZepBF2/vdAsZ2gKNMJzEaBvsfUObRQkqPWaP1I8O
 7PweE7yzr+e2iW4VYPKDlUT8Cta1brZ75jmBVqszNYBE=
X-Received: by 2002:a5d:50c8:0:b0:3cb:fee1:de33 with SMTP id
 ffacd0b85a97d-3cbfee1dea7mr3802340f8f.7.1756319155958; 
 Wed, 27 Aug 2025 11:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaTQhi8tnNlwspccnbYzWb444V2KHqcUn7ZLJZkgxtOXb0uxN9apIbnH6DYH8OaUWhzvfBgw==
X-Received: by 2002:a5d:50c8:0:b0:3cb:fee1:de33 with SMTP id
 ffacd0b85a97d-3cbfee1dea7mr3802312f8f.7.1756319155470; 
 Wed, 27 Aug 2025 11:25:55 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cbd534656asm6812783f8f.66.2025.08.27.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:25:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/14] python: mkvenv: fix messages printed by mkvenv
Date: Wed, 27 Aug 2025 20:25:22 +0200
Message-ID: <20250827182533.854476-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The new Matcher class does not have a __str__ implementation, and therefore
it prints the debugging representation of the internal object:

  $ ../configure --enable-rust && make qemu-system-arm --enable-download
  python determined to be '/usr/bin/python3'
  python version: Python 3.13.6
  mkvenv: Creating non-isolated virtual environment at 'pyvenv'
  mkvenv: checking for LegacyMatcher('meson>=1.5.0')
  mkvenv: checking for LegacyMatcher('pycotap>=1.1.0')

Add the method to print the nicer

  mkvenv: checking for meson>=1.5.0
  mkvenv: checking for pycotap>=1.1.0

Cc: qemu-stable@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index f102527c4de..9aed266df1b 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -184,6 +184,10 @@ def match(self, version_str: str) -> bool:
             )
         )
 
+    def __str__(self) -> str:
+        """String representation delegated to the backend."""
+        return str(self._m)
+
     def __repr__(self) -> str:
         """Stable debug representation delegated to the backend."""
         return repr(self._m)
-- 
2.51.0


