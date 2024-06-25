Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39D4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM869-0003Qk-QK; Tue, 25 Jun 2024 11:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sM868-0003Pv-Oo
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sM866-0002eH-Or
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719329320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y3IxSWBz9dou0rBHZaIa70KyiV69vxlVT1vsoQAxivU=;
 b=UcVukWgOfAVXi3NfmmHt7EpP22HgfAhF/ESqggXqS7VHkXMGCCyteiQ5ISNKk2C/Z2DGY7
 PU555U6flkj8ledBTbT6oa1Bj1/j5bNRyLl5tZu6mW0SzfgpzHMl7zfxj2Dx4OQIWue7FM
 KZquhQk3jxZ5D1SyTpsk11OT+wO3fLs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-10Zv3j6wNPWZTo0TJrYaxg-1; Tue, 25 Jun 2024 11:28:37 -0400
X-MC-Unique: 10Zv3j6wNPWZTo0TJrYaxg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-795cce8b773so1119831085a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719329317; x=1719934117;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3IxSWBz9dou0rBHZaIa70KyiV69vxlVT1vsoQAxivU=;
 b=j88jyZ7Nog9WJB+920e7CHAlTzzgqdjPsbsx9sPgj+4Spo4YTyyS/7NHhjXhE7V5uv
 haZ4oknrpsQsmfNmvolsqddYGHUBFWbO6x0GEYbEc07THX5KZCStc6VCcZmvndGAyeJ3
 7H6i+rq9ot66Koi0oeRR8KN74af7x8K3L/tOT03BfTji5l9ery3UhlZlV+nzA8gdyhwZ
 ZL93eSHVw/mlihJYzvKqF2rM5x9xsFLpW+BysO5neIPpgE1Erg2YX5RRas/Hk+fQNYxp
 0YTlVUJr2m8s1FMh4EU4KVVO3TOzCbPOZErPC+ee3uf+C5K3rl1jTbg77NSgtK0NA7KY
 W3fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNLxU/NBRdbL2ryOTWlqODOOAflncoll/TH1s5ONIjgL1zK0ZHasPabHgEHQZQOolfvXj97NHw2MrlMwiArBZsj+cpTo=
X-Gm-Message-State: AOJu0YznCf9qroJX/8xwkT/ToAtWixdM+UMayvkZAy2c8ITKjvn14iCy
 EONbD/VQZPcVR4JSOD2B/vNUMa7llvYw3N0WejMa7hmPwUS/Euoul6n4dpenwr5APNzzz3royxq
 mJBqI6BhwOoTII3+KxI75qXv32vBrjdiqrf4SlsZZbJK/w2nn0VJ0
X-Received: by 2002:a05:620a:461f:b0:79b:eee2:d212 with SMTP id
 af79cd13be357-79beee2d7ebmr774038685a.32.1719329317439; 
 Tue, 25 Jun 2024 08:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbZ3lgN4VigfzAFjRXHVTwhwVWTHwCRpDSiyar70bV9h4tW1Hu8oPcGWEOc1hFNOJxfKVxPg==
X-Received: by 2002:a05:620a:461f:b0:79b:eee2:d212 with SMTP id
 af79cd13be357-79beee2d7ebmr774037185a.32.1719329317140; 
 Tue, 25 Jun 2024 08:28:37 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-66.web.vodafone.de.
 [109.43.177.66]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce8b4b38sm416730785a.45.2024.06.25.08.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 08:28:36 -0700 (PDT)
Message-ID: <f9f1a643-09ff-4fa2-bd72-2d8f6c89a14b@redhat.com>
Date: Tue, 25 Jun 2024 17:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] testing: restore some testing for i686
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240625145418.694476-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240625145418.694476-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/06/2024 16.54, Alex Bennée wrote:
> The commit 4f9a8315e6 (gitlab-ci.d/crossbuilds: Drop the i386 system
> emulation job) was a little too aggressive dropping testing for 32 bit
> system builds.

FWIW: It was necessary at that point in time since we were constantly 
running out of CI minutes, and that job was one of the jobs that was running 
for the longest time, consuming lots of CI minutes, while only testing a 
host environment that hardly anybody uses anymore.

But now we've got our own custom runners, so we're not that badly limited in 
runtime anymore I guess, so it should be ok to re-introduce this job.

> Partially revert but using the debian-i686 cross build
> images this time as fedora has deprecated the 32 bit stuff.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/crossbuilds.yml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 47bdb99b5b..5ba728f641 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -37,6 +37,16 @@ cross-arm64-kvm-only:
>       IMAGE: debian-arm64-cross
>       EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
>   
> +cross-i686-system:
> +  extends:
> +    - .cross_system_build_job
> +    - .cross_test_artifacts
> +  needs:
> +    job: i686-debian-cross-container
> +  variables:
> +    IMAGE: debian-i686-cross
> +    MAKE_CHECK_ARGS: check-qtest

Reviewed-by: Thomas Huth <thuth@redhat.com>



