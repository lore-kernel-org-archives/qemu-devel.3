Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9709606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEGt8vBs;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UuEpWNDq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYvN-0008VQ-JT; Thu, 12 Nov 2026 12:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvE-0008Mx-KW
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvC-0001YF-A0
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/k1GwBqs6KCQlKguop7T09dCt4xKvfZfiV/TuME0s4w=;
 b=LEGt8vBscbWmuNr+G+INzMnvO9Fwf8GXu1ZphDhaqiHMPZDEvPF2zXkaomSo46UeYvNB2E
 0MjzFZT7lbNmHw/K6v/vnNkPfMr40sx/O6vgnW0C4G/kjQtgVR+JIdYWqdrv3GqiRXWQKA
 TmAUI8cZFs1PAyLut3iLGoRl3JLpxJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-m-21KlKxNYmsCi5ExOhujA-1; Thu, 12 Nov 2026 12:49:11 -0500
X-MC-Unique: m-21KlKxNYmsCi5ExOhujA-1
X-Mimecast-MFC-AGG-ID: m-21KlKxNYmsCi5ExOhujA_1794505750
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a35e1d2dddso520125e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505750; x=1795110550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/k1GwBqs6KCQlKguop7T09dCt4xKvfZfiV/TuME0s4w=;
 b=UuEpWNDqgZCR0zHJi1xBRmjrrtFbPlyu1fCs1EvSDHtTxiqxSgw2HDdT6FTRmZc02s
 GaPIHW8jKFg2WdoiuKbdfLDu2KU7Hkd3rTNwJ6xNXUx1KFsWFrR6c2GOmSC0pqj5HX41
 CYyWWplrC3S7UxHNN9m3PEVy0sZPhoxyORFv+8b7KKUbgoTHpEmBhFpIeGOE7awLfS8P
 KIVuz65r1JU2GAwczvowaAzut1LT2UEQPzESLarRombArp/BPPDv9O/IRv7RqZvoLIxs
 MW88r5ouFMsm4xVapPItOwShI+1gn96kNMPG3ozHfHb+834xXxgRztu/s7q1rv+iQd6v
 /t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505750; x=1795110550;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/k1GwBqs6KCQlKguop7T09dCt4xKvfZfiV/TuME0s4w=;
 b=jbQ2GupXgDDuF4rhOxcapl24DGIEdC1ZaKUgzRzG8mKFy/D94ysC3l0mgZzheBt2gn
 v+nCWdiVmcAQ7jFQDGhTtHEDM5fv5X4m/tDU/faU1dPskf+2VOWmWWG+g+Rkyz6VRGsb
 0rd8x8OQZ3Z4dUgRpYGFFVjnI3vNujyIeRBuzSmu3DmxrEozY8keGlT+ouc4YCHnTE1Y
 +kAlCEWX3hQCdjGyVej++uNvSQpZe85LGTnrIiztMN+01AY1k3tK7yka3LuFV918CnTR
 eoiuqGzbUFzjaOozeLMaORzS1O477POW4hE0nc/i5Mktfd0ElYLhvvSDZjLb6idb5yo1
 ISiw==
X-Gm-Message-State: APuU4Z8i+n82uSNvKOxfgcJ3gd8FQ8j0gOj915ywYOTRBSTWCoIvm6dX
 IMEcQhv0to/9J9/meDzJLvoNHv580FbfYOs4JhvB7ABIUcYVZad4Hlnec7+GdZhpe/YcENE0auP
 4+4ZGiZB+lXrzrwzv/cHZmn756fhVPbEs7yA7c8OFTozlSE4vakOCmO25Yq2Otu/dzBlKpEf79m
 zfE+d/c+Z4awWTqG1sqJQ6eIkkB6zKaigq11fkSpgwoQ==
X-Gm-Gg: AYBFou1BMT/qCzJd2PzOpxBGPlpIWbCTvRLsixdpdWD0DKHtsx89zoqYqWsnUeJtfIK
 cT9mHjvmjHxzO2IQ91zCtIU5BL0EWASBrscW93e24W1fbx5iZPirwEuIzIG60c8KeyiVhEoI39a
 QOOrq6sBbHVe7vwUiV1zZ0FEI9Q++WXvmmRMmvXN9nl86SHnwywM853rEwh8Zo0uwvr0+8bbSpp
 UiY2I9NGMNqwd/j0gqnQyim4N+QofxHbCt4nUxZiee0hkOQaEcRYVfOt8EtQDN8sxHbCfyfl0Qa
 oo3Z6mCM4x4NcA8oYoRdcc0dk8cRYyiQb6dMbUchBCj0JZDZgPrO9sgdK7LF27leOyBjSjIQSyK
 TKfKNWztsc7wiRipHhzCDpMDXh7lUwulAOZOhgVsCGlWc7A==
X-Received: by 2002:a05:600c:4f81:b0:4a0:1c94:7042 with SMTP id
 5b1f17b1804b1-4ba09377c5amr119158435e9.8.1794505749772; 
 Thu, 12 Nov 2026 09:49:09 -0800 (PST)
X-Received: by 2002:a05:600c:4f81:b0:4a0:1c94:7042 with SMTP id
 5b1f17b1804b1-4ba09377c5amr119158005e9.8.1794505749340; 
 Thu, 12 Nov 2026 09:49:09 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60116323sm442871f8f.32.2026.11.12.09.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:49:08 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 0/9] hw/usb/dev-mtp: Collection of bug fixes
Date: Thu, 12 Nov 2026 18:48:57 +0100
Message-ID: <20261112174907.158825-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>

Tommaso Califano (9):
  hw/usb/dev-mtp: Fix recursive delete of directories
  hw/usb/dev-mtp: Reset pending write state on cancel, reset and error
  hw/usb/dev-mtp: Check length of class control request
  hw/usb/dev-mtp: Handle invalid characters in utf16_to_str()
  hw/usb/dev-mtp: Validate container length on first data packet
  hw/usb/dev-mtp: Detect end of SendObject data correctly
  hw/usb/dev-mtp: Zero-initialize command and params in handle_data
  hw/usb/dev-mtp: Fix assert failures in usb_mtp_write_metadata()
  hw/usb/dev-mtp: Stop processing SendObjectInfo after an error

 hw/usb/dev-mtp.c | 99 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 26 deletions(-)

-- 
2.56.0


