Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBCFC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbpk-0000ae-3F; Mon, 27 May 2024 11:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBbpg-0000a3-QX
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:00:17 -0400
Received: from esa5.hc2706-39.iphmx.com ([216.71.137.63])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBbpf-0005Rd-2C
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:00:16 -0400
X-CSE-ConnectionGUID: 7+iM4iVMQH+HcO1N9O+zuQ==
X-CSE-MsgGUID: CYv7+Tb5QuuR1XKl5oLKDA==
X-IronPort-RemoteIP: 209.85.167.199
X-IronPort-MID: 380243688
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:9h/9oKjCaEK5VuUOxpkOGbqOX161KxEKZh0ujC45NGQN5FlHY01je
 htvWT3VO6qDMDD1KN0jaI21oxsEuJXdnIdiQQZvqSwxQnsW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrTwP9TlK6q4m9A4wZhPakjUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIruNjrbhf0QWdaXZNA6Ih2A+c/DKbs9q/3FaPg4TbZLwWG8O49m7t4kZJ
 OZl7PRcfTwU0pjkw4zxZfX5/xZWZsWq8JefSZS2XFf6I0fuKhMAyN03ZK060BFxFk+azgii+
 NRBQA3hYCxviMrpg7OeFuhSo/0Db+ngG9o561Yj3yzgWKNOrZDrG80m5Pdd1TY0w8dPRLPQP
 ptILzVoaxvEbltEPVJ/5JAWxr/5wCmiNWQG9xTM9PtfD2v7lWSd1JDkNMrTdsaiT9gTk0qFz
 o7D1z+pWktGb4LPmVJp9FqHt/GQ3h/xBbsPCYfhxt1u3Vq35UA6XUh+uVyT5KPRZlSFc8tSL
 lFR9icwoKwa8kutQd/gGRqirxa5UgU0XtNRF6g96VjIxPOFskCWAW8LSjMHY9sj3CMreQEXO
 payt4uBLVRSXHe9GBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:V9r3W61DNpSV+yEkCNZ5DQqjBGkkLtp133Aq2lEZdPU1SKClfq
 WV98jzuiWatN98Yh8dcKm7Sc29qCrnhPtICOsqXYtKLTOGhILAFugLh+bfKlbbak7DH4BmpN
 1dWpk7JNrsDUVryebWiTPIburJzbO8gdmVbeu19QYOcelhAZsQiTuR/TzrdXGenTM2fabRwq
 DsnfZ6mw==
X-Talos-CUID: 9a23:nm0zgGwvtYIqGjeg2Q7wBgVLWcEALnzj6U7wYG+zLj9PGZrWW0KprfY=
X-Talos-MUID: 9a23:sWDEagRl/nneSCvpRXTHtS89d/tivp2zFXpUobYC5s6gFgBZbmI=
Received: from mail-oi1-f199.google.com ([209.85.167.199])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2024 11:00:12 -0400
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d1bfe016easo958931b6e.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1716822012; x=1717426812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gGU4xf3g9U6RCe2+CzSpJFx8Y+HIpoEL2EkriGntQbE=;
 b=Ouf+edfa6AXilV9GOOk7/wHOwaDkZJlp2ynnWTCLMw+UeJuy0cm0JgcfuPfW7Y7RF3
 7KNJF1Ev98vx7tf1Z1HPxvPRLywRclEk+b8hK7mDIx1Qx5ieQusgwXLILhKQ2zg5G9d7
 ejXdojMfU70f1jpO4egLGNTlqgvWOFzi+yfoS7U9Ni3XE9F9MU+Vd8LKdu2f9hq6IqMO
 zqNn7zK5bhBRvM8+Y1BhbVl9KhcRbwfwVjd5imVOkN3BL2KSnVGA0npqhkQNbJsh3gjS
 3FOqpllyMQ13G1PsR2w0mr8P4EQhSgKppXs20Q2vE+ksONAxLU5fudqZokCxBxWuuuCp
 FDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716822012; x=1717426812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gGU4xf3g9U6RCe2+CzSpJFx8Y+HIpoEL2EkriGntQbE=;
 b=p1MQIi6l6kL9KmmwlpKiT2g+lduVJDvdeCBNGcQqt7hKFaDTgGNnx1GKA45RUz4D0S
 bApTwD3c7Y6Wl5n9NPkKjdyX0+8RRQpVgwo33Iu2E/stfhPRKOxidReVX7PqIx5JU2LH
 0wr2mSYiouFmm8MxkV+nz5N7RkBABgcpldrs+2fDSz6QOi/7jT8uyNyZaIQiMVUzRbbr
 5nGB30f1oEIrhYxK9Ga/OQ17jB9IoyqHThxY5FiPGk1tY2Dul6RW7GKLhUys52KiPxY0
 BwEXns0fUiuFt2ORYM1xdDdZMJxoMKzDFWja/1ILf07oOZhOhrAcfRS4V7B0/IAv6SpS
 c8aQ==
X-Gm-Message-State: AOJu0YwDHsUBQbxMeFbVS98TcgiEb91FDPGJa47ltSlDjIpIq6G5gDoc
 YkIOhSBUErYsKg5wDQISnwAN4Td5KwyPkbcvbX8QYOBjPxdlRn3em6x78a1H2Y5iskcnUF0NevZ
 H+JDZl7IXq4Npa/oADXJDQtkJt0H97THP62au/f9mkBBJSxrKmB1O9LZBQ2FE4UvE+W2RhHCWQw
 ==
X-Received: by 2002:aca:1b15:0:b0:3c8:61a9:629 with SMTP id
 5614622812f47-3d1a538c75amr9863700b6e.1.1716822011428; 
 Mon, 27 May 2024 08:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQaOCRtkFfPpaah/WP+Od6yhUhxQOSka4Qygtu6Cf/qtETNi7plXbNgcbTgyG0qJoN+MGuhQ==
X-Received: by 2002:aca:1b15:0:b0:3c8:61a9:629 with SMTP id
 5614622812f47-3d1a538c75amr9863687b6e.1.1716822011138; 
 Mon, 27 May 2024 08:00:11 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac20a126c0sm35181856d6.145.2024.05.27.08.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:00:10 -0700 (PDT)
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>
Subject: [PATCH] fuzz: disable leak-detection for oss-fuzz builds
Date: Mon, 27 May 2024 10:59:58 -0400
Message-ID: <20240527150001.325565-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.63; envelope-from=alxndr@bu.edu;
 helo=esa5.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When we are building for OSS-Fuzz, we want to ensure that the fuzzer
targets are actually created, regardless of leaks. Leaks will be
detected by the subsequent tests of the individual fuzz-targets.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 5238f83343..7398298173 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -92,6 +92,7 @@ make install DESTDIR=$DEST_DIR/qemu-bundle
 rm -rf $DEST_DIR/qemu-bundle/opt/qemu-oss-fuzz/bin
 rm -rf $DEST_DIR/qemu-bundle/opt/qemu-oss-fuzz/libexec
 
+export ASAN_OPTIONS=detect_leaks=0
 targets=$(./qemu-fuzz-i386 | grep generic-fuzz | awk '$1 ~ /\*/  {print $2}')
 base_copy="$DEST_DIR/qemu-fuzz-i386-target-$(echo "$targets" | head -n 1)"
 
-- 
2.45.1


