Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37838C48BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFV-0005pp-RR; Wed, 14 Feb 2024 06:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEz-00052h-Is
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEy-0007IW-7E
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1m40RG3DO787zSHU7BGwg57JlBK36kVvrbc9G+uzCdk=;
 b=H48/Ae0K5foajI+am2/QrQa3l5bX0ueAqlTwWJCmFDdJHSsnKizfWeFvtb6ps0LjTYj+Aa
 ABBrCOtVn3772r8guBZJ/A8eOvIlknp6r5zGI9+Rgj3ISUJg4wWx2TExbiJXg8vXIRcHQy
 TSXC+BzuzhyAJRjVsH8Jk4BHTDCWyc0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-fmBEoVjXPBOazzUpEaXn5g-1; Wed, 14 Feb 2024 06:15:46 -0500
X-MC-Unique: fmBEoVjXPBOazzUpEaXn5g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51162d43c64so3207155e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909344; x=1708514144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m40RG3DO787zSHU7BGwg57JlBK36kVvrbc9G+uzCdk=;
 b=SyO0WUhkDNiynPU/pjwvUSfC9BX1tSqHIVSLkvCOwU9OIwbzdO+7ABaExXTGzhR1HL
 xan3lyWxu6DC7TaiugROLe/AN3TO7gAYvvOOzvAwx1LD1vRi3hWqm0TjmXakt4k9iCF3
 upanAxqTDZIxOpbd/mxa7tf1EK1U/YLgLJmfk+tj7fQo2lREJPw1F5fGIYrUFf/OjjD0
 dLvbI7LbcLKNe2KAoVb5osd0wgxnVlg38kG1bQWYuvPivLMa5FevG7Q1s/Xgg5vGEghT
 EUP7aYC2gTJgVKIkqlCf7SaH+fHqBfBe68ZS/MQtpnsVYlKsblGPSHe0jdaj4qk85eXb
 7TCw==
X-Gm-Message-State: AOJu0YymCtUf6QwLyOjl8Tl4DnWnO1QESRhWVmwvBTa2lLI6rIfjkjhe
 z+8gDFifgwAZ8MEgsNhTV0qn4O9ljobBtNKVUGR3PA8NJhY/G3JOkMx+J2v4deO2pGVDcaIQGG9
 JHp0iMRjCWSSKROdwXKQeHoHo8RQJopKGmXL+RzhNEJAqm9BxBpaElcDKX9h2ftN3h2a2veb2iE
 JOuYWdK80jM53jkkdI3QqCDS3HtpJFzg==
X-Received: by 2002:a05:6512:53a:b0:511:5994:2c92 with SMTP id
 o26-20020a056512053a00b0051159942c92mr1715926lfc.7.1707909343798; 
 Wed, 14 Feb 2024 03:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/8T8mvx1Dva0phBPblUBGPpA2jeM8+UNPxggMoqmKVWjJ9IBz7rOWTBU2Ixy3KcUmOzwERA==
X-Received: by 2002:a05:6512:53a:b0:511:5994:2c92 with SMTP id
 o26-20020a056512053a00b0051159942c92mr1715905lfc.7.1707909343474; 
 Wed, 14 Feb 2024 03:15:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXgJd5COh7in68drsPi5VP5OsuXCjzLsBN/hztAZgJB6opXEqfWYsLLl1Yx723f6HU/hT2EQPe+kISo6IOhT6GvBD3sckLL0ArPBUxBM2GqNqq1mkVsBGwlcOiglm13aTyKG35I0kugWCXHyASvBIls+PJZx+U=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 er13-20020a056402448d00b005607825b11bsm4536532edb.12.2024.02.14.03.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:43 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 46/60] tests/acpi: Allow update of DSDT.cxl
Message-ID: <14ec4ff3e4293635240ba5a7afe7a0f3ba447d31.1707909001.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The _STA value returned currently indicates the ACPI0017 device
is not enabled.  Whilst this isn't a real device, setting _STA
like this may prevent an OS from enumerating it correctly and
hence from parsing the CEDT table.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-11-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9ce0f596cc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.cxl",
-- 
MST


