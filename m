Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76589C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIIe-000745-2k; Wed, 14 May 2025 16:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFIIU-0006tI-QI
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFIIT-0003Z7-83
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747252903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=im9GTe+XANPevvqEKchJYT4QQTHDvCgcK4V/4tNOw7M=;
 b=FOPdHpnlPmX5Vu0FGM5h8faDdyY+Pf65LHrpYhWYtsrznB0lw6AYmAzcmMxYfMwF+FdG+3
 U5P4vsscF/6sd/pHVl4BhitmJPMn95SAoGYhYGZYvin0BZbF0LhF+/+bUqal+p25I36qD0
 0jc9Irib8SjbeskqBRKOVN/FNSSuA9c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-0ObCmJOzOQ-5E9w7EDkc2A-1; Wed, 14 May 2025 16:01:42 -0400
X-MC-Unique: 0ObCmJOzOQ-5E9w7EDkc2A-1
X-Mimecast-MFC-AGG-ID: 0ObCmJOzOQ-5E9w7EDkc2A_1747252902
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f54032880aso24665366d6.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 13:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747252901; x=1747857701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=im9GTe+XANPevvqEKchJYT4QQTHDvCgcK4V/4tNOw7M=;
 b=NB5V3jye3e/VyCFZtY+DeWtBPZalNvq6CZZPqgSZ7R66GCH7UY4LYKZqZQ3bLZMYdj
 HNpUqG6qUihC7EPX3AvB/04t/c1HsBH4noR5/kyjffgAFVD0dTh5rEQisVnCRAsF39zE
 bjtfMgRpwzBYHJwK9DiDgIAXm/8NC1TG3JlVkzsDmfzlUyRNnr5nkS+Pmo1mjeqoAjdO
 1eGtDHmHgkJVeAMGLTJ4Ylo0jWgdyh1DFZ5OXZFpwUUfhXmTY9j3RuSmg+31hIowTREX
 0aScNfVFQVvw6N1A/SNJafvmdivtAXTl4R6/F2r3mc9HmOAc2eR5Hpony0K7xVrlTFll
 6mwg==
X-Gm-Message-State: AOJu0YxnjJUHdeHZ66i6jMw3h51AJA80gQKBxeLgP8jeSQMPjAQO78BN
 g0fU5CDXc30GqwExykgSFS8uh0xXCnd6IK9xpcPwKSVvhl6ppjI4VhtpRpRKH4e8N2jkMw6o/U2
 DGjvSgqpccBO/Lyh91K3LzpVUulFhyjKwi/s61d2g5tgsh87DdWeZNRNvCwo6TUMniRd9KPhdzC
 1GEWtcGcnAFt/iC3T6LpOs2GoYEE1wqm35vA==
X-Gm-Gg: ASbGncuzGDcjottWgZjPb6HRK00uxFP9gYaG9VqXp68F9zQoqbuEGnr2tvoxzQLr0yp
 yJhEH642jxvINlw1lddSHGU1AhohF/WUWsi4Pd+1nBnFx5mcqUI9aZHgrcZPR2D12nfzLgzgYnM
 3wqXk6pzCWN9y4Euky/xu8cs0I18D/S6wsUD/C+iOVuDhxDRFtQ0PDla3fy0yMZdfSn03tCMofE
 3tpghbF2Kx/OKSLkfb0OyBWoklMcoE8ivKyksfWgrwBSBI1yV0WC5xyw8otPg3PkA9Yrhg+XTVN
X-Received: by 2002:a05:6214:1254:b0:6e4:2479:d59b with SMTP id
 6a1803df08f44-6f8a31e9146mr14770806d6.16.1747252901381; 
 Wed, 14 May 2025 13:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeVtjkz64qdDNdgQ6gvVhE+8ynRZQnCMdKo2Bzjfe9CwIntviveJcpdAileNH30PIg9OkAqA==
X-Received: by 2002:a05:6214:1254:b0:6e4:2479:d59b with SMTP id
 6a1803df08f44-6f8a31e9146mr14770076d6.16.1747252900746; 
 Wed, 14 May 2025 13:01:40 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a524a6sm84979066d6.104.2025.05.14.13.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 13:01:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 0/2] migration: Some fix and enhancements to HMP "info
 migrate"
Date: Wed, 14 May 2025 16:01:35 -0400
Message-ID: <20250514200137.581935-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v2:
- Dropped patch 2, dump globals only if "-a" in the last patch [Dave]
- Keep using "Throughput" for dumping ->mbps [Juraj]
- Rearranged some more, e.g. put xbzrle/globals under -a too, added indents
  for the global dump, etc.

Patch 1 was a bug I found set capabilities, so it's pretty separate issue.

Patch 2 was an attempt that I made the HMP "info migrate" looks slightly
easier to read.  A new option "-a" is added to request a full dump,
otherwise only the important info will be dumped.

Comments welcomed, thanks.

Peter Xu (2):
  migration: Allow caps to be set when preempt or multifd cap enabled
  migration/hmp: Add "info migrate -a", reorg the dump

 migration/migration-hmp-cmds.c | 186 +++++++++++++++++----------------
 migration/options.c            |   4 +-
 hmp-commands-info.hx           |   6 +-
 3 files changed, 101 insertions(+), 95 deletions(-)

-- 
2.49.0


