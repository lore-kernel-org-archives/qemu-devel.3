Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F8C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 18:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4PXT-0000HE-8w; Tue, 07 May 2024 14:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4PXP-0000Gp-CR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:27:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4PXM-00012S-R2
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:27:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so29460675ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715106454; x=1715711254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CwMi06/1PqRiZMpvJ1zhf7crsIcDUR2zcnNMjbREkHw=;
 b=lRv7CXoE+tIVL5viNqf4IKMsZRNkF6VDwiXwyzDkKj3S5giLieJrwYLjpAq+NuvbMI
 sPruPV1Kbh8UkIQY5vq7eCnuVit5gtaeNev365rqQWs0mSLibWMQHrRr51OGxanvwQBA
 gXUGI9+1oohCiygmGyGTjSdq0/BJqRPY12ZXM4MjFq5bCjuYQKU+56ZRuiK2qNf1/e4a
 4qU1tsXd6fVxks1escncm3HBRwpD1gdgVP3yJwc32m4V0psom+pHvcJxjWyyM6ZQR8rf
 Q6K2FKnYPGbn2vAdTLNLivcacQJgAY7y54juuIyEFnnluqm5pwOA5VbxZ0GPxEt76mHS
 6uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715106454; x=1715711254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwMi06/1PqRiZMpvJ1zhf7crsIcDUR2zcnNMjbREkHw=;
 b=eqwC3TylOYB4oaWho3xI71Q2KljihFH9oBpdTSjghXIk4Q0jUBZC+cQaXbtCBdIGz4
 4fphvQydehM2k1EnG/BOR1PEWyLtkbNgKhrTEbuqd08fc2vF9ToCQnOz2ZPICYUTDmF7
 Epd01rpGa3NuLQRlDBX77lQZ8bBCQWjLdwe644ZR/ey/3B+SEEoKs+2CF7SXEa2V98Mp
 w4Q/RPKYExdq36LqDISPN4jPlPxy7mZYrOSf0GwbRF7k9tBV1rlHUhDqwDiusL2QeK8v
 vLSBE3CgKOS+EzYsItiAf0N5Wxv6D+VcmydW7mvnKefEc6pdEZP+/V/qtzdf3PNmXdu0
 yT5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRhCe0t9qPG6alMqS9vPlYQdRWlJyk4rTvh/Q3vv5/K5f66J2UjhgktXN+foE1nRP1m5OkJ5BLB0p+Hs6t1xAkGDIBVRY=
X-Gm-Message-State: AOJu0Yx6mu0/WEr81bkeCaZ3DH5PYcay2nggVgfQNIooQbryoYR43jVf
 hqwTfBM2UXP9nwc1kH5U2HqOCSRMyLDkp++atqhMwAV56gCqhTgmC/vt37NlPUU=
X-Google-Smtp-Source: AGHT+IGtofq+e0TdrSumQ0Cs8n9c4ifhHZhC5eLbKMEBYQH3WorOissJPdHAOuav1W+7gq0lVYyXzg==
X-Received: by 2002:a17:902:aa8e:b0:1eb:54b7:2724 with SMTP id
 d9443c01a7336-1eeb0bad67emr3900325ad.64.1715106454205; 
 Tue, 07 May 2024 11:27:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 jz13-20020a170903430d00b001e2a3014541sm10351011plb.190.2024.05.07.11.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 11:27:33 -0700 (PDT)
Message-ID: <ae6547a5-a16c-44de-98e5-5158bf9b5069@linaro.org>
Date: Tue, 7 May 2024 11:27:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/26] target/i386 changes for 2024-05-07
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507105538.180704-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/7/24 03:55, Paolo Bonzini wrote:
> The following changes since commit e116b92d01c2cd75957a9f8ad1d4932292867b81:
> 
>    Merge tag 'qemu-sparc-20240506' ofhttps://github.com/mcayland/qemu  into staging (2024-05-06 10:19:56 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to d4e6d40c36071c287199c072cd5d296091ee5968:
> 
>    target/i386: remove duplicate prefix decoding (2024-05-07 08:53:26 +0200)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: conversion of one byte opcodes to table-based decoder

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


