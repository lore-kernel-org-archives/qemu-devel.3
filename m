Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920C4C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQHO-0000dM-0A; Mon, 29 Jan 2024 06:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUQHM-0000dC-2D
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUQHK-00075X-KC
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706529497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pbErSis5428/LevwsaStRPcnx8FTLbnUYr9K0QHQpCc=;
 b=bFITnyELmoAbwG3QPiwem5ryt/WJkhVXTLx5kaer+3dFw9FRpMtEDICkz+IAnkG+95727U
 hSjfiBKGyiMYAl8Tcb7xYnylwY4GoMkw6E+gbzz9GPplUvdSE1hw/e108IE5jYkEFhZnnc
 XjjcpkwJnAV48dx/Fo8S3H4I8nBvxwg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-uD0MmyS8POG5VV1U_-h3FA-1; Mon, 29 Jan 2024 06:58:16 -0500
X-MC-Unique: uD0MmyS8POG5VV1U_-h3FA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a35384ae3beso88317966b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 03:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529494; x=1707134294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbErSis5428/LevwsaStRPcnx8FTLbnUYr9K0QHQpCc=;
 b=GKj7dMMW8ALjsx9a+Chcwiu2Kzgg9vC0RaVlhpDq1GT1sDRkAoOSihy+HIG33dw/XT
 DeyPU+GsmHr9NmegcMQYP8oRhpWIo+UNT/9lZV6J5PGd8+zSO63Dd8txYhp7nfMDjp9D
 RHs510g0cc/ldYQSU5ez5WfBPsEnkoQh4coVJUpkp3a3kXjWR3x8Ji3/bt1u/hMzBsmx
 6QrE9g3bXgGwcYj6x8Z9ibdxNFJu+YIty0t6n+MQVrVJYzMl8KPGjJlt3w5aXyMCknci
 RKPQeEMxSFxGvqaL3l/CzXipV194k0gujwPl29eX2Px7Z71Fepgwx6OYAwP38nshg1eD
 ODPw==
X-Gm-Message-State: AOJu0YyXqRU88niB+DS7aMHZy83YxGgjMkmjTG1b0AwdJNFUU0Ak7c3z
 YeSo+qA/5FXG5WRQABS8rKT78yIEhaVlA4VXVSnqwYvO0000tt1y1x0UnW0UkEoOHblx+iakF95
 +rNZRZJjCH++gbj2c0q7aqgrLN5Ssy7zuEf2LjHncw4lwofS3vysx5q4k2fBi3FpmhV900vq4kF
 LjS6Ank1unoB0UUwsINKndHBtsI2kYqzpYUrQ3
X-Received: by 2002:a17:906:a249:b0:a35:56db:f4d1 with SMTP id
 bi9-20020a170906a24900b00a3556dbf4d1mr3524148ejb.26.1706529494182; 
 Mon, 29 Jan 2024 03:58:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl8LwH0h5R+Jww+ud3pd9JuEVCZoI22c6v+70C8cPirb61u1MpIB86Nhc7yWtuVkFYTff80A==
X-Received: by 2002:a17:906:a249:b0:a35:56db:f4d1 with SMTP id
 bi9-20020a170906a24900b00a3556dbf4d1mr3524133ejb.26.1706529493513; 
 Mon, 29 Jan 2024 03:58:13 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 lf25-20020a170907175900b00a35b59cfbf9sm1057308ejc.202.2024.01.29.03.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 03:58:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] mips: remove unnecessary "select PTIMER"
Date: Mon, 29 Jan 2024 12:58:11 +0100
Message-ID: <20240129115811.1039965-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is no use of ptimer functions in mips_cps.c or any other related
code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 505381a0bba..ab61af209a0 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -50,7 +50,6 @@ config LOONGSON3V
 
 config MIPS_CPS
     bool
-    select PTIMER
     select MIPS_ITU
 
 config MIPS_BOSTON
-- 
2.43.0


