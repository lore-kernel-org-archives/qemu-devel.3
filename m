Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A5CCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 05:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKVHH-0008IL-Fg; Wed, 06 May 2026 01:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKVHF-0008I3-Ke
 for qemu-devel@nongnu.org; Wed, 06 May 2026 01:58:33 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKVHD-0004s5-Uc
 for qemu-devel@nongnu.org; Wed, 06 May 2026 01:58:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so26268125ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778047110; x=1778651910; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CMsLGMy3+ZEl0CiFNXyZztcrjVvONWy0p1TBzBlpmD4=;
 b=HA8CT/EXP4mRSi/tp0iFHjKkIbiXD8EQ+/duywwLjS7msffozp5rAbr2yyEjBCWsKh
 po+3VErpNxPds9B04G6ZzfvHqp6B4jTCyjaGHs6NDweH/efGzbFuvMH+7pAmzs2HscWI
 hguUxkfrEzuSxNWo9axHsmoZMwu/M4XArXfFXT6t8/CoAnB0wB4waABCf59e5EhrvyyX
 zMrCbw2+G4zFd6Gdihe51Bsz6PQue0tIflY11eS6zwiI8Z+SjUEJRDzpJ0+bZdVfg2W2
 lQ7YH5WCJVvnosE4TCaPAReoBDX1klx+1ydk8t8eC0LbPfKu/wD5ys+BNAUV82nKMiXa
 ieUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778047110; x=1778651910;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CMsLGMy3+ZEl0CiFNXyZztcrjVvONWy0p1TBzBlpmD4=;
 b=YJCbiBcfaUE9uifu/VevHxNVC6HXHnhqCvxW0xY/Gt4JiCUrPeToyud5l5L5/UhF8t
 mEL1OD4Q38mRBt6t0l8LE+x4cH3a8Lg1+jjkOFn/lgp+E9/lETi5kmFzUeyQC1ZAmCMn
 l9B4vmVW2aG+SUqQKy3Wk/O+dpXKSQLYTcQ9cdZGQWuKDs24FO63FUjoZHufFVivOuCr
 ZEgWLoYxyRxbqvss5vAQ40dxXy1iDyqkbvBn/X8enYgIrV5FLff2py+A2isbBtbAjEIN
 llbLX9/vG8OeCZZ8YDn2HQZB8PSLoWaGexzvney3AZEpqTxTjJTZQm031hiu8d1lwJQp
 lekg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h0DRa+AaeXaKb5ksIUPx7M4Dp66OmFqP1Fv0h706Ed6fopBz4cUfRxTtv2xsVJtg8tyxdR+Js1QlX@nongnu.org
X-Gm-Message-State: AOJu0YyMwtgYB1yoBjO43pKYQ0/fkyKFufUwcJVeKstIGLvEl/mMJ1Hf
 dQ/BVaxrDT4Tpj65eO7+gPcuaOUzf/XrydwukpClDZ6YNWFrYrn9SVUJ
X-Gm-Gg: AeBDiesuYn9LMO1gnUYOT19X1dGRq/iMxCYgrjutHlkKyzzz9g6upqMCqIap1b0GzHJ
 yiWEqH68sxAnnJzctDQkINdi2cNApsGwB4WlxsXhYplLJpO6EEfUZupMpyU4ICnMgQ4nzJH74FA
 QdBILayTz4jORCYK0jlNdTCYdoJ4cygAd7+81qgvHteLGcPCdo81kjIelyo7kVz+f/2Hp76p1sY
 ery5XBQZ4IeF54X3LJW9qRBv8DsagZRpPV1j9do36QS8iMXWzBWNvR8ZelfVQ695ycWQFw1/wk0
 ads1/R0cK49g8nfm1lshNHDy+s6mnvl40FA88WvP+Tk9ZDWD9gMJeE812Y51kjNLU5XhHzDz4tg
 RsbKpf0DRbMmwabv4nZTpnxJ5+3IjsVt0Nd60PWsbjzwHntn+O3i8kJNGX43eFHk0WDrjJ93ZuO
 fnoUJ6aOIwjtg22eKvrcx40mLR7VtFP3DGUl7Ye9AG2OGEUFhSM3Ru4WMgWkxJ559TVuBxtUEUD
 bKy+GJ2
X-Received: by 2002:a17:903:fa3:b0:2ae:c5fc:b2ea with SMTP id
 d9443c01a7336-2ba794b71b5mr19662255ad.30.1778047110003; 
 Tue, 05 May 2026 22:58:30 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca24a62sm12248025ad.75.2026.05.05.22.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 22:58:29 -0700 (PDT)
Date: Wed, 6 May 2026 15:58:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Message-ID: <afrXTtGrUClrUWMb@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
 <CAKmqyKPyUYfnS3BsHT31hp_P5ufDOZHmr3VW8aUyeTTSTS-Rcw@mail.gmail.com>
 <afmKctliUOEgQrmN@lima-default>
 <1476b7df-b8b7-492a-b46c-81d0bf9cb66e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1476b7df-b8b7-492a-b46c-81d0bf9cb66e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 05, 2026 at 09:36:57AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/5/26 08:20, Nicholas Piggin wrote:
> > On Thu, Apr 30, 2026 at 01:53:21PM +1000, Alistair Francis wrote:
> > > On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > 
> > > > From: Chris Rauer <crauer@google.com>
> > > > 
> > > > In the past this model has been submitted for use with the arm virt
> > > > machine, however in this case it will be used by the upcoming
> > > > Tenstorrent Atlantis RISC-V machine.
> > > > 
> > > > This is a re-submission of the model with Chris' permission, with a
> > > > light touch of updates to make it build with qemu master.
> > > > 
> > > > Reviewed-by: Hao Wu <wuhaotsh@google.com>
> > > > Signed-off-by: Chris Rauer <crauer@google.com>
> > > > Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> > > > [jms: rebase and minor build fixes for class_init and reset callback]
> > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > ---
> 
> 
> > > > +#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
> > > > +#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disabled. */
> > > > +#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
> > > > +#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
> > > > +#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
> > > > +#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
> > > > +#define DW_IC_COMP_PARAM_1_INIT_VAL             \
> > > > +    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
> > > > +    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
> > > > +    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
> > > > +    DW_IC_COMP_PARAM_1_INTR_IO | \
> > > > +    DW_IC_COMP_PARAM_1_HAS_DMA | \
> > > > +    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
> > > > +    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
> > > > +    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
> > > > +#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
> > > > +#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140
> > > 
> > > I would prefer these to sue the QEMU register API
> > 
> > That's probably a good idea. It's a lot of churn to change it, but
> > I'm having a try. Might do it as a follow on patch.
> 
> Good suggestion but please as a follow up, this patch is already
> big enough, is reviewed and tested.

I agree... however I implemented it and it is a large amount of chrun
which is also not easy to review. Also it breaks migration
compatibility. So I don't want to get this patch bogged down but if we
agree to take the register API conversion then maybe we should squash
before upstreaming?

Not sure. I will post the patch as a separate optional addition to the
series to begin with.

Thanks,
Nick

