Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8BBC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvKk-0008Sv-UE; Fri, 02 Aug 2024 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZvKj-0008LJ-3o
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZvKg-0003w6-Hg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722616845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ry6wCSh/Co7KiFNuWJObLspvr5yfVahyZDCoBi1HSEA=;
 b=E8GevpcRGdUpn6OERKmSTqAh279eOGufjpaNoHtarAROl2vXJC+xxwVgPfOZTYorR7pp8G
 /uwBSdB0gCIqBNDV/E91dGcEHvfxU79TLZZvxw7Lzwbv6bfocVodAKI+fDKuu67kghZ75H
 /Nj9UVToO2XAW6OG3ObWCl+b8xTYW0s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Ujy_4fW_Orm_vJgsfxf17Q-1; Fri, 02 Aug 2024 12:40:43 -0400
X-MC-Unique: Ujy_4fW_Orm_vJgsfxf17Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef2018bb2dso79586791fa.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616842; x=1723221642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry6wCSh/Co7KiFNuWJObLspvr5yfVahyZDCoBi1HSEA=;
 b=Jah/2cQVppyWb+DPCk1/ZdK4WZPApcJSl5MEC5MiBgsAl5rdmYhoipOl0i81QhfCad
 9p3k2ejXejds6PrVwx0yZdpSfOAd4AhKJmh/lFdagXLetpP0J3U3c+Kj03spqwh4e1NI
 vUmzO0oJion63OGitlxSn7aDUVlok13UaAirxUI6/6T5dKGuya6s7eNzyxpvWW5MCogt
 H0Fqjxh6Azx9agsHRnQX2Gpw42mNTUI6dnxBRFRS06h8MloMQ5WQc53RjwY+bxu7acNY
 pXjFky/em+t2Ozgr0bmH2pTOWdKNWR2iXF0WUwVdWJLVIHx52XFEnYIAaGPLK6pWrzzR
 2QQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoBcj5apAH2ceZ6VmHw5QvzUlvvAGtxD/4Hoo1vMRfZTyy7hCFMojgkTE35bPw0xYDCV6qhKIv7vwVjNSBoSpZAPhVYPY=
X-Gm-Message-State: AOJu0YxKsX16egOghjqng8RYQ8U892AvGupkrePg1CzsxTHOfVK97Z0c
 8+nUczMZUpaIjowOGAFezxwMEb3kr8LneIM/jTQtcQcxeovBkOsG0gAmCKpA73il1/6UPZqZFUV
 W2OVfrsJLWp+UyBVbj53k+UMOppoAiDA097liCXNcfj6tp3DpdAnotUFunA5LaSU=
X-Received: by 2002:a2e:87ce:0:b0:2ec:89b8:3d2f with SMTP id
 38308e7fff4ca-2f15aa87851mr30338231fa.19.1722616841767; 
 Fri, 02 Aug 2024 09:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD/r9hpxL1VDCpM7UJbeCae1B2I8YvLCNehmjTO31kcekQcCkkbJYsMozPCrjwxpXkbzBmKw==
X-Received: by 2002:a2e:87ce:0:b0:2ec:89b8:3d2f with SMTP id
 38308e7fff4ca-2f15aa87851mr30337821fa.19.1722616840792; 
 Fri, 02 Aug 2024 09:40:40 -0700 (PDT)
Received: from redhat.com ([31.187.78.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb63f16sm99174985e9.33.2024.08.02.09.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:40:39 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:40:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240802123127-mutt-send-email-mst@kernel.org>
References: <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq0IrhV-DgStpJtk@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 02, 2024 at 12:26:22PM -0400, Peter Xu wrote:
> And that's why I was thinking (where I totally agree with you on this) that
> whether we should settle a short term plan first to be on the safe side
> that we start with migration always being compatible, then we figure the
> other approach.


We have two big issues around migration compatibility we never solved:

- some guest visible behaviour depends on a package outside of qemu:
  as that package can change, so can qemu behaviour

- sometimes we change guest visible behaviour and only
  discover this after the release: fixing that breaks
  migration to one version, not fixing breaks migration to another


These, to me, look similar enough that I feel we should look
at them together from QAPI POV.

Both issues sometimes can have work-arounds, enabling these
would be nice.
Also, both issues have a clean solution, which can come in
two flavors:
1. basic: detecting incompatibility
and not starting qemu on destination (or failing migration,
possibly early, which I consider a less clean solution).
2. advanced: ability to go from a set of configurations to
a flag making them compatible.


-- 
MST


