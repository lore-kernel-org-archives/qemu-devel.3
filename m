Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9621DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lnh-0004TY-Vb; Wed, 24 Sep 2025 05:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v1Lnf-0004TQ-EY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v1Lnc-0004jC-EQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VgtC9DHi7P1SAzU+PY0GRgoeMyAV26bm1DUXxz98zqM=;
 b=TkClQ99fB2Pcs6wOYQQiKyMSwz5XjYsGKBirfwFK7wZdKEv9GHJofVCN6RpcmYwo6+mGe9
 0GtwwigM8ivSw1bcfDvPYdNyQX40huHahv0QOCVch0Y1C/RGVVd1ED611SwXZVP25zIj/k
 m/PoU8naGY7FdkMNdOdCufUVXeGi6nA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-oC7o-ojJNzieMdP_Pjbpew-1; Wed, 24 Sep 2025 05:28:22 -0400
X-MC-Unique: oC7o-ojJNzieMdP_Pjbpew-1
X-Mimecast-MFC-AGG-ID: oC7o-ojJNzieMdP_Pjbpew_1758706101
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e25f5ed85so7427355e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706101; x=1759310901;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VgtC9DHi7P1SAzU+PY0GRgoeMyAV26bm1DUXxz98zqM=;
 b=dWtMz/KGpxNWsfklm99r7Xv+ygiivMsDDUaBSXyXvGJIF26eXbC30R8WaPHA6vZERF
 3Nh9zbGJiv8ZZL5Ymv3BvLYb5f1JyG8GetgGAZfIlfJxWhkk1gZZXDoD8xKQEgdQfWND
 FhiMl0xjnSoQKBMTaDHV/PivcSYT/jtA8ztPOop+HnY6V+bbDBa2nshJhyi4/ukknanq
 cCetka5HXaciUgLbdNIEaYFQY2CmIFaStr3HIy0bvSzVd3szXGkvhsYt611pg8XHTr8a
 C4wnYZpSLjjVdQrSHphH3CB2eNnrsEijgCMyMQdDf7BODRBTP95PLtJ1Jt9TiDH068nW
 wh0Q==
X-Gm-Message-State: AOJu0Yyw4niEUT2CsZ/69oSTnz2zrGOrq8rQfAUM+mYtKD4aaMAx4ASE
 oo/rMzo+ez81599/cXNOpCihoM5KEXx7I6aphGelb8h888vO4eeWg3BfyFtFWD/Ep2Tf4wic1c1
 Y3DqWNrqcWcRYlFRkbZhhW0WENXRERdrDp/saGJCnr1Pvx6/wX+G0xRsPJ4bdFeF63xUmj0DjoI
 oavSzGHjKMgZoyrEMq503r8dg1lu2gLih8Z7NmTgk=
X-Gm-Gg: ASbGncsbBGz7Nou6qmUP+VHSxaFBp/w4X6Mf4HaJmDc2SLKRp0p5En/1WILdM0EmQe6
 SN8lU0M9Se7X6H1KZ4lO4P5Z9NX9JkSoBlfEKu4jCXEp7mJOBtghz7WaJSx82hSSwrenSNwNQc6
 kjCBOvy02uk5Nft7QbVV/PdqFjyH1ltev7jp56hSqDiHPQsHyEl9ukBgnU1OmivXKd69i/JCD47
 DfOrtcec+9OWevTggAxDCetE0e/EGYFz50nQotl054N+oc0gMW8m42C5lzTY9YIHko/PgkgbDu9
 OwH44WRgjtMzjIWVp4p6rGyd88KjsySF3lTHQTyrpq1C4kC4+helM9+0cd0I1xdY8fs6MfQpRN+
 WiBeFFEjv5PUJD/VtFiO0/A6iEAaazsFJXXBQW4cf01Pm3aX/1i8m3uDm4tJ8KhBWbQ==
X-Received: by 2002:a05:600c:4f42:b0:46e:1afb:b131 with SMTP id
 5b1f17b1804b1-46e1d975235mr63174765e9.6.1758706101412; 
 Wed, 24 Sep 2025 02:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9UPhE0Ot8MJWKXQMUSfQkGMgqszfQ01xXFivwqczmxp7NyFhRZt9QGvPoZgxE1qeZGLqUig==
X-Received: by 2002:a05:600c:4f42:b0:46e:1afb:b131 with SMTP id
 5b1f17b1804b1-46e1d975235mr63174475e9.6.1758706100938; 
 Wed, 24 Sep 2025 02:28:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b?
 (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de.
 [2003:d8:2f14:2400:afc:9797:137c:a25b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407fa3sm27280223f8f.21.2025.09.24.02.28.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 02:28:20 -0700 (PDT)
Message-ID: <425aa349-d2f4-41a7-b303-21b226dfbbfb@redhat.com>
Date: Wed, 24 Sep 2025 11:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/osdep: align memory allocations to 2M on RISC-V
To: qemu-devel@nongnu.org
References: <20250924131803656Yqt9ZJKfevWkInaGppFdE@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924131803656Yqt9ZJKfevWkInaGppFdE@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 24.09.25 07:18, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Similar to other architectures (e.g., x86_64, aarch64), utilizing THP on RISC-V
> KVM requires 2MiB-aligned memory blocks.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>   include/qemu/osdep.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1b38cb7e45..6de6c0c4e5 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -561,7 +561,7 @@ int madvise(char *, size_t, int);
> 
>   #if defined(__linux__) && \
>       (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
> -     || defined(__powerpc64__))
> +     || defined(__powerpc64__) || defined(__riscv))
>      /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
>         Valgrind does not support alignments larger than 1 MiB,
>         therefore we need special code which handles running on Valgrind. */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


