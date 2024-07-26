Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF0EC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8o3-0001vf-7A; Thu, 25 Jul 2024 20:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sX8nt-0001XW-Ir
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 20:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sX8nq-0005tx-Vk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 20:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721953640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIbBOruk98ENJ1APHewWJU7cFZJmyxfAZQ7nEUlWnCs=;
 b=JkVUnvUOs/vzZndxk6kyNFsxXoYIg1aPjqiraVzo7PCNXj0Z4/reUOfU11zRIcSkDY5Skq
 O655JoD/Rrgw6e0v/4NY7aylk0cfljhdw6rPU8S+qg7i6aYoWUPYL+XPTb7JZRcRvjKpU7
 wglt91AIeSgVn1czopKSvHAC5eHB268=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-YvylIr2IOoKc5mYE5nYtzw-1; Thu, 25 Jul 2024 20:27:18 -0400
X-MC-Unique: YvylIr2IOoKc5mYE5nYtzw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1fc5f04f356so1140065ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 17:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721953637; x=1722558437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIbBOruk98ENJ1APHewWJU7cFZJmyxfAZQ7nEUlWnCs=;
 b=BvTdcaBfY8aQH2VkZmIsi8tF3TDBj4R6z6cbt7nLNQo6q2JSZDIGgpU1g+SoImQDOf
 lhW3nXvN5pcC9UpU940r24nTncuVuC8gGP+0idjIgMNWy6+zeLaS2e5NCZQ3uYf/13o9
 hPIPKRuNhznURD4TNfvUewVPX02F+HhUr/4qmGA5zaqQcBZyw6GlJm/BYBJDghWdRIBQ
 yFDFwBuGIbN70pMY4YTxHE9MVULlNqsQH5t85c9WjVTrSfaLGihcZPjXQmxyiSn1rNaU
 ko9oWueII6SJ7Xzfv4OpLuHX3EQoVLXf1Nx0qwIHRV59i8jKy3M2uS6oT4vtrpjH2PdY
 j9BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFkrH63I9KtywognCBBCHSRNfz2f0m5aCaxtS8e6g7qQN0iUY6mWJPgQOedmc531uzAseoSOltNDIqZMG6QDr3fAv1Lfk=
X-Gm-Message-State: AOJu0Yziavtmgq9s3VoC/J+4/O6zk4mW6Njbi2ca/6PMyyVo0+1Cdszy
 2ovUVwifEyNNEQlFIqJHsWG5w9LvAEkhvds+pCHJyG10+FkH0ozzdKQDp/sX2LplECubcUznVb4
 MmXdFR0VOolHKc8hKpYn1zaQEO49Euj4kgtS8Y/V3DBuFPM1sDQJ4
X-Received: by 2002:a17:903:2352:b0:1fb:80b9:fb8d with SMTP id
 d9443c01a7336-1fed933cbd4mr46866805ad.56.1721953637528; 
 Thu, 25 Jul 2024 17:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyKAM2IEtRnx6tlelN+P7qfjBkd3xFqtwZlMcjawl2f5BwGMAOU5sJTthAYPVZKHasPs8NaA==
X-Received: by 2002:a17:903:2352:b0:1fb:80b9:fb8d with SMTP id
 d9443c01a7336-1fed933cbd4mr46866495ad.56.1721953637116; 
 Thu, 25 Jul 2024 17:27:17 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.134])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f2fc46sm19994675ad.207.2024.07.25.17.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 17:27:16 -0700 (PDT)
Message-ID: <c774b733-35e2-4060-b86a-3804580d6acf@redhat.com>
Date: Fri, 26 Jul 2024 10:27:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU unpark
 logic
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 npiggin@gmail.com, harshpb@linux.ibm.com, linuxarm@huawei.com
References: <20240725145132.99355-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240725145132.99355-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/26/24 12:51 AM, Salil Mehta wrote:
> Loop should exit prematurely on successfully finding out the parked vCPU (struct
> KVMParkedVcpu) in the 'struct KVMState' maintained 'kvm_parked_vcpus' list of
> parked vCPUs.
> 
> Fixes: Coverity CID 1558552
> Fixes: 08c3286822 ("accel/kvm: Extract common KVM vCPU {creation,parking} code")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   accel/kvm/kvm-all.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


