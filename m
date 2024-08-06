Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E91C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEjb-00065E-L4; Tue, 06 Aug 2024 03:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sbEjZ-0005yG-QC
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:35:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sbEjY-0004aS-4G
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:35:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc5296e214so2847295ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722929750; x=1723534550;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LWhrLRVWa9kKNFrZFgYCM5vNBDobiQh0I20Bo8ooMLQ=;
 b=vVMa8ul1dgXaVH+oymTBygm+hxqrCwe26kh0qJGCPSKFjihyscE+JeSCAnCYNuLjda
 n/g3UUFnTTeZFWYTDxDW/iyIMmlSFV98UpSN5E8jNWvniKZeUT+D/BNZ7grFtHEgxEsc
 bwmQshUgbUIU/fs2XciwTNEUy57yOFj+eRDZYltAOwZ7Ep6cTs9/3xarMmZay/+STNUh
 KRj91ekMGGJ0C3jLo1DD5gSzR/XM/pHHpNw1/vxG7TIcxPv7vGx0wd2IFCG30jxD2x+s
 iwPrHyV6IL0bBESCktWCHBhyc9jpL60t8qACb4uru50k3xEOSKY2N7TjODyk4vW+rLUr
 43Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929750; x=1723534550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWhrLRVWa9kKNFrZFgYCM5vNBDobiQh0I20Bo8ooMLQ=;
 b=Uw/4T3T2bZ8PDAazObWPO9D5PWuN8qFTSh7Xy5lxI+Ffw6GH47X+ctP3Km+CWwWnsA
 tUDN2SXgaoIJunycj8CNAIJJMBvktSYQDDZUbJLhPkVyEpOeymbPns3jCmSqRch2FU/g
 yateY+Eo3dg0QHTaQOPmA87tl9iUCEur026t9N8b71T67Y/PBw/W/7dzijpNPiQ8Grtt
 DRlMCOfnYuxd0G6xnu5rmaORNfwTs5TP6hHKT5cWaLGOz9VNc+pLvyO0uMgAurYh9mME
 muQy0J8VOCeTfyIHrfMKZwhaRJK1lrYSfBF/Tjq1L6gRq7by+m/JKCNxGSnYzdeLomKa
 sIbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7C/j0ly7NJL6TnTLfk9Hf98qMP7ghA0aqxnFhvCOCZ0NXrPswY4rT16uIZgRMrqpN4/iunPc1QvlRBC9rqxkLCa1C0+U=
X-Gm-Message-State: AOJu0Yzeb6zbDKTWI/XbwlezrTU2qmk0XCTx+c5j922vbyXH2rwfRi9x
 Vk3SE2xkVbxmZLuEhl2NoPc2mcJ7N8c2hnuMLxNQ71j99WrvqnqPYvh1sPua32o=
X-Google-Smtp-Source: AGHT+IGf+v7kzCDU/SuEYcmvDoShm1aR4cBRr+vxi8kGFM3gMfk0sf9Jw01muj1QzLc8PB9+xkE11Q==
X-Received: by 2002:a17:903:192:b0:1fb:5a07:797f with SMTP id
 d9443c01a7336-1ff57250e58mr208997235ad.4.1722929750350; 
 Tue, 06 Aug 2024 00:35:50 -0700 (PDT)
Received: from [157.82.205.232] ([157.82.205.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f586f7sm81497655ad.90.2024.08.06.00.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:35:49 -0700 (PDT)
Message-ID: <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
Date: Tue, 6 Aug 2024 16:35:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com> <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com> <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240805060544-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/05 19:08, Michael S. Tsirkin wrote:
> On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
>> If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
>> and restart). QEMU can also migrate across hosts if the user ensures they
>> are on the same platform.
> 
> What is so special about checkpoint/restart? I guess we hope that
> downgrades are uncommon, but they are possible...

Downgrades will not work with cross-migrate=off. Users who want 
downgrades should use cross-migrate=on.

