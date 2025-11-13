Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6983CD8CB0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJbPz-00012T-KV; Thu, 13 Nov 2025 12:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vJbPX-0000k2-8z
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vJbPV-0003Tr-3p
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763056023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yx4lI+HzTqGoHdMGBNFgbxj+7xYX+6iGzakKO4rhLQ=;
 b=hi7LVamB0JYp4o9tXHibIP8B5rKSNwcw+muvtxreVU5Ce2/0a+9rzwtmDN2UaF970d2Omy
 HUPBLJgsULOkWUeLsBPWRb3Jm1Trj5rOsjMp98MOATdHADosg7/e6Mu0uA5V/ov/3q3lEx
 JIhPO5Xl5qfHfB0m3IxhfFn1T3Wn4qA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-7fB93-AGOZ-prIF24vTdBQ-1; Thu, 13 Nov 2025 12:47:00 -0500
X-MC-Unique: 7fB93-AGOZ-prIF24vTdBQ-1
X-Mimecast-MFC-AGG-ID: 7fB93-AGOZ-prIF24vTdBQ_1763056019
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4777b59119dso13004785e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763056019; x=1763660819; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3yx4lI+HzTqGoHdMGBNFgbxj+7xYX+6iGzakKO4rhLQ=;
 b=sYIv8jUOtZPoik3v01kaoc6MkDcc0gB4It/G4ORzHVjE2zlOvfhlO4oMNBYq/WXe+S
 i8nYMij7kGh28iueMIXQYxF0X0mSuxVwyTZSiGJuwN4R8jOEv7TtIqXgBY6T+/gevaJ3
 TXiCI9gNd++34+Q+qIrMLAc5MaLFKwfLKV7TMNSbw6g9tGzOPQOWxDsrBUQtUFp0cJyD
 QponhaWZiuJjPv5SpSRRo8TX/pIF9IzMsX2f6JajMSI8+ouJtQRQV5MOev/0x688AD8j
 RPcu8BrIz9b/fJLSLyhWSsPjekigumWa9m/pvuMUrjHEFcLZ4lOw3xCa+EhkDSOBxcxs
 vzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763056019; x=1763660819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yx4lI+HzTqGoHdMGBNFgbxj+7xYX+6iGzakKO4rhLQ=;
 b=UC12gAd9fO780R4pDqiSxXWMJC3C3+nSPsAbAoqyl+nc151O6V3aqBbSc1pI2GMCf+
 hmPMW+LYVVOtcuebpOiC/2PuDmZQWOfAOAi862sgFszV0oMSLRS4ioTmVu41LDwl7Z57
 pZSPiFALuuSEJibLlCZagYx7Ef8fdkuZe7G+8TaWIJRTLj9EuqmohFB3GPv+kI7zE3kK
 D3kW3D9lTpAMSSBTOaL9OoqlyXv9IxDttdcOqfvT6NZnsQAmjWq94ATzWxG5muvrUccD
 bfJ//nXQES3fYyoojshcloKsivWFiHj+EdP4xi3BcNH7RpDu/HAS2V+PN+OYrxRAOtwR
 YozQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwu+0i8K9nIDNCRXmDIPtl/fSVeEdPeNX+fRC3W8qi9bK2xy7897rW8nLa73KTMuaays71b2UHSRuE@nongnu.org
X-Gm-Message-State: AOJu0YxBq1IqCzdYmS/5v3Jbf1E+VX0YZ9MqNtqrSL6xYBUwH2lTgdjp
 GQXMlUA/Y6ZY6xuA3BU3qwMBofSQnSwam3hNGVmjrzDFKOl3vMNLIkC1Xa/XDl8Wvt4bmacmpCO
 q4ClkfWcHb2i7GqmfspxO4kAJJ5tvy/3FibwaOdfgtWB1rkcqErkjUYKL
