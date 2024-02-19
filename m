Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4796DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8Lc-0007Ya-8M; Mon, 19 Feb 2024 13:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rc8La-0007Vw-6E
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rc8LY-0006m2-Id
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708367191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkzV+1257B2FqWosuaxJML+eF4uiBPctHFvHZ4eUl5c=;
 b=PKD5zblPuVzZofkkfGMpZm73McP4VuJkm3FUz9FVI2n+7Su0w7gQExYH+gSL4Va+7oTMWG
 s1Z8KFxpBFKod4ImK8YkynuF5MLtd8ev3roh7+cKazrc3NM0tYtKpL3Rzz+1SohrknUIzQ
 4eKYvvqbLK1ROf8InUlK1Wx/tBV0TR8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-uo2Yir1XPCCC1Ho5Koemng-1; Mon, 19 Feb 2024 13:26:29 -0500
X-MC-Unique: uo2Yir1XPCCC1Ho5Koemng-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c15074df25so2319156b6e.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 10:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708367189; x=1708971989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dkzV+1257B2FqWosuaxJML+eF4uiBPctHFvHZ4eUl5c=;
 b=E4xp6mkz++mFXdIBXy7AwHXTshiATxbacEwjEuBa9sTH9DvtXGQvpqRuO8eY1LUtvg
 9y5MpxTOETMTVLhflmyv55rqvve6Pq6F2JKYMPTRW6Wpi3OYby9nJZtg82IrKZi1vFGR
 gy+04tEOloFPu02ctIrznVumE47/slfNrzYZWHwDte666wOugLsWviDMqRKvr/suBvQw
 4acRfjtAKDEjAJFO9xZWlik9POHBbHKmhGYiS22+mAUJ/gQ6VzP4xvAmk9t2LngoqTjA
 zQTHdDNO8qjSgK7XJ5I/b0EG3lCBv5qwLzb0ZXOqOj6i7HMGLu5UsvohS4vOwmxp7Hbr
 zJWQ==
X-Gm-Message-State: AOJu0YwYJRiGqFTsW8Ld3r2qVW5Qxj793lsIGgRb/YSi+sGl0iNxg+iR
 9GjhyFfsxks/2pqrgUt3qf8oQHKNW18A9duNe3GLdIsRq88rO/n26sw2QFBToWJK9Gchx2vWk5T
 Lj7UhzpqzqF9X4djPlxRNHAwDvsZR+BylCgs42QUi398sciarV35I
X-Received: by 2002:aca:d0f:0:b0:3c0:4ac4:d7f1 with SMTP id
 15-20020aca0d0f000000b003c04ac4d7f1mr10903915oin.35.1708367188853; 
 Mon, 19 Feb 2024 10:26:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUcmDIBnVAJWCtr5pDItsanYKjAAl2C0WZctAOxXRj4rTSZ4pvFDVgHiVOqpnhS6XDzQef0Q==
X-Received: by 2002:aca:d0f:0:b0:3c0:4ac4:d7f1 with SMTP id
 15-20020aca0d0f000000b003c04ac4d7f1mr10903904oin.35.1708367188549; 
 Mon, 19 Feb 2024 10:26:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 qj22-20020a056214321600b0068cc0b46682sm414273qvb.4.2024.02.19.10.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 10:26:28 -0800 (PST)
Message-ID: <9db64273-d7e6-445c-bfe4-dcf7d90ee892@redhat.com>
Date: Mon, 19 Feb 2024 19:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to write data to i2c bus
Content-Language: en-US, fr
To: minyard@acm.org, Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <MW4PR12MB6997A0A111FB6999ACF87F26A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
 <ZdOCkeotwf3EF11u@mail.minyard.net>
 <MW4PR12MB69972BEDF8771C29A1E27C05A0512@MW4PR12MB6997.namprd12.prod.outlook.com>
 <ZdOMZKTd+tZqVpcC@mail.minyard.net>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <ZdOMZKTd+tZqVpcC@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

On 2/19/24 18:14, Corey Minyard wrote:
> On Mon, Feb 19, 2024 at 04:53:47PM +0000, Paz Offer wrote:
>> Thank you very much Corey,
>>
>> I am simulating an external module that wants to communicate with the board management controller (BMC).
>> The real device will be connected to the board using i2c bus, and could initiate communication at any time, by sending bytes over the bus.
> 
> And you have a simulated BMC that can do this?  Or is the system running
> in qemu the BMC.
> 
>>
>> I am not sure whether the 'Master-side' (the side the initiating communication) needs to simulate a full i2c-master device, or whether my code could 'simply' write directly to the appropriate registers of the guest OS.
>> Are there some examples or documentation on how to implement something like this?
> 
> The aspeed i2c controller is capable of having another bus master on an
> I2C but, but it is the only host that can currently do it.
> 
> It is doable, the code is ther for multiple bus masters, but there is no
> device currently that does it.  I assume that is coming at some point,
> but no documentation exists on how to do it.
> 
> You can look at the git commits in hw/i2c around 37fa5ca42623 "hw/i2c:
> support multiple masters" for the changes that were done to support
> this.


There is an i2c-echo device implementing an I2C slave  and a test,
test_arm_ast2600_evb_buildroot in tests/avocado/ machine_aspeed.py,
using it on the ast2600-evb.


Thanks,

C.




