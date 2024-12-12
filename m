Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59536E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGM-0003SE-FL; Thu, 12 Dec 2024 04:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGK-0003Rn-F3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:36 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGI-0008Ob-I5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:36 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so287099a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994812; x=1734599612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u/hPrZs5s6SXWeepqaSLJSvldcFYbnq9Bjj5jPFjVEQ=;
 b=ZwNmW06l7tNjXF2moKadEMfP4QnpkUtgnfIxP3JARIpQF3XaaRAxNOEIdCL7RQy/vp
 XiafyqCXdAqirtIpFHswX1unVt2PrKw9p3QH13KQQRnsF2/M1Aj0m6K+Fsk/xaNsrO6W
 0z5IZT4w9E0B8GKuS59tnEy58e/Bg3C7YBDRXBVbBEHCTVyXpW3sIp5UZnavQ0mVe/cz
 g1kfEno2nDJDM35ONwEW8ncq47wvIGo8QW0GGm/seTloUiW3KMPfL5w4h5CT/LHXqVXY
 we2Vzs7arC6C55It6A3Q8QMxugbf6YFYSC8oRmkSPSMVP8hloYQxSvNylNFsKoF3XxPQ
 tzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994812; x=1734599612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/hPrZs5s6SXWeepqaSLJSvldcFYbnq9Bjj5jPFjVEQ=;
 b=vgoTWq4UfmYGlzFGJrSXNWV0jkuJHPo7rdgduZCZnDosNz5UHkb9fe+yJRMRzTz4l3
 kbfORhjELgm45K8wtkX8iAALtwahniE+/sECUvERRUw9VYxLVYC0WWH5T2CMWEBxNDUD
 dUgDv2porESxfeqq/xPXhzgIeUjiPZH9/DvMaOpVm06b+UHupqbR/h3mFyVVwtpuvNns
 0on7eIJmhe1RNDN/RP6Hki8rxhZE752YbHWJjzQIuPYpgZQstURb08XGo+x5/AL1vvKi
 2I13h+jRABUDpe61kMFzSf7LK0DtuY7uSZChkd0BdmHklvS/wyH5ndFpO4V5z9Cdrz5k
 atUw==
X-Gm-Message-State: AOJu0Yxfl0gCUcwykjoyRjRuP1EdWFI1FEMRZ4iMB4JkNhDlgiVtCyjx
 0FVWi8y+60zFTosj1TSAwubUqhUbhkZWEBb/nsMHK3zAWgtcGEWK+X+atQ==
X-Gm-Gg: ASbGnctphRy6buXjicr7RCBYRiZNQ6JE90dq507GiBcOGjCfLzDBraihJ+c7HGlxQeU
 knJ+bZdcmh/9rwufmPtPFME6bQ5zvSDE/WpIcM/3jeuCxzq4d2pdtBZqA+vasTD8DV4GSUSElCv
 FAx1QAmNAVuXp63g1IR5FNndPwOmP1gHSiWo0ieb/fNAe9cMbZdOhKembky0CyT0AeM15fQPt3r
 DC7pt1nxOag+vZPV7Q2QpNVqugHsgoXbGLhSFJQFyPBBuu1+IPB+7IP32g=
X-Google-Smtp-Source: AGHT+IHKl6LMxQJFs+zoHw/AamqYUL7NdbTSjQhhGjDjmyZBmPu2r49Kd0853d3yPMlL1TIDuaKGZQ==
X-Received: by 2002:a17:90b:4d06:b0:2ee:693e:ed7c with SMTP id
 98e67ed59e1d1-2f128044b11mr9574695a91.33.1733994812369; 
 Thu, 12 Dec 2024 01:13:32 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 00/11] usb/msd: Permit relaxed ordering of IN packets
Date: Thu, 12 Dec 2024 19:13:11 +1000
Message-ID: <20241212091323.1442995-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

This series ultimately permits relaxed ordering of USB mass-storage
packets from the host, as allowed by the usbmassbulk 1.0 spec, but
not usually seen in drivers. AIX drivers do require this ordering.

The RFC unsurprisingly had no comments, it wasn't polished well so
don't bother to look at it. This one I tried to split it up nicely,
add some improvements that help readability and robustness first.
Importantly I kept vmstate compatibility here and didn't do a big
rip up of the whole model but managed to find a nice way to fit it
in the existing design, and I think the end result is just as good
or better.

Thanks,
Nick

Nicholas Piggin (11):
  usb/msd: Add status to usb_msd_packet_complete() function
  usb/msd: Split in and out packet handling
  usb/msd: Ensure packet structure layout is correct
  usb/msd: Improved handling of mass storage reset
  usb/msd: Improve packet validation error logging
  usb/msd: Allow CBW packet size greater than 31
  usb/msd: Split async packet tracking into data and csw
  usb/msd: Add some additional assertions
  usb/msd: Rename mode to cbw_state, and tweak names
  usb/msd: Permit a DATA-IN or CSW packet before CBW packet
  usb/msd: Add more tracing

 include/hw/usb/msd.h |  18 +-
 hw/usb/dev-storage.c | 517 ++++++++++++++++++++++++++++---------------
 hw/usb/trace-events  |   9 +-
 3 files changed, 360 insertions(+), 184 deletions(-)

-- 
2.45.2


