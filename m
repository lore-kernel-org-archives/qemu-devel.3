Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A89C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 12:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rivOh-0006Jm-4r; Sat, 09 Mar 2024 07:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rivOd-0006Ip-HR
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 07:01:47 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rivOc-00031s-1v
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 07:01:47 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-568241f40e9so2088993a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709985704; x=1710590504; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RJqc3GVHJNhinJapfRd05vALzWAJlTFCioGI0MWgKzc=;
 b=cyLx2cEagYfZmi4mfB37w0mBr5RQLOF1gDiq+oKM/X2DZThtcuYQYDvHDpVKA/F8vn
 Pboy3pbJD/IPLuBCINL0VdaVEaUc2+Y4vup/dSkf5yrRRf0uV8t9miR4LZbL8hinFJv+
 ScjS0EsxutRa9MbqlZ6UExBeQC8DnRuyUlbt9amGHq0hx5CVRtuyM1L5uCF5uLrtuCjo
 3A0GuRjsPzFoj8utQcxJiOixza+gbdeTq7XdK2FrnluwKoANoYCfYh85r+L5valYDDUn
 ZBRNm2M0HCtKuH46bEwOWmHbLt7iZPf4b7iEXNsnfRlkm9WPK6JeK8TyI5inplEHrVVc
 Q8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709985704; x=1710590504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJqc3GVHJNhinJapfRd05vALzWAJlTFCioGI0MWgKzc=;
 b=mXWDwH4rW62oaaG44DeV9VWs+0pwvHV7Kac88eLF9m08yzsXE4gARDWOpV2O+vKbJI
 0/sQAvN1yMlKjn749sHgRTZ+grzBaGjZEWBH8wWuyh9FieGt8kdH6tE/9tbUBQ5Wiyib
 iaNdDxnr18fKA9SlFZyA/3Jfps9YQi8Cu3j4T7zBlldDMSIjK0VNwvGNpqjXxd8DOCCh
 6gZQgs7xwxgSfWO2xBzUcTgJ1lFlqrU/6+E/zMvFZKJc5BuBIIH+W2TXktfGRQFA1Vn9
 3iEU0frRsXQfxAwPXkFTe6o6+wK91yrgQRxE3pgGb+bJ1XZstXx/vupqV6VfJPsa967+
 E3og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzI11VoqhaytVDE9BFKgJju/iuzpnln0V7f7VZ9p+F4dKKNbao+iCXP3OfMxIWGkBlDYRahMeSe3aYvNnOP1RKAAYpOoI=
X-Gm-Message-State: AOJu0YzhQgSKirmQzd2AMaQANBZH3XPBIWb2qKzhfJC56/+wNuFxYyda
 TrSV3qCdWJsQJI8kcuf14zVgLFMhpAgSFRXAh6q5Oyz0TulMxBLIz7XUxvZKwmg=
X-Google-Smtp-Source: AGHT+IEDSOSVCuoeolmQ50TK9YE2xZ8nTwcSl3/X5EjvSAuecZAGLp4x3E9QSi1uLGwnSNCY6mn9yA==
X-Received: by 2002:a50:f681:0:b0:566:c388:ceb4 with SMTP id
 d1-20020a50f681000000b00566c388ceb4mr1268630edn.28.1709985703676; 
 Sat, 09 Mar 2024 04:01:43 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 9-20020a0564021f4900b00567e27c72c4sm798372edz.62.2024.03.09.04.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 04:01:42 -0800 (PST)
Date: Sat, 9 Mar 2024 13:01:36 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Richard Bagley <rbagley@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 bmeng@tinylab.org, 
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
Message-ID: <20240309-ee813e971e7c5850d652b295@orel>
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
 <20230811-52e2c90dc3b91e108eb5e4e8@orel>
 <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
 <CAARkPA-dOxOWsR0VS+S8p4fDmNR5X5Jjmo5pQTaurWLYsc9vsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARkPA-dOxOWsR0VS+S8p4fDmNR5X5Jjmo5pQTaurWLYsc9vsw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52c.google.com
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

On Fri, Mar 08, 2024 at 08:22:01PM -0800, Richard Bagley wrote:
> post-nack, one further comment:
> 
> One could argue that this change also aligns QEMU with supporting tools (as
> Andrew observed), and it makes sense to merge this change into QEMU until
> those tools update to supporting signed decimal numbers with immediates.
> 
> As it is, both GNU assembler and the LLVM integrated assembler (or llvm-mc)
> throws an error with examples such as
> auipc s0, -17
> 
> On the other hand, I have only seen this problem with the output of the
> COLLECT plug-in, not (as yet) with QEMU execution proper.
> If the problem is confined to COLLECT, perhaps the argument for aligning
> with other tools is not as strong.
> 
> In the meantime, I have adjusted my change locally to include AUIPC, and
> written a substantive, and I hope, clear commit description.
> If you would like me to resubmit a patch with this updated change, please
> let me know.

Since the patch is ready for posting, then it might as well be posted
(even if it may not get merged right away). If the issue arises again,
then we can refer to the latest proposed patch, which will be preserved
in the mail archives.

Thanks,
drew

