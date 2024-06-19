Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18256C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJitK-00085R-Cx; Tue, 18 Jun 2024 20:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sJitI-00085D-EB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:09:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sJitG-00061Q-0y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:09:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f70ec6ff8bso86085ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718755766; x=1719360566; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rxyf5g8UAW2bEEM6pY/sYRcRHjCvsO7D4Aq2yN0FjfQ=;
 b=DPhqWS2J7j8zwF1h0mxFLCwBYH+XIZ0MkXZj1YGErCu2IfvCubybUo3wcOvXblHyzv
 noX8IEBptxPXsn42ieSuubRnVX82bfAOyihcBKYZtqHqXhakyqX204HS+wfR5XHzZKjs
 WLK36WneluCiD/p3Gg3OIm1fiigiegc8GLhTBvm2l6Wi6a+zV1frnCmQZ8Rd9dYUCGWb
 WNB0fQtpP1YclvO4TMBmWAGuJ2QQY7AqZVP5SNc2uvzNazsuKmEnS+VYdDufSUDw7H9q
 QWLDkwJXCtewopLJX6LnSbJBopxch2g3V+ZWWSnf+yd3EiqVXsyHE+lPbWU9BQ/ALIhy
 2WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718755766; x=1719360566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rxyf5g8UAW2bEEM6pY/sYRcRHjCvsO7D4Aq2yN0FjfQ=;
 b=iCQJlCDkNy7O3IwscQFsJdRgMpaQSYYp+RRJF+v+Z2J4iV+w4kTVufCGqX0yVuKyd5
 ft3GRzN6xjipq2y5Jvb/7wS6Jjk8U5IuQgI6Ljsei0jcX3rZP8MvBnDj4ieeQ+xbFOrF
 TsRqNSxxa9bonltxARAYCdP+KVRwVsWwEr1y+ECsGlYiTkGp5VGTo94tzES/shoE8wt7
 i5+zkU2mkc9PHGKM4HL2PluKhtJehUhJjfN8RR8h5WGnJWBQIP9CLelfZcm4XhjgDNTJ
 ULeeQwcyutKiuBHC2ZgubFR784zZkLn1xJe54kSe96UuLPRq6n+457LyQbYNvkqPZb+D
 9CCQ==
X-Gm-Message-State: AOJu0YzMfZyUO848xLqU1Gi+ZKAwwlmbzNYv+ArOZGl7v8B5ntxs7kMG
 NiMSgJqXvPrfArBqNAg8AZrioZb7/1fnV+8JEHFhHIupwwW8TiTlTWOSBj5i30h23wuJUq0L3GN
 y6C/+Ud1g6XAQq+rX8z/qY0FW7sumllWS/xcV
X-Google-Smtp-Source: AGHT+IGRVNwVMhW4pPpxSJuZVBmP4AObiR26wE0WB40pEY24dyDJT3EIZNbQHiKBnvcfQOptgrTTkVLc5mMzAS/6a9I=
X-Received: by 2002:a17:902:6941:b0:1f6:8836:e43f with SMTP id
 d9443c01a7336-1f9ae0a77e1mr703485ad.17.1718755765354; Tue, 18 Jun 2024
 17:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240618224604.879275-1-rkir@google.com>
 <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
In-Reply-To: <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 18 Jun 2024 17:09:14 -0700
Message-ID: <CAOGAQeouhTW3ZcjCB5H5DpPLH85vc5r5Nnh8Aj+0woPvv3tmtw@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, jansene@google.com, mett@google.com, 
 jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=rkir@google.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Richard,

On Tue, Jun 18, 2024 at 4:05=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> We require "char *" with a space.

thank you for looking into this. I sent v2 for this one.

