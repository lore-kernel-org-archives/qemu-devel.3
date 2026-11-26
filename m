Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308FE606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fp6FhS/y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaaO-0007rh-SJ; Thu, 26 Nov 2026 09:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa9-0007bj-Jx
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa5-0001fu-7Q
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so61654625e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795703772; x=1796308572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nsk3fLPm7OZUWnuZkBr+3MNBAw9oM/IWgRRZixghfFo=;
 b=Fp6FhS/yz+IQpr9YkMZGKRUnZ7fC5HFiNa2km9zTCBeVctekg3UynPEZ5c78WVv7Im
 wUY3Z3jmvU54c/zBw3YEhHAnR2QCO/DEADHFAlk0otGnLlnkbIG+48FjgX4Nxgk9vmsg
 PT/K+1Pfvh8gVCLh7KnNqk7cU8gWi1wYLPzBnrgD4dPB6fbdiv3kb/bWHlnLHhJgJk9K
 /D8xQfclvUl1PCx3nIsFXGuwDniJkyZYDDRv2m4j23waOlKwlM8krFIktFYSrdlunz9n
 i9+653ZW5G0vpOJYPmlDhW/UxTB8kyYgOPgTPwvebpcoEeflO6ZOnkq0t0oEC+uBwHvI
 RK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703772; x=1796308572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nsk3fLPm7OZUWnuZkBr+3MNBAw9oM/IWgRRZixghfFo=;
 b=uuGnyhlz6O2U8rCB50Xa7KCMrPDWUl6CkEG0PQnctYLRyrR+MgFDZ8mhV7Kedk4XWa
 JhETnrkPca0RiE+r2ibWc0z1qdKYSOMDaFO8FUExw9NUdsTdZ8CBZ5k9w5PB9Owd4alf
 ojzEL7znW0Qr3cCXm6jYVeCw7CIs4qGwqeywWlkYAWItoYZpEiMWx7SafBzpsfrk3KEK
 pgH7J58DvetTsL3iaLjfS19dooM6ELPOjYfyORx6tCLfCcFCpTdyaybsmRc0eDQ9u8bB
 bGRMAemhdtJVqTZPmT3QrGB0pvJIlA9apoHBNvlziESNVN82i6ntwFYoOWt0oNFtHSmZ
 udVw==
X-Gm-Message-State: APuU4Z82DpzuMJv+VfsxVZ26wcGZT4tUIyz+pRNqX48RKx8LHy8Ddlvd
 GFIh+GaQONLfpBPJCLaoLn1kiHwUfE37kvNwHt6ZLjepC1D5GMe1oKdEN9dXh/NGNgg=
X-Gm-Gg: AZFdTZen3Sn5ilmVTC6OIJTdSKOvphBjpp9xgmL+R5JIuDF2+UYG9NYl5GIO/zV5O/B
 HHlyAA1A3/dBmvFG7gl4ToghUiZF2/ymcOqbs3CAbFwppHS9z9oaruDlTeDoG+pLZ/k/9RRLNEG
 EOvPtZ7n8nxy+JiUS45wUv9ahAK1UgvLbQGLYbuaMuiCV4JjgAMcsom+1wOR8AW3usFzKeG8sjP
 xTfkOWSE6m4fJrGGsZVOKr5GMHQi14UxmvE3/rDmlx9GgT3QcwiLDV7IJ7vTStSNlUV8L1Ov60z
 PjbnKQ94I5Qk8hJAgf9AKAzugYPu0fA2DQZtY6DtJ4LB+Et7qcRC07xVyw/VnD5N5lcscVr4OIl
 oS/3fpvbtXZ/nJGCd2pqY5zLY/sxmLk3QvE5epB+5LwZKmA/NixFVXkQMZ9Bqj6txIe3XUbX7hG
 q3PMxMzkmmx6Dcuf/If37EZaGrzD61d/fLtSTl4qdjbVARg6Jx4HPVViY7hjGCwz9URezBuSBnr
 QVkML7amZb21XR6UXN2ACTUCBJv9Kh46X3a0zYB5oDvhN+fT1fPunsxHAgHncTwDvjeSuN4Xod7
 r4boshEHrDv4ERiKcICI3RRXBgRU
X-Received: by 2002:a05:600c:5303:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb88785d24mr412664495e9.0.1795703771390; 
 Thu, 26 Nov 2026 06:36:11 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm566256175e9.2.2026.11.26.06.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:36:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1E095FA33;
 Thu, 26 Nov 2026 14:36:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Chao Liu <chao.liu@processmission.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/8] MAINTAINERS: update security reporting links
Date: Thu, 26 Nov 2026 14:36:03 +0000
Message-ID: <20261126143607.2374676-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126143607.2374676-1-alex.bennee@linaro.org>
References: <20261126143607.2374676-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We've updated the online pages but we should make sure MAINTAINERS
doesn't point people to the wrong place.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261120200511.822573-23-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf701b11cf1..ad9dfc43898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -82,9 +82,7 @@ F: docs/glossary.rst
 
 Responsible Disclosure, Reporting Security Issues
 -------------------------------------------------
-W: https://wiki.qemu.org/SecurityProcess
-M: Michael S. Tsirkin <mst@redhat.com>
-L: qemu-security@nongnu.org
+W: https://www.qemu.org/contribute/security-process/
 
 Trivial patches
 ---------------
-- 
2.47.3


