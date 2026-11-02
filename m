Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FE606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SKtodSHp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNosu-0004H4-AR; Mon, 02 Nov 2026 05:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNose-0004Dp-3r
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:03:11 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNosb-0004RR-5O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:03:07 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b05bf699easo23842977b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793613783; cv=none;
 d=google.com; s=arc-20260327;
 b=jQoftRPr7rD1gFpJtrtmenZ6inkJj9lo9ScALMYw2qZ49LM3ZSqlukebVvRUXFgsq2
 kJwTkdXvHikwUy2WRDY/3weOY9xlMc0SpVgRfGFT8DLlbb2YpBASTUqwLiLNQui+65l/
 Rxu6YSQNIoaZqiubzeAlzNygO24BhYFstFBKtwVHmk56tXcfhelRB3tMC1VWaVPugSwv
 RZiS7pGbjEwy0V78UivAVtD7HWEtrs5tKN6urUCe9W/zby843+/g7t7l2HHPFL7wLdiW
 aF3U48LvnsZDX/TgBb/Eqlr0r5zuAEvdIgGSK9Plpl1JDhdhg3lGuL1rmPfVNV3/UNkX
 EIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0V1vKtG4hyuPDUwmCsjrtByO2owPckznkQwt8npQjWw=;
 fh=NjqIG6zpqtwHcKucWOTZU2Rso4Cn86+gAa5lTzqImgQ=;
 b=dMg7AeTR1m3LGJ/svMUc5x9sgIuItz4J8Kge/MYV82n5AT5kUorCp/UrYtSwpaoaZ/
 UL6Op14dT5ZdLTJgNoslE0cFcNjLr3URMHNISlNaXluR0ThKnd+o8BfO83QJT0PfL4nk
 ZxVvs5u5lKG8XJAB//LCjEiHAvazRbTT7zN3Whd1ErAcsstX5uNuNlyal5aWIebPByqf
 kzjGrQOYOZZEYXQR/X/Hh4lpPSAN7rUcHWFyiJXPNI1vCJDEi1ZrsREXmSf+YGn6CJnM
 tljiLNbphV62vCXaP0n+PydD3nEHoV1q+qwk6SDxKQaM4YOt3V1nXjaH1VcXp84GWi4b
 bJFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613783; x=1794218583; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0V1vKtG4hyuPDUwmCsjrtByO2owPckznkQwt8npQjWw=;
 b=SKtodSHpDL8KsHP9T3c8G936AQltw6w0seFloc/Sy4qIscaL9HERPwcRBD5gn9Sg5O
 LmbeAq21b89hzsED+dUG16UrzuDylopt1XYVdyxP/ahjUulSaxl5RemW1n1vgF7NLdhP
 /q116bYChuu4Ygzy536vEFeLuJVDsQHZf8yvAedGnMnKk9VBgf1nFksb6Bpr8aglfXYT
 cTMsylzxxbUOH+ZoxqTsSf9MmOX0QmAiDSYmUr4ynp5mhnLhAjSwvpg7OAfdqJNcjN14
 kk8+v3lITShDTiP5Z9UsgDyBqYjCNVSPD03ebNZ9ibSQt1QGRl4F9nGuG9yv+x5e9WHr
 ChQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613783; x=1794218583;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0V1vKtG4hyuPDUwmCsjrtByO2owPckznkQwt8npQjWw=;
 b=t04p8S3Ll8EhdXcEyKxpjacBzfk2j+8dPhdj13EYri00DJH/xbq/MDUUYNyQfMZZe4
 82wKYlrXKu2aLxAtd61MbN3g11B+cWEGZDEE8Tu1JJUtDonPeevn0FJwQJQ/q7i1a2Bw
 Ay7qjmrGAA+a2spZZG6nC+bxAbP5GCuGoTWtkHlWxvLm+nK9r2+VPk8xHMxtNKbRg+Wr
 1bow+XKEuntaD6k45PBnOgLIwkF5jG+/wy6JYqU2F/E3WnR8FbH6XV3qc/geHtXCHfMB
 HoxRi/DgIzicsoFVZfRBdkZQP1rOvWnoRa/X4xqOQZLFLBVvifEKto1YK93JZ+jmJVLY
 QHqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBnREoG+GNtHOQs9OtGEu3jQ6Y0g0GYoNgdpzHtpTuZnVlaTpNp6bi7XqGQ5i2ck0Eg59n5FV6pH96@nongnu.org
X-Gm-Message-State: APuU4Z/UF76TB4QU6WnGge4cjzDq/vgxJ7w+VFJMiritruSwmnP2Du5v
 5kNHfkldF+VlKBOv9WvPyUEzBqsqEfHFD6Z3ItoyalLbhZmTmSvBCi/ViKhlsFTcj/KRvv3COtn
 aaiZUvB9c7Z+2X5mP63Lvid9sSYyM7Sy2mJRVhSI4qA==
X-Gm-Gg: AYBFou1H47Vn5myFbfpxomaQ7PZdWoIMsGeM3Sk7Oe4TU3Smde2ZfHSqFd+ngSaUskb
 itBCTzRCCtu3KQrhjbI6q4mQEl9laTBdVh2SBul91/SOvE2RoF6wzePw2c5EuK9WtBVjOnT5VGZ
 b2qZ8VB3tcX2x3XpODpkK1uALSN4evWDqYnaw8Rq9AJcQBIpjU7aCwzsxgdmbsOyX+zKxatFEzR
 CZdcWr6vUvZmJL7Rg8ddODT8hQ/kIdPdRxgvKym0lCCJiSj4DheLeHVgrheHBBpbe/MDqs7GAlP
 iW0ESZDRnzSJOJrCbfsF93SraqyNrLIGlD0lDTUeQXRQZ5R4+AlXEyVBVkCo8iOE8vAox1gtPXB
 ogErERhNorYAh5PV+Onllfe75cTLOIIyl7jO6WhAx5fgd8F64ainX6tYuZVIivHw4G8Mu3cPinK
 CP3xo06f7QFsv2vNYbz6+K
X-Received: by 2002:a05:690c:e3c3:b0:8b0:c8aa:d108 with SMTP id
 00721157ae682-8b2b675903dmr49450937b3.41.1793613782882; Mon, 02 Nov 2026
 02:03:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030131406.461599-1-eric.auger@redhat.com>
In-Reply-To: <20261030131406.461599-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:02:51 +0000
X-Gm-Features: AclHuK-pzougyNW5YELHEwFwdIbt0EcKEyG0x8JeT_fXGTB3TsRnaKBbI-u18ak
Message-ID: <CAFEAcA92=yV3GFD7r+g4e3+j6aW_JYi7EZfxeSAwTp=Bip0Muw@mail.gmail.com>
Subject: Re: [PATCH v4 for-11.2 00/10] kvm/arm: Some refactoring for custom
 KVM host model
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com, 
 mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 13:14, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series contains some patches initially introduced in
> "kvm/arm: Introduce a customizable aarch64 KVM host model" series
>
> They are rather independent on the actual custom host model and can
> be considered as a separate dependency. Would be nice to get some of them
> in 11.2.
>
> Can be found at:
> https://github.com/eauger/qemu/tree/arm-cpu-model-v11-prereq-v4

Applied to target-arm.next, thanks.

-- PMM

