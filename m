Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1AAC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNB5u-0008I2-9C; Thu, 05 Jun 2025 09:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNB5s-0008Ho-UJ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNB5q-0004Xn-Us
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749131836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hzwJlPhN1IkmLBR5NQjQjfGm4Y1d+HJXFgR2jlQyObY=;
 b=Si6xmd3FBX/gGDJ2GhHTeGdw7isTgzWgRgTbcvk61+SIP/q5iOYTpjjqrTiXjMnGrdEt/6
 0G4Phk1xZAIQaE2QDMezELwMmygBJTn8jymI8TR2Gw+U4pNz5rnj9vWbsDfhLqMWm6okDA
 3JY8u2Ein2jrZTSvJtCVLqrq6ufbNk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-vT6ZpS4zNIOP6fdM7R5KxQ-1; Thu, 05 Jun 2025 09:57:14 -0400
X-MC-Unique: vT6ZpS4zNIOP6fdM7R5KxQ-1
X-Mimecast-MFC-AGG-ID: vT6ZpS4zNIOP6fdM7R5KxQ_1749131833
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so496864f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 06:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749131833; x=1749736633;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzwJlPhN1IkmLBR5NQjQjfGm4Y1d+HJXFgR2jlQyObY=;
 b=IkqNObjupidJi5U/G5ODtHolZsLA0GyGjC2mmWG2Iw3DYjItwuyouccDV2kudt3MPe
 CXBD6Cf2hp258iUBeIps87Qj1rUqwfO9Jtn1LGyzDhmCTELhbGba8vZacMtq7oijv1TC
 6Y4EuWvmWBdrS0fuc/VM3fQJoXlSpka/8Gm3D7ZZWtcyEe/YGEbgYv9G1SjybsVYowtZ
 ZpNTmZ2cLyQ/luZNWqSRKkBs2PGTaC5GVxEYUgUew7647Lbt3ipxn+nuRAoyzNFUsxZv
 etEtzxUkw2Wn6IEUHYl6K71lMKuCt/QcUnnYizOp2iOtdMh24URmuBOzdZKD7E3efpmJ
 u9Gw==
X-Gm-Message-State: AOJu0Ywl+i7FPVZs5CtqRSKx1oBPePpk7iek4Se4xiXMWvq3tq1EXvUU
 j8YDT2FsrJXl/WRHtI96Je1DFcfkXki/2LaGRRDO7b4G3suS+OTVTlie/9O/M79cqP0aOgHSC4x
 j0+dsiFitvpjl38ZuDwBqhzg0H3VBvtPf42JaUFcN9rI85aC43a3JFJOL
X-Gm-Gg: ASbGncteWAU1x+C1OkDAmC7yV6zJf4svC9qU55lVsPL0NBFxbEdgWSsI8Tfgv+hw55W
 5tqcHxfN8MHXDmgyan7tryjNjQp0fFxANCjU6FpGfJ3OqsV70GJzb7Mgtj20jACvwdAZ00vsZz7
 2ZZahdRNdoi4acyUHVJw5SKbC96b5teD3zKDowO0IpTQNBJFlDl4wwnKIE3W9Y0x6Z7n9JtLAGA
 1fIR+vCuE4NQYw8SK9TBwFWYGYPGwQRNsaW7U7EK6FCWKxruuOEd9FaQETr5MvihKwGMjPIQTFq
 hFUHbAoKKDyFKA==
X-Received: by 2002:a05:6000:4287:b0:3a3:67bb:8f46 with SMTP id
 ffacd0b85a97d-3a51d98072dmr5941824f8f.57.1749131833277; 
 Thu, 05 Jun 2025 06:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7QJAh3XJIR/mYhQxxpFA3is2B8Gn/ETVZIT9sxx+aB0IzR1KYNiGeYIHWTH3iTkTqWg0v5A==
X-Received: by 2002:a05:6000:4287:b0:3a3:67bb:8f46 with SMTP id
 ffacd0b85a97d-3a51d98072dmr5941790f8f.57.1749131832856; 
 Thu, 05 Jun 2025 06:57:12 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe7415asm24790915f8f.57.2025.06.05.06.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 06:57:12 -0700 (PDT)
Message-ID: <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
Date: Thu, 5 Jun 2025 15:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250602222434.GB320269@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/3/25 00:24, Stefan Hajnoczi wrote:
> On Sun, Jun 01, 2025 at 06:12:30PM +0000, Tanish Desai wrote:
>> Moved rarely used (cold) code from the header file to the C file to avoid
>> unnecessary inlining and reduce binary size.
> 
> How much of a binary size reduction do you measure? Most trace events
> are only called once, so the difference in code size is likely to be
> small.

