Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7741BCCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHIm-0008Cg-Fj; Tue, 21 Oct 2025 14:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIl-0008C6-0p
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIi-0004OC-F7
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761072098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9DE36dxziLFDQNLe7vrgpXeBYJ1Q3MmkPMcApqBkfZ8=;
 b=HJjgQyLTyng1sX5N7voWLMsjWQK+T3bsADnu6EtbehaHbDGYCxxrmCHsFAsETrejb+ntoz
 a+EnVjE2TAS7coZHzQHV2ElZ/Ym24L8IJaKFr4GnDfVthU5k6AMaxsRO95XuPgoVuqhrGC
 q+TzIbDU3nX6cXXyCKDC3BU7JNxg6es=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-ZBotqlrIOnqV4zT3BRS9Iw-1; Tue, 21 Oct 2025 14:41:36 -0400
X-MC-Unique: ZBotqlrIOnqV4zT3BRS9Iw-1
X-Mimecast-MFC-AGG-ID: ZBotqlrIOnqV4zT3BRS9Iw_1761072096
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e88947a773so10820511cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072096; x=1761676896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9DE36dxziLFDQNLe7vrgpXeBYJ1Q3MmkPMcApqBkfZ8=;
 b=dcziUeT27YIOvNAxeTNWOHCX3vEipwIpCqKqnxGGTntGvEFfb5uW1RVAyOuCR5HhIF
 71Eivb06gOhsurkDV5Osw4I6oqO59X0s7owc9I3EIOL6EQ4i9MnDdGSpo2cANMvxKFXR
 3gmE0lOzD8T8kqq/pYefnzsMjj/UKSHcDSevEhSAGm8e+rBl4qT4HtL4Mf3bVHzGtIvg
 Jwu7zUHt4vXcuYqeb3sK1tlRzLrGxZwyszwyuJxfuzfBhDbCZo0+ejLmzLHIh8HFEuzw
 A33UvvsxAofO+Ys3cLDYCfQN9IxqiRLqTNZEY0liAZ5cM03z5L3AqDS/SEYae7msAafz
 EhJw==
X-Gm-Message-State: AOJu0Ywr7qJzbuhEmrIh2qnL1kmVSgnyN/LJdIrVgNTn6aqWVXV4b6ff
 qt/VrlMaB7FnAof3lxowTHi11FJ1ugZAxCA39WjbE13WZt9+nEo2KkiruzNvST5fx3epeIF1bbr
 STlZCi8iVa+9GSgZO8pGAy/mQGctB0z3+NtC2DJbUbuhosuHZW7qs2PgZ9kv2V6QF2u8a84z7Wm
 8MkgGBqqCJ3xWnpV3fRt7byE5RJdCjvGrkE0Z/0Q==
X-Gm-Gg: ASbGncsiBbqxWSVj7Ibq33PYyVjx9nQ4VWNvzzSFem1PYIo7LPWAWEVV6Uj7FVMyNG1
 8zGZNOcQQaUUvZCPHL+W7JEGq6utjd5THXL78ty9D/m47oB17R27/4OUO0vWa8+ZXVJPgyCQbvy
 SKedu5or9R6LE4kJOHD9rC9vo4wzm9r9fPrsm9cpZjFggqVQhu34xviifQtYtOL9wj3+Ob77iNW
 BZjASj7CZyZN9nkrr/Lmlw9BgfNNwEhKMM1K7eKkQ+V4uJxYitWI4SOkkgH4UbuJdCqkcrwsCu+
 dy0UDpRCFjVq2xEEAv/Acfjezl+6qQth/Piw+uBc97ndN5TLcnGK/mUAdq0l7gK0
X-Received: by 2002:ad4:596e:0:b0:87c:2329:9b21 with SMTP id
 6a1803df08f44-87c23299c32mr261956156d6.55.1761072095728; 
 Tue, 21 Oct 2025 11:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ZtkpvTQv9PfS+DXdRka5OPDM3foXxxwE4uBkGbiNOnT0IgCtmf0wfHaSKV+idDQOUXdkjw==
X-Received: by 2002:ad4:596e:0:b0:87c:2329:9b21 with SMTP id
 6a1803df08f44-87c23299c32mr261955776d6.55.1761072095246; 
 Tue, 21 Oct 2025 11:41:35 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf51fd3easm74244966d6.10.2025.10.21.11.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:41:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 0/3] migration: A few fixes on coverity reports
Date: Tue, 21 Oct 2025 14:41:29 -0400
Message-ID: <20251021184132.2635958-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

A small series that fixes three coverity reported issues.  Please review,
thanks.

Peter Xu (3):
  migration: Fix error leak in postcopy_ram_listen_thread()
  migration/cpr: Fix coverity report in cpr_exec_persist_state()
  migration/cpr: Fix UAF in cpr_exec_cb() when execvp() fails

 migration/cpr-exec.c | 9 ++++++---
 migration/savevm.c   | 7 ++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.50.1


