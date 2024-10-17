Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AF3D2F7F6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Kc6-0002xk-Ug; Thu, 17 Oct 2024 03:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t1Kbx-0002wV-Nw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t1Kbu-00056b-VD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729148870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XxnoZqcAhVyHsTAGCczEPp2KXs2bM44YDL+etGV2HU=;
 b=F1jtMIHHmF5LrDstJP17iTR4/OUxD8I25YO7UFyDxCvyEdEC4pUGHx2KGdYNWkHRRS6UoI
 9o677hPopBCtx6rPB29AA6ZldkNm6jaOrz9JsA20rubiD3iBTQ1CgDZEC+7F+k0Yxb/iCj
 YnHPhuQzdiKkMtzbqrAV77pVoYw9q60=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-AYYd_G2hPF-zC4hW9R8U2g-1; Thu, 17 Oct 2024 03:07:48 -0400
X-MC-Unique: AYYd_G2hPF-zC4hW9R8U2g-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-206da734c53so7226105ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729148867; x=1729753667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5XxnoZqcAhVyHsTAGCczEPp2KXs2bM44YDL+etGV2HU=;
 b=KUoeCYkN5zQDr4Fn7R62ATv2oG2WXFwdD/ECaR66kBihULDY6+7kAv/k3kfJAHAY6m
 gFU3Q17xizz6l3hMAsXlGsWXsbDSDe3/enwKK2pvSkn5uO7fc6cvZZXo8PoFL/K3Y5gN
 uSOaxeP2Rat4ukqPLOTQbSZ2OjUrlfPoxSPymAulB092zCFaCQL7T0tL8iuHPuiXt0BB
 sSwoEBexB6DiDsCLk11TyOgRLeRxGOBA88y1ZdtjOEx9MzNlSSfQqaleeEJFBR486qUO
 KOLSZ2DE0i1D8dWuM9RYpFnJmstDtboP7ajGrSOHg3fti6BhgQi8N5+95v6UK1Rkqw91
 ujCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmNSZwpHEV4NL7j8Xl7pjG2Svi5rPNof8fs4B9SDsRQ1cIiISy/oqIgBWoW3CcUnU3dOFAfCmHQIfm@nongnu.org
X-Gm-Message-State: AOJu0Yw0nTytJfGY+VR1FK+fw83njtT0TO0lTkf+bYlq2+C+IGTFwob+
 Kj6+wnxj2+AtDLGweykKRN1KZD8yF/qH9W/L9AGofgPmTWV6UC0Jmxo98ilCG1iQ3JXb9Mm5kBJ
 OgAEquR9+8BKN8qM8m6otoifJxuxMxRiFX162ZfEB1UYQtBxh8+0+
X-Received: by 2002:a17:902:cec3:b0:20b:5be:a403 with SMTP id
 d9443c01a7336-20ca1429594mr286607995ad.11.1729148867650; 
 Thu, 17 Oct 2024 00:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBbLSn7uH1nSEfLXlJwAVz2k+iSKKz7pIMWhxJL02yvQfp80Yt2G8d1JIHBwfjAqYur0iQnw==
X-Received: by 2002:a17:902:cec3:b0:20b:5be:a403 with SMTP id
 d9443c01a7336-20ca1429594mr286607695ad.11.1729148867273; 
 Thu, 17 Oct 2024 00:07:47 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f9db77sm38831055ad.98.2024.10.17.00.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 00:07:46 -0700 (PDT)
Message-ID: <b403fa29-2ccb-40fa-89d3-ce6d4152b766@redhat.com>
Date: Thu, 17 Oct 2024 17:07:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, peterx@redhat.com,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com,
 gustavo.romero@linaro.org
References: <20241015100012.254223-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Salil,

The issues reported against on RFCv3 are still existing. I'm listing them
as below.

(1) Guest fails to start due to SVE initialization

/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  \
-accel kvm -machine virt,gic-version=host,nvdimm=on                      \
-cpu host -smp maxcpus=4,cpus=1,sockets=2,clusters=2,cores=1,threads=1   \
-m 4096M,slots=16,maxmem=128G                                            \
-object memory-backend-ram,id=mem0,size=2048M                            \
-object memory-backend-ram,id=mem1,size=2048M                            \
   :
kvm_arch_init_vcpu: Error -22 from kvm_arm_sve_set_vls()
qemu-system-aarch64: Failed to initialize host vcpu 1

Workaround: The SVE feature bits in ID_AA64PFR0 need to be masked off in
kvm_arm_get_host_cpu_features() after the feature register's value is read
from the host.

(2) Fail to hot add vCPU whose PMU is turned off

/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  \
-accel kvm -machine virt,gic-version=host,nvdimm=on                      \
-cpu host -smp maxcpus=4,cpus=1,sockets=2,clusters=2,cores=1,threads=1   \
-m 4096M,slots=16,maxmem=128G                                            \
-object memory-backend-ram,id=mem0,size=2048M                            \
-object memory-backend-ram,id=mem1,size=2048M                            \
   :
(qemu) device_add host-arm-cpu,id=cpu1,socket-id=0,cluster-id=1,core-id=0,thread-id=0,pmu=off
kvm_arch_init_vcpu: Error -22 from kvm_arm_vcpu_init()
qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (1): Invalid argument

Workaround: Keep PMU on while the vCPU is hot added.


Thanks,
Gavin



