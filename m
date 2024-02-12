Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB82AC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRL3-0000qo-0Z; Mon, 12 Feb 2024 03:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRL1-0000q7-Fb
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:51 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRKy-00081P-R4
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:51 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6da6b0eb2d4so2074701b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707725207; x=1708330007;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=MjKlGkWsXxtI1+2CDjj1Y4qsactGV+Ed7YmTNuR+rct14aDceHc0e3g3dw6zme7zMZ
 xedW0i1WlWHxY+zK50o2peRy1T/fI3scGCI1lHyhpW3oW2HAredZtv0KsFazWXsHqoB1
 mOqQXm3ui/sxXj6uc67uTCT/ejjVzaTnqQnaTBd8ducyKmz61GBV/uvGpYSN4CgtflLk
 8ay3HjmMg3CszqNMBMsy20v/hcBc4ec7irBkUDOIdzEr8EU9FDBmN7srdMDgBCLXV/KR
 TUFV1WRFmKuRc6rf9ySo7Q3FFes3qSPtDGfzeToyc6bkAiJKHDe6+2b9+lGPsZujS3jk
 EAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725207; x=1708330007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=xBUjNU6uSPqXdbqfnnELBbrXdPMpHcFMsYZSzh5QKmvmwLSr/nDCO4UPsrAMs4dD8i
 AGsoiKKG15/7/78ZtRVLDnuhUmxFDUj02ycq12RQZz4FPg2Bv5dbh6426sAcH2a9SCDz
 6m6VL4WYKBdPtjpodbXo1Trwv7wqXV8ySacfAIGq6452srIXwT6GgdhdHp54B1VlrXeJ
 qCWAPiaDehkCi3MxzNbxBvMILeGpD77jlEcPdAsb75zBjrve+jhZNrjmjJwpqhmu+nh9
 /wK7VNlWBh1PlBBFm9iSNApAITnelcfK2uWqElIu6mdxZL9CJAHYfMw2taLIMEFROIuW
 BXuw==
X-Gm-Message-State: AOJu0YzlKSMG7W6yRY2rPGEMnn58ayHX1HgweEtPIF/XnXJ6BnH4lrXI
 Y95MKWC7GsfusVIK0kNvEYkxPu7vahX0yATWPcWxhW6D6RMcYELdIkSt7HxkDMyKcLqqYR4qwdt
 phd0=
X-Google-Smtp-Source: AGHT+IE8Fw0k90OnImCaWsS190rn3kldMbcpggl5rFVCO57qMjShoh0Pd4WBLwJf0vyMmgLCDV/+OA==
X-Received: by 2002:a05:6a21:3115:b0:19e:4f91:42b2 with SMTP id
 yz21-20020a056a21311500b0019e4f9142b2mr5438494pzb.18.1707725207234; 
 Mon, 12 Feb 2024 00:06:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXavTR69cvGmKY2vBV9NxlZAK3aTf+2oIlPcN7+5MzMDYVfWSpppYyuv1tMgOwBeEaP9yQQZrIel/0RtWtpjrSBWTeOOrujf060qRU0sqcW7LOxnMMFBJb1iEuBX3PDwOCzx/e3vpu/W2b4+datwNefRHJVdC/YW3QLRuPcM/sqZF9U3ZfF/qrqdYresXtjW/zNit4ewrf5MJYvxTvdMGHajthcIU/KB9F3xQmp8Jsddbf69H0mdDc7gWnqbITUZhpsxT5di1ZM7l9t7ONSlpfuOLyOM8lZMRop8xY3KJ3XjIrHKlnEZMyCIOFqU3JOhRgi3gHtCc6KZ6A3r37IfykY1cKlJUFkFVuUX9wt6YiedzPmijc2ct1qSFeZffMe/w==
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a17090330cd00b001d9fc53514esm5404649plc.66.2024.02.12.00.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 00:06:46 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org, jag.raman@oracle.com, peterx@redhat.com,
 stefanha@redhat.com
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v7 3/5] Update subprojects/libvfio-user
Date: Mon, 12 Feb 2024 00:06:15 -0800
Message-Id: <20240212080617.2559498-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212080617.2559498-1-mnissler@rivosinc.com>
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Brings in assorted bug fixes. The following are of particular interest
with respect to message-based DMA support:

* bb308a2 "Fix address calculation for message-based DMA"
  Corrects a bug in DMA address calculation.

* 1569a37 "Pass server->client command over a separate socket pair"
  Adds support for separate sockets for either command direction,
  addressing a bug where libvfio-user gets confused if both client and
  server send commands concurrently.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..cdf0a7a375 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = 1569a37a54ecb63bd4008708c76339ccf7d06115
 depth = 1
-- 
2.34.1


