Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C0BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpa73-0000nU-96; Wed, 27 Mar 2024 16:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeC-0003Ap-TI; Wed, 27 Mar 2024 16:13:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeB-0005wN-Bc; Wed, 27 Mar 2024 16:13:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e0189323b4so1744455ad.1; 
 Wed, 27 Mar 2024 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711570395; x=1712175195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rYmzSivCuzTkHZHENmWp2t+nxReUdtRGAqmd8Ig6jN8=;
 b=UB1OoUeyzACQjREOBMoqjCJNTuJ1nWyLPQXY5fLYKEkb4+JwD6/gvtF3dBo5DNGuze
 Dn8swkzHcraE/zwyFmat3C2ejSnCaPm9xwsodZeN3JaD1aDjTRF5DPMs2bOIl/+lgn/W
 NkzqPijrBUzRDmwayzuVymzvYQHW8XMlD6peevf9pd8Q8z45naxFTRtccc21Xt70u/Yk
 19i4kXK36hwXoSNMaxRVMQDYqe4fuiThpKjhcJzmmcuNAaFRZEe7S4JRSew2JUJZs0ea
 7HIazGdAWzNbA6ajLjZDuedjh5ARaAa7B9bQmXInpU/eoRKiaks9oIE10c6y4Te+Pq0K
 N7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711570395; x=1712175195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYmzSivCuzTkHZHENmWp2t+nxReUdtRGAqmd8Ig6jN8=;
 b=QWJKX8A/T3BNmgcR3ZT6sMPjs37SGPPtxGV+fi/zkG14eT+wwpqrehi2olaBXc4gzf
 kgDP7/CwxmIH2oHblvP5y3oYHMpCYyPcIhsEFtyc3FevIt5Qa230uwz7qq0U6TwOEUc/
 6tPso7T0Y4T/XukEDx8scMv8UB8t103mzJPNReAjWMzrFMfhVlkvRPF3dAjIIrf1NOKn
 QkNmNP/oyOGQao7cKKXVzVHm9YY7pnAyViR/YClPI9DEf2gMops0r/VNj+CPyOb8KvDP
 /fjGUOOkuV2OciQQvuLqxIauGHAGK2T3gU3/b/Lpd7M6lzbkGMGaOJlsA6yBARuuukiJ
 IrWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbLRGIlIN77/BP5Ee2Ag7QPdQ56S7Hyaq3hc+1kS9t/bUoVp606dY5efAtBV4p6WBahMvMo6rtkkyb8yCwFbYhWT/gCzY=
X-Gm-Message-State: AOJu0Yyd6mK2yuC4hOE0UL6I8faZbJLKJeJ+8cvssalBUrQBMADVKMS1
 /RQdeYTCN8g8GCUMZh6LtzpIKLZ4bIMh2i/WTVv/Vh0SVSkPkaQXWXD27d4YjKUsM42n
X-Google-Smtp-Source: AGHT+IG9qlehlrrOnXZdUqW5lGKPoJgG78qbR6EZ7by9pVAHU7d+ps18dUpJJk6F1aOvliq4qOkhig==
X-Received: by 2002:a17:902:6e08:b0:1e0:c5aa:58d7 with SMTP id
 u8-20020a1709026e0800b001e0c5aa58d7mr669243plk.11.1711570394968; 
 Wed, 27 Mar 2024 13:13:14 -0700 (PDT)
Received: from localhost.localdomain ([192.228.205.68])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b001e08d5a7638sm9682673plk.99.2024.03.27.13.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:13:14 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:vvfat),
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH 0/3] vvfat: Fix bugs in writing and reading files
Date: Thu, 28 Mar 2024 04:11:24 +0800
Message-ID: <20240327201231.31046-1-amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Mar 2024 16:43:07 -0400
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

These patches fix some bugs found when modifying files in vvfat.

First, there was a bug when writing to the second+ cluster of a file, it
will copy the cluster before it instead.

Another issue was modifying the clusters of a file and adding new
clusters, this showed 2 issues:
- If the new cluster is not immediately after the last cluster, it will
  cause issues when reading from this file in the future.
- Generally, the usage of info.file.offset was incorrect, and the
  system would crash on abort() when the file is modified and a new
  cluster was added.



