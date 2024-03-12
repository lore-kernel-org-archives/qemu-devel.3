Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA487C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7Ya-0001Qh-Dp; Tue, 12 Mar 2024 15:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <senserk71@gmail.com>)
 id 1rk78A-0006bN-89
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:45:42 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <senserk71@gmail.com>)
 id 1rk786-00027P-6w
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:45:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29bad5f4ae8so3404155a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710269136; x=1710873936; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l0yLCiTMOODG7pxbVyIL8karU7sUlMb3byO13Y4KVyo=;
 b=QLcu91yuO9MpS1FLCjDdQz+0bOKj6onCt3EtFFCuqZQUBIp1K7GXeernOPB331LJGm
 5GWa34I7uYpYcD2w9Q1wcP1Z5cwm8agq75u75xCx40Z+4933qI3Fw6mWSDH8biHIgw+x
 4ciLAbCuv5XoD3Bx50Fw/LjwfmjKicYalJGfWBeJRcW3y/9NSGyDP9pbW79z8JMO0G9P
 t7K4Bda0FJ2E/ONX/jJIBoHzBWiFKc/JrLnEudc1IAzqNbup0t4IovKkWGFFoopQegzj
 PbrpoLUZ3vCSsg3fuWOFcSasxh7OA7aNlcs56CZusUAYBhFHAHla+UxmpBGuOx4TrmIL
 H9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710269136; x=1710873936;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l0yLCiTMOODG7pxbVyIL8karU7sUlMb3byO13Y4KVyo=;
 b=QlzPbnRGhAd+4yWJqtPQsCMqM5wWTZY3yREnCpYp0R3/1etCTvqUNo5SKTND9jhJUr
 RWiLy4jnCReojvBBuA5ZM4OKf3nVrXcWXNgZzh2Gw5rSXZ23pWEmzb/cc/ED8bW2Um0P
 KtFNGSs8E4bDKi6Nv2B47ofnpnflClcaVY6BSqbAUZJjOT28YILi5w1p/M82wJd/oYcY
 gnui1TBKuBuvis1fl8lz9/90AKaHeYG8D4gcQMDeOKMbCIhLxp+uzG8QJD4HUW0MhqXn
 mMXxfAGBPuXW49PajTwIyoqWt0oCu/5yA3H08BUAsMsxBTAzo9ZKZFnnNtlai/48/LFg
 OzBQ==
X-Gm-Message-State: AOJu0YzOqZrTqo1H4GpIlPxtQGyU8052zepWgI+Yx2e0wHL4QVJ2p8uK
 U7ST7PUYtYlXo8qjMvIIf39byres+qyAzOKtH3NWeHnmz3ikxkUeL202iZ7R6F3yL6CnlCVKikF
 bPGP/WlycGyi8UTLNoNw7KuV+1JdxJ7nI1oWYZg==
X-Google-Smtp-Source: AGHT+IG32IaZ9N+5bgFXYTWbX6E3U3J4VMBATkbjvl8r6iIJvn9QigLsZiCQ6eJbyUmN9dwUJS8I10PVfivmoVgbDlI=
X-Received: by 2002:a17:90b:4b4c:b0:29b:ae33:6ffe with SMTP id
 mi12-20020a17090b4b4c00b0029bae336ffemr8770336pjb.2.1710269135807; Tue, 12
 Mar 2024 11:45:35 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JzQuNGF0LDQuNC7INCh0LXQstC10YDQvtCy?= <senserk71@gmail.com>
Date: Tue, 12 Mar 2024 21:45:24 +0300
Message-ID: <CAL1vMp0KdjfVMOnLcDxr9Cdcvr34jp2aHorZ3F6ibiSRavLiiw@mail.gmail.com>
Subject: Possible memory release problem
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004f6c9b06137b1070"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=senserk71@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Mar 2024 15:12:58 -0400
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

--0000000000004f6c9b06137b1070
Content-Type: text/plain; charset="UTF-8"

Colleagues, can you tell me in /migration/ram.c :2837 whether it is not
necessary to perform memory release for block->bmap, after memory has been
allocated in :2831. If not please explain why

--0000000000004f6c9b06137b1070
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Colleagues, can you tell me in /migration/ram.c :2837 whether it is not necessary to perform memory release for block-&gt;bmap, after memory has been allocated in :2831. If not please explain why<br></div>

--0000000000004f6c9b06137b1070--

