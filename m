Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEFC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApGZ-0002CL-6k; Fri, 02 May 2025 08:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uApGV-00024w-8C
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uApGT-0003lw-3y
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746187992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1Qk+0sq5qvpEKSkvU6LqVzfbMFI8YpqJSQGfD0MTDg=;
 b=fIqxhep1RIWyTwz0mPJ/62kxqR7t4SThiXMVmpYNrSbOCm/aIK/60Y+nSX/oeCuUhfCLYL
 cLp0ZLE4XKGAtJ5PFzLldxp0XoocUqSoHVdkKf4PT7RLyVhE3JePCdmP2GbmRUn4zs3bE2
 oa4VMTKU7bgXo1XXIQ10PfnKcUtghHo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-UiBkM6XAOmSJGPLd2_6irw-1; Fri, 02 May 2025 08:13:11 -0400
X-MC-Unique: UiBkM6XAOmSJGPLd2_6irw-1
X-Mimecast-MFC-AGG-ID: UiBkM6XAOmSJGPLd2_6irw_1746187990
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3fab1478893so538951b6e.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746187990; x=1746792790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1Qk+0sq5qvpEKSkvU6LqVzfbMFI8YpqJSQGfD0MTDg=;
 b=SQ+xH4uwCh6xSrYsqMVOoVUP4Sd/2Di7qxbVLXPxC2rgcWR5O3/sAiVvtJEdTs5KJu
 r/qBUuy4PF/+RFEDg2ycZykfc9q8uHprLo2wdlrzvKRcBMnEUnGOlogYMIbARvk/PFes
 R+o4dQhzCAqjLD7wj/LsgxoRduWQwGhZTPooIhZrx1TUDZfTda0/+tvxLUIH0RdQHVIn
 Tl8VvOhYnMSRGAe9DcpPmT34ykSaz10Pf6jAFo63CnIiejvwOUPorKl6jsvo73A5131t
 BX25vMlwlCcId1TKdkQmyd7USSjA/9oFq4UEMSpjg/zr4r4xGfiquBm+90VSNMdeDBtU
 3j6Q==
X-Gm-Message-State: AOJu0YxPKKS0cRg8+oPdVD1mAOnfGhqqKi3dNMKBJbgw3s+v/BNnxCSA
 PnRRiFzVhkMGIJBEC469aDGnQgoP75hlRaLQiBJEKQHzfdDY6iAgEg0pzcQB1LYdri+t3U8qfhm
 KQ3HMcnAwPOmj28txnZiRG2l4vrhSD2P1oBhKZ6Z5ImW2Dw2anp81Z1wpPF9gkEhVmgVdjhPrZR
 AALArev5GYNiZ3WXJ8eYH/lfBl1no=
X-Gm-Gg: ASbGncuBpe/gHRRhmOGrRbNv/8mAadv+cDapMtEtW2vpY3FjniG/FiYJqex2eIzwY8M
 9vY3IiiTdVNfwbWRDIpnMKh3hKFViRqP5dB3NIIeIRaI5asePefjEQR9pmMvdSV0DoSeHkHRCJB
 uauXiUQ5bcgydym6kfnrqE5SXValo=
X-Received: by 2002:a05:6871:7402:b0:2d5:230f:b34a with SMTP id
 586e51a60fabf-2dab2fe9e33mr1161773fac.9.1746187990345; 
 Fri, 02 May 2025 05:13:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEX8tmFaG7J7P+e4EYyBJf8Oi8Qk5h/S9SDnqVjihwxovvoLCT3yDLn46V6aNuPsgoSkItteXvpDVUqTXw56M=
X-Received: by 2002:a05:6871:7402:b0:2d5:230f:b34a with SMTP id
 586e51a60fabf-2dab2fe9e33mr1161755fac.9.1746187989938; Fri, 02 May 2025
 05:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250411113036.786841-1-afaria@redhat.com>
 <20250411113036.786841-3-afaria@redhat.com>
 <aAuktDpM_FIZhXOH@redhat.com>
In-Reply-To: <aAuktDpM_FIZhXOH@redhat.com>
From: Alberto Faria <afaria@redhat.com>
Date: Fri, 2 May 2025 13:12:30 +0100
X-Gm-Features: ATxdqUFvT-ImRHHG9PbWhO-mHEgC4b6SJBeZHIbHljp6MRF64HXxTcLvXH9OBnE
Message-ID: <CAELaAXyKfOhK=mfV-JjcsvT59xG8dUpJiKRfgWpX1=p8S4+Zmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scsi-disk: Advertise FUA support by default
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 25, 2025 at 4:05=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 11.04.2025 um 13:30 hat Alberto Faria geschrieben:
> > Allow the guest to submit FUA requests directly, instead of forcing it
> > to emulate them using a regular flush.
> >
> > Signed-off-by: Alberto Faria <afaria@redhat.com>
> > ---
> >  hw/core/machine.c   | 1 +
> >  hw/scsi/scsi-disk.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 63c6ef93d2..e4e6474a4e 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -46,6 +46,7 @@ GlobalProperty hw_compat_9_2[] =3D {
> >      { "migration", "multifd-clean-tls-termination", "false" },
> >      { "migration", "send-switchover-start", "off"},
> >      { "vfio-pci", "x-migration-multifd-transfer", "off" },
> > +    { "scsi-disk", "dpofua", "off" },
> >  };
> >  const size_t hw_compat_9_2_len =3D G_N_ELEMENTS(hw_compat_9_2);
>
> This needs to go to hw_compat_10_0 now.
>
> And shouldn't it be "scsi-hd" rather than "scsi-disk"? Did you test that
> the property is disabled when you use an older machine type?

Sorry about that, fixed in v3.

> Kevin
>


