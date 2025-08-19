Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB69CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNgI-0003yz-Ae; Tue, 19 Aug 2025 10:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoNgG-0003y8-Mv
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoNgD-0001K0-4y
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755615074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fvaw7HOeG+FvwWqJzI+Qy+PlUUbJEBPbjPouTKjxHvg=;
 b=S/ysJja1td3Vslh0CvX7ZZ1gX28nGw/ffpVRlVepyfYaavI4X5MuttAUVkihn2c8um4KqX
 Bvlmi2eLIDe8vwWGfYsR3QfDy9RRQ9GMs8uIi71TbA7nNTpEHVbfbJtEMPeC5htBChpzXO
 ln29O8csUpRM2oWFB5QcfgErC3kaN4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-AhNAEsvEOEadjFWN7MdkBQ-1; Tue, 19 Aug 2025 10:51:11 -0400
X-MC-Unique: AhNAEsvEOEadjFWN7MdkBQ-1
X-Mimecast-MFC-AGG-ID: AhNAEsvEOEadjFWN7MdkBQ_1755615070
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0b6466so32799245e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615070; x=1756219870;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fvaw7HOeG+FvwWqJzI+Qy+PlUUbJEBPbjPouTKjxHvg=;
 b=jxlngCO2aIVltNLbx8J4AFEcgyIf35WrBaUMmXqt62kCLvznmxKHrRgqO/GLhS+MYL
 +q9NsurodK/CK/x4tMlMXRWpbBM/V1yN+9g1S3V399YBoNyXY0kdwvKpP+KS+np79BGd
 6IWFZ0qRtWe335a3jdJYoV0eaOArxxhaAYlp76whEPlXCw+AbrA+tO/XlnVCqcV+QSxZ
 g7w76MbeBWxzm1xX0OaHQWHdTRAFV1i9o38JZOgH9cibQUtWcpc7Wt194TQX/H27pWDX
 7jNdSoqKAvu+J3tFX6N3J2C9dZ2kYra7zRGZGKU0Tiv8f1APAQFnzayJ3IBzmahiIM0p
 o/1Q==
X-Gm-Message-State: AOJu0YyNAl4VOLXW8QMJOpCgQHXxwZsLwV/XUitRtRoCMEra2gFpEyG4
 vUl61lNmCmTH51QGwqX/5k6ka7JFmzydElPYIpLK9Jgu+XUiLuyN3wrKQANHSGlXmtGOqczSGXJ
 Km3RFNPDM/KdUhR0zphtieKWs3/aEycWI2vo6Ubn5gXXLFI0ltwJY3D9LDH0Qb+Sh
X-Gm-Gg: ASbGncuyumMMt4R581G9zKxLBtmIcvkX+H63NylTsgR2wSP1/id2/OHDTEE0kENW6w+
 M1x3ygORpyha6IKbF2gpWu3UpZt4GYpiw5Xo2jcsg/XMQPdWOareQ78dL/0iD1/xNPyDq+gZsjU
 9qlCuXGWlirDV9G/KkN6dpFWkK0KTxKHevuT8eqoKpOve+k95iGvjJLhXXY1LnCVdzhNneX6Ue8
 aPHyOSrNzA3WGgsF51KOWXBjydx0zKoYDKkMnapf8pVea4xiwJWhDyrCL9J7ICIx7IbxXg9zcgM
 5gpQ9jFV39U7Jr/8UytEYR8elhp5hMTUQumysLOnlXk=
X-Received: by 2002:a05:600c:19d4:b0:456:43d:1198 with SMTP id
 5b1f17b1804b1-45b43e15cc6mr22327755e9.32.1755615070003; 
 Tue, 19 Aug 2025 07:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB5AI8wamevUGAbbZQ3xLXF+0KTzTJwbjG6LJsAObOWTdUcTV0FqC8wbww/rjr+psdKqwdVQ==
