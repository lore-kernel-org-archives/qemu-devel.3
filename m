Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D665606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PBD3z5XR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UEnfNQtz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpH4-0002Ma-Vb; Fri, 30 Oct 2026 12:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xMpGu-0002LX-8h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xMpGs-0006Un-JR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793376960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAENEnC4rOLT5XV87ofUY9Oqla9pGvvnmgW65KiQORQ=;
 b=PBD3z5XRrei0RYjmZ2yGxixZak6S9J6JANhrn62JyrAMKvYPDAv/crFhO43tPDVysW70Vz
 YryISviR4NYUghMOkVLc6QtFZwT7DwUDUR65QQGPf48cu6EPor4FhN5p4+AeGlpUaw7EOM
 b7ZOISBPJ0Pqwns2bg+SPy1xYqcw3Ds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-yR9WxdFlNAeCHyjTz7VSow-1; Fri, 30 Oct 2026 12:15:55 -0400
X-MC-Unique: yR9WxdFlNAeCHyjTz7VSow-1
X-Mimecast-MFC-AGG-ID: yR9WxdFlNAeCHyjTz7VSow_1793376952
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a20fd059ddso6607125e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793376952; x=1793981752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oAENEnC4rOLT5XV87ofUY9Oqla9pGvvnmgW65KiQORQ=;
 b=UEnfNQtzZs23ySd6akatb1wwKa9CSS8ewHv3B0pE1X7LZyXSqClpUstwQEgaPmPzE1
 ji1NeQHAXSJdH87sJMrlmMjnYWY5s5aO54EYiFjJqHm7rF/v0uUb0Y4PnPUdzElfpaOE
 P5aQVtbNJNxf8YpHeU5yrYW6PHDomUolDFjD3LBm9vgzD7EcL59snSt+CePt0tahmvBK
 8MHMe+Xr9v6TBYvdOrCDl5XvxZVUEEw+/CvoVFLktd9XvHqGDJN//++1au9fgi8/BU5l
 +onclaO8Mw+XPaU4R66xQS3TDhckeUYB3KI8YF1hPaPww8LKXwalvjWk2ir2NbXheEkI
 dmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793376952; x=1793981752;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oAENEnC4rOLT5XV87ofUY9Oqla9pGvvnmgW65KiQORQ=;
 b=plarOKRse93RoxLRiTCciJe21E4g/tqJfgZY+bZ3zz7SPhmyr6iKyTAyh5qOkRdYJD
 alTRNagrrT/4EaQzd75gz1nCfo7Is9m79tTGCPuM7aZL9H84KlCxBoAPBJ6cAcTiSBKh
 M2yMKfE19pjM3mMqk2TqC8odoNtNirxdYhKyFoe5KjGOKKCTEX22Eoxb+abBWyPAYo6E
 61Q3ds7e01uAV2shTwbCBwGjvwFQJmt4RrVMod5AZxXUKMTBlx3xttGuwz+xtimZdPnv
 D/FEq9NBZeORZMDBJZ+K5XRPzpJNLz1iG+e50MeFXyFOmr1jBld2yub6pZr433rFY+Pr
 Anpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4T2Jzz/jLJU3PUNjXzKknlCvKXse5J8hY1zWsIvyPS3v6XBBUOJRbnsE/5WjimJlyO3VHmDejUOrk@nongnu.org
X-Gm-Message-State: AFq9FYLWkcierR2BuKK0D8pgwNhCzzflnKra0OjRLXvJb9zGMl/PozX0
 sZOZi2eVwgL99S6VMTLxads7RWVZE7L7YmBTs0RvbvhsHhtEc+IrqXZ8heTtRK279GkZpuHgJiv
 7U3HufID+r01OumfXkprvrMrOGGrtqdfkZpgWKRqPdMQRkGqvA11AfFmz
X-Gm-Gg: AYBFou1PCgsqFI9q+Kcc83qV8CzwAo2QgDiZEcV11w4RVETxW9WqdF0F2LP+G2preLX
 98BANX/MxgSEkcGKo2vwTLqgse2qeViiJvsDFBX6gYefGcDQiavFGUnSkHiwHH/TaegFjfrJ1yM
 5EwsrGbJg3BG8vRG1EIyZ2NvEOCkGCh4T4CzjwjvwGCP8eEgIpP0CnVKgdqEGybZWaFn1g/Pw8h
 oleOFvYJOS8gzhvb36r8ERoovcnto9+l5jfuDN30bV8uUoUP1A01hwJhoGkRqAPgukZCgDGOq7P
 pZMIbLAEsdugsMPQO8wUmLIoYtxmrx/I4cEXoYlu3DK01Y2QekLQxfsqbw41EqwJWPEhroY4mc3
 mLIP+z62jRv2mmMAtZro8GRJYgeg59tOqc7up0VYV8ZfsEE6/5i3kvVNWnhBKRxbrN0CCjfc1UM
 8ef/NGooNETzftjn4M
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4ac150b38dbmr66321425e9.1.1793376952554; 
 Fri, 30 Oct 2026 09:15:52 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4ac150b38dbmr66321025e9.1.1793376952220; 
 Fri, 30 Oct 2026 09:15:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm147561725e9.4.2026.10.30.09.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:15:50 -0700 (PDT)
Message-ID: <8b14772d-1844-4760-bf3d-d100e8b3fbac@redhat.com>
Date: Fri, 30 Oct 2026 17:15:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm/cpu64: migration tolerance for PMMIR_EL1
To: Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20261030143435.57230-1-sebott@redhat.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261030143435.57230-1-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/30/26 3:34 PM, Sebastian Ott wrote:
> PMMIR_EL1 is exposed from Linux v7.3 onwards. Backward migration
> to an older kernel would fail without cpreg migration tolerance
> definition for this register. Fix a couple of typos while at it.
> 
> Sebastian Ott (2):
>   target/arm/cpu64: fix typos in kvm_arm_set_cpreg_mig_tolerances()
>   target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1
> 
>  target/arm/cpu64.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
For the series:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


