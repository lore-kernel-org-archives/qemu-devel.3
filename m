Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD7AECE58A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkjx-0000Bx-S6; Mon, 09 Sep 2024 16:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjw-00005X-C1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkju-00050p-Nv
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNxl6tlilb/RVxkqHnM+uvvHD1t1Pzft8y1Y+cNR2E4=;
 b=K46yrog3J6fXAvWeWqkNWwlNfTlG+mzvwD8DR8O/zhcs0bt6rERaYOU4BHkqDqWcq/TTKN
 WfVRVNpWkcUGDFiYN4oLI65N/Aq25gwJjPWztojD54YpvaCckdPVa09QM4H09cxKCrZPsc
 VBH4qQIn+nJXit9JoEPpH9m0zZ9EA7s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-j-WYBm8fMAC7qp5uGFnc3A-1; Mon, 09 Sep 2024 16:11:56 -0400
X-MC-Unique: j-WYBm8fMAC7qp5uGFnc3A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4581b5172a6so65174981cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912716; x=1726517516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNxl6tlilb/RVxkqHnM+uvvHD1t1Pzft8y1Y+cNR2E4=;
 b=ctLV5xJXy7L4GNBd/PqPNHi/7Auf9CBY23ynufN/3+v8grU0Ie29awFI60xSJQjzV5
 a92scquPO3Gqhm7AxBhWV04f+I3iCefm6J2RFTfeBrqOWjgp5SgxHi8Q1+GNpjMMWE4W
 SwRrLy1c2cGvFLVBS91e2pncjVevx0Fv43NkFM97AzSc9mi4+jwMe31/KTBeHLTWcckk
 9MT9D4A+NHv0Tu2rx9aLGQmPLm+vljEtUjv3OT2w3YbjCPoXK0+2Xc0DsWlKw3NDtDIu
 qJeaGkeudsheEbbtgtkVPaMUlr3EB+jMJzUegHAxNYAVmJXbq/go/v+mcR5AkYSxoGe3
 kJvg==
X-Gm-Message-State: AOJu0Yymf3WmVs5JdfYBUY8BAxpl1GG0NqABNbo5vLigglTizNF2NU15
 s7PG/W3I+qxfwL9PTd6kGrWd8VHFQKDJS7NoX19fuaW+8ZbVdMp+XMpgcdSWB3zXrGuoxGDLgMK
 XSttpndRojZlMz2KqJBE48gUoBdyVCSTRS8BmGauuQH3bK1bwDKsh1x7PBY9Mwndeqvod4gFdGy
 5k1DVsbIkDmx5DLNuGBW9DNCL8/nIuJtUSTQ==
X-Received: by 2002:a05:622a:487:b0:453:7533:a64f with SMTP id
 d75a77b69052e-45820102602mr124115761cf.21.1725912715825; 
 Mon, 09 Sep 2024 13:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Qi28kgnyxXDsZksZp4q0S/oFQ7mypcDMp5xlC5zYzVjKj6fn319MCAJZLYEx6VbtupZkYw==
X-Received: by 2002:a05:622a:487:b0:453:7533:a64f with SMTP id
 d75a77b69052e-45820102602mr124115391cf.21.1725912715353; 
 Mon, 09 Sep 2024 13:11:55 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:11:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/9] ci: migration: Don't run python tests in the compat job
Date: Mon,  9 Sep 2024 16:11:41 -0400
Message-ID: <20240909201147.3761639-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

From: Fabiano Rosas <farosas@suse.de>

The vmstate-checker-script test has a bug that makes it flaky. It was
also committed by mistake and will be removed.

Since the migration-compat job takes the tests from the build-previous
job instead of the current HEAD, neither a fix or a removal of the
test will take effect for this release.

Disable the faulty/undesirable test by taking advantage that it only
runs if the PYTHON environment variable is set. This also disables the
analyze-migration-script test, but this is fine because that test
doesn't have migration compatibility implications.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20240905185445.8179-1-farosas@suse.de
[peterx: Added a TODO to remove the line after 9.2 release, per thuth]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1d2afae996..cfc51be08a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -212,6 +212,14 @@ build-previous-qemu:
     # testing an old QEMU against new features/tests that it is not
     # compatible with.
     - cd build-previous
+    # Don't allow python-based tests to run. The
+    # vmstate-checker-script test has a race that causes it to fail
+    # sometimes. It cannot be fixed it because this job runs the test
+    # from the old QEMU version. The test will be removed on master,
+    # but this job will only see the change in the next release.
+    #
+    # TODO: remove this line after 9.2 release
+    - unset PYTHON
     # old to new
     - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
-- 
2.45.0


