Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB8EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 08:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSYRU-00008J-4b; Wed, 24 Jan 2024 03:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSYRN-000050-Pq
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:16:58 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSYRK-0000G8-Fb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:16:57 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3107d2bfbaso52119666b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 00:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706084213; x=1706689013; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9sXg36sUep+N61vSnj8FOK4eOgfj23LfuaYjihRPx9s=;
 b=MA5/Vzg1xp91Ckc9/tGxt9G8jW748KHiOrNUJ1I2CcvZ22kxeIlOcZldPt8vH1Z9LV
 DqxGubtP0mPfhl+fiifeLfU/Kv/nTr9jbdKE9XdfVKXdLBbyakWt4KDsWs+mrNt6QSZt
 DJVMrNRztGOJPYB9FazfN2wHdRgfGLSnsVvFHQ4T6hhWvDXSnrDp1MgWw7RClK5yeuHf
 VfoLxI5757fV3y2qMGJFCEl5CeTNPxJX4YuvU8ZS6S74ex+vbut15Fk2Bit2z79GfcGk
 8iEyH5WsZjlbdem1T+70XlzXD497MjCPYMJkn9USWnVIxRH3sCtplYND3vjnEK1+g0Uz
 f6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706084213; x=1706689013;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9sXg36sUep+N61vSnj8FOK4eOgfj23LfuaYjihRPx9s=;
 b=bnn+e/2qap6ypzuCkJYikXnp6nHA58I+WNFCLPKRaCkl7AdD9zPe6FWrAbz2ikSasb
 nwt5dmfA13K6SWHIRszy26J57RU6FJFbkebMIVq02mD5IF5+tD8RvCbooI2Ajlh4N9na
 jhlGzni2vAkP6qG6wqbLZIEDp0vJEC38qZS16AqqQ9CKOtcx2cmXDyqTStK5l7uR9Ath
 K/Eub1M6fG5S9nS1+u/KhQ+c0Sp2T+wm6ibU5vUVa6mSQdzW6p5adnBC1CEc/nEaN+Hy
 lsehhVf3REOuKAGWRSoA0jgzSJV1VqzaMfB6MLUjUDnAI8NVO6pPL4G/4+mctU/Gad6x
 IpUQ==
X-Gm-Message-State: AOJu0YwYWG/Pd2ZkWKgwdjQCXqGEO9+f1PB9so3T4EMaCFZknygcFdLx
 Sn1763HRGTpeh8Y86m4RtVp0soCec8Po9UaMq/I1DUXvljPZIwLtkGgWgRaKKgg=
X-Google-Smtp-Source: AGHT+IGDg1ZQqdXZKs3GCQc5JFbRDXhgLr6ZlGiNbTZRR/B1PaEq7yGPv5awPONM0W1s3+iCwea/Kw==
X-Received: by 2002:a17:906:9c91:b0:a31:2905:5dca with SMTP id
 fj17-20020a1709069c9100b00a3129055dcamr247199ejc.53.1706084212585; 
 Wed, 24 Jan 2024 00:16:52 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 mn6-20020a1709077b0600b00a2ccddf9a7dsm13874643ejc.124.2024.01.24.00.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 00:16:52 -0800 (PST)
Date: Wed, 24 Jan 2024 09:16:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Michael Rolnik <mrolnik@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Laurent Vivier <laurent@vivier.eu>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-s390x@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, 
 John Snow <jsnow@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, 
 David Hildenbrand <david@redhat.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>
Subject: Re: Re: [PATCH v3 01/21] hw/riscv: Use misa_mxl instead of
 misa_mxl_max
Message-ID: <20240124-3d9bec68bff7ab0057b902b6@orel>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
 <20240122145610.413836-2-alex.bennee@linaro.org>
 <20240123-b8d1c55688885bfc9125c42b@orel>
 <15d2f958-a51e-4b87-9a70-28edf3b55491@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15d2f958-a51e-4b87-9a70-28edf3b55491@daynix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 24, 2024 at 12:08:33PM +0900, Akihiko Odaki wrote:
> On 2024/01/23 17:20, Andrew Jones wrote:
> > On Mon, Jan 22, 2024 at 02:55:50PM +0000, Alex Bennée wrote:
> > > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > 
> > > The effective MXL value matters when booting.
> > 
> > I'd prefer this commit message get some elaboration. riscv_is_32bit()
> > is used in a variety of contexts, some where it should be reporting
> > the max misa.mxl. However, when used for booting an S-mode kernel it
> > should indeed report the effective mxl. I think we're fine with the
> > change, though, because at init and on reset the effective mxl is set
> > to the max mxl, so, in those contexts, where riscv_is_32bit() should
> > be reporting the max, it does.
> > 
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Message-Id: <20240103173349.398526-23-alex.bennee@linaro.org>
> > > Message-Id: <20231213-riscv-v7-1-a760156a337f@daynix.com>
> > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > > ---
> > >   hw/riscv/boot.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > > index 0ffca05189f..bc67c0bd189 100644
> > > --- a/hw/riscv/boot.c
> > > +++ b/hw/riscv/boot.c
> > > @@ -36,7 +36,7 @@
> > >   bool riscv_is_32bit(RISCVHartArrayState *harts)
> > >   {
> > > -    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
> > > +    return harts->harts[0].env.misa_mxl == MXL_RV32;
> > >   }
> > 
> > Assuming everyone agrees with what I've written above, then maybe we
> > should write something similar in a comment above this function.
> > 
> > Thanks,
> > drew
> 
> The corresponding commit in my series has a more elaborated message:
> https://patchew.org/QEMU/20240115-riscv-v9-0-ff171e1aedc8@daynix.com/20240115-riscv-v9-1-ff171e1aedc8@daynix.com/

I've pulled the message from that link and quoted it below

> A later commit requires one extra step to retrieve misa_mxl_max. As
> misa_mxl is semantically more correct and does not need such a extra
> step, refer to misa_mxl instead. Below is the explanation why misa_mxl
> is more semantically correct to refer to than misa_mxl_max in this case.
> 
> Currently misa_mxl always equals to misa_mxl_max so it does not matter

That's true, but I think that's due to a bug in write_misa(), which
shouldn't be masking val with the extension mask until mxl has been
extracted.

> which of misa_mxl or misa_mxl_max to refer to. However, it is possible
> to have different values for misa_mxl and misa_mxl_max if QEMU gains a
> new feature to load a RV32 kernel on a RV64 system, for example. For
> such a behavior, the real system will need the firmware to switch MXL to
> RV32, and if QEMU implements the same behavior, mxl will represent the
> MXL that corresponds to the kernel being loaded. Therefore, it is more
> appropriate to refer to mxl instead of misa_mxl_max when
> misa_mxl != misa_mxl_max.

Right, but that doesn't say anything more than the original one line,
"The effective MXL value matters when booting."

What I'm looking for is a code comment explaining how riscv_is_32bit()
is always safe to use. Something like

 /*
  * Checking the effective mxl is always correct, because the effective
  * mxl will be equal to the max mxl at initialization and also on reset,
  * which are the times when it should check the maximum mxl. Later, if
  * firmware writes misa with a smaller mxl, then that mxl should be
  * used in checks.
  */

Thanks,
drew

