Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6639C36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 06:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz8h9-0007Zj-SL; Mon, 31 Mar 2025 02:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1tz8h6-0007XZ-HF
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 02:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1tz8h4-0001V6-DX
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 02:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743402739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bj+uPbhdX2jDRRq2LjcQpDcOcEDf1LjkYUr8tDy3SUs=;
 b=K3t52V6GgwMir4w8TLltn9pS0wcSF/KwFEa9kCM3ioE0V80I62bTCtzwzSrX7iZUgsUAoZ
 E72HpT09SZLiXqSOJwGYRyQJ92RDHoIO6wFah3H9lQ8pDu6HKx8GDwRFEafYJh3n4Gpsf6
 0Fek2afsQfecUhKf7bNrpwH4zDTPMe4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-cBcJmDOnP9uVaf3RVnA5Sg-1; Mon, 31 Mar 2025 02:32:16 -0400
X-MC-Unique: cBcJmDOnP9uVaf3RVnA5Sg-1
X-Mimecast-MFC-AGG-ID: cBcJmDOnP9uVaf3RVnA5Sg_1743402735
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-223f3357064so65776005ad.3
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 23:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743402735; x=1744007535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bj+uPbhdX2jDRRq2LjcQpDcOcEDf1LjkYUr8tDy3SUs=;
 b=cGxqiFlmlfGUtwkXXtKLc7BeI2Z01QCkJSm/lsWlp/pZw6bNOLbCYVyJu60cw9+3uU
 8EJn1DhhOx0lABMWe9OcDSct9lDLxXwAbdgaxmkjtU72kP/6bExnL6MfGWdcgsuW9GSK
 6PddzfYrPAAxcYhNEZy+GJvilmOQmlE1Fe9TGT9cnP3yR5iVR0cE/zCDXgR2hS0KkaSw
 dFTPMrnWB9IxyruiqW7GzPViTEkWfsMlnxM0g+4DuwRI6swEJtjNmfgDmB7I68jytBbe
 dagh6o6tCh06KAevoKf2mhjweVJ099/8+8HUeskiiz65OeP1c8G4oFWhWFbDop9ZrR8k
 nAjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrz6ItQFdjBGa0PxMjmOWQ2Za2IXZ1cCpzEAKCKJ8Lu3pEkMmdrbrn69i5ok05KAtjhQCXpr0pg2Zv@nongnu.org
X-Gm-Message-State: AOJu0YxMQDesUQk9T+DqLWZafCML4j5uvw/2affhpGd+grMKjsFJRZOH
 sECxUrewj+wGF+Qvco5+psyvy0K6t/x8QmkE2Bv1VOC6O6DasCRm5eFVsJjmIOR0cs7c1X180HH
 8ABJ+sXtan/c7imwKm+u9stN8sFQsn0BoSDi3ZNWaNlEizGOd+hqw
X-Gm-Gg: ASbGncvQyWwzWyh7THV2Oh9oI756+faxk9SOq0PIkBPOL97g2EhLLiyeEUAxk+b4M0c
 sCr6bR39xtJsGuNjOC8bbP2z3ic6WW0HXjvIsiXi7ekNGlJqcdPgkOALM49yDH9XYilpdY7/PI+
 AJFZeFJguJSxD6FktJXmXi75OOdCIaXYDUel5Jlf/zk8k+K3twoQPew+obtHFd2yHSxQ+bVY4+V
 Arx84cBarFWjnvn7PTAnAgrAp05bV0Vfu5++9U9ZRZ7My3v8YlT/MdAWpk+2rh+9xbcBSqrFGLa
 6NhPGuGnp7BqU2XS9VKb
X-Received: by 2002:a05:6a00:3d12:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-73980461abfmr14103503b3a.20.1743402735290; 
 Sun, 30 Mar 2025 23:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs8k4qoYwtrF9LTELImaMqZINP524FfVy0bAGagmIfVaPAyGZB2LAMS2lms6/Ug9jADcTQYQ==
X-Received: by 2002:a05:6a00:3d12:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-73980461abfmr14103450b3a.20.1743402734861; 
 Sun, 30 Mar 2025 23:32:14 -0700 (PDT)
Received: from [10.72.116.144] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710dd3d4sm6451950b3a.177.2025.03.30.23.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 23:32:14 -0700 (PDT)
Message-ID: <44dcac55-62d1-4092-9b75-5c26b6d4abed@redhat.com>
Date: Mon, 31 Mar 2025 14:32:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/5] accel/kvm: Support KVM PMU filter
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <2fe2a98d-f70f-4996-b04e-d81f66d5863f@redhat.com>
 <Z9zgVKtZyEx3MKuf@intel.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <Z9zgVKtZyEx3MKuf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Zhao,

On 3/21/25 11:43 AM, Zhao Liu wrote:
> Hi Shaoqin,
> 
> Thank you very much for testing!
> 
>> I tried your series on ARM64, but it reports error at compile time, here is
>> the error output:
>>
>> qapi/kvm.json:59:Unexpected indentation.
> 
> I guess this is caused by my invalid format and sphinx complains that,
> as Markus figured out :-(
> 
> What about the following change?
> 
> diff --git a/qapi/kvm.json b/qapi/kvm.json
> index 31447dfeffb0..b383dfd9a788 100644
> --- a/qapi/kvm.json
> +++ b/qapi/kvm.json
> @@ -54,11 +54,6 @@
>   ##
>   # @KVMPMUX86DefalutEvent:
>   #
> -# x86 PMU event encoding with select and umask.
> -# raw_event = ((select & 0xf00UL) << 24) | \
> -#              (select) & 0xff) | \
> -#              ((umask) & 0xff) << 8)
> -#
>   # @select: x86 PMU event select field, which is a 12-bit unsigned
>   #     number.
>   #
> 

This doesn't work for me.

But this works on ARM:

-#              (select) & 0xff) | \
-#              ((umask) & 0xff) << 8)
+# (select) & 0xff) | \
+# ((umask) & 0xff) << 8)


>> While I compiled it on x86, everything is ok. Could you please check why it
>> failed on ARM64?
> 
> Maybe your Arm64 environment doesn't have sphinx_rtd_theme?
> 
> You can check it by:
> 
> python3 -m pip show sphinx_rtd_theme
> 
>> By the mean time, I will review and test this series.
> 
> Thank you again! I also plan to refresh v3, in maybe 1 or 2 weeks.

Ok, Waiting for your new respin. :)

Thanks,
Shaoqin

> 
> Best Regards,
> Zhao
> 
> 

-- 
Shaoqin


