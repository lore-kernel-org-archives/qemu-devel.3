Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE8DC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 03:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjsHN-0003BT-DT; Sun, 16 Feb 2025 22:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tjsHH-00036V-Hc
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tjsHF-0006tx-Kt
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739764715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h65WkFi/EmB5cWM2abccwfaf8y3XQxyzMfwJRkQ52g8=;
 b=hMp1xX2CkUgpoumecQJgejQNh/p4t/YqeMCvjAiH0rXCCprrcV/EG+aRuEb1YQproPhix1
 +iHn1UwMjchGNt5GI3LZmrN9CCEGQk4RFe9ugvOtdG9nVui06Z39L9sQburJeMibG+kz7V
 4tUyjDTNuXitkrNwlwTV4JI8Ucg6emw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-LvBUzorWM3WwGrtYH-gLgw-1; Sun, 16 Feb 2025 22:58:34 -0500
X-MC-Unique: LvBUzorWM3WwGrtYH-gLgw-1
X-Mimecast-MFC-AGG-ID: LvBUzorWM3WwGrtYH-gLgw_1739764713
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-220ff7d7b67so42109375ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 19:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739764713; x=1740369513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h65WkFi/EmB5cWM2abccwfaf8y3XQxyzMfwJRkQ52g8=;
 b=SRNhSeUHTz7YxBGI15HOFmJEXILpjEc8xtcTn5blbwUAG1Yk9IBZMEQXbHiR96fHm5
 76fRt44jYOh8069EA3leKA330EmiEM6503k5gNGZr3Kfma9PkhHNzB9HjXmTh9BUZ2CB
 PY7MDr2nj7Gbamj+BBHfqAeQNyF2mB6vjzm/mPZXUu9ZaQZfDYWk3NrhVNQCa5MxChee
 0imzXJ8GXr/9hhPerJ01f1Xq2KhE6GJhsbBJjdW1tptkmhGFVjuKvjVzcVOOy/7kcNHz
 ukYpWVKle+aUBb4kpxqkck1J5MTmMD+O3KHrLkJuKM+umYc6ig6jkpzl5QsxB0YO3nFc
 raLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT2JkSf8tSmetGLPrV9eeY1qVLYZaee0kteKeA7/f6cDwJ/3KZVOWsSGdjA0eQsUiRgBbJ9Fyp4l/L@nongnu.org
X-Gm-Message-State: AOJu0YxQTEq83D7ner4CnhJeSvrfH6XVw0LJBGkKO7JCsaEcSuyfT9q9
 w4Cf+iuOvfHSH00IyRaI5xCCtz2cqLPLL48VwvdEBd3jN3UFPOaO2fgihY/AsO+ahYe+ebV6yOI
 nogssyQSzTVDCLpVtTv+OzFVTjZHc7S5qt2INrjVulXjWFDXNOr88
X-Gm-Gg: ASbGncudx1JMmtLWMOAtZ/lSRAIuFmcJwJcENh83vTucZ92XiYOkl6YiXfVJeA3HRZu
 aZuvqPJO3NB/R4vnvujevhcafatL4NzDUguUPx8HN+k9ORorU83wL6kCCjXrICx43+u7lDOL6Xa
 KGUMP/lbqxwQUaGij2WaMbyYU5B3Hct377HnkMwOYYglAnOvyNjZjGfANdHwwDXrsrkAADodquk
 Xd3an4TOswPNmThr66DigGydYFyCm3PxZ8/a5HQeIFQC36PtmYO3CYuzs471YaJhe20zbCJ9O61
 4GPR5Q==
X-Received: by 2002:a17:903:41c8:b0:216:3466:7414 with SMTP id
 d9443c01a7336-221040bcc46mr148178165ad.44.1739764713103; 
 Sun, 16 Feb 2025 19:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXPGG9VbSx0mBt9A5mZBNedBtCvtMgZisnlvVqkhZwLmNHcqVyalSXglwjB10+MEPyPPqjRw==
X-Received: by 2002:a17:903:41c8:b0:216:3466:7414 with SMTP id
 d9443c01a7336-221040bcc46mr148177885ad.44.1739764712757; 
 Sun, 16 Feb 2025 19:58:32 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d534af3asm61917705ad.44.2025.02.16.19.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 19:58:32 -0800 (PST)
Message-ID: <8a5b8897-0754-41bf-b044-15b85fe155d7@redhat.com>
Date: Mon, 17 Feb 2025 13:58:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Improvement on memory error handling
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214135945.322319cc@foz.lan>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250214135945.322319cc@foz.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/14/25 10:59 PM, Mauro Carvalho Chehab wrote:
> Em Fri, 14 Feb 2025 14:16:31 +1000
> Gavin Shan <gshan@redhat.com> escreveu:
> 
>> Currently, there is only one CPER buffer (entry), meaning only one
>> memory error can be reported. In extreme case, multiple memory errors
>> can be raised on different vCPUs. For example, a singile memory error
>> on a 64KB page of the host can results in 16 memory errors to 4KB
>> pages of the guest.
> 
> There is already a patchset allowing to have multiple CPER entries
> floating around since last year:
> 
> 	https://lore.kernel.org/qemu-devel/cover.1738345063.git.mchehab+huawei@kernel.org/
> 
> I guess it is almost ready for being merged, needing just some
> nitpick changes to satisfy ACPI maintainers. Such changeset already
> adds a second CPER entry for GED, and allows to easily add more as
> needed.
> 

Thanks for the linker, Mauro. As I explained to Jonathan, the bottleneck
isn't the number of CPER entries (single or multiple). The bottleneck
is actually the acknowledgment mechanism. With the mechanism, a single
CPER buffer, which could contain multiple entries, can be delivered
and acknowledged at once. I don't see your series changes anything in
this regard if I don't miss anything.

>> In extreme case, multiple memory errors
>> can be raised on different vCPUs. For example, a singile memory error
>> on a 64KB page of the host can results in 16 memory errors to 4KB
>> pages of the guest.
> 
>> Unfortunately, the virtual machine is simply aborted
>> by multiple concurrent memory errors, as the following call trace shows.
>> A SEA exception is injected to the guest so that the CPER buffer can
>> be claimed if the error is successfully pushed by acpi_ghes_memory_errors(),
>> Otherwise, abort() is triggered to crash the virtual machine.
>>
>>    kvm_vcpu_thread_fn
>>      kvm_cpu_exec
>>        kvm_arch_on_sigbus_vcpu
>>          kvm_cpu_synchronize_state
>>          acpi_ghes_memory_errors         (a)
>>          kvm_inject_arm_sea | abort
>>
>> It's arguably to crash the virtual machine in this case. The better
>> behaviour would be to retry on pushing the memory errors, to keep the
>> virtual machine alive so that the administrator has chance to chime
>> in, for example to dump the important data with luck. This series
>> adds one more parameter to acpi_ghes_memory_errors() so that it will
>> be tried to push the memory error until it succeeds.
> 
> Having a retry buffer might be interesting for some types of errors,
> like error-injected and corrected errors. Yet, it doesn't sound right
> to buffer uncorrected errors that would affect the virtual machine.
> 

The question is how the uncorrected error can be delivered if the previous
corrected error is being delivered and not acknowledged yet? With the
acknowledgement mechanism, all errors are equal in priority when they're
delivered, correct?

Thanks,
Gavin


