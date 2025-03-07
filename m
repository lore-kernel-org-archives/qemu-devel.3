Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA0C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSeH-0006bE-9S; Fri, 07 Mar 2025 03:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqSe8-0006ad-Ig
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqSe6-0007Xq-Tx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741334484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XbDePPgsD/75RKsQYUCL2uJEcXU5mvZhyFBRWh1z+28=;
 b=G89bUbmfQBc1PdrrzIl+qRmRqaZD3g9RnJX2nCTrwqQDY2bvNCloSXau2n6wDoK88nvv27
 Icfecj0FDXvAL/ev1NOKjbBblWQKbenblFr5xv4iqBcTy9oHxukD0mFaMbL3UQrdD87jX+
 073xUq+zFMEDwkFeA4gqTqkKcSc8K+U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-OXA7u0tDNKaduwNpA0dpSQ-1; Fri, 07 Mar 2025 03:01:22 -0500
X-MC-Unique: OXA7u0tDNKaduwNpA0dpSQ-1
X-Mimecast-MFC-AGG-ID: OXA7u0tDNKaduwNpA0dpSQ_1741334481
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so500538f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 00:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741334481; x=1741939281;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XbDePPgsD/75RKsQYUCL2uJEcXU5mvZhyFBRWh1z+28=;
 b=CilziRnjnn8KmlbyMcle/xppihbSDJOTBdP9lWej5PEnMcRH1yKT9m/uO6CbGKlG+H
 mzbD5lhJfFQlNjMRq2ciV6KEZjxPP1Mju191USVGCCmxVaas5XgoKpchSl9urMHUIR4G
 58Cvq3hvFnA5uYc87HtPLRyLx9sNm8eHCVzhucU7TNWHKxLqMalH7TBjIYxItuH+8/o8
 xQ9ByoOW5NIyYV0H8NhulnB6skkqbHlDcZRKT7OP/ECVDMnR1l29gwLQSQMlT9JNAQK2
 1jCkDCpNeVUK4D3Mktrd3FvdKvETF5hvDRgWKNI6V+m43HL7cs0QERJ7JgZ1Kg0niVBv
 YM3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4bNzDzcdE42ts8D+7M2AD0yiBhMVvx3R6FdcHKYFi0WqvHpDmzew/av5xHczD6OBej18ZSZ4d7UnQ@nongnu.org
X-Gm-Message-State: AOJu0YwofK7WrIQcSYru9kqFRiP8wVS5meLlu6AdRwSnsdYU4PK5Hq1O
 nu7L2G9xnmhVxP3gh/gvHUEFv7/Q5KEWt7ou3UGpG3JpoScOvDxKA6hnHsdTgtOM1EAbxnjCBdE
 yD/NUNuVIWjVxaXyM6GCr4vBF8fR3izaK2xlzT/MLFvGiN52LrjXt
X-Gm-Gg: ASbGnctQ897nlxjvMWBYnC+/6rN1xFWUykFgOPoqxxPWoqbAs+aBR7mi6ZKeYXXdRqC
 q+y5gOvhXzu/AJ4/oYI53GVReodj/OrRmqOMhJbnRVa3ZVi4wOwWu9mDN3dIR+vt8VNv8S5u38S
 oleG5OaY3FLv5r7gUu6C/4XWb1Wc+DoiijcIF6g2543/F4wk1kHsa06xqv1ypf5j/FLHa5zuNfR
 jdbDfTonLmvs/mp0EmSiKD+O4NLpfMP8MW0mc4uCi3oRGQ4ZHCFYXZaCMx4yb+lrjlCBXF6yITi
 A/3T205LJmZ0e5H5JJwdqf5qsyf4DITM3WGf5eMC9TiuSrERhhQtvtAkUYyubmLYboMrrjlcsyD
 YwDk3HazWp1gIfYiEScq3eRjLCIbcUktghMomHg==
X-Received: by 2002:a5d:47ad:0:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-39132d7c9c0mr1476894f8f.15.1741334481186; 
 Fri, 07 Mar 2025 00:01:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2JT76T2bmDch13XNwuBWH0iGkItnP8nnKexWTUuscpz4ozuKT++mP3FcJw+SXwW9KiaItEA==
X-Received: by 2002:a5d:47ad:0:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-39132d7c9c0mr1476864f8f.15.1741334480789; 
 Fri, 07 Mar 2025 00:01:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17?
 (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de.
 [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9b6sm43440965e9.29.2025.03.07.00.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 00:01:20 -0800 (PST)
Message-ID: <160b44eb-bf3f-45c9-b1ea-c82dbbe40bb0@redhat.com>
Date: Fri, 7 Mar 2025 09:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_virtio_balloon: Only use KVM for
 running this test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20250307063904.1081961-1-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250307063904.1081961-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 07.03.25 07:39, Thomas Huth wrote:
> The virtio_balloon test is currently hanging for unknown reasons
> when being run on the shared gitlab CI runners (which don't provide
> KVM, thus it's running in TCG mode there). All other functional tests
> that use the same asset (the Fedora 31 kernel) have already been
> marked to work only with KVM in the past, so those other tests are
> skipped on the shared gitlab CI runners. As long as the problem isn't
> fully understood and fixed, let's do the same with the virtio_balloon
> test to avoid that the CI is failing here.

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_virtio_balloon.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
> index 082bf08c4e8..5877b6c408c 100755
> --- a/tests/functional/test_virtio_balloon.py
> +++ b/tests/functional/test_virtio_balloon.py
> @@ -110,6 +110,7 @@ def assert_running_stats(self, then):
>   
>       def test_virtio_balloon_stats(self):
>           self.set_machine('q35')
> +        self.require_accelerator("kvm")
>           kernel_path = self.ASSET_KERNEL.fetch()
>           initrd_path = self.ASSET_INITRD.fetch()
>           diskimage_path = self.ASSET_DISKIMAGE.fetch()
> @@ -122,7 +123,7 @@ def test_virtio_balloon_stats(self):
>           # reset, we can reliably catch the clean stats again in BIOS
>           # phase before the guest OS launches
>           self.vm.add_args("-boot", "menu=on")
> -        self.vm.add_args("-machine", "q35,accel=kvm:tcg")
> +        self.vm.add_args("-accel", "kvm")
>           self.vm.add_args("-device", "virtio-balloon,id=balloon")
>           self.vm.add_args('-drive',
>                            f'file={diskimage_path},if=none,id=drv0,snapshot=on')


-- 
Cheers,

David / dhildenb


