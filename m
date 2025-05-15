Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F34FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFajB-0006bc-5E; Thu, 15 May 2025 11:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFair-0006G6-Mg
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFain-00062w-FR
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747323727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XhawS+vfcOexO0bs20TjIKKJ46PSOFraoOZdWjpElM0=;
 b=QobVqYLRuiDdL0TknBFuOnDKuX0wV6ahAxS6ymtRlSJ+Paj84ZbEL8a1n0ca0OR7zoUTf9
 uBBPvDQCQ8pU2Zl2Djc8NVjiIDICjXkQailF2H/NhGPRz+fP3H2tzgREC6bL4cuW/QsFk0
 eL1t9DZ3V8V2Y7Exd0Gnh7R7HeKHyMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-McbilFV1P5SuVC9PJGWtnQ-1; Thu, 15 May 2025 11:42:04 -0400
X-MC-Unique: McbilFV1P5SuVC9PJGWtnQ-1
X-Mimecast-MFC-AGG-ID: McbilFV1P5SuVC9PJGWtnQ_1747323724
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0ba24d233so517538f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747323724; x=1747928524;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhawS+vfcOexO0bs20TjIKKJ46PSOFraoOZdWjpElM0=;
 b=ksNCC37reQoaXf69GUPdG5bmzjoskNWkHGg3cUhRc0XFtxgIAiZb0yg9eXYBmuQg8R
 CIW0jSxjCICh+FjJ4VlEfAiDz3NOg8ke2OUFFiEDvhX7aQsJgEm39BUcNsA4CEgSU038
 AqRH9byceFocsUt0arDNsO9nUyGGmjIV/JBw9YGJDpl1z0lRNoczQ+elLcmvbRDrt2dg
 E11UgVozN8+WL/vUut/W6desL3gzHqKrnUdTL80B6t4LiZ3SML0Lr8BI2kmrnQdFDpHv
 4TYdlB0H3n3cJYOpgv+8CwKPSDvD6mAXD/m0O/Z44K26aeiF3PJ1l8/EuvTFOUb6dkTv
 GpGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx2e01a7p4HqLFwRvzA6U5d1lKBwNgj6RB+69VUAretWBjUpR4xhf3ISY6mytZZ6k5jr9LqKWfPleQ@nongnu.org
X-Gm-Message-State: AOJu0YwBylj35uu+RikISeeNzVBjyqWz7naP9yIjcuaYrZbC9YdS4GbZ
 Vk2n7sxtoBAveS854r5XiJnf+z36CNrSYgv3tg4UvZa9EBCtf4VpZHGd9qpWrZ9MyaQZCGBLxDS
 r1v9eFhrdG9BTVJ0O0sA0E+/pSD7yJIZT3U3h5748u1ppOnrBWBdT574f
X-Gm-Gg: ASbGncud5HRNgcTS4XU29fWZVML8pWLge+kJfnVqltuTOOLq0XNHzZZRmtTl4w7D72K
 CsWLrmemxVy3AgffRufpiqYR4kWK8ipICq07hphoPg/AaowylKE7cEjYKfcjlkVvb7hP6Enmx9f
 LuM3WqGWnd94KaGJAIIl/pQoBujV5cm8cgZ/RhLOKvevfoTQSQ5T81Br8zgPTzBzYZsL0aJjI/3
 4B3wxY2bXGSG/oChhma4oDwHnDBeCAsLP8sOp1aAJ1CweOBlIyJ9sUzhvtov23JAjn5506tNNSg
 w31z+BO/qJR+yQhBRjuHQxJHTPZob5UV2r70HF6LoF19QzVXrg==
X-Received: by 2002:a05:6000:402b:b0:3a0:b7ee:b1c3 with SMTP id
 ffacd0b85a97d-3a35c821fe2mr277143f8f.6.1747323723722; 
 Thu, 15 May 2025 08:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh9wisiIPBkxjA2BusX4ka2g0F08Q3GRiAqs1uoi+LFxMdR5NoFKB2QNTGwhj+zA0ut8Q31Q==
X-Received: by 2002:a05:6000:402b:b0:3a0:b7ee:b1c3 with SMTP id
 ffacd0b85a97d-3a35c821fe2mr277118f8f.6.1747323723307; 
 Thu, 15 May 2025 08:42:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dde0esm23434977f8f.18.2025.05.15.08.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 08:42:02 -0700 (PDT)
Message-ID: <207a044a-9497-45be-ae86-b05ae7c2880a@redhat.com>
Date: Thu, 15 May 2025 17:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] scripts/checkpatch: reject license boilerplate on
 new files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-10-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250515135936.86760-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/15/25 15:59, Daniel P. Berrangé wrote:
> The previous commit mandates use of SPDX-License-Identifier on common
> source files, and encourages it on all other files.
> 
> Some contributors are none the less still also including the license
> boilerplate text. This is redundant and will potentially cause
> trouble if inconsistent with the SPDX declaration.
> 
> Match common boilerplate text blurbs and report them as invalid,
> for newly added files.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 87050e6677..cb1942c021 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1496,6 +1496,13 @@ sub process_end_of_file {
>   			     "' need 'SPDX-License-Identifier'?");
>   		}
>   	}
> +	if ($fileinfo->{action} eq "new" &&
> +	    !exists $fileinfo->{facts}->{sawboilerplate}) {
> +		ERROR("New file '" . $fileinfo->{filenew} . "' must " .
> +		      "not have license boilerplate header text unless " .
> +		      "this file is copied from existing code with such " .
> +		      "text already present.");
> +	}
>   }
>   
>   sub process {
> @@ -1798,6 +1805,15 @@ sub process {
>   			&checkspdx($realfile, $1);
>   		}
>   
> +		if ($rawline =~ /licensed under the terms of the GNU GPL/ ||
> +		    $rawline =~ /under the terms of the GNU General Public License/ ||
> +		    $rawline =~ /under the terms of the GNU Lesser General Public/ ||
> +		    $rawline =~ /Permission is hereby granted, free of charge/ ||
> +		    $rawline =~ /GNU GPL, version 2 or later/ ||
> +		    $rawline =~ /See the COPYING file/) {
> +			$fileinfo->{facts}->{sawboilerplate} = 1;
> +		}
> +
>   		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
>   			my $tag = $1;
>   			my @permitted = qw(

This patch reported this error :

     ERROR: New file 'include/hw/vfio/vfio-cpr.h' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
     total: 1 errors, 0 warnings, 58 lines checked

See patch https://lore.kernel.org/qemu-devel/1747063973-124548-6-git-send-email-steven.sistare@oracle.com/

But this looks wrong. Right ? I don't understand how rawline matched though.


Thanks,

C.



