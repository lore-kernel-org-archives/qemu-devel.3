Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4586C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 12:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdTFV-00059V-GD; Thu, 30 Jan 2025 07:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tdTFS-00057x-4m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 07:02:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tdTFQ-0006OP-Bp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 07:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738238535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tthXxwJ9fuw9xyqBmp8bg2z2kCO9zZkxXy5p5fv+zVY=;
 b=Y8zVpE/1fJYdxrIUCQDXxw+K+syUL8ZFdEZtUmo4FReolSXNUUBgMo2uIiVssvafFeZTA4
 CNXcI9mCzVS62PtVcE8PT8bZiODMOsixf6xpSfVDZh/uTNXb9AJnaLVBu0Ow6eMZcQ7C9f
 xj+VKQq0vHwem6OZ5NrHMFeFG+8CwsE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-3EnwW6vdP62z7E7Fzb3mNA-1; Thu, 30 Jan 2025 07:02:12 -0500
X-MC-Unique: 3EnwW6vdP62z7E7Fzb3mNA-1
X-Mimecast-MFC-AGG-ID: 3EnwW6vdP62z7E7Fzb3mNA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so285144f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 04:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738238531; x=1738843331;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tthXxwJ9fuw9xyqBmp8bg2z2kCO9zZkxXy5p5fv+zVY=;
 b=ncxxR1N89w6vp5OUNc6JCaGY4+ZU2cutfznN4Sdk/BEJmGdgWm7ha6DM8tCtvPir/d
 Wh6Db3UjTkAZsnod2GGH/F4eWZxRG9BkPpE4q4xon7fwI1S7oUx/t/rtA1vAzo2nb5Ou
 RgYBy3xEUs30SN3pFyOafSxdZ35OusHcvdjEidSwYv7AM+75b+kGfCMHV2jSvqH2aRRs
 +8v7wdKrXAcZbCFBEwWfCko/DikrDZT4tVNVG7ZnKg2ityb8B1z7FVRzmS9Zdn1tAnta
 8zHCzj5Tuh57nQdYoBS+dl1aHK1R0QT2gSLgNsLpf0X+zuzY1nCG//c9w857Lhi22X+U
 pfZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3tA5T8HA1qyvLLYpTB5w4FpvtBbBc3qUMefifKXvYH+aNTEPuilu1Q3pr2zllBFYooYvXCdc+uIII@nongnu.org
X-Gm-Message-State: AOJu0YwoA+wEvMXSf+dvbZejFTMw34kMJxa1HYazGpoEEVANLCUr3nEg
 WzF9nBz848t0qYjr/HS4VHHl03jqgaGhCA8uY6tbRh3cp19QHNJFepAtHQ8Oi3xMeIPvuKgtiYS
 2BP/ehSrAUIpJ1os+FbkypYV+q4fdxBB6ve7ULXne9tUrZ6c3W1xW
X-Gm-Gg: ASbGncucAepxZ5YfVJhmCldSTAtPcWdLh/3zD8TEUKJBz0NJh+WUNqux6FH/zldG8/t
 dXxqeHCXM8T8AMx/BEByngF0a43ARm7IasX83EMDarCTOt/SdjjrLI02pL77h0KetYgM5PMLhdV
 mN4rNJz4bv/K5s2Tvvynodhbokmyja5UEEbzE3uew+LeJp3QRR3bP9DNz7CTMCyOZZRLqtOhwFX
 vgv2fFU3xTgAmio8WN015ndnYRCY7FYWZoWJoCSLz/Nf3iCnIH5jsAlvY88u5hypn4dlYJtyzix
 2b8UBUrvh99f1YGm2b6ah1rI/FON86w1886jrRmZlri/az/ddFe2xcrD7OnjWKL9Cc7sHhrKakA
 FNEdcgG+N7f0TjvVRO8Iy/gUiDe0rbOVi
X-Received: by 2002:adf:cc92:0:b0:386:366d:5d0b with SMTP id
 ffacd0b85a97d-38c520c2edbmr4784181f8f.55.1738238530778; 
 Thu, 30 Jan 2025 04:02:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFxEA8huAXyCCPWFJeXna894GJsv+xkPSLaiBu0PqsJooL8+3C4l1JFblk2LvJaotRrJLcgw==
X-Received: by 2002:adf:cc92:0:b0:386:366d:5d0b with SMTP id
 ffacd0b85a97d-38c520c2edbmr4784143f8f.55.1738238530407; 
 Thu, 30 Jan 2025 04:02:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:3b00:16ce:8f1c:dd50:90fb?
 (p200300cbc7133b0016ce8f1cdd5090fb.dip0.t-ipconnect.de.
 [2003:cb:c713:3b00:16ce:8f1c:dd50:90fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf560sm1738223f8f.89.2025.01.30.04.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 04:02:09 -0800 (PST)
Message-ID: <f6254a03-1bf2-4027-8e1d-ba400984807a@redhat.com>
Date: Thu, 30 Jan 2025 13:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] accel/kvm: Report the loss of a large memory page
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <20250127213107.3454680-1-william.roche@oracle.com>
 <20250127213107.3454680-4-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250127213107.3454680-4-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On 27.01.25 22:31, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> In case of a large page impacted by a memory error, provide an
> information about the impacted large page before the memory
> error injection message.
> 
> This message would also appear on ras enabled ARM platforms, with
> the introduction of an x86 similar error injection message.
> 
> In the case of a large page impacted, we now report:
> Memory Error on large page from <backend>:<address>+<fd_offset> +<page_size>
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   accel/kvm/kvm-all.c       | 11 +++++++++++
>   include/exec/cpu-common.h |  9 +++++++++
>   system/physmem.c          | 21 +++++++++++++++++++++
>   target/arm/kvm.c          |  3 +++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f89568bfa3..08e14f8960 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1296,6 +1296,17 @@ static void kvm_unpoison_all(void *param)
>   void kvm_hwpoison_page_add(ram_addr_t ram_addr)
>   {
>       HWPoisonPage *page;
> +    struct RAMBlockInfo rb_info;
> +
> +    if (qemu_ram_block_location_info_from_addr(ram_addr, &rb_info)) {
> +        size_t ps = rb_info.page_size;

Empty line missing.

> +        if (ps > TARGET_PAGE_SIZE) {
> +            uint64_t offset = ram_addr - rb_info.offset;

Empty line missing.

Don't you have to align the fd_offset also down?

I suggest doing the alignment already when calculating "uint64_t offset"

-- 
Cheers,

David / dhildenb


