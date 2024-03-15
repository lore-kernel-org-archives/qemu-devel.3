Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D59C54E60
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 02:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkxRz-0007Sg-AA; Thu, 14 Mar 2024 22:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rkxRx-0007SQ-JA
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 22:37:37 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rkxRw-00067K-96
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 22:37:37 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bd72353d9fso896570b6e.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 19:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710470255; x=1711075055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qY+7tU8I5uon9579LvLugJEteLa9DUIPs4sRp2xGpVA=;
 b=R3lgGQ3mU6cBgq/swbPOPK/qOREQR/oh1Yb3xxaf9Fhq5UwWmSfUGiSQflpkblplOr
 Bj75/JfHxI6zU6Pb9wUKVPmGlaZPyZdr9dKmHSUn2VatRuXiB8c2zSOipRMGpwYzGkH3
 eJYKZv6qOM+JAyJWRLxBpJTlwUMUNDJ4DTZtZ1Q3YV9qfejGdvx9O93DLRkZw9DnW/VD
 zbAGgUinxOj20cchJyT3ZlLCQXnIy6uMq5N7VGHIzyqclHsTANzcMqMplF76SA9I1QL+
 yCZI8fyFE9C6AnGUBhBGKQ1huat0S7+MFwbR8w+PKuDAXtHpEFfWcT3uK0IBYa2XScZj
 sz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710470255; x=1711075055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qY+7tU8I5uon9579LvLugJEteLa9DUIPs4sRp2xGpVA=;
 b=FWrifJkY/Ld86zNcjQgYVmqAIrrJxIvmR82ZgfhQkjpd2Uy21fplm5+rwfKGFfVkA5
 vDoMCDnWB/DYCpswm/3Sei4h6q7O5IgCjDdwllvRt07WCcI0dS0o2XrEizfJUuO+dxVg
 75m/+UtO+1CM0R/x6ouhaSS2xkdIgcCvMXOBd87mGTdzmERIe8zEotYqhkfkCEr8mh8t
 /vpFZpzxHDYl1qqF5j142dbOqSq0xU++yQ/1zE8DvqW3iluxsqg5RVB9DjbbiKEJgxii
 WmlBs1enLOvO9xNjQF+rs8dA2UVsxVj5zX5spjCZEnTYujkUXF6aRil0r00oSmc/SyVF
 UBDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjTHbWBjkHAuJEElsxB8UdesCPyo+HWKg1h5G93temSPcYVdDdx5odB++uda7Lu6K2xRhIIynVW1mEobFy74tfIovFtuw=
X-Gm-Message-State: AOJu0YygikR8VUHT1KOm1rIFmwNJaSoQhkCLqxFO432hbEFMI4e10aQp
 nB83HltKBZGH4+G/EIh+byfKal0EBgXBg7FLiW9AeXrhYr0JxjpH
X-Google-Smtp-Source: AGHT+IHy/GwbaTlZjtp/pnxs/25PFmpjzjtMFL7DR7EupHqCND+Ycr/ywZLSlxkpDlNl9pFDRD5RMg==
X-Received: by 2002:a05:6808:318a:b0:3c1:c2a5:442d with SMTP id
 cd10-20020a056808318a00b003c1c2a5442dmr4974108oib.20.1710470254847; 
 Thu, 14 Mar 2024 19:37:34 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 x21-20020a056a00189500b006e64b9d88d4sm2214945pfh.124.2024.03.14.19.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 19:37:34 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: justinien.bouron@gmail.com
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
Date: Thu, 14 Mar 2024 19:36:20 -0700
Message-ID: <20240315023620.950554-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307062823.2377318-1-justinien.bouron@gmail.com>
References: <20240307062823.2377318-1-justinien.bouron@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=justinien.bouron@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Just a ping to make sure this patch hasn't been lost in the noise.
Any chance to get this merged? Should I send a v2 with a revised commit message?

Regards,
Justinien

