Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661B7C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBprw-00063R-RT; Mon, 05 May 2025 03:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uBprv-00063E-MN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uBpru-00017G-72
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746428641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=csdtgpj57tWVPqtNCVqvudXuYd5/py1Je/kYa5zqJBc=;
 b=X+ZxBwWvpXIzQa1Qp+K/Q+DqtV7GdlMBWL5NO2RFr4z67Dvc29T9CbTkmKSImAdkMBX1py
 VkOMIZIkN1+xX2F+As5I6HdS+gvaOmVStTlOpE1/dfaNfSdb5SPfCrao0WntIYYXndB3ws
 15GWatd/An6VzLSeD/HRWBfTJCUknJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-a3cE1IPyPU-xjS3zSyBg3w-1; Mon, 05 May 2025 03:04:00 -0400
X-MC-Unique: a3cE1IPyPU-xjS3zSyBg3w-1
X-Mimecast-MFC-AGG-ID: a3cE1IPyPU-xjS3zSyBg3w_1746428639
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so1117311f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 00:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428639; x=1747033439;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=csdtgpj57tWVPqtNCVqvudXuYd5/py1Je/kYa5zqJBc=;
 b=XkwhF/o1UzogneWWCwcW+HQyfU2Qw6bVfeoebWaegBQ3DzTDOPl5EGu9RTxkNVc81N
 ZotPNhDqci+yGw3c92iZc5kgLEnn/e36OxqDTFHFDNDC1iv0K3/+Kb9h7uLR+F/J71uA
 yXV+9QR2VGswzQPq72vXMYhULZCONMCzIdpKdj56gZdW/6Kj+iSuModPevFNtCs6GPjC
 FtuyfD+ImkGuEAh4yn8LW8TI+4u1rSA3WwpNkDofxvnLCQZ/djyMoFKhCc4Y4aFLMCTS
 LhL/qhzh2UV614cf6891a9uTOICutx2/M15eYqn9/SCMgF9pgTKepRblEgJbzgy4bz5U
 Ifwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9SRlZDM3Nb+hm3SinqpMhJW1iITDt0sT2xmYG0vaxK4VSEWdEpHSgepriFxcXNcQghdc/cT/PU2cv@nongnu.org
X-Gm-Message-State: AOJu0YxMggxiHT0aNleEQYpVI/IhXsn4Uvrco5BDY7IwpiSsgPjIVwjj
 Ktj0q4Y54+JXc7zVn1tNr8Ex73yeuCOMVyLQINA3fN6pIWWZ+bAgV4OQlpTIE517OQGPsWHW+9R
 yfxZ8mikeKf/ovSGrKlVmWhoss79XKdQKswVAXz5Jv5StuQ7pvFmvJS65YMPB2HY=
X-Gm-Gg: ASbGnctZQKsy/lF9M894aEVVbgvF7kOtLwwjhxLNvdC9lDabl7qSeiFz3vlqVbTakIB
 9AGe3KgTVtm3bpXsVgl6LjRIbWG3fUhiZ3BwacDuEAY4NpbK3uunxGxWbFtSz6nosOj04E1TQDM
 lb2SrpBK0gH6X0pqiV23c1cTTBT0dxfjU1a8I9Zcyrrf2A9O3Ku9WrRA+IO2zCR3pXA/BqZNaPw
 UyfsrW/d8FJlPDldU+KlvKGVC/xOPRuvVn3JSYu+AWhPRGnRN3HtvSPsIIWwk3r76S1CjGHYZre
 CkqhFL0uyfOCCPT0i3vf4eDiKLcGctxRop+sY+ovMN4d834OIW/qI/e7zhz5OYhHlz4G2JeeN2D
 t2g4g34u6F+kaUFezCmpofmxUtEGD/AUDdu7/DQU=
X-Received: by 2002:a05:6000:420f:b0:3a0:825e:8559 with SMTP id
 ffacd0b85a97d-3a099aef887mr8076465f8f.53.1746428638989; 
 Mon, 05 May 2025 00:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC4FANyPZd5PdOy5njotv39zm1ijCfLdBx7DeBJXLSy1hMElG6DW8AwF4kXyOqhARIdodqkg==
X-Received: by 2002:a05:6000:420f:b0:3a0:825e:8559 with SMTP id
 ffacd0b85a97d-3a099aef887mr8076434f8f.53.1746428638567; 
 Mon, 05 May 2025 00:03:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29?
 (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de.
 [2003:cb:c73d:2400:3be1:a856:724c:fd29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0ce2sm9586668f8f.16.2025.05.05.00.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:03:58 -0700 (PDT)
Message-ID: <bf6b5120-19d7-4987-9b37-5843b0392362@redhat.com>
Date: Mon, 5 May 2025 09:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250502214551.80401-1-philmd@linaro.org>
 <20250502214551.80401-5-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250502214551.80401-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 02.05.25 23:45, Philippe Mathieu-Daudé wrote:
> Check legacy guests support at runtime: instead of evaluating
> the VIRTIO_MEM_HAS_LEGACY_GUESTS definition at compile time,
> call target_system_arch() to detect which target is being run at
> runtime. Register virtio_mem_legacy_guests_properties[] at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


