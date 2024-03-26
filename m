Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E4AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6XO-0001Vl-2c; Tue, 26 Mar 2024 09:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rp6XL-0001VK-IM
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rp6XJ-0006yL-OZ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711458495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pSrOi1c9pyDWfk2bV8njuTBnvB9MgZqEjV0NmKOrN3s=;
 b=jJ28v2UyEhZeK+BClETnzyOeiaYIF8tzEYq+td5RMeB9oazPWOEWRdaqphHdER2TW/7M5o
 9aBvHAVlHqQYrdWhmHr2i1Q0BlZEXgPSWc/NtWEm6iFgK704g0B8+A+hWFi9TeGThXQrmS
 2muu8JkNrD9nRvfj/Z6kItlg+DbcTts=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-62nPU0a4MxCBeFzLcSuXDA-1; Tue, 26 Mar 2024 09:08:13 -0400
X-MC-Unique: 62nPU0a4MxCBeFzLcSuXDA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33ed8677d16so3567434f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711458492; x=1712063292;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSrOi1c9pyDWfk2bV8njuTBnvB9MgZqEjV0NmKOrN3s=;
 b=cOPFDdcFSaRY59eK1T2Kj4rKknuVQkY0hfTNVoNxZfmyilOrSWtwXv4coBtkCpshRH
 +dbSmWg2y5eDAsKCu0Qcttir8Qxx4qAg+6ms+nA6QshMGKCWokJaSlkjIUZBmA4qBTto
 FQYdHd1+WWSxi5xMzFD5o7V3koHj60sz+OhGG9L9Gmyp+vMkFJKU/9cjXMUPreYr5W/P
 9bgi1xOamy0scrIjIyeUkxDp+3b1bxpzhVGrB6hfhadyY7WF/avY2fDEHXS6uVSmqj2S
 IixkeSqc+o6oIOf9uiZATxbcAUEuEMsEsPm9ErQab4RLJdb1+FJt+DO7hrSgaDS7Kvpt
 c44w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlrQfSzvE68ebnQv1hXj+FvIfF37+8AveFBEK8zbe9SCm7ZkVm2wk2B4CA34Bm23XRN1xGzPNTjTXgpy+vPL+Ru2TqsMI=
X-Gm-Message-State: AOJu0YyAfo8cm+mTBuuveLz7lfFOwqQd/uwaiBs5gyYF1aCTyUZwWuj1
 2oCDiui9Sl61kG/w9Zq90JUMt6lPD7Owp4DKS+U2s+/vAMa3oHCFk8DaWUxhSK93D9sPgQdzDJJ
 e9bWbCrS6JFGcI32uVdlG6mxekpTiIy1aH2q0U5cNxdeiHatvkBQqy3CWgaoY
X-Received: by 2002:a05:6000:1cf:b0:33e:71b6:bccf with SMTP id
 t15-20020a05600001cf00b0033e71b6bccfmr7369068wrx.36.1711458492531; 
 Tue, 26 Mar 2024 06:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIc+y7I4cAdxyOcuQhwq3phB3avojCRxllpdIv1f2t0uIG1ktwr9If0aNQrQa+eWE4EF0Y+w==
X-Received: by 2002:a05:6000:1cf:b0:33e:71b6:bccf with SMTP id
 t15-20020a05600001cf00b0033e71b6bccfmr7369015wrx.36.1711458491596; 
 Tue, 26 Mar 2024 06:08:11 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 bx10-20020a5d5b0a000000b00341c3071c93sm8947858wrb.73.2024.03.26.06.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 06:08:11 -0700 (PDT)
Message-ID: <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
Date: Tue, 26 Mar 2024 14:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, qemu-trivial@nongnu.org
References: <20240326125104.90103-1-imammedo@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240326125104.90103-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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


s/iaspc/isapc/ in the subject

On 26/03/2024 13.51, Igor Mammedov wrote:
> ISAPC machine was introduced 25 years ago and it's a lot of time since
> such machine was around with real ISA only PC hardware practically defunct.
> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on RHEL9 host
> in only TCG mode, while in KVM mode it hung in the middle of boot)
> 
> Rather than spending time on fixing 'the oldest' no longer tested machine type,
> deprecate it so we can clean up QEMU code from legacy fixups and hopefully
> make it easier to follow.
> 
> Folks who have to use ancient guest that requires ISAPC can still
> use older QEMU to play with it.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   hw/i386/pc_piix.c         | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..5708296991 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -226,6 +226,13 @@ These old machine types are quite neglected nowadays and thus might have
>   various pitfalls with regards to live migration. Use a newer machine type
>   instead.
>   
> +``isapc`` (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These old machine type are quite neglected nowadays and thus might have

"This old machine type is ..." ?

> +various pitfalls with regards to live migration. Use a newer machine type
> +instead.

I doubt that isapc could ever be used reliably for live migration, since 
it's an unversioned machine type, so I think it would be better to not 
mention live migration here.

  Thomas


