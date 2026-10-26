Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E1606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K3dk7Y8M;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FZgYDbIh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLQsT-0004rz-Tj; Mon, 26 Oct 2026 16:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLQsS-0004rk-4l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 16:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLQsQ-0006R4-7f
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 16:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793044859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPQVLK2vPIup/qzJQ1PgZf9iYUNojpWBm+JxAxGyBM0=;
 b=K3dk7Y8MxuX1AUkSHEuG091f8gV5Xfn4mkXcjTPbkwGuAulyYmTcmMjHsCrQeCzjgjmsnZ
 xPaExYwp4uD9M8QGA2tZ96P8GbZ+U9Ufb4vcycUpkJeKW79EWNrYTm6pmA6s6pOUi0wod5
 9n0X8CuOh5EtDlwpwmhPtA6K4cDNkGM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-9EAiG3-PMe6PmSHZ-7sWXg-1; Mon, 26 Oct 2026 16:00:55 -0400
X-MC-Unique: 9EAiG3-PMe6PmSHZ-7sWXg-1
X-Mimecast-MFC-AGG-ID: 9EAiG3-PMe6PmSHZ-7sWXg_1793044855
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso121316196d6.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793044855; x=1793649655; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iPQVLK2vPIup/qzJQ1PgZf9iYUNojpWBm+JxAxGyBM0=;
 b=FZgYDbIhOA/MkNg3Ckaouh0Ri4YBd8GstQbyRv4gY0iX16WjXO3C72wLv/nttddMH5
 t+TAyrS4ZjkjoX8RohQ2jR4doxmG4nOutUY0bbNFbFj6eifH7lxLI1vI49yPIhf20CT1
 3T3SUpayzSuI6yal/nGO/v3gsA889e8fOGo5kJxq4qBBTojMMDMdsBwH9K9Ce15cls0z
 SR5Sn46hc+yyAIn7E/m5nbqEA1TkkbjIlkUrmYQkpxMClEUIfxeiBil7dLtnVP+0yFcI
 WHng8is2e8WpwzUU0HCUo16V/mv624sAI2lcCeHIRyvPVlj/EqyfYeONsRxT8z4f0doY
 3cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793044855; x=1793649655;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iPQVLK2vPIup/qzJQ1PgZf9iYUNojpWBm+JxAxGyBM0=;
 b=zg2gTjejAuwFZqmKR/CR6nRDlpNI3mysqzmRuGgXMd6FSws0nfd/NkGL1wuXMww4dg
 a2wM0DmnNjYKnzLxVsHB41baD5pmKS+02CBBZ9debWlssWiFC3fmZ0SqVE24Bws6MHwI
 ZP/WI+0wFEg4CIbDc/wdYRZQdvKyf6HsAV6oKWgQhaLGbgxNkHCL+vZmrVvT/Kg1pslS
 CkQOd+yFYgqcjg6G6EJS77r1oPHbR8tc8RulPk/IlW2QCfkiRSRME4mXy7MqAuW9oHEm
 RuQ+iR9rb3eN6vgQZPBac4FsmOXXbQ32cFLBPXELCD6YHXpRmfPlKzxtHEGMEktkhZgk
 0AYg==
X-Forwarded-Encrypted: i=1;
 AKwUvByaDwTVBprX70gYJMiCakOvX3G73aqv/1hd+m6pzQ+sZr9BezzchGC/8GvlPdUA2Nkz66nxCTnqNbzx@nongnu.org
X-Gm-Message-State: AFq9FYLp/7TgVB7SIjrdi7hAcN+dBGmx39us5IcXDJkUqriF8mV+CX+E
 9k2iQ6vKZh8+4Xd/IfNMGxFa/Zs/9bzm/macELl0u9IetPYiAUDlI4xwdoXZ16Hrx6SE8mOojGh
 Qx2r2RK1II5NSMUBUIlWxpszyZM0YEvkNcG7+phBWZyklUSidv2MU0fNm
