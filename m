Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C62CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lwG-0007iu-Kw; Mon, 06 Oct 2025 10:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5lwF-0007ib-Kz
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5lwC-0002NV-Cv
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J63yCZy7pfxM/3no1YdElWKiRBMLIRErNOKlLX491tY=;
 b=Yemuz96jZ08BdHSrXoLoQASEV691cBcOCgISsiv1qejBXQQU0MYvoojhFvpM3htqCwcByG
 UNC4dXO/MGnDQrLhDYD1S/Q4KixhKglMYkuC2cK+UJZqaTuDGSnEDBnqOF5/86zEHQ0RNx
 s0UnwRB/Z796azkuD1PBKvlsHFExDmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-CaYik3pBNQSKrFny9eFi5w-1; Mon, 06 Oct 2025 10:11:36 -0400
X-MC-Unique: CaYik3pBNQSKrFny9eFi5w-1
X-Mimecast-MFC-AGG-ID: CaYik3pBNQSKrFny9eFi5w_1759759896
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so29974195e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 07:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759759895; x=1760364695;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J63yCZy7pfxM/3no1YdElWKiRBMLIRErNOKlLX491tY=;
 b=Tum9E8nxLNJttUmRMlKBBduDQMMFoAfOUFiSIRTYyQDi+QXuXUHqzNx++dN3zpvjPl
 mVmM+REBlukGvpg7F3jSEmLTi06q30ZFwOWmdCVO6hz3ReeHub3IiPXcakrUtUYkjUC/
 bVyjrcY0INp1bioTG2gmPItxljNk8Wi20uAKQE2el7bjODyTI//7/tDaVC/YQhPHiome
 npF1FSZmZni1C1sQpwAcQBvLZy+tWil31uEaWWBMybEM7bxHkBoo1H1vx6JwsXozbvoO
 Ah/vK1bwRKUQPN63D0/vMa/3x2f/H+AuRwj3SGYTiKq1PDTQEE6nC/fntbxfwEoK3Rc8
 OozA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXBZFcoz3SGhYkzBaoX3dWXzuJaKu/rk9tSs/LKz7n6kVpPelsKlocvKMz0Hj3VJeTUMbLhjOdfGPe@nongnu.org
X-Gm-Message-State: AOJu0YybKniWRHIwmTyVaAjSXYKsNI0tAf0+F5oXecSrN4TqTkvrHQn9
 qllta6XBDZoyKJOfUFf0lvUKk8Ylm102PbEj1MFh7I2Px1KG3ljh5h6cVccSYZXIUeJMlPAja9B
 8w/A3amaVCEkWTMkeX03PUiqUKTjPwcloVPDKvnzhcp9a3Yy34Tf0dKA4wk8loA6w
X-Gm-Gg: ASbGncsFNCSw22MhmOjZ0rIlFsFJDU0AFgiWKjVCUW+Y/NXfIlf+R3/hF1zZwzQn3ad
 n8kVNy0q6U967oi3ePPD7TdP+dnsCBYW+rBtfLOOkaqottoKlGRub9mLAM/KONDXPpMn7oqbJPF
 kMgZEVSy3g0IyWxKVqbKhcJXEnvS9KOKvsP5dqZTm9woyL/QPguk38j3HaEjT510e/9PBAYPFEc
 IK5GlOXDtPtPt1i1KfrBu1a1HK3yFVMxs2CVcr/udT5O+ScP+Ei1XV58rIvXvgpgLgnov6d1MRE
 JRskxK9TZchKw313JvzvqnPJLL4vLbd/qgA5xLa6x51aTNU5DRHgQiqH5j3kHkA6rQ9kA+zeE+P
 J2b7DVgCJbQ==
X-Received: by 2002:a05:6000:1786:b0:3ec:2529:b4e5 with SMTP id
 ffacd0b85a97d-4256719980emr8894944f8f.38.1759759895535; 
 Mon, 06 Oct 2025 07:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNbwsWVPEuMgtBf72UsW0KqB7vDEFmFM3or0RnDq1lrr1mUdqaQXn3wYCEHD9SXkNvl4m22w==
X-Received: by 2002:a05:6000:1786:b0:3ec:2529:b4e5 with SMTP id
 ffacd0b85a97d-4256719980emr8894918f8f.38.1759759895142; 
 Mon, 06 Oct 2025 07:11:35 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm21091113f8f.41.2025.10.06.07.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 07:11:34 -0700 (PDT)
Message-ID: <117fcd23-f853-44b6-8fff-c5672fa5fd5e@redhat.com>
Date: Mon, 6 Oct 2025 16:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/s390x: Reduce s390_store_adtl_status() scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20251002091132.65703-1-philmd@linaro.org>
 <20251002091132.65703-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251002091132.65703-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 02/10/2025 11.11, Philippe Mathieu-Daudé wrote:
> s390_store_adtl_status() is only called within sigp.c,
> move it and the SigpAdtlSaveArea structure definition
> there where it belongs, with other SIGP handling code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h |  1 -
>   target/s390x/helper.c         | 40 -----------------------------------
>   target/s390x/sigp.c           | 40 +++++++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+), 41 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


