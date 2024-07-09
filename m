Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6A2C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4QC-0004ZP-Un; Tue, 09 Jul 2024 02:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR4QA-0004Xj-Im
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:33:50 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR4Q8-0002J4-92
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:33:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7594c490b04so3304293a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720506825; x=1721111625;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=USUjaLTc7ojbSCgd/T7bjLZM1iCzVsLAtbTnu7ECRKQ=;
 b=0Pui/rJRbv4LWtjACUpP9Ke3OrdtR2OiFHxovE/GddUmnGkdY96LlzjI4sWW64wnCA
 NwCCpyjIk/4922uSsP1rhpbwhjU0NGD3omUaXdTsZ9pa7xEg9LmrpLJ+NZccFn9AsUHj
 p+1fQ8JA0Aol5Nk7iTGF+yeZ9vVjd9TkHdx/DbVxMwz48AiYBxXNYbCNya8AoqQziglK
 lcicqvZJGQtrDE/U7T5YludGeY4UAJNs3HO8c8RTCBnG86rzkoCHqbbEpw7JyxUUA/AM
 c2Xhl+EppemebLOXYVLkR7pIHnOdgk2U7QyKVS4TcSaSo6/YmvWiLIJWzQeNFHfiwD74
 tm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720506825; x=1721111625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=USUjaLTc7ojbSCgd/T7bjLZM1iCzVsLAtbTnu7ECRKQ=;
 b=XMAxkMSr/8aJR6cISr2RsCQtqR3iZv7DuGz8+mEXRo5wXP2j5Q4W7Kk5RbPWKxMtSE
 EhswzQi04yR249YMGQI7ZKpkFoL8k4lZRnCGh3RHeQZXWtgqZhWlb68gAjtscb8ldX5J
 O4x3fv1t9nnNX+FZiyhnHI+XqmOyB1CgODB0Xq0OuNC/pQCHg4+y65p2niSbJtScW//4
 bb8A4sHloeweZ50GZqMZM+SnraKO1rA+HRZWWFJWW/vDICNYu2uDKyBa67ORAsh3SVw+
 tzJ4ez1adfajZ0f2lRiw159aRL5EPdMCfjSOVmU33oVJO8eAHXNWvM0wf7EMqxUUprh5
 d6Yg==
X-Gm-Message-State: AOJu0Yy5LZ2pkfzs+Q2U08vrr3vuY/TE17bLgnrKgE4J316SlSExnzD5
 Py9nqomnQkgORUMU9BlnwBNaDy0BnTeu+sBp4fzYtDISG4bMp+TDxjM6twajPoZjGMTAx+hpEtl
 gv5E9yQ==
X-Google-Smtp-Source: AGHT+IElGqBp2dZFqVOYQxuZv7tRh/Afm6I+Tj2VPrJMflheICMlXPvK3O/OZ3DrO8Z3rAtilzIi+A==
X-Received: by 2002:a05:6a20:cfa1:b0:1c1:795c:2661 with SMTP id
 adf61e73a8af0-1c2984c8532mr1979976637.49.1720506823964; 
 Mon, 08 Jul 2024 23:33:43 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a0fc38sm8713095ad.17.2024.07.08.23.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 23:33:43 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	yong.huang@smartx.com
Subject: [PATCH v2 0/1] Fix the overrun check of the receive ring buffer
Date: Tue,  9 Jul 2024 14:33:37 +0800
Message-Id: <cover.1720506723.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

The version 2 fix the corner case in e1000_has_rxbufs:
Handle the scenario of RDH==RDT while total_size > s->rxbuf_size.

Hyman Huang (1):
  e1000: Fix the overrun check of the receive ring buffer

 hw/net/e1000.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.27.0


