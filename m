Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D84C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 04:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riRlE-0001ib-SB; Thu, 07 Mar 2024 23:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1riRlD-0001iE-Ny
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 23:23:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1riRlB-00051r-64
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 23:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709871784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6FCjidflDebZw4/K4/H//697ULgcbVohVuCWajImT44=;
 b=ISdnZWpl5hWVG31jxVlmq+ZYHu9kHKLhehiinKhC6YER7L0gKjtnsSz35Q/yjxjIQJFeHg
 EssWtSiK8/D6uwhKUG6gQjS5vsANhwmUc7E5bV1t55VpNrFJBo9ofjQPJHf3tCQgIauNHX
 nGkKmnfxG8RwAhUqlyMSPVUaJEU2iVY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-sth-QItgMt6ZxhVLhhPqVQ-1; Thu, 07 Mar 2024 23:23:02 -0500
X-MC-Unique: sth-QItgMt6ZxhVLhhPqVQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c22a44deaeso406861b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 20:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709871780; x=1710476580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FCjidflDebZw4/K4/H//697ULgcbVohVuCWajImT44=;
 b=NWybTT241vrLKqYtpqdHlXHlwJn4jBrIeM3NRWNhQ36W/e8i/6PN4l8DWPL0G36I5h
 FBJE81qgr2jDCvl2i9CERJE5G+vOBspPirqM5ZzN1NTAYt44Hhz9OhoZVX9EXvzobYUO
 p5s9osQconKSY9xryGs95thywL4v7Mb8vzNmiRg0FW4l/GCkOSL0mvC++LUGx2ialQyX
 Il2oxszausRivTwGYn0lm1SNUdqYAaslisc8cdTL+lGpbAOJ6+tm/O+OFoaeJL0cr8D8
 TtAk5lPAZ59cZXDa+9eQ7DbK/SOss3zSMotnh9ohuyjJw1stSD7P1alZOzRe4XzBJCFC
 dbzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgxZPj4iBF3ZYS+EmoXxZlhaV1h4EoGfp9FxLjt9SMzq6dlcZ50+AlYPX5u6v+eWIVOndvrVYITzptk+D2QFZ2YBKnaIo=
X-Gm-Message-State: AOJu0Ywciuk5dcGL6Ex68E7RTxMAR1N3/P8kb1ezLyzFNf6iNVJHTLDh
 kIBSMjPLX1PYLNpH0zcg+9uLSWsgacuFhboFoSfZGhnXqieXdOYdNWd6d210UcMYibkz0Hgh/Zp
 eMcHTQC5cSloowi5BRuk2YcUp4k0+JhZxwnAs60C/uhfjaKJNdQNN
X-Received: by 2002:a05:6808:23d2:b0:3c1:ea3e:6aac with SMTP id
 bq18-20020a05680823d200b003c1ea3e6aacmr12595189oib.14.1709871779769; 
 Thu, 07 Mar 2024 20:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7p37m6EIzmHvGEQgu9HINnn/3Lf+nuyQGMeV9Lx613HjGykGiGrFlz94gtCgqW02anxx3+A==
X-Received: by 2002:a05:6808:23d2:b0:3c1:ea3e:6aac with SMTP id
 bq18-20020a05680823d200b003c1ea3e6aacmr12595172oib.14.1709871779308; 
 Thu, 07 Mar 2024 20:22:59 -0800 (PST)
Received: from localhost.localdomain ([116.72.130.109])
 by smtp.googlemail.com with ESMTPSA id
 l185-20020a6388c2000000b005dab535fac2sm13191781pgd.90.2024.03.07.20.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 20:22:58 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] docs/acpi/bits: add some clarity and details while also
 improving formating
Date: Fri,  8 Mar 2024 09:52:52 +0530
Message-ID: <20240308042252.4083-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
testing bioses is useful. Add author's FOSDEM talk link. Also improve the
formating of the document while at it.

CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/devel/acpi-bits.rst | 55 ++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

changelog:
v2: commit message improvement.

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


