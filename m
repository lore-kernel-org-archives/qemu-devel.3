Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC776C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZsi-0005O5-0T; Fri, 08 Mar 2024 08:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riZsg-0005Nr-01
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riZsd-0004b8-Is
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709902999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4zut43jEHf+dzRVv5hh0k0okOLYghJEDLsUk715Y30=;
 b=OMRKPXau7wyNaEX6JfeaLcDVgtEj0b1TqqS804K3DWjZilmiwqYSA0zU3scKVX8R/jkBdw
 c1Osvo3teipwmQ99HT8DDW+acv/dCW+nUMBeOz2VLBTzvyL2T0pMTUMhqKBYdvifkTb/7X
 F6Q4dH3rPxYyQC83iJ1rwrV03Qoj+24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-wzDSt8LPN622CmG8X6AW9A-1; Fri, 08 Mar 2024 08:03:15 -0500
X-MC-Unique: wzDSt8LPN622CmG8X6AW9A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso10753665e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709902994; x=1710507794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4zut43jEHf+dzRVv5hh0k0okOLYghJEDLsUk715Y30=;
 b=CdQ8niEt3vSmowjMGz1mmJuFZ31zFBIV1U+KL3OtAxw7Cv8CK8NHBjEUunoWkv0sY8
 46+R5dY/8PN06HlMqmmkq3y/LKrlNZHrrbIz+EHnIw8K9sOHM3WFdzFA531d1gc2yy5O
 G+3b8MzESOjkj+AzsTYa6MN5TZhoUcUs9bCG2DE9ko8YIyjnVTvaZOWY7AOBt7O0SOgr
 s5/K/+NR2otZf5tXvPp0WBzdW99n1Du+KonfDzwuLQ46RBU6iQ5Evw7aS7ADDMyY76Ya
 kpphXR3S6jdH4N+s+hxnZTYZ7SSldFwDeFG4rbauqCwFOO9Lgx81+0UT8IBhlaRApxgE
 7PFw==
X-Gm-Message-State: AOJu0YyY2L/ALQ2aS2ejvcb0CyJRQi+4Dd0C3IVKGLdc4JQwd/DMC1SB
 UJ2MOql+oWtcjWT+ccQrQIk1/Y2ovAJmxk0L8BJFOUDN50DPDjmCB5QqwaO2MPu00Igr0Lu/3vL
 Fs0T+g7h+xy52R9KozNHNqVIkumG2rbwi7+p5RBu1UedQgrGvw7Oo
X-Received: by 2002:a05:600c:1c82:b0:412:e555:ff1e with SMTP id
 k2-20020a05600c1c8200b00412e555ff1emr214862wms.0.1709902994536; 
 Fri, 08 Mar 2024 05:03:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHatpxhK+ednbWd6WiCTvO7c28Vi64K3tgpenI8/bDjEgzus9zPzSWiYXZ9rEWY++pquWF9Bg==
X-Received: by 2002:a05:600c:1c82:b0:412:e555:ff1e with SMTP id
 k2-20020a05600c1c8200b00412e555ff1emr214840wms.0.1709902994253; 
 Fri, 08 Mar 2024 05:03:14 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a05600c34d500b004131bbbd9bfsm865101wmq.40.2024.03.08.05.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 05:03:13 -0800 (PST)
Message-ID: <2869ab33-c862-4a8f-892c-095aadab7fef@redhat.com>
Date: Fri, 8 Mar 2024 14:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com> <ZerJDAdaakTCtECF@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZerJDAdaakTCtECF@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On 3/8/24 09:15, Peter Xu wrote:
> On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
>> * [1-4] already queued in migration-next.
>>    
>>    migration: Report error when shutdown fails
>>    migration: Remove SaveStateHandler and LoadStateHandler typedefs
>>    migration: Add documentation for SaveVMHandlers
>>    migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
>>    
>> * [5-9] are prequisite changes in other components related to the
>>    migration save_setup() handler. They make sure a failure is not
>>    returned without setting an error.
>>    
>>    s390/stattrib: Add Error** argument to set_migrationmode() handler
>>    vfio: Always report an error in vfio_save_setup()
>>    migration: Always report an error in block_save_setup()
>>    migration: Always report an error in ram_save_setup()
>>    migration: Add Error** argument to vmstate_save()
>>
>> * [10-15] are the core changes in migration and memory components to
>>    propagate an error reported in a save_setup() handler.
>>
>>    migration: Add Error** argument to qemu_savevm_state_setup()
>>    migration: Add Error** argument to .save_setup() handler
>>    migration: Add Error** argument to .load_setup() handler
> 
> Further queued 5-12 in migration-staging (until here), thanks.

Thanks Peter. All the prereq changes should reach 9.0, which leaves
time to discuss the core changes for 9.1.

C.



