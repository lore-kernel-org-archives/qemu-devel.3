Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE721C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjDXs-0003Wf-4U; Wed, 28 Aug 2024 03:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjDXq-0003Up-L2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjDXp-00062o-DP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724831804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kq10LHxOXDbRo88hXcndnj4lAOuankdm6ReuOHRrwqw=;
 b=gQd01o8VMum9wrJzx59wLROJ+0k1Ucy3NRICin7W5iHEEMKpN6BiUsm0k2bO0/mhEWj5Si
 3r26X1PCCZIbyJTjbJcrr9kL8T/y9xwmreQvmhoTMVx5tXzYNZGh/FZURCbOKsiK0PPsHp
 RBDDJuN97c1o7QzCIFioBMgm1n93VRM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-tgCcv6A3NDCNhTLa4IWzYQ-1; Wed, 28 Aug 2024 03:56:39 -0400
X-MC-Unique: tgCcv6A3NDCNhTLa4IWzYQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d699beb77cso3554441a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724831799; x=1725436599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kq10LHxOXDbRo88hXcndnj4lAOuankdm6ReuOHRrwqw=;
 b=pvnUKd4F9epr4nHm/y0ALDMcDL0QkMqKGtxYBL5vJiyhhk8siEq15ZFMN3HQdSooi8
 9xU2rXTSSjVycye8++tS0aRMr1UrRd7LZbumQ9h7vrJGin9fz+13a+6uPkGbRN8fCYKZ
 hudQ98hxEoOkD5IjdgT60ubHjAzuBFLU98DMNyIeE1CggmXPlorEnO7y08u18TMqEUZe
 HSZ3/95XnyYUuu1OZ7puvRA56nBPfEQCE3/xD7FhibpWpGCc5A4j21xqrAGEVgXQ/DSa
 gGv/O2mkb58r9MlZ3WhgZVvKpl9QX15BoKjlOj10FzLY2/QCAmyY797vDG+n0bdZKWfK
 Tduw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVWWGXeshs8jdX2Yc3qGhvK0gI7g/wR1y9F3XejmAvKoCJFpjw22CaA/gPs5VU6icpdKOb2k/GsH44@nongnu.org
X-Gm-Message-State: AOJu0Yz8f72XEkL5ZOqI3tOxniXJ7Nl8/WFTDQ/XbN+YK/dX6FhoZme0
 iihzJfWQ37o7qlA7e4h59fZQFoZXXtF1qaAAujRSHb4OhxGQdAh+ji9ivqRCy8qYSZ4G1lUbZct
 7mLSwINSl/gCGpwEjG6i0naFkAnA3NkQxY5u/ffo8WNCNWrElZp+D
X-Received: by 2002:a17:90a:a40d:b0:2c2:deda:8561 with SMTP id
 98e67ed59e1d1-2d646d8db89mr15714478a91.41.1724831798854; 
 Wed, 28 Aug 2024 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2JrQQJGRZpEtnU+Iuqg2wKgC65zCQObHf+/APfm7PNxJUpyKYxYDP3jmy4R+4M6BaFxzwsQ==
X-Received: by 2002:a17:90a:a40d:b0:2c2:deda:8561 with SMTP id
 98e67ed59e1d1-2d646d8db89mr15714462a91.41.1724831798366; 
 Wed, 28 Aug 2024 00:56:38 -0700 (PDT)
Received: from localhost.localdomain ([115.96.157.236])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d8445fbf0dsm1013534a91.19.2024.08.28.00.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 00:56:37 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, zhao1.liu@intel.com, pbonzini@redhat.com,
 armbru@redhat.com
Subject: [PATCH v5 0/2] Some refactoring
Date: Wed, 28 Aug 2024 13:26:27 +0530
Message-ID: <20240828075630.7754-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

replace fprintf() with error_report() in kvm_init()
refactor code in kvm_init() to move core vm creation operation to its
own function.

CC: qemu-trivial@nongnu.org
CC: qemu-devel@nongnu.org
CC: zhao1.liu@intel.com
CC: pbonzini@redhat.com
CC: armbru@redhat.com


Ani Sinha (2):
  kvm: replace fprintf with error_report()/printf() in kvm_init()
  kvm: refactor core virtual machine creation into its own function

 accel/kvm/kvm-all.c | 106 +++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

-- 
2.42.0


