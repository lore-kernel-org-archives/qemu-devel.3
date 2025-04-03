Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3E5C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KSS-0004oq-IU; Thu, 03 Apr 2025 09:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KSK-0004mO-VI
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KSI-0008TM-O1
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743686280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YcXmOOdXkn7KD2kU3T4D2a+643hnUuNzLL/rcA7iNFg=;
 b=ijP3KjX2CsQZ4cj3AizVIxOTQMpZQRKwsb3Dm2ISEYFZUNB4/838KvhRPhlG3JlrxB6noO
 ST0MpiduBJAMyCOuMTDKlrotzcOfud2aA6y1l/Iud8r4Tr9RZmC40mhHgwzy7B2L3/Kd45
 caFHzsdzsVH8PWC+3J8Shxg3j+R/VhE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-9YH2tpu1PsKvRnGQsHe33Q-1; Thu, 03 Apr 2025 09:17:57 -0400
X-MC-Unique: 9YH2tpu1PsKvRnGQsHe33Q-1
X-Mimecast-MFC-AGG-ID: 9YH2tpu1PsKvRnGQsHe33Q_1743686276
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac2a113c5d8so69171966b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743686275; x=1744291075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YcXmOOdXkn7KD2kU3T4D2a+643hnUuNzLL/rcA7iNFg=;
 b=MiTxbXcoxkzwLox+VLZi4hop6acglFOgvYF02uG0p5EFOUoANpdLRsV99LxtnnfZ5J
 yoqQuFgAGff4M02WXP7AfSw8LWoTlA1TDlifsp80N/SZPpFqQ6tgJj0mxqT7KvvgF+xw
 ZdFC2ZTRBCmVeG5KZClXmEEu9RtFq4+uriFUqK6B6pGqTS+F30Cu+qEm3F/JkPSYowQ2
 oZ3Rxce6QffIX6SzvsK/83PkRSnXLgRQUf/cMzVglFT/Nxwf6cp+DJiojCodriBcK7aL
 P+fj9abiJu2g9vnNF5xd0erNot9XRS5SPZixEIlTMbZzskJEwGjNN5lX5UP5bie609n1
 vnfQ==
X-Gm-Message-State: AOJu0YxOEmYr7dR55PUPGeB37GLnk1LZx9Sa9L4jwnjqQBowF05OjUHL
 dhDsAH9yBDsfWdDfVa4+XGKe/gk/iH16rX0+cO1M7/l09ftUEb19LtCLIIPLLMCSixUdsw/Y6Wf
 VZvxLOA2L5hEHPLz5vxHBkKGgNhsaWEjHCgnfk0nEEjQUqC4UnQx5vB6k0Y/D+jX3XU0UovosYR
 NbX6Ch4PO4FqQCxnb1RqLuqy3YqQIj4ZXtNVnk
X-Gm-Gg: ASbGncv49GnTOjhAovZ1ZwwwMzbceCJDp7FdLRJd3Cs2WYoYlkes165PEKLgy1UW0Hz
 f/i9X6obxa/lfZf0Huhwpl7/C10+zaleO0kwnKczV3q+ZsbXwTi146VwBxu9szG0HYWt98bTP+J
 KaUayE8Es8CP9bfy64TbqdFoY8Bae3olGDrPWIswO14GYXAik1cVBdo7gtCeHTp7Lktjwdddg1K
 0c+jtvb0IpTWvI/yDdFQRO5ZWr5u4kjmfnim22MEeNJBxxqW5IqcIO2nKVUqXu5Lxmoq5FpxN1h
 sOE8Zy02q3OpVrYJZZux
X-Received: by 2002:a17:907:2d27:b0:ac7:391b:e685 with SMTP id
 a640c23a62f3a-ac7bc272e2fmr222573966b.59.1743686275469; 
 Thu, 03 Apr 2025 06:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe5aNXVCBYrZf95gWZEfzikNRF3Q4yDKYG4jt6wVPJm0fVDVd7OWuo5lefuRIawWRLDjg3dA==
X-Received: by 2002:a17:907:2d27:b0:ac7:391b:e685 with SMTP id
 a640c23a62f3a-ac7bc272e2fmr222570766b.59.1743686274969; 
 Thu, 03 Apr 2025 06:17:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c01be060sm91184866b.163.2025.04.03.06.17.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:17:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for 10.1 0/3] target/i386: share some EFLAGS code between TCG
 and x86_emu
Date: Thu,  3 Apr 2025 15:17:50 +0200
Message-ID: <20250403131753.82072-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

This reduces by ~20% the size of helper_cc_compute_all, and also
shares some code between TCG and x86_emu.  Also, the line of code
delta is negative despite adding a bunch of comments. :)

Paolo

Paolo Bonzini (3):
  target/i386: tcg: simplify computation of AF after INC/DEC
  target/i386: emulate: microoptimize and explain
    ADD_COUT_VEC/SUB_COUT_VEC
  target/i386: tcg: use cout to commonize add/adc/sub/sbb cases

 target/i386/cpu.h                        | 25 +++++++
 target/i386/tcg/cc_helper_template.h.inc | 90 ++++++++----------------
 target/i386/hvf/x86_flags.c              |  9 ---
 3 files changed, 56 insertions(+), 68 deletions(-)

-- 
2.49.0


