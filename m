Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D655C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyLz-0000ns-Cb; Fri, 31 May 2024 05:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLx-0000mr-OQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLr-0006V5-VB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SV+33v0z/DZWczWZ512ZzXAMz9G3MGD5AGLyYqLjaK8=;
 b=Hu2NV4mmJJ9cPXEUMfQzdyk5VF6nRicYLSfjXvOKq6IVQXiRCYXMgHUnGyR23GCLY6jY/S
 RTLY+DpWKOmnU2hKEbpcoqB/hs6bpImNmjZ8yZwHgKQ1Enecvu+w69PsdJLjguvuB+HT9y
 PubeegIKpRnisV+V4+vbQNoXMCAm6Ew=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-7wjniuDIM-qERHsw4xWVVw-1; Fri, 31 May 2024 05:15:02 -0400
X-MC-Unique: 7wjniuDIM-qERHsw4xWVVw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ea839a481bso13035931fa.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146899; x=1717751699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SV+33v0z/DZWczWZ512ZzXAMz9G3MGD5AGLyYqLjaK8=;
 b=mi3fUEM04QAXGXAjyR8/bsTPCJWqDSasoepWxjI3d/nSTfjpQi2Vi9UtGp7ANCEeqx
 DSPb8GaMRfTTLB5aGtCOFKNNmgIHkNfqo4nZSVto/VixzOcndaUABR4ksKN/FOa1NUQz
 Y2WahKOaUCq5IS64e3GUEYBGB0ThMm2KWPLW0U0L0c/nU2NP0UEnu9XYhPdiJmGtmAw8
 5Glpka/SV1w6UCc83SXX0g4tfgKeWUi8l03+tAZFndCAx7Y87KrpdMzpX9QbdxovSn/Y
 xJaSdyCDCdB5eduUOtH1zy+08cjTQE62EXsQjg5NX25RdKtmpDKaqwiV+klFb6/p6NRQ
 YYJQ==
X-Gm-Message-State: AOJu0Yz3jwEu8ffPxCQuKNWlLln8nL01HtUivkM1vnPu9wCjQhuqWviJ
 /z/AfkEaJpyZWL3GMcOk7T8u1Yw8mIXCy1z0U4xsIfZVdgCpsoyIRMkStg0p0QdVkelnxvTrWzn
 KYTfJEG3tB+dMJ5OrT2zdYMvKpIdkSwNgxGN0JLHzoojH6R7a15Pym5Dda8hpSqw3dcWPDUDMih
 jgE802/ZAUjdR6HuFFOwP/aTPyvWClNhgJNPxw
X-Received: by 2002:ac2:58ce:0:b0:51f:1853:25f with SMTP id
 2adb3069b0e04-52b895798bamr735040e87.19.1717146899587; 
 Fri, 31 May 2024 02:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPz8DU6p14+lBJmd6EXRa9Dmt9J8PaNlyhu7Y2N317LWM6yr7r3hh8m0d0MmouDljm+2E7MA==
X-Received: by 2002:ac2:58ce:0:b0:51f:1853:25f with SMTP id
 2adb3069b0e04-52b895798bamr735022e87.19.1717146898962; 
 Fri, 31 May 2024 02:14:58 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea58696asm64837466b.110.2024.05.31.02.14.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:14:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] host/i386: require x86-64-v2 ISA
Date: Fri, 31 May 2024 11:14:51 +0200
Message-ID: <20240531091457.42200-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

x86-64-v2 processors were released in 2008, assume that we have one.
This provides CMOV on 32-bit processors, and also POPCNT and various
vector ISA extensions.

Paolo

Paolo Bonzini (6):
  host/i386: nothing looks at CPUINFO_SSE4
  meson: assume x86-64-v2 baseline ISA
  host/i386: assume presence of CMOV
  host/i386: assume presence of SSE2
  host/i386: assume presence of SSSE3
  host/i386: assume presence of POPCNT

 meson.build                      | 10 +++++++---
 host/include/i386/host/cpuinfo.h |  4 ----
 tcg/i386/tcg-target.h            |  5 ++---
 util/bufferiszero.c              |  2 +-
 util/cpuinfo-i386.c              |  8 ++------
 tcg/i386/tcg-target.c.inc        | 15 +--------------
 6 files changed, 13 insertions(+), 31 deletions(-)

-- 
2.45.1


