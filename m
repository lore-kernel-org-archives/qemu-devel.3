Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46189C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDHf-0001jP-BC; Thu, 07 Mar 2024 07:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1riDHZ-0001ib-So
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1riDHX-0004w1-Jh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709816130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=at8BC76ZbcOCvnYmCuLdtC1vcmwWzolgXKE7VcZPyGU=;
 b=WZjlTrL+Oi2y59ddJ/Uu7svgZ9+yOhnZ4iBf1W7J4045lwWjHiiKGFXIVptEIsIzaXgxyN
 bQOhQcaE507nPbt7OLOYjAcDG7aO7b1BsVonr3TlKJZ0ymMChvpVPpSlijR/W988drxqxz
 FHJhdfDcaTX211nkTlpSfOkDt6tabkA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-uo24iBwHN-afw54KqhjD4A-1; Thu, 07 Mar 2024 07:55:28 -0500
X-MC-Unique: uo24iBwHN-afw54KqhjD4A-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bbaf0ee0d9so811288b6e.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709816126; x=1710420926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=at8BC76ZbcOCvnYmCuLdtC1vcmwWzolgXKE7VcZPyGU=;
 b=pceZdYEOuIzvoWXDwMQ5OZsjiBz82njOpAy3d9tGEnEcIj/H35wGwAXZsp3FFGc1QY
 nzCjyo/ZrBCXkuvmCuiFo1QwwPXG+htLxdUtdEUohX2hnFfpeoYtspUwfQ8gSzqw0dgm
 kWqMN9AV4aafYRLyKsws11ksJRU4MMnIwB37H+g0txPqmd7bb33LDV99i0/I0vsEOLw7
 5YxWWXvnrR29JO1cJZzLXnawBOKkwgncC6EX7bnN6IySA2YUeLWeLhnkHN6MzzW3a2eE
 FUUKid2KR3q/OQ0K09qxPn9CLNRjcziD/0Gne0m8rZ13bYKRLcDy5r0qtM6UYuQ1gRgp
 RTsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjbTYPzIdzhHI6OuqsxyxqaRqr2xjrmSb+rW8+1tTiGkx6I8QJ3KlhQutdjzqvA8g6DcthU/HArhn2uus0mLvShEPYfbs=
X-Gm-Message-State: AOJu0YwtzPTQYPkLUdisxPPXO7ycjcpdn8h0UT4bMjEXVgtOP3J9khMU
 5rWxNAHSOcp8gzpECjsqWfDELWbQoX5Faj3LPBZPZN1IL5nQV8VVBlrn5RU7bjvDbrsqD7Sb70U
 ujvf5h9a7oEdGjIx0ZDZxBqXaPC8L+ZlqSnvHPU4xr9TjaJ4F+FNT
X-Received: by 2002:a05:6808:634c:b0:3c1:c8fb:89f9 with SMTP id
 eb12-20020a056808634c00b003c1c8fb89f9mr7526145oib.39.1709816126417; 
 Thu, 07 Mar 2024 04:55:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH56NG/TchSst+ygxKgGqdok3zc30lHjLaOpFlHLmVemFO9i0I266u1rapCbapRiG2YfRT+nA==
X-Received: by 2002:a05:6808:634c:b0:3c1:c8fb:89f9 with SMTP id
 eb12-20020a056808634c00b003c1c8fb89f9mr7526132oib.39.1709816126006; 
 Thu, 07 Mar 2024 04:55:26 -0800 (PST)
Received: from localhost.localdomain ([116.73.135.231])
 by smtp.googlemail.com with ESMTPSA id
 x7-20020a626307000000b006e624f5c866sm7288282pfb.145.2024.03.07.04.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 04:55:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/acpi/bits: add some clarity and details and improve
 formating
Date: Thu,  7 Mar 2024 18:25:18 +0530
Message-ID: <20240307125518.6268-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Update bios-bits docs to add more details on why a pre-OS environment for
testing bioses is useful. Add author's FOSDEM talk link.

CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/devel/acpi-bits.rst | 55 ++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/docs/devel/acpi-bits.rst b/docs/devel/acpi-bits.rst
index 9677b0098f..1ec394f5fb 100644
--- a/docs/devel/acpi-bits.rst
+++ b/docs/devel/acpi-bits.rst
@@ -1,26 +1,48 @@
 =============================================================================
 ACPI/SMBIOS avocado tests using biosbits
 =============================================================================
-
+************
+Introduction
+************
 Biosbits is a software written by Josh Triplett that can be downloaded
 from https://biosbits.org/. The github codebase can be found
-`here <https://github.com/biosbits/bits/tree/master>`__. It is a software that executes
-the bios components such as acpi and smbios tables directly through acpica
-bios interpreter (a freely available C based library written by Intel,
+`here <https://github.com/biosbits/bits/tree/master>`__. It is a software that
+executes the bios components such as acpi and smbios tables directly through
+acpica bios interpreter (a freely available C based library written by Intel,
 downloadable from https://acpica.org/ and is included with biosbits) without an
-operating system getting involved in between.
+operating system getting involved in between. Bios-bits has python integration
+with grub so actual routines that executes bios components can be written in
+python instead of bash-ish (grub's native scripting language).
 There are several advantages to directly testing the bios in a real physical
-machine or VM as opposed to indirectly discovering bios issues through the
-operating system. For one thing, the OSes tend to hide bios problems from the
-end user. The other is that we have more control of what we wanted to test
-and how by directly using acpica interpreter on top of the bios on a running
-system. More details on the inspiration for developing biosbits and its real
-life uses can be found in [#a]_ and [#b]_.
+machine or in a VM as opposed to indirectly discovering bios issues through the
+operating system (the OS). Operating systems tend to bypass bios problems and
+hide them from the end user. We have more control of what we wanted to test and
+how by being as close to the bios on a running system as possible without a
+complicated software component such as an operating system coming in between.
+Another issue is that we cannot exercise bios components such as ACPI and
+SMBIOS without being in the highest hardware privilege level, ring 0 for
+example in case of x86. Since the OS executes from ring 0 whereas normal user
+land software resides in unprivileged ring 3, operating system must be modified
+in order to write our test routines that exercise and test the bios. This is
+not possible in all cases. Lastly, test frameworks and routines are preferably
+written using a high level scripting language such as python. OSes and
+OS modules are generally written using low level languages such as C and
+low level assembly machine language. Writing test routines in a low level
+language makes things more cumbersome. These and other reasons makes using
+bios-bits very attractive for testing bioses. More details on the inspiration
+for developing biosbits and its real life uses can be found in [#a]_ and [#b]_.
+
 For QEMU, we maintain a fork of bios bits in gitlab along with all the
-dependent submodules here: https://gitlab.com/qemu-project/biosbits-bits
+dependent submodules `here <https://gitlab.com/qemu-project/biosbits-bits>`__.
 This fork contains numerous fixes, a newer acpica and changes specific to
 running this avocado QEMU tests using bits. The author of this document
-is the sole maintainer of the QEMU fork of bios bits repo.
+is the sole maintainer of the QEMU fork of bios bits repository. For more
+information, please see author's `FOSDEM talk on this bios-bits based test
+framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/>`__.
+
+*********************************
+Description of the test framework
+*********************************
 
 Under the directory ``tests/avocado/``, ``acpi-bits.py`` is a QEMU avocado
 test that drives all this.
@@ -120,8 +142,9 @@ Under ``tests/avocado/`` as the root we have:
        (b) Add a SPDX license header.
        (c) Perform modifications to the test.
 
-   Commits (a), (b) and (c) should go under separate commits so that the original
-   test script and the changes we have made are separated and clear.
+   Commits (a), (b) and (c) preferably should go under separate commits so that
+   the original test script and the changes we have made are separated and
+   clear. (a) and (b) can sometimes be combined into a single step.
 
    The test framework will then use your modified test script to run the test.
    No further changes would be needed. Please check the logs to make sure that
@@ -141,4 +164,4 @@ References:
 -----------
 .. [#a] https://blog.linuxplumbersconf.org/2011/ocw/system/presentations/867/original/bits.pdf
 .. [#b] https://www.youtube.com/watch?v=36QIepyUuhg
-
+.. [#c] https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/
-- 
2.42.0


