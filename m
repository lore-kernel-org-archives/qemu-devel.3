Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7832FFA373C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3Ir-00074Q-02; Fri, 13 Sep 2024 06:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sp3Il-00070m-KS; Fri, 13 Sep 2024 06:13:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sp3Ii-0001XZ-Ue; Fri, 13 Sep 2024 06:13:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X4qkd420Qz6GC0R;
 Fri, 13 Sep 2024 18:08:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E4A11400CD;
 Fri, 13 Sep 2024 18:13:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 12:13:02 +0200
Date: Fri, 13 Sep 2024 11:13:00 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240913111300.00007a3c@Huawei.com>
In-Reply-To: <20240913072025.76a329b0@foz.lan>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
 <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
 <20240825052923.715f88bc@sal.lan>
 <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
 <20240911163436.00004738@Huawei.com>
 <20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
 <20240913072025.76a329b0@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Sep 2024 07:20:25 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 12 Sep 2024 14:42:33 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed, 11 Sep 2024 16:34:36 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Wed, 11 Sep 2024 15:21:32 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >   
> > > > On Sun, 25 Aug 2024 05:29:23 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >     
> > > > > Em Mon, 19 Aug 2024 14:51:36 +0200
> > > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > > >       
> > > > > > > +        read_ack = 1;
> > > > > > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > > > > > +                                  &read_ack, (uint64_t));          
> > > > > > we don't do this for SEV so, why are you setting it to 1 here?      
> 
> The diffstat doesn't really help here. The full code is:
> 
>     /* zero means OSPM does not acknowledge the error */
>     if (!read_ack) {
>         error_setg(errp,
>                    "Last CPER record was not acknowledged yet");
>         read_ack = 1;
>         cpu_physical_memory_write(read_ack_start_addr,
>                                   &read_ack, sizeof(read_ack));
>         return;
>     }
> 
> > > > what you are doing here by setting read_ack = 1,
> > > > is making ack on behalf of OSPM when OSPM haven't handled existing error yet.
> > > > 
> > > > Essentially making HW/FW do the job of OSPM. That looks wrong to me.
> > > > From HW/FW side read_ack register should be thought as read-only.    
> > > 
> > > It's not read-only because HW/FW has to clear it so that HW/FW can detect
> > > when the OSPM next writes it.  
> > 
> > By readonly, I've meant that hw shall not do above mentioned write
> > (bad phrasing on my side).  
> 
> The above code is actually an error handling condition: if for some
> reason errors are triggered too fast, there's a bug on QEMU or there is
> a bug at the OSPM, an error message is raised and the logic resets the 
> record to a sane state. So, on a next error, OSPM will get it.
> 
> As described at https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html?highlight=asynchronous#generic-hardware-error-source:
> 
>    "Some platforms may describe multiple Generic Hardware Error Source
>     structures with different notification types, as defined in 
>     Table 18.10. For example, a platform may describe one error source
>     for the handling of synchronous errors (e.g. MCE or SEA), and a 
>     second source for handling asynchronous errors (e.g. SCI or
>     External Interrupt)."
> 
> Basically, the error logic there seems to fit for the asynchronous
> case, detecting if another error happened before OSPM handles the
> first one.

Agreed - the error logic to act as backpressure for the tool injecting
the error makes sense - it's just hardware acknowledging to paper
over slow software that is an issue.

> 
> IMO, there are a couple of alternatives to handle such case:
> 
> 1. Keep the code as-is: if this ever happens, an error message will
>    be issued. If SEA/MCE gets implemented synchronously on HW/FW/OSPM,
>    the above code will never be called;
> 2. Change the logic to do that only for asynchronous sources
>    (currently, only if source ID is QMP);
> 3. Add a special QMP message to reset the notification ack. Probably
>    would use Notification type as an input parameter;
> 4. Have a much more complex code to implement asynchronous notifications,
>    with a queue to receive HEST errors and a separate thread to deliver
>    errors to OSPM asynchronously. If we go this way, QMP would be
>    returning the number of error messages queued, allowing error injection
>    code to know if OSPM has troubles delivering errors;

Is this not better done in the injection code outside of qemu?
So detect the error in that and if it happens back off and try again
later?  Basically EBUSY done in an inelegant way.

> 5. Just return an error code without doing any resets. To me, this is 
>    the worse scenario.
> 
> I don't like (5), as if something bad happens, there's nothing to be
> done.

If it happens on a real system nothing is done either. So I'm not sure
we need to handle that.  Or maybe real hardware reinjects the interrupt
if the OSPM hasn't done anything about it for a while.

> 
> For QMP error injection (4) seems is overkill. It may be needed in the
> future if we end implementing a logic where host OS informs guest about
> hardware problems, and such errors use asynchronous notifications.
> 
> I would also avoid implementing (3) at least for now, as reporting
> such error via QMP seems enough for the QMP usecase.
> 
> So, if ok for you, I'll change the code to (2).

Whilst I don't feel strongly about it, I think 5 is unfortunately the
correct option if we aren't going to queue errors in qemu (so make it
an injection tool problem).

> 
> 
> > > Agreed this write to 1 looks wrong, but the one a few lines further down (to zero
> > > it) is correct.  
> > 
> > yep, hw should clear register.
> > It would be better to so on OSPM ACK, but alas we can't intercept that,
> > so the next option would be to do that at the time when we add a new error block
> >   
> > > 
> > > My bug a long time back I think.
> > > 
> > > Jonathan
> > >   
> > > >     
> > > > > 
> > > > > IMO, this is needed, independently of the notification mechanism.
> > > > > 
> > > > > Regards,
> > > > > Mauro
> > > > >       
> > > > 
> > > >     
> > >   
> >   
> 
> 
> 
> Thanks,
> Mauro


