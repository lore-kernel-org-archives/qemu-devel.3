Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F708C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduyJ-0005T8-EE; Tue, 13 Aug 2024 13:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyE-0005Cf-V8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyD-000374-8u
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5E+Zx4qNMQOjvqcd8nTsICa9sF4C2u9SUGf4qbqIJp0=;
 b=EZiA+nNb3PbbR4NoTRNmi1KKc+YrEgY1vTl2mlNZuSl/rXJdiuqNAltAN/GRTmK+Bcyshq
 VSua7oTTcYJJYQKVf79VZn/5j0dzu6XxzhV6NyVGBfDMtTaSub1JwM/MNOAZWZSvXB0/hE
 ZGOfCEA6S2QtK0/S2O/IoaMg2VETOgI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-3nuib-vDPemEEqdsKc5eaA-1; Tue, 13 Aug 2024 13:06:01 -0400
X-MC-Unique: 3nuib-vDPemEEqdsKc5eaA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a79c35c28f1so455549366b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568760; x=1724173560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5E+Zx4qNMQOjvqcd8nTsICa9sF4C2u9SUGf4qbqIJp0=;
 b=huIezF5Hq6wrs0pZYd077nDfT7fq7B365eQUQ98qUZVDY/1xmw+FVor/ULj2nLzpNM
 6lt9KvIFoD/HE2xp+XNJnLZg3HO5roWhO1GcvRt0Bug16vwxZxWBXHCuAdAWWUrUyiNz
 6OqXRSswi2m9biy3nsCpj5Eq8wfZpPOsBVGFR0yzo4SBrY0jftJbK8ny+k7mno730kk1
 piQfwG7eGMPTu6ICCNd2NVE1map3USXf8/Pj3z5d8JUxL4LIY65B5m7I0ymJasuddLZP
 QJdXjw2K+DWK55VQG8XcG2m+3jfUtzGooWUFy1fTVnvm0/Mx7925VQppUC4Y2UcAqDjA
 aLPw==
X-Gm-Message-State: AOJu0Yze2XYUYqJvqIz2TwNJTg4afZLkFE7AhBLB4ITGVpsQdgVa9Sbs
 FKSKPw3zQP8ujGyoxAZcnWJmebOVIhX/avy3N4Xu/gu2BLR6D43TZ3W5+2WKt/2Pmb8fI3Aw2Wf
 tp80XYJ8qP7XxsjukkuU6NRuuCB3RuryfHRZibcdUdBSZznuFEz/UCSI66KIv2XV2XG618EZB7t
 M5xdKYfcrUwhsskF4no6Dt/Z/ahOeknnbn3KV3
X-Received: by 2002:a17:907:3f8b:b0:a7d:a008:abca with SMTP id
 a640c23a62f3a-a80ed2d6162mr311837766b.56.1723568759831; 
 Tue, 13 Aug 2024 10:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ErBRXrURnmX1kGcu7k/Kp6vpVo2v4lkdnqORfiw5U1gXLvXEzderH94vc/IaNQPMMULDDA==
X-Received: by 2002:a17:907:3f8b:b0:a7d:a008:abca with SMTP id
 a640c23a62f3a-a80ed2d6162mr311834266b.56.1723568759265; 
 Tue, 13 Aug 2024 10:05:59 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f4183762sm82623566b.202.2024.08.13.10.05.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:05:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-9.1 0/6] Miscellaneous fixes for QEMU 9.1-rc
Date: Tue, 13 Aug 2024 19:05:49 +0200
Message-ID: <20240813170556.104193-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 9eb51530c12ae645b91e308d16196c68563ea883:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-08-13 07:59:32 +1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3ef11c991e501768f2fa646e8438f075be1cd2f5:

  po: update Italian translation (2024-08-13 19:01:42 +0200)

----------------------------------------------------------------
* fix --static compilation of hexagon
* fix incorrect application of REX to MMX operands
* fix crash on module load
* update Italian translation

----------------------------------------------------------------
Alexander Ivanov (1):
      module: Prevent crash by resetting local_err in module_load_qom_all()

Alyssa Ross (1):
      target/hexagon: don't look for static glib

Paolo Bonzini (1):
      po: update Italian translation

Richard Henderson (3):
      target/i386: Do not apply REX to MMX operands
      target/i386: Use unit not type in decode_modrm
      target/i386: Assert MMX and XMM registers in range

 util/module.c                    |  2 +-
 target/i386/tcg/decode-new.c.inc | 13 ++++++++-----
 target/i386/tcg/emit.c.inc       |  9 +++++++--
 po/it.po                         |  2 +-
 target/hexagon/meson.build       |  2 +-
 5 files changed, 18 insertions(+), 10 deletions(-)
-- 
2.46.0


