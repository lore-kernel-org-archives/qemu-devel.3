Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9073C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXeb-0005xd-IW; Fri, 24 May 2024 12:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXea-0005x2-Dn
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeT-0006ve-2H
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLcj+G3nZNoagmtde0jJ4iaxwOIbWk0F9rsJ0Ab16Xo=;
 b=QTiGsNhf6Mvw1fsbU/uU/MYLGnrisKc3LZowkoENOi+Qhkc9eAO3IGozneVUW0nXLxjhhi
 ISpXx63kK6Ka50wHoKoSKIdlLQekgQw4zDShzb+o1AEDLwUh/p8NcEuGQyVWZb7MAW0Vk7
 Sv5hp6VOyuyQeYkX69zv/eRANDzzhiI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-NDXRQi9tP6CbhpCv7-8PSg-1; Fri, 24 May 2024 12:20:13 -0400
X-MC-Unique: NDXRQi9tP6CbhpCv7-8PSg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95a655afcso9532791fa.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567611; x=1717172411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLcj+G3nZNoagmtde0jJ4iaxwOIbWk0F9rsJ0Ab16Xo=;
 b=oiEz+isdvhjums6GyQMN4YgWHhc3hrUcjd82+TGX5hGJezvCONWlkPWMV6BoQMPXRs
 UnNAH4zpIsDRm/kOWDlU/QEtmaeQQ8BslTKEVxb0KYqVsHxnh7q5JnXKrjHTJmIdgAZQ
 mpi4hcIA1OcYpdepbnaJw8xTMwF71lzplelKY8O3f1tlOEikSV8GrnvclmPY3be2l4Zn
 sNfNugCnnt1sp720OaLHYXNR3jrDaRngxcD4cKxNGh6DDp5a/dstmEjjY/7oEVJb8DxE
 62nh6te6ho1iPLb3IAACGusE6QJ5bt4JgHku+aJ26yElKkUotEO04WsDHBl8E/eMC+lE
 nEig==
X-Gm-Message-State: AOJu0Ywcr1Z+f0NvY4M97dzr+bGQwW7HKQiidt5gFLETnPWso41p207D
 GGm4dU7Jf5bT+sKE994+uV5reCypCR2aVtaIc47fOfWJHfsqseUwjNJwxbCc95VUA+ylfHYq9un
 yeyH1kWbCL5hTPnPbeZktsnVJMVmrk4hkNES+RQc8fA9B64LPmAODnelE7hxb8vqjZXFZYtHHnC
 dW0bi/gBy0d//3qpfJloetJozyi65aXA9pTBY0
X-Received: by 2002:a2e:99c2:0:b0:2df:e0c4:8429 with SMTP id
 38308e7fff4ca-2e95b0c22abmr17972361fa.18.1716567611303; 
 Fri, 24 May 2024 09:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIp+sB78Wq0yxv4KckkYT9zFXSySJ/vu/klLKAh3rH0QUHLdg/OM0+CGPF9EKh8pdoAo3+jQ==
X-Received: by 2002:a2e:99c2:0:b0:2df:e0c4:8429 with SMTP id
 38308e7fff4ca-2e95b0c22abmr17972071fa.18.1716567610726; 
 Fri, 24 May 2024 09:20:10 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95bcd73acsm2539511fa.29.2024.05.24.09.20.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:20:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] meson: remove unnecessary reference to libm
Date: Fri, 24 May 2024 18:20:01 +0200
Message-ID: <20240524162006.1271778-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524162006.1271778-1-pbonzini@redhat.com>
References: <20240524162006.1271778-1-pbonzini@redhat.com>
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

libm is linked into all targets via libqemuutil, no need to specify it
explicitly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/meson.build b/block/meson.build
index e1f03fd773e..8993055c75e 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -110,7 +110,7 @@ foreach m : [
   [blkio, 'blkio', files('blkio.c')],
   [curl, 'curl', files('curl.c')],
   [glusterfs, 'gluster', files('gluster.c')],
-  [libiscsi, 'iscsi', [files('iscsi.c'), libm]],
+  [libiscsi, 'iscsi', files('iscsi.c')],
   [libnfs, 'nfs', files('nfs.c')],
   [libssh, 'ssh', files('ssh.c')],
   [rbd, 'rbd', files('rbd.c')],
-- 
2.45.1


