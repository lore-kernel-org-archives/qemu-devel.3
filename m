Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B7C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8G8z-0008Cc-OT; Sat, 18 May 2024 05:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8G8y-00089Q-EM; Sat, 18 May 2024 05:14:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8G8w-00025k-Vn; Sat, 18 May 2024 05:14:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so8315135ad.0; 
 Sat, 18 May 2024 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716023657; x=1716628457; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiHe0oEZSeW1JDPWcUaQPi5V3OR4e5diggr729BPIxI=;
 b=cFChYwzRnEowED3OBz7/DYCwmNFP91qt4i6D9IoYg61FSppZ8dKn6HZfVQZ9M35OxA
 rMvx7XAU8t8dkDdyB1YRO4lg5f678Se5rlGcTUsdQj+v1XthbLqCuASX6gc+w365124C
 ARK7JU93E/3HXCJ0hUzDtsZqxxq/mevCjt87TulCcTtC/8jftvCOWLJHHPvKHbQCYlYt
 +jkt9iL6c/JgpzpYzi//SHv90u5lmmzndGfaX7S5m3WuzA6TIfevBpM745EXLJ26KhxL
 7q2aTW81x1GYu311S/BjpVMSUO5V6miDFXxKkGBEkHh8DoRxAFVR5A8Rm1Nq6uroeSNq
 Zm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716023657; x=1716628457;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hiHe0oEZSeW1JDPWcUaQPi5V3OR4e5diggr729BPIxI=;
 b=fSd2FyXXOixf/uf2sRSD0qLkZU8GovXTW0eYRZeSZb8z5Y/1AaGckWd3v0mjoWbJGl
 IbKx5hOBN6ksNzp8ZaGQxDluZNBhnGRwFj7XwdFvErd/oQRzp4Ec+ld/fHT6mTYV6L/t
 eNhfMBvZBDDDgaUXDL+9b/y+X2Th79904IRcED4A7hKEbeUxBq8fhKTkSd5Nms2OHrI6
 npxdzctkhllnAYyoMChoR3mQ4IH5l3/6f03GxhDabYGGY7qKl3OvOSdPxixDX1p7uuHA
 WU0yhA2LLscTEKyLjP1wc3fcfro8Z5HJKzsytgYi9DNj5FzSWYP3/3LFWMJdB73vKx0Y
 0Sbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZTiP/G241R+g3DgfJXQr5ecsDtGoVwhcRTmDUvTSHN4KtdIJogSH47UhEeBgUDYKTOmBS8/N9ooR43GFS1xrjwY6oohgjYuOsotwl64zqhZ6jjJBFpPCpM6w=
X-Gm-Message-State: AOJu0YybDjvB5JCfto4/jfHYS6aD15CLvAF+Se7btsWd5tamI3tsyLic
 91lT7ohivBuKxkMrEcK5TliFuCSE46was+OuLO6piF5r1elP8m72
X-Google-Smtp-Source: AGHT+IHHXTaO7gEdyb127SZQi+l1CKnvIW0UsDqg+jtwHU2FMfMdb5fDVnKxuoPzbm4DZ71b8Jb2uA==
X-Received: by 2002:a17:902:f68f:b0:1e4:733c:eac8 with SMTP id
 d9443c01a7336-1f2ed2c514fmr20016085ad.8.1716023656909; 
 Sat, 18 May 2024 02:14:16 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c035dc3sm168737445ad.197.2024.05.18.02.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 02:14:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 19:14:10 +1000
Message-Id: <D1CNM67REA8V.3KZRSYB198ERM@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 00/61] Misc PPC exception and BookE MMU clean ups
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Mon May 13, 2024 at 9:27 AM AEST, BALATON Zoltan wrote:
> This series does some further clean up mostly around BookE MMU to
> untangle it from other MMU models. It also contains some other changes
> that I've come up with while working on this. The Simplify
> ppc_booke_xlate() part 1 and part 2 patches could be squashed together
> but left them separate for easier review. This could still be continued
> which I might do in the future but this is long enough now to be merged.

FYI I put patch 35 (only taking half of 35) and minus patch 28
here, will merge after some more testing. (Don't rebase your
series on this because it's just a throwaway branch).

https://gitlab.com/npiggin/qemu/-/commits/ppc-next-test

Thanks,
Nick

