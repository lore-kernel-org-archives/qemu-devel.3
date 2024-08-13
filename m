Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54CFC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0Yb-0006b6-H4; Tue, 13 Aug 2024 19:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0YZ-0006Yt-G0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:03:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0YX-00037Y-Ny
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:03:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc52394c92so55162045ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590236; x=1724195036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nepW9SoVQs2Qyr/MC0g9avzBtFNElppGjTFzacabsx4=;
 b=E1YuOjyRdbMwZz5UmH1sEghORSj/7gBbhmRfd3dvcGpSDdmLv0i1rReERLhtpLDppJ
 QZSkdM9+hB+oCqmGRLjVayFIjSJYzR0BrXyPX4AK71YdOW1n7h6vY3f1UWqD80CGwXem
 1IDwfDhq8IuqCEDCDyFA20BcRIarQVhAKQLhcVPIifJJUWt9sb1RVDSFNXXCm4YyOKWq
 KNFp4B1HUOSGdMsfVoGAj0wlCkWZIuItFOnaadRgEhGpIqlKpuRCPkfc6KtMV+p3VCmv
 C3cSrb2FjwqWC4qwgsU//D20iF3Wml6qistYzcLzilQMVRCDbeq6DIUXA/K21T5DD8K/
 hA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590236; x=1724195036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nepW9SoVQs2Qyr/MC0g9avzBtFNElppGjTFzacabsx4=;
 b=qf5rU8GPVB+I5nzYKQqdb5pw3c0iY0xcCL2V/4vcL86hLrJm6vF0RVDwhLseq8mT9a
 wU3fU0NY0GOGiNqHfmisChnKoLgwivBt6OwhRaPbb1QeaaeJn8ATctcl+Ygo5az+Rqzq
 GGlNS5t2FE9OBCFpf4Xo2gGnreJxzBHf396QNUWWGL3qp4PgZGcshIt3yOozxl0ky6By
 f/KEvvCm+AENCuhfrh6SRaKUR7AJU90MtSSThZt/drRtKGzTPvMvqArgeHeF+MQ8sQH4
 FRBmNKkhYB3MwzyI6jFSYqHx3An8e3HTsVHEpjGDBNwbQv2zBc+rsOMLxO9VicwvoALr
 4RqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLBKuky3uRFP8PUnsdAabPDydgrzYzz72wYhIp3IfJlsHpftwE0roygATWp032I4bSJ1bcgcnJDZVHz5T0zfCOjRB3svc=
X-Gm-Message-State: AOJu0YzvBTZb7LY4SzuLpytavsS16tr6RGYsiEqCIbXuGKOKULeegkhU
 m1VuN5Vjr8zWr+j9ZLsY6X0idnuuC8HkgQyzrrIDZFjaBUuw3aivpqiia4Nuv1Y=
X-Google-Smtp-Source: AGHT+IHex6bEHKICRhxEyIyZBtyU9SW5Upe/Huo6OwCS9fcV1+/0BxCrXGbaVQDx+8fctqC3cOKjtQ==
X-Received: by 2002:a17:902:ea12:b0:200:668f:bfd5 with SMTP id
 d9443c01a7336-201d63ac1b1mr16990075ad.21.1723590235629; 
 Tue, 13 Aug 2024 16:03:55 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1a94ddsm18545365ad.161.2024.08.13.16.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:03:55 -0700 (PDT)
Message-ID: <a405e619-bb51-4309-a4e2-d23b4df550f3@linaro.org>
Date: Wed, 14 Aug 2024 09:03:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 02/10] target/s390: Convert CPU to Resettable
 interface
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/14/24 02:52, Peter Maydell wrote:
>   static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
>   {
> -    S390CPU *cpu = S390_CPU(cs);
> -    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
>       SigpInfo *si = arg.host_ptr;
>   
>       cpu_synchronize_state(cs);
> -    scc->reset(cs, S390_CPU_RESET_NORMAL);
> +    resettable_reset(OBJECT(cs), RESET_TYPE_COLD);

NORMAL, not COLD here?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

