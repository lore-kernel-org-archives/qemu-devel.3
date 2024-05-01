Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24Go-0004U2-W2; Wed, 01 May 2024 03:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s24Gn-0004Tg-4A
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:20:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s24Gl-0000Fa-1J
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:20:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1eac92f7c74so52995995ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714548045; x=1715152845;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pMe0tkEnY+Zd6bwkQi+nZwM4FerHeDV0HnpSEBEZIHw=;
 b=XL3/97FmGlwF3EVauXlUokXDj1+LfgmtnGsPOxuUHwQBvEtBy+QUrcnosynzH26hi6
 T6tHoMJqirlyk06yKW1ix4WR8Mziq2Ot/4Qw9yFKwWmvpphJklHKuEX8vS3nggwM/hNz
 yjwyH02dXzc9fmaAwABIY4Hevlh8XWgPeSs2KMJOkT+s1w+c4H3Pq6A6AzPQtVPNmmWZ
 k7Amm382pfxZx5oUopbG7KuojiDtusxf4jjCC/XAPujm5oN3mSOtLK89ZmQjmzh/WkJH
 10Zb2hYcd6yu/t3mB/jcevliRiiIA3QKJS0h1nf1ef/HwXNtV25gWIJXHKodVSHfmx6q
 oikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714548045; x=1715152845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMe0tkEnY+Zd6bwkQi+nZwM4FerHeDV0HnpSEBEZIHw=;
 b=KwSu+VIUavSMdnJ7sTkKDXuu6de8rGskCVtLhCVkrdMvfPll8nsln4PerKcPv5wAdD
 1HbwfxvuCAtAwKLDWResYXUYd3ce4+sT4CxTUUft7h1tOv3T4ZvFMPtDZrTxdfHaJ8xl
 6Kn5cxahbl1hOr57b1ljLb0oRylbTkhW2sjdtF3qp2iKYkbSf1/QQTYtkcl66aBjfhmT
 fxlhoei7TkzPMAukVVCU6eHeH5qq5xV+xsXO8Vf43C6krKLIlK8QdVWZHtaeRHBAeRB1
 aLyJ79acTloDFUOIwXcJ/UAuWfx3Gt6LDIIYhVhmp41A2695b4v4PbgRmdzjm41pq/bG
 c3Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx3Ec2fcLdh+mPTqAS50FBubHreiqTKIOqaqc+pOricCAc1HGdNtPUHtsTi0qx4PHt5lyIw6BDkWg84WWj+DcFYErjAKQ=
X-Gm-Message-State: AOJu0Yx/2ZchApvf9JMxuNjx5AGzj0zYN+rHx4bJ4NF9YtcmU3Q7En5c
 newroMn7fTZFBzRfXc9UfW4Af29jrelQopJaFwnlCwsJ9eeI4lrXziW2qOMY3xM=
X-Google-Smtp-Source: AGHT+IFmTiBoBwhQcZBRgixAxuyYk3BXPfjXJ2t30wv3Q13FoaAuwe/3d4FpacvSuz1emtVz+xrCkQ==
X-Received: by 2002:a17:902:d34b:b0:1e4:6232:367a with SMTP id
 l11-20020a170902d34b00b001e46232367amr1486413plk.22.1714548045457; 
 Wed, 01 May 2024 00:20:45 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 cp1-20020a170902e78100b001ec7d91f1cfsm1070193plb.14.2024.05.01.00.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 00:20:45 -0700 (PDT)
Message-ID: <e7b29a10-addf-4fed-9092-73652cb16cce@daynix.com>
Date: Wed, 1 May 2024 16:20:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org, 20240428-rss-v10-0-73cbaa91aeb6@daynix.com
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
 <20240429030329-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240429030329-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

On 2024/04/29 16:05, Michael S. Tsirkin wrote:
> On Sun, Apr 28, 2024 at 04:21:06PM +0900, Akihiko Odaki wrote:
>> Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
>> ("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements")
>>
>> Some features are not always available, and virtio-net used to disable
>> them when not available even if the corresponding properties were
>> explicitly set to "on".
>>
>> Convert feature properties to OnOffAuto so that the user can explicitly
>> tell QEMU to automatically select the value by setting them "auto".
>> QEMU will give an error if they are set "on".
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Should we maybe bite the bullet allow "auto" for all binary/boolean
> properties? Just ignore "auto" if no one cares ATM.

It is not always obvious whether "auto" should be considered as "on" or 
"off" for existing boolean properties. The properties this patch deals 
with are to enable features so "auto" should be considered as "on" if 
possible. However, other properties may mean to disable features, and in 
such a case, "auto" should be considered as "off".

It may still make sense to accept "auto" for all virtio-net feature bits 
for consistency. In particular, I left guest_rsc_ext property boolean 
since nobody cares "auto" for that feature, but this can be converted to 
OnOffAuto.

