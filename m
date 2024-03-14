Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640CC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rknQN-0004us-Dk; Thu, 14 Mar 2024 11:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rknQL-0004lk-Hg
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rknQF-0000Mg-90
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710431703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8oYtv0N+Xj/Fys+iTmLtGu4n2bLmvghj7cUAxxwSoeo=;
 b=cNgUaPHQ4KQSeCjqqj3x8WLnoOzMf1011CKNczg6pF07gA8aKCPjyzV/bZsOITfwsGM1//
 RaG39t/mO9Gqv7zqKGXmFA3Bu+sM5SpryVKXslb5Ws9hauvrymVx7xWE6Bzo3q3N+2uYDS
 XSKiAXjzSQDq4tuW4ZwIMVUfns4CoQc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-3iVmqnNIPTu0SriNQp_IQg-1; Thu, 14 Mar 2024 11:55:02 -0400
X-MC-Unique: 3iVmqnNIPTu0SriNQp_IQg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513c6e69b85so1476226e87.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710431700; x=1711036500;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8oYtv0N+Xj/Fys+iTmLtGu4n2bLmvghj7cUAxxwSoeo=;
 b=jVyWnw898gqrJvCJdIvWQffiV/Ka4jFbTtLZebKoXlLDW4SudEFV47nfg/d5Bd2IyO
 WqQC8gtY/jbBk8nvh+b/3+tK0kEq1S5Pl7JnQGzY9BB9pn5QLZhPCWfTe3wba+GWal1x
 CvgWFDFUNgXiyEomyOcmHi7dHw0yp0QtcK2U7z91+N7M9mT+E5UtSvDB2Myp9YylBUcB
 8DY9PJNQ9JOp9qNt1/39Hh1g9i7aGjw4auIILReP1LhanQYyiYenk9XklEhupXecRDyC
 W+mpL7zjo0rWaDNG1sApk814M2snQr9IYTMvShXDHCStcM/YZnJwahjZ8aW65WKzLsES
 1WCQ==
X-Gm-Message-State: AOJu0Ywm55tbL8E70id94ba/Al1mVArkxr2ajmiFZZzMlLzT/VEL1mmA
 EqrYqiNzcGyojEtG6iTHuRWf6mxJvJK6pQt1fHqAh9ytLxSFbBNyyWKNoa1I1+YT9jrEMKCAOLR
 sNvM9tQ0VFDVekNaf3Q43sQu7joVEZ9xAgEGapy6mKCGzNsgKysMz
X-Received: by 2002:a05:6512:215a:b0:513:ba63:9f0f with SMTP id
 s26-20020a056512215a00b00513ba639f0fmr364404lfr.64.1710431700571; 
 Thu, 14 Mar 2024 08:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhY/MCRa5uCa9/Y6G8VPNqqxJ5+Vj5WOKsD47R3T4raSufwmB3yqXdGkU64ipG5TDejzCpaQ==
X-Received: by 2002:a05:6512:215a:b0:513:ba63:9f0f with SMTP id
 s26-20020a056512215a00b00513ba639f0fmr364389lfr.64.1710431700219; 
 Thu, 14 Mar 2024 08:55:00 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b00412e5f32591sm2748958wmo.28.2024.03.14.08.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 08:54:59 -0700 (PDT)
Message-ID: <f0d5ec8d-02fe-4660-afcf-ad7b0af1dc13@redhat.com>
Date: Thu, 14 Mar 2024 16:54:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question on s390x topology: KVM only, or also TCG?
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x <qemu-s390x@nongnu.org>
References: <c2aa273a-6f49-2a02-fd4d-a3ddd37db388@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c2aa273a-6f49-2a02-fd4d-a3ddd37db388@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 14/03/2024 16.49, Claudio Fontana wrote:
> Hello Pierre, Ilya,
> 
> I have a question on the s390x "topology" feature and examples.
> 
> Mainly, is this feature supposed to be KVM accelerator-only, or also available when using the TCG accelerator?

  Hi Claudio!

Pierre left IBM, please CC: Nina with regards to s390x topology instead.

But with regards to your question, I think I can answer that, too: The 
topology feature is currently working with KVM only, yes. It hasn't been 
implemented for TCG yet.

> (docs/devel/s390-cpu-topology.rst vs https://www.qemu.org/docs/master/system/s390x/cpu-topology.html)
> 
> I see stsi-topology.c in target/s390x/kvm/ , so that part is clearly KVM-specific,
> 
> but in hw/s390x/cpu-topology.c I read:
> 
> "
>   * - The first part in this file is taking care of all common functions
>   *   used by KVM and TCG to create and modify the topology.
>   *
>   * - The second part, building the topology information data for the
>   *   guest with CPU and KVM specificity will be implemented inside
>   *   the target/s390/kvm sub tree.
> "
> 
> In the docs/devel/s390-cpu-topology.rst
> 
> I see the example command:
> 
>   qemu-system-s390x \
>      -enable-kvm \
>      -cpu z14,ctop=on \
>      -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
>      -device z14-s390x-cpu,core-id=19,entitlement=high \
>      -device z14-s390x-cpu,core-id=11,entitlement=low \
>      -device z14-s390x-cpu,core-id=12,entitlement=high \
>     ...
> 
> 
> which uses KVM only.
> 
> In https://www.qemu.org/docs/master/system/s390x/cpu-topology.html
> 
> I read:
> 
> "Prerequisites:
> To use the CPU topology, you need to run with KVM on a s390x host that uses the Linux kernel v6.0 or newer (which provide the so-called KVM_CAP_S390_CPU_TOPOLOGY capability that allows QEMU to signal the CPU topology facility via the so-called STFLE bit 11 to the VM).
> "
> 
> So I would assume this is KVM-only, but then in the "Examples" section below I see the example:
> 
> "
> $ qemu-system-s390x -m 2G \
>    -cpu gen16b,ctop=on \
>    -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
>    -device host-s390x-cpu,core-id=14 \
> "
> 
> and
> 
> "
> qemu-system-s390x -m 2G \
>    -cpu gen16b,ctop=on \
>    -smp cpus=1,sockets=8,cores=4,maxcpus=32 \
>    \
>    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=1 \
>    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=2 \
>    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=3 \
>    \
>    -device gen16b-s390x-cpu,drawer-id=0,book-id=0,socket-id=0,core-id=9 \
>    -device gen16b-s390x-cpu,drawer-id=0,book-id=0,socket-id=0,core-id=14 \
>    \
>    -device gen16b-s390x-cpu,core-id=4,dedicated=on,entitlement=high
> "
> 
> We received questions about this, so I hope you can shed some light, maybe it would be good to just update the web page to include -accel kvm or -enable-kvm everywhere for clarity?

Yes, it would be better to include "-accel kvm" in those examples. Would you 
like to send a patch?

  Thanks,
   Thomas



