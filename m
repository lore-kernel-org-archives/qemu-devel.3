Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD46CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0emM-0006jI-5l; Mon, 22 Sep 2025 07:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v0emH-0006j0-VX
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v0emF-0001jz-Ay
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pfEf0KPRFEi/1qGChhZlFYNcWUCNMDujVMEg7yKLIxU=;
 b=QtNvhj7lrGVExW5XrTwwfwcK8cnL71Le+plcMF6qicyVEWutKIAJ0Nd3mmCmZw//PQoZ26
 QyCHYDf+lRHErOIubxoio062Yf2BzIdaXvnjT3FazD1FHRF20OLfdwBeCfIKk2TNdRpyav
 mBriEQ5KamKCTolEjkjd5Fl63V+hcDU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-aD-gEgfXNKuZQTTPhlwxcA-1; Mon, 22 Sep 2025 07:32:10 -0400
X-MC-Unique: aD-gEgfXNKuZQTTPhlwxcA-1
X-Mimecast-MFC-AGG-ID: aD-gEgfXNKuZQTTPhlwxcA_1758540729
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so804777f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540729; x=1759145529;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfEf0KPRFEi/1qGChhZlFYNcWUCNMDujVMEg7yKLIxU=;
 b=H1ZwzclXoTXR15E1+Ayw239ZvGaGlhK4IagEy5YeLZwVVMNoT4k1AZKcJsjvEeevv6
 FRMMVF0APT7MRa7GJPx4BhAhyRmC7XTEl3sCQLciPH5ziqzrDHfUPG3OjpdAhrm9IRhm
 3pIygKmDMb3G5MFYnlqHYyA9yHJSWOHP5RTE+m8LYYGRFKAaww4/fTGzztzU0PCEc3U2
 jzuo+BUU4tT4PeboTujDreRFPj8k6yOdWrBHw4b2iPtNvAGEJo5k9V0KGbOipZ7n9w5/
 B48yweD17AMZUzkXT6jlZsT8dsSCfw5OwP7Cc2F4qo+x1Fm0Nf05oe/vpo15hJw0H111
 in1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6QhPw9XDNz4zW9ZnqBlCOhpIKoVwHAUhnPKbnZXfHz1tNdw8N8baZhnv2Z7Ixn+jXYGHEx9zJrF/Q@nongnu.org
X-Gm-Message-State: AOJu0YynEegYPsM2Wnh3SvdrqV0dQqJpxWIfQo50dbWXQ+9iDU+YWW5E
 zkSxIpR7zBHCWiRy909hxdefF+JgxPA+OdyStZX/s+5ibNogII4oOHkJGZUMa9MVxizqR2ScZpF
 dDJV6r6ccItlwcnIXFqMVqIPvcGqyU/0EN97vr8akUjk6Duv41CX3p899
X-Gm-Gg: ASbGncv+Y29lzMd9tGSnfPf5uyQjX/C2goM1xlc1Sx8kT43ifqwwvkjCwr+1pb3xtqI
 6AoX8T3NX3DPGCEEbkjtQkrYzQTMhGE3tbSXgo410nLHZpPQR+Zh8Vo2tbyRZA6kF8yJ0RRagb1
 +85oaDSnaD5vk9DhZC4qy7JRBd0MbnnXt7RMsvc3VOC4pSplvI0xhZ90KNGPet//r+iY21EEDsv
 ZIZRZBbUeUO5RNUQs24eUwBtMCWvceGheKxVNRS6mXDwAuVrsgPh/b+ofSCJf9jTTBNTQZg9YWF
 mSRGG0EC+5VU6RkGP/ATNmAjcY29xynKD9a3J55g7Q2F47HNMpVmwseV+lPE7DE04CvkDknQetU
 h00uT9Q==
X-Received: by 2002:adf:e006:0:b0:3f0:d752:34b6 with SMTP id
 ffacd0b85a97d-3f13bfea75emr6732257f8f.53.1758540728993; 
 Mon, 22 Sep 2025 04:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFodxjjZSemxbb9lOeMoQ1ZVlJu8hOn0b6k8/FHzJbTAC1J80lEnq202/80ILugoSc4IE9xuQ==
X-Received: by 2002:adf:e006:0:b0:3f0:d752:34b6 with SMTP id
 ffacd0b85a97d-3f13bfea75emr6732225f8f.53.1758540728536; 
 Mon, 22 Sep 2025 04:32:08 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0740841dsm19434906f8f.23.2025.09.22.04.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:32:08 -0700 (PDT)
Message-ID: <ab633307-4dbf-42c9-8c12-dcb22608cafc@redhat.com>
Date: Mon, 22 Sep 2025 13:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] docs/devel: fix typo in code-provenance.rst
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
 <20250922093711.2768983-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250922093711.2768983-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/09/2025 11.36, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/code-provenance.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index b5aae2e2532..af5d7349e12 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -331,7 +331,7 @@ ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
>   generation agents which are built on top of such tools.
>   
>   This policy may evolve as AI tools mature and the legal situation is
> -clarifed. In the meanwhile, requests for exceptions to this policy will be
> +clarified. In the meanwhile, requests for exceptions to this policy will be
>   evaluated by the QEMU project on a case by case basis. To be granted an
>   exception, a contributor will need to demonstrate clarity of the license and
>   copyright status for the tool's output in relation to its training model and

Reviewed-by: Thomas Huth <thuth@redhat.com>


