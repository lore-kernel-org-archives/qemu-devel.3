Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3F2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzzL-0003id-12; Tue, 28 May 2024 12:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBzzJ-0003iU-UV
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBzzI-0005lf-0V
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716914867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84UoxmggTbzs7ihJQSQF1fHWhiXOJXZfJPIKFBbmNW4=;
 b=G/Br3D9EIylY5fyso6BCKdF72FQ1l4EJvQ5j/0JK+LThvjqmSrefE3kkKho7d5W1fL+lyG
 XQjo+wun9pPiqLsQJlkFLgZtEw+d/t6ZLq/S9Qzsh+3fB3CTl3VV6dN8PxTkHsZBTfvCS9
 6lz7rKQVhaJhQytv1SMTq4y/Kb/9o+g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149--Ujh5mCQO9S6qBPCLidNVg-1; Tue, 28 May 2024 12:47:45 -0400
X-MC-Unique: -Ujh5mCQO9S6qBPCLidNVg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so88800666b.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716914864; x=1717519664;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84UoxmggTbzs7ihJQSQF1fHWhiXOJXZfJPIKFBbmNW4=;
 b=VmsRhh7yb38DiIiF/SQEfRgRo1HYaB+w6+X5X5Yo9DpVYBeTrV8XZCB2+8PIIaaIfP
 qj2/UjBs15NEA3Syu91zMdnxKe0JpYTAx5iKDUDny9JFgPJwIkqRra6YWHc3r6jm6u5o
 P8b3OAbabPM3Kd9ULrHHHamgAS34sgqJ0wXnnPSvuqEc9l3B7FmbmO/9nPoxxEkV9RUG
 oFPKbbd1VeqDT7aZtoR/OBEQgl4AFPnJ39mwiOPLUSMtVfa+0LkPY2awPueHi6k1Tf/y
 hc/CO5cgpEyN67t5bNX9CBuWT60ASvR8AoVthcww67FOu9B5pKl1kIUWuvFLkp4FFFJC
 8rFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlDaeehpsBTSWPnnrMTwj1T4Gw4CC2JymlKhxdTo1hg9L7hdp9EOEJX+0aw5PCrFkFpVz8bjuX/qmB3bJ9hMkf3DQUm5o=
X-Gm-Message-State: AOJu0YxVd3r/smfspYxK3u0b3Xfa2XAgQK0V0M/f+c/Mw8hyMGW3R2YN
 TBPzUZkqZuR/h1Lsnhm/AynbSXq7nNhK6whuiqbte/9RoPFVO/aLj9E4+B/9RiATrBM20z8zrAQ
 4IOvdtdLXp98k0cBlgmbsiWJM0Fvy9ckuSft20jIZ86cpn9sOzSXh
X-Received: by 2002:a17:906:a18a:b0:a5a:5b1a:e2e4 with SMTP id
 a640c23a62f3a-a62620a8785mr986929866b.20.1716914864603; 
 Tue, 28 May 2024 09:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr93J+kSevJwpYShhqz8KzeJhbirw25hv9Mk9kOCr6lJfj3dOCCO+g2i9yGDFy23CE3uz3TQ==
X-Received: by 2002:a17:906:a18a:b0:a5a:5b1a:e2e4 with SMTP id
 a640c23a62f3a-a62620a8785mr986927966b.20.1716914864199; 
 Tue, 28 May 2024 09:47:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e?
 (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de.
 [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda7cd3sm627255166b.216.2024.05.28.09.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 09:47:43 -0700 (PDT)
Message-ID: <57fabde4-3282-4d10-aaa6-e14c2169d893@redhat.com>
Date: Tue, 28 May 2024 18:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] backends/hostmem: Round up memory size for
 qemu_madvise() and mbind()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1716912651.git.mprivozn@redhat.com>
 <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 28.05.24 um 18:15 schrieb Michal Privoznik:
> ./build/qemu-system-x86_64 \ -m size=8389632k,slots=16,maxmem=25600000k \ 
> -object 
> '{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"hugepages2M","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \ -numa node,nodeid=0,cpus=0,memdev=ram-node0

For DIMMs and friends we now (again) enforce that the size must be aligned to 
the page size:

commit 540a1abbf0b243e4cfb4333c5d30a041f7080ba4
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Jan 17 14:55:54 2024 +0100

     memory-device: reintroduce memory region size check

     We used to check that the memory region size is multiples of the overall
     requested address alignment for the device memory address.

     We removed that check, because there are cases (i.e., hv-balloon) where
     devices unconditionally request an address alignment that has a very large
     alignment (i.e., 32 GiB), but the actual memory device size might not be
     multiples of that alignment.

     However, this change:

     (a) allows for some practically impossible DIMM sizes, like "1GB+1 byte".
     (b) allows for DIMMs that partially cover hugetlb pages, previously
         reported in [1].
...

Partial hugetlb pages do not particularly make sense; wasting memory. Do we 
expect people to actually ave working setup that we might break when disallowing 
such configurations? Or would we actually help them identify that something 
non-sensical is happening?

When using memory-backend-memfd, we already do get a proper error:

  ./build/qemu-system-x86_64 -m 2047m -object 
memory-backend-memfd,id=ram-node0,hugetlb=on,size=2047m,reserve=off -numa 
node,nodeid=0,cpus=0,memdev=ram-node0 -S
qemu-system-x86_64: failed to resize memfd to 2146435072: Invalid argument

So this only applies to memory-backend-file, where we maybe should fail in a 
similar way?

-- 
Thanks,

David / dhildenb


