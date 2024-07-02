Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371D8C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjzJ-0004QO-7V; Tue, 02 Jul 2024 16:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzE-0004BS-N4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjz4-0001Yc-Ja
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C7ChEDGI2fc0o0DZcqX9FIMiPGbOKd/BvwKVobPrMIk=;
 b=fr+j02YjsyVEFQYqH8M1vObADgVzUp5VpdeaIbMBPSmrpwYshpUf0sMzyulvt59ftuMHWY
 GWDvcGg+qwRygEzVcRmB/CkWFGGcIXZarqkZxXm8YsClcKW8f2o4hS3puF8SRSKfBCid63
 ZNEF1yPIeFTXy9CIjSujMECQ8EXNYE0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-y-RfN4jBO2ezDm7oGVsZ2A-1; Tue, 02 Jul 2024 16:20:12 -0400
X-MC-Unique: y-RfN4jBO2ezDm7oGVsZ2A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52d174e26baso6284978e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951603; x=1720556403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7ChEDGI2fc0o0DZcqX9FIMiPGbOKd/BvwKVobPrMIk=;
 b=KejnR7q3GEoU1e0pvM1TZEBbPH1MV2mFwG/YtX9biEISUwwfIDd42gP+Wjunn/pvWN
 Ro2BOc8VeElIhazOvQhEa2EIjPGnIGlm5RENGhnbexF9BCMK3adD3Vc1/7a7fzWBfyrR
 3Vt1UdBcoOCN4H6BpPevAa0nIP5UIamFCyf/BqHnkyR7MhTG4w8nbrmqhCfzZeFgqEZy
 TXfg2k40JgajG1FmqzaGN1YEZnB7ZeYGXeqBwSsR+rhjbJIlvzYp43Vsbgg+ZlKYxFwg
 x+luIO6myYZDPLCXIRLOxv3N4Nj5ACknmuZ2iQBmDYoSBGkKTAvwGDqS0mbviQKvWYWZ
 mStA==
X-Gm-Message-State: AOJu0YzYpDs2NsXlx2WwhSNeuqEuESnb0FPj9R7brjLrwbwwTAMEPYg8
 zf/4rtUP5EaNXuafXT8aKQS2Jv1ZnXWSSpA3cM+u3eqzSlmy8Zilugu5ZyxS6C2l06NVhd25iLN
 ZtAhGzysH6J7iZod0WqEUhLLge9/l/ZGLgSd2cOjZ58fm6ERp9ePWrkUM8ub2V1qmp81lGXvzAI
 EuFQ2fishTlUsbK0ZQmaTDnhpx5zTfqg==
X-Received: by 2002:a05:6512:114c:b0:52c:de7b:586f with SMTP id
 2adb3069b0e04-52e8273656amr6138771e87.67.1719951602965; 
 Tue, 02 Jul 2024 13:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdUV5CY2MHASeNPKHVgykD23IAQ9cmS73fJ2mkallWbehmypuYIqzZT0pzxQiVNrq+lIAaA==
X-Received: by 2002:a05:6512:114c:b0:52c:de7b:586f with SMTP id
 2adb3069b0e04-52e8273656amr6138743e87.67.1719951602281; 
 Tue, 02 Jul 2024 13:20:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5ba51sm208565135e9.12.2024.07.02.13.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:01 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 72/88] meson.build: Add RISC-V to the edk2-target list
Message-ID: <0f05e4452fd777657df812b3e34e4b7b7106b55b.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Sunil V L <sunilvl@ventanamicro.com>

so that ACPI table test can be supported.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-12-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a947b83c3f..088bbbbbda 100644
--- a/meson.build
+++ b/meson.build
@@ -93,7 +93,7 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
   if target in target_dirs
-- 
MST


