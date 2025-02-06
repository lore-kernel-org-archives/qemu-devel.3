Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC8DC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfy6o-0004wt-Sm; Thu, 06 Feb 2025 04:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfy6n-0004ul-BK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfy6l-0002au-J2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738833818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z6SZuuILFAfFaC/XRwySlhlTVSeAti5btC0OO4mWGGo=;
 b=hh/hW2LdCi9nZecB1M0MtgwSR68GgmuG+cFzH7xhs5JXfRIB1MZlgfNqDz2ZiSqTHYPQTR
 2PyzPrFCFCBpsRspgWmBEeX8NdioWDNUo4eWYNYARo1L3ZhiqIzJkn128pDsrGh3CQEgWr
 VavaWXMn6SXF/wCcea84IqM/NEhG+CE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-IlNM4MwINMW_yGn_A_xdaA-1; Thu, 06 Feb 2025 04:23:36 -0500
X-MC-Unique: IlNM4MwINMW_yGn_A_xdaA-1
X-Mimecast-MFC-AGG-ID: IlNM4MwINMW_yGn_A_xdaA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38db3cbd289so480102f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738833816; x=1739438616;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6SZuuILFAfFaC/XRwySlhlTVSeAti5btC0OO4mWGGo=;
 b=LjeCV39FaDZXWWFP/MgjHU3UDpOpbISvtMrobCD6JPjjTpa3NPjbARMCGAppb5xfSm
 OxxANZ6wvU7rLGnWiun4iUAwk3vtdKia+hWnGfFz6jdu3wjbU4+eGgBfRN+qZFh/vqhe
 j1rXxIamvoQB662Vn2iwtJL2te368RYBA+AAJtl057Q7pxOY+P9qMGcKc1a5WtBVzAFH
 QJeoN5++QoGs2KQd1a1L/aR8IfDQkZAS9nM6twHUJ1lsPqbezjiAaYWT5eRVAkAHZCxT
 LhejsbpSZKIhrtNqg1Rfz3jxg8drbMVJkukrGDOgNl6RoO8kgONh1XdQ49r7W9MvGkNu
 Okeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBgZAomh8H26A4HqnKueRGh7yu5zzeNbJrOEKfGmEqFdHwsILLff69MDPcujrzlxQvqXs9UZGyR9WK@nongnu.org
X-Gm-Message-State: AOJu0YzOAKzm0y6D3r/5aDgqqxajsLUr9oqAgBiwzyL1NwUXhswt2Tvo
 J34WTsSYorvvBW1GgJUMV4xfy1qvJVUdSF/PaZ4PfZhUvSmYMJOK17STwIeBwBPuxJRrA0ZFjq7
 eylae1irPNdt4+MOh37Ncb9JsXx6oLJi1X3dXyainOytW9zs+fIIi
X-Gm-Gg: ASbGncsTooTGN/gcG2Zbroahku+8gLqlXE0nDbDx42jj/VxyX8V09Lxdb3gg1OntZ19
 NnsUbv5e/gOdU+6wTojRGLBt2e0uZX1+ZiIr7scUoQE5Sleb2LuJlCQ89MIpzjze49syrRHdvsV
 c/S+O02F9TLmwOUkBtXPujznVgXzDKI4eO6AKTMbihoeFWfsUthHhJR7qLv39Sgmgq9+zArjI76
 9rIdPtIFgHorkyICL3SYickH1k4KE09428nlhZblq+pMs4emJCq7+z0z+69JnjXSVglEGJHyT63
 My8lqnyCmRCCOXPScMQ/lQK4zFYPsJGcgFsJ
X-Received: by 2002:a5d:6da8:0:b0:382:4ab4:b428 with SMTP id
 ffacd0b85a97d-38db48b4201mr4308626f8f.8.1738833815772; 
 Thu, 06 Feb 2025 01:23:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1r8RO8l8pGQhtEP17QjzgjagZ5nRLgVz49q40wvjM7dPC7/2X7Xvdc+ncnG6XOJdZ4mRaxw==
X-Received: by 2002:a5d:6da8:0:b0:382:4ab4:b428 with SMTP id
 ffacd0b85a97d-38db48b4201mr4308605f8f.8.1738833815431; 
 Thu, 06 Feb 2025 01:23:35 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc0c5a894sm624389f8f.95.2025.02.06.01.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:23:35 -0800 (PST)
Message-ID: <40b3a90a-0f42-4804-ae00-48927c89b37e@redhat.com>
Date: Thu, 6 Feb 2025 10:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/functional: remove unused 'bin_prefix' variable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-3-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250205155946.2811296-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 05/02/2025 16.59, Daniel P. Berrangé wrote:
> This was copied over from avocado but has not been used in the new
> functional tests.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 94541e8bfb..332c782ebc 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -192,7 +192,7 @@ def assets_available(self):
>                       return False
>           return True
>   
> -    def setUp(self, bin_prefix):
> +    def setUp(self):
>           if self.qemu_bin is None:
>               self.skipTest("QEMU_TEST_QEMU_BINARY env variable is not set")
>   
> @@ -256,7 +256,7 @@ def main():
>   class QemuUserTest(QemuBaseTest):
>   
>       def setUp(self):
> -        super().setUp('qemu-')
> +        super().setUp()
>           self._ldpath = []
>   
>       def add_ldpath(self, ldpath):
> @@ -279,7 +279,7 @@ class QemuSystemTest(QemuBaseTest):
>       def setUp(self):
>           self._vms = {}
>   
> -        super().setUp('qemu-system-')
> +        super().setUp()

We might still need it in case we try to add auto-detection of the QEMU 
binary again, but yes, for the time being:

Reviewed-by: Thomas Huth <thuth@redhat.com>


