Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6393ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squvz-0001ls-F1; Wed, 18 Sep 2024 09:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1squve-0001HU-3d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:41:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1squvb-00006r-2r
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:41:09 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32974fso8547139a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726666863; x=1727271663; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eiZXMSaoHGA8VZFDXpQmrLegSygOwTH/4r+12ly0/Lc=;
 b=IDlW3MX7CAPgPQiU74pKvmMUKRw0li2UlBpe4YIh27AgVrcYYSfsWZjbNnhm3T54Mx
 qoe3SmarmknHWIc6B10ruI+qqjeT/DdBA6IuxUHW3SMgA4/SMtJBBlWUiQxSywmarcFt
 8nTKiRj62exTvCnhZid2gErvowUPssC7Y0IQxhEioAqh44EvDoYsUbwC0ypPzmnOL7h2
 XGg5/ArWqz/1TKyuEHKDmM6bbQhgMQ28kKbyIoxx/NEVQC3K/oI+51UKU0tuUBiYoX0S
 XOzSV9mS1gD1vkMG2WElBYsiurghMUYZ75BE5pu/btnF28ihSMJadFs0dOZh2vgLJhag
 4FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726666863; x=1727271663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiZXMSaoHGA8VZFDXpQmrLegSygOwTH/4r+12ly0/Lc=;
 b=J7ivjNvdBxYh1WTiXtf93w1b6T3uJm9liJ/NppmWBh1ZJz79RDz6CcfvOHHQRvHIlp
 GwBtAIOF7hO7EF1Kg9A8a9G8H3s2IL4npU/rWZr/WuGai9YxYQ1s7AEkWNEJFcM1kdyI
 qS6jzMefat4B1Vt7cVk4Gn76YW53FqltPCoOBjGW3hEnz7zyKxck2xvpFpN/hF1dXfBX
 cvu7I8oPQcqrPW0mFgbnjLD+X8Nbp1ftrJjxDwpzI781tccKUKZtp2mWjgGXECtev8Jo
 q92nrbpTj8Ylz7RwSQWe7s34k+SirySkatK8GNf6GSdj8sGFOBxF3RCQj97qcdxOxJfa
 ueEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIOpv/Ro7v8UOSHkKNPCpgXSQk5U57BAhCvIZ+qH+G40b1FmC/DCnhIFZ2ryglMbOhfFH3OWZOA+Zk@nongnu.org
X-Gm-Message-State: AOJu0YwCPaSn9RrqtBaMPvHIgwxfwm/GDl/aYHIiuxg0qlbyQXzPk97m
 B2EqO01WkS+ODFupKW6Bqi76HxmxG0DWUfqRw2kKNcQyAL3RsZItid8aPNFbW9Y=
X-Google-Smtp-Source: AGHT+IGy8UivZA00C9dbrcxJPZjJu5OhRlH4RQGziy4AaI4syPWJnGuVebE9vWUeNBfOihBdIl4hAw==
X-Received: by 2002:a17:907:368c:b0:a90:b73f:61ce with SMTP id
 a640c23a62f3a-a90b73f649emr131931966b.0.1726666862545; 
 Wed, 18 Sep 2024 06:41:02 -0700 (PDT)
Received: from localhost ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612e5600sm598611466b.175.2024.09.18.06.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:41:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:41:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Aleksei Filippov <alexei.filippov@syntacore.com>
Cc: alistair.francis@wdc.com, alistair23@gmail.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v9] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240918-a2c17bf6cf08eeec6c750799@orel>
References: <20240626-1420003b7d88d892be22a719@orel>
 <20240917115433.38503-1-alexei.filippov@syntacore.com>
 <20240917-4c642a7fb52b49f470c9f29a@orel>
 <20240917-d929b9736eea1df07a77a9bc@orel>
 <0e2bbc89-66ae-4ca3-b01b-64998a6e8da6@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2bbc89-66ae-4ca3-b01b-64998a6e8da6@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 18, 2024 at 04:37:12PM GMT, Aleksei Filippov wrote:
> 
> 
> On 17.09.2024 16:10, Andrew Jones wrote:
> > On Tue, Sep 17, 2024 at 02:29:41PM GMT, Andrew Jones wrote:
> > > On Tue, Sep 17, 2024 at 02:54:33PM GMT, Alexei Filippov wrote:
> > > > kvm_riscv_handle_sbi() may return not supported return code to not
> > > > trigger qemu abort with vendor-specific sbi.
> > > > 
> > > > Add new error path to provide proper error in case of
> > > > qemu_chr_fe_read_all() may not return sizeof(ch), because exactly zero
> > > > just means we failed to read input, which can happen, so
> > > > telling the SBI caller we failed to read, but telling the caller of this
> > > > function that we successfully emulated the SBI call, is correct. However,
> > > > anything else, other than sizeof(ch), means something unexpected happened,
> > > > so we should return an error.
> > > > 
> > > > Added SBI related return code's defines.
> > > > 
> > > > Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> > > > Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
> > > 
> > > Fixes tag goes above s-o-b and 8 hex digits is a bit small. Most
> > > commit references in QEMU are using 10 or 12 digits.
> > > 
> > > > ---
> > > >   target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
> > > >   target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
> > > >   2 files changed, 18 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > > > index f6e3156b8d..9f2ca67c9f 100644
> > > > --- a/target/riscv/kvm/kvm-cpu.c
> > > > +++ b/target/riscv/kvm/kvm-cpu.c
> > > > @@ -1517,19 +1517,21 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
> > > >           ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
> > > >           if (ret == sizeof(ch)) {
> > > >               run->riscv_sbi.ret[0] = ch;
> > > > -        } else {
> > > > +            ret = 0;
> > > > +        } else if (ret == 0) {
> > > >               run->riscv_sbi.ret[0] = -1;
> > > > +        } else {
> > > > +            ret = -1;
> > > >           }
> > > > -        ret = 0;
> > > 
> > > Looks good!
> > > 
> > > >           break;
> > > >       case SBI_EXT_DBCN:
> > > >           kvm_riscv_handle_sbi_dbcn(cs, run);
> > > >           break;
> > > >       default:
> > > >           qemu_log_mask(LOG_UNIMP,
> > > > -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> > > > +                      "%s: Unhandled SBI exit with extension-id %lu\n",
> > > >                         __func__, run->riscv_sbi.extension_id);
> > > > -        ret = -1;
> > > > +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> > > 
> > > This, along with the addition of the SBI_* defines below, should be a
> > > separate patch. If we were just naming the -1, then I wouldn't mind it
> > > slipping in with the same patch, but this is changing behavior since
> > > SBI_ERR_NOT_SUPPORTED is -2. I agree with the change, though, it just
> > > needs to be a separate patch. And the separate patch should have the
> > > same Fixes tag.
> > > 
> > 
> > Actually it's even more of a difference than s/-1/-2/ since we're no long
> > aborting the SBI call, but returning non-supported instead.
> 
> I agreed, I'll split commits, but do you want me to resend patch as 2 patch
> series or 2 separate patches?

Either way is fine by me.

Thanks,
drew

