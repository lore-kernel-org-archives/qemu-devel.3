Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A76E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnVz-0001QY-FR; Wed, 18 Feb 2026 14:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnVt-0001Hq-KF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:47:11 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnVs-00027m-5P
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=o6xN62itcTikjTej258vkpWGDEkNJEIfYQGCXGo1UMU=; b=eAZ6zU0SYPdZHX7
 EH6elsu1mZlpYQ5tPrMrQS6Pq7w4J8SLyLz2FWpXg7g3qofMvQGAjRoF466UTNkY2PxnpeGh8RLFU
 jwwREAIg5Fn1RNDoiSceB8a/uqefYxOt8bYKb2vuz9pOC2lKWTQI/Sh95lxk3HS7+JDcuwHbM8MfJ
 Kk=;
Date: Wed, 18 Feb 2026 20:50:41 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 4/4] hppa: Add C3600 machine with PA-8600 CPU
Message-ID: <aZYYABuzZT-yF0lR@hive.localdomain>
References: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
 <20260210-hppa-c3600-v2-4-9ca09c677012@rev.ng>
 <816b7e55-ce79-25f9-42ef-fab8a98a00d8@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <816b7e55-ce79-25f9-42ef-fab8a98a00d8@eik.bme.hu>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/02/26, BALATON Zoltan wrote:
> On Tue, 10 Feb 2026, Anton Johansson via qemu development wrote:
> > Adds a C3600/PA-8600 machine/CPU, which from the perspective of
> > QEMU differ only in the size of the physical address, compared to
> > C3700/PA-8700.
> > 
> > With this addition, PA-8700 is changed to use the correct 44 bit
> > physical address space.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> > target/hppa/cpu-qom.h                 |  1 +
> > hw/hppa/machine.c                     | 41 ++++++++++++++++++++++++++++++-----
> > target/hppa/cpu.c                     | 10 ++++++++-
> > tests/functional/hppa/test_seabios.py |  3 +++
> > 4 files changed, 48 insertions(+), 7 deletions(-)
> > 
> > diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
> > index c6b82dc09b..078aa3b08a 100644
> > --- a/target/hppa/cpu-qom.h
> > +++ b/target/hppa/cpu-qom.h
> > @@ -28,6 +28,7 @@
> > #define HPPA_CPU_TYPE_NAME(name) (name HPPA_CPU_TYPE_SUFFIX)
> > 
> > #define TYPE_HPPA_CPU_PA_7300LC HPPA_CPU_TYPE_NAME("pa-7300lc")
> > +#define TYPE_HPPA_CPU_PA_8600   HPPA_CPU_TYPE_NAME("pa-8600")
> > #define TYPE_HPPA_CPU_PA_8700   HPPA_CPU_TYPE_NAME("pa-8700")
> > 
> > OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
> > diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> > index 8246f6bf65..ab5b8b6422 100644
> > --- a/hw/hppa/machine.c
> > +++ b/hw/hppa/machine.c
> > @@ -689,9 +689,9 @@ static AstroState *astro_init(void)
> > }
> > 
> > /*
> > - * Create HP C3700 workstation
> > + * Create HP C3000 series workstation
> >  */
> > -static void machine_HP_C3700_init(MachineState *machine)
> > +static void machine_HP_C3000_init(MachineState *machine)
> > {
> >     PCIBus *pci_bus;
> >     AstroState *astro;
> > @@ -804,9 +804,30 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
> >     mc->default_ram_size = 512 * MiB;
> > }
> > 
> > +static void HP_C3600_machine_init_class_init(ObjectClass *oc, const void *data)
> > +{
> > +    static const char * const valid_cpu_types[] = {
> > +        TYPE_HPPA_CPU_PA_8600,
> > +        NULL
> > +    };
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +
> > +    mc->desc = "HP C3600 workstation";
> > +    mc->default_cpu_type = TYPE_HPPA_CPU_PA_8600;
> > +    mc->valid_cpu_types = valid_cpu_types;
> > +    mc->init = machine_HP_C3000_init;
> > +    mc->max_cpus = HPPA_MAX_CPUS;
> > +    mc->default_ram_size = 1024 * MiB;
> > +}
> > +
> > static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
> > {
> > +    /*
> > +     * SeaBIOS for C3700 currently uses a 40 bit physical address space,
> > +     * allow use of use the PA-8600.
> 
> Something seems to be missing from this comment or too many uses of "use"?
> 
> Regards,
> BALATON Zoltan

Agh thanks, was a bit tired when writing these comments..

//Anton

