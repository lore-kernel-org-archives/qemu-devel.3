Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B08C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 08:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVSDZ-0000DK-PQ; Thu, 01 Feb 2024 03:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rVSDX-0000CS-4e
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:14:39 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rVSDV-0002p0-KX
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:14:38 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6e133d5271cso321367a34.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 00:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1706775276; x=1707380076;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDQr1Y/iBmlF6C2qWRRfab+jRm6FZFW5CoJITyGCHHM=;
 b=przkP6n74q5McpKMY++9uflRWpH3ARXC5y8ZpOP6vEYmqdW8YC/kz/ZiOfh3h5phfQ
 OhVxe31gbWCLEf7I/nTDtaiYPeTmrfEZ/okdzmV37TdpDzKP/nDGB/bOZM8Im0f70qUS
 heC7o3UkNQcsJoR16vZOEx9XFsHNxD0NIVkbb1KYfnWdQCYioA96AQYB7QDd7Q/GWGRa
 Uw67iROnxGwSZKJSvxiy2gJVaN5fHkZFJAa2zf06rSsEP5a6h8aslLFnLCDjk4pfLzUl
 uHjUp5gaZ+rBL5+QI0RpfsukWerGpMpUA6ydF5V2OGn4mixz2ZzrRsBEq9v9yEmZ/him
 Sx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706775276; x=1707380076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDQr1Y/iBmlF6C2qWRRfab+jRm6FZFW5CoJITyGCHHM=;
 b=pmNrt0ZQA3SKnRo6o5ML76hJPsu3GJaftPSE3DM2hsqefpRdxc3tNqMtnmce507VR9
 +SRU0ZGsYIS+dMGFuJSqqNRvwn0jpSJIskaKFH1K9z0FQ0SVQ4Pqp+/XowgbAG/rYGiJ
 REzuAdORs/S1BnDVnMqys2bVDQztmPnNL0XGlhvzYGuO3EuVsgjkfmWea2PKTtb6b7WR
 1xXldjpJGsCXB5n1TG3SD+01YSnyqnr9oIFLRzx2m8zRXJ7EV53F4FCLpQ3bPSbALXmq
 bKpGn1zGJk0Hl8SUWSeg7jwxyD7LD/98RCVadQsJBtM+l+BS/B4PzYuatPlpDCUq3UrU
 kOOA==
X-Gm-Message-State: AOJu0YwoL9d6t4MKK8JhMd3eV6CZLhu6ch0RWJpJ9reIYi2SXCXuaBw4
 xI9vriSetUGiMOOnjQxa08mlqnBukv2v/3S6Tt+x3xFvwf+TGokL2o8L5VHMx4GXV0AC7/hBINu
 ngKU=
X-Google-Smtp-Source: AGHT+IEOGoTLljgb7dltCH4+p6XtiVTgBcpz6YNz5k5LqkthPx2A0d9jqKBalp8pj8RB3X7jDzbpPA==
X-Received: by 2002:a05:6830:6:b0:6e1:3d7a:a6ce with SMTP id
 c6-20020a056830000600b006e13d7aa6cemr3974694otp.2.1706775276519; 
 Thu, 01 Feb 2024 00:14:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXA0bmWm9Tay1KW0b2ATc+wrSfsEq8Gqvo2gUK5J170KAK6wng/RUQeL8f3Ipy9tmpHneOyBsGuzez8J6wocaz42g==
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 38-20020a631366000000b005d6c208fbd2sm11943780pgt.35.2024.02.01.00.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 00:14:36 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/2] hw/usb/hcd-xhci.c: allow unaligned access to
 Capability Registers
Date: Thu,  1 Feb 2024 17:13:13 +0900
Message-Id: <20240201081313.1339788-3-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

According to xHCI spec rev 1.2, unaligned access to xHCI Host
Controller Capability Registers is not prohibited. In Addition, the
limit of access size is also unspecified. Actually, some real devices
allow unaligned access and 8-byte access to these registers.
This commit makes it possible to unaligned access and 8-byte access
to Host Controller Capability Registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/143
Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ad40232eb6..9e0b24c93e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3181,9 +3181,11 @@ static const MemoryRegionOps xhci_cap_ops = {
     .read = xhci_cap_read,
     .write = xhci_cap_write,
     .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = 8,
+    .valid.unaligned = true,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
+    .impl.unaligned = false,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.39.2


