Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E47C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6Yk-0003Fo-7X; Thu, 08 Aug 2024 13:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sc6Yi-00037y-6p
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:04:16 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sc6Yg-0004Br-Cd
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:04:15 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f16d2f2b68so17101361fa.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723136650; x=1723741450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gE/aKvkRc2BJRYhORe/lRQhP3lrl94rhujXiPTcoik=;
 b=hJDKe0dBDyT9z2IU1QbsVCik8vbfpeBth9tZNnO/3wSxURlK14Z0Bbkip3SfVekcDl
 4JfPqkefCXXryL5E/hU4LwdCvIEU7HytLdjk6m4OOmU0AF2RL6wLjXJ59GxHyCnVHVBC
 IsL6XpqUjce/G9X2MA2PQfpWsOh1rGJcC0kJRE6/HVRFBlvqag8GMlPgz/412i8kWUX3
 L4kei/RWd9zRKr+f4SPTnE+AaLALg8GL9XbQHy1+9KDMKJey0a1kuG0VoLpHxzZV3+Po
 sAiqcYZ2oXduEdKEDE6eM1tjP5OZeYBoDFG+Ryx6P1WEKYb0xYd1XrHItm/FSCaN6jdp
 D0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723136650; x=1723741450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gE/aKvkRc2BJRYhORe/lRQhP3lrl94rhujXiPTcoik=;
 b=Az17HvyfTGYnU2lDBNOVOJHcs5Gy4y4EM1D7t7aeJAB+FthCZUbCixg7V3VnWnGXEe
 eXinOoGeC4Z6bNfm3CWS5ZpKPCJZ64YFd49qUfFiPiboIqr489RAugElfBgYaoh2UByr
 MqoIl8FG9hoo4PjPY8SxW8pgiFLfu0e+1C0qRnrJY3GFZ5JDYz6yvre05cxXw0eU/vjo
 mECUDnjXyJvXhh5MAY7QkRUPq1VfgmjKzzXnK8S1RxTIxPdOKY/54qDfbpuscqMVXQm9
 YMN3uc4EcSXylDTG2p0nbh/JyxrMwnYrkRx3cdmpzRfuOh3vOJsn2ggqwAg5k0PxtW3s
 835Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaa1E4xZkOMGXWSVE1S5mARoN7Wpsvwt0esmsPDhjgrfb0Frke+YPmmOjEq1s+ZFk/IapByS/YYfzVg1kGck6NuuW19Vc=
X-Gm-Message-State: AOJu0YyOs7W1UJEV8WOsgiVPP7Pw+zr28CeRqE84NcdZUi0ivQsT+jY8
 NQgCK8fWnYhmgfqSaSI3z+2KJ+2zVYl/XZ+0gT3cy/GiqwD/UtDfJ2Vb+3A2BbY=
X-Google-Smtp-Source: AGHT+IHFC7w7OiNwPAfLjhTJJEkTsjm4x/Qq6fOS2xyW4q+WCCpHICcngFrgaT6OeukNbcLOfjatng==
X-Received: by 2002:a2e:5152:0:b0:2f0:1f15:5a16 with SMTP id
 38308e7fff4ca-2f19de2a52dmr18180381fa.13.1723136650190; 
 Thu, 08 Aug 2024 10:04:10 -0700 (PDT)
Received: from [192.168.69.100] (sto93-h02-176-184-36-227.dsl.sta.abo.bbox.fr.
 [176.184.36.227]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059a8912sm86453685e9.38.2024.08.08.10.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 10:04:09 -0700 (PDT)
Message-ID: <095ebfd1-63d2-437a-8e01-3e2805ae5b73@linaro.org>
Date: Thu, 8 Aug 2024 19:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blkio: use FUA flag on write zeroes only if
 supported
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
References: <20240808080545.40744-1-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240808080545.40744-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 8/8/24 10:05, Stefano Garzarella wrote:
> libblkio supports BLKIO_REQ_FUA with write zeros requests only since
> version 1.4.0, so let's inform the block layer that the blkio driver
> supports it only in this case. Otherwise we can have runtime errors
> as reported in https://issues.redhat.com/browse/RHEL-32878
> 
> Fixes: fd66dbd424 ("blkio: add libblkio block driver")
> Cc: qemu-stable@nongnu.org
> Buglink: https://issues.redhat.com/browse/RHEL-32878
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   meson.build   | 2 ++
>   block/blkio.c | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


