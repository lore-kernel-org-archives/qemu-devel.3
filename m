Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA9EC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDG1-0006bo-IF; Wed, 14 Feb 2024 06:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFQ-0005gZ-Fx
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFO-0007PV-Ot
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TmDYJ4T8Bz+NoOI3p2PmjP8oPOJZM9WBKm2EH3ooem4=;
 b=GQiml0jOQNnKsC1IJBDG8lZ/UnC7aq4eTO7L/oux8QuNYYwfIO0LFZ4M+Gy+gZjGdIJKeD
 j5agX0CXdsE3T9UWv2xdnukaC27HResP5e4z3iGlT9/ue01JKi8WoQle7hdS5ssIDcL0VU
 uObjSzcARxr2Tm3HzdNEQTUaUl43Rws=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-KrpTwIqNNvKaxNxvuKPPcQ-1; Wed, 14 Feb 2024 06:16:12 -0500
X-MC-Unique: KrpTwIqNNvKaxNxvuKPPcQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-55fee28d93dso3093902a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909371; x=1708514171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmDYJ4T8Bz+NoOI3p2PmjP8oPOJZM9WBKm2EH3ooem4=;
 b=IbAB4dcu4P/e+dX+ZiNRsI7yQtV6nI7CMmniBInvvy3pqtgwOECfHqbUg2zohlR5jM
 SY8GuMNiGsC6R5sM2dBYaZMduUudkXnOVdy9bKXGj67yhiFEKVLVWDJ9NmF+HC1XmEg/
 u+CIWsSDOhpM+rDcv/VZE94QltkEp864UrS4iQWiyBfVNahLyE5fXGEW9nhAKP+FiuoC
 ow5EkkK1euZdY92CHxKjPynTmMzZ7huuXBH/7iMYS2t5Tcw3C0A2FoaQ31n4CP3As6ca
 V4ujC5B+HkRQ2WjVglcOuUABFZrOGojefPL0fXqsTg5VzVwQObzhwoVXL3Lu5yV4neZy
 E6Mw==
X-Gm-Message-State: AOJu0YzqtDs24iX75dmeeE8AxeeUgwxZ+WLaI3JbAWjepCb9uHt/ssTj
 xHv92GzXyaCF5Ei7n/aRwOrtH+HyNu5FfiiVU6m8A/tr81JVsZcd+wiTq5nCBtfh4QX8BDmGVXp
 gjaO8NBOEoUKFiHxYoXmRiz9T2X7DxW8W6mI3pe3EtxwIcYdeU1kQOjworhzjGA4LwwNAFTAcUp
 cWCBp9ttP6S1qt5hOZBObr1GzAhgiAjQ==
X-Received: by 2002:a17:906:6812:b0:a3d:967:eab6 with SMTP id
 k18-20020a170906681200b00a3d0967eab6mr1541431ejr.41.1707909371202; 
 Wed, 14 Feb 2024 03:16:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfSfux0Ajn4HD//6r9kG0i49vcP75ZK0Rox31i0IvPwZ3FGH0d26JuBlCKSkCKmXfiAa9L4A==
X-Received: by 2002:a17:906:6812:b0:a3d:967:eab6 with SMTP id
 k18-20020a170906681200b00a3d0967eab6mr1541413ejr.41.1707909370987; 
 Wed, 14 Feb 2024 03:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUyAWQoEhiNWMaOP08T7ia0XHrwBo5JKfQZA/Te/QGeyuDOBBv7RQ95OKItvlsFoAjaIhj/8jcMF/W+fExPeaiIAw8rmmomX88Nd2FJAMCau0h2hUKhUnu82hZHidDBWk8jsLM7cUStYEJRZzubUWgY/5rfBuRs/ZJra+FWINHc9bzLBtBv5AHJMPvt/FP3g/Bgsn4zNwyJFrLB
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 sa9-20020a1709076d0900b00a379be71a84sm2201854ejc.219.2024.02.14.03.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:10 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 55/60] hw/smbios: Fix OEM strings table option validation
Message-ID: <e8ddec58053e9361b2cc18ec6d17b6c95590bf3c.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

qemu_smbios_type11_opts did not have the list terminator and that
resulted in out-of-bound memory access. It also needs to have an element
for the type option.

Cc: qemu-stable@nongnu.org
Fixes: 2d6dcbf93fb0 ("smbios: support setting OEM strings table")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240129-smbios-v2-1-9ee6fede0d10@daynix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index c0c5a81e66..a9048c1342 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -375,6 +375,11 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
     {
         .name = "value",
         .type = QEMU_OPT_STRING,
@@ -385,6 +390,7 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
         .type = QEMU_OPT_STRING,
         .help = "OEM string data from file",
     },
+    { /* end of list */ }
 };
 
 static const QemuOptDesc qemu_smbios_type17_opts[] = {
-- 
MST


