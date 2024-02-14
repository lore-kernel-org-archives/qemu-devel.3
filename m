Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A4EC48BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDG7-0006oC-PN; Wed, 14 Feb 2024 06:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFf-00064y-1f
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFd-0007XS-F9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IqUlUd43QVp4JPzLFMlq1/YZ7NboCWEvvXOOtxwXww=;
 b=RK0eX771DcUtYqgTu7rV7p36Q46aaw9CDT30qCloO0tIOssUDJwKjlsYW0m/onWFVSckE1
 +YUmbdB8bEqWNz8RaZmLck84CpOVs0IS0XeRHAfoR463p2R0j3yB/3Uj2hvWhYTfRPS14+
 sROirhrxmqeN9X6hNAhB9Ez2gyxHu+g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-t4CFZwWwP7eusGV3-VSm7w-1; Wed, 14 Feb 2024 06:16:27 -0500
X-MC-Unique: t4CFZwWwP7eusGV3-VSm7w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56217800333so625268a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909386; x=1708514186;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+IqUlUd43QVp4JPzLFMlq1/YZ7NboCWEvvXOOtxwXww=;
 b=vYSnUe0MMx/i9qB4rCcxwKGQjGj2u8A9MgvN91VmJD+3c/qlwsAkJviTUa7FyMPFvi
 nkwUihp0E3izSRS3nyuMsxTIKWXVYni/8qdAtfYaF6xwZjVD6snIVnS5HxrbKyvrDwkD
 L2SlpqfVw+N503EnMs3QCKAQkj9xeqD53sUqVwzx09cewNDLgC+Bmpld42WW/UNdxTyb
 Pg4C4hZg/b7cOk77/FPAFE3E0eSNshCQfiuNclrHnX223zmj3ElW6LoDMlzjobJjox46
 8a7GmEcq68ERzf8vLjgSUqk1rXzBGjg6pska0qkT5caRgd0ED/SnABM0KgC0z0RjMpJD
 SySg==
X-Gm-Message-State: AOJu0YyYg18MfRXT65UbC4oWSBjqClnh/5nwSc0jnbDXuzwN0KGPoWfm
 xkH1rWgDn6Ym88PRYiOLWjvg85nIjZV6OAMCUWaAaSqWK4Abqpy/NWW08RdqUD4sst0ZGeRllrZ
 IEV06eUqewFm6TktB3P5qdRTQAPhKNiBl8Ms3zNehxPBV9rT6K1jxZU4sRgnGIzFtMkmzth5wIp
 Exd/Ju0C6J7/J7WwHcdhoi+8qvHbIWcg==
X-Received: by 2002:a17:906:6684:b0:a3d:37a4:a7e6 with SMTP id
 z4-20020a170906668400b00a3d37a4a7e6mr1202313ejo.21.1707909386239; 
 Wed, 14 Feb 2024 03:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtTYOR+WwAEd7eYcpklZOVxSG77n8Z/0mY7z46JYv9XeviV1Gq6ioL818hxkUr4Kvyaxe9OA==
X-Received: by 2002:a17:906:6684:b0:a3d:37a4:a7e6 with SMTP id
 z4-20020a170906668400b00a3d37a4a7e6mr1202294ejo.21.1707909385909; 
 Wed, 14 Feb 2024 03:16:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVD9AbnjEEVvkKJthBTPV1jAphMxJ7UiTG0awezkIl+ExBKxGW2pcWPOv42aWpPTCnS+RbffAFRALpEQ7Dq6wWB5Ih5SeaKX0t+H7vKSkkh4d8ZZQWe9SXJ7RgBzmUvDvTc+9TLtCYZTmxuU2eWTm3K62+e7f7TryZjXDjY+gNEiLEoPOgwTsJTZ3lpblPrfaHJjq5LXtA=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 tl14-20020a170907c30e00b00a3beacb1666sm2196228ejc.157.2024.02.14.03.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:25 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: [PULL 60/60] MAINTAINERS: Switch to my Enfabrica email
Message-ID: <3afdb6d18e9ccd6470be30f151a562cf4537d13f.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Raphael Norwitz <raphael.s.norwitz@gmail.com>

I'd prefer to use my new work email so this change updates MAINTAINERS
with it.

Signed-off-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Message-Id: <20240204023758.83191-1-raphael.s.norwitz@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a1afb40ac..0bf716db6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2570,7 +2570,7 @@ F: include/hw/virtio/virtio-gpu.h
 F: docs/system/devices/virtio-gpu.rst
 
 vhost-user-blk
-M: Raphael Norwitz <raphael.s.norwitz@gmail.com>
+M: Raphael Norwitz <raphael@enfabrica.net>
 S: Maintained
 F: contrib/vhost-user-blk/
 F: contrib/vhost-user-scsi/
-- 
MST


