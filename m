Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAC3CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQA7-0004Hr-FA; Mon, 11 May 2026 08:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMQA3-00046s-J6
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMQA1-0004wC-AJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778504100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cZ7u/4BY17Hf8+fx6d+LVchvHDHUJ45dccqudz+it2g=;
 b=CsM2bS4Ngt5J3cD+gajNbBP5WagXX39FnahH9NOEuVqzQAt28x5VT2qlTHkUETgMgewPAq
 GDoDebF6yetcPlwLh7McFUyv2CrnLJeKLu4n5LUS04vQYApzu8uGYVs8NaxbKwN/y6g+rg
 U82osyfLXisPuHJHVUzi9N0TLRs4Eo8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-vYKeuz68M4KWanOHntUy4Q-1; Mon,
 11 May 2026 08:54:58 -0400
X-MC-Unique: vYKeuz68M4KWanOHntUy4Q-1
X-Mimecast-MFC-AGG-ID: vYKeuz68M4KWanOHntUy4Q_1778504097
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62CED1955F39; Mon, 11 May 2026 12:54:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22D719560A2; Mon, 11 May 2026 12:54:52 +0000 (UTC)
Date: Mon, 11 May 2026 13:54:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
Message-ID: <agHRmDMfjfc3BhFy@redhat.com>
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511124828.3210477-1-vulab@iscas.ac.cn>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 08:48:28PM +0800, Zishun Yi wrote:
> Currently, the Machine Security Configuration Register (mseccfg) was
> missing from the live migration state. This omission causes the register
> to be reset to zero on the destination host after migration.
> 
> Fixed by adding vmstate_mseccfg subsection
> 
> This vulnerability was discovered and reported by SpecHunter, an
> AI-driven architecture specification analysis tool.

For the record, this was first disclosed to the QEMU security list,
however, since this only impacts TCG it falls under the non-virtualization
use case and thus doesn't qualify for security handling / CVE assignment

  https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case

> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/a22e4459cd026ae970791dfbd9cfe5d110fbd46b/output/riscv-isa-manual/pr-1879/qemu.txt#L121
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---
>  target/riscv/machine.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a87914..6776e7bf5a11 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -423,6 +423,25 @@ static const VMStateDescription vmstate_sstc = {
>      }
>  };
>  
> +static bool mseccfg_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +
> +    return cpu->cfg.ext_smepmp || cpu->cfg.ext_zkr
> +        || cpu->cfg.ext_smmpm || cpu->cfg.ext_zicfilp;
> +}
> +
> +static const VMStateDescription vmstate_mseccfg = {
> +    .name = "cpu/mseccfg",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = mseccfg_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
>      .version_id = 11,
> @@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>          &vmstate_ssp,
>          &vmstate_ctr,
>          &vmstate_sstc,
> +        &vmstate_mseccfg,
>          NULL
>      }
>  };
> -- 
> 2.51.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


