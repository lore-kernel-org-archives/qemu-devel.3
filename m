Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E25C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6U3x-0006mG-Uf; Tue, 15 Sep 2026 10:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6U3u-0006lk-0F
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6U3r-0000Go-5S
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789482181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSLNtL5Gcxee2dDdMNJ+PxLjdPZQHdAONByRxusHV4o=;
 b=bZYpv+KcoNqCqrkDGP2mT3gIONb/pqkiRunWOKLlYuIjexqzPiAjLHtBdM2iqTdEOyziOO
 kUBBDp/dxOCg6yHzGrwrXrlrRyZuC5MFF1D9jr+jB2gnB5G0hKTpM5ISve/I9LkpPkUnMP
 3ko181N6ZSFw6TjJzM1Hpivbr8IMgQw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-NidNwxNDM-67THb_1EhWCA-1; Tue, 15 Sep 2026 10:23:00 -0400
X-MC-Unique: NidNwxNDM-67THb_1EhWCA-1
X-Mimecast-MFC-AGG-ID: NidNwxNDM-67THb_1EhWCA_1789482179
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6c17ec1dso35721685e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789482179; x=1790086979; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YSLNtL5Gcxee2dDdMNJ+PxLjdPZQHdAONByRxusHV4o=;
 b=ISnbVi1yrMirLjEAu5YqT3OYH+NQ2ZoXFVIWW+usLKk+0a+eNTL/wBZ1xJudgeyv4O
 6S2Z0YyFvpJK8sbzWrOrge5MtJ0fO2sjhaGgzLk8H315h09kXnhI6Tmih0PJ+KMAFW+U
 rZq/1tb3YtW/Q3qw7fOVhoXWOkK8P1+hNusMu4a/++lFgMf9zR+saFEgxJHhxWtU/7sE
 xQkDbf0ehOApMi6kMq7TLzc4D0trPF6EaB8g8cA/No2CcY8MwPUD+cfiKq1mWIaIeOd5
 tL7jyt0G/dqcEzIniFMJClZwhV/oBx3xUnutvaF+87ZBcja93VNiqJz+eUVQWK5oAsXF
 D+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482179; x=1790086979;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YSLNtL5Gcxee2dDdMNJ+PxLjdPZQHdAONByRxusHV4o=;
 b=tyznCcWossjBobLSmeYM1o6qi58lZHjSBJ0rHbDT0p1OYG/lSvxDPRm/Mfr7+Q4f0v
 gLYcU3i0hEdi+xe0IBf2v9kUXaVIyw6rYK9jCgKTJ20+00xiGCitAToW7YxmVFswwv6B
 Sd1P2m+fTKfYbT02t7OuFnmp2n3Zlr9tz6ZB2LlAksbwEZFQ8EjPRHqvu/2nIMKAk+4s
 rSF1O/azbEAsj1yTMp0hSctt4mVqjcrVJcnohiruxCm2Uf//2+fkj4pRXkwrDFDVTSrH
 CrSPt+Kmdx9BuQqXmJ0Yn2UOP3MvQNNpipVDBFjuRd1glWTZXJtBlEXhXLqw8nlynNp4
 tEQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmhDay4gtN8Ewv5RhMK5WS0CeckoOzOxN1UBT9kJL3QIv8zM7Zj8TLA1taKQYuHEG4pXIrw9x8XZAC@nongnu.org
X-Gm-Message-State: AFuF++kujxFcgNeNX1hBFJxE38tBpcOmAIvpoe24XZGTLBFQxiqV6VD/
 D8iDQS+2POMe+20jpnG1b7/cMNMoOMBAstM3jLYBfTOztFk0b4JmWSSwTHGred/L+uWgGrtDhGZ
 dBuK/6ZuW6xsZpV4Ehq3krCupT44MMFgcPD+fHkq1SsyBG+ov2JwNeXg4
X-Gm-Gg: AYBFou2InsFbMF/mCtaYRS+Rn51DCvaNWeb3qm/bsddfaPjM74Yr4JlJEqjvHr5r0t6
 v6pZrXkbC/L1bDw4A0CItVIeETtguTMDxMsm3EPbJArSgbPDZGjs9Zs3dfzpBGwgtn0ywoQtsrp
 4BxzY5l/Nu0l3zi4nIyfzA/1rb1RwZQds6mv6WRYnAlK+cgosvILr44xNaMrblEAE5CvYMPeFrr
 qytwLkFeIJxi1Q17zadWrq8BFOF28osRML8FROH+LyaHZbUum198F/kWvons/FUfarDHEKMujkz
 p7W1K8FHesp2BzP5Zw3KeQMvZDAv4MOmZHklo4d18vq5Y/el2SscCxgbLy7m9eQqAyKhioYTsjt
 00diYeSCQRAZP6812IilVGOA=
X-Received: by 2002:a05:600c:4f84:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49e83a46e98mr119995e9.16.1789482178724; 
 Tue, 15 Sep 2026 07:22:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4f84:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49e83a46e98mr118915e9.16.1789482178212; 
 Tue, 15 Sep 2026 07:22:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d6a9d1dsm78981575e9.10.2026.09.15.07.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 07:22:57 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:22:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Vrabel <david.vrabel@nutanix.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
Message-ID: <20260915102221-mutt-send-email-mst@kernel.org>
References: <20260915072507.1230187-1-clg@redhat.com>
 <20260915060015-mutt-send-email-mst@kernel.org>
 <81c899d9-a9fb-4eb2-ad85-7dde2f626646@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81c899d9-a9fb-4eb2-ad85-7dde2f626646@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 15, 2026 at 12:17:31PM +0100, David Vrabel wrote:
> On 15/09/2026 11:01, Michael S. Tsirkin wrote:
> > 
> > On Tue, Sep 15, 2026 at 09:25:05AM +0200, Cédric Le Goater wrote:
> > > Hello,
> > > 
> > > The xio3130-downstream and x3130-upstream devices lacks x-speed and
> > > x-width device properties, making it impossible to configure PCIe link
> > > speed/width when building PIX switch topologies for GPU/NIC passthrough.
> > > 
> > > Fix that and preserve migration compatibility with a 2.5GT/s x1 default.
> > > 
> > > Thanks,
> > > 
> > > C.
> > 
> > Given they are clearly intended for users, time to rename to width/speed
> > everywhere?
> 
> A more comprehensive series (hw/pci-bridge: Configurable apparent bandwidth
> for the PCIe topology) is here:
> 
> https://patchew.org/QEMU/20260908155223.164787-1-david.vrabel@nutanix.com/
> 
> This adds new upstream and switch port devices with configurable speed/width
> and renames the options so they are non-experimental (but do not the open
> question about the usability of the speed option with the need to set 2.5
> GT/s as the string "2_5").
> 
> I did consider adding options to the XIO3130 device but since the real
> hardware is Gen 1 only and does not support speeds/widths other 2.5GT/s/1x I
> didn't consider it appropriate to claim these emulated ports are more
> capable than the real hardware.
> 
> David

Right that makes more sense to me.  Cédric what do you think?

-- 
MST


