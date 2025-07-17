Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09838C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTlv-0004Sm-F1; Thu, 17 Jul 2025 14:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8b-0002tU-UJ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8X-0002F4-D0
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3Lm68o9Wr9o652txBCwt/ZL0omPMYt4O8DFykRcXrP4=;
 b=M4ffjtc7MGcPqAZSqVgnXyy5H6+mmTGZvY/ZYWEmuC3MlmKjQIPLmUI0MrW70WiKu3kvj1
 EuZWpTcbrrZrko6FffAjizI6PuYGczLZdAHOnbzKlfUd/I55zUNaUtLpPLVeliPxlfOs3T
 DpUsIWbU8K26FCMG96MvELfTS59ZGlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-O5a21o_QMkKvmCGM5koY8A-1; Thu, 17 Jul 2025 12:07:04 -0400
X-MC-Unique: O5a21o_QMkKvmCGM5koY8A-1
X-Mimecast-MFC-AGG-ID: O5a21o_QMkKvmCGM5koY8A_1752768423
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-456106b7c4aso10035405e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768423; x=1753373223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Lm68o9Wr9o652txBCwt/ZL0omPMYt4O8DFykRcXrP4=;
 b=NYcn0+MVEC67vwVh12er2JY3asnWigPC7aAvW57dBY+2JoP70gHFEmSQ1vA/M37mtC
 3yq5jVoNxmZuWg7Ibp1c0meN9ME2JQBZSvNGvGrt10zV7iOulb3cjy1R9QZQK4PHPT7d
 agkJWLjLLWViNkwYlrbkF2ifZWD4vLERx6LoefLRq/ca0OBrM3r3ZDG9XgorNcDc2M0o
 /NYg1H+amv+FQODUVAeF6eoDBcIiUXmIGVZZ8ZT/FG9cDzZmndbZdKE7+tK+BnUVRmF1
 Ywt75MwJG2OLyji7pFU01kM3qkN7DrskmXYZPermB+jwY0/4r1qLiROq1gJ0h8caCKa9
 wPFA==
X-Gm-Message-State: AOJu0YyIWdJ4mmVtnEuZqbYDSLPkRgpN/tCccUtSF9tX9bRNFgmyzCeb
 Q7cKcu1Tlt6fPVuM/eHKT+7GORE3xuqHTWlH02wcexJhKneGRf/6sCo+DWGTNdo5OEfjuLg8SzH
 ewyyvn7zZh4hSM/uzj3he49EHY7yob9UdUuIo1CrzD10K7tokZFV713JRURwrkf0EP5seVRDS5x
 zYI3EWsAANo4gouJZ65F4Bznoc8N8HImOq4Mv5f0Oe
X-Gm-Gg: ASbGncu5mzgUAH8AjhKGnCXxQMpE+aa+WMXQg8dONOOzzK/tKUPN2bSl4jD8XQ5MFsr
 BBD4JoYySXcQJTFy48heLOmgPAcKBgfEsuK0W4C3819Eb7U6IovI3S2z95BxPPj/hc6PnKkEM2J
 I4AMqeVKmwXcAvs/TwSCdq7ar6Zs8JacYOOK43jBWDpjd+hyTs51UzgbBzkwudoSdVSA+0Y4Ryl
 TIekB4Omc5McHMwDhXenrpgpSAZ5J1aTQJGGS2CndymhyfvwOo+QbHlCMVjA+3P65ucHFmrTAm/
 5pz0smgUJGV30f5N5kvDsQ/HO42zgUHDhdcjQ4sRv7M=
X-Received: by 2002:a05:600c:214b:b0:455:efd7:17dc with SMTP id
 5b1f17b1804b1-4563a5416ebmr3189005e9.11.1752768422377; 
 Thu, 17 Jul 2025 09:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI/DvTbuqbW0p5krFkZSqfHJ50Rn62Om75b1gu1KgDXnHAoIZpvuRsacmqpd2ZiaoMzEaG2w==
X-Received: by 2002:a05:600c:214b:b0:455:efd7:17dc with SMTP id
 5b1f17b1804b1-4563a5416ebmr3188315e9.11.1752768421688; 
 Thu, 17 Jul 2025 09:07:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e89c87esm54596725e9.33.2025.07.17.09.07.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Mostly target/i386 patches for QEMU 10.1 hard freeze
Date: Thu, 17 Jul 2025 18:06:54 +0200
Message-ID: <20250717160700.357384-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit f96b157ebb93f94cd56ebbc99bc20982b8fd86ef:

  Merge tag 'accel-20250715' of https://github.com/philmd/qemu into staging (2025-07-16 07:13:40 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f64832033d1262983bfe759669b4f65080f760dc:

  i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock) (2025-07-17 17:18:59 +0200)

----------------------------------------------------------------
* target/i386: bugfixes
* regenerate meson-buildoptions.sh

----------------------------------------------------------------
Paolo Bonzini (2):
      target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
      target/i386: tdx: fix locking for interrupt injection

Stefano Garzarella (1):
      meson: re-generate scripts/meson-buildoptions.sh to fix IGVM entry

Xiaoyao Li (2):
      i386/cpu: Cleanup host_cpu_max_instance_init()
      i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock)

Zhao Liu (1):
      i386/cpu: Move x86_ext_save_areas[] initialization to .instance_init

 target/i386/host-cpu.h        |  1 -
 target/i386/cpu.c             | 22 +++++++++++++++-------
 target/i386/kvm/kvm.c         |  6 +++++-
 target/i386/kvm/tdx.c         | 12 +++++++-----
 scripts/meson-buildoptions.sh |  2 +-
 5 files changed, 28 insertions(+), 15 deletions(-)
-- 
2.50.1


