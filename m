Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE6108B8E3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WXj-0003jh-Fn; Fri, 20 Mar 2026 05:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w3WXh-0003iC-QU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w3WXg-0005lK-9F
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774000398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5euiBn3f0/O8o0xYggtpWQYDLJX6fZXYzFK7or9Ows4=;
 b=RSxhnoTQviYdel6QtD30MWQtysDGmjG5WgyDcb2pwPhF2hlTKj2ydD+yam/o28Y9Gv+mrv
 E/r3wjOeN5/ADWTiZ2pLH/ZI2EUvXcjK+sFR/Y4V29D0J2q0cVErd0HzsoS6txp9UvmSuD
 AYVSDAjb6Pq5p44qRebh4KyUlO7SqeI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-jZNRRSd-PLaYIV-AT2_6MA-1; Fri, 20 Mar 2026 05:53:17 -0400
X-MC-Unique: jZNRRSd-PLaYIV-AT2_6MA-1
X-Mimecast-MFC-AGG-ID: jZNRRSd-PLaYIV-AT2_6MA_1774000396
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so17053295e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774000396; x=1774605196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5euiBn3f0/O8o0xYggtpWQYDLJX6fZXYzFK7or9Ows4=;
 b=KtjCiR7D2KdMop25b7+cKRoBY0EMPQfzTp6wOMKEuYOWiABPCJalciRChycrPOFaiZ
 l9MOk3H0vzm2G3c1KtnRULU9c2EjndWKH8mOFRNvRX7oCHQDLbQcl/DKyNjNoAlKKvvf
 gcCAUKPthgP83hIR4rG6dRd24hoSPsd1NGlWh+iyP/VDoy+XSKf8psu0gO7YrnLteIPE
 ZBtw1cOxO5N1p2cbFXrwNcGOAWqGKQcUu3hN8QdwggGCEojxyVbVZFAxxMy/s6NAAYZP
 V/X+8J4BnmfNgupcucG5/l7/1+HossRQc1WXsdsNFJGzXNMo2hxgseFSB0tBKrZiVfEC
 JdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774000396; x=1774605196;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5euiBn3f0/O8o0xYggtpWQYDLJX6fZXYzFK7or9Ows4=;
 b=qiLTwMzutcPSTBDibnSVA/ALkLkJDA1qnwH/Z0JQluHEGJoh6xhFAFntyP+9mwuHgj
 M2IfbANC/UAjlktRrTWpD2I1i4dV88oZMBiB3p4UJI+4GCEXYr//N0KdR5U22lX19ZLk
 7IxloBZ87mCYgOp5hde/f8az3B5Av1SrcjuwsVi17MH9OPTuShMEDGeGCF4KPOyJKG47
 NeDjyQrPtGJa+8rm8+f04hh60sd+Ra5tqNV/NydSAILCCGzJrZvH0CQHyXHj87Oqxyf+
 fQrysUf6i+YJtjCEE6F2M5zQ5y/nWgqtYM3ybFCFCrwGl4BnKmtseuhJYmoIuH6eE8wq
 VknA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnnkUxPFy3LQwUCA/CaS4HfmTE8zaHC5JLT0UvzEdo6kqiBPbuBNYWPMOu+HOJxak848SQ/TxO2FL7@nongnu.org
X-Gm-Message-State: AOJu0YzskmqzJPwd2cU+RiZLR1+g7TKJRXbuCHcWcK0xm+r3mA+v5W1d
 7VXvgerImTvsmAvQeWhK73FoKL0YullJVIY+QhKMsigmdviGwINYzGgYvcjl/3gWkSR3nNL+iJC
 4Gm8CpDu8T0gpQqzQVAUm6zLyk/2ITH9NvhrwPk/7B6Kw3cjMdeQni86S
X-Gm-Gg: ATEYQzy8k/ffdl1YRzeFihlMRltRqxBIgTvxPiCGjDyfVuIp0Bxpb83FnZyXfczBYPz
 vGNNlhX7H0pdL6y23mpJHrwTUSyIWAkuW8FzwldD3Cy0oADR55WGD0hlJUuMqFmAI2LVlIGEAyz
 cfkgOEVoZMYnat2bMY7gmNLHvQcFktqi82Q0eGiuEbyK2JJ4hprPvwmU2L3dOfbgGkCYBx7dBGf
 O8RTEYvMKcbDvK241mrXU8dcPzyZgrVzJV5mdMeZzcSCRkxtZYTnwg1feZztapkNTEwhd0I4C+e
 JOyaBeA8/xu4/cblFofXsum0FEoGswDZwrZjOmZHLPLvIRvn383P6DjoOtC/5NUO0UuXPfxBr5b
 MVf8BGwg85kemlZi+Rw==
X-Received: by 2002:a05:600c:8b18:b0:485:3dfc:57d with SMTP id
 5b1f17b1804b1-486ff01ca8dmr31706795e9.30.1774000396136; 
 Fri, 20 Mar 2026 02:53:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8b18:b0:485:3dfc:57d with SMTP id
 5b1f17b1804b1-486ff01ca8dmr31706445e9.30.1774000395739; 
 Fri, 20 Mar 2026 02:53:15 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.47]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd38bsm5164036f8f.10.2026.03.20.02.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 02:53:15 -0700 (PDT)
Message-ID: <e328d1c1-92cf-4b46-a920-0151d5ea2834@redhat.com>
Date: Fri, 20 Mar 2026 10:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/21] qom/object: use BIT macro for ObjectPropertyFlags
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-2-zhao1.liu@intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260210032348.987549-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/02/2026 04.23, Zhao Liu wrote:
> Standardize the definition of ObjectPropertyFlags by using the BIT()
> macro instead of manual bit shifts to improve readability.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   include/qom/object.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


