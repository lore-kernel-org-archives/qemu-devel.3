Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632F6CFD34A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 11:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szDZv-00075h-4z; Fri, 11 Oct 2024 07:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDZt-00075F-8v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDZr-00073J-FF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728645178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNkkdnViJzmwPUrPyUoXMSX7pAPJHiwhmuc02vFfZIA=;
 b=EqFjej8wij5fOERvAmPLV4kiUrkxdnR2elNr6JO0nLSgBfbLHNYz9WskCwbpA35TThwhX0
 hbemNUVQxLqW2uH6enG05mbxh64qRhj2GDlZt2RQfFt4MCbc4FiLM84diVpwS89m/OZ99e
 NkPsqQHruvlUnNomFmtI1azhIXxnNu4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-SUoo_Yb-MjmtNkJQDuAPuQ-1; Fri, 11 Oct 2024 07:12:57 -0400
X-MC-Unique: SUoo_Yb-MjmtNkJQDuAPuQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-53995187384so1977429e87.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728645175; x=1729249975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNkkdnViJzmwPUrPyUoXMSX7pAPJHiwhmuc02vFfZIA=;
 b=QNQxxTesfQFnRqe547O0W3OTZP38GIoWOrVZOc4yrTC1EEyLersf2uN+L/ugx6K7eZ
 S6RCNKwp0QpkuZBZ+5jQeWHaj7bLy9laPphyaq37B40EvSvdAwAgYC4NXTwxTkIR8+K+
 b4/3nUDnzb3AesX/IKMd8Jx5fEgmAoiWfuv+hdECS5UQc0I19VZBP2JGklnGeGW+dhVM
 5bxbv1pCZr0YqcA88TwKHOU2lezJRkY01Q2WC2UU+gz4+i2Arf6phT+SXsQFbLc5PZxu
 RG1iznrGiGGPGD/mrH99S5GFKOoypWp0cgO+kPKtZ+hDSa3KT5Kd2ICj7DAMUo72fCVg
 CY3Q==
X-Gm-Message-State: AOJu0YxUUycGOgxeq5t1Wx+0ZTm1GGZKn48uV1iFYrTv+MXSuH4Gx1Ij
 ubVSXrHLAAjw6bm06+OMsL3h5DkmZfdwcQ0js185yh4n527jm8r0ZNgfkHqycr8gu0DlyHEd0SZ
 nr6x7jUKxGo77JmO4Ue0G+UoDPvhyFG6ucZ/EQNAOEBtz2CDlGqRIFkg62Bpny178RztFB1Gimb
 gPWAK3J3OiDwh0zWnd9TG1reMxqkEnqTABDJCe5r8=
X-Received: by 2002:a05:6512:1294:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-539da3b232dmr1273420e87.9.1728645174766; 
 Fri, 11 Oct 2024 04:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg0BVVUSvO7ImebThXrgD3dj5iyd2irE3IDVTdNnmGwkitieGlxuOMug/FWa/EWyysZZWErw==
X-Received: by 2002:a05:6512:1294:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-539da3b232dmr1273392e87.9.1728645174173; 
 Fri, 11 Oct 2024 04:12:54 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80c0133sm200054166b.114.2024.10.11.04.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 04:12:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 1/3] docs: fix invalid footnote syntax
Date: Fri, 11 Oct 2024 13:12:47 +0200
Message-ID: <20241011111249.47530-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011111249.47530-1-pbonzini@redhat.com>
References: <20241011111249.47530-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

All footnotes must come after a separator in reStructuredText.  Fix the
two files in which this does not happen.

This mistake causes the link to be rendered literally:

   ...from the venv itself[#distlib]_. If no...

and is caught by Sphinx 8.1.0 as an unreferenced footnote.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst      | 2 +-
 docs/devel/build-system.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index b77c6e13e18..6bf032f9005 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -204,7 +204,7 @@ They come in six kinds:
   before the second with respect to the other components of the system.
   Therefore, unlike ``smp_rmb()`` or ``qatomic_load_acquire()``,
   ``smp_read_barrier_depends()`` can be just a compiler barrier on
-  weakly-ordered architectures such as Arm or PPC[#]_.
+  weakly-ordered architectures such as Arm or PPC\ [#]_.
 
   Note that the first load really has to have a _data_ dependency and not
   a control dependency.  If the address for the second load is dependent
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 79eceb179de..fa1c59d9fd8 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -145,13 +145,13 @@ was installed in the ``site-packages`` directory of another interpreter,
 or with the wrong ``pip`` program.
 
 If a package is available for the chosen interpreter, ``configure``
-prepares a small script that invokes it from the venv itself[#distlib]_.
+prepares a small script that invokes it from the venv itself\ [#distlib]_.
 If not, ``configure`` can also optionally install dependencies in the
 virtual environment with ``pip``, either from wheels in ``python/wheels``
 or by downloading the package with PyPI.  Downloading can be disabled with
 ``--disable-download``; and anyway, it only happens when a ``configure``
 option (currently, only ``--enable-docs``) is explicitly enabled but
-the dependencies are not present[#pip]_.
+the dependencies are not present\ [#pip]_.
 
 .. [#distlib] The scripts are created based on the package's metadata,
               specifically the ``console_script`` entry points.  This is the
-- 
2.46.2


