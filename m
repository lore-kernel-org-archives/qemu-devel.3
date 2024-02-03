Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF82C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 02:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW5dr-0000ro-4M; Fri, 02 Feb 2024 21:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1rW5dp-0000rC-Ol
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 21:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1rW5do-00021Q-56
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 21:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706926821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiQgmYZ/mBc8N2CDgVTJqTovQfcuFwioJuvxcoCj8AM=;
 b=BXj7HgSLGDB60uDVRKx5F2Q2UF0ddlgVQUiwH6GB6nBWT4CkX2KTLGXBKPpe3jOiTZ1EaO
 nsSydb4ZYEfJ6QUSSKAaRyzr+Y7E0H1FULM1X1u0eEG/AusDG2Adelly4a/vUM1sZ5e5Gx
 HJkJOjSmQFuzANG3M+HLeEL2U7UoE54=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-DBUPTltrOUS7QW1ekGkbYg-1; Fri, 02 Feb 2024 21:19:13 -0500
X-MC-Unique: DBUPTltrOUS7QW1ekGkbYg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6040a34c24bso46736227b3.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 18:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706926752; x=1707531552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZiQgmYZ/mBc8N2CDgVTJqTovQfcuFwioJuvxcoCj8AM=;
 b=XKywvn06kQBUHlbvulQwRzAMrupOWA89iycIA+YQy7IEG8gT7OgUE/jt3D4iuj/Idu
 MStsq97zG1aU/1AdObYkZd843YBiKiZE5CLsCS4udv7XTJ324nRUuFMGXLyFJLQPfdF2
 Gkp3weQfICtnYYH+rAeDx3ZePE/0QWVwo+zqQG3e4g7BBqLVcKOTHHi1AFloHvYx9Gal
 zaOeLqFyYWbCGjbPwLpWhL4L3ptpNSrIVH38w/V9etdlU02Lq7+CVtTYvw6eqx+cs+3B
 SP/gPacMfWKYVYPYaVrdHrKLh1HzJhy0HWapZuZZCjpNIyNFTt7sCpRMq3Ssga/BdM3r
 RV9w==
X-Gm-Message-State: AOJu0YwlLgnj9qgCZmoc3wiJusMqnG5G8UhN8hLPKKPjmd2R5niVQ7m3
 TIDR1lcInKDUAYad7yeGvkfr5z8+n7AmtCTBY4PNl5QrmYIGpZZOHCzzhcs476AOrQ4LkKYzLV2
 ir97pTsxQVDFQMQAv+XZPIIziRakzFprcaJb+JO/ln2CwEwLVDB08NKb7d3NXcrmjqc1nya7dzz
 xGfqRbuV3bo+7Z2bNOZgol7Z4lbI0=
X-Received: by 2002:a81:a511:0:b0:5fc:f6d6:26fc with SMTP id
 u17-20020a81a511000000b005fcf6d626fcmr9375446ywg.52.1706926752152; 
 Fri, 02 Feb 2024 18:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6O61BmfF9xLVNSQQbY00nqihGy0ERrztqW/z9aB4R81mMw7st+PDi37INMXGdhOFNCP1AYLcWR/b28HDW5vM=
X-Received: by 2002:a81:a511:0:b0:5fc:f6d6:26fc with SMTP id
 u17-20020a81a511000000b005fcf6d626fcmr9375436ywg.52.1706926751867; Fri, 02
 Feb 2024 18:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <CAFEAcA-A-7H7nb++fkCr1O-aCt_U3JzrF_9=Sxp2Mg+kCWD_-w@mail.gmail.com>
In-Reply-To: <CAFEAcA-A-7H7nb++fkCr1O-aCt_U3JzrF_9=Sxp2Mg+kCWD_-w@mail.gmail.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Sat, 3 Feb 2024 10:19:00 +0800
Message-ID: <CAGYh1E8g_J5jwKpSxBPS+060diGt-rt4PeFvLRPet_0V9+bH-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] monitor: only run coroutine commands in
 qemu_aio_context
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, 
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It's easily for me to encounter " ../block/qcow2.c:5263:
ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *, Error
**): Assertion `false' failed" issue during 1Q vhost-user interface +
RT VM + post-copy migration

After applying this patch, the issue is still not reproduced even if I
repeat the same migration test for 60 times.

Tested-by: Yanghang Liu <yanghliu@redhat.com>


Best Regards,
YangHang Liu

On Mon, Jan 29, 2024 at 7:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 16 Jan 2024 at 19:01, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > Several bugs have been reported related to how QMP commands are resched=
uled in
> > qemu_aio_context:
> > - https://gitlab.com/qemu-project/qemu/-/issues/1933
> > - https://issues.redhat.com/browse/RHEL-17369
> > - https://bugzilla.redhat.com/show_bug.cgi?id=3D2215192
> > - https://bugzilla.redhat.com/show_bug.cgi?id=3D2214985
> >
> > The first instance of the bug interacted with drain_call_rcu() temporar=
ily
> > dropping the BQL and resulted in vCPU threads entering device emulation=
 code
> > simultaneously (something that should never happen). I set out to make
> > drain_call_rcu() safe to use in this environment, but Paolo and Kevin d=
iscussed
> > the possibility of avoiding rescheduling the monitor_qmp_dispatcher_co(=
)
> > coroutine for non-coroutine commands. This would prevent monitor comman=
ds from
> > running during vCPU thread aio_poll() entirely and addresses the root c=
ause.
> >
> > This patch series implements this idea. qemu-iotests is sensitive to th=
e exact
> > order in which QMP events and responses are emitted. Running QMP handle=
rs in
> > the iohandler AioContext causes some QMP events to be ordered different=
ly than
> > before. It is therefore necessary to adjust the reference output in man=
y test
> > cases. The actual QMP code change is small and everything else is just =
to make
> > qemu-iotests happy.
>
> Hi; we have a suspicion that this change has resulted in a flaky-CI
> test: iotest-144 sometimes fails, apparently because a "return"
> result from QMP isn't always returned at the same place in relation
> to other QMP events. Could you have a look at it?
>
> https://gitlab.com/qemu-project/qemu/-/issues/2126
>
> thanks
> -- PMM
>


