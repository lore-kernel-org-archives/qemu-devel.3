Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCE9C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 08:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkgQl-0007YN-Q2; Thu, 14 Mar 2024 04:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rkgQd-0007Y5-0F
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rkgQW-0005uZ-EA
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710404818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUGPb2FwStDT7f4MGlCQU3gMq3q+9XkeB8V8WQUvNjc=;
 b=XhYYDuijzcKyHtqgBMdq5IFwhkvAjp5nEqHynJw0BNLl61TnTGpE5xSay2n3LYCnmFpiuA
 TVXzGFKGX14zTo6Ld5qqrIrYgTHjGHWIcmPaJ+j44tp5SsoguKDKmRWROYaAVYo6hVs7fc
 issxK0LeHnYLqjFEO2NhNZMdp37I8Tc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-Vm1zW9wqO02Li7pJUUStLg-1; Thu, 14 Mar 2024 04:26:56 -0400
X-MC-Unique: Vm1zW9wqO02Li7pJUUStLg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d8d208be9so393726f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 01:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710404815; x=1711009615;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sUGPb2FwStDT7f4MGlCQU3gMq3q+9XkeB8V8WQUvNjc=;
 b=AwM1mPbEDUegV8B+UCqfIAJiNyndJW3VAkzYnGNw790qVJVtw+UT7GjtW0suBXlSMT
 r5WHioh1pu7YwT1YzXIjDCi55V5HhGU8YebwYU4QOH/p5bWkRSSZnQ0chsXu0bBGCAza
 9EoPKCAYjfyjULKXeRNzwdEHjoXweVCS0GZ8fdE1d9IAgaJCtIZEtqzlwfT0FOOl/QHb
 IphiN243wNwkgkRQA/Ix9nDinXSenTNYuGYK+h153tEgxGHBytagwuakLoapJiKyt+Zh
 EJ+gP2A0ThrzcMQtXzo/RAIrTxhYUpg6H969ywmUGZArFmML5H1e/TMsw6r152z6joAO
 yw6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqfQnvtg34RkpV0JnLy6P/Ep7CKvruARSY6Hr4XXFQ+/0A9HfN7m1aIPKupL8VcmcpPBrW+3TBMYFoKwm/AG0ua/YCQi8=
X-Gm-Message-State: AOJu0YyM/fwmzPHKK7sTEgr5dfJYHs+s0Mu6Kj/fUs0hUDXDyfp1hWw3
 GRRLUElACoowFXJZHjr6D6+QXMBVdiXB6fvgIknZJ+hQrOPLRsRK6wTTf2ZF8C/ISWISh7C2eQD
 vvyPo2EpGzC56aWnOeOLk8j7p+LWEb4+Aa/ee3jbgoElGUlmeOifY
X-Received: by 2002:a5d:4b07:0:b0:33e:7f51:c2fb with SMTP id
 v7-20020a5d4b07000000b0033e7f51c2fbmr709463wrq.41.1710404815038; 
 Thu, 14 Mar 2024 01:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfgnTepXsyhYEL3Qk/i9QwHZbF23RjVUbCWLJMchJHOs8ZznZZzkS1RItL8wxppBPwtosLQ==
X-Received: by 2002:a5d:4b07:0:b0:33e:7f51:c2fb with SMTP id
 v7-20020a5d4b07000000b0033e7f51c2fbmr709452wrq.41.1710404814659; 
 Thu, 14 Mar 2024 01:26:54 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 l4-20020adfe584000000b0033e91509224sm184074wrm.22.2024.03.14.01.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 01:26:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 09:26:53 +0100
Message-Id: <CZTBWJZVA9SG.1U837DUGPOX31@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
User-Agent: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <ZbjDtytv-_-Bz4-S@redhat.com>
 <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora> <ZfB5eBwWXL45sN_K@redhat.com>
 <CZSKAAQ3HE0Q.32DYA8Y3PX16V@fedora> <ZfGIScbYp3htVRMi@redhat.com>
In-Reply-To: <ZfGIScbYp3htVRMi@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Hi Daniel,


> You don't need to access it via the /node/ hierarchy
>
> The canonical path for CPUs would be
>
>   /sys/devices/system/cpu/cpuNNN/topology
>
> The core_cpus_list file is giving you hyper-thread siblings within
> a core, which I don't think is what you want.
>
> If you're after discrete physical packages, then 'package_cpus_list'
> gives you all CPUs within a physical socket (package) I believe.
>

Yes, this could work.
However, on laptop, I've got:=20
cat package_cpus_list
0-11

Where on server:=20
package_cpus_list
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46

I asked my teammate: always the same results. This is I guess due to=20
either a difference in the kernel version or how the kernel is handling=20
the case where there is only one package, versus the case with multiple=20
packages.=20

Anyway, writing a C function to handle both cases might not be easy.=20

The other solution would be to loop through=20
/sys/devices/system/cpu/cpuNNN/ and update a table of integer of a fixed=20
size (*) where I increment table[0] for package_0 when I encounter a CPU=20
that belongs to package_0 and so on. Reading=20
cpuNNN/topology/physical_package_id is giving to whom package the cpu=20
belongs to.

This is a bit tedious but a safer solution, I think.


(*): Maybe dynamic allocation is better ?

Thanks again for your guidance.

Regards,
Anthony


