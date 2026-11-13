Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E396073204
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNKRQudU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRv73-00060E-MM; Fri, 13 Nov 2026 12:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xRsw5-00075s-5D
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 10:11:29 -0500
Received: from mail-pi2-x0a.google.com ([2607:f8b0:4864:3a::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xRsw3-0000qm-72
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 10:11:28 -0500
Received: by mail-pi2-x0a.google.com with SMTP id
 41be03b00d2f7-cd6b195dd0cso243434a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794582685; x=1795187485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JNW4wQ5b106mcpTnmonDfMKgXnzoSI8NpA2DGuw+NKs=;
 b=jNKRQudUw6UbMayuBSswvA/3p5UYKUZRMRe1kVfkzkf8s+WKDXh1aN1FzByiuSRFJM
 4BFag5f2J3ZJzckRv5r3q5G2G+DYjDCcnp5UlXgwBGJveX2zwoW1nxpZhI5czKqH6tZe
 u55rclmJ3DrILudEjcAJWjbRPD5MN9hgcaWgttPhJIqhkoMcAYV1V/DBbMWyLXpqythH
 Obg5HBGWJdickG66GM43liLwc+/CRxT37AheoYk8W43NjQD3zWJTiYVpOCEY95S5IQN1
 KU4ZL4JlZb6ZFpJZWpgIsLaZ2iPlFZVV/LwyEE19d2gmNHz34GtHW5osLQyzKzCICwOw
 bF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794582685; x=1795187485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JNW4wQ5b106mcpTnmonDfMKgXnzoSI8NpA2DGuw+NKs=;
 b=EqVCUJfSjQCykL39XashUafpWHlHFHr7NkFXGOkKM+fOAGWFH2C5PqLclwOL8rU6kl
 gko1zZiobOYqZ7vJqkx5vuOtDKA0dAWJVaw5axJNyR2X8JMy9oELMwRf1VZdDXk08wCZ
 SpoDmLvyED1jYt/wjVtVxTVpmW2Hfg09KQP2aqAf3kjq/Wof75ktFWicr0I9ZeqRK7xL
 QL37lBNWhzBEcrBJK5oHFzK7ju3LyBw/1aY8RW8qLtW2N0301gQIKClIQWtohPaijE/u
 OoYgXLS0tX8CSmnqO54QitO7UvswB4+P8exj/ZtzDOLxvuBw1zTb5FWDTrgD83nHUNUK
 y70w==
X-Gm-Message-State: APuU4Z+K9hZrUnZ3/IZmy/sF5m9k4JTKPfhEQnZOh0cRmcLbPQPm6IbI
 TbOMQNGb7lLWGGmazCNWH1Y2mLK5ceQpJPvDeL4THGXcYnMH9v7rl8vhWW77ntrv/Q6K3ZOu5PQ
 =
X-Gm-Gg: AYBFou0eUtizM2jxwfBeMDd8JTkc2ANai7jP/v71u43f+m4ViwhNTsTK+Ex5CTPVtCU
 QPMHFcsgntN36I4AIkJmy7Vh1UYW2brIw3bmqLbxsGR4iVs/ywP359UEiJy+tn2xrTlvBHYU4VP
 q/oj1ZRKoWHTnNdrelOTB/125Dy/7fzpVLUbQb0hLuJGioIh8ek7eDEElh+POtRJUxhMVy9Qs2w
 WqCfSXG2ehWa/ftSVHUpClH0K2C+qXagSS7ZnXwgG4GVctZmmzIFfpK7jB4UcdKniOmhKuMJyfw
 IpGaBrNwdQVz3LoEYCVexYHGsq0l9F0dsYW7YLj9aNjIphKB8I2MDx146HgeM1BSt6FnMx5FFLp
 i8PTIeyg5QeT9TMBIqutw7HQN5SWI4mooM5jNY6qnrlhZfO3ACZIkuSD0YmRfrhNZZNKE8JbBym
 8MnPxF+d9NQrK/us9mtofLgk5tpLtr6+cw1wUDrN+zqIN0OnNdKExogacnr7kZxsLHSMxpd1ibm
 Sf323qQk6eqPLxiqP+OR6noMn9UAMmjyCtXaf53bt7CiDBiUsVsTq7505bUY2fbdXL4OGQriruO
 KhB4DOonBPTF5k11G5NeWtJR8gY=
X-Received: by 2002:a05:6a20:b78a:b0:3eb:afe0:20a6 with SMTP id
 adf61e73a8af0-3f7a72b98d9mr2559134637.21.1794582684919; 
 Fri, 13 Nov 2026 07:11:24 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc1889960sm1476908a12.15.2026.11.13.07.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:11:24 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH 0/1] migration: free migration blocker error in
 migrate_del_blocker() stub
Date: Fri, 13 Nov 2026 23:11:19 +0800
Message-ID: <20261113151120.1912194-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::a;
 envelope-from=zachwade.k@gmail.com; helo=mail-pi2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 12:30:38 -0500
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

Hi,
The migrate_del_blocker() implementation in stubs/migr-blocker.c was an
empty no-op, while the real one in migration/migration.c takes ownership
of the Error from the migration blocker, frees it and then clears the
pointer:
    void migrate_del_blocker(Error **reasonp)
    {
        if (*reasonp) {
            ...
            error_free(*reasonp);
            *reasonp = NULL;
        }
    }
Command-line tools such as qemu-img link against the stub API.  Block
drivers like vmdk allocate a migration blocker Error during open() (see
error_setg() in vmdk_open(), "does not support live migration") and pass
it to migrate_add_blocker_normal().  Because the stub
migrate_add_blocker*() is a no-op it does not take ownership of the
Error, so on close the stub migrate_del_blocker() has to free it itself;
leaving the body empty leaks the error message.
This becomes visible when running under ASan: "qemu-img info foo.vmdk"
leaks the migration-blocker error and hangs / fails to exit when the
image is closed.
This patch frees the Error in the stub migrate_del_blocker() and sets
the pointer to NULL to match the semantics of the real implementation.
This also covers every other driver that uses a migration blocker
through the stub.

Thanks,
zhuwei
---
 stubs/migr-blocker.c | 7 +++++++
 1 file changed, 7 insertions(+)

