Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A705C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 14:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSzA3-00075z-0T; Sat, 21 Jun 2025 10:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uSzA1-00075V-7u
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 10:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uSz9x-0003Ue-HJ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 10:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750515930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rSoKeUvkLYcsQ3YPMp9rTX7Ktjq/O6WOnuThRHLwu3Q=;
 b=HpXjTH9WaFekMkAIDou1f4kunatWugxIMam25uYAfiC+pWkAHQ+nHEbi0sUducguwZxVJ4
 BEJW5aMkRj109aWFqiWD6BPacCBvJ5d3SfQSdz1+3K1fNgJNYgj2Y0+lWYH92r/7outqOB
 ZPY/LRKSA4rM8+DaUvdd033bT2Nuo00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-75yCKwDRNYCoFFwcAUmtrQ-1; Sat, 21 Jun 2025 10:25:28 -0400
X-MC-Unique: 75yCKwDRNYCoFFwcAUmtrQ-1
X-Mimecast-MFC-AGG-ID: 75yCKwDRNYCoFFwcAUmtrQ_1750515927
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4530c186394so11999335e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 07:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750515926; x=1751120726;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSoKeUvkLYcsQ3YPMp9rTX7Ktjq/O6WOnuThRHLwu3Q=;
 b=PjGQ7Kg1dDvDQ857e/iTrM6iudwZe/8fCv8cRO+fx96UR7Zf2adApJDW90ePEqjnK0
 5ddxse+yk2j7iRQRiN8EmWyjSWXwREEj0MeSKxkgdEKNvjoN16c0/M9V6mxjQB19CePK
 SA7HN+cka8WAR/zdoOpaxQ9EA3q8H9re7TNLHlD4I+9OLMiFwDyz2ZGKRKb/GeKZv6YP
 F/rIKL7/f0T0Va+j7eljyRRCpWp7TN2+A3VnRR9x7NC0KUiUMZlbTR+2xdnCsZ51Lr0D
 OguZ2YUjkESoS2W/LP6CsO2ylFgJE6/KcjJKskZH2z8NdJsu4LrvaJxqVGU4ugfIrvFR
 EM2g==
X-Gm-Message-State: AOJu0YxnnXLCyyvBILL+NMoe1ExeRR/JEXes6ZRwGE38pkSsgP4eX91N
 kAPuFRNRYlJcw9I+Eg2gRTGwq6f2GIMu4eK92jT4pJGLf1Y3iZd7NKCfuthgqxPXP5Rfj9694iZ
 8Cz4s9cGhVYLS5OanaXrCMz03T1Za8WKar57iWBMrr2NztkmGpf+aP6T6
X-Gm-Gg: ASbGncu9HIEDLUx7k7wgPxB8D0NmMaoD151uAS2Ds4xiPPJcIex9XIy4V3lvdswwGx4
 TOldhnTksNhGK6WSj4atWVMFknHgWt3knxv7BGzGcZtopRFFeXI4oPNTKHXWKCz4Kw4bYPGynhL
 qIrXhHtTtSYKORvqN/Z9JZkhI3WWyvC0QNy5RxdqhzrMft6xoEYmR5M8QZgl8Z8K0UE34U8D2UD
 ObQo4r5rWTJmdrXBrVqErl+9YOyIaQ0tVlvPua6BfHrK9aIScs4uOkvR83GnitY7IGVrmgZPthV
 yZQB55V7FWoCRQTgBox0eQqGTisBJbSxTQbKj43IYmFec4GfoMV8Dh68eJaJYnehkw==
X-Received: by 2002:a05:600c:8b67:b0:453:6ca:16a6 with SMTP id
 5b1f17b1804b1-453659c9b5cmr69908925e9.10.1750515926587; 
 Sat, 21 Jun 2025 07:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQS952rwIVqay0DDUjYu++9VUi/Z9qyGrF+kGXNTQXM3R5oGziA9l5t/3wlRN3+yYr2vmmFA==
X-Received: by 2002:a05:600c:8b67:b0:453:6ca:16a6 with SMTP id
 5b1f17b1804b1-453659c9b5cmr69908695e9.10.1750515926161; 
 Sat, 21 Jun 2025 07:25:26 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e9844c3sm89960025e9.11.2025.06.21.07.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 07:25:25 -0700 (PDT)
Message-ID: <84170782-ba25-4f9f-b0fd-3b77c3a98edc@redhat.com>
Date: Sat, 21 Jun 2025 16:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] vfio-user client
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <3757d761-db62-4d22-b16e-c634f504bcb3@redhat.com> <aFabYdacLpv3RHu8@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aFabYdacLpv3RHu8@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

On 6/21/25 13:45, John Levon wrote:
> On Fri, Jun 20, 2025 at 11:11:10AM +0200, Cédric Le Goater wrote:
> 
>>> The series contains an implement of a vfio-user client in QEMU, along with a few
>>> more preparatory patches.
>>
>> Please run ./scripts/checkpatch.pl and resend later on, as we might get
>> reviews.
> 
> Output is below, MAINTAINERS looks correct to me, and the other complaints are
> for files that are the same as in hw/vfio/

Please fix the SPDX-License-Identifier warnings.

> So please let me know what if anything needs to be fixed (and if I should make
> the same retrospective fix to hw/vfio/ equivalent).

Did you update the QEMU tree ?

   $ git describe
   v10.0.0-1657-g6e1571533fd9


Thanks,

C.