X-Gm-Gg: AYBFou1rJyteED9tyQAqPtgTotAxOcOmzpl4pbdiDtFf8BMnbj/oFTmiAKkjVR6KFbB
 sXb3LXK0Cyu8AvGEKfzJrFj7VtpJbOnHkMA1UYCC2AKJyfvOilNxtxKiSBzBIwHGjp3/GIRmJyV
 HHHi5CCJUBpoX/dRpcHkiAKFnpVqmEc5K9CGfNlLTqWJ9cmxuktEcI2F1Vs+PvDOeAkTW02jqNX
 BE3RZPgEx+5BcpQiX4Sf5p0gIeXGIueldUZlkpx1EukA+56s7GIE3tA6MBklE49VGnfNV0pMPwV
 6q+EtuqNgjIYro8Ib+yOAgBVPO8uSn1fMD6sNnOromx++jFFtYDzmDW/7IKO3E6rlWqFHUkTZna
 p9eiFBFoYY5+wtCKpw+PzI6/dNGyr8NaVGcGNPO5Hzjrw
X-Received: by 2002:a05:6214:124f:b0:914:4869:fe3f with SMTP id
 6a1803df08f44-91c48e5ad58mr129038376d6.43.1793044854631; 
 Mon, 26 Oct 2026 13:00:54 -0700 (PDT)
X-Received: by 2002:a05:6214:124f:b0:914:4869:fe3f with SMTP id
 6a1803df08f44-91c48e5ad58mr129037126d6.43.1793044853824; 
 Mon, 26 Oct 2026 13:00:53 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c6c4e7565sm9061086d6.15.2026.10.26.13.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:00:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:00:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: migration, PCIE ports, and parent_obj.parent_obj.parent_obj
Message-ID: <at-xdAQEyEqYwOe8@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA_1ESA4Uan=gJyiRrjj4-EVvtfgn2dUT8qDa8zUU_gf=g@mail.gmail.com>
 <20261026121828-mutt-send-email-mst@kernel.org>
 <at-QMTmel_ZAWLPa@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8WxxFBfUc+TJa33aouEbFtpMkCVk_auuwWk3EKyB7V2g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8WxxFBfUc+TJa33aouEbFtpMkCVk_auuwWk3EKyB7V2g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 07:10:21PM +0000, Peter Maydell wrote:
> On Mon, 26 Oct 2026 at 17:39, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Oct 26, 2026 at 12:19:07PM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Oct 26, 2026 at 04:11:57PM +0000, Peter Maydell wrote:
> > > > In reviewing a new pcie host bridge, I noticed (because this new device
> > > > copied existing code) that the vmstate structs for pcie root ports do
> > > > this in their vmstate structs:
> > > >
> > > >     .fields = (const VMStateField[]) {
> > > >         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > > >         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
> > > >                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> > > >         VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
> > > >                      GenPCIERootPort),
> > > >         VMSTATE_END_OF_LIST()
> > > >     }
> > > >
> > > > (this specific example is hw/pci-bridge/gen_pcie_root_port.c).
> > > >
> > > > Devices shouldn't have to have ugly long chains of "parent_obj"
> > > > like this and shouldn't have to care what in their parents needs
> > > > migration; compare e.g. SCSI devices, which start with a
> > > > "VMSTATE_SCSI_DEVICE" that captures all the parent class's needs,
> > > > followed by only the state that the child added.
> > > >
> > > > How can we get to something more like that for PCIE port classes?
> > > >
> > > > thanks
> > > > -- PMM
> > >
> > > Yea makes total sense. Anyone has the bandwidth to take a stab?
> > > I'm buried under a pile of ai generated security reports.
> >
> > /me buried too on other things downstream.  I'm prepared to not be able to
> > work much upstream until after forum..
> >
> > A quick look is this is not too bad yet:
> >
> > $ git grep parent_obj.parent_obj | wc -l
> > 20
> > $ git grep parent_obj.parent_obj.parent_obj | wc -l
> > 11
> > (and, some of above lines are part of vm static checker script)
> >
> > Looks not too bad yet?
> 
> Depends on your definition of "bad" :-)  This is basically
> the only vmstate that's doing this thing, and it would be
> nice to correct it before we add more devices that end up
> following the same pattern.

I agree.

> 
> I agree it's not super urgent; I posted mostly because I have
> no idea what the right fix is (especially given we want to
> retain migration compat here).

I confess I didn't even try to think further than counting lines. :(
I'll try some day.

Thanks,

-- 
Peter Xu


