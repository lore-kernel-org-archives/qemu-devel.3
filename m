Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51587D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJGU-0005vF-NA; Fri, 11 Oct 2024 13:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szJ7s-0000hD-KJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:34 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szEVa-0004pP-2K
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:12:39 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b3e1so2782947a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728648756; x=1729253556; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=puJWoXBog/8ydctWkSxGOTiyURIuNNY5UfOdUVQ+f3s=;
 b=efSkZ7VxmqyO7QGVHUgC0HJiXWJTx4S9aMY5GCwENywNt+U5Pjwn8DrRnHsrsHLtui
 +UtCUqhYqAdyxRtRHNvaIAwz8bjneSv3fJ2mXxMAC6vHOTAX4UVbPutG2TGJjZzb4yYL
 Escu0gYLZIfd4HWIKXjg8sdmUpX6TnVQ+bs/444CrmrW9h4Hz4cY1Lx5lpTPO4gT5brG
 RXJmEaNvUapb5jwasS3Kr0pSXlN38S/x/X6hbO1/uGxqJfmz2mFaDRH7kS1I0KjLwN1f
 dwrmE/veYq8SR2yx7kFQMS6AqK9nysqPVF87SPoC9EZ2ypZ9D0h75Ku64CQnrF97JmF+
 WgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648756; x=1729253556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=puJWoXBog/8ydctWkSxGOTiyURIuNNY5UfOdUVQ+f3s=;
 b=ckWNPdnw5i003WxTBCuLkAtjzEOAAWx9ZpcngdbGHR5jaAhjgdXor3umunvzaDbL+I
 UtBVN9HZ2aiDBIQn0LIEFAjPBHIAcmLQXufvC1YQtIcV5dAamZVYyB7QFo/08qywildG
 Koji8fGhRcXWVCd3Y0FhP+Vhy7mg+QIjC7XIPn/JkQY07sIXRjIM43rXnEOTBJr/9uGr
 7a44WLkNiaRnNQFg4OZtnYQEH8Mn45c6cakCbk1KVUu2y0pMmCTSS+HiIApzBJR/xoQi
 L7q3yoh3CLn+JApylQJLGfgnX41QYVnlp9AbSNVxmqnMvHWKaVv0wLVVggwOqWusFeKZ
 Sy9A==
X-Gm-Message-State: AOJu0Yw+fzszSa25TXpjrMZCUVFsi91qWly2U00hVz+Vj2FzOFt7hHh0
 Z/163QvHtm7foEI8sQXRbmZX8JfmmPydQ1bWSb3GDWIf8WZfo6vixkmaWFy6P+GBYGkLkeEgnje
 RzMFAZebIODu+jKd4ImPUKBX51nAYuduucGNdWQ==
X-Google-Smtp-Source: AGHT+IGlgJCk120RDcia8DtaaK3bs9F0zbHRivGQXfWxGUUdW71bnLktdNciAU4N6zRSwroTuCFRUqkI5CuHDDRZZh0=
X-Received: by 2002:a05:6402:270d:b0:5c9:36c4:ceb6 with SMTP id
 4fb4d7f45d1cf-5c948d75f09mr1594460a12.33.1728648756043; Fri, 11 Oct 2024
 05:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241011083532.15023-1-pbonzini@redhat.com>
In-Reply-To: <20241011083532.15023-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 13:12:24 +0100
Message-ID: <CAFEAcA_RNb-bZ4F1czfCXJ1ARahw1Hr9wSk-1vY=k5D7=y+P1A@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/archive-source: find directory name for
 subprojects
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 11 Oct 2024 at 09:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Rust subprojects have the semantic version (followed by -rs) in the subproject
> name, but the full version (without -rs) is used by crates.io for the root
> directory of the tarball.  Teach scripts/archive-source.sh to look for the
> root directory name in wrap files.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

