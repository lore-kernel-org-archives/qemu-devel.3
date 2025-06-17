Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD36C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 21:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRe3m-00040P-JV; Tue, 17 Jun 2025 17:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uRe3i-000409-Og
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 17:41:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uRe3g-0005nD-5K
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 17:41:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-60179d8e65fso11336381a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 14:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750196490; x=1750801290;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+i2r25fv3lZnZ7NcNPYLjqx49EDrS4YcpnaPGt9A58=;
 b=xOLO6AJRfFfRoSPNX7aH9p5R41JPjh0MY3sm+NkQlneIaN+cUOE2pB+HqfbZuGnCHo
 Ho9ILMbZQrV9Q3gbAVlRdc4+m3wK/0+u3+etgKP28NbSv7mSpBA5p4sCLBPzmD/hXsQq
 LGFLp62KxO3mbhR2859jWHtlR17RoHfs/614Tt8PKEUgnm4277gXuFbbnZ6IZwcTh+sX
 +11LIJQ1LlYmKkXKnHGzVaOw8+xOzufVKE0vtg24GlQa02/Yg+YiqVZvNHrwDw/FrZJx
 ilkqk3UAkmvKb7ztjn5Nx/erfJmMD8PUoKew/xvahDZeV0CKIASdZtotOnul7HbREgPi
 sIug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMBV5NbE+AOHiJmwWjJCd/TJz17d3UBlk3oRDN/4JTThF5w02XR5DvZe8kGvlkoEQPycK55s7bclvL@nongnu.org
X-Gm-Message-State: AOJu0YxPPbKMB3hqeEGpdFr4CsIxuQOFKvAx/7XqpDRpycxbIx+OYbvR
 xfMoWoUvAtYTJGpXp/d100tCO45MMAxzZexb/7CYOqIamfIOwSKxStNX
X-Gm-Gg: ASbGnctw/nAG2LUir/kwM6BnNVaWcqhgrJeuLKB0QqoVUOAAN2jyvRpYOzI1w7XvmyT
 kVopWVCJ3rA52wlxk4M2kc6Lyy1DYFjNSjg6gwFV6QBZ9LRn3urvoXrYaW8WAXKfhuIYm4nCYBD
 EbZ2PUcHCBKuGeSJSbIYXN5b7bq3/ClZD4+p+9/0q+/+TK+qdUps1UoPWkARHV7Cg6jVVrQAjhb
 RiBfbrTLIvR1KI+ERUPOxyOPAFV9+kWYs447fcNTLvIs1TthUqXUJ7C++Ml2+KHNd97Cr62YGC3
 xEAPj+/+cYy+QMgbizDE8CuiC/KFkxCwYowiv/nmm7VM6KJ1mdPK1mt8OJ2cHB7goeuvrTFQTyW
 CRejlM2yVHBVDFHXSoWWC
X-Google-Smtp-Source: AGHT+IEHfd9sWBs8ZxcnNpd55qdhfjmD4SNszb/5QsGcAjskeAn8L14d9ycbAFm/lE/0R72urXHqWw==
X-Received: by 2002:a17:907:948e:b0:ad8:8efe:3206 with SMTP id
 a640c23a62f3a-adfad58e7a3mr1439288566b.42.1750196489991; 
 Tue, 17 Jun 2025 14:41:29 -0700 (PDT)
Received: from [192.168.88.252] (78-80-97-102.customers.tmcz.cz.
 [78.80.97.102]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec892e756sm937312166b.144.2025.06.17.14.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 14:41:29 -0700 (PDT)
Message-ID: <6f043380-31c1-4b57-a912-e785af7faae9@ovn.org>
Date: Tue, 17 Jun 2025 23:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH v3 2/2] net/af-xdp: Fix up cleanup path upon failure in
 queue creation
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250604112916.1195368-1-daniel@iogearbox.net>
 <20250604112916.1195368-2-daniel@iogearbox.net>
 <945f230c-052b-43b5-b1c3-b8c450c21327@ovn.org>
 <19099367-8d3d-4697-90e6-306bd133d0d7@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <19099367-8d3d-4697-90e6-306bd133d0d7@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ed1-f66.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.068, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/17/25 3:03 PM, Daniel Borkmann wrote:
