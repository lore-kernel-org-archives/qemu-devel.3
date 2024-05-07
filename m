Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E089AC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H2Q-0008J0-L0; Tue, 07 May 2024 05:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4H2O-0008Ik-N6
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:04 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4H2N-00007R-9F
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:04 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59c04839caso585563266b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715073780; x=1715678580; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+48BOP0KWPtZgfp4Doobp5+mRrlLoRtclMPFjpAog2w=;
 b=nKJgw1cA0rjqWJ2XlP/T0KQ33rrCH4Rj5Fs5iO8+i+KYo43q9zONR/wI1rs72vSHJp
 GCRy81Z8cV9U2qteWDiDRPDVzyZJgO/4KE3FBlwx7Ucvcy/14fYcQO3yNu34DUo8Cyam
 X4OOBrkX+1SHr+A2zeY3QmqdXuhxlmTwOJqel85v0IiUofqg1v86eaLVKsBxnqnTb9WI
 CF7ayQTQJj/kUmLUTEHv9PRFaTumIVbw5G2xd9Y3DquWjoHWdv/InIv5s3WmmxHchNgU
 BkNuejzP2BPbjs59B4rwl8qSekZMxu66banSrYdJIqd8Z9Q/x4eBl8qbW434GkztsFym
 UXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073780; x=1715678580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+48BOP0KWPtZgfp4Doobp5+mRrlLoRtclMPFjpAog2w=;
 b=WKyxOR9qS8fzrIjgDzGUisbaPksY8T0NG1Yigi61ncKV5GvsWgif/0WVMRh6yQq29S
 lnQ551mDWh6Jqa3M3ixjXT3QqLamwTTTcW64Hh5If6tBR7qAs6r+hJwrW8bIDgdZzjpD
 LLf1oCmIsATybNYc4IOT+nTc3Ya7EAQLa6Yr2ZRikX2lwtSbHcy3bVD9J3dZMwcIPs5s
 HiERFprSyC6pIyYRl09BEYtr6JYLQdoFhM2vC8R44j0deMcH1OIMFH+hPGYf9BG4Sz+3
 AmPNr/DKqhAqOA2DgrSuryaRhMLxFSXJjoFCzFolmR0D5detTLbmRJEZ7sUe1vFX8OWL
 tsQw==
X-Gm-Message-State: AOJu0YwJT1WF6tXd9WSmJvM3PARk7NF21DkQU7cNpxatzWLYotMnLyVM
 WIw3rrmcVHqF1nt65u2Q/GOL35R+gWcDWCg/Dk0VZ1yi9AmNMXXtRsk6v/CPDUlKawOzhGLez4E
 xUkBU3zvtiW0f0R9oXhN3RVREwDQRUsjQmvelOA==
X-Google-Smtp-Source: AGHT+IGEcraNUs1+6cCHzrrRat5Jk9I2ULuxD2n3WlM8sK1vbN5IAa5DrIhPS73EdfJEZNetgTO6Hm06QUHOmoOCpzw=
X-Received: by 2002:a50:cd93:0:b0:572:8aab:441c with SMTP id
 p19-20020a50cd93000000b005728aab441cmr8210109edi.26.1715073780275; Tue, 07
 May 2024 02:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240506202020.422514-1-richard.henderson@linaro.org>
In-Reply-To: <20240506202020.422514-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 10:22:49 +0100
Message-ID: <CAFEAcA8qs-uVcuFKez8QKsA92QRjpD_YxbosXKf7sDao9OiR4A@mail.gmail.com>
Subject: Re: [PATCH] gitlab: Drop --static from s390x linux-user build
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Mon, 6 May 2024 at 21:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The host does not have the correct libraries installed for static pie,
> which causes host/guest address space interference for some tests.
> There's no real gain from linking statically, so drop it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

The lack of rcrt1.o seems to be a bug in the Ubuntu Jammy (22.04) libc6-dev
packages. It is present in the versions in Mantic (23.04) and Noble
(24.04).

thanks
-- PMM

