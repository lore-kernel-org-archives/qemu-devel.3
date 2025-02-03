Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1234DC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezdJ-0001W0-L5; Mon, 03 Feb 2025 11:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tezdI-0001VO-Jp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tezdG-0008NT-Ti
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738601348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4VDrKehuLAGI51RmXWgnH+0qzccI0Yp1LPUQsIIE/g=;
 b=NaeS6KYfj3fAey0kSxAK+qpLlqQB8OH5tzzhZNmoBNnipgVoqhL7pDrUZCMYgqkqRqXLzP
 Ie5DC5GSlZT/7zcAppdm6im6QMOJbO9aAbeJkMCRmi4o8rfqAHSCs9XVdaOUkh96MNRHxF
 8LtPsbD8C7YR/A2Zbr6huEoe3w+r3Ec=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-gkB3OKHTPFq-pxR06IE92Q-1; Mon, 03 Feb 2025 11:49:03 -0500
X-MC-Unique: gkB3OKHTPFq-pxR06IE92Q-1
X-Mimecast-MFC-AGG-ID: gkB3OKHTPFq-pxR06IE92Q
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b7477f005eso1057299485a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601343; x=1739206143;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e4VDrKehuLAGI51RmXWgnH+0qzccI0Yp1LPUQsIIE/g=;
 b=R9kYSQ5/tmh5PaPEjpu1T5vPsJo4uavvjCyGM12TqRcsj8Ba8xmcyaSuFMPns8ooRM
 A8w/H4OpIbowoIuxkd1QSJnetkyulU64k0SgvT5MyaH9Hi49SZ1vht4hz6wrIWczKhLE
 VVpybTQC6l3QeXx6gNBy5dUSTuTflqhfGO0tWZiFhbTD6UNJ6ZDnVfUpthvYwUzv/pBb
 igmSw4ZRJmDXqjmD8bJ26WYiB8YBcjYnYMbS7VyAGjD/XpfNmyIsxos0lzyqERpRcjhG
 kYaLvVWPoI/02mkbQwyXJPfZiarl2veNId6YafUV7aggA5MhWSs521TbGETQO1frW1mu
 Gruw==
X-Gm-Message-State: AOJu0YyR+/Txg0T5Ee+mxm8zYZdrvHljvLifjughBqaTIdqxKv8PHmXh
 8RYRrMlHBry58qNFnorTscpKBC/VMXfwBR1lsAGnMzbz3m9/MP5L1+VzwsjJwPNtkY+qiszSnT2
 OVe6NvDTIK9w2x9iZfHlS81tJmjZm7eEQzUnRxpKLnC0j7Lm+JjBF
X-Gm-Gg: ASbGncupr/ii44mRFEZeWJeIxxEQ0FNYfplDIuHM2RqVkhd8jI14JHX2NalJI5gMBMi
 YnotL9YCUygv7U+DBnCu9rCpUZXyAnKko55VFEngJNqNnCHH49zujw6t+btnlVYk9ls+TsYQZxC
 545k0CC64HFF++lsZZWN1iaY72jiyhq1klKoKeoB+fqpaTbUzHVLtYh3Yjo4/hhBofiIjuoA5hn
 Q3D83GWodTONjGkFH4krqkRQUO3q6FYVYPtRta60Wxr1tlI1y93HK3wkx/1BPzGoMn3Zavwq2mY
 JA1btKS3qmBVALwUwf0MOOknyy1+PF2KjDxEHN4po307ahvR
X-Received: by 2002:a05:620a:258b:b0:7b6:dac1:cb73 with SMTP id
 af79cd13be357-7bffcda901cmr3555682885a.56.1738601343253; 
 Mon, 03 Feb 2025 08:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYF6qOEQc0EQFVu6XwmdZ+Ax5tss/o45FHYhuyp14IGLKD52QkWfr5F31hm1a1d4SWAU9kFg==
X-Received: by 2002:a05:620a:258b:b0:7b6:dac1:cb73 with SMTP id
 af79cd13be357-7bffcda901cmr3555676185a.56.1738601342764; 
 Mon, 03 Feb 2025 08:49:02 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d02c9sm544826385a.48.2025.02.03.08.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:49:01 -0800 (PST)
Date: Mon, 3 Feb 2025 11:49:00 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: Re: [PATCH v2 0/7] physmem: teach cpu_memory_rw_debug() to write to
 more memory regions
Message-ID: <Z6DzfFvgXw9AQs8p@x1.local>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jan 24, 2025 at 04:45:25PM +0100, David Hildenbrand wrote:
> This is a follow-up to [1], implementing it by avoiding the use of
> address_space_write_rom() in cpu_memory_rw_debug() completely, and
> teaching address_space_write() about debug access instead, the can also
> write to ROM.
> 
> The goal is to let GDB via cpu_memory_rw_debug() to also properly write to
> MMIO device regions, not just RAM/ROM.
> 
> It's worth noting that other users of address_space_write_rom() are
> left unchanged. Maybe hw/core/loader.c and friends could now be converted
> to to a debug access via address_space_write() instead?
> 
> Survives a basic gitlab CI build/check.
> 
> [1] https://lore.kernel.org/all/20241220195923.314208-1-git@zabka.it/
> 
> v1 -> v2:
> * Split up "physmem: disallow direct access to RAM DEVICE in
>   address_space_write_rom()" into 4 patches
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
> Cc: Stefan Zabka <git@zabka.it>
> 
> David Hildenbrand (7):
>   physmem: factor out memory_region_is_ram_device() check in
>     memory_access_is_direct()
>   physmem: factor out RAM/ROMD check in memory_access_is_direct()
>   physmem: factor out direct access check into
>     memory_region_supports_direct_access()
>   physmem: disallow direct access to RAM DEVICE in
>     address_space_write_rom()

IIUC the last patch will stop using this for debug path anyway, so I'm not
sure whether this one is still needed.  The hope is it's only used to
modify real ROMs?

>   memory: pass MemTxAttrs to memory_access_is_direct()
>   hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
>   physmem: teach cpu_memory_rw_debug() to write to more memory regions

Still, I can't think of anything harmful of patch 4.  So nothing I see
wrong..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


