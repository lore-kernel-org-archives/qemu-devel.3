Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728ECC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRuc-0004SQ-D0; Mon, 12 Aug 2024 06:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdRua-0004Nc-E0
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdRuY-0008KD-4H
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723457061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WH+34UDAHX79Po2Yq7ExNVjTPxlkArwIEowUs+SryDk=;
 b=BoE4kdFH25+YB0/dnnzG1h8Q2VtiDNwOHfwVIyKVQ/LcwUNAGhhOVZfyuYWbhg+XscyMPg
 iIHCh++liHNgNGcLIKUH69O4OOSAxnM9Q9WW4Q9HWeDCCeD8R2N369H7enywtDvxFlsxoS
 D4OkdWYYDsZk8AKCMta8d6d7Mt2Bklg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453--kEbpWt1Mlug3wNn_-SYug-1; Mon, 12 Aug 2024 06:04:20 -0400
X-MC-Unique: -kEbpWt1Mlug3wNn_-SYug-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52efd4afebeso4855871e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 03:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723457058; x=1724061858;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WH+34UDAHX79Po2Yq7ExNVjTPxlkArwIEowUs+SryDk=;
 b=Yk1ctsrHUqdmUjecr1bq3Cp3sBtB06RDIHXiKBSH6TdjEHLfRCQ97cEyftML4mlgz+
 B2iPmDbs5oMF1lWiiBfpeEUVWP+EVP5B7iXVPMSZcwaDRXfxkUUvZuGF71+QPUyJUsdS
 ZkdDQHfN0rgxCypYVkuKaxvXBwC/p6qjqIJJeFab2ZeuJbecayziCOuPNDQBIUeS4taJ
 6S7b5lhOeI+P+3/f4JK1+eWy/d59lFfQhnVUcQnJWI9uDbvGrB6qaQKAegQ+GVka2cpO
 D8AC2RqNm6GfN6PtBUnHzHfiP7MWg/IybLqrbNpUKidKdQBnMclJSHyiHYJmUio28cmT
 Mu/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1c4Rv+eKYcXFZMEZVrHLh7qxN5cpIz7sfrVXAY7ncQsn6EdHofC8QdChpq7Lph5SEfYSm+mHurI22SpHDfmFZy24mYHM=
X-Gm-Message-State: AOJu0Yz80G0iebKh7mQea4/TLgVlK62NSdoKJjISYbXqpecfTyDWSmH1
 XS4JEcWEXJSEN7WXG9+T3UIL0SVAmdnpDhhrTp3e+6sYd3b/mEjng8Yvti5VBpJV+O/UlGHzQgJ
 TCvX5Pp0Il2sYjnOmbmH4rY47xAen/HrLhhjo0GbWA3ByljLmpaz3
X-Received: by 2002:a05:6512:31c3:b0:52e:9ebe:7325 with SMTP id
 2adb3069b0e04-530ee9958f5mr6282359e87.31.1723457057827; 
 Mon, 12 Aug 2024 03:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK+STVX8B0xyGRx+La+5znM6BFUq1kpM5Ysu0IPnW/eI+XUkLxbNRlUYjVBqeS0udHBDKzRQ==
X-Received: by 2002:a05:6512:31c3:b0:52e:9ebe:7325 with SMTP id
 2adb3069b0e04-530ee9958f5mr6282294e87.31.1723457057213; 
 Mon, 12 Aug 2024 03:04:17 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-125.web.vodafone.de.
 [109.43.178.125]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd187f5671sm2009223a12.3.2024.08.12.03.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 03:04:16 -0700 (PDT)
Message-ID: <ae5f3a65-4cee-466b-aac4-ddd83c8fd1e5@redhat.com>
Date: Mon, 12 Aug 2024 12:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] tests/qapi-schema: Drop temporary 'prefix'
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au,
 andrew@daynix.com, arei.gonglei@huawei.com, berrange@redhat.com,
 berto@igalia.com, borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com, kwolf@redhat.com,
 leetroy@gmail.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, vsementsov@yandex-team.ru,
 wangyanan55@huawei.com, yuri.benditovich@daynix.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-3-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240730081032.1246748-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/07/2024 10.10, Markus Armbruster wrote:
> Recent commit "qapi: Smarter camel_to_upper() to reduce need for
> 'prefix'" added a temporary 'prefix' to delay changing the generated
> code.
> 
> Revert it.  This changes TestUnionEnumA's generated enumeration
> constant prefix from TEST_UNION_ENUMA to TEST_UNION_ENUM_A.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/unit/test-qobject-input-visitor.c  | 4 ++--
>   tests/unit/test-qobject-output-visitor.c | 4 ++--
>   tests/qapi-schema/qapi-schema-test.json  | 1 -
>   tests/qapi-schema/qapi-schema-test.out   | 1 -
>   4 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



