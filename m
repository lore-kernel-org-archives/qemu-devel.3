Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F30C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKCe-0007jW-J3; Tue, 04 Feb 2025 09:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfKCO-0007hH-NW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfKCJ-0005Gy-Dw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738680400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++kN6Fekww5w0N6JZf7kMT7JmISFlzuwH3O3FibrCjU=;
 b=hjrhCJfqKnDUn3UHTuk6dau+OkuJ2uNW2DNm2k/aiVvDEIs+rsxY3FvPANyBc4U1HsDSqq
 shq6rAVn3APS6a3GbpYkmP/A11auna+Uq6OBBzdeivTNAmIWm3+hDaUBNsxgSJaKtULDTQ
 11ZV+a4oqIX4+jUzmpWuEzgOtgM+Ygo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-G-EEKzMwOZSXwxqvmbNVog-1; Tue, 04 Feb 2025 09:46:38 -0500
X-MC-Unique: G-EEKzMwOZSXwxqvmbNVog-1
X-Mimecast-MFC-AGG-ID: G-EEKzMwOZSXwxqvmbNVog
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c034838f38so87201785a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680398; x=1739285198;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=++kN6Fekww5w0N6JZf7kMT7JmISFlzuwH3O3FibrCjU=;
 b=UcSVs5WcifTLGszmTIsKzZV4bvaPtgqo/TUGT9PYFCQa7X4EiopPc5hCUQPOjiDGzp
 /bbU3vUn2TushqMOrXEU/tvzyrZr2deMIUWtnO1yGK3HQ+LMSUitq7oFHxdDuCXOVMJ4
 L+d2RXE1WdnXEoJfiNAu5Sa4Fs7KpP6nizDKCZcrKViQ/3HIPdAcSgwLTfduujS1yUI2
 OmyWxnM3IcrGa9CeJq/qDPZIiCk1aQN1tSr8qxX4IHOogP7JU0I/sj9uB0PZfYwmXbLC
 98R0UbVba+zinKIkIydvz3fEYTRURlZE5jFpkYI5qqwEtqPSSwOLdQQFwhmPBBuBq+Cs
 QIwA==
X-Gm-Message-State: AOJu0YxSzSs9G76N/85v6/6FbOAsASh0WdmSM/5uX8zS2x/3rsUNmIzi
 FMdfOOISOl8FB5wLu/4k7qM9Nqdx08MzcW8dAj0hycZqBhjLVbX7nMVwCTMhDIOlALqUEe9jzLl
 VDTYQL378a2jtpOODQjKw80bZrpcwX84LCccqW6m001MGvDQB85Mq
X-Gm-Gg: ASbGncsZ7tu6EUzkZnz6bF5Vewx2qulNYSXYbFkHsyrXlxD8Ox7Km085wj5Vl44QeBU
 KqlNBniENpYhrlt42yt1DA1ay18o/zdJaL2taN7dCfvtODRrqTqOKPzg2skordLg1TH7x1Cs+Wa
 kG9IfKvSl7WinPmi9PGMEFx/9n3WLYYMvFJql1OG872tXhU6qTmacX2WfscTci8pOShmtsjb9Hl
 HTdxGNscdPHgBHr8ydTEXABP5TDWdlgR4bCGLrHnDNCzdXZCMKueAxVb+Sr0QiBq222ODXCzDOt
 f8mWa7Kduv0Tj1JJOnNDFSAK7VryOHvnm4WVgrJp+wvLCitp
X-Received: by 2002:a05:620a:404f:b0:7b7:5d6:37fa with SMTP id
 af79cd13be357-7bffcd92940mr3768428785a.41.1738680398090; 
 Tue, 04 Feb 2025 06:46:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWOiVazuMDypTQNM71mrxoM6jcV8sJtm1FO6AnfSi4XUNTldHrdOAIkTs6ARdar/DWgmMk8Q==
X-Received: by 2002:a05:620a:404f:b0:7b7:5d6:37fa with SMTP id
 af79cd13be357-7bffcd92940mr3768423585a.41.1738680397706; 
 Tue, 04 Feb 2025 06:46:37 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a904810sm640362485a.66.2025.02.04.06.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:46:37 -0800 (PST)
Date: Tue, 4 Feb 2025 09:46:35 -0500
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
Message-ID: <Z6IoS9DWj24oZhRV@x1.local>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>   memory: pass MemTxAttrs to memory_access_is_direct()
>   hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
>   physmem: teach cpu_memory_rw_debug() to write to more memory regions

David, I think it doesn't apply on master, would you rebase and repost?

Stefan, it'll always be good to get an ack from you to show this at least
works for you - I'd expect that but an explicit email or Tested-by at the
last patch would be great (either this or a new version).

Thanks,

-- 
Peter Xu


