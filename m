Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD415C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDJ-0008OF-0z; Mon, 09 Jun 2025 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDG-0008LF-Up
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDF-0004TX-1T
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fky2C5XWssldCauVD5W1cOCcRd8P/NgdIIozgxtj3dI=;
 b=hoIoHBQWk8f9z2qTZeeADIG9FLz1RMYuDxXFLsZCEAZ9jOEFLccTIBsmZpVs4dFzzYTDPF
 VzHCueD+nVNA2hYqVpFQrMe9NvlgwCAHsBRDu+Ppx5pFQQcipNXWxNmGxR4FKxOmTfDvJr
 MjWFb4zvHskSaAJt7d3ZU9l/Zswn4sM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-MSV9l6TDMfGIGLpJWX0BjA-1; Mon, 09 Jun 2025 12:19:02 -0400
X-MC-Unique: MSV9l6TDMfGIGLpJWX0BjA-1
X-Mimecast-MFC-AGG-ID: MSV9l6TDMfGIGLpJWX0BjA_1749485942
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fad1f7f175so77166316d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485942; x=1750090742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fky2C5XWssldCauVD5W1cOCcRd8P/NgdIIozgxtj3dI=;
 b=tv6J7kwc8f7c21yYkpi4ZhcULcJ9a8eHmwtyhJLmbB4m2prdRbh8e51tgpC9zBJUOX
 mGqA8UpHPFIytJF9Mpc/VB73fA5f7dJvVEiKgNLhJFPvCQSK6EaJKLxt4jA5kF9oY9gH
 UgiRqairXGLtKhinb4AHeVgPHl7C6++9nVIxnpOSdMwaCJWDfMER9XLKEE+3Ofkjg4fw
 yCfLzt9cI136S/y3NSsl2JXYeC6kHp3Ksempxl7BbCy6t2DyErBlCtXvVXNYRuMEO2vp
 a4j3ZgCOPkmEC5QQBBSEpVetj1iSQX+xsYLgUH/vZANPbiTKc7wVcvWxNois9VgvhjGQ
 X8ng==
X-Gm-Message-State: AOJu0YzzVWXHI/xGjtgzj/UuatGeh+4idQtMTI2RQOnRgO/OPlXyoXoj
 RH2M5UK13QMmDvuPRn454A1jrIKQEJS1pKsuQFx3ZRwhdHjOf/2/m94roQ3dENsdDrWYgTxnT4/
 T3KsbSb+v5PM8ZCjXUAmN7u1ySnu8er0dtkQMo3zJ92rfTh0BMnDSslP5WTL+Elb8OSmzZ9M1dk
 PPizLSm8SmKblulKWgm8ZfBQgSDcvJf70oCxU4yQ==
X-Gm-Gg: ASbGncswr6hS3nsDWE9dWTn9gkvLiidGDZz+ir8lf9JZCbDf/ybAGRPX8rTSbuDoC88
 lXALVfEMLSX45s6h/NKGNM002+92AcBuhgec9teMIWzUR2AkygYqH/DO3gJEDlxYEbXA4QdXHfN
 zHy0mKpPHVfg9i2QDEMrCN3EZj50ZLt/JMd0usAAprmeqvHxqSe5iFDdzWMCb00gkkf/E0BRFsI
 LW/gMGtFeqv0vFqALEwG4P+dDpgNA7yAxq0uN97czqf5w/UABfSZheEqoE2QvPQL24lsTwk3fOK
 PA8cD60qMnm9wA==
X-Received: by 2002:a05:6214:2528:b0:6fa:c5f8:67eb with SMTP id
 6a1803df08f44-6fb238f9aabmr2669786d6.7.1749485941736; 
 Mon, 09 Jun 2025 09:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcP18+WsNalRNu2/tcyVRidhsxOvxsTs15WXoURMIAiJ3ayVC/WnWpRosa/qSCncq3O79cOg==
X-Received: by 2002:a05:6214:2528:b0:6fa:c5f8:67eb with SMTP id
 6a1803df08f44-6fb238f9aabmr2669146d6.7.1749485941234; 
 Mon, 09 Jun 2025 09:19:01 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
Date: Mon,  9 Jun 2025 12:18:46 -0400
Message-ID: <20250609161855.6603-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
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

Unfortunately, it was never correctly shown..

This is only found when I started to look into making the blocktime feature
more useful (so as to avoid using bpftrace, even though I'm not sure which
one will be harder to use..).

So the old dump would look like this:

  Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59

Even though there're actually 40 vcpus, and the string will merge same
elements and also sort them.

To fix it, simply loop over the uint32List manually.  Now it looks like:

  Postcopy vCPU Blocktime (ms):
   [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
    33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
    40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
    22, 3, 0, 0, 0, 0, 0, 0, 0, 0]

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 367ff6037f..6c36e202a0 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -208,15 +208,19 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_postcopy_vcpu_blocktime) {
-        Visitor *v;
-        char *str;
-        v = string_output_visitor_new(false, &str);
-        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
-                              &error_abort);
-        visit_complete(v, &str);
-        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
-        g_free(str);
-        visit_free(v);
+        uint32List *item = info->postcopy_vcpu_blocktime;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
     }
 
 out:
-- 
2.49.0


