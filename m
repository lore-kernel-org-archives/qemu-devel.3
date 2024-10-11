Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA01CFD312
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCHn-0000W3-JF; Fri, 11 Oct 2024 05:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHg-0000Rd-6F
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHd-0005lg-4N
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728640204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuA4LT4Qd6C85HmZQe9ktVcKHNDYnUR3Ii8WYt5rNHM=;
 b=LE+P4q5OHkegocblZEHmEfzgK36O8JdNRcyz6EjFVgi7QH//p2uOdZjRfzrhQaArW+ZBxF
 nKvXoj/78XgA8dXobH9uZawOuX/QeWDHfa+Z/iMTziOSEK6cPkdRsM611njJN0Z1/A8TlB
 t67PsQjXo1c/HcArin7r0025lIy7hjc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-UX0JC4o2OB6Y3FJDlzNi3Q-1; Fri, 11 Oct 2024 05:50:03 -0400
X-MC-Unique: UX0JC4o2OB6Y3FJDlzNi3Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a99442bd721so135437366b.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 02:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728640201; x=1729245001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuA4LT4Qd6C85HmZQe9ktVcKHNDYnUR3Ii8WYt5rNHM=;
 b=kBbMzh9IthlP4ccLUqnMzQMYSIwUNiaGP/yxMgDdWgia3GZgYODUHt6qIv9zlof5xW
 zaCx1d2OHui9TaRzU2su0I+MiCyexnms4Wd92o4wAk7m3A89CGNmg/HDSZp74DUqpEoc
 NKZ4USCPgl2ILZcxM0KiRVndV5a3yTnLD8w2aJsuPSe+Bt9uae0biR9EAAb9r+EqMGwB
 Ybs7S7vSdip6DiY7wFVeVWjzqPAOkSpqO6fk57qkWBi/U54pfY0KDHfoAXSaM4oSzT7T
 47addc3sDNSfBeF+BtcDIc+Pp+KkL5hQ3SH0lKz7KbLK8oVBgbnQy49TYYp4PhnORLh5
 RtqQ==
X-Gm-Message-State: AOJu0YwN9v6eJ9MpPoXFhQjs7Q1m2wuIehNExSQX0Nd25CdeC/Gd2s4C
 tfgHHNR4qI84R/2RhEji8HoJGj7GZx+AjB+JtUOP937JqRqaQz4e3azntFSbTG08lylaftu04aO
 0Y4jt7rqMLiR6HdnBj/XJgOny1XqMY8s1mQNuA+djW8d5fLXhkEEkAtlqFMCtP2HqQYY39FrY9y
 v2stiBFRIyyixKLFzBfZXRAU6sSXgHWFXMGbt0hKc=
X-Received: by 2002:a17:907:e247:b0:a99:4649:af69 with SMTP id
 a640c23a62f3a-a99b957f7eamr165951266b.15.1728640201221; 
 Fri, 11 Oct 2024 02:50:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbxpFGINiCJGc8DFZFLFrM8vu2tVRvxi2ujj90h9qtupKKgFaIwyfhf347B4okvw9a/tRsaw==
X-Received: by 2002:a17:907:e247:b0:a99:4649:af69 with SMTP id
 a640c23a62f3a-a99b957f7eamr165949066b.15.1728640200652; 
 Fri, 11 Oct 2024 02:50:00 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7ede7e8sm192819966b.9.2024.10.11.02.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 02:49:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 2/3] docs: avoid unreferenced footnote
Date: Fri, 11 Oct 2024 11:49:47 +0200
Message-ID: <20241011094948.34550-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011094948.34550-1-pbonzini@redhat.com>
References: <20241011094948.34550-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The link to fosdem.org is inlined but also included in the footnote [#c].
Replace the inline link with a reference to the footnote, because Sphinx
8.1.0 is a lot stricter about unreferenced footnotes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/testing/acpi-bits.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/acpi-bits.rst b/docs/devel/testing/acpi-bits.rst
index 78aeb6aa3c4..2e4f1d23def 100644
--- a/docs/devel/testing/acpi-bits.rst
+++ b/docs/devel/testing/acpi-bits.rst
@@ -37,8 +37,8 @@ dependent submodules `here <https://gitlab.com/qemu-project/biosbits-bits>`__.
 This fork contains numerous fixes, a newer acpica and changes specific to
 running these functional QEMU tests using bits. The author of this document
 is the sole maintainer of the QEMU fork of bios bits repository. For more
-information, please see author's `FOSDEM talk on this bios-bits based test
-framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/>`__.
+information, please see author's FOSDEM talk on this bios-bits based test
+framework\ [#c]_.
 
 *********************************
 Description of the test framework
-- 
2.46.2


