Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D316AC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZqF-0006HM-78; Mon, 10 Mar 2025 05:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trZq6-0006Ad-57
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trZq4-0003T3-Ef
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741600463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtuqdOuiecVVRmmjSp3gslEg0ualkMi9F/wEULB6TGE=;
 b=SF3pdZUmMtenn1J/SiFXA2aTvqrk4wD9E6CL0mhR1b96djIJbEQOX9yy+7OXJUYfsliG38
 uSAjavF4fVud3uoVnFjfL8fm+68800tDVGTowUGmllS4BrZpp9TwovWXjNsWCDpocMWtox
 x/uIW5RTgn0ROn/znZ0EMBfIesH5Mno=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-XnqH7brXOcO85ir_7nUz6Q-1; Mon, 10 Mar 2025 05:54:22 -0400
X-MC-Unique: XnqH7brXOcO85ir_7nUz6Q-1
X-Mimecast-MFC-AGG-ID: XnqH7brXOcO85ir_7nUz6Q_1741600461
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913f546dfbso1032729f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741600461; x=1742205261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtuqdOuiecVVRmmjSp3gslEg0ualkMi9F/wEULB6TGE=;
 b=ZJYSIxXOnrGlEiKTPWITe4jsHNUW0iAHgQokv5+Gnv6rEBO3TwpGz348uN0ZX7uoZ0
 ruYM3BK43dBuNywtcnADU9CyKM9aZObLl/+UF2G2Carbes6KPzjhpZmxsKnpq+5g9zF6
 xjvWFFkKdIhT8p+F+vAklR6PIU3a1qdDJD+9oDi5Ko7CKBjtCu/db8qilg+1uvPJ0NOT
 pk7Nc/bdkQMU60kTvWdyu3nMr2G4dRjA28ooiDnPPIyboYsbhMBDvI9FzG/1gPAVru3G
 TnIdQalSjm5q0K19hVnovREGvDDFe7DDn5H4ifB/NJtXu51igYWqOqrET+bKJI2QVmx0
 v8mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV+gjKBxyBtwBAwi5v2plx51yXzIeusOn4JkNlzVDLym6DQn7z6pE+gJX10GEUWlJz40B4RSyMFc8D@nongnu.org
X-Gm-Message-State: AOJu0Yz17JLiFiLUL7Lsw8J2O8/RO7E26hGBQcbNj0Fo3Iaf9pPVl3dF
 vjHriC/s/bgFh+ehTu/qtV6XKo97MsuG/JkhAivOCC1qLQQA57rwAqudQvdznmxpYcePTlQxwUU
 YwceB445ZCBxQopLzrDruSWsG6qhz/IVvsi3IcTwNOiY5vI4AwsZz
X-Gm-Gg: ASbGnctqe+9XBDnl/T65/2EWcenhHgD5PTvObFc8OC6WWcnf1fv43+DRSlifY8EVOx+
 5dBEj5r9RPYtTl2nZoQbXsrkwuFLeiYkb0HngoMnSZQi8N6/hIfuy8m1Uc17if3+hb8LR7B+/vV
 hnFC152MV31/XK335ZXHBsGuSWqhd91RZ4JPslMWWOgySgcy/vQFyrfOLFHIXqEyxzMKfCld++a
 rFghzZx9ESo3TZIRTAnMlCSbA1tSpVltLrl7+LyYE+/hKiS/mom1Sn1sdXyQ63ivRBifT1c+dV/
 7/Ewxso5UAhlMKhIPLM700/u24Powz7uoEawFkSvoBcoN858S8Qs8TKQFt4Ir+I=
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id
 ffacd0b85a97d-39132b58ad8mr9968020f8f.0.1741600461029; 
 Mon, 10 Mar 2025 02:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgn6vs3wtpQflZqcFKB+5gsLSC3ji/MtXlKgd119Pz3EhyxOK5skvoV6airBMnFiGNkKyOOg==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id
 ffacd0b85a97d-39132b58ad8mr9967987f8f.0.1741600460622; 
 Mon, 10 Mar 2025 02:54:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7ae4sm13985560f8f.5.2025.03.10.02.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 02:54:19 -0700 (PDT)
Message-ID: <35eb4589-fea5-47e6-a0f2-c30cc7afd72d@redhat.com>
Date: Mon, 10 Mar 2025 10:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] qom: Introduce type_is_registered()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-11-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> In order to be able to check whether a QOM type has been
> registered, introduce the type_is_registered() helper.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/qom/object.h | 8 ++++++++
>  qom/object.c         | 5 +++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 9192265db76..5b5333017e0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -898,6 +898,14 @@ Type type_register_static(const TypeInfo *info);
>   */
>  void type_register_static_array(const TypeInfo *infos, int nr_infos);
>  
> +/**
> + * type_is_registered:
> + * @typename: The @typename to check.
> + *
> + * Returns: %true if @typename has been registered, %false otherwise.
> + */
> +bool type_is_registered(const char *typename);
> +
>  /**
>   * DEFINE_TYPES:
>   * @type_array: The array containing #TypeInfo structures to register
> diff --git a/qom/object.c b/qom/object.c
> index 01618d06bd8..be442980049 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -100,6 +100,11 @@ static TypeImpl *type_table_lookup(const char *name)
>      return g_hash_table_lookup(type_table_get(), name);
>  }
>  
> +bool type_is_registered(const char *typename)
> +{
> +    return !!type_table_lookup(typename);
> +}
> +
>  static TypeImpl *type_new(const TypeInfo *info)
>  {
>      TypeImpl *ti = g_malloc0(sizeof(*ti));


