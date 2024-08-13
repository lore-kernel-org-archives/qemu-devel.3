Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D14EC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduyc-0006jU-NB; Tue, 13 Aug 2024 13:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyX-0006SF-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyV-00039G-Rs
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JEbOJkwY4yqdkYnOaF1sKBNaU2b+I2B2V004N9EQqg=;
 b=P/ZyoYIF0f0qTnhLEp/bsWKWoNlRAscDt7Shk9btFvuB0Cm1KuK+7ZWalr1nssZeDD7nXx
 5Gz+sTALMoLythwNXSei3k9ao2+kpzSanYkLKZ+NK/4g4TZ3XCV+viGyeGNiOt+7zP0+yU
 Ggsh7yqK5b3Y6GPHTmXaW500ux0ZfcQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-QC1UtPEqPNmN_KYOl4PMjg-1; Tue, 13 Aug 2024 13:06:21 -0400
X-MC-Unique: QC1UtPEqPNmN_KYOl4PMjg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef3157ae4cso63360911fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568780; x=1724173580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JEbOJkwY4yqdkYnOaF1sKBNaU2b+I2B2V004N9EQqg=;
 b=DGZzLsqj279QzaScmqcMEQzBZG3q0+Zg6KJMQE3g9ybVLqvbrLkI2ldzpCa9YvS46C
 RIbemc84sL87QVT6s7DnE+lF3i6Rc1HzImFc1i4xTBQ0bD9C8TKcFBFm1yb5/aYuYWdf
 vep7XH/AWfrelCSwEuw+BqC0hjrsEy0ZBTDd2ViGREp+vFsfEaITVukVN+vVcxw5wYAz
 f2cJNrabvjjP8s7OhPw8z3vjO64GfGPsKDOCpTRa74L2A5r+xdhTUkBN263eRi2+UgNz
 mQ4dnDqtSCbyHxcLn4B6FSpbBgzeVNiTOwk6D9KhL4TGbQrqWrZLI4TiU46fUc+ikFmF
 E+XQ==
X-Gm-Message-State: AOJu0YxOkJMUesQkg+2+knwz3H4nkEeI33sq7uc7a5O+AEN4QEhFlyGI
 qZKfu0ukoxqilM+9XCSUD0SNNMBIwpISvDYVkVn4Lzamek2qS5+kBVDIg79fMa2hYbpj+wxsK2s
 A9PSnaZjqN8yYivtwGV9Q16cz/v087e6Fl/OXqPU9isL3GovV9Es/i+0Z/yItg1yKB0/E3ztFpT
 H+SIvwYxvUS37Npt6H8+qYQth70feKZnY/ix9Q
X-Received: by 2002:a05:651c:11d1:b0:2ef:23af:f202 with SMTP id
 38308e7fff4ca-2f3aa3014d8mr93721fa.46.1723568779880; 
 Tue, 13 Aug 2024 10:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQAFehb92Po3sTasJDsUkCvOWxmJMfRoc0itBsiOHITjOISKaOgfB86PrU5W0jHZEsND2EJw==
X-Received: by 2002:a05:651c:11d1:b0:2ef:23af:f202 with SMTP id
 38308e7fff4ca-2f3aa3014d8mr93331fa.46.1723568779307; 
 Tue, 13 Aug 2024 10:06:19 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411bb19sm82352666b.122.2024.08.13.10.06.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:06:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] po: update Italian translation
Date: Tue, 13 Aug 2024 19:05:55 +0200
Message-ID: <20240813170556.104193-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
References: <20240813170556.104193-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Reported-by: bovirus <https://gitlab.com/bovirus>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2451
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 po/it.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/it.po b/po/it.po
index c6d95172070..363b9bddf2f 100644
--- a/po/it.po
+++ b/po/it.po
@@ -65,7 +65,7 @@ msgid "Detach Tab"
 msgstr "_Sposta in una nuova finestra"
 
 msgid "Show Menubar"
-msgstr ""
+msgstr "Mostra _barra dei menu"
 
 msgid "_Machine"
 msgstr "_Macchina virtuale"
-- 
2.46.0


