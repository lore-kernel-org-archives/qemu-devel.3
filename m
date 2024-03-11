Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF2EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhUn-00024U-HY; Mon, 11 Mar 2024 11:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjhUa-00023F-4V
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjhUU-0004FH-Be
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710170577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO6AOKKtPoAZBcTZORGPvQhESqW4ylIsYMtoflYBP8Q=;
 b=iU+Ak8qrIZu2GLu1OyhSIMjPER0k6X5YflmfXVFoQFTQwGFEdb2jgsBiiV0nDtYMXdbs/9
 lK1o7tRDbWUtmyt4ZJwb/ISq8ClPOrS34L8zCsZIjvggGUOHrTxchJCZbH2DK7f+yH3r+Z
 GsOJO+yuZSEYEw/dgLtfLq5k7EqSVIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-D46Juc9tPUW6LZ1ZgINRlg-1; Mon, 11 Mar 2024 11:22:54 -0400
X-MC-Unique: D46Juc9tPUW6LZ1ZgINRlg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4132a5b38adso5124855e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710170570; x=1710775370;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aO6AOKKtPoAZBcTZORGPvQhESqW4ylIsYMtoflYBP8Q=;
 b=fT1AGm3FpuYCsBuVITTgGoSer6kpCYsoHV1jaPPMjuoYJsyLT4ESWoFKOTHxhYdk2X
 8r0+w0JsDBtUjP6OiMthRtuphotqWc22Xq3YfdAW66Rh+LoBpWQrbeWNneR3Lf4VsXy2
 SQuuthinzz/WMyW1vsy51fHmF58fVST6O3zSBxbEwLcagLRQs6xD6Rx3WHDK4lkAhR6A
 bes55qWWV88a8DjLhs5qpq6f16WqHXHtaG8LstWmQI7nbfJsIYr4hYiJUa87Hv0ASL+z
 CV6F4HfLE1DVr9HLzgBRVDXcE0KVFRqqhjZHz9B4Acb21awmIPqZpZE85te+fsyidQuM
 i0Fw==
X-Gm-Message-State: AOJu0Yw6MwM2JKnOBerNQmZr6DXp1HitRnISP0ihXZ5ZhPg8v5S+i5hP
 T6p0Mvivj6fHnck2s2ndjjtyubLFmHWCo1qT7mfYbF1Ui8LpmiB5ft/Dp0lBiT7spcPnXmXZLZz
 /gR30P0M/RsedWK01oDXi7Na1+ntW63+1GGUJouiCGKWbdFBYh7gf
X-Received: by 2002:a05:600c:5494:b0:412:aa70:67a with SMTP id
 iv20-20020a05600c549400b00412aa70067amr7490736wmb.5.1710170569808; 
 Mon, 11 Mar 2024 08:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHokOu3rxGAJFdQCDTSMaHOckGnuPNe9I5nkO4LgIWTx8pOX6SAJZEzgDGcaGPBuzn/Mu7OTw==
X-Received: by 2002:a05:600c:5494:b0:412:aa70:67a with SMTP id
 iv20-20020a05600c549400b00412aa70067amr7490711wmb.5.1710170569423; 
 Mon, 11 Mar 2024 08:22:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c4f8400b00412ff941abasm15925243wmq.21.2024.03.11.08.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 08:22:48 -0700 (PDT)
Message-ID: <7fe26a07-abac-4211-96f7-efcf9878f090@redhat.com>
Date: Mon, 11 Mar 2024 16:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/25] migration: Always report an error in
 block_save_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-8-clg@redhat.com> <Zeq3bfUt6cpug4GC@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Zeq3bfUt6cpug4GC@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/8/24 07:59, Peter Xu wrote:
> On Wed, Mar 06, 2024 at 02:34:22PM +0100, Cédric Le Goater wrote:
>> @@ -404,6 +403,10 @@ static int init_blk_migration(QEMUFile *f)
>>           sectors = bdrv_nb_sectors(bs);
>>           if (sectors <= 0) {
> 
> Not directly relevant to this patch, but just to mention that this looks
> suspicious (even if I know nothing about block migration..) - I am not sure
> whether any block drive would return 0 here, if so it looks still like a
> problem if we do the cleanup, ignoring the rest and return a success.

yes and it is not symmetric with block_load() :

                 total_sectors = blk_nb_sectors(blk);
                 if (total_sectors <= 0) {
                     error_report("Error getting length of block device %s",
                                  device_name);
                     return -EINVAL;
                 }


> 
>>               ret = sectors;
>> +            if (ret < 0) {
>> +                error_setg(errp, "Error getting length of block device %s",
>> +                           bdrv_get_device_name(bs));
>> +            }
>>               bdrv_next_cleanup(&it);
>>               goto out;
>>           }
> 

May be Kevin could tell if bdrv_nb_sectors(bs) == 0 should be considered
and error in the save_setup() context ?


Thanks,

C.



