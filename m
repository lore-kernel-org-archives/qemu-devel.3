Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E86606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R0mPSd7h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW4jT-0001yV-6j; Tue, 24 Nov 2026 23:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4jO-0001xp-Ja
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:35:43 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4jN-0008Pi-0W
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:35:42 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70059e4dab6so2816485eaf.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795581339; x=1796186139; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yQ1jBwEwnjaqRwdvfbwNRfThs78Rv0h6e32QJOsI94s=;
 b=R0mPSd7hKw24cZR9GcmyrMu4vexYa7ihtB/hMPh0nG0hKvZW5y6zQg4JSBRjDjqsIi
 ZQzJckx5Goo2UNqTlYKm7TWmYCtDnKUvlrLiZkZh8tBaikMpz7jniAsXpYXGbT8xrLTc
 txqkzxDpzcttFkJCR5p5dpYXIqKPXTx75Q3fdE5nNCN+41LZQdnxjPMm54+inclUFe6K
 Bg0XFKl22Q5Xw8fOOoqw9Ayo63shmPYzFhRoCt04KHE++brWQhNe0LCfW0un/HFXi3ZU
 JANlz+kK+ZE++yQW7diQZQaLtpdQpkEFqRhO+KTGqJrfZ0nbxj9KiitN2BhcC1TocMid
 QuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795581339; x=1796186139;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yQ1jBwEwnjaqRwdvfbwNRfThs78Rv0h6e32QJOsI94s=;
 b=YVRCx5s+JokNtmjYZlUG4NlGIgOEFrzJbNIGwC0Wy92iLHFJLhqbZzGd4HW60pK38A
 dXnGW4dDvqBe1PNSr0psWFWv5aKCDY0nUA8DZwKbvpnGXS5jy7o5a7OiSIy+HHR9YZ/7
 6NxENzqo5E7kwqbw+SrMSTwBrLtZBd45wp3m+4yWAgYOMHeyOIAfCtXY9j36yntUIA6n
 hefjNtUk2ZKCPWXNEmqpEP/VX+aKbK/wPeJADGCkQckBnFupygrPqCBLkVXbhTxMDyEZ
 LQoaEyG6zvZU9hHZPkU7sYG9GZY5PJ1mCuguLvLjmcdyFFqP0dYkl7C+QQLDKyyhcHGJ
 I3QA==
X-Gm-Message-State: APuU4Z+iWI17pTyjzRug0JIqtDaP5t2MbdNZBiWtNSjTqOhi2C/EJo36
 dojkdoKGG3so6DhTHL0/42HNBAHPI3NxRrxvBLMmziMr9WR/TEZsM681
X-Gm-Gg: AZFdTZe1agGkEf1tZqQKL6vUIj5cWd+hJVhVrA4U5qqnbH92Cx84mcNBdAl7JJpSaAg
 BerwyfRNMFFXyOdsfdeX/U6GONH3Ds3SzjWfeprwKlYmvyPVF46w8Rgvw9BHKkzfhhwLDLjih48
 eW6k7vt6+5PvSWT1Xys7jEtIedpd3PX8/UuZWmeRH829JxDM/j2pIuhCX30FQxSMbbCf/3YrDh4
 YsJ9ayqM8colWcmmBORZEPsBxkniwmfSd6ZHB3WBM2iYPKGKkiw5O11rLvi0FimE1NjqeXMuFuW
 u17Vqwy1z18510djdhYdMm4j1+zzSiLRZcZjk7MJT2tjzJsQ++SxaY2/jImJe306yflOEbgQXRN
 KB6g9pe35YE0Ccg2tTJvhLmwJZrVLxfmXagH6JvSfrd0GbT3JhBowwbSyqsfkTZMz0fUrVJpzxS
 CRPq641F2LOdnYaUSrf15b942DrTotiT2ewpKd+hp+bLgdz/VnLRn2y6kvK33Y8zqVFn5Ly5tCm
 Rz3L60rcfMm4YdeLHhqlt9i2AoI7Zv/gRFX5m5ktuuYAnlgMIPu24LZNsHvagljKkoAL6FrwpMH
 bU6zo1ZowNy0X7K/Uxa0N9ay
X-Received: by 2002:a05:6820:858b:20b0:70b:a287:72b5 with SMTP id
 006d021491bc7-71b394d84f2mr10280127eaf.20.1795581338801; 
 Tue, 24 Nov 2026 20:35:38 -0800 (PST)
Received: from [127.0.1.1] ([2603:8080:a00:9759:77b:471:20d8:44bf])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380bdff9sm11183745eaf.11.2026.11.24.20.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 20:35:37 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Subject: [PATCH v2 0/2] hw/net: handling 0 RX queues
Date: Tue, 24 Nov 2026 22:35:31 -0600
Message-Id: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJNlBmsC/5WNQQqDMBBFryKz7pQmaKJd9R7FhU2iDtREJlEs4
 t2beoPyV+/zeX+H6JhchHuxA7uVIgWfQV4KMGPnB4dkM4O8SSWEqLDUssGwJAw9vsLibUTekHx
 yzMuc8nxDXVvVdNrWpbaQTTO7nrbz5dlmHimmwJ/zdBW/9j//KjBHlXUjtKp6ZR7D1NH7asIE7
 XEcX6t7mwnWAAAA
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795581335; l=1596;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=zIkelXqe/LLU7dn4X8y8S3qgBro99q7yUcAxYlUY30U=;
 b=naDkTmvQ3gg7ljak3Ol23I6YEAQu2imC86RBJ/C0Ai3XMngIw6pG0WXNWRB+Y8cyDDUjTp/eT
 j8jH1NIXxDiCtumplt7CvpfnlnIpa81sTfFaLOZROhgdANMDoY/3M2f
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=xmphyr@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a resolution for issue #4729: 
https://gitlab.com/qemu-project/qemu/-/work_items/4729. The issue is that
a VMXNET3 configuration with 0 RX queues is loaded. When one of these RX
queues is accessed anyway, say, rxq_descr[0], it could have an invalid 
interrupt index that was never validated in the first place.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
From reading some support articles, I think that there has to be at least
one of each queue. Unless receive side scaling (RSS) is enabled, then the
minimum is the number of vCPUs. Not quite sure how to interpret this, so
I went with always no RSS. Another note is that if RSS is enabled, 0 seems 
to be an acceptable number that gets interpretted as the number of vCPUs.

https://knowledge.broadcom.com/external/article/322369/rss-and-multiqueue-support-in-linux-driv.html
https://knowledge.broadcom.com/external/article?legacyId=2061598

---
Changes in v1:
- vmxnet3.c: changed the RX queue interrupt index validation for loop to a do-while loop

Cahnges in v2:
- vmxnet3.c: undid v1
- vmxnet3.c: when validating the queues, not interrupt indexes, check for minimum of one

---
Andrew Nguyen (2):
      hw/net: always validate the interrupt index of the first RX descriptor
      hw/net: at least one TX queue and RX queue

 hw/net/vmxnet3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 6bf90d4fc5027567cb704d7888f5ec792b4ed75a
change-id: 20261115-4729-out-of-bounds-rx-interrupt-idx-78d69a7d847d

Best regards,
-- 
Andrew Nguyen <xmphyr@gmail.com>


