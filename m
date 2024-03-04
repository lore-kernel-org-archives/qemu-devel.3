Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE8DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8m2-0001yd-35; Mon, 04 Mar 2024 08:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rh8lw-0001xp-TM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:54:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rh8lu-0002V2-Mn
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709560465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GIJGxh6vwIgUWC2cGg1VjYRjXLh++LvhAThWVmzffc=;
 b=X4mVwZzMcssO+SY9gxN2npbdjZ7PdsfecFL7KiGDVRS2i2/3elH77CTA+5LKLwAi1dZoM4
 hJ3mE53mm1SvrkviVZLyde7DyX5LGfXNecsB08EthaPqKBcISBcH88KCulRAFbsOVYX4ub
 5IiXGgYQ62Tckfhv1BSFNPSWefB76Pk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-9WF9Ajl-NCmFvbMDiZDGrw-1; Mon, 04 Mar 2024 08:54:24 -0500
X-MC-Unique: 9WF9Ajl-NCmFvbMDiZDGrw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5dc992f8c8aso4212608a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709560463; x=1710165263;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GIJGxh6vwIgUWC2cGg1VjYRjXLh++LvhAThWVmzffc=;
 b=IhRItX1JMjcRSp81ro0Xg4qA+juj1EpX6aId1MP+fXa7ZEO/UNZuW0v2kqwOYRauAV
 vCVYXriWZQYNPJIikgwd40PVYkHT3dYc7btLv2zhlII51Dk8ltAisvOD+eft5VH2gZSQ
 Qu8w7aKk7SMszLVVmOiWS9BTI2qjzLFwQxAfmWJNnFdkK7Kvb8HWvLwIWHoxz74tJnko
 RxJvt4DoVUpuneC/w4043Ew7j2h+2KKCmMIO0yX8Odc4jgIeacFoXc/f07u9Nxvwl7vU
 e0TeDxvNWi9KNRGCn+Khd+gyDk9E8SsnYLSnDGRHsnkb1+UNniWJsX3qUmO+JbtuacjB
 cGEA==
X-Gm-Message-State: AOJu0YyZpSMxYhIZX3+a7cWvs2MRxJKQJH/5sSmMcMuHWDRtmZCdRRGo
 mQom9uoQFVMMpjHJoRst5WovLQDQS8hciEwv55r9A9FoknCXsXVF43+rS3VSFzZTbbEOxz/B2Iq
 NHN3LTz9d/TCY8cQ+X5HPghG6vf8hv1cDKGXFnm88Jayk0Jq61rOI
X-Received: by 2002:a17:903:288:b0:1dc:df18:c5c1 with SMTP id
 j8-20020a170903028800b001dcdf18c5c1mr8599455plr.33.1709560463558; 
 Mon, 04 Mar 2024 05:54:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECniDIWgHsgl2DymkHjGs80A148+ZDxy9tk4J0JYoHtbTip3LNhotXNferFkd2l0Ax7LvKLA==
X-Received: by 2002:a17:903:288:b0:1dc:df18:c5c1 with SMTP id
 j8-20020a170903028800b001dcdf18c5c1mr8599429plr.33.1709560463258; 
 Mon, 04 Mar 2024 05:54:23 -0800 (PST)
Received: from smtpclient.apple ([115.96.159.226])
 by smtp.gmail.com with ESMTPSA id
 mn14-20020a1709030a4e00b001dcada71593sm8544922plb.273.2024.03.04.05.54.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Mar 2024 05:54:22 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 11/19] smbios: clear smbios_tables pointer after freeing
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-12-imammedo@redhat.com>
Date: Mon, 4 Mar 2024 19:24:06 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, wangyanan55@huawei.com,
 eblake@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: 7bit
Message-Id: <92FA6B88-CA59-498A-AEFA-9A82E3342230@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-12-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> that will avoid double free if smbios_get_tables() is called
> multiple times.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Maybe we can squash this with patch 10.

Other than that, 

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/smbios/smbios.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 7c28b5f748..d9ba2072b1 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1052,6 +1052,8 @@ void smbios_get_tables(MachineState *ms,
>     return;
> err_exit:
>     g_free(smbios_tables);
> +    smbios_tables = NULL;
> +    return;
> }
> 
> static void save_opt(const char **dest, QemuOpts *opts, const char *name)
> -- 
> 2.39.3
> 