X-Gm-Gg: ASbGncupE5oj8OzZ1l7+j6qdfwsRh7m3ytjX4CbdEljPy9clAedNZ3zq08NLw9mR7EX
 6cxsn8G1hI4daXn41sNCdXYCs2sxWGad1WDSApMrGldl81NqKNQupuDSXRJ+3z9LDSQNmVyB//B
 0CLialQgGkbRigrKoHgNZ/+WqzCFT24UF/3FePKRFENXlYVDDVfUcBuyj5bxrYE81OHIXPEiuEi
 52Q9lpSBJQD9ju3CabklrfyVsnpRMFHnIznB+KK8dys/DfjV1Ezc8OOwQfO2PEYIxoJ1lkuvsBi
 7NbLxuZHuvs4edSBBuHICykPVGmu+mqDFKTOeLwKVV3lokOdMSPMDsvkhMatKOmFW0GETm0xfeZ
 Jten4XREjrIDRHdwBdE0=
X-Received: by 2002:a05:600c:35c8:b0:477:79cf:89cd with SMTP id
 5b1f17b1804b1-4778fe573b0mr4066955e9.9.1763056018654; 
 Thu, 13 Nov 2025 09:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKZPkFwoGVifWs5S8Aunnec/1ruQ56cPqXYC8912ea79cvbSukSF3EZaqwwREwWqlQQaGb7Q==
X-Received: by 2002:a05:600c:35c8:b0:477:79cf:89cd with SMTP id
 5b1f17b1804b1-4778fe573b0mr4066655e9.9.1763056018193; 
 Thu, 13 Nov 2025 09:46:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787ea3b56sm99895615e9.16.2025.11.13.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:46:57 -0800 (PST)
Date: Thu, 13 Nov 2025 12:46:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251113124207-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYRhg7lKDCBUIrf@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 12:12:38PM -0500, Peter Xu wrote:
> On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > > > We used to clear features silently in virtio_net_get_features() even
> > > > > if it is required. This complicates the live migration compatibility
> > > > > as the management layer may think the feature is enabled but in fact
> > > > > not.
> > > > > 
> > > > > Let's add a strict feature check to make sure if there's a mismatch
> > > > > between the required feature and peer, fail the get_features()
> > > > > immediately instead of waiting until the migration to fail. This
> > > > > offload the migration compatibility completely to the management
> > > > > layer.
> > > > > 
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > 
> > > > This is not really useful - how do users know how to tweak their
> > > > command lines?
> > > > We discussed this many times.
> > > > To try and solve this you need a tool that will tell you how to start
> > > > VM on X to make it migrateable to Y or Z.
> > > > 
> > > > 
> > > > More importantly,
> > > > migration is a niche thing and breaking booting perfectly good VMs 
> > > > just for that seems wrong.
> > > 
> > > IMHO Jason's proposal is useful in that it now provides a way to provide
> > > ABI stablility but allows auto-ON to exist.
> > > 
> > > If we think migration is optional, we could add a migration blocker where
> > > strict check flag is set to OFF, as I mentioned in the email reply to Dan.
> > > As that implies the VM ABI is not guaranteed.
> > > 
> > > Thanks,
> > 
> > 
> > All you have to do is avoid changing the kernel and ABI is stable.
> > Downstreams already do this.
> 
> But the whole point of migration is allowing VMs to move between hosts..
> hence AFAIU kernel can change.
> 
> Downstream will still have problem if some network features will be
> optionally supported in some of the RHEL-N branches, because machine types
> are defined the same in any RHEL-N, so IIUC it's also possible a VM booting
> on a latest RHEL-X.Y qemu/kernel hit issues migrating back to an older
> RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have the network
> feature available..
> 
> It's also not good IMHO to only fix downstream but having upstream face
> such problems, even if there's a downstream fix...
> 
> This thread was revived only because Jinpu hit similar issues.  IMHO we
> should still try to provide a generic solution upstream for everyone.
> 
> Thanks,
> 
> -- 
> Peter Xu

failing to start a perfectly good qemu which used to work
because you changed kernels is better than failing to migrate how?



graceful downgrade with old kernels is the basics of good userspace
behaviour and has been for decades.


sure, let's work on a solution, just erroring out is more about blaming
the user. what is the user supposed to do when qemu fails to start?


first, formulate what exactly do you want to enable.



for example, you have a set of boxes and you want a set of flags
to supply to guarantee qemu can migrate between them. is that it?



-- 
MST


