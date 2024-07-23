Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4777DC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 00:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3Bm-00066n-PK; Mon, 22 Jul 2024 20:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sW3Bk-00063k-6q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sW3Bh-00084O-E6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721693727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LsnU3HfXMnpZU1qCXgFM1zlQJvg45ejDgk0Ol1zkG7M=;
 b=J9ABE6f/0W1LSkUSbG6aDU8cq4j1FpUpSX1+csjcOffODNsc0IGaOen13Kp/yBtTcRlPmy
 RTnsUvW+ogpZLGi7Cd8ARg2w6i1c6PgTzp8KcZLOQIxfsE8sEeNtQ6SKoVsfl3CchoyXg1
 Ck1WjggZ7P73TlsqbiNltUsgoRvm5sk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-dquOrR3fPlyZYM57my-s-A-1; Mon, 22 Jul 2024 20:15:25 -0400
X-MC-Unique: dquOrR3fPlyZYM57my-s-A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427df7b6879so16592915e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 17:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721693724; x=1722298524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsnU3HfXMnpZU1qCXgFM1zlQJvg45ejDgk0Ol1zkG7M=;
 b=jkd0Ma2Y/zIX38vaPQKRmglYpHTtmtnzhSr6NEU9rbzRQE7zKntDapsVNsdGz/xYBF
 MU8DLLvYD3TUvLs6/uqx26iBlfPdFay4Czxs/5nALi9zhdkAHpw2jQvApF5hXxhSyWCO
 5fqhrGSUwYsujaBjWECvDRg6KskBBSq5iLw15o9D4mz1XPsEsVZVfTKmCeorygPKdzVT
 6lzbgXGbr7OUZoOE3+nlIKutTfmrqeNnTQv45JAaSvNB/G8tbHrMJjawm6qnrMkWHfDs
 Xgj4VL7kqW63D/Ab79FXBTpMmI8I6r7Ziyp0TwDhKBtEbjQf5+V3Gha6XMgdDNt0v0qR
 eAJg==
X-Gm-Message-State: AOJu0YwkhW+dTAUpJxIbY3ikGMfvoPQmMKmmdkyxNEPg0fdyB9aEI7mD
 iTbLujTlPHy3HGXPlfFBVSRjRjz9ECXqNZnK1bwcJey+ZDNyDBtP8e0JE8AnnB5l0CtfrDPpKWn
 FtA54Y0BGwV27neaD6MGEae2oRH8c7ue66fmbQ+y/qYBRXX6+TZ3o
X-Received: by 2002:a05:600c:a41:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-427e373fcaemr43795195e9.18.1721693724363; 
 Mon, 22 Jul 2024 17:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvDONw8SVo8q10EcwPZB3HM+8yFyubnH0/tqVdmyc821v1z6cgUdHQ7BrDiTeBRz3+Z+T/xg==
X-Received: by 2002:a05:600c:a41:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-427e373fcaemr43794945e9.18.1721693723423; 
 Mon, 22 Jul 2024 17:15:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5415:9d1e:913c:6f61:614e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e436sm173212335e9.33.2024.07.22.17.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 17:15:22 -0700 (PDT)
Date: Mon, 22 Jul 2024 20:15:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yui Washizu <yui.washidu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PULL 29/63] hw/pci: Do not add ROM BAR for SR-IOV VF
Message-ID: <20240722201505-mutt-send-email-mst@kernel.org>
References: <cover.1721607331.git.mst@redhat.com>
 <54f3a29f08900bef796953971d2482d64ddf9969.1721607331.git.mst@redhat.com>
 <943d2a14-f4cb-4169-a7ac-bbe38a0e9abd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943d2a14-f4cb-4169-a7ac-bbe38a0e9abd@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 11:21:13PM +0900, Akihiko Odaki wrote:
> On 2024/07/22 9:17, Michael S. Tsirkin wrote:
> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > A SR-IOV VF cannot have a ROM BAR.
> > 
> > Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Message-Id: <20240715-sriov-v5-1-3f5539093ffc@daynix.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/pci/pci.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 4c7be52951..bd956637bc 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
> >           return;
> >       }
> > +    if (pci_is_vf(pdev)) {
> > +        if (pdev->rom_bar == ON_OFF_AUTO_ON) {
> 
> This requires:
> https://lore.kernel.org/r/20240714-rombar-v2-0-af1504ef55de@daynix.com
> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> 
> However it does not seem included in this pull request.
> 
> Regards,
> Akihiko Odaki


good point, dropped for now.


