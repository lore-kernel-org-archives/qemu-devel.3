Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF2DCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jh3-0002hx-4q; Wed, 24 Sep 2025 03:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Jgx-0002gp-5d
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Jgt-0002q0-Dx
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758698004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g4oJluTktRG5ExCsaTWSY16WNKCNXMAnB/5c/fkUs24=;
 b=cUQiXKKYsM78CLSzmW5wVFyWQF7S/AXXWLu+xuI8I1AiO4QHVXHhBzU+NCXCRGg1LVzLmC
 Rx5RNBSmUnwa07sQ/ff1odx+FwvgHPIk75spivizW6LZPFwQ/FitFP3MauDIZ2Xz8vRZRy
 7eNjgG3nAQp5X++pnHR1rQanZhIWBt8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-zdcRAp8dMaeFAhk4fkp6vw-1; Wed, 24 Sep 2025 03:13:23 -0400
X-MC-Unique: zdcRAp8dMaeFAhk4fkp6vw-1
X-Mimecast-MFC-AGG-ID: zdcRAp8dMaeFAhk4fkp6vw_1758698002
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2e74dd6b42so219366666b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 00:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758698002; x=1759302802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4oJluTktRG5ExCsaTWSY16WNKCNXMAnB/5c/fkUs24=;
 b=bk5jkMFDAJLW6MACoK+q7ridZZnKURw1IO8xZzEakS4QllPwyNfbFois+9lKhjjymJ
 DvKu7H0zZltJ9ROI3Mb5SLI/2otSC80UTpCn2+O2k9YBOQDBz8P2xFCyjLwJ1jXQlevy
 SbmkGaytxJbFFnOyfKGDBTbDkelO2k35e7CHiL7exGCq8gwZtFcujKnr2/cLta/jeAJM
 BBWOBtvRO8KFIBMY2w6KaqgNv1BV/JkjVyItZG+J+nsmdn2c7yRPj6GOAZiaZ1c8p1sl
 Cm8AK1oD+beesJ/Pskta2dOkm+cOXlRXPPiSkzPKRSzDiBcRamyCqD7gxjF7nTUWWG0H
 QsKQ==
X-Gm-Message-State: AOJu0Yy8CYZfFI9kN5RFIrBv9StS2ivPjJnmk0Ye2dIXtHRPBE8qkw/k
 iJz2af8uJFwxpMjb5OQ5BejgNBIB2ZOiGBSRy+K40u4FhxxKmAqbqlGShI7if+xSOeNpuPO5y2p
 d0MRem1uS/BBXj82qHgoxR42/cPxhMmINYYM9mx+byJ56ETkHrfNX3Co3
X-Gm-Gg: ASbGncu7sDJHcniVRO7t6q1GMOxM1+mxTVttsZUwX7tXxHjBt6WhAbzVkBCNQ8LD350
 d393gInJeSa2QLIfiUqFNV0/8laH5uiJuQQZlD2vf/W5xMZ+C8cbgvNmjMzwE++1KA/04s9G9QT
 qBDy9Tw/oJWdBJBdUagHcLgEaugss/ClsI+n0rmtHZfHCuv7+mdXjfHwCwQ8J2Th6B7nkhyqxk4
 gRWAct8J6TN2FlOnU/JGTBfdcRRaSK/NMoOjFZqulNAnGDab7I5rrqWNGAbZsILvPwlB7QPIEBw
 +Gv5EcLKcTh09UZ2HU0HEPHwtBIleExb65gnWFaGo42woO2DCzAu4sLkR2RNH2ftN5BSpXGN8as
 +UHbCIYQuxdVuB3JvZNBuoeJ1OaoQ5oqsc3dV8StpC6fuOQ==
X-Received: by 2002:a17:907:9713:b0:b07:88ef:fe1a with SMTP id
 a640c23a62f3a-b302a1752f3mr593292566b.40.1758698002192; 
 Wed, 24 Sep 2025 00:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECYGfprolQDglqha4raChAyrDQ3gKEgbdViccdp9kDOLGjD3eksTBS6hRiHATqe+IV/r47rQ==
X-Received: by 2002:a17:907:9713:b0:b07:88ef:fe1a with SMTP id
 a640c23a62f3a-b302a1752f3mr593271266b.40.1758697997484; 
 Wed, 24 Sep 2025 00:13:17 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b2cdbd3f7d4sm612072066b.71.2025.09.24.00.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 00:13:16 -0700 (PDT)
Message-ID: <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
Date: Wed, 24 Sep 2025 09:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250923192354.GL509965@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/23/25 21:23, Stefan Hajnoczi wrote:
>> +    out('// SPDX-License-Identifier: GPL-2.0-or-later',
>> +        '// This file is @generated by tracetool, do not edit.',
>> +        '',
>> +        '#[allow(unused_imports)]',
>> +        'use std::ffi::c_char;',
>> +        '#[allow(unused_imports)]',
>> +        'use util::bindings;',
>> +        '',
>> +        '#[inline(always)]',
>> +        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {',
>> +        '    unsafe { (trace_events_enabled_count != 0) && (_id != 0) }',
>> +        '}',
> 
> This was translated to Rust from:
> 
>    /* it's on fast path, avoid consistency checks (asserts) */
>    #define trace_event_get_state_dynamic_by_id(id) \
>        (unlikely(trace_events_enabled_count) && _ ## id ## _DSTATE)
> 
> The _id != 0 expression is incorrect. The purpose was to check whether
> the trace event is currently enabled (i.e. dynamically at runtime).

The expression is correct, but the function and argument names are not. 
It should be

fn trace_event_state_is_enabled(dstate: u16) -> bool {
      unsafe { trace_events_enabled_count } != 0 && dstate != 0
}

>> +    # static state
>> +    for e in events:
>> +        if 'disable' in e.properties:
>> +            enabled = "false"
>> +        else:
>> +            enabled = "true"
> 
> What is the purpose of this loop? The variable enabled is unused so I
> think it can be deleted.

The Rust code generator is not emitting any code for disabled 
tracepoints.  Unlike C, where the disabled tracepoints can produce e.g. 
-Wformat warnings, there's no real benefit here.

In the RFC the "enabled" variable was used to produce a const for the 
static state; it had no user so I removed it, but I left behind this 
dead Python code.  Sorry about that!

Paolo


