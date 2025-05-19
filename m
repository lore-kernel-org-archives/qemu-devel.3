Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 21:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH7qd-0007uI-Cp; Mon, 19 May 2025 17:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uH7qc-0007u6-1n
 for qemu-devel@nongnu.org; Mon, 19 May 2025 17:16:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uH7qa-00050a-7Y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 17:16:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-231e011edfaso37886465ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747689390; x=1748294190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=104EC20XdaLBJzQFWGmFNCvPEA0lzfVozLjB3hPd8VA=;
 b=MeM0s6T+KZtu0FXc4Z9BImH1cbBtz8RKEhX/4XWi2o7zZKtxJSU0ts6FeaFIsaUCkR
 qC+rVU5x46NZRnq3Jjdvi2tOwwsiQzLTf691DZt5ZY1h5OE+G3j+FFDL9Fewefdarw12
 aZSLNMZ5xqkqTYTCyVcPtc978M+m4/y1DD9KFx6LsPrtI7Nx5jT1YG9jIOuHUnavJsJv
 qTjJq9rz9DlzJZ566QlSQUMkoZJsuxCnVlxLwHHAlsWZh8POrqJGBlfkTHuxAqF+XE1u
 1Jczd0GpF2QkWRsRLDWpQphs6cWDjGxaAlS/M2xGWgcN379mMCRdP7X/ZrK5U1vhAfDo
 P5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747689390; x=1748294190;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=104EC20XdaLBJzQFWGmFNCvPEA0lzfVozLjB3hPd8VA=;
 b=Vp7PGq/Gm08d/3ls/364Sr2zIYltpOtV+FVZFQwLuRTLd+xQY8UDDt/huxQgWehnka
 taR7uyy0jveiP4jOzyBNlhZ0b9etm4oNUjTyXvyj5dUllSkPk8PyECOsz///UyWMnnfM
 btIRPMr2wwL3RBFtN8K7fzH5l/eYIDSxhqhUbtri0BZtVlwuc1Cz8WWjz/awwnzEFOJ5
 3BRQ3vPL8vYtOaZp+PDq9tydiES4oJmtSo0JTe+UAFFIakZR9tq74ForHlQRBUv+U4cd
 BCp1FiYhQJfwqzCJmyJEefMGCi4AV4HrXnunKf2Jx6Gi5L3lkr84c57pm5felB0VnLSI
 a7KQ==
X-Gm-Message-State: AOJu0YwP1hfaJHXi8W/x4aQeIxiz4QggSwp8n+j+y7mnXgD3HD+su6vu
 6WmppvAnTETD0LIao7S3uskhJA0ZhH7NcM+q3Citx6SkAoj8iVgWT3EtiMfFGm4k9RaBesMshah
 4fI+w82JpugWec8/rnhw2c07XPWagr5M=
X-Gm-Gg: ASbGncuQD0uxjRIhhAGxWcuku6PodkJtPF7uoMVv0ni1A2zecTcQVxgo4jOoODge6WS
 4tTD395ZFyhFWs98JFH1FUKJU8WwxVLRmalYSDu57MJrqAX7BsT1eAzASGW5z8JMc5z3iUvFmv2
 JWKfwr6Zya1J43LcW4ZOsZB+hS2B0pjN0=
X-Google-Smtp-Source: AGHT+IE4NAWD9lsB2sF9QzQ9bXowErGZL+p3ry3ny/eJyt4cYu+zgMMoDLx8cbsehjNxOaCkDhXgdbrlgNm04bYmPsA=
X-Received: by 2002:a17:902:e78c:b0:231:d156:b26b with SMTP id
 d9443c01a7336-231d4598d28mr234128885ad.38.1747689390141; Mon, 19 May 2025
 14:16:30 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 19 May 2025 17:16:14 -0400
X-Gm-Features: AX0GCFudR-6Rqk1QbWh074E5CeENsR3KWm9U93V5Wjeqk8pYETkntGCBY7014XQ
Message-ID: <CAJSP0QUrkSK9FGXBCTmCOQD6QT1gK1SmvWxr2=C6Y5_eTzUx8w@mail.gmail.com>
Subject: Orange Pi Armbian image down
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x62f.google.com
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

Hi,
Hopefully this is just a temporary issue. The functional-system-debian
CI job is failing because the following image URL is down:
https://k-space.ee.armbian.com/archive/orangepipc/archive/Armbian_23.8.1_Orangepipc_jammy_current_6.1.47.img.xz

https://gitlab.com/qemu-project/qemu/-/jobs/10082011030#L1037

I can skip the job for now. If anyone knows the contact details of the
Armbian project's server administrators, please let them know that the
download is not working.

Thanks,
Stefan

