Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09678D1266D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8FTj-0000t6-RH; Tue, 05 Nov 2024 04:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8FTg-0000sZ-T0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8FTc-000230-Lk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730797428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lz50M2A2GIkWB2y4TtgpejEf420SK5ILiQtnvKv0AW8=;
 b=ZUSfa8N7/1CSam7AuJQCbMHXNrY946DcXq741FajWzKr2xieeM7P7+2YaIT1KBKOzBBPEm
 hOLaWHBzOjenjGYF8A1itQbvgEvFzsoyAWPNt/YLTS3QDqstSo1wb8ql20V2AlYIkWrjeq
 zKpru8v6dTo5rId/iwlx1iuHl+rtA7E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Z11AAkfCPci7xUNTXuvuAw-1; Tue, 05 Nov 2024 04:03:45 -0500
X-MC-Unique: Z11AAkfCPci7xUNTXuvuAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso33016225e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730797423; x=1731402223;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lz50M2A2GIkWB2y4TtgpejEf420SK5ILiQtnvKv0AW8=;
 b=wTSNGdHhgBRBXsp+IBxqCbMREBwv2GlHCf+QewVXkfbEfvj2jehwaodFfVi8PriJs3
 W1dytCgim3/8FhuntCf30o7+bhVuPP8CpafUpBITzzgtqsNJJCY1HIWL33HOYZ3rgIDT
 cklbwoJAc6WXMtCAZBU9URFst91qCuzm/F9KAbJ6dzEIWtSoIH/uEkkcJVhLg5ASqCrr
 3mRDelgXVzDeBjfxPEK2RKAgMMK/ibMftOa/+CTzeCQjzwyUh5WjZY1E6KSGP+YWYYW9
 fDA868UzuzBEZXyo7YYAngPctX38jEjconiwD6K0XGZ2MWFamZXBUVag5W2LBB1vhaFx
 +RaQ==
X-Gm-Message-State: AOJu0YxJmLR16ZkCwsV0EKgSMtGcw2wHHabroqu6PKYnowf9iEA3e/38
 25yW5Wagau/vx+YF9Ko/eNoTGsXlloM4LLnLv8H1cNY5ZWYe6KEZB2QkxF6FVU7A0443KSM3EYF
 yvmFqDcEKIg8Ejvq27Srt36FRVuarh0k+KZ/SqRWk1Em1qsSeCv4mng2ahPpVq06gwRyMuXhJyh
 89AN1L2tGhz9jevJiTv6BcQCoPavz3jJyOzHJ7qXs=
X-Received: by 2002:a05:600c:1c01:b0:431:9a68:ec84 with SMTP id
 5b1f17b1804b1-4319ad04780mr277847915e9.23.1730797423185; 
 Tue, 05 Nov 2024 01:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWYyICTyRk4tWd37EARxQrXkEpEWe5Z4WSZX2A2Fz+l9edpX+TnO8vjcYaw7OO9PIFP5ihiw==
X-Received: by 2002:a05:600c:1c01:b0:431:9a68:ec84 with SMTP id
 5b1f17b1804b1-4319ad04780mr277847605e9.23.1730797422694; 
 Tue, 05 Nov 2024 01:03:42 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4327d698405sm183968225e9.41.2024.11.05.01.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 01:03:41 -0800 (PST)
Message-ID: <eccc3999-2ee9-4e55-a4ea-6921eaecb5bd@redhat.com>
Date: Tue, 5 Nov 2024 10:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: add avx-vnni-int16 feature
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com
References: <20241105082848.230020-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241105082848.230020-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 11/5/24 09:28, Paolo Bonzini wrote:
> SHA512, SM3, SM4 (CPUID[EAX=7,ECX=1).EAX bits 0 to 2) is supported by
> Clearwater Forest processor, add it to QEMU as it does not need any
> specific enablement.
> 
> See https://lore.kernel.org/kvm/20241105054825.870939-1-tao1.su@linux.intel.com/
> for reference.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3baa95481fb..ae5b85f4e8e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1113,7 +1113,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>       [FEAT_7_1_EAX] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> -            NULL, NULL, NULL, NULL,
> +            "sha512", "sm3", "sm4", NULL,
>               "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
>               NULL, NULL, "fzrm", "fsrs",
>               "fsrc", NULL, NULL, NULL,

Obviously the subject is wrong, sorry about that.

Paolo


