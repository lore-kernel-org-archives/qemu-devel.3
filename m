Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662EAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmjh-00019m-Al; Tue, 13 May 2025 06:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uEmjd-00018w-OG
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uEmjb-0000YJ-4T
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747131576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cRFVwNL/q1APjBkV0o0pxCp932asVyl0IyTJ08vI01U=;
 b=W0dE3m1/nhWQVlVBQRDn39MnxFLZcWeTp2CjIMARZm1n+tVpIr/cE0aV3R+eNljPMPbllN
 L+yGgGYFXrmIEYRLKdFFxgxzJe297Ef+4sgjTLteLkcjO1R4O0aYrz59dqz4dUxD8JqGDU
 yl0TOZ6rvm8DZDV4wYjRAE8ISFKLt1Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-epgPalCtPyy9ud1VNtrPrw-1; Tue, 13 May 2025 06:19:35 -0400
X-MC-Unique: epgPalCtPyy9ud1VNtrPrw-1
X-Mimecast-MFC-AGG-ID: epgPalCtPyy9ud1VNtrPrw_1747131575
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso18462555e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747131574; x=1747736374;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRFVwNL/q1APjBkV0o0pxCp932asVyl0IyTJ08vI01U=;
 b=BKLDhylxgxIOT39l8XsVrsFs3amkWnXVdSEYMC21dIz+yrQZwvFACa6JYicR5jXj1q
 /POeZDPNTkFhXzf3n1anp3OMxgdEXAxtLCHTh975cOx/rEUPBL+9iGHaCxpk64WvhXS5
 vlAIVTu9SGNANeEtdjjTh8l82EBIcEOPwrmYygAgHLLJJCXJrstNoU91w7IN5mVpWWaf
 +aNmMYSIlosg9eQTF2h5QLTBxA8Ib8o7t1eaq7GpRFhH6zbBtMqT3G5jZDxkNermoqus
 iEK4SRYoRkOogXKkt/cAlmL+eaAaEnjX7GXGSubOn181kq+C3C2vxGqQTE7ThvfyW6Ls
 GRZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2NIVLwg419k7CDQwOAFa2uNXbOMLXigKU6sxPqpI41iPKixpwNxJiQdyngjQYCFFNwHqOkC6As2cu@nongnu.org
X-Gm-Message-State: AOJu0YxAz/+3EtGolvaKXW0S40X2zvepsfIilMtWnZtI/mQlQGrs3r3b
 6fEwBf2r8PddgvFYa/8hgRxLfvbs07Wu0LCP4vJ1908agOuoPb6jxz4O1mtY1rs4ghZusQOVhtM
 WsL96QgYjE/SJn88WJRsOqq3PlEUNoZqt4ltAh4UrURcefFkUrSpyhc/7S8CCpl4=
X-Gm-Gg: ASbGncs6d0oRl5fi66LswTVxdAd8GXsv52KzDAPoyUAE3lDgYfn6J+ymlosdlo2qSZY
 8d1ajYljw+0AWG9kTCuCvQ5MLHaevxZ9scjg2xrDSxudvUj89g/lpTBTzgfxLDUz0tw5zHcWwFH
 Fq66vpungU2hpiD93Xgz7iea3DbZRxZU4CoSbQAzHEJtqDkdP1wFsD1ClHvCnJcCW2PytWoq98N
 USwcfx6wGYfcqHMXpuvVd/3Ku8dHUwV1YgyJruoSlfI6KUBBAWX9afMvzryuHBzrMxds0d/JvzB
 RwfMLQOUuCSjbj2bRMSO4eoK4FOevYQaiB/4Ue+Ubw3r4ybVrg==
X-Received: by 2002:a05:600c:528e:b0:43d:7413:cb3e with SMTP id
 5b1f17b1804b1-442d6d17f7cmr124317975e9.1.1747131574437; 
 Tue, 13 May 2025 03:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNUIon00bmYlDe7stP5DZ8HC4iMOU4AHZ9WLY6KLjjXT1qIJwzTiHomLVsefjc0OfbTGmBFA==
X-Received: by 2002:a05:600c:528e:b0:43d:7413:cb3e with SMTP id
 5b1f17b1804b1-442d6d17f7cmr124317655e9.1.1747131574054; 
 Tue, 13 May 2025 03:19:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442e9f1d1bbsm41332385e9.25.2025.05.13.03.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:19:33 -0700 (PDT)
Message-ID: <cf58909d-f0cd-453f-baf6-898139cc8bd5@redhat.com>
Date: Tue, 13 May 2025 12:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/qtest/aspeed_smc-test: Fix memory leaks
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250513080806.1005996-1-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20250513080806.1005996-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/05/2025 10:08, Jamin Lin wrote:
> Link: https://patchwork.kernel.org/project/qemu-devel/patch/20250509175047.26066-1-farosas@suse.de/
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed_smc-test.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
> index 4e1389385d..52a00e6f0a 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -228,5 +228,10 @@ int main(int argc, char **argv)
>       unlink(ast2500_evb_data.tmp_path);
>       unlink(ast2600_evb_data.tmp_path);
>       unlink(ast1030_evb_data.tmp_path);
> +    g_free(palmetto_data.tmp_path);
> +    g_free(ast2500_evb_data.tmp_path);
> +    g_free(ast2600_evb_data.tmp_path);
> +    g_free(ast1030_evb_data.tmp_path);
> +
>       return ret;
>   }

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


