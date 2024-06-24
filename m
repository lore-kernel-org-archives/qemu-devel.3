Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F601C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqea-0003L4-HX; Mon, 24 Jun 2024 16:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLqeP-0003JW-IE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:51:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLqeM-0000kL-8M
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:50:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f480624d0dso40271235ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719262250; x=1719867050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmp0yN0H1vU5ibv4aHD7egKd8LJLQWb3142z5eoJfHg=;
 b=xcvOSrM4KeVkOXC4fs87OTRbeb6oZVuacS2Qqu05KGTrgUYch+MIU+zEboR8iMQjsG
 hx1tyfs9xd69GfBA074yz+sP+HbxMPsxO4ZvonGLG6K8IvHf22OCqwafdeW9aYhwoJAg
 wLAIwHXiST60JDe8XO7arrd02oQ+4WXL6zAyPGvPm32uI31TSLbkZb2mvHWVsD+8+Kpg
 MSA3tDOCZvaA6FYM+1RM1eiaogK7oKIV7gROYYr8Yk2dGIcfZCmvhttf9ISBnOygDLV4
 14F2NZm8/bf8kIGCJySp3n9kj4PkkkicLQFYUOQ8kKffW6um0+SmlKbk7nrHncvD+2Pn
 +l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719262250; x=1719867050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mmp0yN0H1vU5ibv4aHD7egKd8LJLQWb3142z5eoJfHg=;
 b=Zd2xdYj3FWESeYMsBlPdh6xjaM6LGC2/FeC5/AvRsDiHX32qrfz0PFDiNH8++/pQH1
 sGgn455zR0JM9913Mdoro2loIYNwac1EQw/4E6aCWxAE0xmQLw4Xe2yVWNsofp02jjqi
 TTK8wAY73dPQc1q17rmZ9oeq5PjU9L1BcfiZZ/mcE06/TZLc8VhtJpttPUdWnDdIur+u
 VqQcKqNZzLhuCVuOLDFtU5OKX34+rkUlOwwRzEWHsaL6HEVeDWJv3ClcdlNBZzO1EwJ+
 wPddZbtoWCAZEGWNy2OLPBpuoGFffhZ5pvuGBSpoQA4/UYZOAzKn8jKuN3wsoJ9kjoA7
 6W6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYqob0FC/LOdHXZvQGJ9kAU7+/keHDKoS/+vTu4yjGKMFgjbBlOnT+TrvwOqDEXJwMTqMDZ69WKhMPNIzcitgmzA59P9U=
X-Gm-Message-State: AOJu0YyqiNDZEoQwSfNj/sTGP+zk/hrQEPLGKndZl146yBy9+uLHN8sT
 fua67ya9PeFF2P0Cxwe9wT/EYcwMxEJtyUiKfGVEwG3kMLFC+DoCg8SDuxkHwfQ=
X-Google-Smtp-Source: AGHT+IGmBaIQVQMF0+K4LRg95YqMJwFXFmV5n9wXqn/RTLHePs271983niT7+lr26UMH4V4Bj1/hgw==
X-Received: by 2002:a17:902:c943:b0:1f9:c8cc:9e18 with SMTP id
 d9443c01a7336-1fa23ed7575mr81804015ad.27.1719262249971; 
 Mon, 24 Jun 2024 13:50:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c8c01sm66951925ad.129.2024.06.24.13.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 13:50:49 -0700 (PDT)
Message-ID: <c1a4baa7-f541-4325-a8b9-f248754fafd0@linaro.org>
Date: Mon, 24 Jun 2024 13:50:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] s390x and qtest patches 2024-06-24
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240624091043.177484-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/24/24 02:10, Thomas Huth wrote:
> The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:
> 
>    Merge tag 'pull-target-arm-20240622' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-06-22 09:56:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-06-24
> 
> for you to fetch changes up to d6a7c3f44cf3f60c066dbf087ef79d4b12acc642:
> 
>    target/s390x: Add a CONFIG switch to disable legacy CPUs (2024-06-24 08:22:30 +0200)
> 
> ----------------------------------------------------------------
> * s390x error reporting clean ups
> * fix memleak in qos_fuzz.c
> * use correct byte order for pid field in s390x dumps
> * Add a CONFIG switch to disable legacy s390x CPUs
> 
> ---------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


