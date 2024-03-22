Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF489C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 05:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnX9L-0001JA-3U; Fri, 22 Mar 2024 01:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rnX9I-0001Iy-Q3
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 01:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rnX9G-0007ni-Ic
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 01:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711084135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wI05PcXhsGCvbeIpxplJvwpXlfY8r3XKcHbiSoAvAhQ=;
 b=Qec91XVV0XI7DeBhY6hojleQO4P+aEgWqvYauqJS5ZWBdjAc6OGGdFwrg/ap6QoJm2+sg5
 bLLNOT1gGQ88htgM9c0S0mgkr7HBXp+4/+bxu362ZJY9kNAl/Dh8+TvpG1ahAHriBnO8LM
 AqidV1rFVec5J2ae3qVtuQM3hTXljoU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-yWlS_85uMbSXtrKECS8mLQ-1; Fri, 22 Mar 2024 01:08:53 -0400
X-MC-Unique: yWlS_85uMbSXtrKECS8mLQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c38cb97a3aso1813375b6e.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 22:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711084132; x=1711688932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wI05PcXhsGCvbeIpxplJvwpXlfY8r3XKcHbiSoAvAhQ=;
 b=M4SM/QHyu7yKmqRByR8SQYwr68B0NUhIIWD/vm7ZhHXfalx4GaZi+RUpSMrPZ64sRR
 eFaEQyuU+aoFGEkeTb/VV06/njA3XwB122TTpgi1f67TsJk08ctf54mfBjEY+7HWPUEy
 x476FQDaPBKkEyhj2pqDgkRV6dPC1r6g7vMDmpBKUcF28KaoyTLTP0mWGYUgSr5ghdRf
 LlOD/ysTtbznlYBeRuI9BbPXI8/yGMRNOkKelsjsNsmaEmz9nDywi/VgPKS7HuEI7vNH
 feJT8PfRbkaCSssUn4tEpUeSSOJu5PjKiuHAdvIm+QIsJLrqFx/QLa4MRcfA2HvLJRdt
 l3bg==
X-Gm-Message-State: AOJu0YwIntrKm+4J6WAwIxMrFWsQCTZBsrXM4VbYH7sfQUkKaJCFE8rl
 oNFBRscrh7bZM1ci5RSfYu5WD2zTgPSs8xp1S9kEQJps0S1o1qV3niaEqFxD6HOB6CHrcllNv8/
 M8mFPcsLoKdwKoIUg0cBcaIqyS7fBL0YrJ7QqTR5YyEqrVT/A7eYRbN/5yIk8p2vga63sdMfF6m
 o7zv8qc4LzAVuMe3ROZcEBoZfu+e8=
X-Received: by 2002:a05:6808:a09:b0:3c3:9e3d:c632 with SMTP id
 n9-20020a0568080a0900b003c39e3dc632mr1275786oij.23.1711084132557; 
 Thu, 21 Mar 2024 22:08:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzjv4IXTdb451uwFTOCapDeHhGwfHf9JphIVufqFx6MN4PBeaWEvTX2tiaIas6XSlCt11kQVJXbeVMN1x8wGQ=
X-Received: by 2002:a05:6808:a09:b0:3c3:9e3d:c632 with SMTP id
 n9-20020a0568080a0900b003c39e3dc632mr1275775oij.23.1711084132263; Thu, 21 Mar
 2024 22:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
 <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
 <CACGkMEtEtmOZB53xibp5G7ZeVdKpZogEnetfnfj1QCSX-RWY8w@mail.gmail.com>
 <0dec84ec-289b-4026-8098-010ec4c5c315@oracle.com>
 <CACGkMEtWe59mNWORwS=OMg3MXFRdkPwmjJu8wR2rTXBr4w2_MQ@mail.gmail.com>
 <35fc446d-61e3-49a3-b79d-c44aa2e65fea@oracle.com>
 <CACGkMEsbsqpw4NLJkkoNh8xfbpKgz9Usm5YO_qjF3JyB2K0frw@mail.gmail.com>
 <99ac7902-57ba-41b2-9f1b-368f4563fbc2@oracle.com>
