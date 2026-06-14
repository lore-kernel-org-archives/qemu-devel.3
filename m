Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487F9CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDO-0008UC-QV; Sun, 14 Jun 2026 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD5-0007Z4-Av
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD3-0002eO-Mt
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SWeGTj7EwdyIVL6K3gXCRmAsQCPB78CchrdftE53rGY=;
 b=MAqmJGGr69M09ZHoXqx1qTEkVpDxGPGUUeeVpTY2VZKgbVPVuf4ietOU9fEZXQpofLpFYW
 /2HAIVrpQqVnFEKZOdsDEIw4FNtvH86a5uZIJl1d+343Mcd9ayQXLSsrXEnUDae7ulDNz2
 U5KKL74YKXqgUuBGSmOVpRTMhWQYmno=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-hfsI3Q6lPt-P6tJTSCSBuw-1; Sun, 14 Jun 2026 15:09:27 -0400
X-MC-Unique: hfsI3Q6lPt-P6tJTSCSBuw-1
X-Mimecast-MFC-AGG-ID: hfsI3Q6lPt-P6tJTSCSBuw_1781464167
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46010bc0f1eso1417683f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464166; x=1782068966; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SWeGTj7EwdyIVL6K3gXCRmAsQCPB78CchrdftE53rGY=;
 b=VGnzilQMxSWL3+P2I5XHRq+tihf0Ljiiy9zFOCj1iLKL3OjSOGi6SF8podeaJnRyaS
 tofQUYL47LmJfOHb6ZgpEesRqDKmzW3Ll5wJ1TjI9Jh8KNxOuY0/z9Iovf7J3ouzd8ke
 rtWnYfuj11lValcPnELsXqsglIrjVl9kcsEHLTAovKZ522VUyawNVFnvBnZgNyrp5okX
 OnTKPcNLRJGvRAo/lkF6qTquX0ou9t8vGuQn5Wc0cSyHtFXavh00NMxa3v/lpRX2EGG2
 5vgMt8Vtdaep04PJ2mcFQTeNHhLRyeUHwpa5osXEqxcDXB3jWhvSWXspdgjxD02qud5o
 FImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464166; x=1782068966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWeGTj7EwdyIVL6K3gXCRmAsQCPB78CchrdftE53rGY=;
 b=U4ItS2iRJbbNbsMoBiNKwy/KskmLk2BonmMVl4MrFg+fypMEvCoV2raK6KDT2IohU7
 OrLyaRe6jwhgG3CSw/z+gOBn0aM5FN50wSGi+3kW32QDycUX9+ZPF/10itIrMRIDiZ8I
 aYo4LHOCu7h0QRkV3gjYSP6V2xsuuFY6YuJLc/A8yvua1yClFiDdgpb25UdFhMrl6wXD
 dIiMFwmHqbrK6vsESUlpaAomSmnzdiCA1fsOPLuikFPQBadDrZ6Ueng8ZBtrj7CHy+Qf
 AQS02OKv5Vn3dT/Rycz+kC9gR1cIBvJzZGi9Ci2PcbuQ3x/GSuGSGjiHgoJ+d4PYzVj+
 zxhw==
X-Gm-Message-State: AOJu0YyJLWSRarwteKC8od0a9cvoMk/c1vc8LEn+dd9bLN6W5bqKhmZt
 oghFWCS2jzv+y6RSvQknJ/iUxLkApdbpj/nFQ5nUmJ1ZhJd4jI8En/H3FcIzCDUhpK2DVQxv/t4
 DFszcjY5C6iOtwoM3OhoToWB0yQGrZkBSksvtUU9/GTBE8zAU3MuY9ult26DVzTRkt861kvLQ7K
 4U9t8hbRcmdojC/Wgqaa2nWpOsyMdrwReVXg==
X-Gm-Gg: Acq92OEwLXbm2unxIkWTSSd8v4Lk0ktdrC74FbDnilIepLJ9P4LO9fLG0HKcGERcDyt
 pEQPCPnrgcLEE6//xA/l8mHaisHRqeZCaVzgSTdv4pzT25S1qG99UVvKZHGyejUypAchHqJsq9u
 LBM3P+og/Cf/Qm3ZpCZpZ+ZGEUiNBE2VLHs/I/9dxaqXNvYOy9YaPNIH6ZEZuarRDV1hWJsqnJ9
 65ioOz7H4KhLySq1QG7oWzu3cAhLpopzq95PWnHz0Ay0vt73Xv5b9ANwZa1FeShA/gsrt5VNlYx
 vlhGW19HwOMZY+6P+pZG33FgWUduS+nWwPeYR7o46rSfFBGgl4Oft7ZO6rblbKx/u6IcQ1aX+Bg
 HfKbtQ9jOC1Qb5cIaYC78gJGvs4ouUdSLeDbyweGDp9g=
X-Received: by 2002:a05:6000:400c:b0:45e:9115:2982 with SMTP id
 ffacd0b85a97d-4606dba784bmr15552793f8f.34.1781464166444; 
 Sun, 14 Jun 2026 12:09:26 -0700 (PDT)
X-Received: by 2002:a05:6000:400c:b0:45e:9115:2982 with SMTP id
 ffacd0b85a97d-4606dba784bmr15552757f8f.34.1781464165923; 
 Sun, 14 Jun 2026 12:09:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm27253629f8f.37.2026.06.14.12.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:25 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 088/106] tests: acpi: x86/q35: whitelist new WDAT table
Message-ID: <c42b3b6ed699148b5b245f23408d2c6277d8941e.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260303092532.2410177-5-imammedo@redhat.com>
---
 tests/data/acpi/x86/q35/WDAT.wdat           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat

diff --git a/tests/data/acpi/x86/q35/WDAT.wdat b/tests/data/acpi/x86/q35/WDAT.wdat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..14b680debe 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/WDAT.wdat",
-- 
MST


