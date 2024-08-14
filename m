Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D32C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMga-00028e-U5; Wed, 14 Aug 2024 18:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgZ-00021L-4T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgW-0007Ls-Qn
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so3563685ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675299; x=1724280099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix2f5gCzV/CdkxjLWnI0M17lOMP/hB/dGS/GHu24vmM=;
 b=GZEApvKJLZFVkB7XXbl7q+u5BDzuUJ7iX2wrMc0On44aBEm5brEcwyVOC6YKQKwBEF
 B6zbBBPQdLCOJ9U0N27BAOrgNiSLOWcS1Or3U8Q5ZebCD7c+7jTEwC6TjK+UkeKWiLF3
 hyIl1rzSauk9QyTHhrKvTbxMrNRSb7lQRDl17AfnlLAAjPcw9i+3wSa0uNGyvIcmrQ+f
 11PYsRAzk/GEmLXzH/fjxLVEMo1fG4ghr4Q05HmN4w2RNpI0Pu071MUg6E8gVh2jAjL5
 7PcoYQo3QSyWZBQW1S0eRaVQwnzLYDKyVByJvtsanTVSFUrMHGITLuYlMf7FQ4XQGOf6
 vUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675299; x=1724280099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ix2f5gCzV/CdkxjLWnI0M17lOMP/hB/dGS/GHu24vmM=;
 b=LNo9sXjYPWWwsiXMnnUlkccEGeTD4CZ5Qt0oFf7eKMIw7xw2Dm83DQplHWZEQxEgcd
 uIQBEZF90GVfn62Ckr8c6QmbCn5b2/LOr3GQjHS2+tVnmH7Vm1rW22TxOB4ZuwKdfPP4
 f0rYbbtwWKENX3N1iLcESwJQqKGibEjPg0SDCtKqjbU0wh5kZEqQVYsaqE4d+Y7CJzNZ
 EnCPYaxr2aMw8/lvfvVExU+CdpywuY1+kyW5eVhKKJnxpPQIjeEZvXI0i3di+ySXmFTl
 S0vcKmb2HPRVLboI//cz0x3EMPN5j6PzzWq7WPPLt11fESwSHP2C+GFjdPBJeSZ3im9J
 RkkA==
X-Gm-Message-State: AOJu0YzR6vp6RxulnuQVmToLXIvNhJRoKRnUBvpSgKSUf8PajJ15f9ED
 58tmFnC3FALizbd7blNUasXUDhOpDsYNTBkNJta5CLjKnL3Oj+r54Bp87mb/aBUdUjkBLt8cIsF
 OVDA=
X-Google-Smtp-Source: AGHT+IEcu9RodvL06jYwIW+MbnMmHphUULHzOODkrJsSEEKFjCAGokM2BML2UnWqSdowzt0TfjMKog==
X-Received: by 2002:a17:902:d508:b0:201:e792:d6ff with SMTP id
 d9443c01a7336-201e792d9f9mr31346215ad.10.1723675299512; 
 Wed, 14 Aug 2024 15:41:39 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03b2874sm1225595ad.308.2024.08.14.15.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 15:41:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/4] target/s390x: fix build warning (gcc-12
 -fsanitize=thread)
Date: Wed, 14 Aug 2024 15:41:31 -0700
Message-Id: <20240814224132.897098-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Found on debian stable.

../target/s390x/tcg/translate.c: In function ‘get_mem_index’:
../target/s390x/tcg/translate.c:398:1: error: control reaches end of non-void function [-Werror=return-type]
  398 | }

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/s390x/tcg/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c81e035dea4..bcfff40b255 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -392,7 +392,6 @@ static int get_mem_index(DisasContext *s)
         return MMU_HOME_IDX;
     default:
         g_assert_not_reached();
-        break;
     }
 #endif
 }
-- 
2.39.2


