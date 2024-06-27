Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278BAC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMplq-0001xz-EY; Thu, 27 Jun 2024 10:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMplm-0001xo-HM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMpll-0003fv-0c
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719497195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RN13PerZa5guBC8xzoBDY7B4coHs5esmjYRJAP9x94M=;
 b=WMB4082bI4LgmEfXiPROAIrTbUmaBKbGFUwQa6v3IvPRcSoCMVAtq8arH01O93uDtHH7eC
 mwHT+OjNzezNDrH61y7GBZfXS3ulzd5xYqDyFxKXxXylckA/WRQ/MQIeTS0JHCEwN3uHME
 ORbEUIaG2ryRNVLZBKUhJGK4rlZfYV8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-8PyKEjpuPzytAxaS1ZYL8Q-1; Thu, 27 Jun 2024 10:06:34 -0400
X-MC-Unique: 8PyKEjpuPzytAxaS1ZYL8Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a727d1e7e9aso184676166b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719497191; x=1720101991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RN13PerZa5guBC8xzoBDY7B4coHs5esmjYRJAP9x94M=;
 b=owzbaW4bujDtVr0gkCGbGijYkp2e0dZwoJiRGqdpDe9LuoSz5D03FJTdGmNpCEwwhJ
 ZSjQEIShwPN+zQYtj3f7OQz3SNQwbFl802afMfA6AQVhGTWec015lCwJO5YEPU1PjJs2
 GAC3VEsPqZeWMaa+tbnJjXx9TTlQlF0AzF5ju4l6uRCey0uYi8ja4U3iN9qKnbKa8lJP
 BymIN+qki3DWqH7KZ5BgVPbewOnoqzD8wSPER8bzVL9+fWjpYvspJNuNYy1hrF7f/FLg
 nCpJ68HD24zodZ8Z6r1oTJOeUEAR3pVEodMUY1weUICtKeTAK3jc6iBhdkDt7764h/Yi
 7sGg==
X-Gm-Message-State: AOJu0Yw8tYTTCZokdHCe3jTgiOHVK5WNZx8mTR7D69jRWPNk9bqzKgXb
 wJvgHybDGXASIqpiIPj53oFRWw8VZnZrlZfnKAYRewU1v1JUczJDuu+WUGeGr9ctsmZeBYzy8Sg
 QO3vSuGo4t968o6lK0J7wgXUvrorddhri/C0jcBcpidTNVmQjP/615E5MqiNgUCXPyDDd7t/UKu
 G+9ImgUOwfwPJZF1AURZuZKGmMvASWGNB/xVA/
X-Received: by 2002:a17:907:c306:b0:a72:6055:7886 with SMTP id
 a640c23a62f3a-a7260557953mr931639866b.24.1719497191518; 
 Thu, 27 Jun 2024 07:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi+lK2VdJAZfAn23TwjoLEbsjYVdd/XjEblNr0E7WD8Z8OwDGMtyOASOi9Pa4mLM5jTadbeg==
X-Received: by 2002:a17:907:c306:b0:a72:6055:7886 with SMTP id
 a640c23a62f3a-a7260557953mr931629266b.24.1719497190051; 
 Thu, 27 Jun 2024 07:06:30 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d71f6f9sm63082466b.74.2024.06.27.07.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:06:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	John Allen <john.allen@amd.com>
Subject: [PATCH 0/2] target/i386: drop AMD machine check bits from Intel CPUID
Date: Thu, 27 Jun 2024 16:06:26 +0200
Message-ID: <20240627140628.1025317-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid()
causes the bit to be visible when "-cpu host" VMs are started on Intel
processors.

While this should in principle be harmless, it's not tidy and we don't
even know for sure that it doesn't cause any guest OS to take unexpected
paths.  So plumb in a mechanism for x86_cpu_get_supported_feature_word()
to return different values depending on the *guest* CPU vendor (which,
for KVM, is by default the same as the host vendor); and then use it
to hide the SUCCOR bit if the guest has non-AMD vendor.

Paolo Bonzini (2):
  target/i386: pass X86CPU to x86_cpu_get_supported_feature_word
  target/i386: drop AMD machine check bits from Intel CPUID

 target/i386/cpu.h         |  3 +--
 target/i386/cpu.c         | 29 +++++++++++++++++++++--------
 target/i386/kvm/kvm-cpu.c |  2 +-
 3 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.45.2


