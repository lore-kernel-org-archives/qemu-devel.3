Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46913C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYi8H-00080k-Ko; Fri, 17 Jan 2025 03:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYi8F-0007yi-VQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:55:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYi8E-0007Ex-Dt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MPAu7vdK6fBGy9Hm0CSVGXVVmg2uDavLVK6ihFmZ3VE=;
 b=QDQDeGxLaaHzYog3QpvyP56Tn1T7xzzZDXBA07xsS/E/fTpzI6aprxOdockY/JHlFhkk54
 sPmafuBHKgsff1vn8Crq5PZiF/j+xXveIkcCD7wf/ItKGtvrenrLEVkp8XVV0cKVu9MBYB
 ESeSwyGccyyekd6cDpiilVMMfnf1WII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Fis05WhWP3qw9TAlvopUWw-1; Fri, 17 Jan 2025 03:55:06 -0500
X-MC-Unique: Fis05WhWP3qw9TAlvopUWw-1
X-Mimecast-MFC-AGG-ID: Fis05WhWP3qw9TAlvopUWw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so14691975e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104105; x=1737708905;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPAu7vdK6fBGy9Hm0CSVGXVVmg2uDavLVK6ihFmZ3VE=;
 b=G+SkOOJn1zFBfeXchkLo1iACd7bcQbbGm+B5Ea/DwSh5hR2vDHA4wLGyj9zd1lzwYs
 9Y1xPP+HrGyTKix75nlfejTT+lY9mz3I+njo+2EJSX/Letaqw5mCsxEHzVxUXLAWjvLY
 UqautfW5VIMhNs1zSIVha/WTKj80ccoNp8dNFyJO1FAIpuq6EGoUVupQ5/DxXeMOneD+
 kYcyQIu7WWgy0k08nwI1Cauz/dMK0txQweGSE7K5hhDErVRY0tbyFkBzfvThk1k24W2V
 C31l5w/TirWwdmVe+LaeNdUjr1ochwF8GFfwLF/5zoCRttYjLhmp9/PBC1hcF0QoO7dE
 Q0bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh7CiJFzNGJ3XICaktLwLsNmxKAdL89963PcQ6EHE8xQe0HZJcLDR5NAPKACaEHVfjfaWhbbi6efBK@nongnu.org
X-Gm-Message-State: AOJu0YxQGZjbQVGY5YUXhEDyUyEHwFTAWelIr1qlHugN7Np0f7/Wk7/D
 yfTZcGjVaNwM81REmA8/oQox8hwcglVmhnUa8Qz30wbuj6JUoB8BVvAh07Eo+eN7TxmCVD20EBN
 csM0kmuT36E0g9buUTmAs9kawAi348m8r6vHPxG4QCJGzdIp5ifwrCrC5RG7i
X-Gm-Gg: ASbGncs0q0l0Auw/XZozSVJyvzVwQq/oo/dyf1g5oGv8Th9mwSe+BJJ1WdkR03FL9Mh
 ctrBpviCQC+tBwyU6Zj+0r/cUWGqBIfnQBKK1x0RtuoZEYG7FN8O592y0vtIOtHb/lKoBOjUn6Q
 xZF4s/5bo1WSaW18/IU1D39Ll5umnBO9y+zq9Opd0/c+9s6fv6u+air6rZSAR3jI0wqpKkjL9vq
 85w1HFVwfmtK7agyG/e9eCGSYEkFGxXYCZc6/dzE1/MZcKGMiRNrS5aVhkQ5d0+ubpmqlMQruwN
 5CkX/MwH0quc
X-Received: by 2002:a05:600c:348c:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-438912d7c1bmr17837445e9.0.1737104105712; 
 Fri, 17 Jan 2025 00:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVPbY9ETSsJ5ZG/m6GSxnCRSe19LMXhhSEmWeuRXQrgYli8Us3M4zT2EE1UdmwHbH7znOPYg==
X-Received: by 2002:a05:600c:348c:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-438912d7c1bmr17837065e9.0.1737104105273; 
 Fri, 17 Jan 2025 00:55:05 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac5f9sm84545205e9.11.2025.01.17.00.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 00:55:04 -0800 (PST)
Message-ID: <84543b6f-97f6-4c95-bf5c-8a815684a7f2@redhat.com>
Date: Fri, 17 Jan 2025 09:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> The PCMachineClass::broken_reserved_end field was only used
> by the pc-q35-2.4 and pc-i440fx-2.4 machines, which got removed.
> Remove it and simplify pc_memory_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h |  1 -
>   hw/i386/pc.c         | 13 +++++--------
>   2 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


