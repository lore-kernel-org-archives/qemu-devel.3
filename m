Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D03C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxrg-0007WO-8j; Thu, 06 Feb 2025 04:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfxre-0007WG-6n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfxrc-0008JE-60
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738832877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=abDJHtmXPlcy1n3tI2+CQkCOvlnWfZuzRNFhk1iUW8c=;
 b=AY+GtQMfU47Zqf9WXPZipL+3VnE6XaRPHcu0Rn64TBa8YfgSwwwFR3AfvlR8zNTqsAzmap
 6nI9YfrQZVNF99AK4kh6Q1Y7bs9BAbKK1pwZ69c7g0K01DYIz/MXM0ETJlMcvgP2WyxGTt
 AEylA+TmjCH/mAT/ue32KmH6s4oeeLg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-QLtFOgb_ORWpzvPW4IQajA-1; Thu, 06 Feb 2025 04:07:56 -0500
X-MC-Unique: QLtFOgb_ORWpzvPW4IQajA-1
X-Mimecast-MFC-AGG-ID: QLtFOgb_ORWpzvPW4IQajA
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54278fd453cso341834e87.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738832875; x=1739437675;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=abDJHtmXPlcy1n3tI2+CQkCOvlnWfZuzRNFhk1iUW8c=;
 b=u5bb52gRI51NhKCtAYQvowTfsQu2wLompwoQDXxgXzHp0Ne3yGvY/Ics8n07vTVoBH
 7IjfgDo8MMrsfYulcdYcCaeJ2oE+9CYPRPcqOFYFCHuPQQhB8czUGoHR7cbLrkolcl42
 Jr6g72lzXn0Udx1+8IfNelBdK7ZsQF8yWndDIJU3ilirY1/6vFo7hqhQOgO30UHsdKTU
 gk8UoQx6jOBT05IltkBwfCcrwOY3Z58mqZeU295kmY2H3YgcWVpF34dqGBz0Kn4vZ/ht
 DXtjKJJBhZMR7seoWiVasJhSoALTswsoTFRB70pwRVJBujsjxdFShexRv8+PL1Y7N+u1
 rEfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhpUzMivHtAqarsrVxaVO6Nfrxj6N1na1lHPpEv2UiKu3FSlb1TGKx4gdwQRfyw9+AoqdNr+A1DiHX@nongnu.org
X-Gm-Message-State: AOJu0Yy+e9sDMZcNtrcbs+RIu+Ya08jlmHeMx/45tS/awFU4zjxmVh/4
 pBc8L+g7D60MB47IRb9MH/NSmFCPlGTZxWZodKFndv3fuEhznCAgqG6JwN/fDD8zZzzewcXJNE7
 m9KOWy593EjB6v0ZloViubC4Fn0puc9iXOsGy6jmqS4NINpZqJp9BeMhiYw78
X-Gm-Gg: ASbGncvKSiWq70oVpzfTbFHim903zG0vxlCg9feUpe60Q9zKW6V1CNsdbmJLPu47koN
 UC1hQETgstYMJHRBX/c1gVvKOe8B1c5R9Qc8TGF8cxayCglZ2mVOFmk1b1SSmiyWy7V31uCItq6
 ECs71Kxbp5ReLug83Zp8YkX5vtu/KvDZOg4ZE7yJEJSgUv4oBT/FZ37ecJFGWBWhrtjfKcvc+AW
 UXpYlwNYSG4uDSTqdiTvMWwmJjLEjDt03bGw5aAM3F3mmtFy84hsg/qH1G0b/wR75dHH70HTDzN
 aH22eFQwmE0jaNSpt3ibxT8qV/qaS/UeiCsy
X-Received: by 2002:a05:6000:154a:b0:386:375a:8322 with SMTP id
 ffacd0b85a97d-38db48813f7mr6114116f8f.13.1738832513384; 
 Thu, 06 Feb 2025 01:01:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwbVZnP5jAnWyUAZCwV/om+1hwB9BGXN7j5dSJ+MGYdcmlTJflEeedwWIF4PU2DFgEkqoiUg==
X-Received: by 2002:a05:6000:154a:b0:386:375a:8322 with SMTP id
 ffacd0b85a97d-38db48813f7mr6113473f8f.13.1738832507696; 
 Thu, 06 Feb 2025 01:01:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd81747sm1178987f8f.55.2025.02.06.01.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:01:47 -0800 (PST)
Message-ID: <a90b4f1f-8581-4647-9145-e52fc14ac604@redhat.com>
Date: Thu, 6 Feb 2025 10:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/functional: skip test if QEMU_TEST_QEMU_BINARY
 is not set
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250205155946.2811296-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 05/02/2025 16.59, Daniel P. Berrangé wrote:
> If QEMU_TEST_QEMU_BINARY is not set we currently assert in the setUp
> function, resulting in a big traceback:
> 
>      TAP version 13
>      Traceback (most recent call last):
>        File "/var/home/berrange/src/virt/qemu/tests/functional/qemu_test/testcase.py", line 280, in setUp
>          super().setUp('qemu-system-')
>          ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
>        File "/var/home/berrange/src/virt/qemu/tests/functional/qemu_test/testcase.py", line 196, in setUp
>          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>          ~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      AssertionError: unexpectedly None : QEMU_TEST_QEMU_BINARY must be set
> 
>      not ok 1 test_ppc_405.Ppc405Machine.test_ppc_ref405ep
>      1..1
> 
> For every other test pre-requisite that's missing we will mark the test
> as skipped. This does the same for missing QEMU_TEST_QEMU_BINARY, such
> that we get
> 
>      TAP version 13
>      ok 1 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      ok 2 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_noapic_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      ok 3 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      ok 4 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      ok 5 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector_noapic # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      ok 6 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      ok 7 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_vapic # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
>      1..7

Not sure whether this is the right approach, since a missing 
QEMU_TEST_QEMU_BINARY is a real error, and if we just skip, then the problem 
might go unnoticed if the user does not look closely.

But to ease the situation: We could maybe add some auto-detection logic that 
tries to guess the right qemu-system-$TARGET by looking at the file name of 
the test and/or the test function name? We already encode the target 
architecture in most of these... WDYT?

  Thomas


