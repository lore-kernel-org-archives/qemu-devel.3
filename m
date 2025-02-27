Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63062C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekR-00074E-CC; Thu, 27 Feb 2025 09:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekN-00072h-P2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekK-0003iN-AO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rffOM0f5uVVtqcpBSP7+vcNn2V5K/QuALkN5DWmU1mM=;
 b=V3wvxd11JJynKhtd/RziZ4jlYjazhfWcigGc+hgiZUP3DSrwjLtoNP+a3Kpdc24I1D2zYH
 nl+7LFUejMJWOmVzlF6D4G0sZBKwaqm0astkTyhF2zj7JIK1k1x2cyN0A+2Nsk/96QHyNB
 BRElI58YcZwFrWZdUFm89EPldDUt2J4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-bwRcAuttOv2TxXdHS50Sbw-1; Thu, 27 Feb 2025 09:20:14 -0500
X-MC-Unique: bwRcAuttOv2TxXdHS50Sbw-1
X-Mimecast-MFC-AGG-ID: bwRcAuttOv2TxXdHS50Sbw_1740666013
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e082a05744so1106825a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666012; x=1741270812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rffOM0f5uVVtqcpBSP7+vcNn2V5K/QuALkN5DWmU1mM=;
 b=o9zuiFYwlcBvMRwLqKU4RUZOpysClXBKHcbE/0e0RftW65M7xBr7OptcgI28cbLhLS
 OVstDmYO8kl3XIGS409l/veFpTxP6qU2AVZ9oY3hVAzdnQ0SK0q1H99JrCixyVZVZOSz
 sO4LLwOb9nTeaAyfwogF7lBCFAkp1N759DvVCtkH7/nfzkd6zAtn1TkXCR5YkPof1OJw
 R85Amjf3gx7M8oNuZM3DohXABp4WhwztJhsbhioX7SXz0L9nh5ux7IeD+Fwg550mqR8D
 5XGzA3729XT0jtIu9YoGKJzWyYiWDphu5epQlJcyyGIWmw1GdR/f9FEr2eHqbn2SxDWx
 RiRQ==
X-Gm-Message-State: AOJu0Yyml/YhCV16AOb3bR/kalKW3SDb9RsZGWi8mCkMO+8oPG05A1cX
 Jem2GwEDBngyoUfqMyEg3IQlqCjxEIkyNo5nXFtjcGTgN1kYZJNCfyHe5JutQWmLwC2JfXqtPtY
 cQKGpogUo+gHmOLoq2ePQU/ItJPtKu2XOMbijcn9wN5zg1iS/vPgjjC9ChoWFWtJ4cKfY0g46Vm
 2mBcXUySYk6r16U4s5EvmDQWcKZJz2UUhJWhuMR9g=
X-Gm-Gg: ASbGncvaRutVM9L0awmoq67I7e4/Z/l83htNWEEEtWMrohJX/OpsCFl466LFFGkDMcG
 ffO1S/BXsHB98EDJ3WFOTsB3yom8eMRs+0UjNreKpvQHBvXwGESHPZ2wT8LrBSIJFo7KlZtLteu
 KZv+sH7ZJ7yqwVs+d3eWC2XQulLl4OSlPj6dcinR8JIjkkAVWrCfSQa+m8VrQlMrEV99jiiagoQ
 gtIAoL19OivkKoHiPAZmxAUBcHaXA1zn6IpY5CG7M3/7U4pk6j6EP60ZzGF8lm7KcLKO0ieHzzl
 MFPQP0tZx84SgcFhT/GA
X-Received: by 2002:a05:6402:a001:b0:5e4:a0c4:1db7 with SMTP id
 4fb4d7f45d1cf-5e4a0c41eadmr7442309a12.13.1740666011884; 
 Thu, 27 Feb 2025 06:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8bZf1qckRKdvlgFMb0JPie2kjFkOllhql9a2DyL3Zbr2Cpwq9f7HU2qxJuzxbhtkv1UKFGQ==
X-Received: by 2002:a05:6402:a001:b0:5e4:a0c4:1db7 with SMTP id
 4fb4d7f45d1cf-5e4a0c41eadmr7442290a12.13.1740666011514; 
 Thu, 27 Feb 2025 06:20:11 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b70112sm1145715a12.31.2025.02.27.06.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/34] docs: rust: fix typos
Date: Thu, 27 Feb 2025 15:19:26 +0100
Message-ID: <20250227141952.811410-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index c75dccdbb7c..d68701c9c87 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -294,7 +294,7 @@ to a Rust mutable reference, and use a shared reference instead.  Rust code
 will then have to use QEMU's ``BqlRefCell`` and ``BqlCell`` type, which
 enforce that locking rules for the "Big QEMU Lock" are respected.  These cell
 types are also known to the ``vmstate`` crate, which is able to "look inside"
-them when building an in-memory representation of a ``struct``s layout.
+them when building an in-memory representation of a ``struct``'s layout.
 Note that the same is not true of a ``RefCell`` or ``Mutex``.
 
 In the future, similar cell types might also be provided for ``AioContext``-based
@@ -350,7 +350,7 @@ Writing procedural macros
 '''''''''''''''''''''''''
 
 By conventions, procedural macros are split in two functions, one
-returning ``Result<proc_macro2::TokenStream, MacroError>` with the body of
+returning ``Result<proc_macro2::TokenStream, MacroError>`` with the body of
 the procedural macro, and the second returning ``proc_macro::TokenStream``
 which is the actual procedural macro.  The former's name is the same as
 the latter with the ``_or_error`` suffix.  The code for the latter is more
-- 
2.48.1


