Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE08C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDG3-0006gP-FY; Wed, 14 Feb 2024 06:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFU-0005ns-Ij
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFS-0007Sr-9B
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4ENYhUgFnCI8zatThJ4D45wdZB8M6CEIKjVTDexlIE=;
 b=iJ5oVn8znMhZK/lB+I9H6toAS6aPVAxjepVs+InkNu/hmqBE6S8Tom1iemuoBSo6s3mZeN
 Ohmvx0kkCffZP4KjITqglWpCeUV1pqQpXTj9pknuNotoFL8qNy9KSqHbmr4WOA/jeYrjvR
 paI582enO/WJR60pCPp15ROyr4FTmmw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-1WSgttgHPmaL8Nhgw1dbFw-1; Wed, 14 Feb 2024 06:16:16 -0500
X-MC-Unique: 1WSgttgHPmaL8Nhgw1dbFw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d0908edbd0so48678491fa.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909374; x=1708514174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4ENYhUgFnCI8zatThJ4D45wdZB8M6CEIKjVTDexlIE=;
 b=JzWlhWFXQAc4EZjGDSSljVNcJq157RObjdOm5uGs/FG8lprTmyqgUXlqXzu7U5EEOz
 z04KUwR9U66ABs51eJFVW0EOvHrcdCptIlXJPBmmTZcR5TNbkiToMcK0JxWEdeL4ajB3
 yRF4u9223+OdgT03e3h14aCPaVtHdoEh923Ov/tQJ2s61kxCyzq4LfIGxZOFsJc2OmRC
 06PVwQzW+1dH9A27SjDIJD1Ka0fuwiftm0bDU94uHSFcNtTmeYLUykdA83DM+JRBgex3
 XxE0Zcl7/ty8C1YoWrZxYWuYGz/DNN3d15PhRKooip4E7c0J9sXV9w8NOw7DDHWYyMnk
 Y/Bw==
X-Gm-Message-State: AOJu0YzcO+/TpMZSj5WqGsgJ4yAw13o982Rwietf3pvUMMXatnO989qv
 iu4Cec553r+67Ems9ZTWwcsrPDhy9W1nn4MQSA5YfasT5tr5Pv+IzsFDUxY+2/65s2gTcNoakIu
 +wQNi0Vo0hzXyFH20AxXZns1ujsJK6k6C3aBstxoozLDGbo3tsxmsn5390XnBC++I3Ol5o/HYGZ
 ITMJuzeNAo7rbNZ/3CRFJDJgTMPraEog==
X-Received: by 2002:a05:6512:3b9e:b0:511:a4bd:bfef with SMTP id
 g30-20020a0565123b9e00b00511a4bdbfefmr1957636lfv.4.1707909374455; 
 Wed, 14 Feb 2024 03:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF+OqKZCMfufDjJtx8otkLsPpsc9I1uzpC0KIbXQDoj+mcraCvf7AvXISr3Z187fRjrjceSg==
X-Received: by 2002:a05:6512:3b9e:b0:511:a4bd:bfef with SMTP id
 g30-20020a0565123b9e00b00511a4bdbfefmr1957614lfv.4.1707909374146; 
 Wed, 14 Feb 2024 03:16:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWL1bHQDdLCPwalsrug/6tMZWvvKtH+kiycUoW4UEHDfzuYt8tPKZEJ4VjQH1cK3YERq5i7W1zL+x+dVMKaj8eDLbqdyhTQxcBEf592TezjC2+M6MowNd9eqZw8Hpm7PViYCLlOCzub6fRV6qo5/AI+/MMUuhudElKEmVLMX+AIj+BKLc7EB2F8XdFQUVu196WwUjx1rEWDVcdz
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 c8-20020a0564021f8800b0055d312732dbsm4619551edc.5.2024.02.14.03.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:13 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 56/60] hw/smbios: Fix port connector option validation
Message-ID: <33b081e2947db6117b27f8c76544a756053f5514.1707909001.git.mst@redhat.com>
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
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

qemu_smbios_type8_opts did not have the list terminator and that
resulted in out-of-bound memory access. It also needs to have an element
for the type option.

Cc: qemu-stable@nongnu.org
Fixes: fd8caa253c56 ("hw/smbios: support for type 8 (port connector)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240129-smbios-v2-2-9ee6fede0d10@daynix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a9048c1342..a3c4e52ce9 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -352,6 +352,11 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
 };
 
 static const QemuOptDesc qemu_smbios_type8_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
     {
         .name = "internal_reference",
         .type = QEMU_OPT_STRING,
@@ -372,6 +377,7 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
         .type = QEMU_OPT_NUMBER,
         .help = "port type",
     },
+    { /* end of list */ }
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {
-- 
MST


