Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF6F47CDA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFwH-0003iT-91; Thu, 05 Mar 2026 16:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFwD-0003gj-Is
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:08:55 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFwB-0000AH-Lu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:08:53 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso3149427a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744930; x=1773349730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SU/WcDTa+3Pn70m9VfH6GrcBlD4+q7UdN1KppZclnEA=;
 b=c5NR4dWpPojR7g9OxGNNyDge3KP1b0frsU76bQO+xA0atc0f6fROiYRdXa3c8pNvLH
 1H7wEY3T6ZaLxUL54wf5pBryKMQ5C632JIK7DZ/C7raOx0lehHM3vwrUaR9btoRX8rBN
 mYbZvnjj9a8C52IImrMkhQWHtr2zRebTMEZhxTr4fddOW5ZUGJ5snE/lTnImCY7q10Eh
 2KTknyl0i7q2+Bo/R/02/znGN5rTPcKypHlDbPexUYv5Xks92SzkvOOLh2HWgi5O1HOs
 HtJBSzwMhEOBNWdSJvwmQrw50gEJo+uLqQlTnZc/ClhudWwiIQNtrrZcsiDJIlkcEmg7
 Kftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744930; x=1773349730;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SU/WcDTa+3Pn70m9VfH6GrcBlD4+q7UdN1KppZclnEA=;
 b=QzDn6OzY5tDlEGQb2FqKMdS0r5ZUPavj2pfQZA6hmoQlfQTcC9gXhpSdiiYo39clK4
 04XuyoeX2j9tOTqkQwNSl6ev3tQk97dv6HRGXeRUJqygPltawlShZCus8mSFKAzl1Te7
 ir/xCop+g5a9erDo/N43KrMCWII5oQacDfbEzBmgNgLeCtV7dT0Ax5+bhWfFeR4ZDBNl
 IDNEKV600WVqunUNgjbtfMkYJkbZAe/v0CapvSOAX6iVtzVcPxmYEsRZToTSTDwnBB7N
 zvgz8nBh/cEuAv1asHQOYIdJTO4FltocrPWrvlnxG+2Cbv+nkm1NC05Kh9het8k3uEHi
 HdWA==
X-Gm-Message-State: AOJu0Yy9bP3eATeDRr8G+DuAh7dYAtzGGjbA+hWT8WbZL6OeV2NI9pP3
 0V6hLwvafvnSH7/McJpqE4IOut1UJEQmCe1jIDHWVsWhKuUWMJ/iA+AUqOeTAUPsvfQSj4mFmsD
 BccRD
X-Gm-Gg: ATEYQzxZ4xiz0Tzk7cuOek4g0ChzLxNQd+z1zHHQGSvNFCCs+EhOp+pxMENysLL2ZyA
 sN1ZtMdJgtPzQ3OWFIlJ9Jj7EMvssZT8BS7dpUZytF+Uq3xFEq8i0KCoUd2atYFFOVSU+bKWrwA
 Vii9EBSLbtp16mZse9Bduq0lRh7GBbKZtusEmrntYG+Uuw1CdAwus/uMXvi8TwUW8SFeFKQdmaO
 KDDCtzTBOCt7TDIJhHQu7rkqxIOr3CQcQcYrb7wZAz1fyoWl3ED0vPFwJSXf1jVJ51urCmrxHQJ
 WYayAIQywl0IZcQ5H06vvNeeTt8BfGqv0NuFe0TXJE0vTEJqb5ADKF6shGaExgdOOkm929Jh7nD
 kfYMLqCUSosAPcQ+7PbV9hVBPxW+eK3ZZAHzwOs/97+dEavNiGFq0z/Sf5aWzb+zz3XgupE6Vn1
 ybJwNbvikSZdnt9WV6pOs1gBj0wbSqVSmzKrWI3lAeVOO8+4RLizlVmtK32WnWvmqoY2A6
X-Received: by 2002:a17:902:f545:b0:2a0:a0cc:9994 with SMTP id
 d9443c01a7336-2ae6ab64894mr64888465ad.47.1772744930007; 
 Thu, 05 Mar 2026 13:08:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae3a9dd3e7sm169933315ad.40.2026.03.05.13.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 13:08:49 -0800 (PST)
Message-ID: <2d283daa-a28d-4f33-afe9-987301e2a6f2@linaro.org>
Date: Thu, 5 Mar 2026 13:08:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] hw/virtio: single-binary
Content-Language: en-US
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/5/26 12:55 PM, Pierrick Bouvier wrote:
> *** BLURB HERE ***
> 
> Pierrick Bouvier (6):
>    hw/virtio: Add virtio_vdev_is_legacy()
>    hw/virtio: Simplify virtio_access_is_big_endian()
>    hw/virtio: Inline virtio_access_is_big_endian()
>    hw/virtio/vhost-user: make compilation unit common
>    hw/virtio/virtio-qmp: make compilation unit common
>    hw/virtio/: make all compilation units common
> 
>   include/hw/virtio/virtio-access.h | 43 ++++++-------------
>   include/hw/virtio/virtio.h        |  7 +++-
>   hw/virtio/vhost-user.c            | 11 ++---
>   hw/virtio/vhost.c                 | 12 +++---
>   hw/virtio/virtio-pci.c            |  6 +--
>   hw/virtio/virtio-qmp.c            | 70 -------------------------------
>   hw/virtio/virtio.c                | 12 +++---
>   hw/9pfs/meson.build               |  2 +-
>   hw/block/meson.build              |  4 +-
>   hw/char/meson.build               |  2 +-
>   hw/net/meson.build                |  2 +-
>   hw/scsi/meson.build               |  6 +--
>   hw/virtio/meson.build             | 17 ++++----
>   13 files changed, 50 insertions(+), 144 deletions(-)
> 

Please ignore this PR,
I resent it with correct cover letter here:
https://lore.kernel.org/qemu-devel/20260305210656.2140206-1-pierrick.bouvier@linaro.org/T/#m6f075d3cb400a177dad46b2694f1ebc676488838

Regards,
Pierrick

