Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E4CC25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXvQ-0000wO-RG; Mon, 27 May 2024 06:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvI-0000rn-6f
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvG-0001CO-BZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716806983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfYj1zWDa37QMZhg2QbMpwvSXs7y8EDnFObV+cxXRkA=;
 b=NHd3k3eK1yftxSqAzsEOKOK2rpY5hM9H57vrnOsKGX2i+del8MkFWxt+oJmY6sn26qIEsQ
 oxIYpJJ2F3pEYEnvhEAokRuIRQjKQkYN/0wnkTSgWGY/O3T8bHjmJDZYlFMwMAplT6q135
 /bocRRCzY+KwLDA7XjrSDOthKIt5Z1Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13--KRpi5Y-OXeWKWo4XhXRrA-1; Mon, 27 May 2024 06:49:42 -0400
X-MC-Unique: -KRpi5Y-OXeWKWo4XhXRrA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6269ad7bfaso144135966b.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806979; x=1717411779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfYj1zWDa37QMZhg2QbMpwvSXs7y8EDnFObV+cxXRkA=;
 b=UpVBoBYAFz2B6npCuM3bdZotueasNgWLGB5VZMJ7ECAcct9kyC/vHfv2rXSxkT/MBh
 HRGjBc+bxd4JAw8t+dsLjPd7YninaM11szO8IxzJZiT7tOMfKcYKy6sRXm/kjrf0OE4g
 gtFjpL1OdXlChjPmu1Z26OFX8hV8M3w6UEftNwpiU2pkW5xykA2ehYjflpUyudZ6maK2
 C246ZkvkHcMdC9bpS4HQtl8J0dOB042n8lUWdaNJcK+Fn6E3H7PGqnZKK9rPyMz+TTrg
 vTTF0mPljKdkCNMbO1EajjeJubcJJhauTJirCPxnyKB59oWey+ErWJeHZMb5AFL+vbpr
 cvDw==
X-Gm-Message-State: AOJu0YxyEGaIfGGx6SB+MWURXj5FAXMiKXMquznQC4PYLpHaf7HWSdpk
 K3cz1gqyRxoiHmpK/MKTOizB3/TovtH8jpf8e9stUVkOeCjB4dN+UWxK5Ipk7V5anu9oxRq00SK
 vfVFL7hh4gXF2QhP1UHir56T4ZmS2n+Mdcb2TqRKMTqlhNBpOkuxedhKEoKSOAw6NkFTb3Sf/+i
 yZVhBtPJlPKx9sDsmaDamuWd+pKpE0Ep1j09wW
X-Received: by 2002:a17:906:38cf:b0:a5c:dd34:25e7 with SMTP id
 a640c23a62f3a-a62642d894fmr602022066b.1.1716806979523; 
 Mon, 27 May 2024 03:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGujb39w81ghOAxqsTbm6PV52v1VIjwwtPYsGFe9vYqdk1zHfR0zxlrARtDQDgXbb3acevNKQ==
X-Received: by 2002:a17:906:38cf:b0:a5c:dd34:25e7 with SMTP id
 a640c23a62f3a-a62642d894fmr602019566b.1.1716806978891; 
 Mon, 27 May 2024 03:49:38 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc4f811sm479654066b.132.2024.05.27.03.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 03:49:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
Subject: [RFC PATCH v2 0/5] meson: Pass objects to declare_dependency()
Date: Mon, 27 May 2024 12:49:32 +0200
Message-ID: <20240527104937.30443-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This is a working version of Akihiko's changes to declare internal
dependencies as objects instead of static libraries.  This is a safer
way to drop the ".fa" library suffix, as it drops usage of the
pseudo static libraries altogether.

Static libraries trigger an issue in GNU ld, where GNU ld keeps all
object files referenced by thin archives open.  This can cause it to
exceed the open file limit.  Another problem with link_whole is the
suboptimal handling of nested dependencies, which is described in
https://github.com/mesonbuild/meson/pull/8151 and
https://github.com/mesonbuild/meson/pull/11198.

I'm keeping this as RFC because patch 2 ("meson: move block.syms
dependency out of libblock") is a bit ugly.  I think it's _less_
ugly than what patch 4 reverts, but I am open to comments.

As Akihiko noted, fork-fuzz is gone so it is possible to just remove
the .fa suffixes.  This series can be evaluated independently from
that.

Paolo

Akihiko Odaki (2):
  meson: Pass objects and dependencies to declare_dependency()
  Revert "meson: Propagate gnutls dependency"

Paolo Bonzini (3):
  meson: move shared_module() calls where modules are already walked
  meson: move block.syms dependency out of libblock
  meson: Drop the .fa library suffix

 docs/devel/build-system.rst         |   8 +--
 meson.build                         | 100 ++++++++++++++--------------
 stubs/blk-exp-close-all.c           |   2 +-
 .gitlab-ci.d/buildtest-template.yml |   2 -
 .gitlab-ci.d/buildtest.yml          |   2 -
 block/meson.build                   |   2 +-
 gdbstub/meson.build                 |   6 +-
 io/meson.build                      |   2 +-
 pythondeps.toml                     |   2 +-
 storage-daemon/meson.build          |   3 +-
 tcg/meson.build                     |   8 +--
 tests/Makefile.include              |   2 +-
 tests/qtest/libqos/meson.build      |   3 +-
 ui/meson.build                      |   2 +-
 14 files changed, 66 insertions(+), 78 deletions(-)

-- 
2.45.1


