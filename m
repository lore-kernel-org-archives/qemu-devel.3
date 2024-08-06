Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29728C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLps-0006QF-Rb; Tue, 06 Aug 2024 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbLpo-0006PK-Uh
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:10:49 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbLpl-0003fR-1y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:10:47 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso65700566b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722957040; x=1723561840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y2p+kq+b1QH3l+tEwxaI+/LqcGMZAJUnrFHD2/FgIR8=;
 b=Cug5VrgLL6eZKk3YUVK8irhbf/F8M/eFcWAHGwP9cr8W24WQSEkvE6EuaTispXwIO5
 sJY888szN9x19Z51VODluNjDM01DsS21EdkjZqLKg9/LgTE2Gn4I6LF30BjgtClBicMz
 82+mGnOH0tavlJ31bqPyyMoG5vWh+imhENVlvdKBw3spzh4VSag0kGvG+Qd+cBa++MZ8
 zHFwm7k0j67WOhV1Ox6jtcIRS15viGpGGM/ljrQNOE9EvN7/dDnGW+j6iVBGsQqo41RF
 aZm/0Nm68ujqNF27R0jrvemNBOi3G8QLa3VSRuf4/l2/GXupplDktLtacEP383aTZT0X
 QQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722957040; x=1723561840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y2p+kq+b1QH3l+tEwxaI+/LqcGMZAJUnrFHD2/FgIR8=;
 b=uni1+zYaBUiCcyLSdystzH9EO1RBqb9TJW51ThwMzBADPpGmxZkuVfcBwVY7jHFWtd
 2eYi52RUn0x46llB/VG6zDvX/I7JdxuyrXUHDAFhsVLs69FlIgCeNPC/Op+7d2mHKGMQ
 4k+lABlmVPK5qXZGb98UPj7qZQ7XhsPXbt8c+GOzoMdeZaCLfUY6Y3vIWIurf1c6LrdE
 ARwHr9GQEovqcLcU5DSX4oRKH9uyFDX795VdOmxsQzEpSnWOhUYwwYmrzQMT+01ElCGt
 JGFrkSDePABQFolFqh+ueuz6lb1bun0gJ9Q+/+RMz7xMG1qd06TsHlg4qv+TURJfs1k7
 0VUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlewCES35XRZUGJYu+0Sfc/eNFaM3s6N4VWw/Raay36s404cAHTttIhTyNpMNpphJRC9WK2Ov/gG/IXe5QOUVtQbAvWyc=
X-Gm-Message-State: AOJu0Yz3optA8wgl75K/bBu9xOuy6oJv6lRRAOgVnTJaW+pbQB3CJ1qF
 K4a/1xIdDOF+9Eshwt3Dd2I2/u4JAuGqofFCDl1jK+SY7eYri4EQmBIIFbGOtvw=
X-Google-Smtp-Source: AGHT+IHQeVbWChKStKZV813/MF1Dye5QIiE+PrGSfcSuFVrDoX+wwdHX3U5UtbfN6XjTvKL05+tHdg==
X-Received: by 2002:a17:907:968b:b0:a7a:952b:95ae with SMTP id
 a640c23a62f3a-a7dc509f900mr1182474766b.47.1722957040376; 
 Tue, 06 Aug 2024 08:10:40 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c7e0sm551529366b.75.2024.08.06.08.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 08:10:39 -0700 (PDT)
Message-ID: <183e2ae7-0f8f-456a-8fe3-e57f7acc4445@linaro.org>
Date: Tue, 6 Aug 2024 17:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/net: fix typo s/epbf/ebpf/ in virtio-net
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240806145653.1632478-1-berrange@redhat.com>
 <20240806145653.1632478-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806145653.1632478-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 6/8/24 16:56, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/net/virtio-net.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


