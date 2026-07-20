Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75DFC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmqs-0001VP-7b; Mon, 20 Jul 2026 08:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wlmqq-0001Ud-6E
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wlmqn-0006XP-Bg
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784549519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd9y3mATfQIKtcIXvAkA2ABfdkCApbp+cQtC4H0DoTY=;
 b=JiY9YoKJqlypMvyEnsaJEX7ZMov4/sYaGZQYnj8Lxf1Yv6Uh4HLcZQKkLrrazI9v7ip2QC
 ZSckEcUKvKnxaZPlLWqf7zq9WxSLlQulyIFZ4diugqlqS0LymRvUn5oHG5bJfO/KR8LJLO
 GMhc2mXt27OCrGhiQJOBLt92JmsedtI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-6qoKLsMKPxaWDOcA2ZwqlA-1; Mon, 20 Jul 2026 08:11:57 -0400
X-MC-Unique: 6qoKLsMKPxaWDOcA2ZwqlA-1
X-Mimecast-MFC-AGG-ID: 6qoKLsMKPxaWDOcA2ZwqlA_1784549516
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15ff68c858so1155083566b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549516; x=1785154316;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xd9y3mATfQIKtcIXvAkA2ABfdkCApbp+cQtC4H0DoTY=;
 b=mkeYEBURH4EaHuZMePqj8lKdbqQqhojrUtqXVGm4rzxMm1HxRcT3mNu1dtRnoBzws+
 xo3UbJNZnc0p8I7tYDsL9WLR5rxm9CNRc+6wB8nefP/ZBOuTc8lboOVP0qUo5q7Dw5s6
 8HbVS12jSmjTGxpmv6Kp4Fl07Z0lOwqLFoeISzwnALgo8+iN4tmJY/aw6bwJoNN5eCsx
 b0WuMUp7DK7c4J2gUwHs+TBVHUMJeQn4KnPSR4hNbZlGlbLBhfiPE5DsoTbT2uJ2Otuk
 Au39qXORpjENp5qZaBI3IBGoBCIryhw90F+Po2Lf3OZL9p+fAqCfbMmri6zAXeK3ajNY
 86uQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgAa1WSvhDV3E8A5cjlMLxpghOS5Go715mLatn5umxpAzXYpu0MVrYC9YM0yjx8+4aOSRK2MHDK2Ot@nongnu.org
X-Gm-Message-State: AOJu0YxAy0zbNIqz32rFdTEOOh+C6CrfZACMvMv6y8JlJgxYf7xGTrBl
 L+db6H4P9zu3Eavog44GGgxgERSUql4+A1Q45RpIFXBxqNDG7rZE+kEKQJ5k7twkZZqf35v2dFl
 YxY/ndY76cpjCKdm1+w7dimEgr/Wb2N8qo7Go6uyjvb6FAIndW8Kb+fG8
X-Gm-Gg: AfdE7cnJNr2eix6ifDnR6t55MCRik331CaV2pHSjftS470K4LrLUN1x9BHswvatWEml
 DN0eS3sW4NMvlRmSdrcJo+xPEpG2zw8YXV7KP9z7k3awFHeRd5q/5LrnPhViMAVb4uFF6PdvMqJ
 MOHPgnIRpsX84YkwmJOH0otpCuuEXtdq2/l0vcApdISk71n4bJIQkTfBrkvGp6WOdaCExTJRDKL
 wklMSdAgCEiNqSr5AbA+Fp58HmRmoOlNhIlAaPieZ02PffLwZQrIbUH4UmGxuFV79cu3STEEiR5
 k2rCVV30QA3U1guwdFh0BJ41dnt7bCI71DlvksETJKS2IJh6x4GsID3O1bZD/cX6Op37x4fHTKe
 kGUbIFkcragk6KXvpPAV2L/xdXgRtPZCKdLaqexzR8eXQTEeG
X-Received: by 2002:a17:907:9720:b0:bf0:2253:ad67 with SMTP id
 a640c23a62f3a-c16b482612amr577604766b.46.1784549516334; 
 Mon, 20 Jul 2026 05:11:56 -0700 (PDT)
X-Received: by 2002:a17:907:9720:b0:bf0:2253:ad67 with SMTP id
 a640c23a62f3a-c16b482612amr577602266b.46.1784549515869; 
 Mon, 20 Jul 2026 05:11:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm447960566b.7.2026.07.20.05.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:11:55 -0700 (PDT)
Message-ID: <c09c55df-a79d-4ea9-a5b4-3eb4c489370f@redhat.com>
Date: Mon, 20 Jul 2026 14:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/19] target/arm/sysreg: regenerate
 cpu-sysregs.h.inc
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 prerna.saxena@nutanix.com
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-2-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260716213858.609699-2-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 7/16/26 11:38 PM, Khushit Shah wrote:
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu-sysregs.h.inc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 05f558610b..2188cd7be0 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -19,6 +19,7 @@ DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
>  DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
>  DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
>  DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
Please could you send a branch. It is difficult to understand on which
code base you applied thise series as
ID_AA64ISAR3_EL1 definition is already upstream

Thanks

Eric
>  DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>  DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>  DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)


