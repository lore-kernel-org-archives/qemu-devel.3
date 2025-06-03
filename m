Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FF6C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMKmR-00006Q-Q1; Tue, 03 Jun 2025 02:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMKmN-00006B-Sx
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMKmL-0000H9-Sj
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748930739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NByGciD3h/JhMDoEWsHIEDjiwZjTZk/rSc27ZPGTVOo=;
 b=Y28Sgu5myTZ9qxynIRz5zKisA6iTQhr+1YW81fFYf2Sr/NxFsTtQ+qzsLZIxhJnmEl1ai2
 3l7zAPsCK6OecTnJfOoveWi7MGXMk3JeMbr359bjO3MReUDEeZjUrO3MPIByAfW8uteLn+
 Z1w6Q6f4Gex3cjViuhORCcQrztXEpIM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-JMvoaOhYNjm6PgJ_umpLYg-1; Tue, 03 Jun 2025 02:05:37 -0400
X-MC-Unique: JMvoaOhYNjm6PgJ_umpLYg-1
X-Mimecast-MFC-AGG-ID: JMvoaOhYNjm6PgJ_umpLYg_1748930736
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad88ede92e2so509657366b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 23:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748930736; x=1749535536;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NByGciD3h/JhMDoEWsHIEDjiwZjTZk/rSc27ZPGTVOo=;
 b=NfWGIm4y7p1YePW7a4/wictsD0ljo3NwDMIrWCfltL9jqi2soW8XhL7W6mHk2Jae/Z
 bs5DS1C3TMYdrUJqtOKy7HugwMikbhkGTbddf7/AFFomld6Hjb1uOVpmvXHRUofQhTbM
 7fKAINY69n+RvYVjWzFiqXqsAEU6WtX/yfhd5fcFuZnY0qRNABjwITSw08THA5Y5foAp
 ng7PL4TAFcTKxYMjv6emfBHToixzSR8956f7FQeVooECMHeRTJ+0XV4oePCvXFrQCeL3
 IGxbU7BlWU/rqF4nowBYWJ2z2ZGL9CAPgImIW75MI8bnlhLIQXjrV5bqUBeUuxft7vZa
 GKmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEGwopO9NBIQxoFH+E6wemJJXHTReHpLzZLJhzKm6ghGhlgovk+U8kwIm7l5KogVm1Yk/NJy84E2bR@nongnu.org
X-Gm-Message-State: AOJu0Yz+DY822mUxcwOGqMA82yVCeO9nGd5t41cEOiB2LQ45w5pe4+FX
 gnikBRor51qUe91iy8xCl5g2i19eoTOyWYTdIxlWwfQTieCXjeA3ep25MvlVUtg40wQ49/UhvoH
 2SVBHO6KgOcy3H0xk+RdTYmKbC5snRMGRZ2bTj+0RzJQ+EoLUl2iDr2Lk
X-Gm-Gg: ASbGncvlydGFnN/nOL6YcecIBI2ssA2HxY2s+A1nwCGs5oya09xo02nUcM66d5+tiMx
 TMY+D7A1NJKCAbYM9KPPwAA1QSppwcC9/3YvYdcNGl8Dk34BzS9fOUn960tktb0w73/WbkUGdCc
 cxTEfZHZE9ihYNOiabxpm/1c71CbrpfmDJoOM54dSoe4Iw+MLB1EIRWYRPTbRUWZz+UHiu9scBH
 NrxfS2JvNXeDkIzCRxq+Pxzb2Rk8gJOEnpbAIbUAyn6IhttMOgvy0SeBUDw6uu6DnTMRxie0Lnf
 w4SDigevhmR79e8VNK3IDmQM1JRKpFAfO5ODKz/76b8=
X-Received: by 2002:a17:907:1ca1:b0:ad8:9645:798c with SMTP id
 a640c23a62f3a-adb36c00eb1mr1349495266b.51.1748930735915; 
 Mon, 02 Jun 2025 23:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8WzfwfkGz2LDtIDAw3TN5LwuoixeJ/KK5BEjtEACPnbx5/GqPTAKq9lWc7XJ2vLUTeAQ21A==
X-Received: by 2002:a17:907:1ca1:b0:ad8:9645:798c with SMTP id
 a640c23a62f3a-adb36c00eb1mr1349493166b.51.1748930735502; 
 Mon, 02 Jun 2025 23:05:35 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82ddfcsm913557966b.55.2025.06.02.23.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 23:05:34 -0700 (PDT)
Message-ID: <fb5bd578-9869-4376-a47b-b7f9e3f288a2@redhat.com>
Date: Tue, 3 Jun 2025 08:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use config_base_arch for target libraries
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: clg@redhat.com, nabihestefan@google.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On 03/06/2025 01.38, Pierrick Bouvier wrote:
> Fixed commit introduced common dependencies for target libraries. Alas,
> it wrongly reused the 'target' variable, which was previously set from
> another loop.
> 
> Thus, some dependencies were missing depending on order of target list,
> as found here [1].
> 
> The fix is to use the correct config_base_arch instead.
> Kudos to Thomas Huth who had this right, before I reimplement it, and

s/Thomas Huth/Paolo Bonzini/ ... it was his patch indeed, I just was the one 
who sent it as a proper patch to the mailing list.

> introduce this bug.
> 
> [1] https://lore.kernel.org/qemu-devel/c54469ce-0385-4aea-b345-47711e9e61de@linaro.org/
> 
> Fixes: 4fb54de823e9 (meson: build target libraries with common dependencies)
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 2df89006f8b..ad9cef99ed9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4142,13 +4142,12 @@ common_all = static_library('common',
>   target_common_arch_libs = {}
>   target_common_system_arch_libs = {}
>   foreach target_base_arch, config_base_arch : config_base_arch_mak
> -  config_target = config_target_mak[target]
>     target_inc = [include_directories('target' / target_base_arch)]
>     inc = [common_user_inc + target_inc]
>   
> -  target_common = common_ss.apply(config_target, strict: false)
> -  target_system = system_ss.apply(config_target, strict: false)
> -  target_user = user_ss.apply(config_target, strict: false)
> +  target_common = common_ss.apply(config_base_arch, strict: false)
> +  target_system = system_ss.apply(config_base_arch, strict: false)
> +  target_user = user_ss.apply(config_base_arch, strict: false)
>     common_deps = []
>     system_deps = []
>     user_deps = []

With the patch description updated:
Reviewed-by: Thomas Huth <thuth@redhat.com>


