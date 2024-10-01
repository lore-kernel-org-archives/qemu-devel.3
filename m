Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C33CEACE5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfeC-0007Z8-Gs; Tue, 01 Oct 2024 12:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svfeA-0007Yh-RJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:22:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svfe8-0004HE-E8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:22:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37ccd81de57so3598245f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727799763; x=1728404563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScpOb3Cf3gpb/f3RjhWE252cnOYMmwNtvgL970uxnsM=;
 b=kBTEUoJt6Xw+Vn2L89ANjtW/KoZSoNqrHkEF+Lv4zW5SEwsaAMrI31+wR5+yZxHBgn
 kCF+UZ6uNqQux6IcQtsILeDcfeneBrnDDnHuoDczK0kiMHAORTjzQPyl+6wZbdIvU3Zh
 qJ1Ffam07D2XWfBoLYDybOs5LyeGbIomnToMUkLSNqwCT9LoIv/XmcJCck26VwaT3it3
 h/8KYCyvtRJK8QKiEnl3mNQb1Aja8qqVmMC5kLadq16v0M/3lchgpBMztBZ4/TfatI3u
 TEcJ+c0J8ukSNN6RLpUOPX77Yd5lUfx8W6Q19utSJBR/ulMXkD4DSb1x6neaig6LWIYh
 zYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727799763; x=1728404563;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScpOb3Cf3gpb/f3RjhWE252cnOYMmwNtvgL970uxnsM=;
 b=l8G/cB4A9rMx6xmQCqHocQ+pIqrz9382ZFUuqQA/TOI+6gPCPDiWf9TfNpZpiniAIh
 +Y8GNZXPMQESVPHu5clVBfAV5ftehidjvfdYaxWd+IrFzx4MUeil6FTCfsiy9gOuQF5C
 RglxLkxuT2PiRf7xbgcegF3DFJxKnkV1/B+NCdnagtjRECAwKgJ5Hfkvy6ULkqh0ZWHl
 yxUQqz+lpxdVcsQ5JVdCdO2ZdFMPJcmL1u9Rm6hOmAjn/m5Zzr3fEYO8ZxZV46W3mvO2
 Cl8VMlRthBJcrAcXgsy2Tm5MjINri2HATaiUtyEnuoymKxwYnbpxS/yAV4jg/Oow0q0B
 /Mnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoc8Sp+bJ2EeZJvvzOHsZbE2V/naglfpU3X+YrP7CV9jFqovlT8b+mBmQJvEIr7Npj4vxiORtMryop@nongnu.org
X-Gm-Message-State: AOJu0YxkuZnkX6ECUb+NAWgh5lR/+IX0OI1+yE4qJ1wSAKLd1qeHTRE/
 PdaZ+3e0I4jQ/Mc0afERwdj0R4494kdWPbfqlDpPlywV0gx8cfxGoTDl3cQMRYa0AkmTVanbrGM
 I
X-Google-Smtp-Source: AGHT+IFqkEu/4OOy7nqcCujL0U0d53yAdpxy0WqclMRQnh6ax2oNlT9mIyApshljN1+/Y18XnJzOlQ==
X-Received: by 2002:adf:e44c:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-37cfb9ddc04mr113459f8f.15.1727799762862; 
 Tue, 01 Oct 2024 09:22:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd575de8fsm12027134f8f.116.2024.10.01.09.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:22:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E11B5F714;
 Tue,  1 Oct 2024 17:22:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v4] testing: bump mips64el cross to bookworm and allow
 to fail
In-Reply-To: <20241001153703.98793-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 1 Oct 2024 17:37:03 +0200")
References: <20241001153703.98793-1-thuth@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 01 Oct 2024 17:22:41 +0100
Message-ID: <87zfnnn67i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Thomas Huth <thuth@redhat.com> writes:

Sorry to mention it but now the subject needs tweaking...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

