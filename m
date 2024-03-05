Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47B5C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQtz-0003xk-8j; Tue, 05 Mar 2024 04:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhQte-0003sV-BN
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhQtV-0006ko-0u
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709630128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HTY+X2KO6kKRaIQrR95vtH8ooylQ2pgOWr5xDKhIos=;
 b=Kmp7Q1Yg0g+kDeR+hB2DN08Vg5y51jaM/YO4L6OM5OvxwWOw000m6chii2Pjs+o4lSnBqY
 uL/FZtJ23sZCa0KvmkteRG8HYqxMrGhqMGfvYnLqj08ogOE1H1CmWqzbhV0WXYgqGLh4ZC
 wCGzWBKGvT3wEUd2pgxhOr01Wf26fH0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-TWCo05Q4N6SAFIDdiyvifg-1; Tue, 05 Mar 2024 04:15:25 -0500
X-MC-Unique: TWCo05Q4N6SAFIDdiyvifg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-220a44546e3so4869756fac.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709630125; x=1710234925;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9HTY+X2KO6kKRaIQrR95vtH8ooylQ2pgOWr5xDKhIos=;
 b=rqTLPMGHqptFzhJLhG8P2147ihTZXdkdFKyfhWismn7E3PCgV6jjUzRRqeX/R29zgn
 L7nhR8MiBL+2xd1cHuWmDnwbg/cqGbMqPwmaT+t+1fWANPz7Swm6jo3PR8w1EgiAd+ex
 FLOJFzAH/iz8npufMAshozyFPnoxAePbiMQCJYggIvG+10DckA9CJn6fO46P4mmz0dpt
 1tnM81N2mEANIgnL7ChPSNU6pyXImfUw4fy9pf+tJWJC8LmrpdL6hhTyI9CCcz88wbQM
 N6jiHcNQJit9lxJZZdFcfz48KUDUm5TqV9gITOSxGwNVVgpTNob09jRomvPUf1mio0jE
 iFRg==
X-Gm-Message-State: AOJu0YxeQHBHklE4ZUVk67iRQlnVxi5JI/PdpdAGhHFnhsx+cFUx3LW0
 VQGn8uLehxqIxJe45Ww5mEddyrjqL0gyhw6BKZvhNCMnbEX8vfn+JFC398wb4gnc3d90gW7T1xU
 XVOqbsIqSLOR7GY7Z8v3xRlneV0Pv18+ELLbhstz3K+44QxXIvpI1
X-Received: by 2002:a05:6870:d07:b0:21e:a47f:ec31 with SMTP id
 mk7-20020a0568700d0700b0021ea47fec31mr1122613oab.43.1709630124874; 
 Tue, 05 Mar 2024 01:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5f0idmnHOJFCmu/LZ7Cb0S5HthJTa2Fcn2AfOoB/vCCu6+LAGAETMWrPvtr3yYmCt1ILnVw==
X-Received: by 2002:a05:6870:d07:b0:21e:a47f:ec31 with SMTP id
 mk7-20020a0568700d0700b0021ea47fec31mr1122597oab.43.1709630124610; 
 Tue, 05 Mar 2024 01:15:24 -0800 (PST)
Received: from fc37-ani ([203.163.238.152])
 by smtp.googlemail.com with ESMTPSA id
 g29-20020aa79ddd000000b006e6291c30dcsm2475475pfq.104.2024.03.05.01.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 01:15:24 -0800 (PST)
Date: Tue, 5 Mar 2024 14:45:15 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 mst@redhat.com, gaosong@loongson.cn, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org, 
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 13/19] smbios: extend smbios-entry-point-type with 'auto'
 value
In-Reply-To: <20240227154749.1818189-14-imammedo@redhat.com>
Message-ID: <a9f674ed-0e94-86a1-8e8d-fa65a27a8aa0@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-14-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On Tue, 27 Feb 2024, Igor Mammedov wrote:

> later patches will use it to pick SMBIOS version at runtime
> depending on configuration.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  qapi/machine.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 93b4677286..4c68528507 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1802,10 +1802,13 @@
>  #
>  # @64: SMBIOS version 3.0 (64-bit) Entry Point
>  #
> +# @auto: Either 2.x or 3.x SMBIOS version, 2.x if configuration can be described
> +#        by it and 3.x otherwise (since: 9.0)
> +#
>  # Since: 7.0
>  ##
>  { 'enum': 'SmbiosEntryPointType',
> -  'data': [ '32', '64' ] }
> +  'data': [ '32', '64', 'auto' ] }
>
>  ##
>  # @MemorySizeConfiguration:
> --
> 2.39.3
>
>


