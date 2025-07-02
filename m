Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5637DC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Ct-00089F-Vt; Wed, 02 Jul 2025 17:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uX5Cn-00088C-9P
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uX5Cj-00038e-RN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751492477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i3ZjKUoIeF+QTJFrvwcc6JPKOyjD3b6qELLeNaubK3E=;
 b=g05vJaZqvaGCk6eR89brnbpaPoeuWD7abRkzGTSZY1GIfE0NshyIdKV5NR3IIkfTP9AWlQ
 Qwx3ZTRWTWjSGhcde6VInlLtzaR4V663qnz/4Uat8MY/98jxEp2q9K6PosTok+uZXvRejy
 kzNaiK4GsSWf1yyXklxuo6RJ/4vUqc8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3tD8higGPWuQonNPYtACyA-1; Wed, 02 Jul 2025 17:41:11 -0400
X-MC-Unique: 3tD8higGPWuQonNPYtACyA-1
X-Mimecast-MFC-AGG-ID: 3tD8higGPWuQonNPYtACyA_1751492470
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so3065832f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751492469; x=1752097269;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3ZjKUoIeF+QTJFrvwcc6JPKOyjD3b6qELLeNaubK3E=;
 b=vjNVdmPj8mu9bDEo3S5wbIUDE83aeVx2WkyQHjYAALt/XTdNBbGTDtVIVV+nwQwQcQ
 Z5tI1fiMpTq4u6vB59dnlLqhE65mXaL07eA/aFjuQNDxj0h2vVWeRQQm4Bt5nTfEugm9
 AG0ADGTnUtUpZ7WHONyFBn6ffkJbfXRNqaoskUkZz0yUyx9TQ0VGbSemNVVSXitgIEge
 PN1lCi7Gr2mC3X7Ti+DokRUFL+25mAL6jSAQDIGkiL3RKS9WaOpSeCKwFlhKt7KfNrAo
 5fwri+mpOZiZkDOVqh2FpdapIGqoemgVYjEf22jg/qkPIcn4JBTxydrImcioI8yalX5C
 oAMg==
X-Gm-Message-State: AOJu0Ywo3IiSOFOV11ayVLD+/TlL/Fy9EvYh3vud9HivJe6yYxAnu4kP
 DBfPN8qyh9Ls/+Fuo6jRCe6fPw+E6YRm3OchqXzdeEt4RE+txstnD6mad9H/G3Unf512DOOfgBT
 1Be7l4DTEHM15gH1KEv5jk70VtRXuNFFkp8ECIPgjSWfAEdzxZIGE36TwO48WIQ9gP0re1YiQb/
 8VlBDDSadkQTyhktD1f/aXmySdTcszozLOIQ==
X-Gm-Gg: ASbGncuyc2m2cFNUGlbLQ9estEtSgwjmstPhsnvTf+N6CfJ4DbeCC2lHDH/DPTrbX4/
 aIhZqhHeuy2UEf2W0w3gMx7mYV5PlCiBmb5U2ezPSrvOlDh3OsF7R50t+9kbMGrc6pobidDur27
 5G17SDfW0PxDBYAySEc9UHMsHgFTuPXI9nvgtxRBZDExTEH2PcrjLeHRdp2rWyPRgVLJYVf1DEg
 pBMxSip/E676fCVWCjCmj+ySBEDxNTumaygElTCxVJxrM36rF0RccZKuooTIMkfDnCdVwZBZgKD
 ygHinin33hE8KrYmA+SL96118p/jKvvMfO0J0y9t6X9PqxdvAAb7HkQZWOG+
X-Received: by 2002:a05:6000:26cd:b0:3a4:eec5:443d with SMTP id
 ffacd0b85a97d-3b32ebd78e3mr534222f8f.29.1751492468991; 
 Wed, 02 Jul 2025 14:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP7VmQu1uC/slNaBiTx1BC+G+aiW8Kwx66tGaKCxDFSlzzAzuCMzRQ65UO5G4lF1xXwg+Jzw==
X-Received: by 2002:a05:6000:26cd:b0:3a4:eec5:443d with SMTP id
 ffacd0b85a97d-3b32ebd78e3mr534198f8f.29.1751492468471; 
 Wed, 02 Jul 2025 14:41:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcf35csm8299615e9.20.2025.07.02.14.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:41:08 -0700 (PDT)
Message-ID: <53990724-f80d-48e3-bab7-604aa4f3e92d@redhat.com>
Date: Wed, 2 Jul 2025 23:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: prune quilt source files for cscope
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250630172048.519182-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250630172048.519182-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/30/25 19:20, Cédric Le Goater wrote:
> Both quilt, to apply patches, and cscope, to navigate in the code, are
> useful tools. Make sure source files that quilt saves when applying
> patches are not taken into account when building the cscope database.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index c92a3cf7857a..74c2da203720 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -227,6 +227,7 @@ distclean: clean recurse-distclean
>   	rm -Rf .sdk qemu-bundle
>   
>   find-src-path = find "$(SRC_PATH)" -path "$(SRC_PATH)/meson" -prune -o \
> +	-path "$(SRC_PATH)/.pc" -prune -o \
>   	-type l -prune -o \( -name "*.[chsS]" -o -name "*.[ch].inc" \)
>   
>   .PHONY: ctags

if no one objects, I will add it to the vfio queue.

Thanks,

C.



