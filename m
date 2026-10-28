Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IaIkrcxm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzwK-0007l2-TW; Wed, 28 Oct 2026 05:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzwI-0007gr-8L
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzwG-0006jz-Lw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ea1e7fad99so4430295ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179639; x=1793784439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z65zVelmLx1fFCAo4lDjRGL/KahgCS4BHF2UkQlOECk=;
 b=IaIkrcxmPLKzdsHsorn/fgrzMk3ibawvQMhw/DBw9Buz1QNundnzJkMYbtnyZ/vkK9
 fOtNcx44G2fPPXIevEXubJzKar0R7JDA0ebFi9OqY9onkhW4P9s1Pdohwika0niYeNKR
 ElsP78Jc6sDVvow0+44YzmgMxen8D58F02VJOQqnvaNxWk8FyM5xF8ABuN6TyuJpwO6Z
 9ov6Okvj8R6lBa2dZIAvvU5cG2XhdH/F5AStK2VagNPAxSGa66WbyhNYfF7jjqyrrCPQ
 iUO5YtmxomSfdeFYH7qnGzhbyfzmVH4DTFdy2v92Z7fD8aASQGcrKwr9ujLVy9SvcYyi
 k/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179639; x=1793784439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z65zVelmLx1fFCAo4lDjRGL/KahgCS4BHF2UkQlOECk=;
 b=FffFTpj/TgrVi7OewvSNU77d60MSYrtn8DYBBZjxILZxDBuK9a7ByG2aEWoSCHlzS+
 VSv1Bppz2ECQppr4LS+OMM0lZLIHD0nua8EEhNGWDNr2k7+eXzXsRYh0yzLZIu7E2k6i
 Fy41uYRwisYscQ7dk+j/o/C+1bbILXGdqsAybDqbbTSibshTZS1vC3v0tQQ/RJ6UT1nE
 MAsOKI1OXV04yyrdB1U0HRg8Hhg1KjWDOPZ8O4fPZJw3uwfC84TcusfZc9UpNqIZJVSJ
 fZ+bKpWWgCT/YNMzra1ldSdckn2PwTAM0RxOCNauTfrVdMV8j33S1Psu/FDXydBtTpnI
 6Dwg==
X-Gm-Message-State: AFq9FYJ+ye/37NQMvxnNxXYWqjJCfkVzgGPW6kbfTB8RTF90AZ9/to6l
 O41nvrB6kSaD8l/gfSab6inmjOCs7e9fDUFrlB/PRpp4mkBgP50STrk1B9QNlpwg
X-Gm-Gg: AYBFou1v4cFRz9ekgN4cPX08pXjH8dQy2lwJkSv/fpfOmuD+9ai/Dk2al/C/AWwCYAX
 Emdye7tVu82tBCYerhcAA1IgnVBd+UBvFL2XuUP+6v5K0WhlEw4iWpofms+4N8m9Qnc+AGnQIwo
 rxaq6lJ27x1/ICxhiZv1zEd67mSWgQqnz75zVyikdAPH/oeGpnfp8VHaJ+nLSUbKmn5sxS88vt5
 v/aZuslFH8Kpy8M6xP4Z8rYeqYjCuMDsWmXKhWDlfXy36a6c7mJNXTZZ9/k34Yq8KnThxzBDT8Y
 IuBjUeBYhS/JVWCxzXuI2KS29VMwSJUBwHBNdbIhi8oedw1T/iSK4JrjFKWC0e+WIRe9D723tho
 XoTZ+mTXcaAF6909NPpHmdYCEfHiPMT3sq8aKDiTQo/bqmNGfAOLv71JbDtAa2DI90arn7rDSev
 rK63xAWDBeSqQAt5BgnhjbET7TrBlmS4DIyAb2yKc6IX5G9RAHlaOxsIf4Ck7SL0U7RWQXkgqlP
 NiZOFeqxi7o/aKJ9hNH9CNDrfeAfC4LaSoSZori0FocWg9qKq1Rm2WoB6Wbotk9PV9GUKOfWJnr
 1z+5YeGe1V9p5cdVb8P+rt5bAp30k1gQEH0S+5MIX92Aihabpof2EElzs73Gqu+0YIbUdtgEmE9
 oqAvC
X-Received: by 2002:a17:903:2f08:b0:2e8:3d48:4d80 with SMTP id
 d9443c01a7336-2eb004ed893mr15717005ad.45.1793179639393; 
 Wed, 28 Oct 2026 02:27:19 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:27:18 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 14/14] docs/devel: document holder-aware IOThread
 AioContext APIs
Date: Wed, 28 Oct 2026 17:26:19 +0800
Message-ID: <20261028092619.1654474-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the obsolete iothread_get_aio_context() reference with the
holder-aware API. Document matching get/put calls and their BQL
requirements, and clarify that the unsafe accessor is for legacy
callers only.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 docs/devel/multiple-iothreads.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/docs/devel/multiple-iothreads.rst b/docs/devel/multiple-iothreads.rst
index a6eb046267..3bd8144ecc 100644
--- a/docs/devel/multiple-iothreads.rst
+++ b/docs/devel/multiple-iothreads.rst
@@ -88,11 +88,20 @@ argument, which is used to check for and prevent re-entrancy problems. For
 BHs associated with devices, the reentrancy-guard is contained in the
 corresponding ``DeviceState`` and named ``mem_reentrancy_guard``.
 
-The ``AioContext`` can be obtained from the ``IOThread`` using
-``iothread_get_aio_context()`` or for the main loop using
-``qemu_get_aio_context()``. Code that takes an ``AioContext`` argument
-works both in ``IOThread``\ s or the main loop, depending on which ``AioContext``
-instance the caller passes in.
+The ``AioContext`` can be obtained from an ``IOThread`` using
+``iothread_ref_and_get_aio_context(iothread, holder)``, or from the main loop
+using ``qemu_get_aio_context()``. Code accepting an ``AioContext`` works with
+either event loop.
+
+The ``iothread_ref_and_get_aio_context()`` registers a holder and takes
+an IOThread reference. After the caller has finished using the context,
+release the reference with ``iothread_unref_and_put_aio_context()``, passing
+the same IOThread and an equivalent holder. Both calls require the BQL.
+No matching IOThread put is needed for the main loop's context.
+
+``iothread_unsafe_get_aio_context()`` neither registers a holder nor takes a
+reference. It is for legacy callers that ensure the IOThread's lifetime
+themselves; new code must use the holder-aware API.
 
 How to synchronize with an ``IOThread``
 ---------------------------------------
-- 
2.53.0


