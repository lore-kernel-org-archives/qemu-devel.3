Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED16C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj32M-0006SC-2p; Sat, 09 Mar 2024 15:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj32K-0006Rh-Ap
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:11:16 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj32I-00020H-9t
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:11:16 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5682360e095so2949335a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710015072; x=1710619872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qVlU4OMX+YaJ+7hrZpRAdZX3eg6PYc7U8L42CwKIv+4=;
 b=upklr5tUESL24XvowthK4k5pNHvQW5HbDtTvV/1Ay3/37+QJtIhQZmE4a0ZdFjB8AG
 fs/BwZ6SSCk77SJfpnvsm9cK3FUqvAdHxllYJCae3mXELcHc+TlAUG/ttx4zZ2Kx4u5Z
 VAeRxOhaoLRM9BdcicieccGzPy+RaPsJLs2EdQyArkKXxoxgFUYgV9Bm1tvrxuApbuQ1
 fRilRzyrmLKNVeMGHe5Dp0xUUOqNCmBa623bifZVdf6vuyqmLdvU5z7FR11yN1s7Y3U1
 CFdPw0+uz05pIdY9sEpLftJwChLmXI68Up4thtoyuWFDLxSLaqIzlD4HWBEqYR1muCVk
 0Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710015072; x=1710619872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVlU4OMX+YaJ+7hrZpRAdZX3eg6PYc7U8L42CwKIv+4=;
 b=GOlgjd1sG3t2QNIgS539TS6yNbuq9lX/UV/0QeQBcuOi6omoD6IrDNZv1haeMgrjHE
 Tk8kg5K8y1JlkfKEzKAMhwqtceSihaxHfyRBYAh1poSybvSb763KTKnexugZljrL+dI3
 m5IVEk8bGbaHKVuTDg0grUnlncC0u1sefdpLZoKYisKUL0Acg1ZknffJ6sjShIrSh5sZ
 R0cVS8Osf1C8hhpMcOFlctPIq+OjjQQQaRjSvFvAO95LR2Bt5dYBCnq9/7FyB1cFHZD+
 erRgUobI+DYKH8QYKS+PQqwLDgaKkiP5d1Az7smLV2CzM/MRWo4n3AhRuK3SxhYSFk0w
 0oTQ==
X-Gm-Message-State: AOJu0Ywu7Iaym4GaRclFNiQf1nSWOEg6TYijBUauTwbLusICDXjnBdgo
 KbWtJFTyXZy84NXHKovhS33esClX1OGTej6lywz1ZOpNw55EyUzyf6TZiHHU2BeYCt6T2ys1NkH
 0y6qZ4yeHgqmkclHCwasqdhtxC+FC7C6ikxCM6w==
X-Google-Smtp-Source: AGHT+IHI4uGRT+6IYZQSvTC+Qdb4AHCq6ul6QAiaVNTEMAJ0stpQ/DR7Yx7HEqCzALb40uKoKvHLv+rZX50k8+x5Ry0=
X-Received: by 2002:a50:cc0c:0:b0:568:2578:f50c with SMTP id
 m12-20020a50cc0c000000b005682578f50cmr1816061edi.36.1710015072073; Sat, 09
 Mar 2024 12:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20240308181202.617329-1-pbonzini@redhat.com>
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2024 20:11:00 +0000
Message-ID: <CAFEAcA87jdkm+HdxJfFstrZMcsvFnPORR=yiBaW=i_wRiW6jEQ@mail.gmail.com>
Subject: Re: [PULL v2 0/9] Misc fixes and coverity CI for 2024-03-08
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 83aa1baa069c8f77aa9f7d9adfdeb11d90bdf78d:
>
>   gitlab-ci: add manual job to run Coverity (2024-03-08 19:08:23 +0100)
>
> Supersedes: <20240308145554.599614-1-pbonzini@redhat.com>
> ----------------------------------------------------------------
> * target/i386: use TSTEQ/TSTNE
> * move Coverity builds to Gitlab CI
> * fix two memory leaks
> * bug fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

