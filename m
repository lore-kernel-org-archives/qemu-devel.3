Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA11C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 06:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulLkT-0005Op-LX; Mon, 11 Aug 2025 02:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulLkC-0005LH-HO
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 02:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulLk7-0003DZ-9M
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 02:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754892640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Z3EAS2A83uvtKwwu+GxpjlAvXfbxMmvjEpZS7nk+2s=;
 b=PVRnLo0gOsLlyXyMCsv+TwONQIUNKmCmFss3fkZuXfaWe/biKmiyQhbMLRU1ACL337fEhq
 S2q5OWByWeV7BYeNLhNfBaJ5bzPe37d3vtxABAd+nlkKAtJ5xJsUzxK5+GXwvA1zDrbPV/
 ndSqMhQMEAp5EAZEJZgtXiqYhwVGP5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-UdeGYUA9OB2wxrrnmA4AGw-1; Mon, 11 Aug 2025 02:10:37 -0400
X-MC-Unique: UdeGYUA9OB2wxrrnmA4AGw-1
X-Mimecast-MFC-AGG-ID: UdeGYUA9OB2wxrrnmA4AGw_1754892636
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-459e0f54c88so23144175e9.1
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 23:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754892636; x=1755497436;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Z3EAS2A83uvtKwwu+GxpjlAvXfbxMmvjEpZS7nk+2s=;
 b=Da0BXeUmnULT6ZurK9Bu7NTdPPb1eCHvXZVgBI8W54ntVxifHjUaAPQHlV9lrgMsdL
 2Gx08CWg0pJsLGEU9GGAB75bmWYp3hJQU+WZl/pRM5u6X3eT73efLs3KG2bRCyvaIz/1
 fgAXXLfnFaAVBUmjuQ7p/6u+vXr3FDdm8dTHkoMeWHxqVRqZqd4uEoQVr/53YTQC5qrq
 UMMT20vFblrSjIAhvlzEq89gWdKUGkEhbDrqye16chYilL5etheHLHGvMOEgQ/vkLAZe
 ZfuAWnanDCUYgZ8F1SkpWTRK3EWqRtT1z28R17lek/bnAwiL+f/124jpMxi2Rqa4WpJ1
 masQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC8QXF7LdI9ak9fIrXr/NPAWf7kLmXKC5zyyZbmv3lb6CNvJqrXRD/NvDyfITpMmfJzoYd/MIcIz9C@nongnu.org
X-Gm-Message-State: AOJu0Yxn7ocImjcmSmx3ySwb7RIqxg6GvrkcJywq6FWLByoCWanyOsG2
 s6hFAixLOR7c+MXilk61ClHP7ktPQy/RRA6vxnMDsjUo8qlXU5vLxhrkBGEspKFbRThYD7E9Ew+
 uhKjjvoxFvnTrEQtBmNlYY33l5C+ii127ac+W04hGcPuIG3qocpPGOpZD
X-Gm-Gg: ASbGncsChFpYwQ3JEgfLDBKmkOP6Qh6B2YKUwPjG0B6NdxwZkF1LihAMkX2z4Aam6Em
 iDbATKfG5DPn3e6z7j3b+DxR2JlLUlvvXD9AAiReSfOSN5BsbME3rgCDZdleSNkX9iaypCJCKiJ
 fN5O7V78GDyhes2L5aTRifWKBAn8K8p7ebTyRP2O+cMtbzeU2vuIp6KMPLwChwV3CDbwGeQCgNl
 Dm7RG7Ilj4orBqEwLbdt3O9TI1wxgKAQGISxBG2GpWjuzA0fLncIJlsFv8b6cO/Ck/TF27BmvwF
 Ag0LCDSPMgBitkfyeOfASS6WmEe+ttuzwyfp9a/YgyeH
X-Received: by 2002:a05:600c:3149:b0:456:189e:223a with SMTP id
 5b1f17b1804b1-459f51f361dmr103823115e9.10.1754892635809; 
 Sun, 10 Aug 2025 23:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf0kaMf/ZQbPCQ4d5szppyI5q7b4T42FDiK0zx/YVl0YjNkTFCSdqRyZ+VE36WVvWoN7qcTA==
X-Received: by 2002:a05:600c:3149:b0:456:189e:223a with SMTP id
 5b1f17b1804b1-459f51f361dmr103822905e9.10.1754892635402; 
 Sun, 10 Aug 2025 23:10:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c46ee84sm38339075f8f.57.2025.08.10.23.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Aug 2025 23:10:34 -0700 (PDT)
Message-ID: <78ceb108-670b-4be6-9d74-4521c0b6d872@redhat.com>
Date: Mon, 11 Aug 2025 08:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-5-pbonzini@redhat.com>
 <d7923560-58b8-4967-ae2b-2cabf5dfea7d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <d7923560-58b8-4967-ae2b-2cabf5dfea7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/10/25 01:26, Richard Henderson wrote:
> On 8/9/25 04:59, Paolo Bonzini wrote:
>> +void tcg_kick_vcpu_thread(CPUState *cpu)
>> +{
>> +    /*
>> +     * Ensure cpu_exec will see the reason why the exit request was set.
>> +     * FIXME: this is not always needed.  Other accelerators instead
>> +     * read interrupt_request and set exit_request on demand from the
>> +     * CPU thread; see kvm_arch_pre_run() for example.
>> +     */
>> +    qatomic_store_release(&cpu->exit_request, 1);
>> +
>> +    /* Ensure cpu_exec will see the exit request after TCG has 
>> exited.  */
>> +    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
>> +}
> 
> So, now both cpu_exit and cpu_kick set exit_request.
> 
> You ifdef this out again for user-only in patch 7, but this does suggest 
> that kick and exit are essentially interchangeable.  You rearrange 
> things a bit in patch 6, but it's still not clear to me what the 
> difference between the two should be.  There's certainly nothing at all 
> in include/hw/core/cpu.h to differentiate them.
> 
> Should we instead eliminate one of kick or exit, unifying the paths?
In cpu-exec.c terms, qemu_cpu_kick() *should* go out to 
cpu_handle_interrupt() whereas cpu_exit() *should* go out to 
cpu_handle_exception().  The difference matters for some accelerators 
where qemu_cpu_kick() tries not to take the BQL in the vCPU thread.

Until now TCG's implementation of kick_vcpu_thread set both exit_request 
and interrupt_request, and I'm not changing that yet for system 
emulation.  Patch 7 does that for user-mode emulation, because it's 
trivial: neither linux-user not bsd-user use qemu_cpu_kick() directly.

Paolo


