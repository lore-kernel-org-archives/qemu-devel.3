Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3036C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDK-0008PY-1r; Mon, 09 Jun 2025 12:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDI-0008Nl-AE
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDG-0004Tr-NF
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT+PxuMKRJ8Bh39RMhUF6/Cm7/wGAILL/wn1CqdT0Rg=;
 b=a4Zl1/voEKwusfZoWVJyU7l/YT1ltThnZerVFOt68eSm4Xey4sCumwKwvolwww0uzFyx46
 ZrT/Nvh75CQ2FShNyB+x3aRNfzzkTwVpBH+L2iGP8Lnx1xHFgUqygOI+Z4lflcDl33ceQW
 fP5rdC9GLC0hhljxv1EeSGK/k0m1y20=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-0t6EcvsZNwWYUL2edn094Q-1; Mon, 09 Jun 2025 12:19:04 -0400
X-MC-Unique: 0t6EcvsZNwWYUL2edn094Q-1
X-Mimecast-MFC-AGG-ID: 0t6EcvsZNwWYUL2edn094Q_1749485944
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fafca0971cso80309806d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485944; x=1750090744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT+PxuMKRJ8Bh39RMhUF6/Cm7/wGAILL/wn1CqdT0Rg=;
 b=jO3eWxAMMcyl6TksAmbAMv6B9kIwkY8Wnx4kvq5cvys2Fp9yviPmzHWgOhOIPR25EQ
 mEQgqz8kZP5+QuDb1UcdRaeFD6md6pS4a3pTvQq87jSyxVcZOPsufYsG8H9yzWgnl1jj
 kxM97bikpzi/cgtaAjaRG8yfGaaxsRo9hYCN73J3aMLOltYhJLk0NWSqjogejNcjybKg
 yImSjj9ttMU25WIb0vda4TED2Yxju9/o/417i9agV7rQ+WkRBortIb0SnpfWDUICr52j
 Sz0K8+1kW9h/5Y5jgFK7g51RaqMT179PCkoVA8jgv0SITMxH2Vu+hdQAGNHorYW6jg8r
 Ootw==
X-Gm-Message-State: AOJu0Yyf7/U9RYrdxSC2usCPWIGVtOX85kKqmSI2d1ch6Mf+a2PKWqa6
 qVIbERW+w+FzJ3xITcYZ7u1OptMy1R6B6rktsMRgeMcNKwL3yk9ZZh0nlIcWhhjTrVD0DQf8C5z
 tNH3adoCVAwuuLuf/RmoXAYvMlVQY4gl/Kzfvv4UOW2g2YWs82Nxj3+gR9XSLC/zERfbYEoI8Hu
 L9Hj+vtLccxqZMXFf7EDNp7cf+Em5jcdLtciiZ9Q==
X-Gm-Gg: ASbGncuAzgtpGV6frjAhrZZLYDpcdYuuzr5idPDBGXCy1aWLmeJsoaWphhVh0vwNlKe
 m6XqrUx49zOANbMy38FY/Mv2MV59fnWvWoAgFGxgzaauxAI8Ak95O91GVqfdNOPbeDqXaq3Kgi/
 wqY8ZyQd8ua/Zn/8RbRiNUdcydDd0wRvcEyr8G3fO4f2Hznst8zFM47b2FoyJh1+vtbfkKl3vJO
 KurxPJyFfmICn+x9q09Gt4q4QCBq2/MS4zUvPh3IycJeh41SXWhT49114RVjtM0lGWScv+ZjIKa
 hCo=
X-Received: by 2002:a05:6214:226d:b0:6f2:a4cf:5fd7 with SMTP id
 6a1803df08f44-6fb0903f125mr234169746d6.45.1749485943713; 
 Mon, 09 Jun 2025 09:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDFAtJ+oIhAKqZO5TOGwU7PZ0gt7EFwbL5stBG87K9+9yyZkIljqZxh9TQMb703j33haU+xg==
X-Received: by 2002:a05:6214:226d:b0:6f2:a4cf:5fd7 with SMTP id
 6a1803df08f44-6fb0903f125mr234168816d6.45.1749485942879; 
 Mon, 09 Jun 2025 09:19:02 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 03/11] migration/docs: Move docs for postcopy blocktime
 feature
Date: Mon,  9 Jun 2025 12:18:47 -0400
Message-ID: <20250609161855.6603-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Move it out of vanilla postcopy session, but instead a standalone feature.
When at it, removing the NOTE because it's incorrect now after introduction
of max-postcopy-bandwidth, which can control the throughput even for
postcopy phase.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/postcopy.rst | 36 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index 82e7a848c6..e319388d8f 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -33,25 +33,6 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
-Blocktime is a postcopy live migration metric, intended to show how
-long the vCPU was in state of interruptible sleep due to pagefault.
-That metric is calculated both for all vCPUs as overlapped value, and
-separately for each vCPU. These values are calculated on destination
-side.  To enable postcopy blocktime calculation, enter following
-command on destination monitor:
-
-``migrate_set_capability postcopy-blocktime on``
-
-Postcopy blocktime can be retrieved by query-migrate qmp command.
-postcopy-blocktime value of qmp command will show overlapped blocking
-time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
-time per vCPU.
-
-.. note::
-  During the postcopy phase, the bandwidth limits set using
-  ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
-  the destination is waiting for).
-
 Postcopy internals
 ==================
 
@@ -312,3 +293,20 @@ explicitly) to be sent in a separate preempt channel, rather than queued in
 the background migration channel.  Anyone who cares about latencies of page
 faults during a postcopy migration should enable this feature.  By default,
 it's not enabled.
+
+Postcopy blocktime statistics
+-----------------------------
+
+Blocktime is a postcopy live migration metric, intended to show how
+long the vCPU was in state of interruptible sleep due to pagefault.
+That metric is calculated both for all vCPUs as overlapped value, and
+separately for each vCPU. These values are calculated on destination
+side.  To enable postcopy blocktime calculation, enter following
+command on destination monitor:
+
+``migrate_set_capability postcopy-blocktime on``
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+postcopy-blocktime value of qmp command will show overlapped blocking
+time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
+time per vCPU.
-- 
2.49.0


