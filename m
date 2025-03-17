Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271A2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCHN-0000VX-Ji; Mon, 17 Mar 2025 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuCHI-0000US-FP
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuCHG-0002b6-FL
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742224876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nn1ODu2oB4MWjfAuLd1/bntKmpce1BRStaD+UBCQaZc=;
 b=KfAAmfIObOW0Ze1PY4GT/HngXb5E3fiyCXeNmrSRsM6Vw+tYMxWuj9Xv/IfMVJvE1G3SXl
 Q3vgL6HzIitkKFyxBEwkmGv8uC2b//Qdoew1xLS9nCb2T70GXLBW4zRMjox+d8IA5WJhfY
 HOI0yKRXAn7BDJ8MdjaKu0lH2GMm71M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-IrhaskHQMai25elG_B7uog-1; Mon, 17 Mar 2025 11:21:15 -0400
X-MC-Unique: IrhaskHQMai25elG_B7uog-1
X-Mimecast-MFC-AGG-ID: IrhaskHQMai25elG_B7uog_1742224874
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so17767475e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742224873; x=1742829673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nn1ODu2oB4MWjfAuLd1/bntKmpce1BRStaD+UBCQaZc=;
 b=NieVsNHii+p+aqEqWKMoh7dbyfvSZQY/T6oEAq7Lf/Cli1d0QR6/C+Dfpx0DYyVpup
 qw5WwP6hb6xS0D+4Lz9MKuj1Y+1OGNOqlcYqVcjixZgJhk0LbQEXfnaPc3V8RHib+7FD
 P43fEMfbUrZiM7Q6f/TF9CxRs8Wq/MFIGjy8J/wYkoMO21oWR9u9hhJxW6ZU7SV+J2KU
 gc4Ao8qcCA2rOU+sHLzZtlvZL5zewI1ziJ00HsN/fuiOl3TfPNHihfWnBfznA1DbOYQC
 FwgBcV4k2h6SLz70OED7h1wTxHOI66m0fnTCnai2mej0QrlWHeCtImEVuPl7PBLH6hB1
 d15g==
X-Gm-Message-State: AOJu0Yxawd01oEDOI+AEO1f819KtoR9c5Oh5bqmNl10gMbnnFuNoreWh
 ew/UiO3my8UA50JHfjywa4Vn1aUg7TGS22tjvgcnTDINkAHSSZ5taY/8PWd845KYspednQJ8oE8
 fvnjWWfj2C9GQNh3bX5XPKKm2Fbf1U5+XwvsyuA+O29NWaLFw3iKE9BMwpSqeBUcU/ZiKus1VBq
 sbWsThJZU8fbqJMUWW55swk0/ZpsH/5Jet/lAW
X-Gm-Gg: ASbGncvzFT3/2ivpbIkzLdeyzT4H7FLNrb8f6l7NkUpttlH//VN5D8CCI5ZvUbChDAC
 wfbUJflj0U+n/n3whEWbIg7T5Xw3TPQtLnQdgoyX36rt3LLywOMFj4GXYd9IdgMY5CbJPui/ksj
 lNA+X0dNCob//Nzm0zb2dnqXafQuip18MjRs5aaC3QfwuCt4xDlwn1NRjtMWuMESL5bPQiOedPw
 fzLY9QNV+L76PagpiG00zVnXwL2kI8Xhk6tMgGOQREFH50H2cisBs93aRda2PzVQyYOS5B1Oo8Z
 qoRv2QVX9ruL680TpAoy
X-Received: by 2002:a05:600c:6749:b0:43c:f87c:24d3 with SMTP id
 5b1f17b1804b1-43d389d4043mr2081835e9.20.1742224873396; 
 Mon, 17 Mar 2025 08:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs6pzCYdDKrZWHm/ox24ATR9fHLxyJMpNuwJCwPGJB4nfQlut6u9CJaY+LLjlwyrfXun8ydQ==
X-Received: by 2002:a05:600c:6749:b0:43c:f87c:24d3 with SMTP id
 5b1f17b1804b1-43d389d4043mr2081655e9.20.1742224873009; 
 Mon, 17 Mar 2025 08:21:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe659b3sm106245745e9.34.2025.03.17.08.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:21:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Fixes for QEMU 10.0 hard freeze
Date: Mon, 17 Mar 2025 16:21:09 +0100
Message-ID: <20250317152111.316627-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

The following changes since commit aa90f1161bb17a4863e16ec2f75104cff0752d4e:

  Merge tag 'migration-20250314-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-16 02:45:22 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f35432a4f699d8e450f65e44ddcd5911f2d8c146:

  Revert "meson.build: default to -gsplit-dwarf for debug info" (2025-03-17 14:22:07 +0100)

----------------------------------------------------------------
fixes

----------------------------------------------------------------
Paolo Bonzini (1):
      Revert "meson.build: default to -gsplit-dwarf for debug info"

Tigran Sogomonian (1):
      hw/misc: use extract64 instead of 1 << i

 meson.build                   | 6 ------
 hw/misc/mps2-fpgaio.c         | 2 +-
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 2 --
 4 files changed, 1 insertion(+), 11 deletions(-)
-- 
2.48.1


