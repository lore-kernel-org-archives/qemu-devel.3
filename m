Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AFEC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2bS-0002sE-6I; Wed, 20 Mar 2024 16:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn2bP-0002s0-Lr
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn2bM-0000uT-Gi
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710966715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lrHmvojHdkPh5TqSrQQHC55PEivjVvN7u2YxMlX4Hw=;
 b=BRZAE0GuN81QDm3gc38ghlWgdvaKRhCCGBn4hqSgCM9/XyTA/exaB2Y8HY0NUUBAYKXN7j
 BirD8W3XlZspX2PFJ2AWRlxpmc3zdZ20Jd5wFrdPxLA+71tOp9QaWfIiNN6xl3kOHQO1xq
 TFx6mJAI4G5VX+GlANa4XrLvHJc1OQQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-SpiEERZWPvmPnke_nGhetg-1; Wed, 20 Mar 2024 16:31:53 -0400
X-MC-Unique: SpiEERZWPvmPnke_nGhetg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430b4572a97so760481cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710966713; x=1711571513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lrHmvojHdkPh5TqSrQQHC55PEivjVvN7u2YxMlX4Hw=;
 b=rCt6TJd5a8anfYvxDySrJdXsBCDVlYgrq2cOBvEQWkr11+ALjXEpcJs+T/tsC4U5jH
 rbJoqT49f/CWktIchg65nooIs0OJ8Fa2zB6FLhQtNWpulVgshfIoHfqvfpwzWOOA9/qY
 urrh/B9UF1FOAHu4JdPj4fU1lMt5S2sej0ftqhJfrT2HoJHDt6I+9ZHm7/f7DKiauEd8
 TRtCpL46Xr/JMtk58grABMEsSWFQReI4W73tMXlQeih3pLpcRnXHlt1vc3FfTcJjwA94
 wOS/AV6Jog2SvsXNfpHN5bhgQIOrQwFh/aEU+0E8Lg8Tx8vXOFdNl7hIueXoMFeXDLTs
 s8nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNKp1OHDpUmrXfiNWgLmDV3difjYgVLX3MSHNi7hZx6UzAp1+erGTDMjxpcjM8hi6FS4B0WDyPApfDPJd0IKi/CPx7SQg=
X-Gm-Message-State: AOJu0YwSuBLq7QdVER+75BcSzZbffUpuC0JZ3Az9HflqisKiGb5e8rEa
 hcx01EGfWZRQNkeOU37kAf7FFsKB6OqdGwTV+pPLPSh2Kv683OEJ+dOedI0u8cIJZD0cnbk7ZWG
 FVkznosUaUHqNsyaoLnZzSfj9Pt0yvJgXaWx7sXVPYvoiCPxXDd5W
X-Received: by 2002:a05:620a:4710:b0:78a:29c8:fb45 with SMTP id
 bs16-20020a05620a471000b0078a29c8fb45mr1946054qkb.4.1710966713174; 
 Wed, 20 Mar 2024 13:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5PJVK3yQvHpDwam/hNFjHOWEuZ2l4KkjiH7zIp09qtkJF6jT2l+YYF91qk0lKUHGT/Z+kvA==
X-Received: by 2002:a05:620a:4710:b0:78a:29c8:fb45 with SMTP id
 bs16-20020a05620a471000b0078a29c8fb45mr1946025qkb.4.1710966712675; 
 Wed, 20 Mar 2024 13:31:52 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 p1-20020ae9f301000000b0078838c7acbfsm6910245qkg.42.2024.03.20.13.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 13:31:52 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:31:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Message-ID: <ZftHtgpxOPNA8AYE@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com>
 <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Mar 20, 2024 at 04:23:01PM +0000, Liu, Yuan1 wrote:
> let me explain here, during the decompression operation of IAA, the
> decompressed data can be directly output to the virtual address of the
> guest memory by IAA hardware.  It can avoid copying the decompressed data
> to guest memory by CPU.

I see.

> Without -mem-prealloc, all the guest memory is not populated, and IAA
> hardware needs to trigger I/O page fault first and then output the
> decompressed data to the guest memory region.  Besides that, CPU page
> faults will also trigger IOTLB flush operation when IAA devices use SVM.

Oh so the IAA hardware already can use CPU pgtables?  Nice..

Why IOTLB flush is needed?  AFAIU we're only installing new pages, the
request can either come from a CPU access or a DMA.  In all cases there
should have no tearing down of an old page.  Isn't an iotlb flush only
needed if a tear down happens?

>
> Due to the inability to quickly resolve a large number of IO page faults
> and IOTLB flushes, the decompression throughput of the IAA device will
> decrease significantly.

-- 
Peter Xu


