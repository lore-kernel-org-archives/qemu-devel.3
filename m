Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B2CA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzEb-00057j-28; Fri, 30 Aug 2024 06:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changbin.du@huawei.com>)
 id 1sjzET-00053S-J0; Fri, 30 Aug 2024 06:51:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changbin.du@huawei.com>)
 id 1sjzEP-0003v9-R9; Fri, 30 Aug 2024 06:51:57 -0400
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwFK52MvSzpStD;
 Fri, 30 Aug 2024 18:49:45 +0800 (CST)
Received: from kwepemd100012.china.huawei.com (unknown [7.221.188.214])
 by mail.maildlp.com (Postfix) with ESMTPS id 61500140360;
 Fri, 30 Aug 2024 18:51:30 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100012.china.huawei.com (7.221.188.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 30 Aug 2024 18:51:30 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034; 
 Fri, 30 Aug 2024 18:51:29 +0800
To: Peter Maydell <peter.maydell@linaro.org>
CC: duchangbin <changbin.du@huawei.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/arm/boot: Report error msg if loading elf/dtb failed
Thread-Topic: [PATCH] hw/arm/boot: Report error msg if loading elf/dtb failed
Thread-Index: AQHa+q2oIp7h7OzKoEG863TRfi6oB7I/DPSAgACSrAA=
Date: Fri, 30 Aug 2024 10:51:29 +0000
Message-ID: <80da1b5b8a2043dea81d7883e10ccc55@huawei.com>
References: <20240830072409.2399084-1-changbin.du@huawei.com>
 <CAFEAcA995BnypV8Yx4fA_ojAt6NopyMnCWY8Gwb840++8kx91w@mail.gmail.com>
In-Reply-To: <CAFEAcA995BnypV8Yx4fA_ojAt6NopyMnCWY8Gwb840++8kx91w@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.110.54.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0AD03D4E217F64686041A4DAF22BAA0@huawei.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=changbin.du@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  duchangbin <changbin.du@huawei.com>
From:  duchangbin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 30, 2024 at 11:05:59AM +0100, Peter Maydell wrote:
> On Fri, 30 Aug 2024 at 08:24, Changbin Du <changbin.du@huawei.com> wrote:
> >
> > Print errors before exit. Do not exit silently.
> >
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  hw/arm/boot.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index d480a7da02cf..17c01f299831 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -839,6 +839,7 @@ static ssize_t arm_load_elf(struct arm_boot_info *i=
nfo, uint64_t *pentry,
> >                        1, data_swab, as);
> >      if (ret <=3D 0) {
> >          /* The header loaded but the image didn't */
> > +        error_report("could not load elf '%s'", info->kernel_filename)=
;
> >          exit(1);
>=20
> I agree we should print a message here.
>=20
> >      }
> >
> > @@ -1322,6 +1323,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *m=
s, struct arm_boot_info *info)
> >       */
> >      if (!info->skip_dtb_autoload && have_dtb(info)) {
> >          if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, m=
s) < 0) {
> > +            error_report("could not load dtb '%s'", info->dtb_filename=
);
> >              exit(1);
>=20
> But for this case, arm_load_dtb() should be printing the error
> message itself (which lets it be more precise about what went
> wrong). Is there a code path where it fails to print an error?
>
Seems not. arm_load_dtb() prints errors on all of its failure paths. So thi=
s
change should be removed.

> thanks
> -- PMM

--=20
Cheers,
Changbin Du

