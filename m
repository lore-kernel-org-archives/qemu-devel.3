Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6266C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59H-0003yu-SC; Fri, 13 Jun 2025 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ599-0003sw-3d
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002Jw-Nz
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeJM+ShIS0TMolEwKNgTvE0T6ihxo6U4DD+hKUlZmKc=;
 b=g+ZH2WZLFYuMggC3WEVsfTEfveeKbN+hECxtcawBF8P7FnlRKvJs++GaXMw6HvXzCuEF5H
 bTr8YwDt3ojbDxFigesx9V0EwgpKfsTagYiizpRJmIlUpnZybnujz2r9zY6rIUO6GOgYvY
 0UPssbbCosXnmLqs1PYd/rHQx1yw0mE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-viFtTmpMPeiyjexH-B5zDA-1; Fri, 13 Jun 2025 10:12:34 -0400
X-MC-Unique: viFtTmpMPeiyjexH-B5zDA-1
X-Mimecast-MFC-AGG-ID: viFtTmpMPeiyjexH-B5zDA_1749823954
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a58cd9b142so38804421cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823953; x=1750428753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeJM+ShIS0TMolEwKNgTvE0T6ihxo6U4DD+hKUlZmKc=;
 b=QWKp8NhKfFySGph0Ngua7EDpSf5vyv9+ufcd4RFpw92cINm4SLOkT4lKrWcO4bHm0H
 0d8cRpqZFSUa5XovcY9QRd75S35tAuQlXfIxxDf+WKJg/Rvf6URMiULsmPePscCVDKz8
 sUQuwmunU8SYc+TNnFwcNpBDl6sb0vfgw77ME03cgS44DyQX8CMvd2u7Y3NK8HLui00W
 2+FKBW3LujKprEfeJ7SIRMwBdefpRoH6NbCCJLtqZfortw/XJtO3QI1dB4EHv7PcIDM1
 9exmY9XDkp103DDcBDx3mQCWfY8OQieT9ki/cy/miPdixjMO01eWbL7WOLcZdoNx8PrU
 T/Og==
X-Gm-Message-State: AOJu0YyDtxCINU7Oa833IycA6SfdXnyML0TxnW1EWIMZmWpM33Us8ao9
 gtPDoYFQWIjePwfFkFpuXX22DWVSVc24LSfrsPUDR+rXAu2S65i+PUocZ0Zhxi+lqNOiqiNAv8I
 7ilF8kX7eDMHeW+Mw+T2XyYLrlTSrtxEcJxg7qQJxOZrgdGuZCtu7XGO8g1fqHg0rUNHzilPPfd
 KLv1se7uZwnxEi9fVSL4G62EHAG7/OYVUULaeuJA==
X-Gm-Gg: ASbGncvDXayh3lLYbldBQkT8hVZr7GLlh2gO6LivWnD0EHvQnVFzYxgIO6SdcWLjsCz
 e2rp8DkuhKhivmbz5I1mmhP5rdk3YX7tvXHsr6NUALrcq7+rT9vi18Y2g3kqaNraHr7nmlinx/+
 cCFCpUCm7i8P13xMFSA8Vv188kNNmgRZqOk4B7bcI2WjYZ92/RYJufeEqFelf772zcmgEPYB4S1
 1U1+zku+LEsyiSMyiGbmH2f/vldI7U/64ZEXRbq8iq0LRmHD2XRxQLfTBFZAoV3ObqGePVr1fqF
 DGBF+qtqlWk=
X-Received: by 2002:a05:622a:1f1a:b0:4a4:40a5:f789 with SMTP id
 d75a77b69052e-4a72fe5b363mr39878521cf.9.1749823953427; 
 Fri, 13 Jun 2025 07:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl6RIW8wR3NoPg/iqr74ECaHamdyhKHALQCdE37d/SZZ+TMKk1ufUGgq8slysL/5vDDWLWkg==
X-Received: by 2002:a05:622a:1f08:b0:4a4:327f:1d0d with SMTP id
 d75a77b69052e-4a72ff366e3mr57631591cf.30.1749823941582; 
 Fri, 13 Jun 2025 07:12:21 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 01/14] migration: Add option to set postcopy-blocktime
Date: Fri, 13 Jun 2025 10:12:04 -0400
Message-ID: <20250613141217.474825-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a global property to allow enabling postcopy-blocktime feature.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 162c72cda4..4e923a2e07 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -187,6 +187,8 @@ const Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
                         MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
+    DEFINE_PROP_MIG_CAP("postcopy-blocktime",
+                        MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME),
     DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
-- 
2.49.0


