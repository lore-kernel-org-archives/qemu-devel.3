Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D91C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJM1-0002Ei-J2; Mon, 13 Jul 2026 12:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLt-0001y1-En
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLr-0008WK-Mx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493f431e317so992245e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959470; x=1784564270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ePvYMUwahU4QhDonbqd74bdkV2tcEMODYnveryQj0hI=;
 b=I08/eSkhWo+YS351Ct458U/4UljIsfd9ZCkQm+ByDyj3mZ4wIgBGeY12k/jQzhGItz
 0WouKNvBzAGEglF8v7ubyMprMGsgdSYRhJkCuFHifki2G+6jVtaojJ4bSEr8V1EwvAQw
 UzxISo3Ow23ziHMsXRnF36ZJWkQDLK3MmuPG05NTgtGZKGywJY+GzHhUXgV7+LN9iCmy
 vw70yttNMz4wK5mcGN1U7S+ToIUAw09jo/RCjHfzwGwdckTMsFsXVqNRq2Xfrbp68xUE
 xhQfnZIfB7qRCNwEvz/KNNpF2cyesgh39QT1V7SwBBeo9ogjtcE59rV/yHa20tctYoxY
 sYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959470; x=1784564270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ePvYMUwahU4QhDonbqd74bdkV2tcEMODYnveryQj0hI=;
 b=oHDkOFmK6J0Ddq2HHTO1s7qT/PvI9aKPpb3aMBcsFudYSOtYfsNTx2h38VwD1INPk4
 ue3V69ECUo1acLUl6ER/lcFT1lY8Q4cIJBEbC0+95AMC7FH6n3DsumS8dXlG3X+zr51k
 WHNiW6Co76nJTlFLhcoi7V1+fZCh7EmDkeZKUf5qouw6eC9gGe6VxmWUfOcNDvxJ9HvN
 Z77eNPcZ1qmwitzGE//sfxYgOVaQ9lNCufBnNOwU6etqQQBD7Ob+7XRk9amyxz7KaC11
 mrEceCfdNYpDPg9NiMuB5gaYvBrVNBX8+Uj0G6vQw5t3UOUtvA4IesYWqI3eRtOXZ34A
 LKCw==
X-Gm-Message-State: AOJu0YzQtcln9GrFHsoN7zu9crMfNozKa2rYFmJQoOJ+QK2QTpms4yK9
 dHDZ1LBVXC9lDIjRvmjVyr1o8XsURKdvec9Z3ZHQrPrGMTAz7ZshisGFtZMpJMXEOk5yQ9P8sc5
 /glzTZhg=
X-Gm-Gg: AfdE7cknqZvYsRdQ9HQ7INU3k7Y86i1K/ND8zq6zREgm261FDb9X5C6Rkda+rZIO9CR
 7jZhDWUkLPjr7Z4tuwmj5wN932U1UIVRwtf7RJ1r2TDyuxpZvWd2jwUmQ/kta4tONID/TYP0u+e
 2dCebSWelkWb81xvX3ok351gXGWEvYkPJLmswg2YAniBTkAID6UDtig9GTjL3bLBPlzvCP2lzTn
 7prhdjqtzznf6UoeE4qn5zjFNf7yci0cp70pAXZoksLStVO9N0XgHOmwdqk36r2htCBFGol26gr
 0z23f+u40dKwGE+sKmd7vXUsXZIYlOtMIIGzi7APdq7N3vccKEQrFf8aLAn/16voYp9i/kcjFWg
 RbntC590Vf9iImuEHiEY+1EBGxCxQeRQDSyA+GRpwetUaDGrAMnSSwZ6zkoPOyfLb8FhV2JMxQs
 Esr3cJslQ4/TIO
X-Received: by 2002:a05:600c:1f8f:b0:493:e79e:da6b with SMTP id
 5b1f17b1804b1-493f8815d42mr126489855e9.21.1783959469804; 
 Mon, 13 Jul 2026 09:17:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871cbd6sm7766195e9.3.2026.07.13.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCAAC5F8C7;
 Mon, 13 Jul 2026 17:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 4/7] contrib/gitdm: Update IBM map
Date: Mon, 13 Jul 2026 17:17:42 +0100
Message-ID: <20260713161745.53889-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joel Stanley <joel@jms.id.au>

A number of us have moved on from IBM.

 * Alexey moved to AMD in 2022.
 * Andrew moved to Code Construct in 2023.
 * Ben moved to Amazon in 2019.
 * Cedric moved to Redhat.
 * Daniel moved to Ventana in 2024.
 * Greg moved to Redhat.
 * Joel moved to Tenstorrent in 2025.
 * Suraj moved to Amazon in 2019

Most have either stopped working on QEMU or swtiched to corp addresses.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Greg Kurz <groug@kaod.org>
Message-ID: <20260709080040.4157324-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index 24d8dc1b865..39c53a42ca1 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -2,14 +2,6 @@
 # Some IBM contributors submit via another domain
 #
 
-aik@ozlabs.ru
-andrew@aj.id.au
-benh@kernel.crashing.org
-clg@kaod.org
-danielhb413@gmail.com
-groug@kaod.org
 jcfaracco@gmail.com
-joel@jms.id.au
-sjitindarsingh@gmail.com
 tommusta@gmail.com
 idan.horowitz@gmail.com
-- 
2.47.3


