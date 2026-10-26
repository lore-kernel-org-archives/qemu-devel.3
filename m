Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294F606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7xYQQzV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KH1SYnlu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOh1-0003Er-0U; Mon, 26 Oct 2026 13:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLOf9-0002T8-MT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLOf7-0000W9-Kc
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793036344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7IZnAaf+ITTPcsMQHVX/LWexAtRdOB4pnjCdOP2k2dI=;
 b=D7xYQQzVFR0vVcyH3YqqK8YO1pr8PAAWSLcBaI/1SvxGqWx5vRcmneni6/2o01Rh0WqUR3
 77WqK0v+VRPvof5yOfP+fv465cR8yIJUx90u1dVPhA/bAopReHCKJXej9GeyA1ChozdA6I
 QuteNIb/gxBLy4dPw1TPPdlSmJ5DyQA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-AlrYvPdoNVa5LUTdJBlx4Q-1; Mon, 26 Oct 2026 13:39:01 -0400
X-MC-Unique: AlrYvPdoNVa5LUTdJBlx4Q-1
X-Mimecast-MFC-AGG-ID: AlrYvPdoNVa5LUTdJBlx4Q_1793036340
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so680905385a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793036340; x=1793641140; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7IZnAaf+ITTPcsMQHVX/LWexAtRdOB4pnjCdOP2k2dI=;
 b=KH1SYnluh9ykHN56DIRMx1tz8E4Fq7wefx34nip8LshsGST6NeXpH8qakfgY4op+mV
 ftgnnzjdZ8rza9AsIPc6SD8akfQxid9A5mdi7ru/rRinaXhlJ18uyGixsg2+Bxmo+0ES
 uGWFEATPzl/8+QbfvP3rDBPGxdw+mms68YXphUuamE49arepLnDx0SeCEPa2aIZCin4t
 bKKQGcBKLWSN8eGoylQ1OHZJMZU0MUDMrMZaQBueqEQfRjBQv107djPaXlTRGz+Uk410
 kQ5m6mflbKaDGQpTpltzj7usoIo7uxDISYb4Gai7THSNhbAnDnU0c9OAPxKfxLHvL0sh
 iXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036340; x=1793641140;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7IZnAaf+ITTPcsMQHVX/LWexAtRdOB4pnjCdOP2k2dI=;
 b=1XWHGIz7ko+YM4/F7vC90enpZyO9VMLP72uCAVXiYAwcPFV2y4xhesc8eGcSO/jxv7
 C6IO5tx8M7ZCZvrbi9/X8dfsdcZMzJigHBvFaj0d9tv/p0x8ERxLc4xnYd5Bf2pZkOxP
 ZBXVt+KNlhN47aSiKqBpWjHGHemH8mySX0ayG0QNXKLhdm4WrT+tPv5FC29YBZyrE+z0
 rzikwey0FaaT2MldwNsqivMwAdMGXyRFEHsz28DKeAzvRAho5qRcwXEhk5FItTneZ+uX
 p2H54q70jLlNXjS3g5FiRIWfBb0FK7kA1uUSiYuRo3E1YXqmo4maMRSPaulqdMX/+fEX
 IutA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuHDeIbYrJ8K/7CSrPQPXb5ICVVgNjUKRvnxuIyDu5BSW03rRti/maP/DJ4UbU1VrI+aVGFQf2obUN@nongnu.org
X-Gm-Message-State: AFq9FYLxMglD6YbOvbiO7IEf7o8xvPFpMst8xMbdj5J2XWJ4mtQMA3fZ
 fVQCpyYj2KV2m+s0as9uZaAfsDWjxa+rndQrocxDKFR5j4ZqAEgCMoS077KEXs+MG795JO8hhCU
 dghBP+dlU3+cLN1ickE5qI5An3CdDoQY35eEDg6mUJcoVWhD1jkSXfQO4
X-Gm-Gg: AYBFou2I69UtxYtbLknWHxHLdWSBq7c1fNScJ/Pkpyvf2uHYKLoetVH0kayDVot5pMN
 fvyqJsU6X111tenifJeW8Qma4HrpEceqcOhBmz72s4WwAOuPHCpmsiplclq/SqKBGp5blWIHHAw
 XWcnYexstF83zu94e7lexwuM4XvYJP4Q/He9GGuxOUuoQDtk4kAwPC5vboQPXGpoVaRWkPg/tqr
 XqgfTeKPlz5554d0p1/FWuc2ndDlxtzwpeT8kLAcTEN6oJFtS18JF6E/BqRvD1OaaWE6NU4x7fW
 07sCcoj4VVokJEhG+8utHRlVgOtRQcb/KUp+VUs8Y1uBJZkAHqQ2rlpCWMcYCgBvanDG0ac=
X-Received: by 2002:a05:620a:6887:b0:939:6dfa:48fd with SMTP id
 af79cd13be357-940ef96543fmr1116838085a.51.1793036340052; 
 Mon, 26 Oct 2026 10:39:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6887:b0:939:6dfa:48fd with SMTP id
 af79cd13be357-940ef96543fmr1116832185a.51.1793036339338; 
 Mon, 26 Oct 2026 10:38:59 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f078cc39sm742374085a.31.2026.10.26.10.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:38:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:38:57 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: migration, PCIE ports, and parent_obj.parent_obj.parent_obj
Message-ID: <at-QMTmel_ZAWLPa@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA_1ESA4Uan=gJyiRrjj4-EVvtfgn2dUT8qDa8zUU_gf=g@mail.gmail.com>
 <20261026121828-mutt-send-email-mst@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026121828-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 26, 2026 at 12:19:07PM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 26, 2026 at 04:11:57PM +0000, Peter Maydell wrote:
> > In reviewing a new pcie host bridge, I noticed (because this new device
> > copied existing code) that the vmstate structs for pcie root ports do
> > this in their vmstate structs:
> > 
> >     .fields = (const VMStateField[]) {
> >         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> >         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
> >                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> >         VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
> >                      GenPCIERootPort),
> >         VMSTATE_END_OF_LIST()
> >     }
> > 
> > (this specific example is hw/pci-bridge/gen_pcie_root_port.c).
> > 
> > Devices shouldn't have to have ugly long chains of "parent_obj"
> > like this and shouldn't have to care what in their parents needs
> > migration; compare e.g. SCSI devices, which start with a
> > "VMSTATE_SCSI_DEVICE" that captures all the parent class's needs,
> > followed by only the state that the child added.
> > 
> > How can we get to something more like that for PCIE port classes?
> > 
> > thanks
> > -- PMM
> 
> Yea makes total sense. Anyone has the bandwidth to take a stab?
> I'm buried under a pile of ai generated security reports.

/me buried too on other things downstream.  I'm prepared to not be able to
work much upstream until after forum..

A quick look is this is not too bad yet:

$ git grep parent_obj.parent_obj | wc -l
20
$ git grep parent_obj.parent_obj.parent_obj | wc -l
11
(and, some of above lines are part of vm static checker script)

Looks not too bad yet? Still, I'll add a todo at least to myself (the other
place is https://wiki.qemu.org/ToDo/LiveMigration, feel free to update if
one sees it fit).

Thanks,

-- 
Peter Xu


