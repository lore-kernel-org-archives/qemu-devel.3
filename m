Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566D8C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRysp-00080V-8o; Thu, 11 Jul 2024 14:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRysm-0007tv-WF
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:51:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRysl-0002kL-BG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:51:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70af81e8439so1083436b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720723866; x=1721328666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qzVaiWwxSOo+UlNEk7JBM/R5ttiM4260CxM4NJ2QJmc=;
 b=UYYbqp+Y3EPiRNV5ENfkNMzWrsBYq/ye73VPAMbuB/SIyz3eASNjuD/Yh+FqN2C54S
 +715amtj1jgxYjQUSI/Z/oXo32xEaLi+vZVDKs19veIRjKPAeStHuw8EXFnRe1tJxRxU
 VW21Z3ni+nbauFVpx4YSO4Xd21q0N5Tj9Y3RPmjmgJfbUOyUt4NipLJqLuK6FuNh5Lew
 CFPriKZAABFeLt/4hDUmGwwOVPkyJaZ0/6IvXzdKt26FeBuLu2N8Y4A/54yjNPR2FQI7
 LKPmZZRjG4nU4IouTkLhgjOgx+pTRtm+CK8R94QvEbQ8DGaKIza5iiK61RA6vPRdDzkh
 8Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720723866; x=1721328666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzVaiWwxSOo+UlNEk7JBM/R5ttiM4260CxM4NJ2QJmc=;
 b=YwF+Od7JIIug72OPjuBImwmBNpKVSGCYO1l74PUbciMp6SL81GBjDqF1JwyZ++lPAu
 7Po7dBor35jAvL4zErojvFeIGj2qgTacbLuvh89GyeFFexZxE8MnROZQQZILsiljwosw
 vT2szRflfDhT7NVl7dk2ksDs9Lka1H7wTVEgkrjOTPsHrwTAVd/IuzJz4+yeq3frbsrG
 khRCKc9cgDYPArX21lSicJJzYM2b8o47C4hTFFqvsC7Eoko6w7NnHOOPt6W1PQkAa5rw
 tCla9mZMDD4kNQ9pv9b6IFeaU/85ifpjZ+oXqrBWjbRwk1tVQSfcz9/qkJdD1ZAF/bEu
 HBjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXypQM1yRIE6/xOsiOtuOEUwr5Cfo3NPbyo5mQSZ3rGfbia3p45crSMkceEzW/ArAXIHsA/8CFIkDn9X/QtAY03D62SO/4=
X-Gm-Message-State: AOJu0Yw1MA0VShhzCl73XS4KQy1U+gpvpwG55LiTaB+3WoqobI8REku5
 2DPac5avDZxalt8Qml+QKzb4yWA+5vehVh76EmXf9AYuypByXNLEkG4ghoN8PNM=
X-Google-Smtp-Source: AGHT+IH8akxCcZItngOzWdzUJZT+NbvHjsC9qDh7bnSnwjSlQdiTM3j2bQGjA6Vc3Mp9I3oXHoELjQ==
X-Received: by 2002:a05:6a21:6da6:b0:1c2:9487:ee90 with SMTP id
 adf61e73a8af0-1c2984c9df2mr10545667637.44.1720723865642; 
 Thu, 11 Jul 2024 11:51:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d604eea04sm4695163a12.26.2024.07.11.11.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 11:51:05 -0700 (PDT)
Message-ID: <ff903e0b-504c-438c-b1a3-622b0ab1922a@linaro.org>
Date: Thu, 11 Jul 2024 11:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Host Memory Backends and Memory devices queue
 2024-07-10
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>, Liang Cong <lcong@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20240710180036.101149-1-david@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710180036.101149-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/10/24 11:00, David Hildenbrand wrote:
> The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:
> 
>    Merge tag 'pull-aspeed-20240709' ofhttps://github.com/legoater/qemu  into staging (2024-07-09 07:13:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/davidhildenbrand/qemu.git  tags/mem-2024-07-10
> 
> for you to fetch changes up to 4d13ae45ff93fa825ceb39dfd16b305f4baccd18:
> 
>    virtio-mem: improve error message when unplug of device fails due to plugged memory (2024-07-10 18:06:24 +0200)
> 
> ----------------------------------------------------------------
> Hi,
> 
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - Only one error message improvement that causes less confusion when
>    triggered from libvirt

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


