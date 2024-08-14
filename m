Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E145C531DD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHXw-0000hT-Ex; Wed, 14 Aug 2024 13:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXj-0000ET-Fa
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:15 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXa-0006CO-S3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so589115ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723655524; x=1724260324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Htp/8g1R2z3d38RDUYPogVSSaWK2pqHvMB0hVXVdWXw=;
 b=WrkA7QBYj0jxMAp3IH1dn3iN+T/p/6kZLP59CVLDvsDhcrAp9NKLFC6MAuGHFYekjh
 JS7KTTviw/we6kzu8BO6ypxGGuuVkzlA8ywVpAgoBhDSbbh1n3bzbgVb9J+z1lqkPARD
 PeSigcmTif7OD4G7R0dXrN79vsIsHjBQb/Puvk9oyGb9BVhsdcuk1jpzKLMzMvcbaQMD
 Jp+dy6XEfKOR4lSzu28JKY+otsD8y2Fb735aNER06yL1JqUMbU+X1Zszprx2p/8v8nst
 bz5jCIHDYgn0f4RmYv52rD8Y6PtDjprpBJdLeD0tx6ayP1B2XkpavsLfA/gMD4szgZ1B
 fIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723655524; x=1724260324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Htp/8g1R2z3d38RDUYPogVSSaWK2pqHvMB0hVXVdWXw=;
 b=ErRXZ/RBZ35bP0LMJlJHKXmP/uSrogu9BpYt9SrwmiWe6pyDZtaItPPoDlvfAWvXZ3
 ++58JVo8zmXZjYl9aeXlKXhvOmlFk9j+phDoxXWSSt4yTeW6jHR954MBadK0roei00mC
 TVxPM22J4zu9e4X2bW6PNFYgmUNxEQnkdfQsQAUTYqaAMkBxJzBUXxLGDq/J+r7gb2GB
 QdseVCs5KtJsDzJiNcOGgVVo4YoLfzD5Edv0XG64m44hybqF6SzOKzLMAB1pLG0LIK7B
 mZ8q2G7wbVbAdY4o8rNNV+Vy+ynp3c1X2LuZzyBRJGfGTowRTLPtrRNIPWyrHHLO9+VB
 7oWQ==
X-Gm-Message-State: AOJu0YyGIqFsbgQ8Bt1BHRWPimzbPG9Fa6XODfluL2rbA/DqjoOt+dP/
 7HRaNjbaLv7lKQiBGQK3R1/hZTnLzFvRfpWsXat+9uIKMyLUfoOiXG2rT/29FrLs5IDWN/LmJC0
 IO0M=
X-Google-Smtp-Source: AGHT+IETPkjiP32R23n1L+lgXiz7FUq2+2pRy2MPK5HVKPfPEe+6AsVieMnKEKbFzsWCaeqABPMWfw==
X-Received: by 2002:a17:903:2446:b0:200:9535:cf13 with SMTP id
 d9443c01a7336-201d6393a5cmr43674185ad.1.1723655523921; 
 Wed, 14 Aug 2024 10:12:03 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1c8783sm31813895ad.245.2024.08.14.10.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:12:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/4] build qemu with gcc and tsan
Date: Wed, 14 Aug 2024 10:11:48 -0700
Message-Id: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


