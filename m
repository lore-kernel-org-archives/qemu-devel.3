Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAB1D0EE01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNv8l-0002qo-Uq; Tue, 25 Nov 2025 10:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vNv8O-0002ng-KD
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:39:18 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vNv8L-0007ZW-T3
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:39:15 -0500
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-948733e7810so229456839f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764085152; x=1764689952; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+rE3Tk1rWDT25APTUMQkhbusuRV50MrgtsW6PhHR4Yw=;
 b=KxhlVbeD7pfJF1ksVsjCWKzVT3RKr919ku4BiTntH+ND9KkNXcbG2xUSjHr5oj4MhG
 /9zDUJZM5aqwJEIi98l+P8xqgn0IQL4T5ObAunPz27vyTJWTy5COClkt0GNI5QfxXrc8
 EmuuUkjAGaDl8u08x29s0vJLAoL/Oi4zX+Xtx+Go5kV8JvUq54T+j0XYUNOF6zavnRb+
 HOxFFrrkBnxe3imDdOKiMtk6pHOfyEnWsaVP/IctuzvRxcgLbzPVcw84e+rpJbmiGFXD
 fbobH5Ml3zyN2oYf80afLLDmeH0IMblFd1DadfOSTXNctnH2aUIriVgeKJ8VMdKd5dco
 0/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085152; x=1764689952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rE3Tk1rWDT25APTUMQkhbusuRV50MrgtsW6PhHR4Yw=;
 b=npmllzs5aTQrb7Odrs9gGW9G55BjhGADs5QhD10ZjuoJEinZl7PSeXF+DUnG+vfnTX
 YGO0OK3KzDM8I59E7Cr8lAxqo5ELEMgJjfTaL78PZwm7HbciEokhKhxtah5/h706s7QG
 oiv8cNu/gzs0uJ4xlCtXzlRt8SE+Ykj64RaybO1Gh20scglzi2x8TGEEeoy+KkaQDGZq
 oPiVuBemr+jT2dgVxOU8RPlVBV3b1SKgYfRUvAn1JP5vaLwwWvzSoawvQCaKMBxtXmsT
 Rqp6TlvUpaxDjWk35VThdkd592SsQaubG8nlN1l5dLGeV5I/TgCyZuFVuO0yQFsZIucW
 b9MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+DGA3uq0Gi+51nZMn9+l1es53VxuOP8hE/6mCCcVGVbbPGiBI8Jcya7KNMrvpA7GM/5+xmylE8jy+@nongnu.org
X-Gm-Message-State: AOJu0Yw/O0z4ftu/C2IQN8E/0GG+NECkQl6cSuuxyUWCLPqvXocEyPdh
 iAAutMiSHzOD1TIIgo8Pvw5dLvIwSb3o3mWms9dfq/kj/G/49BavTbmuIZutmFBf2xU=
X-Gm-Gg: ASbGnctoreE+8SkYm2ZS/IRGlYSz1kA8/Fk21wBjAIIziYKpIMz962LNlrt1OQu7bbY
 78yInRUgQV7M0VdgAfJYYtq19boUXBpOg/ifpe4tNwBDw6SlmTiPtSqmlkuOHOYBqDNcT8z6/EK
 OkxDax+GCOr6vmyGsxz2VCR4km7XFJQyobWPMfh5YO1Tj/cgre0Bz4BibLg9fNDblxsK73hUe6z
 dGjGPOm5qLA5AuUH8RSQXaLpvPlkA7NVFjwaz/K6egShuso9dxJ9fyHW20dc+jMN9HbhgNXYkUO
 9U4/fzeE+ahe+mpgr2hrowKtDsp17hgpVXMCGCzKS6yq2GgvAKvY3STM+SLvnEd55OsAcz6goAC
 XcGAyD/8nX6p/njn3rPLz/7TuvwxXPZlB1I89iAT1Bbb7fVCcbiAHpnVMBdz9be/c4QMM1UmP8w
 ==
X-Google-Smtp-Source: AGHT+IH1wxSR50/qXlLM9/LRgrIo27vNXCgXhqArCXg+HFluauJszYSuHw4zcJ1eBnLNIlZN6N1dig==
X-Received: by 2002:a05:6602:1689:b0:887:56f5:26a2 with SMTP id
 ca18e2360f4ac-9494755df87mr1745181939f.14.1764085152210; 
 Tue, 25 Nov 2025 07:39:12 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-949385ae254sm617805339f.1.2025.11.25.07.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:39:11 -0800 (PST)
Date: Tue, 25 Nov 2025 09:39:10 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>, alistair.francis@wdc.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 wu.fei9@sanechips.com.cn, zhiwei_liu@linux.alibaba.com, xiaofan@iscas.ac.cn, 
 wangjingwei@iscas.ac.cn
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
Message-ID: <20251125-3e644247d1d73ebad131f69a@orel>
References: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
 <b1d0bc43-96cd-4919-b5c5-d004e422e902@isrc.iscas.ac.cn>
 <ef829d73-f39c-421a-8ebd-ef5422a7fedc@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef829d73-f39c-421a-8ebd-ef5422a7fedc@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd44.google.com
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

On Tue, Nov 25, 2025 at 08:24:22AM -0300, Daniel Henrique Barboza wrote:
...
> So, in the latest spec, section 2.1 RISC-V Harts:
> 
> https://github.com/riscv-non-isa/riscv-server-platform/releases/download/v0.9-rc3/riscv-server-platform.pdf
> 
> There's a set of "rules" that each hart should or can follow. Rule RVA_010 states:
> 
> "The RISC-V application processor harts in the SoC MUST support the RVA23S64 ISA
> profile [6]."
> 
> The next rule, RVA_020:
> 
> "The RISC-V application processor harts in the SoC MUST support the following
> extensions:
> - Sv48
> - Sdtrig [7]
> - Sdext [7]
> - Zkr
> - Ssccfg
> - Ssstrict [6]
> - Ssaia [8]"
> 
> 
> I take it that the wording used, **MUST**, indicates that RVA_020 is mandatory so we should
> in fact support sv48. In this case we can change the default to sv48 without problems
> 
> 
> Drew, is this a fair interpretation? Thanks,

Yes. The server platform spec is based on rva23, but also mandates
additional extensions beyond what's mandated by the profile, including
sv48. (And this is why I stated the default should be sv48 when pointing
out that it shouldn't be sv57[1]).

[1] https://lore.kernel.org/all/20251111-e4f4062f326aef78ef820d00@orel/

Thanks,
drew

