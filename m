Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4432D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu5G-0006oS-4H; Tue, 25 Nov 2025 09:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu57-0006ix-8e
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu55-0004fB-JA
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:48 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso3364909f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764081106; x=1764685906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzGaz+mT8MwL6xqiiVWVptUVAp4I0FWW6NwifF8v9es=;
 b=XNA46vbfxlmpG6rOC0nMvoW92oEqqHwLQoPpL37tSqI7IdrwFybAUIagFQ+LPIuZjq
 IJrY2lm9YN27EoaX7omue64ujQoPUv9N8gANDEpMJf3CKJcCXlEdZbgiiOWqaOp8VA3I
 T3X6bmUBeKKmo1dPvuluACKvElpY+qvkhE0+k6MCJtIpZvV7z0dHqQuOE7JiMfHx0Z44
 f3NoI8MWDxaNx/iYdWsH9TMtNTrsSiaH3jFtN3RH/T56aSSk3ydhzHhE/idKJ9hLX3IZ
 hfZ8wb2BePh+VtLTeHRadw+3zoSW3/7/OyDQI2dPtDMxXoNFfjTzdUAUjPQ1ASNZyk7g
 9WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081106; x=1764685906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lzGaz+mT8MwL6xqiiVWVptUVAp4I0FWW6NwifF8v9es=;
 b=l8AkXfFQk4MzRvVMVsRYGhfX5QzhmTaD1SbWS0+NyG3pPUqUNJpJiM2bQyaTZ1iZKw
 DTCriipOtH9XlShLWauTbzcHtOn57zU7OmcMaD8H1y1YSxwKPoNSFOT/nv98+4DAaamP
 SqTK6Pel20qbgt4KK1GcQcjDW/kR/IcdctA8KlsPHXMNVcCuSWcI74cVachxa9fvPPdZ
 o1XNvfAfduyAtL0nCYEmWVNFtk7rDMt/gc8WNP3zkjtnDoq5xt3k7e/P06zkTfPh6rNC
 x+iN2ZYtRfFfz2TI2WvuNxlVqqgnNSDFLnXOz92OTMhlIGV1+FUwY5kdoh2MMRMD9DlT
 hknA==
X-Gm-Message-State: AOJu0YwhHhpQBcugMkkIaxYtnkoAhU+3CCw5xTx3DdfBqd5+EbFRntqy
 yTCWuRPmtvhtVhBvCNYxOgaKX6pXqgs6YnzRjHEVtr10VCatsofjMKE3MYM7EU9hMCwHTLlALhf
 GfIWn
X-Gm-Gg: ASbGncsLxFbkJXet3bjJdamC+LxHIKhxHpID22fYuEtLoRxZHDPY2za54+Y+gEoY6VH
 QiVaAb5vNOuMtL58cz8LNKz1u2omW0LmYSLbAaTa0USgVv+X4Y5M2H8MMhhFRMNGH9ai/S9qMZy
 wycPDGaubzqFBVJtajKCEeT2RYWIedk/OgbJi6ZBuhE74sD2mvvx361Tm+Xa+tIL1OYJGGWPqp8
 4i4bYzsRgae7eyf4S8eQtQ1mKuJXNUzWM5gi26XBGsWcnp8D2oCcFUAyBrtx86tiB1GRRs7nRI4
 BQpgo2eifNlBHnKkiYzqvR+1wCVWllkb/Z3F7j20aa0uYjZ7t40r/xfhDNMhn+tQYyxPfDpTD19
 OH9Kuf9cXCraFE8RQyLv+d0nm8LDiv2rJO9cNKDE5EioF6NXKzZN0rYRe0uUEFGjfuXU7luvNyv
 HiNg==
X-Google-Smtp-Source: AGHT+IFJQ4l3D+PWQ1ipxYohx7BNVhYy888VbttWHpMd9NtNsie+COgIy00+sfvMChywHIxElQoQYw==
X-Received: by 2002:a05:6000:2506:b0:42b:3e60:189d with SMTP id
 ffacd0b85a97d-42cc1cbe230mr17075912f8f.24.1764081105768; 
 Tue, 25 Nov 2025 06:31:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm34485434f8f.34.2025.11.25.06.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:31:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/3] docs/system/generic-loader: Don't mention QemuOpts
 implementation detail
Date: Tue, 25 Nov 2025 14:31:40 +0000
Message-ID: <20251125143141.216056-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125143141.216056-1-peter.maydell@linaro.org>
References: <20251125143141.216056-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We currently say "All values are parsed using the standard QemuOpts
parsing".  This doesn't tell the user anything useful because we
don't mention QemuOpts anywhere else in the docs.  What we're really
trying to tell the user is what we mention afterwards: that the
values are decimal, and you need an 0x prefix for hex.  How we
achieve it is an implementation detail the user doesn't need to know.

Drop the explicit mention of QemuOpts; this in passing removes a typo
"QemuOps" that we made in one place. Put the informative note
more closely associated with the <addr> suboption which is the
one that users might most reasonably assume to default to hex.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/generic-loader.rst | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index 3ac39cfbbe2..d5416711e93 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -21,6 +21,10 @@ can be done by following the syntax below::
 ``<addr>``
   The address to store the data in.
 
+  Note that as usual with QEMU numeric option values, the default is to
+  treat the argument as decimal.  To specify a value in hex, prefix it
+  with '0x'.
+
 ``<data>``
   The value to be written to the address. The maximum size of the data
   is 8 bytes.
@@ -37,10 +41,6 @@ can be done by following the syntax below::
   The number of the CPU's address space where the data should be
   loaded. If not specified the address space of the first CPU is used.
 
-All values are parsed using the standard QemuOps parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
 
 An example of loading value 0x8000000e to address 0xfd1a0104 is::
 
@@ -57,14 +57,13 @@ can be done by following the syntax below::
 ``<addr>``
   The value to use as the CPU's PC.
 
+  Note that as usual with QEMU numeric option values, the default is to
+  treat the argument as decimal.  To specify a value in hex, prefix it
+  with '0x'.
+
 ``<cpu-num>``
   The number of the CPU whose PC should be set to the specified value.
 
-All values are parsed using the standard QemuOpts parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
-
 An example of setting CPU 0's PC to 0x8000 is::
 
     -device loader,addr=0x8000,cpu-num=0
@@ -85,6 +84,10 @@ shown below:
   The memory address where the file should be loaded. This is required
   for raw images and ignored for non-raw files.
 
+  Note that as usual with QEMU numeric option values, the default is to
+  treat the argument as decimal.  To specify a value in hex, prefix it
+  with '0x'.
+
 ``<cpu-num>``
   This specifies the CPU that should be used. This is an
   optional argument with two effects:
@@ -104,10 +107,6 @@ shown below:
   This can be used to load supported executable formats as if they
   were raw.
 
-All values are parsed using the standard QemuOpts parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
 
 An example of loading an ELF file which CPU0 will boot is shown below::
 
-- 
2.43.0