In-Reply-To: <99ac7902-57ba-41b2-9f1b-368f4563fbc2@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:08:41 +0800
Message-ID: <CACGkMEus=LsocdQPR6UE4HrXyCJFyGQRcpHKBYX89VKOckwW7g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 22, 2024 at 5:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 3/20/2024 8:56 PM, Jason Wang wrote:
> > On Thu, Mar 21, 2024 at 5:03=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 3/19/2024 8:27 PM, Jason Wang wrote:
> >>> On Tue, Mar 19, 2024 at 6:16=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 3/17/2024 8:22 PM, Jason Wang wrote:
> >>>>> On Sat, Mar 16, 2024 at 2:45=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> On 3/14/2024 9:03 PM, Jason Wang wrote:
> >>>>>>> On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@or=
acle.com> wrote:
> >>>>>>>> On setups with one or more virtio-net devices with vhost on,
> >>>>>>>> dirty tracking iteration increases cost the bigger the number
> >>>>>>>> amount of queues are set up e.g. on idle guests migration the
> >>>>>>>> following is observed with virtio-net with vhost=3Don:
> >>>>>>>>
> >>>>>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> >>>>>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> >>>>>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> >>>>>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
> >>>>>>>>
> >>>>>>>> With high memory rates the symptom is lack of convergence as soo=
n
> >>>>>>>> as it has a vhost device with a sufficiently high number of queu=
es,
> >>>>>>>> the sufficient number of vhost devices.
> >>>>>>>>
> >>>>>>>> On every migration iteration (every 100msecs) it will redundantl=
y
> >>>>>>>> query the *shared log* the number of queues configured with vhos=
t
> >>>>>>>> that exist in the guest. For the virtqueue data, this is necessa=
ry,
> >>>>>>>> but not for the memory sections which are the same. So essential=
ly
> >>>>>>>> we end up scanning the dirty log too often.
> >>>>>>>>
> >>>>>>>> To fix that, select a vhost device responsible for scanning the
> >>>>>>>> log with regards to memory sections dirty tracking. It is select=
ed
> >>>>>>>> when we enable the logger (during migration) and cleared when we
> >>>>>>>> disable the logger. If the vhost logger device goes away for som=
e
> >>>>>>>> reason, the logger will be re-selected from the rest of vhost
> >>>>>>>> devices.
> >>>>>>>>
> >>>>>>>> After making mem-section logger a singleton instance, constant c=
ost
> >>>>>>>> of 7%-9% (like the 1 queue report) will be seen, no matter how m=
any
> >>>>>>>> queues or how many vhost devices are configured:
> >>>>>>>>
> >>>>>>>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
> >>>>>>>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
> >>>>>>>>
> >>>>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> >>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>>>>>
> >>>>>>>> ---
> >>>>>>>> v3 -> v4:
> >>>>>>>>       - add comment to clarify effect on cache locality and
> >>>>>>>>         performance
> >>>>>>>>
> >>>>>>>> v2 -> v3:
> >>>>>>>>       - add after-fix benchmark to commit log
> >>>>>>>>       - rename vhost_log_dev_enabled to vhost_dev_should_log
> >>>>>>>>       - remove unneeded comparisons for backend_type
> >>>>>>>>       - use QLIST array instead of single flat list to store vho=
st
> >>>>>>>>         logger devices
> >>>>>>>>       - simplify logger election logic
> >>>>>>>> ---
> >>>>>>>>      hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++=
++++++++++++++-----
> >>>>>>>>      include/hw/virtio/vhost.h |  1 +
> >>>>>>>>      2 files changed, 62 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>>>>>> index 612f4db..58522f1 100644
> >>>>>>>> --- a/hw/virtio/vhost.c
> >>>>>>>> +++ b/hw/virtio/vhost.c
> >>>>>>>> @@ -45,6 +45,7 @@
> >>>>>>>>
> >>>>>>>>      static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> >>>>>>>>      static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_M=
AX];
> >>>>>>>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYP=
E_MAX];
> >>>>>>>>
> >>>>>>>>      /* Memslots used by backends that support private memslots =
(without an fd). */
> >>>>>>>>      static unsigned int used_memslots;
> >>>>>>>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *=
dev)
> >>>>>>>>          }
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
> >>>>>>>> +{
> >>>>>>>> +    assert(dev->vhost_ops);
> >>>>>>>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NO=
NE);
> >>>>>>>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MA=
X);
> >>>>>>>> +
> >>>>>>>> +    return dev =3D=3D QLIST_FIRST(&vhost_log_devs[dev->vhost_op=
s->backend_type]);
> >>>>>>> A dumb question, why not simple check
> >>>>>>>
> >>>>>>> dev->log =3D=3D vhost_log_shm[dev->vhost_ops->backend_type]
> >>>>>> Because we are not sure if the logger comes from vhost_log_shm[] o=
r
> >>>>>> vhost_log[]. Don't want to complicate the check here by calling in=
to
> >>>>>> vhost_dev_log_is_shared() everytime when the .log_sync() is called=
.
> >>>>> It has very low overhead, isn't it?
> >>>> Whether this has low overhead will have to depend on the specific
> >>>> backend's implementation for .vhost_requires_shm_log(), which the co=
mmon
> >>>> vhost layer should not assume upon or rely on the current implementa=
tion.
> >>>>
> >>>>> static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
> >>>>> {
> >>>>>        return dev->vhost_ops->vhost_requires_shm_log &&
> >>>>>               dev->vhost_ops->vhost_requires_shm_log(dev);
> >>>>> }
> >>> For example, if I understand the code correctly, the log type won't b=
e
> >>> changed during runtime, so we can endup with a boolean to record that
> >>> instead of a query ops?
> >> Right now the log type won't change during runtime, but I am not sure =
if
> >> this may prohibit future revisit to allow change at the runtime,
> > We can be bothered when we have such a request then.
> >
> >> then
> >> there'll be complex code involvled to maintain the state.
> >>
> >> Other than this, I think it's insufficient to just check the shm log
> >> v.s. normal log. The logger device requires to identify a leading logg=
er
> >> device that gets elected in vhost_dev_elect_mem_logger(), as all the
> >> dev->log points to the same logger that is refenerce counted, that we
> >> have to add extra field and complex logic to maintain the election
> >> status.
> > One thing I don't understand here (and in the changelog) is why do we
> > need an election here?
>
> vhost_sync_dirty_bitmap() not just scans the guest memory sections but
> the specific one for virtqueues (used rings) also. To save more CPU
> cycles to the best extend, the guest memory must be scanned only once in
> each log iteration, though the logging for used rings would still have
> to use the specific vhost instance, so all vhost_device instance still
> keeps the dev->log pointer to the shared log as-is. Generally the shared
> memory logger can be picked from an arbitrary vhost_device instance, but
> to keep the code simple, performant and predictable

