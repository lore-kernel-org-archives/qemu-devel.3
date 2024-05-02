Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93687C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yky-0000u1-Sp; Thu, 02 May 2024 11:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yks-0000rK-3b
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykq-0002N3-Mh
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLWU8wT2XoRQ7J5Z8lyNBtluwjetfKCt3lDqz8dxc20=;
 b=Z8WkU8NuGqU4ihs9XVogwLH7c6mxrRlJr+hA4puFjkWoVUm2Cw6O/n7hxHZL9WCBEJMHMD
 3uweP+kvvHJ+dMw4KUdIxapBp4rWYwaAvUeejL/T0iSF9n+bM7SeK3RVPJssk5Gfcld9YI
 atYgIW/+uZigYbTBwGuUcRQTnrowxp8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-VbLlttJDO2aSY4AZpRirHQ-1; Thu, 02 May 2024 11:53:50 -0400
X-MC-Unique: VbLlttJDO2aSY4AZpRirHQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572b993d8ffso669030a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665229; x=1715270029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLWU8wT2XoRQ7J5Z8lyNBtluwjetfKCt3lDqz8dxc20=;
 b=Y87lEp2i8Y/wNkTOaB6+JV5douHS2Ras085o0wPXuX/dxIC6h7hIG/e9cx+iHWoaW6
 DC6FCOzzXXjgG4YMOlCAvdfeJmIrNEpojiag99Qb+ukxtXgx+BHTL0flAklu1iOXYuh7
 K/EZKYJDDce1pBqdBtR6rGrlpS06U2tw9PHDGzD80rLxWzLQcEN3J/y3LDGx19PmsgW3
 AaF+GCiWNhvukcg4hTTHd+PFi/yQfJBx8ExTuW5Nsy4DtI9ZmBVqXD1cmi4/2XqFnGFb
 Ksnxo2NVfIxSYH7iV6qq1EZ9re5qRxcoZAPgb4/cp/pqHqsgwQWM/0VWBGDXlvAOt2Rj
 lfag==
X-Gm-Message-State: AOJu0YxZc4Mysf/2JVYWStuH0YA+4KQgcfv/RkDoQd4cBlTaYPKDZNOe
 4mSEHfcPtowO9i01qWI3k92ZACHNVyx5LidyXYe0Wanvl+/JEkxDyRgSXTkcP1xjslAEaNP1dob
 KU9Q8X/xfq/Qsp049yf/7uSAnbIJj6Z9fCo91zs8sLhH5iwLFFzUy08iWzZ9K6MvZh8SXxgnJlh
 21P3nnrReui2O/bRiH4kBbnAcf9pYeHKXI0Zyy
X-Received: by 2002:a50:d5c2:0:b0:571:bed1:3a36 with SMTP id
 g2-20020a50d5c2000000b00571bed13a36mr1914865edj.38.1714665229289; 
 Thu, 02 May 2024 08:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExy1Fa3bDNdmUFc2NqUJ4TZq1DBcJiqLtXDCK8R0XoRRC2bGdRXiIA/yrZ4SBZB4pjHY9EEQ==
X-Received: by 2002:a50:d5c2:0:b0:571:bed1:3a36 with SMTP id
 g2-20020a50d5c2000000b00571bed13a36mr1914854edj.38.1714665229010; 
 Thu, 02 May 2024 08:53:49 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 g21-20020aa7c595000000b005729337f955sm644797edq.97.2024.05.02.08.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/13] intc: remove PICCommonState from typedefs.h
Date: Thu,  2 May 2024 17:53:24 +0200
Message-ID: <20240502155331.109297-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