X-Received: by 2002:a05:600c:19d4:b0:456:43d:1198 with SMTP id
 5b1f17b1804b1-45b43e15cc6mr22327585e9.32.1755615069538; 
 Tue, 19 Aug 2025 07:51:09 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b42a8fdc1sm43422485e9.19.2025.08.19.07.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 07:51:08 -0700 (PDT)
Message-ID: <ccabd72c-6f48-4be2-8bbd-44f28eb2cfd1@redhat.com>
Date: Tue, 19 Aug 2025 16:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aJOqmxTimJ_mFCqp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/6/25 21:18, Daniel P. Berrangé wrote:
> On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
>> On Wed, Aug 6, 2025 at 2:00 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
>>>> Hi,
>>>> I was unsure if this would be better sent to libvirt or qemu - the
>>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
>>>> behaving differently. I did not want to double post and gladly most of
>>>> the people are on both lists - since the switch in/out of the problem
>>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not yet
>>>> having all the answers, I'm sure I could find more with debugging, but
>>>> I also wanted to report early for your awareness while we are still in
>>>> the RC phase.
>>>>
>>>>
>>>> # Problem
>>>>
>>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 was:
>>>>    error: operation failed: guest CPU doesn't match specification:
>>>> missing features: pdcm
>>>>
>>>> This is behaving the same with libvirt 11.4 or the more recent 11.6.
>>>> But switching back to qemu 10.0 confirmed that this behavior is new
>>>> with qemu 10.1-rc.
>>>
>>>
>>>> Without yet having any hard evidence against them I found a few pdcm
>>>> related commits between 10.0 and 10.1-rc1:
>>>>    7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
>>>>    00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not available
>>>>    e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
>>>> feature_dependencies[] check
>>>>    0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
>>>>
>>>>
>>>> # Caveat
>>>>
>>>> My test environment is in LXD system containers, that gives me issues
>>>> in the power management detection
>>>>    libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS:
>>>> Read-only file system
>>>>    libvirtd[406]: Failed to get host power management capabilities
>>>
>>> That's harmless.
>>
>> Yeah, it always was for me - thanks for confirming.
>>
>>>> And the resulting host-model on a  rather old test server will therefore have:
>>>>    <cpu mode='custom' match='exact' check='full'>
>>>>      <model fallback='forbid'>Haswell-noTSX-IBRS</model>
>>>>      <vendor>Intel</vendor>
>>>>      <feature policy='require' name='vmx'/>
>>>>      <feature policy='disable' name='pdcm'/>
>>>>       ...
>>>>
>>>> But that was fine in the past, and the behavior started to break
>>>> save/restore or migrations just now with the new qemu 10.1-rc.
>>>>
>>>> # Next steps
>>>>
>>>> I'm soon overwhelmed by meetings for the rest of the day, but would be
>>>> curious if one has a suggestion about what to look at next for
>>>> debugging or a theory about what might go wrong. If nothing else comes
>>>> up I'll try to set up a bisect run tomorrow.
>>>
>>> Yeah, git bisect is what I'd start with.
>>
>> Bisect complete, identified this commit
>>
>> commit 00268e00027459abede448662f8794d78eb4b0a4
>> Author: Xiaoyao Li <xiaoyao.li@intel.com>
>> Date:   Tue Mar 4 00:24:50 2025 -0500
>>
>>      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
>>
>>      When user requests PDCM explicitly via "+pdcm" without PMU enabled, emit
>>      a warning to inform the user.
>>
>>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>      Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>      Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li@intel.com
>>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>>   target/i386/cpu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>>
>>
>> Which is odd as it should only add a warning right?
> 
> No, that commit message is misleading.
> 
> IIUC mark_unavailable_features() actively blocks usage of the feature,
> so it is a functional change, not merely a emitting warning.
> 
> It makes me wonder if that commit was actually intended to block the
> feature or not, vs merely warning ?  CC'ing those involved in the
> commit.
We can revert the commit.  I'll send the revert to Stefan and let him 
decide whether to include it in 10.1-rc4 or delay to 10.2 and 10.1.1.

Sorry for the delay in answering (and thanks Daniel for bringing this to 
my attention).

Thanks,

Paolo


