Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EEDD33991
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qm4-0001lS-1G; Mon, 28 Oct 2024 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql3-0000LV-3w
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkt-0003ko-8d
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB7G90+Tf57PYu9+1OIot/PufKxyTD249TZ0dYeOJQU=;
 b=gydlhh933Az2jxlldHH9QI7WLTJtFh/U5/RDILGn6Fvd7RCcqK2hu4mRbpPnrQXtX0fq83
 R9zEfaYFSBqKOKU8c76iVp0Ibu3vV4Cm9AIz1Xnv7Mod8/+sPeRUZVsawWrlawngm2pWod
 4ZBA3PfPzOJuse707JToL/GuSp9KWp0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-lA0ePlZaMteFSeLjfgbDMA-1; Mon, 28 Oct 2024 10:30:01 -0400
X-MC-Unique: lA0ePlZaMteFSeLjfgbDMA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d603515cfso2081260f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125799; x=1730730599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DB7G90+Tf57PYu9+1OIot/PufKxyTD249TZ0dYeOJQU=;
 b=isnsZParup5Uh8s52QtY8f7vevApi2LQIM7oNIfBmh7JP9hcAgJOTb1zunJZhpBj7I
 7std1pRXUH2cTk/guRt8aB+Z2Q25mqOVRFZfiZWPqulEePCUKaIgb6V2Ao6/X8p0Qyno
 joW0nPI4MpoULZ46cOABganOVzADQJkbr1a3qMIWPCy9hsRDYQGUpUj85qjskugBfGoo
 mGZLji0fwbPLhq608L5dg3SYFl5RyG4cyamCz+L1Ui3PKAORzJA+CzieuyAWl+YYeQpK
 C3FJNdzvMQHynFehvR9eEaYA21/DJaTFuexihxw2mg4mxAgc97Ua+98dI+WsNIqsLI71
 kWmQ==
X-Gm-Message-State: AOJu0YyjKLOEDfSqPp4L9jLREGtQLxvrLRCzNBilHbfhGdmy7Y6Ks//P
 s6y3lWtkMpCtlFsJ9SYk/0qg05katlZf6isKdIEr91W6CKkp97gudNMdeVeZOG8XkEiZ3sJUAMz
 MSIl5godvXqxWwnsiJhZ5LWJh2nXHcr81U7QL4AFU8AjJlW9KFOC0bed+Oox97rN44F/XDd7mJW
 gaqGto8+94hrFAy6Nabn1thf2tL3DrjT4qdQ1FilE=
X-Received: by 2002:a5d:4e0e:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-380610f7b1dmr6225907f8f.5.1730125799330; 
 Mon, 28 Oct 2024 07:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwhh5EdlAVH/Ky9t3ZwsbmWYYg2rAZN3hghsz81PMkxVKW7pA9r8O1NN8WlvIx5ju5mS3nwg==
X-Received: by 2002:a5d:4e0e:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-380610f7b1dmr6225887f8f.5.1730125798876; 
 Mon, 28 Oct 2024 07:29:58 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bb4461sm9561669f8f.113.2024.10.28.07.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 10/24] meson: remove repeated search for rust_root_crate.sh
Date: Mon, 28 Oct 2024 15:29:17 +0100
Message-ID: <20241028142932.363687-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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

Avoid repeated lines of the form

Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/upstream/qemu/scripts/rust/rust_root_crate.sh)

in the meson logs.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 891590353c4..0f1de0db2d9 100644
--- a/meson.build
+++ b/meson.build
@@ -3977,6 +3977,7 @@ endif
 
 
 feature_to_c = find_program('scripts/feature_to_c.py')
+rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
@@ -4078,7 +4079,7 @@ foreach target : target_dirs
     if crates.length() > 0
       rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.rs',
-                              command: [find_program('scripts/rust/rust_root_crate.sh')] + crates,
+                              command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
-- 
2.47.0


