Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E5BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjyN-0002FM-UC; Thu, 27 Jun 2024 03:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sMjyM-0002Ex-UN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sMjyL-0006H2-IM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719474911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VlPYqLS4nINnru7w86A5+23JSL+m8ddrZiO0AbA6Kc=;
 b=K5kur9KrIzDeL3ICz2sruAf3EsGQ20n4lGKx9dE2IKGPSfHloTPGj78V7odPHnkoW2E7uQ
 Na3ckU7nRJkG44ruigy3DWbQBRRIyecRpX6uKrXuKomAlLpi35FSJ0Y2Bs5N8fk+KWxT7J
 VKTe/vM6swKhx3JpNvnTtENQV7i/3SE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-cmhp9f7pMbegyXYl98g6bg-1; Thu, 27 Jun 2024 03:55:09 -0400
X-MC-Unique: cmhp9f7pMbegyXYl98g6bg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-424a5a5f024so14800325e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719474907; x=1720079707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/VlPYqLS4nINnru7w86A5+23JSL+m8ddrZiO0AbA6Kc=;
 b=bRtrUMJzTWJM1wGCaU+8rI05TTHGC1+J2/3QI+HRVrmecWxztmFP748B+OW9qMPBCd
 HV6GOudwTM2O8IPKNx6izpJUrb7cSJGvwv5boJaHmEhiPEsmHJ6xevW7u375zG0JzB4X
 S8fIyYskvDacAf02J0a9wlkAWs0ezKSMpVhfVz0xROfxNOBXJwHdUO5zvKdu01xSNrH7
 Fn2W0IBsdR5ytMERgqINby9f3alnt4HmRwpqS6r6U1Kpjtt2RK4k2QkoawyRXrCmxJZ8
 mQbKhK7WDxQuJk3u4fDb+hEt8ajLyNOJzeup5Wdo6ruo4cvHuV4dPTW7dgdmtERGLCSs
 9Pzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/PZh+Sc5+Oo8H7RMk1QnVrE1m7BuJ/gXumKF67mgn1xgS8P+JTXzuVZ81wCKxeDBjqUmpkut8QaM1/5cnbIRLwVRioVk=
X-Gm-Message-State: AOJu0YwVFZx6BgC4eHuQVhO3e8t92A3tWrMRjoxb424WHffkmpV1dwHA
 uW8+etp0acX5DcKJpQwitPuJyGj/zMTogQtD6kBybdh4mRU0c+Dn7q8ABSFDLL4KDlQN+vUQObD
 Dlz0JV32872/ZMEMsKDM2WJpFs7UyP0rNHJu1uz27NC4ZF43R+gVB
X-Received: by 2002:a05:600c:4f0e:b0:425:675a:d52e with SMTP id
 5b1f17b1804b1-425675ad6f8mr1085705e9.2.1719474906986; 
 Thu, 27 Jun 2024 00:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaR3+adqtAimEe6enJChYyn5UgynR5I1VDTINNeZ0kenqIbo2FOGHjmLZ2c+UAIa/pxi/uew==
X-Received: by 2002:a05:600c:4f0e:b0:425:675a:d52e with SMTP id
 5b1f17b1804b1-425675ad6f8mr1085525e9.2.1719474906721; 
 Thu, 27 Jun 2024 00:55:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8468caesm52702385e9.44.2024.06.27.00.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 00:55:06 -0700 (PDT)
Message-ID: <c2e4d431-b7b8-4d0b-b0c6-935cd4fba97c@redhat.com>
Date: Thu, 27 Jun 2024 09:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/sd/sdcard: Deprecate support for spec v1.10
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
References: <20240627071040.36190-1-philmd@linaro.org>
 <20240627071040.36190-2-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240627071040.36190-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/27/24 9:10 AM, Philippe Mathieu-Daudé wrote:
> We use the v2.00 spec by default since commit 2f0939c234
> ("sdcard: Add a 'spec_version' property, default to Spec v2.00").
> Time to deprecate the v1.10 which doesn't bring much, and
> is not tested.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/about/deprecated.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ff3da68208..02cdef14aa 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -362,6 +362,12 @@ recommending to switch to their stable counterparts:
>   - "Zve64f" should be replaced with "zve64f"
>   - "Zve64d" should be replaced with "zve64d"
>   
> +``-device sd-card,spec_version=1`` (since 9.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +SD physical layer specification v2.00 supersedes the v1.10 one.
> +v2.00 is the default since QEMU 3.0.0.
> +
>   Block device options
>   ''''''''''''''''''''
>   


