Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE96CF11F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt2n-0007gW-K7; Thu, 10 Oct 2024 09:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syt2k-0007fs-Qa
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syt2i-0008Mz-J2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728566241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tW61VWT1190yosWqG11QNSDaPixl9Zxqyixjvrrfz3U=;
 b=QIlSJkhUunp534LVHpcS9Clk4sjyWggr3Vn6iP7oG86bgqv6l3AJj7DNo4LFjhtwNcM1EW
 B9kJuvDYfA+NdLKZKoQMclvcrBVrYiIg2zCib0fM985vldSaCxZAu30p5zTMMBD8DMxEMQ
 dYDWSblLfR3hPsFsdeRZCQ8WdlbsEps=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-3mzQajXeMLGoPuXPDj5SMg-1; Thu, 10 Oct 2024 09:17:20 -0400
X-MC-Unique: 3mzQajXeMLGoPuXPDj5SMg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53691cd5a20so766362e87.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 06:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728566239; x=1729171039;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tW61VWT1190yosWqG11QNSDaPixl9Zxqyixjvrrfz3U=;
 b=os3V9zXEwBUQmOFB81/cwj/egOSMKpN0eSnF7gqjoLOIJN3qIlaV4tS/4EbxHWw2QI
 PJx/JBNpqBCMoiA0W5fhVgHgJaK8Kp91x8MRNMRKJU5kmEVAMHvSFyAoq4vOk/PgGDAO
 xh4pgN0o5oE3dQs6fRPkU4q6X4+mi9dd3/7rwU/0dafbxCaj97KqteEHhgMZjoLa8fuX
 CV6KS5XcBSmreMFdqQeRmn+glLrrqdJzxxA9C+utNAIpDnF49A1Xwa+mAxU+tRotnD/V
 5j0EsjR2MIaMCIwOg90GyAkpfarYt44TKQFjd7GThFYiT5fzxXWLf75u83SiAfkl48Lw
 xSRA==
X-Gm-Message-State: AOJu0Yyfrdg0TAfoJDpORxT4EaR7wN5tBrVmQlte7AAy3NZ71Z/uZYW/
 qNjaGdwsQTH8bDKwI0I8Gpirialy0uLJSyZV0nm4vlnlamwqnAAtHbIr/M6GQkcKGSx+Ska3Or7
 zeVjE3HFqE8C1WgHLGuzspB3w8xKH4ktpMniEp/cDdI0Cb/4Cn/Lw
X-Received: by 2002:a05:6512:1281:b0:539:8b49:893e with SMTP id
 2adb3069b0e04-539c4967f89mr4218279e87.38.1728566238587; 
 Thu, 10 Oct 2024 06:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFljLrIMPYNITNfXxdoNMDLVXmnBFchxnTeiHmhRHZUm0FcNwVxbQJqmZlCCv/SI3/hmPb1Sg==
X-Received: by 2002:a05:6512:1281:b0:539:8b49:893e with SMTP id
 2adb3069b0e04-539c4967f89mr4218258e87.38.1728566238121; 
 Thu, 10 Oct 2024 06:17:18 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5c937298cc5sm762640a12.93.2024.10.10.06.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 06:17:17 -0700 (PDT)
Message-ID: <9bd5659c-6066-46f9-a096-10f585f8561e@redhat.com>
Date: Thu, 10 Oct 2024 15:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
To: Chao Gao <chao.gao@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, jmattson@google.com,
 pawan.kumar.gupta@linux.intel.com, jon@nutanix.com, kvm@vger.kernel.org
References: <20240919051011.118309-1-chao.gao@intel.com>
 <ZwY1AeJPlrniISB1@intel.com> <ZwY69phzk3GpGvsh@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZwY69phzk3GpGvsh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/9/24 10:12, Chao Gao wrote:
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 85ef7452c0..18ba958f46 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>>       [FEAT_7_2_EDX] = {
>>>           .type = CPUID_FEATURE_WORD,
>>>           .feat_names = {
>>> -            NULL, NULL, NULL, NULL,
>>> -            NULL, "mcdt-no", NULL, NULL,
>>> +            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
>>> +            "bhi-ctrl", "mcdt-no", NULL, NULL,
>>
>> IIUC, these bits depend on "spec-ctrl", which indicates the presence of
>> IA32_SPEC_CTRL.
>>
>> Then I think we'd better add dependencies in feature_dependencies[].
> 
> (+ kvm mailing list)
> 
> Thanks for pointing that out. It seems that any of these bits imply the
> presence of IA32_SPEC_CTRL. According to SDM vol4, chapter 2, table 2.2,
> the 'Comment' column for the IA32_SPEC_CTRL MSR states:
> 
>    If any one of the enumeration conditions for defined bit field positions holds.
> 
> So, it might be more appropriate to fix KVM's handling of the
> IA32_SPEC_CTRL MSR (i.e., guest_has_spec_ctrl_msr()).
> 
> what do you think?

You're right, the spec-ctrl CPUID feature covers the IBRS bit of 
MSR_IA32_SPEC_CTRL and also the IBPB feature of MSR_IA32_PRED_CMD.  It 
does not specify the existence of MSR_IA32_SPEC_CTRL.

In practice it's probably not a good idea to omit spec-ctrl when passing 
other features to the guest that cover that MSR; but the specification 
says it's fine.

Paolo


