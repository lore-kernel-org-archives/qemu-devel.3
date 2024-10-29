Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DF0D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0G-0005iA-LV; Tue, 29 Oct 2024 11:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5nzw-0005Uc-Uo
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5nzu-0000O5-Hb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nbGaDxsN8JVqYYUrFuzXXRBZoXXEIQCVrTue5vBaCdU=;
 b=Uo+onVBPJnZQchjI/5J0wk1M+0/JKj/B3HWdDwX585gy9ybdXXNNbBSeTw9eJiF9cOX60Q
 JMeJvtI5jDJaZu495DBDmynnOfSdI2rCl2udn+H4PpwOcGJgNwgP8ncWreFIOVI/1j7Y4V
 TEqWXKFO97K9r5YuGU1rA8AwXozYvl0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-HMh66XoaPoq8jGI4MqUBtg-1; Tue, 29 Oct 2024 11:19:03 -0400
X-MC-Unique: HMh66XoaPoq8jGI4MqUBtg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4cf04be1so2634876f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215140; x=1730819940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nbGaDxsN8JVqYYUrFuzXXRBZoXXEIQCVrTue5vBaCdU=;
 b=N2oVfW1b93QTB6wwGh47hpEsQ8hhvxuT1x4VpOF5E153FAkZO+rIl4MeYuV+YzldSt
 YRt4z0sf/8SUnEYfQw64EeToE4p0UcGoLuH7L88zEiF9Z0kNlXd9djSnjkvMmC/3j0rx
 XhvUxNYc5z6yj0p4EqTsEy6cuRGgh4L9GDQuRUXjwlMrTEipHVztkfEAnKWBVhIvuHew
 xaecCYqqlBocgvBibbbfTOyflXsoSV/khJQaAcfE93/x4Xwhco2S6UaTtUMs72MhYHOI
 OhiU6ZIWoGYapTigIjJXakyWQE+ccAhZimdvegJ6TyciTx8sjLqNQ68fqatejcFUG0wy
 3yJg==
X-Gm-Message-State: AOJu0YxCS6VNZjPDlHcdJF6f0lk5m+gSX2h5ie2NqsDRDh4OAc0n5f5U
 t527T+I6Fj4v4y2lBCfjWkmjfSDos0Or03KiEkSHNmnk3vqKsiNfYJPXdk9IUrdtmMr9cedA95Z
 xr2c/EnfUu6foZfkdLrbYDbNYzhnEHFQwK59jQaMpveSxORAR/MCYsq6xWaz7kBzSMXqgNwii1B
 XUuTAVww36x6JjzlRAFmHC0uFwFHlXkutG9HDNlp8=
X-Received: by 2002:a5d:5d85:0:b0:37d:498a:a237 with SMTP id
 ffacd0b85a97d-38061c9a26emr7507644f8f.8.1730215140334; 
 Tue, 29 Oct 2024 08:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfmb68nwi3DbYTpNhyyVjUt12p3+oko5P9JzFDUdDIpgDkQGtSDdO0hjdPjY/mo1bvENK62g==
X-Received: by 2002:a5d:5d85:0:b0:37d:498a:a237 with SMTP id
 ffacd0b85a97d-38061c9a26emr7507630f8f.8.1730215139925; 
 Tue, 29 Oct 2024 08:18:59 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47f59sm12811231f8f.54.2024.10.29.08.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:18:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com,
	zhao1.liu@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH v2 0/8] Add AVX10.1 CPUID support and GraniteRapids-v2 model
Date: Tue, 29 Oct 2024 16:18:50 +0100
Message-ID: <20241029151858.550269-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Most of the patches here are from Tao Su's v1.  The main issue in his
version were two:

- overlooking kvm_cpu_xsave_init(), which currently looks at ExtSaveArea.
  This would get a bit ugly for extended save states that are enabled
  by both AVX512 and AVX10.  Patches 1-2 change kvm_cpu_xsave_init()
  to look at ExtSaveArea's size field instead of testing features.

- downgrading silently to KVM reported value if the avx10_version property
  is >= kvm reported value.  Xiaoyao Li suggested basing this on
  cpu->check_cpuid and cpu->enforce_cpuid.  Also, the check must accept
  any accelerator and not just KVM.  I moved the check to
  x86_cpu_filter_features in patch 4.

I don't have a Granite Rapids machine, so please test! :)

Paolo

Paolo Bonzini (3):
  target/i386: cpu: set correct supported XCR0 features for TCG
  target/i386: do not rely on ExtSaveArea for accelerator-supported XCR0 bits
  target/i386: return bool from x86_cpu_filter_features

Tao Su (5):
  target/i386: add AVX10 feature and AVX10 version property
  target/i386: add CPUID.24 features for AVX10
  target/i386: Add feature dependencies for AVX10
  target/i386: Add AVX512 state when AVX10 is supported
  target/i386: Introduce GraniteRapids-v2 model

 target/i386/cpu.h         |  16 ++++
 target/i386/cpu.c         | 175 ++++++++++++++++++++++++++++++++++----
 target/i386/kvm/kvm-cpu.c |   8 --
 target/i386/kvm/kvm.c     |   3 +-
 4 files changed, 175 insertions(+), 27 deletions(-)

-- 
2.47.0


