Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6146606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bXFXEKx9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzMq-0004Sx-OV; Thu, 05 Nov 2026 10:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOzMl-0004SH-Eo
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:27:05 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOzMj-0000wH-5x
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:27:02 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso497753f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793892417; x=1794497217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=boIE/CvpxAW++uDAFl070rHVEYkZYfB/D0jeTT0yYnw=;
 b=bXFXEKx9bVKi6XkJnGg5oZLn5cyEKom6QnIKQkz6j5ye4uUS3+5zVCcdTqvkqqs9Ro
 5FdWt8nVHHfUMa73AYTRoAi4GN08CB8y/b1fPD0g1eZYDc9mE7p//IL9cFJrftycFpbm
 8jf/DdK8CTf7RSxWlHaO8jk7LkvIhtWn2rBjIFf6Pl2SC2OjxopXSWBVPVGsG/clVJrY
 6mOy0Ey45vc4W+Mw0MhenPWQS7Y7InJ+e+oyWd6CJ6uMirdPbNbPrs8RZb8j/YP6ltKK
 yKr8Mu6Dp+VOv9+6vVVBXPXXVY49GvWb1f1sbfO0eeMF3+NEgUsEjXpoVvnvjT7nv0ea
 w3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793892417; x=1794497217;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=boIE/CvpxAW++uDAFl070rHVEYkZYfB/D0jeTT0yYnw=;
 b=2ga0wIk+kfiXJkoxDNGKbGeIGVsGZ7vXuti8Tf//TodNWP6adiAaFKidmI420I77Aw
 3hn46tlMsjrhylBbq20oi3tS1ziDO3EoSIri4kOJU4GA3JvB8dSHT73jjJkrSsH7DMed
 RCQxTIXkrblsHFcUjBlvwO7U/xUC+onOxbkjK6JyXIkuAQcHfStgEXOV8tQpsDvC+xC7
 dWtzSxe2TYP+RjKZ+uA2aPK5V3sy+4NGeOyHNEV85QNsk6O8e2TrwgSAiMRk52BD+f23
 Vg2SigEVgzxBkxZll+HyB5xwxhiqfyh2KerVsv5g3aAjDc9UZCLOmxEHXOYECijClg8z
 GBcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSok548QGtzkT6//wdgU2pdd3wELGcF67MflCse5XlVYgbeL/nE7e5nkyhcab0OvFhz61GVfT+setM@nongnu.org
X-Gm-Message-State: APuU4Z9dGTwcmkLm2ONA7Hjy3m/n9sjJar6Bvgy/qsZC8EVuhlWkEH4h
 M3+7R4iI2uy3sNcktpWTsH8h3m83Y5PaKzkBoHhbxkt1hqYgSTrNLdR0xko7uHbPLJg=
X-Gm-Gg: AYBFou24rgP17avdY9Wr/znabRPphev7t/HKqSf6IC57F1AqcOH5mwrTITfp7uqfTb0
 siMxcEycSPWHLGPDptLCj4KS5sG/etVPoTwh46hI4lkDNVur7qlq1ff/yDnvXVoRYvYoT0p8yLe
 i+4obPrpzcUC/0FuJTPh6Pp5ki+fKxvzjwRxBpCP/QM5xkPg4Lamf/+ey24/oy0InR1ZltcTTwx
 IHaZr3iHeXglzlveCOCs7DXKebMqOzNlGXgyhRl38K6C0LsBCwxJmjc6EBF3GS2aTcPZCLYYIAv
 asYkciIgML9FmuoV2+YXOwm2Qvbpj+yal561nBJ+3y3kbFzRIg7rP6i2PVD3kAbe2mU7H2MiKyY
 3jLOlgrrtIEHdRurAwCqjLmiDlzxtDpfn7ZWDKZ0pyNXITjLVjiBFy30t5vpqhKSwdpr99uzraM
 rT7+UqqeUuxscc1GOts7Chezrwn2EBtuaI7nRAsbZQsMAF1gjjJhe5HliCW0s3H32GhF5CAM/4P
 3u+FVlL6e8QwsWpqzYJOTzilaQdCHWC+q2yDP1tDAshaa+fKV1MIVx3YDGIjdGN/+tqT4xHCJyC
 g9qEeToXNT0r4NF/9nh+GqaBswNmSA==
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4ac1719112emr416260595e9.9.1793892416537; 
 Thu, 05 Nov 2026 07:26:56 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56fca2a4fsm77974715e9.15.2026.11.05.07.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:26:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 99D285F8AF;
 Thu, 05 Nov 2026 15:26:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] MAINTAINERS: fix typo in Gerd's name
Date: Thu,  5 Nov 2026 15:26:46 +0000
Message-ID: <20261105152647.2458298-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 198ed583650..3fac3e0f99e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2945,7 +2945,7 @@ F: tests/qtest/vmgenid-test.c
 
 VM Launch Update
 M: Ani Sinha <anisinha@redhat.com>
-M: Gerd Hoffman <kraxel@redhat.com>
+M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: hw/misc/vmlaunchupdate.c
 F: include/hw/misc/vmlaunchupdate.h
-- 
2.47.3


