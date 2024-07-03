Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA87C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxkD-0000pe-VA; Wed, 03 Jul 2024 07:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxkA-0000m6-4Q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxk7-0003QD-5u
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720004499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LYRDkR2J7HRVjDSzemvFU/uL4+bPk+60DL6asvn/Ekg=;
 b=acpT/jknNYDCtY1mXfGlfA7obGAhY1Ja9xX6fHhEJn7eIChXpsVBOH0kpBng1/WR5jC729
 9+097Pc3f8nBbhAKCi/UD9m8lnsoa66uvlSCAls8ksM4zwmJGIyFJ9OpX7tdfEkwMehTG+
 fs/j742CtMUY3IdPypwyqtgNgQJoCxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-cXrtsuaDNWWWXQS5TJV7Lg-1; Wed, 03 Jul 2024 07:01:38 -0400
X-MC-Unique: cXrtsuaDNWWWXQS5TJV7Lg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4257f95fe85so23726195e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 04:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720004496; x=1720609296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYRDkR2J7HRVjDSzemvFU/uL4+bPk+60DL6asvn/Ekg=;
 b=TZ37LkFDZ8SFDzZeAvVclx4+Be++GvUc42GmaxzHsQHmteSEgcnofI1vXdx0TdGoDd
 2Jh1Vou2UFywqrFbJC/jDQ3UxYM5IzQwT62lU/bxXBx9hdroM/elLD4LiNrWjTi34KxE
 VpS9vDTYGG+sZF9ezCrMhOiJ6ys7khubeePKhgV0yRn+3tF4MQSI7vH3CxjVOQKj8byM
 gZR5Vmslcz++b4SPn1/+TU7j/nKysV59uWLqAAyMJ9SQo2lvVZQRETsnSs5JLDmIUzC+
 2FhhNOeAXOa4ozQVJf0RBw90eWQuJKWGRK5k2RQ/g7wo7N0dbHBJeaMwxAyGFjdNXR7D
 4sNQ==
X-Gm-Message-State: AOJu0YwFqp9bJt0TXJc1hqori3j9fwwZtJKiEJWUXhPm+SJpLJ8g2gqi
 UNNYlGgIgEmx1ckLBmVSCMgS35nK/Ws8tN+Vzpc1s+PoKqfH2LPOPImB6i9a3sTDSghQYGs8jS2
 auqd6W4zLD/6IX39Q/I4/uHuRC4H4thQblxyWv4VagnWWZquOu4xb5b5Yl3GdssfeBrC/m6Fvpn
 ZR6tAYhh52Pqg5+R/tcFKO8H5U1fD1nGFzSwc9
X-Received: by 2002:a5d:540f:0:b0:362:5a6e:2649 with SMTP id
 ffacd0b85a97d-3677571b850mr6502645f8f.56.1720004496266; 
 Wed, 03 Jul 2024 04:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgY0YEoQhlGGy7Mha0BH1XDdJi7jCXo0d8mmbw29XGCzjy8rNkeuyNDaukZP+/rqJ9fEc3xA==
X-Received: by 2002:a5d:540f:0:b0:362:5a6e:2649 with SMTP id
 ffacd0b85a97d-3677571b850mr6502623f8f.56.1720004495791; 
 Wed, 03 Jul 2024 04:01:35 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6b4sm15508153f8f.17.2024.07.03.04.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 04:01:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	zixchen@redhat.com
Subject: [RFC PATCH 0/2] target/i386: SEV: allow running SNP guests with "-cpu
 host"
Date: Wed,  3 Jul 2024 13:01:32 +0200
Message-ID: <20240703110134.1645979-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some CPUID features may be provided by KVM for some guests, independent of
processor support, for example TSC deadline or TSC adjust.  They are not going
to be present in named models unless the vendor implements them in hardware,
but they will be present in "-cpu host".

If these bits are not supported by the confidential computing firmware,
however, the guest will fail to start, and indeed this is a problem when
you run SNP guests with "-cpu host".  This series fixes the issue.

However, I am marking this as RFC because it's not future proof.
If in the future AMD processors do provide any of these bits, this is
going to break (tsc_deadline and tsc_adjust are the most likely one).
Including the bits if they are present in host CPUID is not super safe
either, since the firmware might not be updated to follow suit.

Michael, any ideas?  Is there a way for the host to retrieve the supported
CPUID bits for SEV-SNP guests?

One possibility is to set up a fake guest---either in QEMU or when KVM
starts---to do a LAUNCH_UPDATE for the CPUID page, but even that is not
perfect.  For example, I got

 > function 0x7, index: 0x0 provided: edx: 0xbc000010, expected: edx: 0x00000000

even though the FSRM bit (0x10) is supported.  That might be just a
firmware bug however.

Paolo

Based-on: <20240627140628.1025317-1-pbonzini@redhat.com>

Paolo Bonzini (4):
  target/i386: add support for masking CPUID features in confidential
    guests
  target/i386/SEV: implement mask_cpuid_features

 target/i386/confidential-guest.h | 24 ++++++++++++++++++++++++
 target/i386/cpu.c                |  9 +++++++++
 target/i386/cpu.h                |  4 ++++
 target/i386/kvm/kvm.c            |  5 +++++
 target/i386/sev.c                | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+)

-- 
2.45.2


