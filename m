Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6A4D49222
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD21z-0000I2-2C; Mon, 18 Nov 2024 08:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD21x-0000Hc-9j
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD21v-0005RM-IM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731937382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J+O+V5fvVJqmnCMnnFyl71XPLYjvhBGc185goM7pokY=;
 b=hgAi1oKgnHxm4X7s3Svt1ADKe0DrWAe4uEtn5mNUxlYLN4T0Rmjo2NdvpnBc34AmwIGyUZ
 FjyAJUDvzWecv7vq0kktKmKpRufq0x1LnIomfJvYPCInJ4c3G5CoFRWtSF9lZNUNJIz2f6
 zlYSCmC0Os21SqD8i4lTVwUQ8Mqgkj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-zxVLc4ItOQ-Dkm7K9HIWvg-1; Mon, 18 Nov 2024 08:42:58 -0500
X-MC-Unique: zxVLc4ItOQ-Dkm7K9HIWvg-1
X-Mimecast-MFC-AGG-ID: zxVLc4ItOQ-Dkm7K9HIWvg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so30108265e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731937376; x=1732542176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+O+V5fvVJqmnCMnnFyl71XPLYjvhBGc185goM7pokY=;
 b=lsQL5sdpDkFj9RBY5riWRrTIyYMW9dZjMMxV6li9uhNPD4qxMeLAz+jOLR2x2dxCYf
 TZimCmnC6wBqqpbEv/hQIsOo5SSBSZn7P3bjuU9jsxSdJI8V4MmgodwD1CktO4WQ1WUU
 S+gUUzDVGsOjf8CZgBygw448YFqUJbXC5uicQwK6dS+WOlY5e2G9iA94eGzQB9+KQNsn
 GxjoSYdri3lq3ZkM+o6TNgQTGPOF/IH44g8O0uPsMD3Wk4a7gh6GWc/u5CMsAtUS/djs
 sA2FqhiNVyHC0kX93I3527oXS0FdfofYpvVsy8qlVfyvRTiKgd0wbELmv8/2z5bG1hFu
 W/yg==
X-Gm-Message-State: AOJu0YzxchoWGq4XvyM+N4YtgMdpN/aZ1vAf+Ii8W1/J4uBcd7FODPTh
 /IQVDzr7gAUMTXRsgZU/DQVLmQT11hcAOPDbUSou2rD8ZVe7FTZ5Gey2AuyDoHhkomzxrCgu1IA
 spuoeKMe450Xfbxb+AtaV708Xg543rXgqYk5/ixdX/qRD/PyRrhtw9E/NPRmoUAeQyjjINRERmv
 GDw+YZv47dmGU8CeH8NPzi2C/DXttdXhGm/88k
X-Received: by 2002:a05:600c:4f93:b0:42f:80f4:ab31 with SMTP id
 5b1f17b1804b1-432df74cecbmr100824105e9.18.1731937376652; 
 Mon, 18 Nov 2024 05:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHthn+GDxnr93i3ypT6mwha4+PH5Tg0LkGcHpT4uEn0kHpqTDY8U640mMr/CqSwj+1Omyy9kg==
X-Received: by 2002:a05:600c:4f93:b0:42f:80f4:ab31 with SMTP id
 5b1f17b1804b1-432df74cecbmr100823235e9.18.1731937374596; 
 Mon, 18 Nov 2024 05:42:54 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab72085sm160363965e9.3.2024.11.18.05.42.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 05:42:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] two tiny patches for the next QEMU 9.2 rc
Date: Mon, 18 Nov 2024 14:42:51 +0100
Message-ID: <20241118134253.2071319-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f0cfd067867668870931c9411d96cd518564b7a8:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-09 12:34:01 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ebcf886d88e0fcae322d063b28846d20b23b5321:

  configure: Use -ef to compare paths (2024-11-18 13:44:54 +0100)

----------------------------------------------------------------
* target/i386: fix compilation without CONFIG_HYPERV
* configure: improve check for execution in the source directory

----------------------------------------------------------------
Akihiko Odaki (1):
      configure: Use -ef to compare paths

Paolo Bonzini (1):
      target/i386: hyperv: add stub for hyperv_syndbg_query_options

 configure                     | 2 +-
 target/i386/kvm/hyperv-stub.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
-- 
2.47.0


