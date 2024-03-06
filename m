Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA0AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rho5O-0005Ht-3A; Wed, 06 Mar 2024 05:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rho5L-0005FH-8v
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rho5F-0004ra-T5
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709719268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTp8e0WZUBvMyqT1cOn79edMLQPrjwMomvyCPj6o8mk=;
 b=ILeTWl3Y/TZ96j5tj3mn9OzLoVvGdWXE4tN0R8r+TmJ3qhp2o3iGZKpIRUeI93f9/R3VOr
 Wb1a74bOOqB74Etz7XV8KL3q/UNZgBw5jOIDhvOUJAOJa3f0wedCBNo0JPog/7TY2djwIv
 A01qQ1Di9zaFs0GPUd1lzy3+lphNJ40=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9GbhIL2kPs6DolkyY6hu9g-1; Wed, 06 Mar 2024 05:01:07 -0500
X-MC-Unique: 9GbhIL2kPs6DolkyY6hu9g-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c1a8342d69so932499b6e.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 02:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709719266; x=1710324066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTp8e0WZUBvMyqT1cOn79edMLQPrjwMomvyCPj6o8mk=;
 b=bPQQP05pRBJbgOtr8xgss3WmoySsfOCZ9EjzlljlxdiOmoktoUDBF49MGx9/Xy4WQt
 g8vsCSF8U4ZbkSXJmH21UzhulN938ORyZ3+zHM0yMNHyhNoRuFqTz5G0ZHeM60SXTXwF
 0fHdoadLX644UeIA1eIA7L8vcupG7sIapbPv1HPefnrYSwm9EYaq+I2eWlDD6Q6HufZ0
 42qJKHpieNnsomTjecvwK8Qq2cdIxEsL2HGVkdwMs74ZtrI8aA+8qFWo/3Zbd4svZXvw
 zBl0NQ+DRcjM0EHPfKqWOC/AimiddxE3wAuiCbJ1aPU6nleBrO4a96yibswuYa+iAn+F
 nwCA==
X-Gm-Message-State: AOJu0YwMQ1HY53GrBoMwKM1ie0p6+TSGijAyVd9xjMj8hFBzIOejEcOx
 Ti6BnCpDtSa5O3f1iV3I8dALI1Bk2zUcapCJjiEwWUrxH/ZTnf/Tqzqp7+IxYCG80T8KFCDwBye
 DNt+CGnmeJVIb6+xDrdX9pSIR4+rNv11BTmT9k+BhqTndEf133Evz
X-Received: by 2002:a05:6358:80a0:b0:17b:520f:8249 with SMTP id
 a32-20020a05635880a000b0017b520f8249mr4794690rwk.31.1709719266336; 
 Wed, 06 Mar 2024 02:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKe6ANnrnrAIRgAbxgSrpPQXkNhGwV6mJEOS8kPXC2mufMyikqQ33Z+P6+NcQxRqKpUu9xPQ==
X-Received: by 2002:a05:6358:80a0:b0:17b:520f:8249 with SMTP id
 a32-20020a05635880a000b0017b520f8249mr4794660rwk.31.1709719266078; 
 Wed, 06 Mar 2024 02:01:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 qp30-20020a05620a389e00b0078820f053b0sm3850364qkn.109.2024.03.06.02.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 02:01:05 -0800 (PST)
Date: Wed, 6 Mar 2024 11:01:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Alistair
 Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, wangyanan55@huawei.com,
 eblake@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH v2 20/20] tests: acpi: update expected SSDT.dimmpxm blob
Message-ID: <20240306110100.6b1c445d@imammedo.users.ipa.redhat.com>
In-Reply-To: <9E373F64-2290-4AF7-A23D-340FB6CE86F8@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-21-imammedo@redhat.com>
 <9E373F64-2290-4AF7-A23D-340FB6CE86F8@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 6 Mar 2024 14:50:20 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 05-Mar-2024, at 21:27, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > address shift is caused by switch to 32-bit SMBIOS entry point
> > which has slightly different size from 64-bit one and happens
> > to trigger a bit different memory layout.  
> 
> Why does it affect only q35 machines and not i440fx as well?

that what tests show, mem layout is a bit different between those 

> 
> > 
> > Expected diff:
> > 
> > -    Name (MEMA, 0x07FFE000)
> > +    Name (MEMA, 0x07FFF000)
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Acked-by: Ani Sinha <anisinha@redhat.com>
> 
> > ---
> > tests/qtest/bios-tables-test-allowed-diff.h |   1 -
> > tests/data/acpi/q35/SSDT.dimmpxm            | Bin 1815 -> 1815 bytes
> > 2 files changed, 1 deletion(-)
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index 81148a604f..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,2 +1 @@
> > /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/q35/SSDT.dimmpxm",
> > diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/q35/SSDT.dimmpxm
> > index 70f133412f5e0aa128ab210245a8de7304eeb843..9ea4e0d0ceaa8a5cbd706afb6d49de853fafe654 100644
> > GIT binary patch
> > delta 23
> > ecmbQvH=U0wIM^jboSlJzam_|9E_UV*|JeaVTLvQl
> > 
> > delta 23
> > ecmbQvH=U0wIM^jboSlJzanD9BE_UVz|JeaVy9Ofw
> > 
> > -- 
> > 2.39.3
> >   
> 


