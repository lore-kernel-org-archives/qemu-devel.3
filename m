Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0AEC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNTD-0003gJ-H5; Mon, 14 Jul 2025 14:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSh-0004Y5-FD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSf-0001IO-69
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45622a1829eso2725465e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752512126; x=1753116926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GnuPhOvOnPLOfdX6XlrP4ky9ziluFD2vjxw40gSmZ1g=;
 b=jCYgYxSjp2tFVtEG6L2j9YDsGihp0kgEiSvPimbpVhG2XM2fDLVY7qopgh8CBBZARn
 01zAoCOJkrIkyxquZFgIhDJD7Gx3hVSe/SQ9jjo7+UVqkkyUXjQvGx+Vs4spLSFJzG5A
 DnDU1I5AynLdufdQKI+GQzDIVGliJrswaVFMKZ6ssLOeVMFnj2ESzu47H1InM2KizOkK
 z76qvmWTnyxPVTFpEnAs6qHTwvHPutE90lextnSrPiITwGYYvs29ft9E0clAG4RULvPa
 aLsT/08OuS0wdNsgAo9vw1rBs66uPK8FfFXW11VLjCP29z4DnldbdDgrN8OM5klSgUAR
 FjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512126; x=1753116926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GnuPhOvOnPLOfdX6XlrP4ky9ziluFD2vjxw40gSmZ1g=;
 b=kg5KaH293d0d7PzYzZbsZcm8KtBqS2O3MOMIa11XDgMeG7R1oXMKfGGcBHVHcB9mAt
 Tcm2dOiceWZyK/YoTLp2KixvBI1cbQvXKdtd9eaJC9NaNkVu2Dsm1OqJwmDGge6PqZs0
 myh7tnyp4GgQCt+wl6rohnT8fq4ur4CuPTeoUvC4WQWN8OtrwrztIAMfoEaKgQBNNkR4
 9F3L1XtaktIHnOOFqCpYbCOQ9yQiZvvPFCr98ooCA58mSWDZK1AnanJBi0n4mwvH7rZy
 eKX6ttdHpsv68I0+o/CQ4SgX3RJNUzlpAxQaNZBWalOGl8oPjXqevM+HfyhJtT93pws6
 UMqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3b7DBOKcYBURXgJ0Oo7jq20aIx1ERAw9q1D/CT3QuyEX+jA5z/ld9ZxE0hzj1F2E7RjC5Vbr7E18F@nongnu.org
X-Gm-Message-State: AOJu0YyoDq3LOnsixr48fYRTTBbNIZfuT9fy9iA6zXSO4x8m+vkwEHOE
 Vr4tYkQ+mWupfOl+O7kOZ7ivsJeJLXKtdo8qJ3VohlBcYDzP2fZMg6/yrtViGnTuVHY=
X-Gm-Gg: ASbGncuavgI5/463rR4emeF6Jp2wje8yiXrCNZvrFFHbYRyUlR0emGE4hJ00PyuOpjC
 dv3RtZzifrFzOIYrSI+4xnomJ1nVbGhW9MlbjIwEXZ8pi2NUM+SECL+nxz7rHYy3i4Gr6G1x31i
 /XHpA0yAHI1xMztoIL/BOH5uHExFRXyoWg5J/9jB3Sj9sZOOT+gS9HeMCPUewbl2WKnRlu0LC6r
 SAZW4dRAfEuj/KMnuWv+fsQ1EWWYWOEiufPtnHgOJeApDkmFvtgu3GwzcW/MhT3nKbn9qtOC8Rc
 evfwM4JUp0WG9I1jf/yj+rNFlq8NpKPpOhtMO5a/4NGErfX5Gbf/btuO5kaxGZXyeFMYREjBwmj
 9inadb8350e29CVVJb/wkFD1KRpKy
X-Google-Smtp-Source: AGHT+IF8LcEWUTJee4OP99Z2DnuLr/s+aC/Ikzv5ruMl4L1QLo7yroHHrQyk4wQysm3/F9Wprf1wkg==
X-Received: by 2002:a05:600c:8b84:b0:454:aedd:96fb with SMTP id
 5b1f17b1804b1-454f4275fa0mr127666235e9.29.1752512125735; 
 Mon, 14 Jul 2025 09:55:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd15bfsm13164665f8f.19.2025.07.14.09.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:55:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/4] hw/net/npcm_gmac: Various fixes to
 gmac_try_send_next_packet()
Date: Mon, 14 Jul 2025 17:55:19 +0100
Message-ID: <20250714165523.1956235-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is a Coverity issue in gmac_try_send_next_packet() relating
to it setting a variable to a value that is always overwritten.
While I was looking at that, I noticed a number of oddities in
this function. This patchseries collects those up. Note that I
have only tested this with 'make check' and 'make check-functional',
and since I couldn't find a datasheet I have some questions about
the hardware behaviour. Review and testing would be appreciated.

The first patch is about something I noticed last year, but never
got a reply on:
https://lore.kernel.org/qemu-devel/CAFEAcA8Jx=CrXCSzOtjtEky5ikvtatk8N2gz=nKccpwEwO13+w@mail.gmail.com/
The code appears to mishandle the case where the function ends up
sending more than one packet, such that the second packet gets
sent with the contents of the first one.

When that bug has been fixed, the length and prev_buf_size
variables become exact copies of each other, so patch 2 gets rid
of the unnecessary 'length' variable. Here I have a question about
the hardware behaviour: what does it do if the guest attempts to
assemble a very large packet ? In this patch I retain the current
behaviour ("wrap the length at 64K and send a short packet"), but
this seems to me unlikely to be correct. Should we be detecting
the huge packet and flagging an error somewhere?

The third patch fixes a classic C thinko where we do sizeof(some pointer)
when we meant to check against the size of the dynamically allocated
buffer.

The fourth patch fixes the Coverity error by dropping the
not-very-useful 'buf' local variable entirely.

thanks
-- PMM

Peter Maydell (4):
  hw/net/npcm_gmac.c: Send the right data for second packet in a row
  hw/net/npcm_gmac.c: Unify length and prev_buf_size variables
  hw/net/npcm_gmac.c: Correct test for when to reallocate packet buffer
  hw/net/npcm_gmac.c: Drop 'buf' local variable

 hw/net/npcm_gmac.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.43.0


