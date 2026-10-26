Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC0606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DMv6noJX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKG8-0004Ww-6p; Mon, 26 Oct 2026 08:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG4-0004WR-Dp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG2-0002ZI-Th
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so1746772f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793019416; x=1793624216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w7iSxPg+1QsAQpJtRyhk++7OtyLKzOOGXEnoXyHUruY=;
 b=DMv6noJXZWtgJsb59st7Ls7sn1sySbJaYlanWSAtRFM3rv/DBbAnIxYKOwL9KoTVmh
 4X0WK0hrp4AxaNUh8xj3rleExUA53fSEjn4TGEIn8EqTeD5vqT5cBNwKxHkIcLF3a4QX
 wAagpg3xEGdg54jG50ltm+aunU7ZYMqrWBEekYifrBeQ0W65hZxClDN0n06U4G9K8wFv
 qzt6PSn86eUHfa80K3M1wO4XkqM8Srs5ykdhfRIxDj0vEmr4xxCy8iVslNdPa29irHod
 ANVX7ufUFH3v5t80q5gUJsg8vjAI/nVBP/qcF3Jo2ovTdVE5xdbBtdo7L8BV8ID4xJeS
 jnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019416; x=1793624216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w7iSxPg+1QsAQpJtRyhk++7OtyLKzOOGXEnoXyHUruY=;
 b=onbSMlT8D5D1ZECcdJwOTmlnKjY+LCkvH/0A+x2HI/rHifj6RUnSRFvok3q1C6e0Z+
 89dDQLtQh15ct+BhTBLx3yzn1urdQDHZF5dlPIiHUZNFqpa78UD8Jie/tFZzWkcnA1Tn
 uH5bGhupxcryGyrvped64UJl6/w0CqjFgO+DuvjdOnDp0C3ce0Cgp3kgAJTZaud8O821
 mvvNTpEE2UFU87WmCrAnPPiLvQ7kM781GDPI06F++ktXkMbVhjWqqXo3guQ4728Gkd6/
 sJqL3/3qUKl+jH8fNkjRnikZhxcxQp7GZgza4C/OiNgQ/WMz6peHjDz37o8DY+dfnS/T
 CFOw==
X-Gm-Message-State: AFq9FYKmW0gOq7MqGyzq6kwOeebUjN+7vMbejHUT8uKxjnye/1lg5r1Z
 wzrYTTmrZkNDw9rYuTFhSzdmoLE/t/pI1pTUq2K0DmxzFou7llmxAqH25stAlUGcpM22ofK0x07
 wJ3v2B2w=
X-Gm-Gg: AYBFou03yWs0JdGuEV608UppgQnOtFz2UrQshNA2JPnzzcNKWj4HULKX7GVGdEIu4qJ
 l8+1mQe2yf4HuvLwK4SZzO4FFeBQ/PrQOajQvVrH01V1qeXkggBFhg9+ewWU05JgEtfoiB8Xw0I
 gTDHk5pHDT39pjM7bECauDZsJzeXYpSHHtbwOwrlR4I8O+etBdXRCq5MhzaashdPav6GWRkfddx
 odzp9jLwJFO5sY56TOgwPv2A0ecHO+3uo6VixXSssLdeMrWb12P6ep/L7ZCxxzwXkhstft5pWBE
 hI1X5mzmplyhEt1NXu/sW9Kb1i2z6cAaDk9IjtPxW63XfiCPyUPuhgluUO1sFBUG5wP5hmgTOCw
 6+VUfTSAn7LdIjXxB840dDFdFMYs+1IiaqXWqsqrJUIZmBBcPwx5YuRjlThDOvyT8Lo9elB117l
 pj0wrwJ5hjbwNQhA8n4Jv8EeLIf1FraJE0o1xqPsAaOFeeaxG8MCglfoQCBq3HyiClS4ph5P/G0
 TYOZIPhuZ14u10bqdEGXYUSKH2gYrvxWKWHBzmzosEgJ4ZtlzI5u3HTUCPWgqDptEnlcLEB1h8F
 uxZKPw70HhTJaYyqrccjX6wtRtlnCxbxXeoqkhf+1q7S5fMXcXna2/9u3/V7
X-Received: by 2002:a5d:5d02:0:b0:48e:47cc:6cbb with SMTP id
 ffacd0b85a97d-48e47cc6cd3mr10905684f8f.38.1793019416471; 
 Mon, 26 Oct 2026 05:56:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm20740192f8f.49.2026.10.26.05.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:56:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] qtest: Remove 256 IRQ limit on irq intercepts
Date: Mon, 26 Oct 2026 12:56:52 +0000
Message-ID: <20261026125655.2668658-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently both system/qtest.c and libqtest have a 256 IRQ limit
on the size of an irq_intercept_in. If you try it with more then
qtest.c will overrun its array, and libqtest will trip an assert.
We have some real devices in board models that use more inbound
IRQs than this (e.g. the GIC in the Arm virt board).

This series removes both the fixed-sized arrays, so there's
no artificial limit on how many GPIO lines we can cope with.
I also fix in patch 2 a bug I noticed while doing this, where
we don't check the GPIO group name for irq_intercept_in, so
we apply the intercept to every input GPIO group the device
has rather than only to the unnamed GPIO inputs.

I haven't bothered to cc:stable on these because we don't
trip over the limit for any of our existing qtests, though
I don't anticipate there being any issues with the backport.

thanks
-- PMM

Peter Maydell (3):
  system/qtest: Avoid fixed-size irq_levels array for IRQ intercept
  system/qtest: Check ngl->name for irq_intercept_in
  tests/qtest/libqtest: Use a GArray for QTestState::irq_level[]

 system/qtest.c         | 47 +++++++++++++++++++++++++++++-------------
 tests/qtest/libqtest.c | 28 ++++++++++++-------------
 2 files changed, 47 insertions(+), 28 deletions(-)

-- 
2.43.0


