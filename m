Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286AFC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDQC-000542-19; Tue, 06 May 2025 04:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDQ9-0004yt-Ej
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:12:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDQ7-0002Qh-41
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:12:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso11654276a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519173; x=1747123973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5S7dOoQyCu/f9E/gA9Dx4B1UO3Arr91c96EFMsn69C8=;
 b=gRiDgoF7lzyXQyxtSZxSq2HWHVoOKRW4VY388zETMR2ahqx9LOIOCdqo03T56O4KxC
 doyMYuWpj1EcBPCzpNRIJVIrPt63cPXI1/zskUbI0AcXkAUvMKlHxBcIN4SlFxPp9r9x
 ipukKEeLlK7vveOGH3aXpVoBNVNZfZf+2EYmiU6zl6dAbc07poja0FKXc0/gh59jLPp6
 /EZ+T2vaJ627HLgzwvUtdrOew9OX57d01hCyZW96Oz1QeU+xoDa7Wwjz1+W5fLI1SP3G
 VJMeEz00uqJ+mA+gL0fHzPKwpJth87fz5TrtIflBowbZhy5OiFDyZjJbdTIreQTP5VCc
 fT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519173; x=1747123973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5S7dOoQyCu/f9E/gA9Dx4B1UO3Arr91c96EFMsn69C8=;
 b=iNBgAGhbUmsoRCIrP0NIq5f6Gh5HGU0OqXX8/D46N66CA/u6Mlw8hnJcpstkLwgwas
 QHarBE/Ktbin1vNRtVE7aMR16EUlXKMlvB3c2y536uFjm9vijRyWcQwEp5TqWKu58DYL
 eDyterSd4SQtCp7HGRqrO5W3shrFwyFCKjLjlANoe07nGPOQyODTczwmCuH8LVzkjVbo
 LOoboOoOevbCOR5ynSmEZq+u+F9eFQyroFsnflB9Zemp9CoSSDZ4oADioCqPcWnJdA/e
 QQIfxNXzrcdGPNdgR5huodYHe/AuqogxwrAdqCEzHSd6BVJTwGz2jJW9RGXsX1vjJQCE
 XE7g==
X-Gm-Message-State: AOJu0Ywm4uFfvziQthHU0tsNgQxkQEuZyk71PV7HDW61gTqWgTRhnMQD
 qO7nUIuQJvElS54kjVymgxBvFtRLyReu2sKjd/kEkKsgvzi5FzHv5CGsinnlsr8=
X-Gm-Gg: ASbGncv9FaJlu3k1iSxg0rSDRUsaoYbREWjLTteO/J8tL+c/SCYvzqQepc7So4mVudr
 sBMShUwwMXP07/hgfoswV1lD5eAPe99/t8nu7c+dhGQcPtAUT/9hy51cszRvYC0VyWVR0rYpILr
 CoRxZcZqei2y/ONvasyLpBwtPzESkJ4vjdVpj/pad1bFoJXt0nzNAnJrGCBKoqxSEJ++uRyJHf8
 MOVCuigPjN3xvl1szvLvsYUrwZp1XqgdGhi3SH9Dom7TGGChvbGqjYnUkpSqg4PC4Ig58YIXyBf
 5eWUCulpXWr9XY5/ca2aiW1y/9u7OWWQFVqX2s8tkcMjb6gcreTQFgiOZbRh0zWh93fswQY90Ap
 MtQs=
X-Google-Smtp-Source: AGHT+IGR4jwShyqecaGeLGfekWxKITn5LhKGnY2dqgfsjY7lxbaKQTQ2n30biFauDroOvvngIDqb4A==
X-Received: by 2002:a05:6402:2743:b0:5f8:f0ed:ffc5 with SMTP id
 4fb4d7f45d1cf-5fb6182d3d6mr1981820a12.12.1746519172967; 
 Tue, 06 May 2025 01:12:52 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77755abcsm7031968a12.4.2025.05.06.01.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:12:52 -0700 (PDT)
Message-ID: <de4b73f6-b0bd-4d60-af12-10dee174b737@linaro.org>
Date: Tue, 6 May 2025 10:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/s390x: Rename the qemu_V2_11 feature set to
 qemu_MIN
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that the v2.11 machine type has been removed, it does not make
> sense to keep the qemu_V2_11 feature set around. This is rather
> the (minimum) feature set of the oldest supported machine now, so
> rename it to qemu_MIN.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/gen-features.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


