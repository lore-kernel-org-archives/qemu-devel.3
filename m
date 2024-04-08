Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD2EC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 22:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtxHD-0006tg-Be; Mon, 08 Apr 2024 18:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtxHB-0006tE-Dw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 18:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtxH9-0005pJ-Im
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 18:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712614538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFxnw+9m2EZT+0BWnX18QlSqSThNDI0QB59hntizCD0=;
 b=bN6o9powjLAXK8GheM8TfbZegWORUOKYYH55/N1HEsjiHHplxpA/nBSLB+DAoMa8dsA/uV
 eEL+Qy0XK0Agi22O4KuLiaZyXU1qWLpC90Rl9BOmRIm9wLesQyIi7x0DY/6I+kA2M6pMx5
 nxwLZd8aSAOqBTot/kfvTY39oUa7YKk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-X8ac3nKdPBGm1A4dKfgSyg-1; Mon, 08 Apr 2024 18:15:36 -0400
X-MC-Unique: X8ac3nKdPBGm1A4dKfgSyg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56e3f7ee50aso1661461a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 15:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712614535; x=1713219335;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yFxnw+9m2EZT+0BWnX18QlSqSThNDI0QB59hntizCD0=;
 b=vKqCNRawbFndpP/lgH5xnX9S+nVUAcho7Ib4diqDbdfhQafMtyPH9awTw2Mv1fWM6E
 +tcMj9q+UgLS3eECoq813/X6QRs8XxfloCsic9ycIRbz4v1Lr/FGNqb+ql/jK5ijWp2u
 +bUsNd+TB99HI0WtNt+ZbYUg8e3zcC+2P3pRnaYOKmv0arCbY5AI+lWC0GaVx6vKuqyq
 Ecyuc4VX4aK7mHeHLO4xF9YLE1u9/gVehNMcSnQAcBSd/UAJhVcz9MOGVn+7paCkPkL1
 gQCBvJU/0Ved1yuUTKNLeH1c2PLFkrr1O64n16D8ZPafKMll6i1kjIr1Ptm8K3HmuP74
 wSVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjZ0U5ebQUikirbG/fWqc7cFmiKglSGKQK+yP0BFqEhJyf4P4bDA2TdjhxH30/JMgMZojkQfgsz5N5fC1Dk+F/KUuhRkU=
X-Gm-Message-State: AOJu0YxGmAsnlBFyH9NCb+xmbOo/U0iTmRxvOs9vgy1JU8TpzuLE8G2X
 /IME6CvFLGbH0Ig+AEl7f8nSyLTMussRDRQbUq/yLhMR0B9xLiyPbSgrMcejVx54PWZwovEvMbN
 To9rkpoAVvPAEUIG/h9OdjLfmW+NuRnqmA5xwGOjddY07zK2h+RAg
X-Received: by 2002:a17:906:2792:b0:a51:d8a2:7a35 with SMTP id
 j18-20020a170906279200b00a51d8a27a35mr2352770ejc.37.1712614534999; 
 Mon, 08 Apr 2024 15:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX+TB5MyePHyD6mKv/alKM+HqeYBK1z3tfKeVKH5+CCAmcg4dpRf2hwZthu6Av9FAE8BgOIg==
X-Received: by 2002:a17:906:2792:b0:a51:d8a2:7a35 with SMTP id
 j18-20020a170906279200b00a51d8a27a35mr2352760ejc.37.1712614534561; 
 Mon, 08 Apr 2024 15:15:34 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 my46-20020a1709065a6e00b00a4735e440e1sm4944687ejc.97.2024.04.08.15.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 15:15:32 -0700 (PDT)
Date: Mon, 8 Apr 2024 18:15:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] Revert "hw/virtio: Add support for VDPA network
 simulation devices"
Message-ID: <20240408181452-mutt-send-email-mst@kernel.org>
References: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
 <CAFEAcA9_mLQ=jWNEHBVLJKHST4X=QVdpgPCTh1mRSSiea7ruzw@mail.gmail.com>
 <20240408061752-mutt-send-email-mst@kernel.org>
 <CABgObfbfi-LiV0_BfK78-53kfTg+z3zX3sfBDAJqr5GxOWiOMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbfi-LiV0_BfK78-53kfTg+z3zX3sfBDAJqr5GxOWiOMA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 08, 2024 at 10:11:18PM +0200, Paolo Bonzini wrote:
> 
> 
> Il lun 8 apr 2024, 12:18 Michael S. Tsirkin <mst@redhat.com> ha scritto:
> 
>     On Mon, Apr 08, 2024 at 10:51:57AM +0100, Peter Maydell wrote:
>     > On Mon, 8 Apr 2024 at 10:48, Michael S. Tsirkin <mst@redhat.com> wrote:
>     > >
>     > > This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.
>     > >
>     > > The patch adds non-upstream code in
>     > > include/standard-headers/linux/virtio_pci.h
>     > > which would make maintainance harder.
>     > >
>     > > Revert for now.
> 
> 
> As long as it is part of the spec, why not just move the problematic parts to a
> QEMU specific header? As far as I understand the kernel is never going to
> consume these constants anyway. 
> 
> Paolo 

I expect the contributor to do fixups like this though, not myself.

> 
>     > > Suggested-by: Jason Wang <jasowang@redhat.com>
>     > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>     >
>     > Are you intending to target this revert for 9.0 ?
>     >
>     > -- PMM
> 
>     Yes.
> 
> 


