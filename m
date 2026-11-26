Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1EE606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h8441Bsx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=c2+WMguI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbjy-00020Z-7K; Thu, 26 Nov 2026 10:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjd-0001sJ-SR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjZ-0003Qg-P4
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oi2jnDmm9R3xjPQjaiD9WT+wJAsI7UjJsR2u2pFuhjA=;
 b=h8441BsxvSjdndSBK02CfnJOHL3L1cdCB7GHazOvstfpEr/iEgX5LGQixWeCAzkYa41pcN
 fR+09b1iX0w95LGqSl0S3TdKj/oLB4ChTPrT8yGxFmayPUDxnLSxMBl1uswFFvOEfzSloI
 90SrCHs4Ui0XKSiFcRetIJSHkFRlCyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-TeemWYe6NViwoa364nwfIw-1; Thu, 26 Nov 2026 15:50:02 +0000
X-MC-Unique: TeemWYe6NViwoa364nwfIw-1
X-Mimecast-MFC-AGG-ID: TeemWYe6NViwoa364nwfIw_1795708201
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4925ef75fc4so4343595f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708201; x=1796313001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oi2jnDmm9R3xjPQjaiD9WT+wJAsI7UjJsR2u2pFuhjA=;
 b=c2+WMguIq8J3/tuhKR5fsV8KfzfEtpIU8d/VXWRHMFTmfpAq05rmjUzHbhahidKm4u
 K826k/PiLOiySlcxQA6HxvR9p/90Etvj0/rqDe3Hui3W9hYyeqdUjdBawMWmmqNvEAEy
 pCnDVU3s8mefeEfknGFIMzt7IZJQ8TJMuO/81LfUr4v5VKaePVmpl8Mk1fegnDXAcAkZ
 9gsaiTB+OE+4JkESuAz1wgd/B7cNhN56y/ALmVmXOYG6j7IP5Rkfzpw+JeafSkWPmMu/
 NF5CQJ8m6McGJdyg5tMKqlyyzfM9/s2+oXqfaGYmzv5GTYI89EWcSDCnodOTANhqhgIo
 M2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708201; x=1796313001;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oi2jnDmm9R3xjPQjaiD9WT+wJAsI7UjJsR2u2pFuhjA=;
 b=f1uOthxoe8KF6qxYqaT5w0Gxcb+exFiEUWCT14NSyWPXuCPlF16l+5HmApdGOhLteA
 3fXq49e8wjwPIA6MWOAc/lpsEbn37mBeefWv5Ri8zXo7lJ2jIJyFOb6HwHSEJYsodl9d
 0tLiZrkwmIpuIWpGXdthxKOyYSGvf/CizCaVWOLcNAtONrHCUgYMyCxoRM3qDjR5bhJB
 ayYbenWPtQmpIL2tob405wuzCV7c9eVkRvbgZVHeRKaToLWOW8k1/kbYsUy95zhva5py
 jXXa7irScbwp1PTxkcxlpPSfnJ/6qThyCGxkUvWpg2m8hQlvp2yfdWbswZO+f2M5jDSa
 pc2g==
X-Gm-Message-State: APuU4Z//s0mU3EyP24WL953+log1uQs5LqqeRNzkfSluC7Wh3Lhipcch
 umruJs2USmE/bNtx35kk+ONEc48XTFtcS/CUN7pmiyrzkVe2QgvjzH7T7OC+KaaDoRrAW+N/iG7
 1f7RTTDXxhFCE+7Aiqwgr7tQDGkxKq6oNC4c38CFXkddU8duq0YtIYj0DyMC+yCoSYIqH4PUgt5
 G0/aAexLL/igfygbq3mGAfrjLowcI3BVpsyaiRA9VAdZ5V
X-Gm-Gg: AZFdTZdH1fMo6QyRRU0sLdwEZe55TrKUoI136kXhK28ZPhX9r0kWf0N/uOvpRPAgm9I
 l2M11rhIiZKT1JeticUmF5+oiB/H9E9+Q1walLHstlVrSadgb0HLw+TTClK2hLnOe81zydVer/a
 HP+YUfagzT/ULkySYkkQGFOpsnUfsoKVIN4bZO2CLXu+kRRxD+xbLIb5dsb5GI65663M1BRxUUo
 Jo18VhF9hlM01SvD4e/bTG/OYXrmJ/PT3fwY3zOsEs2K1Eperf7518zoV6kEtINeskZOQRrHOvy
 lQjr+KxjFWPsfe0uAUVThyE2PCURM/1T+xUkAGn5nGN+nNOM34Kw+Ys3wSwFaajP38S0rJdKlSA
 IMkgET8Pr0cgOAWoc+RJsHKiOCz1g6z+Ys1enGSd28Q044QEgN9C8F1RqWhzH3+YGMZU=
X-Received: by 2002:a05:600c:19d0:b0:4bb:65ed:b55c with SMTP id
 5b1f17b1804b1-4bb88824b18mr439300465e9.33.1795708201069; 
 Thu, 26 Nov 2026 07:50:01 -0800 (PST)
X-Received: by 2002:a05:600c:19d0:b0:4bb:65ed:b55c with SMTP id
 5b1f17b1804b1-4bb88824b18mr439299965e9.33.1795708200577; 
 Thu, 26 Nov 2026 07:50:00 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm839079405e9.13.2026.11.26.07.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:00 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 0/6] hw/usb/dev-mtp: Collection of bug fixes
Date: Thu, 26 Nov 2026 16:49:52 +0100
Message-ID: <20261126154959.81769-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is a collection of bug fixes for the MTP USB device
(hw/usb/dev-mtp.c), all tracking the same GitLab work item
(https://gitlab.com/qemu-project/qemu/-/work_items/4529).

Although each patch is independent, all the changes are in a single file and
stem from the same issue, so I decided to group them into one series.

v2:
- Three commits of the series were pulled and merged.
- Reset dataset.parent_handle and dataset.format in
  usb_mtp_reset_pending_write()
- Use g_utf16_to_utf8() instead of wcstombs() in utf16_to_str() to avoid locale
  dependency and properly handle surrogate pairs
- Add corner-case checks in usb_mtp_handle_data()
- Fix coding style

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>

Tommaso Califano (6):
  hw/usb/dev-mtp: Reset pending write state on cancel, reset and error
  hw/usb/dev-mtp: Handle invalid characters in utf16_to_str()
  hw/usb/dev-mtp: Validate container length on first data packet
  hw/usb/dev-mtp: Detect end of SendObject data correctly
  hw/usb/dev-mtp: Zero-initialize command and params in handle_data
  hw/usb/dev-mtp: Fix assert failures in usb_mtp_write_metadata()

 hw/usb/dev-mtp.c | 87 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 23 deletions(-)

-- 
2.56.1


