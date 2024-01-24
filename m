Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C168FC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 05:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSVuA-0003HH-AJ; Wed, 24 Jan 2024 00:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSVu8-0003Gr-KU; Wed, 24 Jan 2024 00:34:28 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSVu7-0007GE-3B; Wed, 24 Jan 2024 00:34:28 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28e79182570so3847743a91.2; 
 Tue, 23 Jan 2024 21:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706074465; x=1706679265; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTxS4ujXScBQ9YJeb9/hLV5tSH4IEFYFpQWvdNbqi/g=;
 b=VSH1SVXCBzytF71Dbdo26PSewuJgcx+vBxelLzYT2qlz0WM1M/oOWZfW3Wl5ouQlIW
 aSbjGv3CBI9uZV54XusNc/2Zq3vXBzQpDMlFEs4fWTyaq9BNar40h6i5IwTeT1D7OWjD
 KeRyMmnWySB0OwkGw4NLYRCitXxf662EGp81koqU2d+laTYgNxtxLTc0HbpOWQ4CaJf1
 CD1eIBbSfZySBQ1RcpK4Q9z6wny7wD7b3ayhELMqOacQvbbKzpsb6ZNvB7Qx8+65Qoyb
 1Wj8J1S4S0ubZCbbtpCJ3RpZbR93m88SIWvkNSrW2YTCjDz+Uqhm4pFg09voRw+VkwpU
 b82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706074465; x=1706679265;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZTxS4ujXScBQ9YJeb9/hLV5tSH4IEFYFpQWvdNbqi/g=;
 b=GxEbFE7M5kJNRniHhe7U2V0CRwSg8R44Md9VCYurkydm6r9tevOufLW14chjN7uYzs
 c99Ng484CUZWlJpLdCTw5qbqYjfVYN7fBqZwYqiRnURloBDWKw7IoekLRnpih6Z1N5N2
 ZDcRGcqcsoaQpuwVnKbY2gXrZN0wUG2sHaEq0Miaq6ee2eA+ntaSmiCtkNjOmJwuz3AX
 Yd63HmUTngspOiqWC2grTH2sJnKOoNb1BhUnYOj/Lddny+4etz645ogMiiOMmgVUmlWI
 KpdnGPVSIn0/NECNxscv+gjK+eQQxkQGHNQOpJYTTyQU1N+9dKAo0/5WNX9kWeQpc3Qb
 Ph9Q==
X-Gm-Message-State: AOJu0Yxq5emc8zHzNRAkXOtofT+Efx7sPEuasuFq9YFDzitvEr0lDASV
 8UnG3jQCohjKXoDdyLF+IGcR5PYfvVdRW1ZW9vQjpOapeMpwN98R
X-Google-Smtp-Source: AGHT+IGjTbeE4wgH7xQeYTCDtosGRfeULBDtyT9U6UXb0Me4sDqHUpuAcuX76O1k4NN0L96KU+6rZQ==
X-Received: by 2002:a17:90a:bd03:b0:28c:cec8:cfe0 with SMTP id
 y3-20020a17090abd0300b0028ccec8cfe0mr3931622pjr.94.1706074464744; 
 Tue, 23 Jan 2024 21:34:24 -0800 (PST)
Received: from localhost (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 qn13-20020a17090b3d4d00b00290665960basm8289646pjb.43.2024.01.23.21.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 21:34:24 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 15:34:17 +1000
Message-Id: <CYMOX5U1GW3G.OFF4LRUPOYL4@wheely>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-devel@nongnu.org>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Thomas Huth"
 <thuth@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Cleber Rosa" <crosa@redhat.com>,
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 4/8] tests/avocado: ppc add powernv10
 boot_linux_console test
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240117141224.90462-1-npiggin@gmail.com>
 <20240117141224.90462-5-npiggin@gmail.com>
In-Reply-To: <20240117141224.90462-5-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This test seems to be flaky, it hangs without ever getting the
MTD partition message. But I think it might be the init process
quieting the kernel console messages that just happens to run
first. P10 seems to just hit this up more, maybe small timing
differences.

So I'll send a patch to adjust the tets harness to avoid it.

Thanks,
Nick

On Thu Jan 18, 2024 at 12:12 AM AEST, Nicholas Piggin wrote:
> Add test for POWER10.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/avocado/boot_linux_console.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_lin=
ux_console.py
> index 3f0180e1f8..4f05bb7441 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -1386,6 +1386,14 @@ def test_ppc_powernv9(self):
>          """
>          self.do_test_ppc64_powernv('P9')
> =20
> +    def test_ppc_powernv10(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:powernv10
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        self.do_test_ppc64_powernv('P10')
> +
>      def test_ppc_g3beige(self):
>          """
>          :avocado: tags=3Darch:ppc


