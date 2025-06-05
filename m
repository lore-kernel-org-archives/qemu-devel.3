Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF84C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFes-0002OK-Lt; Thu, 05 Jun 2025 14:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNFeq-0002OB-Fg
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNFeo-0007GZ-SY
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749149382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LcDjCuchAqq5X6aqz2CQ/wPBKFgtTpRw6OhF/ul9ubU=;
 b=Pm2HUja7JJfSt6QBRwJ/dtcwbGpXWERnGkeUrHX4F5z7YTI5+g+YScM/XlXtEAOPzpN6zJ
 fxvke5GzCapXQ9r8jlEe6xnMYa/iPu0sh7DPk+jzt2CXVOH3ORpYugVuwPbop1VAfNEV3R
 de+3HNk6YFzUhqA9TcoXEW3O98W/FhY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Om1xVDANMzemG-DRBUKTJg-1; Thu, 05 Jun 2025 14:49:40 -0400
X-MC-Unique: Om1xVDANMzemG-DRBUKTJg-1
X-Mimecast-MFC-AGG-ID: Om1xVDANMzemG-DRBUKTJg_1749149379
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d290d542so8638545e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 11:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749149379; x=1749754179;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LcDjCuchAqq5X6aqz2CQ/wPBKFgtTpRw6OhF/ul9ubU=;
 b=fCn14zQ+FObbjdqVGvK/tl3FQYIjBJZXOMfDNjG3cVpk/OjMZpYHs+6YeCJdBdevEX
 ArqgeC9VpeZ6e9NgzEL7CIpeI2jmW2xPkULhSOAw3VMqQaPjxemF2bOKpL9TCvWicT4m
 PY/fVCOrnLvwNG78Va42+nnG/AolZYu93rXo6rrNOLlrkRzX9qpPEHhyOZBLDxJXp02G
 3MygNVA71dsbmSwZIHipw7TfGkIH45f4nd6xKE0W0dIza0mPjpfVoLAMlLtxACF/YZIS
 Q5czjY9O+iFKheXJaUn4Rx6I+QSIBEnDLK/7m4hb+OweNmr50dsFm7YlXg2B3++8nBcy
 YX1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCViO1PAsnK14KfSBpf04t3+RjPUeMFhL3gSWDhU2mknjsGkB3zIT/5haZNnY15QGsu6Yd+5O6eILb+a@nongnu.org
X-Gm-Message-State: AOJu0YzshF1hPqmkQfQHkij5DZRyof315aEC1xJD9wJcd2X9jGkVLVjy
 7KNEsCAp9LooohUIcMHh4ldF9wFJmdJrtXYWW/G4HMASzzgRjXVonOHfjWgU21obTG6Yct88TuF
 Jvt5SUveZpcsH+pR1lcBcpud7fO55swkBHhp3DdzIp2soRo4flO+MljEm
X-Gm-Gg: ASbGncu4nA4y5MCKglyBINDh+vp3bcDbaw6TXubjRoaXA0OT0jSvRaJoSZIvLDcaZCE
 G6uiot6DJEw2FAxsAt9VP1YS2DQNxopUrjcA1pploVnjb5ijo8UD58s/JVdjJdspBCcinKZMuim
 /6SgJ9AcWzpAWyl9LUpNwrbLZgeNzI6qWYQeV1Ao4hfvPS5uWa2nWBRhClVlm1j8+FsgDGlkdkr
 JH1hQxhXzYgrRKWFBbablS+DHe3UqvWfk4t/1Al1M60OIV1JhWEN1bkwxid2KGW3aQMfTtKs9Sb
 QllACsrK/a+Xtg==
X-Received: by 2002:a05:600c:6089:b0:450:cc80:e594 with SMTP id
 5b1f17b1804b1-452014b6777mr3768435e9.26.1749149378600; 
 Thu, 05 Jun 2025 11:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIk8m8l7CpEk/2sILRIa+4J0ONx48afAsApp/bLyrciJIDyqpqxamcXvz53pmmp1L7UPsCpA==
X-Received: by 2002:a05:600c:6089:b0:450:cc80:e594 with SMTP id
 5b1f17b1804b1-452014b6777mr3768245e9.26.1749149378202; 
 Thu, 05 Jun 2025 11:49:38 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45209d0bff7sm1487605e9.23.2025.06.05.11.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 11:49:37 -0700 (PDT)
Message-ID: <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
Date: Thu, 5 Jun 2025 20:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
 <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
 <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 6/5/25 20:37, Stefan Hajnoczi wrote:
> On Thu, Jun 5, 2025 at 9:57 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> It's easier to understand the code generator and the generated code when
>>> each trace event is implemented as a single function in the header file.
>>> Splitting the trace event up adds complexity. I don't think this is a
>>> step in the right direction.
>>
>> I am not sure I agree on that; something like
>>
>> static inline void trace_smmu_config_cache_inv(uint32_t sid)
>> {
>>       if (trace_event_get_state(TRACE_SMMU_CONFIG_CACHE_INV)) {
>>           _simple__trace_smmu_config_cache_inv(sid);
>>           _log__trace_smmu_config_cache_inv(sid);
>>       }
>>       QEMU_SMMU_CONFIG_CACHE_INV(sid);
>>       tracepoint(qemu, smmu_config_cache_inv(sid));
>> }
>>
>> and one function per backend seems the most readable way to format the
>> code in the headers.  I understand that most of the time you'll have
>> only one backend enabled, but still the above seems pretty good and
>> clarifies the difference between efficient backends like dtrace and UST
>> and the others.
>>
>> This series doesn't go all the way to something like the above, but it
>> does go in that direction.
> 
> It's nice to share a single trace_event_get_state() conditional
> between all backends that use it. There is no need to move the
> generated code from .h into a .c file to achieve this though.

Ok, I see what you mean.  Personally I like that the backend code is 
completely out of sight and you only have a single line of code per 
backend; but it's a matter of taste I guess.

> In the absence of performance data this patch series seems like
> premature optimization and code churn to me.
> 
>> Now, in all honesty the main reason to do this was to allow reusing the
>> C code generator when it's Rust code that is using tracepoints; but I do
>> believe that these changes make sense on their own, and I didn't want to
>> make these a blocker for Rust enablement as well (Tanish has already
>> looked into generating Rust code for the simple backend, for example).
> 
> How is this patch series related to Rust tracing? If generated code
> needs to be restructured so Rust can call it, then that's a strong
> justification.
Well, moving code to the .c file would make it possible to call it in 
Rust without duplicating code generation for the various backends (other 
than the "if" and function calls, of course, but those are easy). 
However, this is only handy and not absolutely necessary for the Rust 
tracing project.

If you disagree with this change we can certainly live without them---I 
asked Tanish to start with this as an exercise to get familiar with 
tracetool, and he's learnt a bunch of things around git anyway so it's 
all good.

We'll also try to take a look at the code that is generated in the 
function that invokes the tracepoint, to see if it's improved.

Paolo


