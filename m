Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19A7C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIiW-0005bZ-Va; Mon, 01 Jul 2024 11:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIiV-0005aw-4N
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:13:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIiS-0006G7-2V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:13:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-424acfff613so28509855e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846794; x=1720451594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N9FEHlPTNxswtINWYqFC+mMBpTrdhlMygvNvTt8YoNg=;
 b=KFjq/X2+QeQnghncEUfLnAnDlCESXHBCf327mhskz+m2HQCTAYg88osWnQm0p6BRO5
 BoLatwNzmxu8vrWXuMhiq+tN80RBTwf07NjBpPgBCg6rvezDxKCYOY6uE5/JGVeQ8KPk
 AlPnSvXnOlKqWEHhKrTK/VkOmUj5fTs8IFghliAF4V9J60Xhxs2hQmO6T2g5s4FDr29n
 DvrTmmu7U/pr2phoZbNb0g3Rd/J05pgCXAAtGnS1ZNvLnoEXrOEOY/vb7dqg0KtVz+6o
 52pdPf7l82NpMtHNy5gvZs8omtUxfuJ0QsN9ZEOlkIynTlayL7dZrnFz66o7nQzxYPzl
 7Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846794; x=1720451594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N9FEHlPTNxswtINWYqFC+mMBpTrdhlMygvNvTt8YoNg=;
 b=kW2Gh5Zmij6D+C6b5OTQfHVzNg6lFg9SvCRBxyIAlklCaNKOxXt4AAdxQFETiT+lXl
 0IvwhN4RTSJrQxyy0KL5sBHIO2jnSyKHC+LbaT16OoA2PQnhqo5ZrfVJMPtBMU7JaoQO
 6RIpmtXkGBtmMzRAB8JlrLVpR7pobiHyECzA8G4i+Ukm12vd4pYPcejTZl6ZlANtD2Cj
 Wahw2XAfZ2uPS4y2OcZlsSYPJZYH5DBiL3s138hvePRYEd6Jshlx+e5fECaw8DH2QVJ+
 asCSyFLpMvMoIEBUCGKuOK2AnARqvAdWbB9r4tTbOe0ymzSplMD9sCXt9qfH+sTRIEVn
 d2NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCUSrsSeG7BdiaadqIS5gVtWvSaZ0WDAXwXyz8Kd2I6E0c6ejQCO3+7dSiTgAi7u3bTPv8FB3s1oH5h2g2MZwVaEsuUuY=
X-Gm-Message-State: AOJu0YwkbsDj3sJD8S3Gx04Pc5kabjsrWqHiqUYlknveQz7UhFKRrVGZ
 vX2ygM4M73p14JPcGnmzgyk/SOWRwsT7PkCeagJNHeDup1kmnLVMG2mQRC7CTCM=
X-Google-Smtp-Source: AGHT+IGlWdkLPyJwB/VmaLxsTdcIRwMLsH5VuGtwqT/765uNX/5wWnD1F29uRvc8qgJtoEfq5w7ljA==
X-Received: by 2002:a05:600c:47c7:b0:425:5f73:e2e1 with SMTP id
 5b1f17b1804b1-4257a00c088mr51672315e9.22.1719846794419; 
 Mon, 01 Jul 2024 08:13:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af37828sm161811305e9.9.2024.07.01.08.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:13:13 -0700 (PDT)
Message-ID: <609600ee-f77a-46b7-9692-f47eba3087fd@linaro.org>
Date: Mon, 1 Jul 2024 17:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] include/hw: add macros for deprecation & removal
 of versioned machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-9-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> Versioned machines live for a long time to provide back compat for
> incoming migration and restore of saved images. To guide users away from
> usage of old machines, however, we want to deprecate any older than 3
> years (equiv of 9 releases), and delete any older than 6 years (equiva
> of 18 releases).
> 
> To get a standardized deprecation message and avoid having to remember
> to manually add it after three years, this introduces two macros to be
> used by targets when defining versioned machines.
> 
> * MACHINE_VER_DEPRECATION(major, minor)
> 
>    Automates the task of setting the 'deprecation_reason' field on the
>    machine, if-and-only-if the major/minor version is older than 3 years.
> 
> * MACHINE_VER_DELETION(major, minor)
> 
>    Simulates the deletion of by skipping registration of the QOM type
>    for a versioned machine, if-and-only-if the major/minor version is
>    older than 6 years.
> 
> By using these two macros there is no longer any manual work required
> per-release to deprecate old machines. By preventing the use of machines
> that have reached their deletion date, it is also not necessary to
> manually delete machines per-release. Deletion can be batched up once a
> year or whenever makes most sense.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/boards.h | 96 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 96 insertions(+)

Nice again.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


