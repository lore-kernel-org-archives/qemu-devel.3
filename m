Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2AFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 17:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ8gp-0006S6-3z; Tue, 24 Dec 2024 12:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8gn-0006Rx-Pv
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8gl-0002G4-NK
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735061241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzbhUhrWNwCvRxgzE/HfE1ydUCglHfpWJioxaIF26Gw=;
 b=Fu5bq3g8tzYIrysH592eypUAMABezCiFOky3yq4syCkYomGt1L60xUDYdBYy6RhVj5eMk8
 kDi//T7QBCtp9uG9eq7AJDT9y1zzKLGoH/QAmAOxz96v6fxNk1e3vgbrEeBCao19wdqg/6
 2kLa7qRhCPhUxcUwhYzZaELt7sSBKds=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-UcPBiSLTNcGx0mfdehjfVw-1; Tue, 24 Dec 2024 12:27:19 -0500
X-MC-Unique: UcPBiSLTNcGx0mfdehjfVw-1
X-Mimecast-MFC-AGG-ID: UcPBiSLTNcGx0mfdehjfVw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6f274f1f9so891619985a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 09:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735061239; x=1735666039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzbhUhrWNwCvRxgzE/HfE1ydUCglHfpWJioxaIF26Gw=;
 b=nzzPIsPREXgN32SehiTcstUrmXEuu0xgcd+w6KumUnHhfclHd31Sjt/OX1TLIRgW6C
 jMCxT5B/uR066Q5JOihse1Fon3Otw5Jy7Q/AgTQ9hMiNnQ5zFcIfDP+jQhA3/cyd/fGy
 gBfMHkWBTDveeWeoc272MM79BRSNtUweLh9Kx1CyJ4DGUDXt5FNZ4FiZAHFRoJEQB6Z/
 pXIscjDMT5QNGyk09XRcL7Aoim8+pU5ZHYa5YMC/DkiUNEejd8hsyjRureCnq83DworK
 qRZ8Z6bPIX8YVAsl7wMeg3CmCcnArJGrATPQQNzfyAk1UKCzaRo7LCjMT7IS/naHtRfB
 7qrA==
X-Gm-Message-State: AOJu0YzCJnr8cR/WY5lMM+S6FkNImmjw8p5U04YHgkpAwN3nV20Mhi71
 FlSk9FdxGT8kqZhgjZfvnYLBTZKyK11kvb+FatLA/3fMkAMq7l7Ivt1i/qJ/Cd+7wyw7mrjQiGE
 V+ecf1HNUiKwjKNfI+4VWySJRDNbNZTsz19QJrd2Od/x953diPBgx
X-Gm-Gg: ASbGncvfmihdy0Vb3ouKFSiuacum+uA554hbef0xsuza4OzVzuz7TYVdSyVTs32vo+6
 2wUIvDxQV2yf6+Am6wsGCUfYF2wllPxbdcZNpqBz22fKhAfP4ehBRoSdNgpSwB8l9IYgHMXfEy+
 7MqfaNRiI0cShkMOjCXIlgCZmpiQI7fAZPoK2skSPgwVU3zw/0MEo6SzIKl880YEhInBHhefs9t
 z+tDxYTR23yU/YvgLHDgvM2rWmr+ltgAzocsOqj0+4D6Cf/xAEeZi2OIh8wJrcaFuqDyRWSkoS3
 P/tfBv7qRnQC8u6Bpg==
X-Received: by 2002:a05:620a:2487:b0:7b6:cedf:1b48 with SMTP id
 af79cd13be357-7b9ba70310cmr2460926685a.3.1735061239389; 
 Tue, 24 Dec 2024 09:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1eCzRRAMj32MbbnWY3YKDUqWJ9tYgWf+PiWFfPfmrq+4f9ddCOMNusVyWQUP8DgGDkEiidA==
X-Received: by 2002:a05:620a:2487:b0:7b6:cedf:1b48 with SMTP id
 af79cd13be357-7b9ba70310cmr2460922785a.3.1735061238990; 
 Tue, 24 Dec 2024 09:27:18 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1760fsm55337801cf.71.2024.12.24.09.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 09:27:18 -0800 (PST)
Date: Tue, 24 Dec 2024 12:27:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 03/23] physmem: fd-based shared memory
Message-ID: <Z2ru86ST5BCoiOhy@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Dec 24, 2024 at 08:16:48AM -0800, Steve Sistare wrote:
> @@ -2079,6 +2100,41 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
>                            RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
>      assert(!host ^ (ram_flags & RAM_PREALLOC));
> +    assert(max_size >= size);
> +
> +#ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */

Yeh relying on POSIX should also be ok..

> +    if (!host) {
> +        if (ram_flags & RAM_SHARED) {

Nitpick: can merge the two "if"s.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


