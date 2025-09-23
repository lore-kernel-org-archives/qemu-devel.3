Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10T6-0004hx-0X; Tue, 23 Sep 2025 06:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v10T4-0004fi-4I
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v10Sx-0006Bp-7j
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758624103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EuS4ChifMYj038gMyaz4BTDR1ybrqayXJbrc/WNj+Jk=;
 b=Avarz1hgK4EQfP+Bv72IoMxQPrAiRyfSzlAcd66Mq6oy1BcPj2NFzwvMVrhwppErJ52dco
 hRiK86bS3C18OGt3r+ZPZGgrr7zqM8MbDRSzSvrEKFGXRwVVAeAGCHQQl7OSXWqxVtz2zq
 2p5pqKL7Zg6BIE3bflxBVFyuRABw2ac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-9_EfgLI9PWSbNX08hebD4g-1; Tue, 23 Sep 2025 06:41:41 -0400
X-MC-Unique: 9_EfgLI9PWSbNX08hebD4g-1
X-Mimecast-MFC-AGG-ID: 9_EfgLI9PWSbNX08hebD4g_1758624100
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so182544366b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624099; x=1759228899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuS4ChifMYj038gMyaz4BTDR1ybrqayXJbrc/WNj+Jk=;
 b=LJsZiONxIpXF8bhlwCfZFDfYFIexEuPp8EZS1fWzipTacKgktdgmEQ/VDON8yYDTf6
 O6b2BfDf1++bW7H84wIY1RJ1hccn/qGotk3MGScNa/k+mlzBhaDAQvuE6vZOb5EKhRtw
 NQN7cKBV4TQd6ZzpEQ4+X3Jyc3rtCb8QJJ6b5k0AZnEv1yEQuRzXagXxccBHJB8Ht41Z
 1vOto8nyXjMaBZsFiTzdiomdS7utO0XWVGe77UyaLHRwVtI1I+RbN8Eh7C3+XFO9g9X7
 uu16kxqw8+itDHDbOB2G9ZWVig05wFzuBkzIrBNrfPtc2HPpgksNqXmBAK8JW7Zz9cBF
 b0XA==
X-Gm-Message-State: AOJu0YzM+2WtdDd3F8cXIKxzwtJdYtZ/A4bnHDHg3/z7hfcedImaMYZ8
 drEyad7hWYM4WO4sJ5xErIVtakaPfszrCDZ0qcKHR3eQUUWK+oWWqmbZXtFdnmbGc0RcewN8gC/
 g9h8/O2PqY0mY/tqCVXqxTMADwt6cIvMvzyXDg8nJjMd0LNbaXXUZf0vBcKwSSdUF3c/qjhwT3k
 O1MFwcl1XufhmBDSuaP9ULIblJjQcTeeONw/0No0Zq
X-Gm-Gg: ASbGncskznIauJPW51OHuES0mDdr5JnK2ZkqPhcmzNjrWLoP7Ne3ZfH5ie9FfdbaEoB
 DaRWlGfvknuCkRz5hiz+1K3v70+moIt/zVgk7Y10kveqEzfKgzQnhpjfdcNjWZaRd3sVIrh5qo+
 r5N7ltqj9b0ERJl179NM8Z9DDSLA4UnueQjreoJH0zNvQFKFdp6Oefhsj8I80OeoHwoUtHfQR1s
 mDyUFo3Sb/HCZfJZA3vTr9ZpEXcY4NHen8ZrQdnu6ncqJmwpxhSG9Hgo/nl/BtMu/Y1ltbVkwci
 WSg91zHAn6NkS/xWFD7MpWSScfftAhAOjM15JBnn7E3L89Yass+ihFDeqX1MYXENaJl/rViZUUd
 izF38n5wRZbzkWq5aHEToeoNta8mI/1DDjvN204mv11xSlA==
X-Received: by 2002:a17:907:bc97:b0:b30:852e:bea with SMTP id
 a640c23a62f3a-b30852e0e98mr151742366b.63.1758624099137; 
 Tue, 23 Sep 2025 03:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiL4GxfmfhyPk56Tq2slAPN3auI63uy3S1p/YJWWbXtzVjieflVoBb9V0AzpFDH6TH637yYw==
X-Received: by 2002:a17:907:bc97:b0:b30:852e:bea with SMTP id
 a640c23a62f3a-b30852e0e98mr151739766b.63.1758624098650; 
 Tue, 23 Sep 2025 03:41:38 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b26c49ab9c8sm923996666b.47.2025.09.23.03.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 03:41:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: hector.cao@canonical.com,
	lk@c--e.de,
	berrange@redhat.com
Subject: [RFT PATCH v2 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
Date: Tue, 23 Sep 2025 12:41:34 +0200
Message-ID: <20250923104136.133875-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add two compatibility properties to restore legacy behavior of machine types
prior to QEMU 10.1.  Each of them addresses the two changes to CPUID:

- ARCH_CAPABILITIES should not be autoenabled when the CPU model specifies AMD
  as the vendor

- specifying PDCM without PMU now causes an error, instead of being silently
  dropped in cpu_x86_cpuid.

Note, I only tested this lightly.

Paolo

Hector Cao (1):
  target/i386: add compatibility property for pdcm feature

Paolo Bonzini (1):
  target/i386: add compatibility property for arch_capabilities

 target/i386/cpu.h     | 12 ++++++++++++
 hw/i386/pc.c          |  2 ++
 target/i386/cpu.c     | 32 +++++++++++++++++++++++++++++---
 target/i386/kvm/kvm.c |  6 +-----
 4 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.51.0


