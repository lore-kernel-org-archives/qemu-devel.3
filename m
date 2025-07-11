Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F6C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 00:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua1IF-0006Uu-Uq; Thu, 10 Jul 2025 20:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1ID-0006T4-ET
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1IA-0007bZ-PM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752192425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y6Qyvu3FrjUZ8xrx2m3kEz++Ce4vpi3v1pyEwDcNrq4=;
 b=dBfS5ba84OJXPhpRA6wu2GU++kV4kZI6vBRn2VILgvIbWb0aOa+0LGIZ5ezWJNtl2jz2wv
 sRDpVh4+PxoXSUOIJ7acNkr6APZXUoVlWGmCUS1gK3llb1wPJh4MoRkRMr6fYmP9Pts6R8
 uKP8BZ/a7gJUKMhJPTQOcTd2ZeLkRM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-DkRaJXblMRWzu7MJiV8lCw-1; Thu, 10 Jul 2025 20:06:13 -0400
X-MC-Unique: DkRaJXblMRWzu7MJiV8lCw-1
X-Mimecast-MFC-AGG-ID: DkRaJXblMRWzu7MJiV8lCw_1752192372
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so11062735e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 17:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752192370; x=1752797170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6Qyvu3FrjUZ8xrx2m3kEz++Ce4vpi3v1pyEwDcNrq4=;
 b=PmrBvpK12DUhVKKp4K59FowhtUBIdjiOKFs4Ihw9OXPVYc4iwNVCWu4DWvmSjvbREI
 stTeeDMLoPSYOB5UVgOYPvKhk/I/4zJeR6D9fW16zwFh1fOGH6MAjYaJByvaXLSTKypJ
 YYldz35BNvQEnsItUFBv2s2TE5LZ+/xxES8f2fh4JZO3TAHJRYGRdNf2hSCw4dWojpCz
 3Syf9hg/b6p0Fk5QhDZtYJMqHlbwLft5zrtjGGSRNV97OGCIEVzIZG1FGa7CBEb81hkU
 vKTyLq6Oaea8Y+DP3buQZRg/RYdEJWfFwBdBTh+kAjG2yDuidUBYT6KlG6/H7nXDRDWQ
 9pPw==
X-Gm-Message-State: AOJu0YzuBpE2KqX5mdy6c4OKjSHZjZuk3HKgKQPfr2sqQnd7YBzUgUaU
 rBEQxd0yjKIFa4VurVqjMJ7nO264kl/bfvkebAPcVGbpK3kucCvvxWObGL9jdMYtAL2chpj7aMJ
 4e1POAfo853KvV8ThN+A78XWd8VzxQF1zBqp2Sc6D6RqAJQxwX14yiYByA85oLzkQlldl94ebga
 Y0/8LRdb/4pPrtanOBjgY4O1yu99fHKwtfzHn+KDuR
X-Gm-Gg: ASbGnctkYx1bIdxudM+yhYfhcsCruoRvLDq1drL7BEQ87RIjATtkiMVzQEpqo4/KEyD
 GVpPwyupqXgzce4BgnCFiZze9J0iN16r1Y+XHjPXRXzEjQMtT1fgWd5h8EIjscgFizObNdr4TQq
 X3dStUwoAz2wpfiS1Rcf5m+YU89HWqyQmRasTUDzmPllwPaHsCEB/LeC3S7Bg2SSY/tMzMUip1U
 5cIw+H9L1MTrVSnDUymnvn3w2P54S1ZzFc4fT13sHAcz3tNJHpp7NRX8pWgtlDtbXFsx1MoM87/
 I/mZ/mkPXAL+R/V4XZBtZilbLjhDDXR5gZuv1eyEGvID
X-Received: by 2002:a05:600c:474c:b0:453:6146:1182 with SMTP id
 5b1f17b1804b1-454f426be92mr5118065e9.32.1752192369879; 
 Thu, 10 Jul 2025 17:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENqeqI/+plbL/q+mEjEFmK2oBWf+H12M6kiaNUSCsdK61RwTgURs5ilHSZHilc2iqKgRrikg==
X-Received: by 2002:a05:600c:474c:b0:453:6146:1182 with SMTP id
 5b1f17b1804b1-454f426be92mr5117885e9.32.1752192369461; 
 Thu, 10 Jul 2025 17:06:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537cd9sm32333195e9.26.2025.07.10.17.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 17:06:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 0/4] target/i386: fix position of accel_cpu_instance_init
Date: Fri, 11 Jul 2025 02:05:59 +0200
Message-ID: <20250711000603.438312-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With the reordering of instance_post_init callbacks that is new in 10.1
accel_cpu_instance_init must execute in .instance_init as is already
the case for RISC-V.  Otherwise, for example, setting the vendor
property is broken when using KVM or Hypervisor.framework.

Adjust x86 code to allow this movement, and perform it in patch 4.

Paolo

Paolo Bonzini (4):
  target/i386: move max_features to class
  target/i386: nvmm, whpx: add accel/CPU class that sets host vendor
  target/i386: allow reordering max_x86_cpu_initfn vs accel CPU init
  target/i386: move accel_cpu_instance_init to .instance_init

 target/i386/cpu.h           |  2 +-
 target/i386/cpu.c           | 41 ++++++++++++++++++++++---------------
 target/i386/hvf/hvf-cpu.c   |  3 ++-
 target/i386/kvm/kvm-cpu.c   |  7 +++++--
 target/i386/nvmm/nvmm-all.c | 23 +++++++++++++++++++++
 target/i386/whpx/whpx-all.c | 23 +++++++++++++++++++++
 6 files changed, 78 insertions(+), 21 deletions(-)

-- 
2.50.0


