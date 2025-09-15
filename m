Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CCCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBgb-00070N-G5; Mon, 15 Sep 2025 12:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBgL-0006og-JZ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBgF-0001ZX-It
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757952223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TJx7K6GnlFWVWEx9Tw/jFNFzzx4h4KWFrMnTIEk2YMw=;
 b=I+Ic2/vBtbBU+aEUWo41htDL7+obvLAH9jN/Vt40d7ssS2jBFoj/ktk+2JXn2oiMZPP7/e
 cXTWFGb/erpERG8w5JIULlKjKdVhEvBXTsEoG3TGRy2XLJZPzFFo/0lizGIXCLL3BFCvzl
 1CT3ZxMIM5WNxE8rGsVAsyGn7i9b1ik=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-Ri2TDAYRN5CGIuSGto2KRw-1; Mon, 15 Sep 2025 12:03:42 -0400
X-MC-Unique: Ri2TDAYRN5CGIuSGto2KRw-1
X-Mimecast-MFC-AGG-ID: Ri2TDAYRN5CGIuSGto2KRw_1757952221
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-827887699easo486245885a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952221; x=1758557021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJx7K6GnlFWVWEx9Tw/jFNFzzx4h4KWFrMnTIEk2YMw=;
 b=biamrCyzNS+pWv6eUJ0iXEWsW3gkWArqmD93FHlon7+D2ijC0YxDjJ6ZEHO1qe2fOG
 MUZUGhupjSYWrhrakQfGW4Q3VvDBgA8U4E9eGlmTPuycVUewseqj3w5oUtvHLwMdg6AP
 O0SO+cZ7xWqY3ubKqZ1q/b0poJnTw9a8/j1UUmQAH+YUaZEdWZdh/LkUZBgX4tCtgAT3
 89+mPdpQnEO7UZmWGAIyOE0w9ApBEo3FXYUZJOlhJIvBQ2QQ86ntSHCDbn8pjfyrub+S
 2ai1zkOp0WhEEOdh83NDQ+HLPEL4iCXUIK91FNjC0LtIf83XEiZwvNDf6Pdm5OBr5qEf
 Kmxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTqXq/2lKiT0FMmQCGoatY8smeurlLdeiaJabPi+rjuR4kSzqnrYtIDqGbUE8KNG0YVasgEwFu8NBx@nongnu.org
X-Gm-Message-State: AOJu0Yyy8dnF1qYGiqyV1xhr/96TBWyh93raaKymHFWOeIun0tZ4kMYH
 6lmIO/tA4njNZg3RXlfV5nlvIr7VNQGdhX28zbvDz9A5vDz68U7jsedZegf9Xq3ngkRjQuZaB0d
 sEU+I8hZlcu3HehBlvv//Ws7d/MuPGpj1LCXN8RZE1gNbNsZyvJe3ftFe
X-Gm-Gg: ASbGnctrUs8hTx5locIgoZvIrd145HVtFAtZOQdvw+wbNuAraxfDnAtEgeBVrgPLz2u
 ReXXGjMwSL60hq7mFJFYHX+Pr7PzfGmF+//EvH2zYoZnQZ66Gz/QIU97uoOvY5kZcSQanpkQ95M
 N8c05IjtxzIoeM6iLtDl/Mm0Yj5E3hRatlJQbxqaSgSjEQSXc0aQ2mjrUI2hrrNjtZA8qR7ecKQ
 haD2ETTnoGs7k6dfWu3obsxzAubwCNVG+bnorJ7k5Nxm4KX6xwsub5LcfXr7FIoClu4juY4KRmL
 U5gRwoioDQKAff/L4c/EGPDDbqe9fQ==
X-Received: by 2002:a05:620a:4003:b0:824:6f4a:6e28 with SMTP id
 af79cd13be357-8246f4a7167mr1590443385a.17.1757952221172; 
 Mon, 15 Sep 2025 09:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0/NvguET1db0ieJAaJQ8vpGs/J9e+nVTKRB2tWQ7FsHG8z2a3PNXtLkzpthe9zDNeSwhr4A==
X-Received: by 2002:a05:620a:4003:b0:824:6f4a:6e28 with SMTP id
 af79cd13be357-8246f4a7167mr1590436485a.17.1757952220514; 
 Mon, 15 Sep 2025 09:03:40 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820ce19e020sm796565385a.52.2025.09.15.09.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:03:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/2] Mem staging patches
Date: Mon, 15 Sep 2025 12:03:26 -0400
Message-ID: <20250915160328.2080723-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:

  Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/mem-staging-pull-request

for you to fetch changes up to ac7a892fd37ce4427d390ca8556203c9a2eb9d38:

  memory: Fix leaks due to owner-shared MRs circular references (2025-09-15 12:00:12 -0400)

----------------------------------------------------------------
Memory pull for 10.2

- Peter's fix on flatview_access_allowed()
- Peter's fix on MR circular ref

----------------------------------------------------------------

Peter Xu (2):
  memory: Fix addr/len for flatview_access_allowed()
  memory: Fix leaks due to owner-shared MRs circular references

 docs/devel/memory.rst |  7 +++++--
 system/memory.c       | 46 ++++++++++++++++++++++++++++++++++---------
 system/physmem.c      |  4 ++--
 3 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.50.1


