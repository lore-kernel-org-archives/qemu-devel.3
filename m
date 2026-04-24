Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58972FE520D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGEpB-0000qi-8Y; Fri, 24 Apr 2026 07:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGEp9-0000qC-NU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGEp8-0006Gy-9W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777030553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zYlyk/FU8jAvtu3n9b+43GgXp9tSPuBcVYejaiINyT8=;
 b=iNM93zjaT/hMVidW8cA9UYcL71dfSPZN5GeBC+pld8S0Q/7QyHn64xc3zJ2CU3alEKFf+I
 I9jgnvaVMyylpeKYcs4SNg4IF0l2x5ZEYtJHmUgFiR4opLlYZ8X22QH9nnjyottPjJEISM
 FaJNJNHrgHaOk83et+zkJIuxQAZYOss=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-L7cZg6NXM-CfpSq8xazS2Q-1; Fri, 24 Apr 2026 07:35:51 -0400
X-MC-Unique: L7cZg6NXM-CfpSq8xazS2Q-1
X-Mimecast-MFC-AGG-ID: L7cZg6NXM-CfpSq8xazS2Q_1777030551
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d5b5d607d1so1519042085a.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777030551; x=1777635351; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zYlyk/FU8jAvtu3n9b+43GgXp9tSPuBcVYejaiINyT8=;
 b=TAAmKCsg+lZ3UBExBnpYg+dFT9MzLz5lWJ+a/RSLflJlKHjnZMHR9Nfo3L1JWsqj6V
 uaV9TjIIiNtvimiTnphDez113DSSsTnBzEOw3gR7hieWZxgfdF4gTrUtN2/3vae1IPT5
 mVcgi/xLmqASlu2uGkV4919wh7YaXuCWZnJSTqaOyolxDfGYlnp29syJWydkI4qD77rp
 7UTEgyEwgGnI4XXqHDzkqUBOu3UjQCIMTn/HcETKRKu3mcn9LiHIc+7g98pDfFfSKFCt
 7JZxT+IfRefxRwTCBCeU1gClsF7JmNGJ5LE2351mb39ICie4/ww+ySPPnPk5T/zDTG10
 3NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777030551; x=1777635351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYlyk/FU8jAvtu3n9b+43GgXp9tSPuBcVYejaiINyT8=;
 b=Rn4sDYthW0UeRJ+bxRtkNtCIc1LaDpieButtzzsFWna2s9RDkgCsgtpQeG0/E8Z5sQ
 /+yTDxSiM517OAgZpMQdno0eCmVvkzmu4qwmuxwy5FtZ9AuPfcP8PGRM4Vo7XzQ7amix
 mNMQLyXQ9WE/p3KIwlLf+QLR/FEdLkDXwt5LoBGazQ7NCvD1ql/QFwbf7f5APd2sifjR
 NOkt6W6sqwCqCpkogr1deyTtQ8+G5Uwhldum01ihlDECx0BXs2BVULmSPohslOwunDxC
 86Xt1PyRhsm+P983U4KvUtXzcEV3RqR+srqN3OWYf1nMysmcI279G4OwWh7isRAjQaO4
 ay7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ85nb7RqCajAN8nccPvlPBu24MI6NrSMW/IO1HS80AHlV5qaQABHLfVTU2DN8MMt1DhqUxw76kweXJs@nongnu.org
X-Gm-Message-State: AOJu0Yy6INyzAwhfJKLRoXXHhWnweWEgROlLen4va3PnR7utGoOPpLx3
 tjkPE3WCE8ZT/buV7i77nQqTLhKvEn4tHW4ILTFgBM+Z1f11XB3kKxufa6Fc2t8DyUyFnLwaTRT
 Av0qlXX9Ppa5e1RQx3QlLjZomam02sk1tXtl9kVL8hlNNZ1MvjermyaFG
X-Gm-Gg: AeBDietjq068YDBK4IaPI3Z/U3xhcYhhzURNtU19+8nrDI/5P1EQPb5aT4JBNkmH3K/
 c9X2+CT2hGobFDoHMTmBYai7qunwl9x8wUeFMLNka/XdE6HxvvZGaIdV9CbB3bnGiW/sUCCtDbp
 UdaAaVD85Jkpx+yvad6yotsYvG6Ji+bS8ZI23i+byANaqgsCy6la0jv++cYhODfcs9vyprVJDAw
 ipNZcnMmEG5IHsMpY/t033/wVGor7Iz7kqynBFA3tJJVyIyocCyNyJfbW2l/bGuvCMTG3OGycRR
 4qfJNrP9PBs6dEqKr6ukMs03714WMZ7uPtZN4eqSXb9Ll+M5rVedzhXKkoh2NMOwNUryBHgihOR
 QugUBmfoBWXTTAF/ZMid06vX625eQAONKQ/TM4N1XxOODFmKP4y5gvzb/qg==
X-Received: by 2002:a05:620a:319c:b0:8ee:18e7:9406 with SMTP id
 af79cd13be357-8ee18f6e17amr2519719185a.29.1777030551115; 
 Fri, 24 Apr 2026 04:35:51 -0700 (PDT)
X-Received: by 2002:a05:620a:319c:b0:8ee:18e7:9406 with SMTP id
 af79cd13be357-8ee18f6e17amr2519708985a.29.1777030550418; 
 Fri, 24 Apr 2026 04:35:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5eaf1sm186134476d6.30.2026.04.24.04.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 04:35:49 -0700 (PDT)
Date: Fri, 24 Apr 2026 07:35:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "philmd@linaro.org" <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: Re: [PATCH v5 09/18] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Message-ID: <aetVkymHe-Gy3vBk@x1.local>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
 <20260424080508.53992-10-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424080508.53992-10-jamin_lin@aspeedtech.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 24, 2026 at 08:05:21AM +0000, Jamin Lin wrote:
>  hw/usb/hcd-ehci.h   | 17 +++++++----
>  hw/core/machine.c   |  5 +++-
>  hw/usb/hcd-ehci.c   | 72 ++++++++++++++++++++++++++++++++-------------
>  hw/usb/trace-events | 24 +++++++--------
>  4 files changed, 78 insertions(+), 40 deletions(-)

I skimmed the migration relevant bits, it looks all fine now, thanks.

-- 
Peter Xu