> On 6/17/25 1:59 PM, Ilya Maximets wrote:
>> On 6/4/25 1:29 PM, Daniel Borkmann wrote:
>>> While testing, it turned out that upon error in the queue creation loop,
>>> we never trigger the af_xdp_cleanup() handler. This is because we pass
>>> errp instead of a local err pointer into the various AF_XDP setup functions
>>> instead of a scheme like:
>>>
>>>      bool fn(..., Error **errp)
>>>      {
>>>          Error *err = NULL;
>>>
>>>          foo(arg, &err);
>>>          if (err) {
>>>              handle the error...
>>>              error_propagate(errp, err);
>>>              return false;
>>>          }
>>>          ...
>>>      }
>>>
>>> With a conversion into the above format, the af_xdp_cleanup() handler is
>>> called as expected.
>>
>> How exactly this prevents calling the cleanup function?  I don't see the
>> errp being checked anywhere in the qemu_del_net_client() path.
>>
>> Could you provide a more detailed call sequence description where the cleanup
>> is not called?
>>
>> I agree thought that the local err variable is actually unused.  We should
>> be able to just remove it and remove the error_propagate() call as well.
> 
> Ok, I basically manually injected an error in af_xdp_{umem_create,socket_create,
> update_xsk_map} and noticed that in fact none of the af_xdp_cleanup() callback
> was called and qemu was exiting right away.
> 
>  From reading up on the qemu error handling patterns that should be used via
> include/qapi/error.h I noticed that this was due to passing in errp directly
> rather than a local error variable as done in many other places in qemu code.

Hmm, you're right.  I can reproduce this issue.

I think, this fix should be a first patch of the set and it should have
a Fixes tag on it, so it can be backported, if necessary.

> 
>>> Also, making sure the XDP program will be removed does
>>> require to set s->n_queues to i + 1 since the test is nc->queue_index ==
>>> s->n_queues - 1, where nc->queue_index was set to i earlier.
>>
>> The idea behind 'i' instead of 'i + 1' was that if either af_xdp_umem_create()
>> or af_xdp_socket_create() fails, we do not have xdp_flags initialized on the
>> last queue.  And without it we can't remove the program, so we remove it while
>> destroying the last actually configured queue.  And this is OK, because the
>> failed queue was not added to the program, and if the af_xdp_socket_create()
>> fails for the very first queue, then we don't have a program loaded at all.
>>
>> With the new changes in this patch set, we have an extra function that can fail,
>> which is a new af_xdp_update_xsk_map(), and only if this one fails, we need to
>> remove the program while cleaning up the current failed queue, since it was
>> already created and xdp_flags are available.
>>
>> If we get this patch as-is and the af_xdp_socket_create() fails, we will not
>> remove the program, AFAICT.
> 
> I'll double check this concern and see if it can be solved (iirc we do test for
> s->xdp_flags in the cleanup callback)..

Yes, we check 'nc->queue_index == s->n_queues - 1 && s->xdp_flags'.  And if the
last queue doesn't have xdp_flags (because it wasn't fully created), then the
program will not be detached.

But it seems that code is broken anyway even on the current main, because we're
setting n_queues into the last queue that never has xdp_flags on failure.

To fix that we need to do something like:

  uint32_t xdp_flags = 0;

  ...
  for each queue {
    if (failed) {
      s->n_queues = i + 1;
      s->xdp_flags = xdp_flags;
    }
    xdp_flags = s->xdp_flags;
  }

This way we'll have xdp_flags set for the last queue and have a proper queue number
and will be able to call bpf_xdp_detach().

One thing I do not understand is why the program is actually getting removed even
if we do not call bpf_xdp_detach()...  We're not calling this function pretty much
at all, and yet, when qemu fails, there is no program left behind...  It looks like
the program gets automatically detached when we call xsk_socket__delete() for the
last successfully configured queue.  Which is strange, I don't remember it doing
this before.

> in case of xsk map, it should not detach
> anything from an XDP program PoV (given inhibit) but rather it should remove
> prior installed xsk sockets from the xsk map to not leave them around.
> 
> Best,
> Daniel


