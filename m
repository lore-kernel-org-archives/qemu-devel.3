Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D434C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 18:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpt7w-00025r-8S; Wed, 05 Mar 2025 13:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpt7v-00025Z-8k
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpt7t-0004PT-O3
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741197949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2hun2UzUIwQgMAOmZNLNMZW1zSbDTeXQqgjll1Ersc0=;
 b=g+hjSzBwpzyxelsmZeYvhZSriBGhx3nGBL40krqAlPEqjZu1UEk1ZpwWRLsyuAKcRV+F4B
 E6KYt+es5lL1S5xrnQZHbIhvpF6UcqYXoGKOUyoc+hhsXYQkCwdC1o2Os2CwMGriju+fqY
 iw8rmswNRdyd+h1+CfxVib37OikXNYk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-V3qrva3vMjy_32T0MbW3pg-1; Wed, 05 Mar 2025 13:05:46 -0500
X-MC-Unique: V3qrva3vMjy_32T0MbW3pg-1
X-Mimecast-MFC-AGG-ID: V3qrva3vMjy_32T0MbW3pg_1741197945
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390f7db84faso3761586f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 10:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741197945; x=1741802745;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hun2UzUIwQgMAOmZNLNMZW1zSbDTeXQqgjll1Ersc0=;
 b=WGT711/rz9wUeib3Ym6w6XCuFDLKG8YQItOoUbiaH/CLcVziHuZ2FTVRDOA+6TUk+t
 jrGh+1ZOJWO87zcOUOmhS130PbwgKT/NhPZ+qW/ElCdRc5JANL3YkdYdxpWhjLmdCJaS
 +e8DQvANBcnH2+WybYoSjYI11klzjmPzEGl8zzl3kEdickLK3BCMwIC1y7XTXeJvckc3
 hg4vsYzRkLywUn3N1M4TQJziT9+oVV/duRkYgxH2qjHk4VDUfoVGmWh9+O5zIIJxF2Lx
 7g+coOnWUWdyO5r2nBjpUd0sn9YGPQrEgqb1GxZBvu6bWO0oljcgfJDJ8pbMYdkO9K5w
 mwXA==
X-Gm-Message-State: AOJu0Yxd1uTpG8JvzpQUrb/i7q2SV4rr3aJCnYLlXNDG50WB3sbzIrHj
 /31NVbw1vSeRr2XtQsw6kZmXW9vSLvAe3K9jO55JVRGRi6q6bipYXrHnlUlfiYAl70SUz7rEKq5
 IWnyuDSjLaoHIervXt70MGKGwlpC9Bq/0fsvMd5BFO5zUYMmfUFnU
X-Gm-Gg: ASbGncvMOga/vTOqyjwbkGjxtkc5mWWZYnosVEAfTFzPKx/yPfmlsMph5EQ1aEhfLpE
 7I8KnMCPMly9JnGMA+eDt+A0zHgzXXe4dLx4jziyd1JeCUSqJ3H1KL4go8daNLQDyXSmMdiW5iG
 /mbL+jRw1kBvoP4cF0T90zQY8JqIQ8UCuOs2kbt+G1HcArGDXV9bfL2z5mjHXcdwmQZnZAn4ODc
 ADptuY3+qQ0N3IKOGlhxolyOgNzaIoXtYZLFiUu2KGjBRlSPirEBvciuxS0KIBJJgMTyBaOr6+1
 4F1xDxy5bk5LmkRwSk8+TJztxVwggU6/emQwWlSYk4EeWlM=
X-Received: by 2002:a5d:6da7:0:b0:391:952:c730 with SMTP id
 ffacd0b85a97d-3911f724d03mr4550463f8f.11.1741197945428; 
 Wed, 05 Mar 2025 10:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+WPYjlw6hoT2hfsjyCB4zEOjEbcuRCGIJXxIvWCJftW0DdTbLYtU72EamGGzNq2KImuClUQ==
X-Received: by 2002:a5d:6da7:0:b0:391:952:c730 with SMTP id
 ffacd0b85a97d-3911f724d03mr4550406f8f.11.1741197945040; 
 Wed, 05 Mar 2025 10:05:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm22087456f8f.15.2025.03.05.10.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 10:05:43 -0800 (PST)
Message-ID: <6ddfe2ac-9d1f-446c-8ab4-9c14fdb46411@redhat.com>
Date: Wed, 5 Mar 2025 19:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250224120449.1764114-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) to the QEMU Object
> Model (QOM). The CPI identifiers provide information about
> the guest operating system. The CPI identifiers are:
> system type, system name, system level and sysplex name.
> 
> The system type provides the OS type of the guest (e.g. LINUX).
> The system name provides the name of the guest (e.g. TESTVM).
> The system level provides the distribution and kernel version
> of the guest OS (e.g. 0x50e00).
> The sysplex name provides the sysplex name of the guest
> (e.g. SYSPLEX).
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>   qapi/machine.json                  | 24 ++++++++++++++++++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 51ae0c133d..13ea8db1b0 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -50,6 +50,7 @@
>   #include "hw/s390x/virtio-ccw-md.h"
>   #include "system/replay.h"
>   #include CONFIG_DEVICES
> +#include "qapi/qapi-visit-machine.h"
>   
>   static Error *pv_mig_blocker;
>   
> @@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>       s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>   }
>   
> +static void machine_get_control_program_id(Object *obj, Visitor *v,
> +                                           const char *name, void *opaque,
> +                                           Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +    S390ControlProgramId *cpi;
> +    cpi = &(S390ControlProgramId){
> +        .system_type = g_strndup((char *) ms->cpi.system_type,
> +                       sizeof(ms->cpi.system_type)),
> +        .system_name = g_strndup((char *) ms->cpi.system_name,
> +                       sizeof(ms->cpi.system_name)),
> +        .system_level = g_strdup_printf("0x%lx", ms->cpi.system_level),
> +        .sysplex_name = g_strndup((char *) ms->cpi.sysplex_name,
> +                        sizeof(ms->cpi.sysplex_name)),
> +        .timestamp = ms->cpi.timestamp
> +    };
> +
> +    visit_type_S390ControlProgramId(v, name, &cpi, &error_abort);

Forgot to say: Please use errp here instead -----------^

  Thanks!
   Thomas


