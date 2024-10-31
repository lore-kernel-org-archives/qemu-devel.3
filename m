Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629F2D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLW-0007Aj-9o; Thu, 31 Oct 2024 13:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLS-00074o-N7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLR-0007CE-7P
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+Vr9TnjLU2a58qM6D2/5EPfpLYLf3sVQLHOXY3Mmj8=;
 b=QELfDi14BiZMPCGQRjTISjhLCsYgxf1XhZ99FcLrbcAz1Bs0JLX/smGEe5OsmRZTCF74Hs
 FfBgEWqtGg091b0dnG4vDEa1UJVMgomX+XD0aevgZn2JQsHGTM6ZUzh/z3up9+vShGOLgC
 Vfe+J2TfbK6xd83h6hC5fisr3EITpBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-YBiiid1IOjixn7on15Uvzg-1; Thu, 31 Oct 2024 13:52:27 -0400
X-MC-Unique: YBiiid1IOjixn7on15Uvzg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5ca5bfc8so583224f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397145; x=1731001945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+Vr9TnjLU2a58qM6D2/5EPfpLYLf3sVQLHOXY3Mmj8=;
 b=LWnGxZmhaEmOZIiwqm5SpjfyvSeFmeTwYSQHkj5a5G8yrY9QrNg+gMIQrx+QAvZpq8
 lVJcqvwrhS9/rq4rrbkLHGXASBBbfDrc0jhdMTm6WyyNcZNMM1h1WJ4nNtSWwNXeZ+Sf
 fs3gn+NwqDHt4rOVKrDjFxpYb0AIJwkg2CWm+h9KaoNbZ6gAbQnpC7q9hxigTe6eQ2QM
 FZX7TB+EnbLd9T3KdMT3VqaHlLMi53zAojN0XRxDfFBj5lbDBENeeUjald2kX8z17BYg
 XnOPvdG4D6jTHEZukeBxP71g08KpBuK80vo6Z8rSsLBvIKYDkv7lRCBgC/kpC2tPUdZW
 Rxeg==
X-Gm-Message-State: AOJu0YwNagA5Cciw8o4p8nP5Ank2hQ6xEafQT19+dWu9Jmk1fOhzMh0U
 jVvNHj1pOeEAL6FUZuyYdJCJ+4pTd2D7vyHJGRSbc+ARJnXuxMRrx/sNYaYzH6FMQ75k8UsuN2D
 auwg8YO+LgugdcrnTNZQkmklIAnX5yN9wC859sXR6P3CG1tFX/yD3yCIKC048M1DNrNIoWkqhZo
 shJrTVyd10O4bZEBh168+Jk9CMWY9/43d3A8/pswA=
X-Received: by 2002:a05:6000:4618:b0:37d:4706:f728 with SMTP id
 ffacd0b85a97d-381bea1012emr3526467f8f.50.1730397145007; 
 Thu, 31 Oct 2024 10:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtuoiJjfTPbjrCTYacmVbF1HpVP6H+GrUO8SEvcla5Mjwc4Hu9Asb9zN6Nt4i0551WAyH24g==
X-Received: by 2002:a05:6000:4618:b0:37d:4706:f728 with SMTP id
 ffacd0b85a97d-381bea1012emr3526446f8f.50.1730397144576; 
 Thu, 31 Oct 2024 10:52:24 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7f80sm2839249f8f.20.2024.10.31.10.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/49] scripts: remove erroneous file that breaks git clone on
 Windows
Date: Thu, 31 Oct 2024 18:51:29 +0100
Message-ID: <20241031175214.214455-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This file was created by mistake in recent ed7667188 (9p: remove
'proxy' filesystem backend driver).

When cloning the repository using native git for windows, we see this:
Error: error: invalid path 'scripts/meson-buildoptions.'
Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128
Link: https://lore.kernel.org/r/20241023073914.895438-1-pierrick.bouvier@linaro.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 scripts/meson-buildoptions.

diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
deleted file mode 100644
index e69de29bb2d..00000000000
-- 
2.47.0


