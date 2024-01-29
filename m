Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2DDC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURpz-0002M7-NB; Mon, 29 Jan 2024 08:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpt-0002EL-DH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpp-0000l4-J0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sK8lgGOArqs1MdylFvVbKrtVB+hwZiuBtX66j3iv/fg=;
 b=cMydtFumAOHjyANGHvW3yxtliOU5XjC242fykUWz3hrOpiH5tN7kZMlnVkPvrP44wexKZ6
 lViSSYIRskEHCiuNrhMc0AP5a1IQSVcQ4qQ1u3aU+aHqw/bidBJONsVNdPmX7lFMoH1Fi4
 9ZaanlA5sYs/pc7g3MVjVnie14knhH0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-9bOUN4gkPLGQCj4vq_-TfQ-1; Mon, 29 Jan 2024 08:37:56 -0500
X-MC-Unique: 9bOUN4gkPLGQCj4vq_-TfQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2f71c9f5d2so155754166b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535473; x=1707140273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sK8lgGOArqs1MdylFvVbKrtVB+hwZiuBtX66j3iv/fg=;
 b=g/p8n6axk769TjJn3eGlzEfQbYrQfH6OO1ISzTiHdcI06jCx+fU8bhsgdRU+c1iqhw
 sEg7bDyVqElGwjWppcBFMWxrKVpte2NNk9qb6GwXD18QQMAg6sQgOfTFwR2jOE7os7+a
 K7gS3iT+L6DYK1ibhTikcc3ZkNHEcNOB6kPGCG7xYJlTEXVhrJ28NnjaDA6383v49nSC
 T9nThEMhHq53UV101RtFG1OxIs9w1f9z0yM80k+E6bjqoLFoL1/1XZfEN1vkD/vDl4sB
 p2HBEVTtn5emMudWDQaSvib1g3hCyfOf3aZCpXh2lxQQnNFohQKs4E3jFQsZDrc64+/k
 z0Og==
X-Gm-Message-State: AOJu0YwcLVQD7yGxI/R2WcN1+FmVH7ra2hAEHnATml51LbydprcEuB8J
 SJexSD1ame+XDV8t2sucaWoq5Jk3n4H0llDp6gBWao8hSt4qvcGtswjPQH0EDlUPXRyO7RN4Ph+
 LnUp58wjAF/LvGy7V/WZCd04Z4MBmw/dNs30sR6M7gBSMUChw43jKyQdofEEHH84EmCYh034EyY
 Yf/n56Cr2/jRHBLUeAn98S2S9MvhMuB/jS1KRR
X-Received: by 2002:a17:906:fa10:b0:a35:fe4c:e76b with SMTP id
 lo16-20020a170906fa1000b00a35fe4ce76bmr77095ejb.66.1706535473497; 
 Mon, 29 Jan 2024 05:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrXJq3mEGVl1MW1x5Cb3G7ssv2tr82B2ANKyDX+o8xl3DeXHuStbA45nioL1J98dRzkQ6R1A==
X-Received: by 2002:a17:906:fa10:b0:a35:fe4c:e76b with SMTP id
 lo16-20020a170906fa1000b00a35fe4ce76bmr77079ejb.66.1706535472991; 
 Mon, 29 Jan 2024 05:37:52 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 vi4-20020a170907d40400b00a35981e30desm1623346ejc.106.2024.01.29.05.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:37:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 0/4] mips: do not list individual devices from configs/
Date: Mon, 29 Jan 2024 14:37:44 +0100
Message-ID: <20240129133751.1106716-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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

Back when Kconfig was introduced, the individual dependencies for MIPS
boards were never added to hw/mips/Kconfig.  Do it now.

To simplify the task, include a couple cleanups to the SuperIO chip
configuration symbols, as well as a change that makes USB device
creation available even when building without default devices.

Tested by comparing old and new kconfigs; and also by building each of
the boards one by one, with default devices disabled, and checking that
the board can be started.

Paolo

Paolo Bonzini (4):
  isa: clean up Kconfig selections for ISA_SUPERIO
  isa: extract FDC37M81X to a separate file
  usb: inline device creation functions
  mips: do not list individual devices from configs/

 configs/devices/mips-softmmu/common.mak      | 28 +++------------
 configs/devices/mips64el-softmmu/default.mak |  3 --
 include/hw/usb.h                             | 26 ++++++++++++--
 hw/isa/fdc37m81x-superio.c                   | 37 ++++++++++++++++++++
 hw/isa/isa-superio.c                         | 19 ----------
 hw/mips/loongson3_virt.c                     |  5 +--
 hw/usb/bus.c                                 | 23 ------------
 hw/display/Kconfig                           |  2 +-
 hw/isa/Kconfig                               | 18 +++++-----
 hw/isa/meson.build                           |  1 +
 hw/mips/Kconfig                              | 25 ++++++++++---
 11 files changed, 99 insertions(+), 88 deletions(-)
 create mode 100644 hw/isa/fdc37m81x-superio.c

-- 
2.43.0


