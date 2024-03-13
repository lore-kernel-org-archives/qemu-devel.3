Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIRp-0005CU-CQ; Wed, 13 Mar 2024 02:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkIRP-0004zU-1s
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkIRM-0000PL-QM
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710312615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Go8QLI9gQbXmyhHkKz0PaJ+v3qPiC1qNd2rnvX58eMk=;
 b=VvlMkY4byWW6X5cntDvjNZJgGxcjhk9qTUi8cVCxrKvoTPffJXy+62hXCVLZfd69iHPZ1+
 NgRIK/HNMo50JpwFVeGNzxU1mtyyGFQSVkJAsZYC8BUllWcJJZS4xTNfRzo9MdMsQz4kyq
 KCxuZ8WAHvmevb3zlKUMR3Ef13NCIw8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-9sDuPv4lPVKxY2nr6F3VeA-1; Wed, 13 Mar 2024 02:50:14 -0400
X-MC-Unique: 9sDuPv4lPVKxY2nr6F3VeA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513c65ffba5so846829e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312612; x=1710917412;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Go8QLI9gQbXmyhHkKz0PaJ+v3qPiC1qNd2rnvX58eMk=;
 b=LteX6oyC7fa/qtgAqAzMu5VZsAfreW5ET4ytj4em5pwJwDcJJ/IIgmCdGj1Q2cLR46
 v+4A0le7UwhLFaP9lOVsQQ+zj5SvAf+to1YJDGNGm540uaZ5fbPPm2mhL3cnkgSykgo7
 7TKOo8OVof51hlMDFG42KiP0EXSlU5QUhmI8TbpFafiOF0WwVFiqmjgL+nJ/AV0U9HGy
 9LDP2z7mmAUgw6qNqlGmaHP98O/amzJAGlbgPGKOXH5CqVmH+5H+Q7JQD0CrGjgoFgxq
 R1a12Ho7SI6SHHkkN89NF3M+/sJg/TZWXV+8ET9emgulwOiFpHfoNifbf3itky9SpQWX
 K0Og==
X-Gm-Message-State: AOJu0Yw4HWnMISztBzgtrPnmD0IFEH8tJibtEcziPwRs557yq8PJtrT1
 I/BA872DtnHoG7YyCdRygoJ5tZAsRtnjfYadDpQdwKjzmEpcEIyg8Grw3fkK3updXpYtbVEn5xV
 ES7VP7xuYcT2yQqT4sCWnezL3EKdekPW8Iy07CMXk3L3X9ALHYULlbg8x04NsVi3oEpFUAHjsn0
 eKTXHF+tlIzRSVTi1ugDF3wcFJiO9ZCA==
X-Received: by 2002:a05:6512:694:b0:513:42e:ddf0 with SMTP id
 t20-20020a056512069400b00513042eddf0mr1877926lfe.36.1710312612157; 
 Tue, 12 Mar 2024 23:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbn0IFcHLdFd1xpIywrSkAibGWg2Y8/3rTZqYlZGjO0HUz33f5sxTLMUVzDgcAT+DcXKD1VQ==
X-Received: by 2002:a05:6512:694:b0:513:42e:ddf0 with SMTP id
 t20-20020a056512069400b00513042eddf0mr1877902lfe.36.1710312611612; 
 Tue, 12 Mar 2024 23:50:11 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 k37-20020a05600c1ca500b00413e6c56faasm1252864wms.41.2024.03.12.23.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 23:50:11 -0700 (PDT)
Date: Wed, 13 Mar 2024 02:50:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lukas Stockner <lstockner@genesiscloud.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH] qapi: document PCIe Gen5/Gen6 speeds since 9.0
Message-ID: <7a27998637b347c287b6a1c1394669e2769fa8e4.1710312598.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Document that PCIe Gen5/Gen6 speeds are only in QAPI
since 9.0 - the rest is since 4.0.

Cc: Lukas Stockner <lstockner@genesiscloud.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Fixes: c08da86dc4 ("pcie: Support PCIe Gen5/Gen6 link speeds")
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/common.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 867a9ad9b0..7558ce5430 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -107,9 +107,9 @@
 #
 # @16: 16.0GT/s
 #
-# @32: 32.0GT/s
+# @32: 32.0GT/s (since 9.0)
 #
-# @64: 64.0GT/s
+# @64: 64.0GT/s (since 9.0)
 #
 # Since: 4.0
 ##
-- 
MST


