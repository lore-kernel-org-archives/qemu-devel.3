Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FC5C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8ax-0000g1-01; Fri, 15 Mar 2024 10:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl8au-0000fY-UK
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl8at-0000lq-K1
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710513094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhLpqY0x5oddwZF7Pef1cCyhlta+48OMpG5TdILQZW4=;
 b=JHJhAReirxj4b+cvTP46qBqrHHKWV0WrI0Gn9KeRBb3bklJnGwsm22Xv5eBqRXiEiZj4kA
 DxDWTLWDZ85vE/yvr6lkoCSoYPMUCXTMjzSOPzy+xiN1UFm2ndqbkX6MqxKbpUeQTOxFft
 7DS7AlrVJtGVAINjIHdt6AWssAVwVm4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-FZAvT-ocPp-vwNjpeF3WWw-1; Fri, 15 Mar 2024 10:31:31 -0400
X-MC-Unique: FZAvT-ocPp-vwNjpeF3WWw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2218e929fabso2339695fac.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710513090; x=1711117890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qhLpqY0x5oddwZF7Pef1cCyhlta+48OMpG5TdILQZW4=;
 b=IWuxP0f/Cfzge99D2QeNsnXpGRqlDs7EUHRLzZLopL7PHitXdFM1WNK+laig8exfzZ
 uzJ3oIMjgTi+Y9SF5fiM/Ocfd/pN7wxoh4y0932RP975RQrD5RX0EN7s7TsF/0phoJnR
 XpKMoUTjSU/+6BBEvbJTCGDYpIYyluOOEawpizbFMHoLlYJlyC7GjUsMf/e6kHB1SULM
 DNxCJ+YvrPGz5IH0+1QOn0Y22dDZWwPjE3lh2lMGEgqRPrarPkYwlUDjqXQErGCZ/rfX
 KPwLQJwclIN2CGvGecXWsnyk92bwehA4mGunwE9q80bI3Nt0ZLfMCuL29X+9mMFcIsKU
 hyoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc0cwrwrkRDR65pBItpXtwN/4wtUio37bJwcTqUngHRyd/rgymK4PnfoLFPis+o4FHmXW3RkVyAja4N6MkoY+1/pHpvhE=
X-Gm-Message-State: AOJu0YyJo3SZZpJ6/G7bX99dZRIItME4Sy9eswhUgvkPTQv7Tyx3lltM
 c0mab2HvgntTz5xaqtgmlLcK58pPh1wZhwFCqjz59/R9faCS42qoN9uogUj+lG3xvzwt+FSwrNt
 gmTLiLcxVRcWlpRTRUSflsAamzGxr5LlHzuZhjzzusyffKDAWBC44
X-Received: by 2002:a05:6870:a9a8:b0:221:51c1:3284 with SMTP id
 ep40-20020a056870a9a800b0022151c13284mr4533913oab.12.1710513090728; 
 Fri, 15 Mar 2024 07:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdeO2EIoA5mBxje0Sr97nbgFhL5lWzeipbLlrIyX7iAy0eTyCZIf3SSCoOBMhaKWjMA1FGUQ==
X-Received: by 2002:a05:6870:a9a8:b0:221:51c1:3284 with SMTP id
 ep40-20020a056870a9a800b0022151c13284mr4533889oab.12.1710513090494; 
 Fri, 15 Mar 2024 07:31:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 dc33-20020a05620a522100b007885cd1c058sm2106481qkb.103.2024.03.15.07.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 07:31:30 -0700 (PDT)
Message-ID: <36089ba2-7ee3-412f-9050-739a8ead2fbc@redhat.com>
Date: Fri, 15 Mar 2024 15:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n> <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com> <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com> <ZfRJHEya_kPaXWbU@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfRJHEya_kPaXWbU@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

On 3/15/24 14:11, Peter Xu wrote:
> On Fri, Mar 15, 2024 at 01:20:49PM +0100, Cédric Le Goater wrote:
>> +static void qemu_savevm_wait_unplug(MigrationState *s, int state)
> 
> One more trivial comment: I'd even consider dropping "state" altogether, as
> this should be the only state this function should be invoked.  So we can
> perhaps assert it instead of passing it over?

Yes. If you prefer this implementation I will change.


Thanks,

C.




