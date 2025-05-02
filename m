Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFFC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAplW-000627-Ky; Fri, 02 May 2025 08:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAplS-00061j-5R
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:45:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAplP-0007bq-L1
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:45:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so16429025e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746189909; x=1746794709; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wbPnSyO/WCbfKavlxLxWhGakah80+RQ81JjBl7ovjQA=;
 b=aKzqI+KgDfSOtuu7f011GLnYy6MRSByXRuj/0e8NbVboV9BM5T7dB+9tOn+Q/1rDN5
 fsQ61CmPrx/UE7C1T/hlN1NkY37x4ySkvjOsSwLGka6FNw+03CgMoFa6sQH6ctHkbLxP
 BSgDr9hmwrJWG/DGJgnQND0vDCVNtuJ60iGRdKPpskVs5DYqZ9uElMdnVa7AmCVT1xgC
 UAv0XTVEdKe/O03zVdfKBBOAoHae3JiH+Lh8kinp8aNW9njYU+uWkx8qd90CP9bSTC2u
 hwcAHu2MQmuQXoyrpS/dPXKTjKifDEJN9c6pM9VyVxxYgM0LxORYtx9LP4py0fbmgsB9
 er6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746189909; x=1746794709;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbPnSyO/WCbfKavlxLxWhGakah80+RQ81JjBl7ovjQA=;
 b=q3KdTQrgTtvxTJJRWGseGRwzpBFT6RSN+P+qlthNfKs1sCIGDapILmd0inPSOijt/p
 uPdTY5fWOdZkCn1O87RBhn2rtgyHD6PskPHuBuh1MXwlbiIGt4iSGcUjRE++nLpcb7rF
 0Rr5j8qkS7PkxkktkDiHCgtnGPMLdJnWOS3UypcTdKNcgEh2FAv9ODJ6yx4LYoqDog6e
 cpMXMFAaore6aHff4gQpeqJagMMQ0gBJEhk6W5AAfjvJhRk5QretXy96P3+6PTBvtGXE
 lNoyzY5uq9X+J1XxnlZhdz/dxjCWGrGUyOJZNpKelv0sTXp5/0rcCNeH6+P5kSpal3nQ
 fcjA==
X-Gm-Message-State: AOJu0YyWFCNUojNyY/OW6FxeSbcxMSd+Op7j9Z6fSGJoa/2y5M2QvHYO
 JwQwfdjKqMT9WqY9EbqTp1PPc6JlaUl78h//CiQyBKPvvG+01OmqFsOEhxu6Ext5xonP9Il9S1p
 x8gg=
X-Gm-Gg: ASbGncvuWeM/Ec/dmWbk6WpU9Z7C0D5VFz3gBj06q00osbo4wAWDP41xQbzGMeoqVAO
 +DlpZu6RhEdMGdl3rPpt7e2sEEarZxX9OfvUtbOMoiLD3bFJxM1DvAdNyvWDnrnelN9JFTVAmFM
 LUCrTFix8GYj8lz2RKwkU/cLAodcxdIzii+dYI/cmS8sMPfI4GNp4IcoJpfKAi45ZOFZ0NmWylo
 +M1Gju9L11/m0ldN11Ci58oEkKeb+WdBOeyGCfi4ounPGZd+leJ+FowE/amLtu+59wALfuYc11C
 MwBM00XGDKUTxmvfSUGNZY5VNRdODPZqkRn9QA2SaAJ+jpmgitjJWPNohIfzqZ1ojjtZaMBQPUL
 oB3MiXA==
X-Google-Smtp-Source: AGHT+IFf6K/LWUxWTHV2+GpbF2DvBxr7xZ+hv7E7lNLI+m2chz0Hl8gyq04akU7Q6VZxRO1MzqZeaA==
X-Received: by 2002:a05:600c:828e:b0:441:b3eb:570c with SMTP id
 5b1f17b1804b1-441bb852676mr27417045e9.6.1746189909079; 
 Fri, 02 May 2025 05:45:09 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315d3sm43996935e9.36.2025.05.02.05.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 05:45:08 -0700 (PDT)
Date: Fri, 02 May 2025 15:44:10 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 3/9] rust: let bilge use "let ... else"
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-4-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-4-pbonzini@redhat.com>
Message-ID: <svmwr7.46e2vcedtq0m@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> docs/devel/rust.rst                           |  3 --
> subprojects/bilge-impl-0.2-rs.wrap            |  2 -
> .../packagefiles/bilge-impl-1.63.0.patch      | 45 -------------------
> 3 files changed, 50 deletions(-)
> delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