This is the point, I don't see why election is simpler than picking an
arbitrary shared log in this case.

> , logger selection is
> made on the control path at the vhost add/remove time rather than be
> determined at the dirty log collection runtime, the latter of which is
> in the hotpath.
>
> >
> >> I thought that Eugenio's previous suggestion tried to simplify
> >> the logic in vhost_dev_elect_mem_logger(), as the QLIST_FIRST macro th=
at
> >> gets expanded to use the lh_first field for the QLIST would simply
> >> satisfy the basic need. Why extra logic to make the check ever more
> >> complex, is there any benefit by adding more fields to the vhost_dev?
> > I don't get here, the idea is to just pick one shared log which should
> > be much more simpler than what is proposed here.
> The code you showed earlier won't work as all vhost_device instance
> points to the same dev->log device...

This part I don't understand.

Thanks

>
> Regards,
> -Siwei
> >
> > Thanks
> >
> >>
> >> Thanks,
> >> -Siwei
> >>
> >>>>> And it helps to simplify the logic.
> >>>> Generally yes, but when it comes to hot path operations the performa=
nce
> >>>> consideration could override this principle. I think there's no harm=
 to
> >>>> check against logger device cached in vhost layer itself, and the
> >>>> current patch does not create a lot of complexity or performance sid=
e
> >>>> effect (actually I think the conditional should be very straightforw=
ard
> >>>> to turn into just a couple of assembly compare and branch instructio=
ns
> >>>> rather than indirection through another jmp call).
> >>> Thanks
> >>>
> >>>> -Siwei
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>> -Siwei
> >>>>>>> ?
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
>


