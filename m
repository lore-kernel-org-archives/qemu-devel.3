Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4383CCF65EC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLh4-0003Qt-Ej; Mon, 26 Jan 2026 07:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vkLh1-0002Y3-QF
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:27:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vkLgz-0001xv-Bp
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:27:43 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f07803R2tzJ46fK;
 Mon, 26 Jan 2026 20:26:56 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id B77FE40571;
 Mon, 26 Jan 2026 20:27:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 12:27:29 +0000
Date: Mon, 26 Jan 2026 12:27:28 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>, "Michael S
 Tsirkin" <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 Igor Mammedov
 <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH 06/13] scripts/qmp_helper: add support for a timeout logic
Message-ID: <20260126122728.00001d76@huawei.com>
In-Reply-To: <20260126122932.10a3d552@localhost>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
 <20260121123927.00001daa@huawei.com> <aXD1Nb4MU2XYI0HL@foz.lan>
 <20260123161603.00006b0d@huawei.com>
 <20260126122330.515e5deb@localhost>
 <20260126122932.10a3d552@localhost>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 26 Jan 2026 12:29:32 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> On Mon, 26 Jan 2026 12:23:30 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> (by way of Mauro Carvalho Chehab <mchehab+huawei@kernel.org>) wrote:
> 
> > On Fri, 23 Jan 2026 16:16:03 +0000
> > Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:
> >   
> > > > >       
> > > > > > +        for i in range(0, attempts):
> > > > > > +            try:
> > > > > > +                obj = self.qmp_monitor.cmd_obj(msg)
> > > > > > +
> > > > > > +                if obj and "return" in obj and not obj["return"]:
> > > > > > +                    break
> > > > > > +
> > > > > > +            except Exception as e:                     # pylint: disable=W0718
> > > > > > +                print(f"Command: {command}")
> > > > > > +                print(f"Failed to inject error: {e}.")
> > > > > > +                obj = None
> > > > > > +
> > > > > > +            if attempts > 1:
> > > > > > +                print(f"Error inject attempt {i + 1}/{attempts} failed.")
> > > > > > +
> > > > > > +            if i + 1 < attempts:
> > > > > > +                sleep(0.1)      
> > > > 
> > > > ... and here, we sleep for 0.1 seconds.
> > > >     
> > > > > 
> > > > > Do we care about a sleep at the end?  Feels like a micro optimization that
> > > > > isn't needed.      
> > > > 
> > > > This is not a micro-optimization. It is more to ensure that we won't
> > > > respin it too fast.
> > > > 
> > > > What happens is that QMP interface asks the BIOS to send an async
> > > > message to OSPM, cleaning an ack register. When the OSPM reads the
> > > > error, it writes 1 to the ack register.
> > > > 
> > > > If we send messages too fast, the logic at ghes.c will detect that
> > > > the ack didn't happen, imediately returning an errocr code.
> > > > 
> > > > On such case, we sleep for 100ms before trying again.    
> > > I was suggesting the opposite.  Just sleep one more time at the end
> > > before timing out.
> > > So instead of
> > > 	if i + 1 < attempts
> > > 		sleep(0.1)
> > > 
> > > simply
> > > 	sleep(0.1)  
> > 
> > If one writes an external loop calling fuzzy with different parameters,
> > like:
> > 
> > 	for i in $(seq 1 360000); do
> >             scripts/ghes_inject.py fuzzy -T proc-arm;
> >             scripts/ghes_inject.py fuzzy -T firmware-error;
> >         done
> > 
> > The extra unneeded would sleep waste 10 hours doing nothing.

True if it fails every time, which you were suggesting was very rare. 

Anyhow I really don't mind that much, just seemed like a tiny
bit over engineered for a rare case. 
 
> 
> Btw, the same applies when using the -c parameter:
> 
>              scripts/ghes_inject.py fuzzy -T proc-arm -c 360000
> 
> The goal here is to optimize in a way that we could one day have a
> CI running lots of tests in a reasonable time to detect regressions
> at QEMU + Linux Kernel + rasdaemon.
> 
> So, we don't want unneeded delays. We only need to sleep if a
> retry attempt failed and it will be retrying again.
> 
> Regards,
> 


