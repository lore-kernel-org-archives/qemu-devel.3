Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB3C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIqc-0007jX-Jo; Wed, 11 Jun 2025 06:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPIqb-0007jA-9V
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPIqY-0001BF-PF
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749638296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y8aiy6gLrcAVxGa7WKVwLbsuuGNNnp7+0cmsOBx1M9Y=;
 b=ZrlCBPoLqvBGSzvjJmDRWai+Ef80QC+42IzJ7rjgfd0+TT2dUZBWhVJ1E5WV62FCdG3Tk9
 UzuWaOAS530+R7eiYV/hwr/tVW+GI2wgFZJDWZ/NLqOX5CiJy5udn/QTLFaZy7hrIdPfMw
 LiBieScVtmyByiHXTlgNxHJh7X53Y2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-MPvXjztDNM-8BTAFgX5PkA-1; Wed, 11 Jun 2025 06:38:14 -0400
X-MC-Unique: MPvXjztDNM-8BTAFgX5PkA-1
X-Mimecast-MFC-AGG-ID: MPvXjztDNM-8BTAFgX5PkA_1749638294
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450cb8f8b1bso15131825e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 03:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749638293; x=1750243093;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8aiy6gLrcAVxGa7WKVwLbsuuGNNnp7+0cmsOBx1M9Y=;
 b=io01hzm7DnEPgy6b7Gj7AD36iLtA51tHjezJNxHZfwu/SW++XOSjEGiltykn25FgWK
 jGK152Fc7Cn9RtJRDmxj6vwwplgS4kuaOt8Wk6ezsbzOPVmTYTHpd1U4Iv2bFj79fqq7
 jGwLBw2Lh7gNJYcD2ZuFlAhzBBc4A3nzmMSjam6aW72TBxSzUJZ2xKh/LN/1m17F5izC
 0VEax2UXMTR44dV2ZhiqBw6EOXsHX0JA9768n2mGiwCfBS5m2yfuZSEB8AMspTmT6uy+
 2kHdkbl6X6jNYZ0gn0VSNjZyzrc645HzJCWrYQwEQKghXS7zPZzMMoRtuSx0Ke5KOCnt
 jfqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHZOZry/KHi867H+rv/noB/rJEq+Kk5/E9l68UB48a4ED3f1ZkfVw6UPoKmsyBKSqdK4HL8jHzcgRN@nongnu.org
X-Gm-Message-State: AOJu0YzhLjRdhpfM9gw3vbYk6+1Q5HhLIOm9Ls5FLNS2PqWICzQLWEQf
 sAMLGO41ENHOLnkzgX0/XvOqBcNLsvNyA5jhIpSkc824Tgvz2WozuFIDmOp/UJJpsT5b9NysaMe
 +dNxdCKN3H/QNEMs4oevTwTWPYUzEjS6z6SFExhof5Pq/7EYmtg/i+QpP
X-Gm-Gg: ASbGncvfLgyuCtiI71Fq+iJa6QGUe9oJ9OBXF/Mt4ehlq1OyWRUTCR81lRkuWfhE7fe
 1wFwzEvP2MLcphjltjsDvDmaTfKbWviIJckVAPrX6FhnlU6x/sCV/VvqH6Y8L1VtNdPL6ilvogU
 hlC5d4kI35x7o7ko0F71HJ/8i3rUIXPVQiyLIuOaBVIfKPkaTDptVUbpVh/5Kk6phOy331beLgE
 vVHwL57M1ey05DEDheqZKsGC7MvWvsXJanM/NQBn3ChM8hFPbANJ8voX2Z/DzfaOwHD8PaJXzt5
 +q8G4EE3DWs/YkoyrVKqcp+Ry9Dl5Bb/yx8nE4QBvMB/AmGaNuXeMZfZl8FulE8=
X-Received: by 2002:a05:600c:c178:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-453247ee33cmr26281795e9.0.1749638293649; 
 Wed, 11 Jun 2025 03:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFalzxyiIR3nr3Siimpl4io70ltX+0lbzDlOxnMvorBom6DfAT0xZKIIqeLPOzqohOZ4BC4Q==
X-Received: by 2002:a05:600c:c178:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-453247ee33cmr26281485e9.0.1749638293305; 
 Wed, 11 Jun 2025 03:38:13 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net.
 [47.64.115.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453251b6c19sm17110555e9.40.2025.06.11.03.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 03:38:12 -0700 (PDT)
Message-ID: <a444a00d-bb63-4018-84f9-f530c622d3bb@redhat.com>
Date: Wed, 11 Jun 2025 12:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pc-bios/dtb/meson: Prefer target name to be outfile, 
 not infile
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-3-shentey@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250610204131.2862-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/06/2025 22.41, Bernhard Beschow wrote:
> Makes this custom_target() usage consistent with other ones in QEMU.
> 
> Fixes: 6e0dc9d2a88a ("meson: compile bundled device trees")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   pc-bios/dtb/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
> index 7a71835bca..993032949f 100644
> --- a/pc-bios/dtb/meson.build
> +++ b/pc-bios/dtb/meson.build
> @@ -9,7 +9,7 @@ dtc = find_program('dtc', required: false)
>   if dtc.found()
>     foreach out : dtbs
>       f = fs.replace_suffix(out, '.dts')
> -    custom_target(f,
> +    custom_target(out,
>           build_by_default: have_system,
>           input: files(f),
>           output: out,

That looks better, indeed.

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>


