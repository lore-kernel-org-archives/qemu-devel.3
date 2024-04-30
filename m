Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F153DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 02:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1d4S-0005C2-9F; Mon, 29 Apr 2024 22:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1s1d4Q-0005Bd-QM
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 22:18:14 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1s1d4O-00017X-QO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 22:18:14 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c865f01b2bso1143222b6e.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 19:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714443491; x=1715048291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sJF6z50nmwI4XvE64ATxcpbbJtSb6UVr1A5vQdipVA=;
 b=i2BFWE0eX3J7tfflKidJ+WQfbHBI4D8wxfI/v+izyzbv9cmKjmKD2jbrlyOTc9mlKI
 Q1uochmUYiZHPg5qm+Wed7kI+0Nq5sbqlsKrwtB5dORDTkQ1AUR2QhrE4gLpFtY41WDG
 Fb3q2yG9i0MnZ9umXOMoJiovX1LR0A2V4CHbKKC1gqDwOG13nWvEcYrA38oyR+lkY4DF
 lRXPHNNHQXtU4LIn6jffXNk+kbEP3J/y5zb7mEegXQog9QUogWWvIhWko1Fky4GfiCsK
 dt9lMYcpcV/kJ/LLAwtfvRzd9aSy5LbAsJdXBy/YK9j2486/d8S8Ymx6y9+3x046g7j9
 SEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714443491; x=1715048291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sJF6z50nmwI4XvE64ATxcpbbJtSb6UVr1A5vQdipVA=;
 b=aFQomMZz5paJaiWciBQAiy5aGV8D0KDY6sRNzaiI5NBDDBiRMnUzsHCQPBy1MqNbP4
 UWA4M+qIJtrzqKUtdKHxv2ufU4TvgT3Jrs3llUHrukK3ZeFmkMewYLLsvE8CbhUpP0fy
 SBkdZBMwZCLdO4VAC9s0HnZY6TQl+JEEnZgRF36rDsvBz/5lcJjJdRm4YnLQfaYZkIaj
 CvMU5VALxJqvmRJYe8e/pIC1je+EAICCxWpFAfYn19uyXF4OsvQFlGLFtwyv1ftLT8Me
 v7GeQO/Jlc+2sB8tXODWAaS+DmDCZ2VijC8wGMZXYfpa4XawIP4PrtETxg2rOCVgFQoU
 1bbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnWRbQb2SWOYL7lwW9yoXPsC33HYK2X0kYRwLr66R+JUbyWWEqxEvtGqp+BVTLMxvrVaxyaXfDC+GRA02QKTUzFj7poO8=
X-Gm-Message-State: AOJu0YwkIp3X6jy+gut6OFENa1ps2DVK7w/0T2CT7nXpAxPqkEiqqzYl
 pPq+CyGG9ltXCncuPUbhXcjkZv5Yq+xYenb63BZlC85wj6+UZcmD
X-Google-Smtp-Source: AGHT+IENovBB8zIqVpqa2Zf53gbdLQByDbVLRdbvFqpW892lipZHvJAOvyGTXxLV7v1oIT3My5R6fw==
X-Received: by 2002:a05:6808:a8e:b0:3c7:314a:2ee with SMTP id
 q14-20020a0568080a8e00b003c7314a02eemr1745529oij.42.1714443491097; 
 Mon, 29 Apr 2024 19:18:11 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 gu27-20020a056a004e5b00b006ee25097c2csm17441790pfb.103.2024.04.29.19.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 19:18:10 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: justinien.bouron@gmail.com
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] input-linux: Add option to not grab a device upon
 guest startup
Date: Mon, 29 Apr 2024 19:16:53 -0700
Message-ID: <20240430021653.766028-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403055002.890760-1-justinien.bouron@gmail.com>
References: <20240403055002.890760-1-justinien.bouron@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=justinien.bouron@gmail.com; helo=mail-oi1-x234.google.com
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

Just a ping to make sure this patch hasn't been lost in the noise.
The relevant patchew page is
https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/

Regards,
Justinien Bouron

