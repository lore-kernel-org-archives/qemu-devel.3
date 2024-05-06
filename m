Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC2CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9m-0007mt-LB; Mon, 06 May 2024 03:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9j-0007ZW-21
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9h-0001m4-JB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYqiJiD3cHkBOXJK8l/nxNS2jHk461xYcqaYdRiiYtg=;
 b=AlV5FUHY5sJj+jKQ5Jw8aFuud+raY/DjNVDTqr2IQmZfSvzEQopwM3D23QyDMDCZmb6S7x
 w24vseQ5kFc0ljKWQ1Nj7vRmKM1LkM6MXIO0vxu3Jju5vzUWVjYllkihr2bF4MHpw9BDIO
 fxBgdDp05WYiprXB/m4izrWUp6v5q4k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-4_QaOxtTN_-xiZ7Dfp3zVw-1; Mon, 06 May 2024 03:52:58 -0400
X-MC-Unique: 4_QaOxtTN_-xiZ7Dfp3zVw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572a0c5ece9so818425a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981977; x=1715586777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYqiJiD3cHkBOXJK8l/nxNS2jHk461xYcqaYdRiiYtg=;
 b=fwrFwOZ1ytqsuseNWBnwLw/DSy0ciW8U3rb2rSyf9JAmCzO2T7HsC1VWMleiF0WSJO
 wRVUDYAzI/vRTty1z0bd6yaeDlJxMUukkwiVNSlncxN6jEMFyOfZBqIv/ZQG0t/D28pU
 GWwmxd2MONQB9VNJQIjYtOEjJyaK2ev7Z62pne2iK9l5uul7FBue6PpSrX4jXTQaSdO9
 rcrgkjk4gt1EyIrS7WF9qCqt+DNS3KS+6ARZewt782qtxO3NlWNWJ0Yg7nZBkxFznmNL
 OIRbVRSnkxT30DQrNcv0Q4fXcDsEpIsM0OCTc6/UrhjwoJ2w6zWasetrNvJGFPszFtri
 Lkpg==
X-Gm-Message-State: AOJu0YywvnzXbjxj+zJY9p+3m3elTXBY9ja0M71OOFOBy4qEES5ClphR
 WfFptRS40xotHnLSxUikQbu8e0ZY6yH9qWs7MZxVSstyYhso8Z+rFPwCwLie4plBZY/GL5g42nu
 JVpuo/varViAZOmd7iljqmiq2x213UAcWVtQF/JGgfqLjmFtljAuukdLNbtP1cxLJpzAcIut35o
 IlJ9s4/hgZuIjXUXWn64xmoHaCU2QoU1a7/e+S
X-Received: by 2002:a50:cdde:0:b0:572:9d87:9aa3 with SMTP id
 h30-20020a50cdde000000b005729d879aa3mr6088127edj.36.1714981976871; 
 Mon, 06 May 2024 00:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwn4ba2TUupKhjfFRVRr75PJoma4/O5fEZ5D2rhMBv8qgvaZMgJEm5/NcCzQc5jbRcU8wv+w==
X-Received: by 2002:a50:cdde:0:b0:572:9d87:9aa3 with SMTP id
 h30-20020a50cdde000000b005729d879aa3mr6088118edj.36.1714981976528; 
 Mon, 06 May 2024 00:52:56 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a0564020e0900b00572d58cffe1sm3720062edh.2.2024.05.06.00.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/46] intc: remove PICCommonState from typedefs.h
Date: Mon,  6 May 2024 09:51:15 +0200
Message-ID: <20240506075125.8238-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Move it to the existing "PIC related things" header, hw/intc/i8259.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/intc/i8259.h | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index c4125757753..1f2420231f1 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,6 +3,8 @@
 
 /* i8259.c */
 
+typedef struct PICCommonState PICCommonState;
+
 extern PICCommonState *isa_pic;
 
 /*
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 4519f0cd613..090e219248a 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -96,7 +96,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PICCommonState PICCommonState;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
-- 
2.44.0


