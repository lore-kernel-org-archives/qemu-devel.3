Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCF5D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4Z-0001De-5r; Fri, 11 Oct 2024 13:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4Q-0000hu-Fy
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHeD-0007HK-M5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNkkdnViJzmwPUrPyUoXMSX7pAPJHiwhmuc02vFfZIA=;
 b=XjbaFeMoL2I1He7l5byNoTu9WSx4vQLdwD2a3AS6SCVWDilNGf7nKuuxtitd3wFft86a0s
 2WYfCRva0FzAgVhAdNYBPNkDjASWJQDtNRf0AoR8JsElSqPb8/yf995iAsqLH0YhHbgQUu
 BzeDwWzEsfBLNoxUeLBp8MEgEZxtpYA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-NQZgpW_qMUqpYIYx8KpB4A-1; Fri, 11 Oct 2024 11:33:43 -0400
X-MC-Unique: NQZgpW_qMUqpYIYx8KpB4A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c92e8b8101so1361522a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660821; x=1729265621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNkkdnViJzmwPUrPyUoXMSX7pAPJHiwhmuc02vFfZIA=;
 b=w0aVp80hh/Hpzy1Ui/t7Ve3HXgbfSFk0QxGi9++2GeP00M1Y98bBRhqF7Zz2BLqiHO
 VlDyaOoxpTdKsahisv0vrk60fSmzeReTQoqMN2WZR/KiRQgn/yzO0aNHjYcC+l9uerDF
 4Fi/R5r0QzkSr/4YE8FRuaq1KKyrY11LMW2jO/ERVxWeRP5m52Q0EjgaYafKzAsbilK6
 HbcHYn9X0iPnyqtIS/3kFvwLjlseWUpHs8YpxnEOO2Hg1Dm3TQ6wB27UrIr8IkVyGMr4
 b3N3xAFwoe0YFev/bVGk+joZ6WQ42Ylk7b0MH6feuSm/rVdqx77ZongeW95oP/pCnKaT
 6Jnw==
X-Gm-Message-State: AOJu0Yz56/DxCSc5IDKDIASEPAlMp6qm2lcJutsQyIOBS/gAxXodj4N1
 3L87argmdOGkjW+RsPsRfPtqtCIisyOo8eewCOUvwidC88IGUW9tZwXy8+/NQO6Uh2SNGxM7BH3
 MWoszIELORTWxZ703LKEqEPHwquXOmZSXX9v3geBC8X7lxjxbj2fqNK4WYLMZju9TR+0glrnryl
 imaMnX6OnaJHizJo7Q2+Is+g22YAusulrTZUw1C8E=
X-Received: by 2002:a17:907:c7d6:b0:a99:5629:b3ac with SMTP id
 a640c23a62f3a-a99b957e3b1mr262460366b.26.1728660821125; 
 Fri, 11 Oct 2024 08:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGolNN6TBVqw1Sg0aWcAp2PM9aWGSVjwwyVB7HZv8r9QKMVXpHj6J3w5dxisH1n+nnd/1WjPA==
X-Received: by 2002:a17:907:c7d6:b0:a99:5629:b3ac with SMTP id
 a640c23a62f3a-a99b957e3b1mr262457766b.26.1728660820550; 
 Fri, 11 Oct 2024 08:33:40 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f25411sm222853866b.67.2024.10.11.08.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 16/18] docs: fix invalid footnote syntax
Date: Fri, 11 Oct 2024 17:32:24 +0200
Message-ID: <20241011153227.81770-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
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


