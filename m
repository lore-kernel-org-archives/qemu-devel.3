Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFB606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ju0RhrAG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rpbw2cx8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7EY-00050Y-Ph; Wed, 28 Oct 2026 13:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EJ-0004tm-OV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EH-0003Sm-6D
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=022mPMPfbSJttDfJNNbT0vkSspt8HAahvqLWCA8uwCM=;
 b=Ju0RhrAGe1NkJoxd8Maz/SvpbJhR1YzL5ak8eo9cou8w+19QpcjSJRPI4Pevnv6fCWkX1G
 QE5P2kJHYBwGlyJ2xvvuN4QppbFEnFQYyAqCeZTgIpGfmMV79h0a/5Bb2CuQ77/hZtd89K
 0if+8suJKV0KfIw0ueGw4ZVprviJspI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-7OHQ2dJjNCqROGK_KgRKjw-1; Wed, 28 Oct 2026 13:14:22 -0400
X-MC-Unique: 7OHQ2dJjNCqROGK_KgRKjw-1
X-Mimecast-MFC-AGG-ID: 7OHQ2dJjNCqROGK_KgRKjw_1793207660
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b027578a4so951834f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207660; x=1793812460; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=022mPMPfbSJttDfJNNbT0vkSspt8HAahvqLWCA8uwCM=;
 b=rpbw2cx8fJ8C1q3niGvvNrJuPgIJpExclqsPs+LZ9Lpfx0WE8JPTgoBOAI4giL1VMb
 d+ZMLVfZYwmlKNCnC2Kxx83/TVdhiwXQFpVQGzBSSHW+w29YFbebsNBS1PlX+U916CvP
 blADwoajmxFMyxcbwziXOT7j0/hSElPno7vXTCiZurcuIQ1+MtuRafsax+5vDMHsRhR5
 mkXEkcjAXUDmOlzm3IU5LSlaH+yVRa60UCVEv0NHIFOcjehmY/U+iWXnZATRqenLhdy1
 DePfKLu6C5STTbkNQX0fss+5A/TWlEftur8P1NxhDy6w860J1rjIqyJvGnVReL9ItegN
 ZquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207660; x=1793812460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=022mPMPfbSJttDfJNNbT0vkSspt8HAahvqLWCA8uwCM=;
 b=WYyd7IizQbUXhaR/2vaardE1jsUVOi6FhkrgVaK3M1P2znqv7R3PA+YVZgZHvB/wIK
 WFC2lLYZdidbUAb5OknRh20G8tKhlo3LBNNEEFhp+0KGrpBYRLeXIIkxOeC9YRaSVdwe
 Nm9yrIEh0fy765P4qni9bg0oKe+fwqBwGOS6HaiXBd4Ei35uQi1RLKKS2YRVJyGm82xp
 uO0TJTYKlI7HL1xjSenxB+kdrjuUNVPHXI9w5l+hDI2a81yP9pojMb72pvBwgj9Wal1p
 NickxcGT+OSXji+3RC0Oq339nQ6CUuR/iMrazXAUM3ECNoYJXlE+Q6eOw4UlUYOPIto6
 WzPg==
X-Gm-Message-State: AFq9FYKxQ+AftQfWIfZ+JEX8h0Ts2YCVdZLe1UIRxLAH/IYZ69MXqPIP
 bf5joHpzzjoFXxNJ07jM7lDQWqjEJ4qPGhWRwr4zBXZYcZ6g6+i2+xPvxU81lc5HCGy/uY6Snlm
 vqyZuKbhWoxhsJTss3Gr7N4pp9MPQPjBzGXqRJUcU+u6RUEGV2iEAqD7pbYZXmE5VRu6IYjjwZm
 DBmrbEBHjsscoY/nnYDqmN0WMRI3eP7vAUcg==
X-Gm-Gg: AYBFou0vALc9FG52vWKrK7JaVctltrFWUOo4ek/E8pB7v6vK6z9YbrWYVKN2sGZhUdf
 MpZxypbySyR7jkwYsk9jXi587rt9JAtYy9HZURzFsVuED7ds0zKoscHHlPV6mSRcwTnX30n6ijw
 39kGeULcTC4PV1dVEeghqe/rZ19aPdwSEQE1YQJmYcs4/oR4nfKfarIMiS21d9qiqSl52jn4nUl
 2NEYccU6CN++wWY6bSZmb43p9XUuWG4svBo9ewni1gWSeV8zHZQ/wtPV805kOVdlTOiaI9gXWvN
 9zxTv1nXxNRIccRiRqOymg4M4tOlYzIcSmJzW/6n+GoV3ZcxkIwYU8LayO5vj1XC3CwxN1oISCX
 weqDmN8LHFDKLCO2IADvOWpV9zS7ZCCtXS0574TF2
X-Received: by 2002:a05:600c:1d1a:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4a966c4111amr65053375e9.17.1793207659515; 
 Wed, 28 Oct 2026 10:14:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1a:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4a966c4111amr65052275e9.17.1793207658837; 
 Wed, 28 Oct 2026 10:14:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e4be4b2sm38904815e9.2.2026.10.28.10.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:18 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/78] Revert 9696846600ca ("multiboot: Prevent loading of
 x86_64 images")
Message-ID: <9c590ba3ee4002b6911cc9c88bf58240529a4287.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

Loading x86_64 images in multiboot was disabled on the ground that since
multiboot actually boots 64bit kernels in 32bit mode, the binary would
have to be 32bit.

https://lists.gnu.org/archive/html/qemu-devel/2010-08/msg00913.html

But making the binary 32bit makes using debugging tools such as gdb
unnecessarily complex since they don't understand what architecture the
kernel actually is.  Letting qemu load x86_64 images and boot them in 32bit
mode is completely fine, works, and is what the multiboot standard actually
expects.

This notably fixes loading gnumach in x86_64 mode.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260829175047.2710519-1-samuel.thibault@ens-lyon.org>
---
 hw/i386/multiboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index d544b62afb..004d5185fb 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -196,11 +196,6 @@ int load_multiboot(X86MachineState *x86ms,
         int kernel_size;
         fclose(f);
 
-        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
-            error_report("Cannot load x86-64 image, give a 32bit one.");
-            exit(1);
-        }
-
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
                                &elf_low, &elf_high, NULL,
                                ELFDATA2LSB, I386_ELF_MACHINE, 0, 0);
-- 
MST


