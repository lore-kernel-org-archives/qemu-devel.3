Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341FC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIg3-00024H-7f; Tue, 06 May 2025 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCIg1-000244-66
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCIfz-0002QV-Op
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yfkutnSnOZuLjz9BQulRJCmcaKmMmcPXmHM+IV8HwvA=;
 b=H6gz67PYxeTBTrTXTRogVOK45XIiPAybEyLQwWBSu4UwvkRsdF/vR7UZRqZQlHvrxbWxEP
 LRABNtA93ZFecS9dteQBIwo/rNB8150bhKWpR5Wbc0uQG0niprPeKDyi9GUR0Dg5oNl6bs
 0cKO0BsH16QbnG/NGM13j0ApDpTe9Nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-iR7ddzPTOpmiTPW-OnYIXQ-1; Tue, 06 May 2025 09:49:37 -0400
X-MC-Unique: iR7ddzPTOpmiTPW-OnYIXQ-1
X-Mimecast-MFC-AGG-ID: iR7ddzPTOpmiTPW-OnYIXQ_1746539376
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a08a1c0fc5so2924729f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746539375; x=1747144175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfkutnSnOZuLjz9BQulRJCmcaKmMmcPXmHM+IV8HwvA=;
 b=E5biAC1zju2lCVGpOaqGDlGXSzkn6C/tnIK4NgCghinoNdz9Jq7oXEMYbGpUTehy6v
 cwNCA78NMWmpa0KcOV+Rh+eGkIvnsoYDrrf7m/udDyb09/6aLd+QlgtpBsQkHvW57902
 4JdEdDCXUdKkKVqd+zjyfXbKzLD4asSpLSA7W8xtSuovjsOA+68vSCXpfSqpRgC8ifvj
 YQUAkb+IoZscdMxNcCRpXUpA164h6KY8O3exTHf92uAS7HtnLEaBMMfWdGjR8Zxtg/Dg
 oFc2jro9CRYVyihYMTPydIbVVyL8TNi12HnR2gIqXmZo1mQUwCuO2UXVRt9pxVuA4jRd
 MCZg==
X-Gm-Message-State: AOJu0YwFP8Wvw7zhGqrz25/eo9+lf/8iVmg2en+nA4EFfeBFTQ8H1biB
 Vg8+jRytCQ/8QmbD+VZ7M/H5UKXniX/ihMdhZckP0wtGXP/6SIxe0GTZ2TmlFe/GqMfK0TOl0gc
 1koF3gE4fsQMZ6JPYUU57O7OoUOzuXfFmMTQWX3tg00UUIL/MUKz3I4IK/8Ltlmk1MJ91+3lBE/
 DnCMGD1y1Wz/hirvNb88vPxbUCECHs5HdnZ5GD
X-Gm-Gg: ASbGncvZjjiaOd4BPjwUnWGgeEEeDZqWd6D37Ured3U2cW7jgnpJahHer5hk36oTlTO
 vT0W5bbT/DHNAIhBrpkoV7/emYEno/lhNCiaE8b81ZHQACK2ujTfNRRLJZOg08jr+EiIkDlZD7J
 pBavDwHfQ+V82YpXjxM40RsgRCDskEBqz8Ca6aLbLC5fXArPtx1C5u4FChYoY/k3RUyyua8wnYW
 ADMO0wRi3a4mKMXVNORBg0uAlI73wNYVOoNU5zYTLSpFGnZW7xU9QLjFNglkqJeSrghTSpmMQgE
 Kuqz3h7JMjeZ8SQ=
X-Received: by 2002:a5d:5885:0:b0:3a0:b37f:c97e with SMTP id
 ffacd0b85a97d-3a0b37fc9f9mr246780f8f.4.1746539375293; 
 Tue, 06 May 2025 06:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSFysL1RG7NrlgiOFH0BUpU/h3VuGSZXqSwwpAu2Nqd7wl56RPwJK7vubzZBJzr9ezUiybLQ==
X-Received: by 2002:a5d:5885:0:b0:3a0:b37f:c97e with SMTP id
 ffacd0b85a97d-3a0b37fc9f9mr246756f8f.4.1746539374696; 
 Tue, 06 May 2025 06:49:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0d3csm13537375f8f.3.2025.05.06.06.49.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 06:49:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: build-system: fix typo
Date: Tue,  6 May 2025 15:49:33 +0200
Message-ID: <20250506134933.194740-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 258cfad3fe7..2c884197a20 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -168,7 +168,7 @@ The required versions of the packages are stored in a configuration file
 ``pythondeps.toml``.  The format is custom to QEMU, but it is documented
 at the top of the file itself and it should be easy to understand.  The
 requirements should make it possible to use the version that is packaged
-that is provided by supported distros.
+by QEMU's supported distros.
 
 When dependencies are downloaded, instead, ``configure`` uses a "known
 good" version that is also listed in ``pythondeps.toml``.  In this
-- 
2.49.0


