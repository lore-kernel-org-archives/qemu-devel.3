Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC6C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEQ-0007DZ-FM; Tue, 02 Jul 2024 10:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDg-00059S-3F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDZ-0000Q0-Tm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C7ChEDGI2fc0o0DZcqX9FIMiPGbOKd/BvwKVobPrMIk=;
 b=A/NDyEprXStz6Xj+7KfrvIbjJVDaUd/LEL87MVLwyqzajS43l8HtQQClE4yWyrWWJ/i/O4
 ZsxRwzAtGo+Ra/sg6qLBqgl0xzjJbluEUCqbnIka3FE2r+Qq6rm+2DaH22NhqCh6RbIP8U
 BkbUlI7KDtKHOk/jsesH7osvYkZsrcc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-gq60ES0vPQmQVI5SgpjDNQ-1; Tue, 02 Jul 2024 10:10:47 -0400
X-MC-Unique: gq60ES0vPQmQVI5SgpjDNQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so103650f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929445; x=1720534245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7ChEDGI2fc0o0DZcqX9FIMiPGbOKd/BvwKVobPrMIk=;
 b=U389ho6xQeFRG0TIqJOsBvpVQoX8cnlbgy4iHe1ssF5oIxdzo+qhbcf1odq6rjo8FX
 CCgStK9VRGK8s/zkHBR43DsUE4U7IFg20IH2jtoi/euobmouB+Eg94APJUelWW2JMmGc
 hzHgQY4cJEjEIFs2fU8ktmYhwVLmNSSSEanmCT8Bugxzn0+peKHPOMDQ3Fh1FXeWxhpK
 ui6d/uebmTXQZscUnpgMJOWSXchPYTCW0+3aUDYEiCqX6pwp6Ki4Qy//wj2+cxLO2p8P
 UDF8oafEVlVcnaOI5JM8n0sNGjA/ELohFdxS+MyJrUQYEs1ec/xgaA7DA1pyXHto4Zzx
 WySw==
X-Gm-Message-State: AOJu0YyOjIvmvk5mA8LelVgbP2m8n2STvy7VtG+z0lOYjlmynpkTCj3J
 IapZKZsk2ue7pzotqiytX75npx2Al0OkVoQyE8RUqq8pdrlIbpG7xUutMAV+iWHiOLVnppmlZDH
 zWtPoiOhUl/RzaeCEp+tfHmtmYWTjKb9ynZc/qkwUsXhHTnxr8cBW6B6vdhzukDt/ql3QJfm4rO
 3Hd3kxa10aGlaUimFAHUvd7KlGTSSJRA==
X-Received: by 2002:a5d:4812:0:b0:366:ddb6:a067 with SMTP id
 ffacd0b85a97d-367756a92efmr7205222f8f.20.1719929445570; 
 Tue, 02 Jul 2024 07:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJgb1h070XrEeVmERupzPswNXBOUduypkqnnBbiTK8B/BYWHqNXMldhoz+w4ManCdadLXgyw==
X-Received: by 2002:a5d:4812:0:b0:366:ddb6:a067 with SMTP id
 ffacd0b85a97d-367756a92efmr7205183f8f.20.1719929445058; 
 Tue, 02 Jul 2024 07:10:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0ce6c9sm13498899f8f.22.2024.07.02.07.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:44 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:42 -0400
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
Subject: [PULL 72/91] meson.build: Add RISC-V to the edk2-target list
Message-ID: <59652fd06ed7775b68c771aee5a15c6b28c952d0.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


