Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC9ACCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzUH-00037o-7Y; Mon, 03 Nov 2025 13:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFzUE-00037L-6B
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:41:02 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFzTx-0008Q4-0K
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:40:59 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7a9cdf62d31so2347777b3a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762195239; x=1762800039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VPUHH2KG3a+zlnw4jFWnJXDoqnz1r9b1MatYjBejcUw=;
 b=cdFwzTjd4ebDll8kYCpR2dewc4MVMKy2gfoXdJOgdGIe7HYYy0ldorGHGX5h0VVvxP
 itlMoLQItIi7QmfPhHTif3eDg+6W/I/m+GENax9X/QfyqGQsNxgLOqjtP0fGNFmCg4Xt
 /CduqsbTu6izxEQIDUEzqMzQ6+CdiXym5EkqdAuT3dnGRD6rrNAWC+iDNZ6rAr/JKHea
 URDgtx+/YlOZLjkU56iOwG7DZy2hTpoPk1Pa7/4YL/OGwQAGOyTC8HCI1jTFyPDUJQgO
 gFQu6nVLsp+myCX6Jpl6KAQLVz3yZwoSjkx9zDYReCBJpZp8xDAnWDgdtMPbtX0j49dM
 PEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195239; x=1762800039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VPUHH2KG3a+zlnw4jFWnJXDoqnz1r9b1MatYjBejcUw=;
 b=ApwM7uFYhYvsHlb767ytuzy+xAeCDvsrGrLK8J22joWk5Nmdb7VGZTsWG8fh970hKv
 qk7N5PRl1IGFulXSzNwiHTgow3lYJ8cxWBHvL61TTcIUvh5TygFrWN6xFljerYGaeI/I
 sf8l6A9dVPvo6WgAxyUg3YwsOqxFyKnbZ/L5Na8KeGh6DscTQc7muOclLJ48bG3Udipn
 yzOG1pTjN6X6JMg9H6phHNNPL3KcS+FKNShxfwY8zXs7JhBRULp5E2V08QYHhi95bRsN
 FrTiuPBuUi6qAxTrlFpAiyyIdnvQhosIVIczDwIuf6Bd3DYtWoqCjuq9OIUpWRhnALam
 ZPsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGCbVVVw6JWigtXUkff7ja6LT1gxH9vBOdfuZh+f6uUp1fNXIyhugcHFGnVqX4AHc4yy3kcOO+XlBE@nongnu.org
X-Gm-Message-State: AOJu0Ywk5qVOgzmI6HR51/M0hF1HVRduqoOY6ouMWBD6qUVNr7sv3FG8
 zRh9q/ZX5tmCSfubUY5HaNQQCQ81PamJa/2vdMVswaEtR6n7sf5czOHn
X-Gm-Gg: ASbGncv/wowQLwqPlMSXjcPClobgo5thP038h7xs8pzY3fQemhmG744Okynhnymuq50
 QaviqRevjBGPV1+wr1GFvQfWVYJwspijzrZQw3Ot7Ooy9HOgNnI9XRLDxOzgx8zzKypU29yT+V5
 +prc3BgafR73wH4gp7vJmqv12NTcsIwG8fe8NluxT8tRwlfOyivcxATe87FC6l1UfSipcUFyg9U
 ulfzpaybHW31OhHiDMJU9+mdF+uUhfjDC8GwZYt/2yt+Y4JOAua+Z1Fwd7MAAyNNOOYT5urZNdx
 UmcwUIQmwAcOE9GfYUZzppFCdND3LgJRQ2lLAuMMw4Lq5U0/ATHzvNIv/jxCJRGm6a+WOmw+KCq
 rvI+TgD8ZViwTdqoRj+flOfbzZ4KjQhNe+J2OV5Dlj5cZbRJWirswikky6NpzUMGYo4LsJHd2gF
 GghCo9NtVddH1vYw6C8MOXtZxa7Bxc81is4zFFwTmkxXu3dmHKAw==
X-Google-Smtp-Source: AGHT+IFROLwiidtGgHNOFLDS0NLic4/SfwdcLwnjJ5Ix2Pq7s+vN0gSTRHjJsor2LLomq6zsZ056WQ==
X-Received: by 2002:aa7:8f98:0:b0:7a9:cb58:2b72 with SMTP id
 d2e1a72fcca58-7a9cb582d32mr5583731b3a.3.1762195238714; 
 Mon, 03 Nov 2025 10:40:38 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd634081dsm64255b3a.58.2025.11.03.10.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:38 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de, mark.cave-ayland@ilande.co.uk,
 sarkarsoumyajyoti23@gmail.com, peter.maydell@linaro.org,
 zhaoguohan@kylinos.cn, qemu-devel@nongnu.org, stefanha@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v4 0/2] HP-PARISC: LASI's NCR710 SCSI Controller
Date: Tue,  4 Nov 2025 00:10:29 +0530
Message-ID: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Fixing Defects reported by Coverity Scan for NCR710 SCSI Controller in QEMU.
QEMU runs the Coverity static analyzer to identify potential bugs in
code that has recently been merged.

In view of the above these issues came to light.
I would request you to please review the fixes for the same.

Reported by: Stefan Hajnoczi <stefanha@gmail.com>
and GuoHan Zhao <zhaoguohan@kylinos.cn>

Soumyajyotii Ssarkar (2):
  hw/scsi/ncr53c710.c: Fixing null pointer dereference issue.
  hw/scsi/ncr53c710.c: Fixing Incorrect expression  (IDENTICAL_BRANCHES)

 hw/scsi/ncr53c710.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

-- 
2.49.0


