Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B657606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=YL04EIsT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvTj-0002Xh-SW; Thu, 05 Nov 2026 06:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xOvTh-0002XA-1B
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:17:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xOvTf-0002jz-64
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:17:56 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so14705385e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793877473; x=1794482273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dKE1iy4q4bVxBqnKfqy7iaPOa+pvGElBkWoOSM4nSss=;
 b=YL04EIsT6JszHKc0x1fYjQkycncWlaTixoWbxjdt4H8LDqG4k7UKaDb3K+5BUc4FAV
 6FDfjp7+rdCtF+niVkx2f6HRD55x2NxGuJkzWEEL65xDTgaxr0hCzKV6egI7hvEtjslX
 g8RQ7lR4t+aUoVRantUangPH1WRATitBwWILsxH3S9ZFX6V2JpECFNytrMkG9oSTfJg2
 ebCklsZn1kqvIo3KAqbtQMAeRgEBQHxnyQCGYaXTdTgDB7bowuf/9K2N+GskAsMa8zor
 fqZhpacildIqKGKf91MrfkpckzSWt8uz6gp09i0J29Mc4qk5nOvFDtqSzLD1YcV2R85q
 UM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793877473; x=1794482273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dKE1iy4q4bVxBqnKfqy7iaPOa+pvGElBkWoOSM4nSss=;
 b=NY5GFNB+SSFg+JIR+8H/xs0RT48Vass9z9uXyHibG1T39weKT1hmHYjqSpV8qqm5d2
 Za16UM0BhPKBNkKdcY+ryn07nKa/S1vfufVaVIL8rQOlbcrZ1qr/SyybZCqkd4wi5QP5
 y7K5s3N54AaQM6QOakRFzburVlvzHykYx7jKtQzFYJB1/Ul5uRYF2fd94fw6AHPvQ9ns
 OcAiTgkmCmwPwbN/fy08n/xRngECdqxxl8mscx88OlerZPw5AO/+E6++uz+RxIa+3fvN
 AYL8Rxu+5Vixqws6LuXZkrApDjSTIBRAxKaBuWWMmm7isTGcGIjMGivH/pTzOkywIm5G
 V5CA==
X-Gm-Message-State: APuU4Z+wyaSRJhhPCgwFlDFmC1ZpU78K3YxGKCkCLUY7S0A2LoO/+9Aj
 wbmfTzfw5zBCkUK1XhJUzDi3MJDyWY6Xv0ywfP9qB7HALZyWLOpIQ/E7+MndusfJQdX1x68jh7B
 Vx6ve
X-Gm-Gg: AYBFou07AMZVcjfmrCHqA5ML/UyJHXDYxm+ncrPuh0UH8jiI9VhE5SjdXIZA847tnPo
 C9VoBuonvCeAsilW8wdisH+nno/5aPa1FhKsDhBKE8fFfqJhujZ4/Mtj545ja5BIJYW/DYlY8Ze
 hv+P7cuQ8B+7EJ4h9JD1jw51gfFSBBu274bVeHg/chhGgQEOa9NwIpIVHFBN2uCqibGttviwY5Q
 rj/V/2W9XP/wXcE5H4zlvT8q9gaArz5dICuIwD9Sp6m9SjjXALs+pTLQNyo2ntklxsYdKhv9D/v
 E+7KVma5MVTptCG0rTBv3foF8JO+BRXhm1jlnLQstp4QMZwSHZ5jsbrwGsFqYjZbxbGD/0vE/hA
 v64hW6otmnb9p2taXKp2Jhp/IOOkwTm2lYYnfk2NWKdEH5QAo4FkicyOevLJMt8eYJVfWV63pVo
 MoUK54Qcujd5QT4vYUAOkpvsjxP+EXWZq3cTED6NYNTHH7Kv1aCL1OspgiPiur/55oU1/BjBP0z
 egD7ygvFcuc/nolA52MOPCFdFqB/nLic3f4ZN4GCCfOY44oML9U7+nDf2jnWA1OqXQ9e0/eHEqS
 tFms7f1LoiSWO/IyCCIIf7QEuA==
X-Received: by 2002:a05:600c:811a:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ac187a6b30mr405066635e9.28.1793877473016; 
 Thu, 05 Nov 2026 03:17:53 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm11018817f8f.4.2026.11.05.03.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 03:17:52 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH v2] migration/cpr: document the BQL as the cpr fd table lock
Date: Thu,  5 Nov 2026 12:17:49 +0100
Message-ID: <20261105111749.2361913-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Every user of the cpr fd table runs under the BQL: device realize and
unrealize, backend creation, RAM block allocation and freeing (the
latter also from RCU callbacks, which take the BQL), vfio MSI-X vector
setup from vCPU threads, and the cpr state save, load and cpr-exec walk
on the main thread. The table has no lock of its own and depends on
that, but nothing says so.

Say it at the declarations. The obvious way to break it is a socket
chardev preserved across CPR: its connection hooks run in the chardev's
GMainContext, which for the monitor is the QMP iothread, and that thread
must not take the BQL or out-of-band commands stop working. Such a user
needs the table to grow a lock of its own, and has to keep the saved
table and the preserved fds in agreement when a connection comes or goes
during cpr-exec. Both belong with the series that adds it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
---
v2: replace the lock with a comment, as discussed on v1:
https://lore.kernel.org/qemu-devel/20260916132428.1628553-1-den@openvz.org/

 include/migration/cpr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3ad084d5ba..5ac46b6207 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -28,6 +28,7 @@ typedef struct CprState {
 
 extern CprState cpr_state;
 
+/* The cpr fd table, including cpr_walk_fd(), is protected by the BQL. */
 bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);

base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
-- 
2.53.0