Indeed I don't think there would be much reduction.  I expect a bigger 
benefit in terms of improved register allocation when tracepoints are 
disabled, keeping unused tracepoint code out of the TLB, and the like.

That is, the difference in code size would be in the functions that 
include tracepoints, not in QEMU overall.  That's a bit difficult to 
measure because you would have to isolate tracepoint code in the 
"before" .o files, but we can try.

>> This improves code organization
>> and follows good practices for managing cold paths.
> 
> It's easier to understand the code generator and the generated code when
> each trace event is implemented as a single function in the header file.
> Splitting the trace event up adds complexity. I don't think this is a
> step in the right direction.

I am not sure I agree on that; something like

static inline void trace_smmu_config_cache_inv(uint32_t sid)
{
     if (trace_event_get_state(TRACE_SMMU_CONFIG_CACHE_INV)) {
         _simple__trace_smmu_config_cache_inv(sid);
         _log__trace_smmu_config_cache_inv(sid);
     }
     QEMU_SMMU_CONFIG_CACHE_INV(sid);
     tracepoint(qemu, smmu_config_cache_inv(sid));
}

and one function per backend seems the most readable way to format the 
code in the headers.  I understand that most of the time you'll have 
only one backend enabled, but still the above seems pretty good and 
clarifies the difference between efficient backends like dtrace and UST 
and the others.

This series doesn't go all the way to something like the above, but it 
does go in that direction.

Now, in all honesty the main reason to do this was to allow reusing the 
C code generator when it's Rust code that is using tracepoints; but I do 
believe that these changes make sense on their own, and I didn't want to 
make these a blocker for Rust enablement as well (Tanish has already 
looked into generating Rust code for the simple backend, for example).

Paolo


>> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
>> ---
>>   scripts/tracetool/backend/ftrace.py | 44 +++++++++++++++++++++--------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
>> index baed2ae61c..c9717d7b42 100644
>> --- a/scripts/tracetool/backend/ftrace.py
>> +++ b/scripts/tracetool/backend/ftrace.py
>> @@ -23,6 +23,10 @@
>>   def generate_h_begin(events, group):
>>       out('#include "trace/ftrace.h"',
>>           '')
>> +    for event in events:
>> +        out('void _ftrace_%(api)s(%(args)s);',
>> +            api=event.api(),
>> +            args=event.args)
>>   
>>   
>>   def generate_h(event, group):
>> @@ -30,26 +34,42 @@ def generate_h(event, group):
>>       if len(event.args) > 0:
>>           argnames = ", " + argnames
>>   
>> -    out('    {',
>> +    out('        if (trace_event_get_state(%(event_id)s)) {',
>> +        '           _ftrace_%(api)s(%(args)s);',
>> +        '        }',
>> +        name=event.name,
>> +        args=", ".join(event.args.names()),
>> +        event_id="TRACE_" + event.name.upper(),
>> +        event_lineno=event.lineno,
>> +        event_filename=os.path.relpath(event.filename),
>> +        fmt=event.fmt.rstrip("\n"),
>> +        argnames=argnames,
>> +        api=event.api()
>> +        )
>> +
>> +
>> +def generate_c(event, group):
>> +        argnames = ", ".join(event.args.names())
>> +        if len(event.args) > 0:
>> +            argnames = ", " + argnames
>> +        out('void _ftrace_%(api)s(%(args)s){',
>>           '        char ftrace_buf[MAX_TRACE_STRLEN];',
>>           '        int unused __attribute__ ((unused));',
>>           '        int trlen;',
>> -        '        if (trace_event_get_state(%(event_id)s)) {',
>>           '#line %(event_lineno)d "%(event_filename)s"',
>> -        '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
>> -        '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
>> +        '       trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
>>           '#line %(out_next_lineno)d "%(out_filename)s"',
>> -        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
>> -        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
>> -        '        }',
>> -        '    }',
>> -        name=event.name,
>> -        args=event.args,
>> -        event_id="TRACE_" + event.name.upper(),
>> +        '                       "%(name)s " %(fmt)s "\\n" %(argnames)s);',
>> +        '       trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
>> +        '       unused = write(trace_marker_fd, ftrace_buf, trlen);',
>> +        '}',
>>           event_lineno=event.lineno,
>>           event_filename=os.path.relpath(event.filename),
>> +        name=event.name,
>>           fmt=event.fmt.rstrip("\n"),
>> -        argnames=argnames)
>> +        argnames=argnames,
>> +        api=event.api(),
>> +        args=event.args)
>>   
>>   
>>   def generate_h_backend_dstate(event, group):
>> -- 
>> 2.34.1
>>


