Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FDDC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6BG-0004jm-7Y; Wed, 12 Aug 2026 06:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu6BE-0004jK-98
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:27:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu6BC-0002Ws-Rq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:27:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso4346365e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786530445; x=1787135245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ekoszo7DaJPYx04CStXiOC0J0YxfHEShVUgSZslYgj0=;
 b=X9NJhSXV9J7ms7lBCv4aC4tcxv7i8cb76y2uQ0oQXamCmysaO9FnWS5vqpkv5CDKMS
 +TN1QHgnfDIpWsGXzzUxkq2KKq49lSl6vVjCYVux0w4vYEAMk5jsp1+PxlBYo9nYR38Y
 rruj1TIAKqoNtoCwhhaxKm54VMJ//9KZnuKX7+Cj/9FXSEGDDEeZnY/7By+7B2BLWcSd
 ZU+z/zvdy7s5KvDBx1TsvM5xsm4UOFHsKygz2oM64KH4AU4l6s5+M4CT5UCdRst8KV94
 Xd5EBWtar9Dn6v9tJHHmzT3S/2zVv1BymD+0MzTxnGFlxb66otOVd1NWyByMxpbtXXZL
 0i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530445; x=1787135245;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekoszo7DaJPYx04CStXiOC0J0YxfHEShVUgSZslYgj0=;
 b=hBPKhrdJgpK5tTEES4bHFOVZLv9qz3SPc/QlOfJqzCYcEjU3fPo5JJ2StustInsScn
 5fYAoe07ngz9LYUW/yfOqI9314GGkBewid3FbYzh575Shb2FC9zo5JHn6djLZvMUaU9n
 LApliFsVvSHIz7PTPT7hBvP7/471R5c32FnR6dNXW7V5reHO9z19BAXLxvaThSNAltlL
 9yJRwQGZ9Q5fQ0le4lvFYozW/5vAL0qUOa29SKU0P1jux+qk3vw/0XQ3IrPMF7o6XqXC
 dgaMOZxR7jJ5h1uc58nG73x1di98jzaoaqZ/NZqHPEQ2Pi5RIf9c7I+dYeUn5TMqlGVR
 0T9Q==
X-Gm-Message-State: AOJu0YwDGOceG6TYLwk1kNIBPF5VWf01rCftjsTHsTKwasF0n/bFhvBH
 MPiHCDHk3T2cmZKWez1lIYSbKKV4WzVOrd7y/IS0zCfDutVNhF7kavNij4LvI9mgFkE=
X-Gm-Gg: AR+sD13rIje26S2Fa+DyLDZq3JgXFBwomGS7FlsmGiuMSJMxVCdgRWbiwUSZuwdUCn6
 zHplT4PrZtRv5s9AmYiwgTBkGFF/H7RZyPqBgCv2tp40K/o195+umJJ3RWeSP5RM87n4yudnCAu
 c95+LrvjaM0YvECD05FSr6cOoYpFevMwJczgjPdl9xEAnSrIeXNForuf09dehTvMYIynpNEqKJ/
 1GgNSXpe1Doyz+kbY/nMwHZvCdN7Cw/i7N80M6HPnWW5Dxs+XHd7wQatISlOyhWcOdIYMF9kKNM
 jXFDuu+0WgYuhTD7KQl0ceeRxRBsNgjTHezdScFomucL/YENoPMPVqlhmajVXLtybh5upyjv4sB
 +7ND5Cqp8B9RfNXLDuNvS9t0DEXqF5r1jBqiOjJUf2dyf8jKrC1z+jNjTaCm6jPPqsWRGXRQ56P
 zkTDIzSe8n6m8AQvCSbt6YuTR+ZLBMrZMOf+GmSHsIA1imGyiub6tbCHzp+XdG
X-Received: by 2002:a05:600c:3e8e:b0:493:cc25:9c0e with SMTP id
 5b1f17b1804b1-4997c1459d9mr55850545e9.14.1786530445082; 
 Wed, 12 Aug 2026 03:27:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c94f4c0sm34596805e9.8.2026.08.12.03.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:27:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 376835F886;
 Wed, 12 Aug 2026 11:27:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 097/103] tests/tcg: remove remaining Makefiles
In-Reply-To: <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:41 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 11:27:23 +0100
Message-ID: <877blv1vn8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> tests/tcg/mips/user/ has extra tests that are not currently run at the
> moment. Keep their Makefiles until they are implemented.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

