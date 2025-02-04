Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86444C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKXA-0002JV-Ff; Tue, 04 Feb 2025 10:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfKX6-0002Du-8J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:08:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfKX4-00068e-Ih
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:08:11 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dabb11eaaso418645f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681689; x=1739286489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kP6w1WKkihoHD3ir22CroqPv5+rX06byXpKNAzNtDiI=;
 b=SAxCagHTHtawH1RWWyph2ykG3poAkqb8X70RKu2x9HLVSMQhUJQxSU8kOkpdIMmiDU
 7hHz6qqiXBnOBqef5NxqJZu0awKWCoo35IEfieBev4YgGCRLuoyPlSp8RfEUljixpFdu
 CbeuKN1j7QdjUqdIcl3Thjuy2wAT9NcPNnOXN05nSSvbcIid5jQXMOmECb2YKasKQPfP
 RPDLiqSZZr29iVHFpXxx93vzcLMtjpgr80DtA1zjNyr94DNC5zO3BlYaMKwDixm0ysME
 jHxAq04CqHQIN5QyKK4UYZLtVzNnK5xt5K8GqbafLbtne05RV63zcPQezXM+1DzZDOxP
 wEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681689; x=1739286489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kP6w1WKkihoHD3ir22CroqPv5+rX06byXpKNAzNtDiI=;
 b=RDtJ9gBirAzb8B37sGI6alR8+3nt1BuZUnmWVTHwISeTkTyyQiSK3FeIuFsLb5hygL
 neeXBRlSJD7AaPw6MZgSM0vYj/aIpoOXzXKjnm1G19HIeTjRcibHHxz/6//SxDQbHaq1
 UvMaayOip38zdFF6dm4KjUWSP8P2297TSQWKgy6VB9HxOzvb3iXnuflZqwQROJLdetEv
 rtNjWQNjigAwyTmKU5aoNYaVotmiTD2qHTTP6pdnwlMBOLK6iMf9+pZoCIQCCM6SN+87
 J8qJtXj2ozrQ+vu4julXoTtCvGfEXc9tHcLsBlVgzwKzaJb4r/WTU9wJpDfDzyOyyD7o
 ZE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSrR8wE1aSCK1gsYsgbDpMFbrKhrqVB2f7zZJ7rPXnBgGFh80Ef64F6YL0FOefQtGFzpF11VD9PnXU@nongnu.org
X-Gm-Message-State: AOJu0YxSbT8kON5MTEOpnCYlnwYkWL8sWBPkM7XT8Q6Wp8eKooNfkUIZ
 2Yw0LjkZLk8pFDtxpyHZdwB7S+uPzTvB9zPHBdMvrmqolI5eEOIoR9mdr8aWrzg=
X-Gm-Gg: ASbGnctHofK1nNWf5jjwtv0i9Ia1pe1PkAVlBOpl0L8wloxpVEd1mwELHcNpfOdpAbU
 aGVktlf4G4M7C74qe1sVmdCLTy+CSO2d+TX7L6E4LPksM5Ym2b8U8nNE0qgBkNdoBawmqCNfCKu
 /dYZwWYo0yAd8JUaFtK2DxMLDarzTkQsR6HQEJNYa2lnHxl7TIRyJ+aSAO5ngHIGhpoy8PJe8Nf
 BUcH/Q7ePqeZvIUq4fH6eSPkpalxMA+QVAddS6SZ7nocXcWLeU8v9CL/7JkBWEYHdSO+Lu8kvO4
 PzfCoeYDYqlNAQ8lQCP17x4rJMAW5/KKZwuPqRBgPABKBZRf5VvNJFxo5HU=
X-Google-Smtp-Source: AGHT+IHXnoUg7qOq6J0VNQzwNvILGCVxFhg2TaDyi+YFuK3oU+462PYzluugSGowLHjFHiptyKq7vw==
X-Received: by 2002:a05:6000:1445:b0:385:f573:1f78 with SMTP id
 ffacd0b85a97d-38c519744e1mr20670393f8f.24.1738681687061; 
 Tue, 04 Feb 2025 07:08:07 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38da676457bsm2501642f8f.101.2025.02.04.07.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 07:08:06 -0800 (PST)
Message-ID: <bd5ccffc-5e8c-4b87-9168-01a964dd6f0a@linaro.org>
Date: Tue, 4 Feb 2025 16:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: reverse order of instance_post_init calls
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
Cc: peter.maydell@linaro.org, mst@redhat.com, alistair.francis@wdc.com,
 xiaoyao.li@intel.com, Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250203114132.259155-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203114132.259155-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

On 3/2/25 12:41, Paolo Bonzini wrote:
> Currently, the instance_post_init calls are performed from the leaf
> class and all the way up to Object.  This is incorrect because the
> leaf class cannot observe property values applied by the superclasses;
> for example, a compat property will be set on a device *after*
> the class's post_init callback has run.
> 
> In particular this makes it impossible for implementations of
> accel_cpu_instance_init() to operate based on the actual values of
> the properties, though it seems that cxl_dsp_instance_post_init and
> rp_instance_post_init might have similar issues.
> 
> Follow instead the same order as instance_init, starting with Object
> and running the child class's instance_post_init after the parent.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   qom/object.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 157a45c5f8b..c03cd3c7339 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -423,13 +423,13 @@ static void object_init_with_type(Object *obj, TypeImpl *ti)
>   
>   static void object_post_init_with_type(Object *obj, TypeImpl *ti)
>   {
> -    if (ti->instance_post_init) {
> -        ti->instance_post_init(obj);
> -    }
> -
>       if (type_has_parent(ti)) {
>           object_post_init_with_type(obj, type_get_parent(ti));
>       }
> +
> +    if (ti->instance_post_init) {
> +        ti->instance_post_init(obj);
> +    }
>   }

I'm not opposed to this change as I had a similar issue there few weeks
ago, but I feel we are changing one problem by another. IIRC some class
post_init() handlers check the instance correctly did something. But I
don't recall any example in particular. The documentation isn't clear
about order (include/qom/object.h):

   * @instance_post_init: This function is called to finish
   *                      initialization of an object, after
   *                      all @instance_init functions were
   *                      called.


