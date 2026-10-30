Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE8606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uak3OC+v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMolV-0001Qv-J8; Fri, 30 Oct 2026 11:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolO-0001Q9-Bm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:31 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolL-0002fp-Lx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:29 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35c76e9614aso1314592eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793375006; x=1793979806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c1puNhUalAD7QUOVHvxUEoQt8D7I+jr/DiiotLixuO0=;
 b=uak3OC+vZxjDOzoCG/CEGAtrBEke0W7jESHpvWj1KvINjaoasSLbPP5T7MJsMx6DfE
 mjrPitY5l89TIgfTi8mbWfbXK2W62T20j8NsbncFM1uaBCoD3BuPxhV5L1z/XJYy/R6L
 PWA/yFDS5U41cvLHJKCVhbOsAXXFo+yyx5/hX245dtB3p88kz793lsIjW32P+imzZCtk
 /jeIx1GGJ+xoDM/+lNMeURWaQrXe+l1jjQmPkG/UzG305MQ4Xj/IYrBX7raZe0wCMBZX
 ANGDd825ZhBhz5KOwNsx4naVZnGhPixRmhGNnJpar1D88jpUVpN6OENY59/D6tLEusz8
 JGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793375006; x=1793979806;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c1puNhUalAD7QUOVHvxUEoQt8D7I+jr/DiiotLixuO0=;
 b=C5u6YYR2QSav4bxYSVPM1OYcHfTHEf5etOoMGhxAgNyuLe0cjI02+j81rT0uwT388M
 Ff9IwUT4cI5pmY/iwOMcKl6yBJNGQtw9B/FrR5XagFI4HF85PhbOb5Lm6JiBb+R1msZv
 fmIn7KfTeV8Kv7QfW3fl8SvrPbCRyaT9ymEpgTD4UYuKeN4jgvRRN4lao5IChFInYHwc
 IceTw4IKC4T+0Ker4wmN9/9kLJx6eqO6LArUuyrLz8GBRkkGpHtmmfvjYN4WawVWV1dK
 IVjPrhOm2RtIso/wcvk94iYhk/+A2caUaRtD94fgzc7AVoCIsey5Gu0XHFfQs2ZB8XYh
 y0Pw==
X-Gm-Message-State: AFq9FYLyVliN9kraR7FUV4Dv86c1lJl+uw+zj5/y6GvqcQ07j4DkgW6e
 W48/sSWR8auVlxOPZnxJERTnRhe35IXK3RMQaWhQnj9U48nx6CJLpmXbOKbGHzGt
X-Gm-Gg: AYBFou07GEqyZBOMVfall5urfgjFHVOGLsNlWf7nLW/3mvKf/fnhGEE126RxFLiZnJ0
 hjkCe0wftGQk6EBxZaZNYPk8rajSvS3d8AVKOIl0oWBjRpkKc+9zW4JUPSIlg+JX4SHkBow4egw
 nYF8MCAeHVrrVX6dH80Llc/hFXbeXYASIbRCY/29jCY9Kl6ohCWR/2SvqneHMQDHX+tN50/aYRf
 f6fwPiSYyUx7zb1A2QRF/gVloIeFJjbeHP0nPRHFFqa4DYIOU8ttBSFv3os0e7r8S/7BKzrhRXV
 XDmV4wfJt0sIsc4Pnc7JIbP2ZRWFcX9GuXdB6FLh8rHqb0t7Ci4CaIwtOpFGpjwWMwTmpxaBvx4
 QWC16F4T3uixoapjGr0qEaDfQRFi9fCz2WzNGiwTExHHDYdN/OR8LTtgNWTU2wqx52y4wz5Hw8m
 B+3RuZ8NPzp7CtUm+p7Q4NMJYkg+HjBEBr8YzjSVVAlS0Bmh5NmQA93YS7kER0SAA4ZuzN9cs77
 Us15XBzfPICxesQfK6vh+wTJYI4hsM24+pssxhc7w4dcKyFgM0RQCuLkKLAL67ck6mtq99tObkJ
 1Gr9zebFrnscc2vAA81dhEa8h5vpwhX8Ispz5AGGCKrU9AXM
X-Received: by 2002:a05:693c:39c4:b0:369:2f25:339b with SMTP id
 5a478bee46e88-36a42330c56mr3718274eec.8.1793375005773; 
 Fri, 30 Oct 2026 08:43:25 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm9620706eec.22.2026.10.30.08.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:43:24 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/3] tests/qtest: raise meson timeouts for three slow tests
Date: Fri, 30 Oct 2026 23:43:13 +0800
Message-ID: <20261030154317.1807-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qos-test, device-plug-test, and aspeed_smc-test are slow under WSL on my
computer, an AMD Ryzen Threadripper 2990WX with 32 cores, 64 threads, and 64 GB
of RAM. This series raises their meson timeouts.

slow_qtests in tests/qtest/meson.build sets both the meson timeout and the test
priority. A test outside that table uses 60 seconds. A test in the table is also
added to the slow suite.

qos-test moves from 120 seconds to 240. device-plug-test uses the 60 second
default because the table has no entry for it. This series adds that entry at
240 seconds and tags the test slow. aspeed_smc-test moves from 360 seconds to
720. Every other slow_qtests entry stays as it is.

Yonggang Luo (3):
  tests/qtest: double qos-test timeout to 240 seconds
  tests/qtest: give device-plug-test a 240-second timeout
  tests/qtest: increase ASPEED SMC timeout to 720 second

 tests/qtest/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.55.0.windows.3


