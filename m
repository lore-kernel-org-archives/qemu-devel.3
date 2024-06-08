Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA12C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrdd-0001Ic-23; Sat, 08 Jun 2024 04:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdb-0001IT-GU
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdZ-0001Lc-V4
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=giCTeqY3gQkDNV2az+kH9seHEypnYBSwo6Omj3a2xfc=;
 b=ASYOGS0A0HZDQRVXkDiyVg5BRLmc1tCnN49At8/VMGxHlOrr68bwyhm6/OCxpGwddSr9Aw
 68PZwwW2F/Nkz5sJPv49tMt06IITje1d/JaqJ1CQ33/6M2bFsdX9i9F/CpenjYYQ838dgq
 5XFtvZ03Ily1YDmm0du3q1H3Eb9hqg0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-2-TaFgZfNQ6yIIag02pQcw-1; Sat, 08 Jun 2024 04:41:19 -0400
X-MC-Unique: 2-TaFgZfNQ6yIIag02pQcw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6def6e9ef2so114212466b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836077; x=1718440877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=giCTeqY3gQkDNV2az+kH9seHEypnYBSwo6Omj3a2xfc=;
 b=tTG/adKMAAfFU0HmH/h6MmFm7dFH9KxtjfDsqaTXQdhc0Ze4sAwtvFFW9BCghY/Ewz
 EFUkA6t3lCl2hiBbYlRjWMWthggBfMoM8/oIyEA8Zf0CzgIUnJHB+TuYcLbw7ARnxsg7
 OoPmxjzPrVRMAbETtcEblNHYNAs058DcrGXR7wYy4FPgb3AcpR1xJj+WONwL3FCC4edq
 c/UUggfjOHcr+N9LByCwlgtQ9cvumk9C5PqulIGm+kUnaWsed2Lz8aMLjy/mClsj2KIP
 neIm7uv0ct1TcoRNKBF4Sb+4UOVZ1gdsAx/YXW5onzA4YKzrXtHe4Z1YECAXuLHsUDCh
 rnIQ==
X-Gm-Message-State: AOJu0YyfOPZlkpm+Vl8O17XnIZpj05+rKfrlzCHEm7SnBQdXwrRXZg03
 AjJucIGWFhSGA1YfxSJhSg1URjAXHGVDfGwU+KPLyzxxNSCXnAOuEukyvvlt4cz7Grh7GUoFIB5
 KoS8C66SaPj6tXpRYP26vpDTgvVhZ9J7WB2Shdh8FXkuekUn7Z8EgCOUk0+L03aFvPaJyD1nsq1
 Opjqgb7s7Lj4jzXRqfkYw+Soc8lFxLbmUPVyMi
X-Received: by 2002:a17:906:2543:b0:a68:b159:11ee with SMTP id
 a640c23a62f3a-a6c760a4d46mr565430666b.12.1717836076687; 
 Sat, 08 Jun 2024 01:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+12KZ8Qf9UZ9ljtmujrv8Qti3ImHudbts4Se6dnNOGF1rAQIYb/z+0JCNXIgJFRaGLE4juw==
X-Received: by 2002:a17:906:2543:b0:a68:b159:11ee with SMTP id
 a640c23a62f3a-a6c760a4d46mr565429466b.12.1717836076183; 
 Sat, 08 Jun 2024 01:41:16 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806eab0asm354075066b.134.2024.06.08.01.41.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/25] target/i386: more progress towards new decoder
Date: Sat,  8 Jun 2024 10:40:48 +0200
Message-ID: <20240608084113.2770363-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Just like in previous installments, this series ends with a specific
thing that is now done entirely in the new decoder.  After removing
the legacy prefix decoding in the previous series, now it's _all_ decoding
that is done by decode-new.c.inc.  Most two byte opcodes are converted,
leaving out only five plus the x87 instructions, but even those only
use the X86DecodedInsn; they do not use anymore the CPUX86State (env)
to fetch bytes from the instruction stream.

The only reason why those five are left behind is that the decoding is a
bit gnarly and, having little or no commonality with the other opcodes,
there isn't much duplication between translate.c and emit.c.inc that
supports them.

It's nothing that's particularly hard, but this is just a nice place
to stop for now; and also I think it's enough to implement APX's 32
GPRs and REX2 prefix without the legacy translator getting in the way.
Of course APX quite some more work---there's all the EVEX special cases
and flags, and the new conditional instructions (CFCMOV, CCMP, CTEST)
to consider---but it's a start.

As in previous installments, there is some reduction in the total number
of lines of code, which is a bit surprising; but then again many of these
opcodes have modrm bytes for which there a lot of repeated lines, and
also it's possible to share some existing emit.c.inc code (for example
SHLD/SHRD mostly reuse the flag computations of SHL/SHR).

Patches 1-7: simplifications/cleanups in decode-new.c.inc

Patches 8-20: move all two-byte opcodes except for 00/01/1A/1B/C7
to new decoder.

Patches 21-25: move decoding of modrm bytes entirely to new decoder,
and cleanup.

Paolo Bonzini (25):
  target/i386: remove CPUX86State argument from generator functions
  target/i386: rewrite flags writeback for ADCX/ADOX
  target/i386: put BLS* input in T1, use generic flag writeback
  target/i386: change X86_ENTRYr to use T0
  target/i386: change X86_ENTRYwr to use T0, use it for moves
  target/i386: replace NoSeg special with NoLoadEA
  target/i386: fix processing of intercept 0 (read CR0)
  target/i386: convert MOV from/to CR and DR to new decoder
  target/i386: fix bad sorting of entries in the 0F table
  target/i386: finish converting 0F AE to the new decoder
  target/i386: replace read_crN helper with read_cr8
  target/i386: split X86_CHECK_prot into PE and VM86 checks
  target/i386: convert non-grouped, helper-based 2-byte opcodes
  target/i386: convert bit test instructions to new decoder
  target/i386: pull load/writeback out of gen_shiftd_rm_T1
  target/i386: adapt gen_shift_count for SHLD/SHRD
  target/i386: convert SHLD/SHRD to new decoder
  target/i386: convert LZCNT/TZCNT/BSF/BSR/POPCNT to new decoder
  target/i386: convert XADD to new decoder
  target/i386: convert CMPXCHG to new decoder
  target/i386: decode address before going back to translate.c
  target/i386: list instructions still in translate.c
  target/i386: assert that cc_op* and pc_save are preserved
  target/i386: do not check PREFIX_LOCK in old-style decoder
  target/i386: remove gen_ext_tl

 target/i386/cpu.h                    |    9 +-
 target/i386/helper.h                 |    2 +-
 target/i386/tcg/decode-new.h         |   46 +-
 target/i386/tcg/seg_helper.c         |   16 +-
 target/i386/tcg/sysemu/misc_helper.c |   20 +-
 target/i386/tcg/translate.c          | 1089 ++--------------------
 target/i386/tcg/decode-new.c.inc     |  473 +++++++---
 target/i386/tcg/emit.c.inc           | 1290 +++++++++++++++++++-------
 8 files changed, 1417 insertions(+), 1528 deletions(-)

-- 
2.45.1


