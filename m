Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C8BC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKGI-0002aW-Rz; Tue, 06 Aug 2024 09:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sbKGB-00029P-A2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sbKG9-0005pr-9s
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722950991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQTn1f324B+2iDzw8vvDbOyeB4ZOqhLUl3h8ZE/2v7c=;
 b=GCMr84cSXMtKyG36KJhTAq3ZzNKkyxru1CxWxGZhf/dQs4zmKDRU5Hms9We2anoxIbyklM
 n2twoeD1RjrGDhjk5u8pXWX/1Q0y6y1iI4kCIaOqEU4yIBasSZuR5Mkr2+jo4FB9nlOW2g
 1m/iqII7RS1E3S9os2EkZnKS4Ac6rKc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-CMAXBBRzN_KtkI2T-9VDSg-1; Tue, 06 Aug 2024 09:29:50 -0400
X-MC-Unique: CMAXBBRzN_KtkI2T-9VDSg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428207daff2so4839675e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 06:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950989; x=1723555789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQTn1f324B+2iDzw8vvDbOyeB4ZOqhLUl3h8ZE/2v7c=;
 b=DGBd/6CKUYWfgYntNNVEpHBqqat+zKCRiv47tyoCIMsj+530t3axcv5UWZSLNDnu3m
 2B1qE/E0KDXlmLNTm6g4Z/igfzcIHMtCxvpGNEh0Y9kTOq1FAzgFkdphsmzavs5nurmN
 Y3lKw1pa2mHTLpNTogoZJPFuq1smNKaC4HK37ZEePlpmWUxqtlUVaFhTtrtRlYxcZCYo
 rDNDE9icCM2hacyrwPd5Ba2f5cecpe/XuJOnprhKUrskBkUgN6nJfFvZfDBv67DonMHa
 ElGqsN5Rl1ZYX1VpdIeYmksXRQ890aBs4RcYSF6VqIVTSOhOZLcoOPCkzlwesPt+UTnS
 k4pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEJQAx7uaE/JRNXQU9bUOzgUoIyL4avNAuWtze6mnvdmBXr5GaBRdH+eLbUDC1vhe7Udca2G+LBnba/nI7rphrg5rgQe8=
X-Gm-Message-State: AOJu0YycspjNAFmYLmfVLVT0BKdPQ8A6+FibSFvFF69nT092z7sM2PHg
 Mp6yFFJsNlG6VH1VSusVE8xbpDRbAW7dCGTq+14c/xR43HX7HwvkcDjdqcK2vtGvdTur+VKglP2
 Q7pDAb/LSAQnmLETzPPRKC6+3IP/Ztkils7qQ3fhUbuFUiYZjabWj
X-Received: by 2002:a5d:5d82:0:b0:36b:bd75:ed72 with SMTP id
 ffacd0b85a97d-36bbd75ef49mr8885998f8f.2.1722950988739; 
 Tue, 06 Aug 2024 06:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWXJM42MC0J/hUUWcFhB2cl9HUrET++0xlmrXQPvNwLgSoKXMjjFsuZMLgbElZQhSELK1PpA==
X-Received: by 2002:a5d:5d82:0:b0:36b:bd75:ed72 with SMTP id
 ffacd0b85a97d-36bbd75ef49mr8885939f8f.2.1722950987806; 
 Tue, 06 Aug 2024 06:29:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c9eb:d9d4:606a:87dc:59c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dcefsm13304870f8f.11.2024.08.06.06.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:29:47 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240806092822-mutt-send-email-mst@kernel.org>
References: <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
> On 2024/08/05 19:08, Michael S. Tsirkin wrote:
> > On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
> > > If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
> > > and restart). QEMU can also migrate across hosts if the user ensures they
> > > are on the same platform.
> > 
> > What is so special about checkpoint/restart? I guess we hope that
> > downgrades are uncommon, but they are possible...
> 
> Downgrades will not work with cross-migrate=off. Users who want downgrades
> should use cross-migrate=on.

We also don't know that upgrades do not disable a feature:
can happen if e.g. there's a serious bug in the feature.
Basically, this makes the feature too fragile, in my opinion.

-- 
MST


