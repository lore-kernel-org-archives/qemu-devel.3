Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875EDC52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMgY-0001vS-8K; Wed, 14 Aug 2024 18:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgW-0001uy-Ew
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgT-0007LS-Ur
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fd69e44596so2492225ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675296; x=1724280096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+CPT1Wcm5Loouzy0QjXsIcxjBTGx2lwMSs6X8Aj1VVY=;
 b=wG42akDD1l4lXaOXYd73AjggYIELFP3OShAIbqoAXIjEN9LWQ4LDBO1vkPH41RyVr9
 peMTp85UvTmuK3x39VCqFxGeZ/DgMP6foIzryx5tM9y5Mq7KTUdgYtNtG0gdo4/dw7JW
 9C2CWdz+6rGYaUEdWsVQsiIe44/E/MepUuZD07lnRFEZqd3I/4lSaonSJo0hVVW2p+kS
 DE1Ae/f0hNVZpfLx3XBnMBNIKw7RZ5tGqVDEOnB/0f1QkMcm2sN3tRaM9Rlkqp7EhyPm
 R1VOURCn6N1SYmwi23UC3ZkkDGpyWV6Qs+PYboZ+C/2LD02O9ymUp6VMsnz8+jRzu5gI
 Z0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675296; x=1724280096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+CPT1Wcm5Loouzy0QjXsIcxjBTGx2lwMSs6X8Aj1VVY=;
 b=Cm9FNUuJj7spTrJLFVLZxLW5eJ3OSD7W7pLj9IKdZgRg3aGQ9p7S+sUg2Bl5aAKUKb
 9WF0uFdHgxdntNt6sdZElyNzULfCm9VpeS8wvZfiWBMxBWlQULOXnM6EEt5r+TpaDkli
 l1vow0DH2uFstMcpvAhNFst0B1quYpHjEzf33aaMWctkOe3HcV6jl5MMOyY8PmzvgChz
 4lxD4XyiaXfoTaYRlERcfnht7IBrE9u7z12kF8n2I9f0W32CkLy0bSjG9hSojOVIcg8n
 tgXDV2D2l4OadDoK8EFCwdnKIjkCZct9LU+w2FQpsQN8bZiPsHHZZ28GQcQjwpazAOzS
 MLhQ==
X-Gm-Message-State: AOJu0Yw/rJ5DgNFBaIKXR4tLE9wLO/WpdcZYc5t4j0Vx7dFYJAaxqEjZ
 xP5OXSOBsd2nTV8JAHqQ1MMFeSqE+s44JwsR69dd+JdmPBkNGbduFFbRQwAV8GfYNJHgHXvmty9
 FMc8=
X-Google-Smtp-Source: AGHT+IG7gxkJQzoz85Nl6gIYhEFIhQRnI1kEpARmF/7Y+15rka8ekLMz3X97T1LAnWwofpIENpZv6g==
X-Received: by 2002:a17:902:f64d:b0:1fb:8e29:621f with SMTP id
 d9443c01a7336-201ee4bc33cmr19854555ad.16.1723675295973; 
 Wed, 14 Aug 2024 15:41:35 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03b2874sm1225595ad.308.2024.08.14.15.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 15:41:35 -0700 (PDT)
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
Subject: [PATCH v2 0/4] build qemu with gcc and tsan
Date: Wed, 14 Aug 2024 15:41:28 -0700
Message-Id: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

While working on a concurrency bug, I gave a try to tsan builds for QEMU. I
noticed it didn't build out of the box with recent gcc, so I fixed compilation.
In more, updated documentation to explain how to build a sanitized glib to avoid
false positives related to glib synchronisation primitives.

v2
--

- forgot to signoff commits

Pierrick Bouvier (4):
  meson: hide tsan related warnings
  target/i386: fix build warning (gcc-12 -fsanitize=thread)
  target/s390x: fix build warning (gcc-12 -fsanitize=thread)
  docs/devel: update tsan build documentation

 docs/devel/testing.rst       | 26 ++++++++++++++++++++++----
 meson.build                  | 10 +++++++++-
 target/i386/kvm/kvm.c        |  4 ++--
 target/s390x/tcg/translate.c |  1 -
 4 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.39.2


