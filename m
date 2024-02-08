Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812DCC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6z0-0007RC-Lk; Thu, 08 Feb 2024 11:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY6yy-0007Qy-By
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:10:36 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY6yc-0001Qm-PS
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:10:36 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-511616b73ddso3443320e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707408610; x=1708013410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=cUMRxN2xty5KKNWqgryBeh0t0iFDuqxILhwGRGLcYjA=;
 b=h97XmIKfTO4Udf+qEMz/eu/OXQttoeSkbBlylM1WszK1qchSPOZHrcUEIx4i9++ZIf
 hTlRJhhu1GXRoyzKovXA8MEu7LOg12y4Cwjk4j0Dwo8p6n33MOTPR0YW9kmw5xgK5QmK
 HnDAVqLAgMgnDP3ydMiyCemwRlHSBrKJ4Kie4PkGM9y9SiPDinldac50WCFDCESyi0bw
 x+dWgG47kLxSQGREM3KPQbKDjTNn59/oAFtjwbK4OhZUqhYaOMukbIJAis4YUggCmoau
 WRYoe474cVbvjd3h+gOA/fuUEK5fLI0mEz3ldv7jnd4/5y6u7xKKYbzHF/2zcdjTOjj2
 QEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707408610; x=1708013410;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUMRxN2xty5KKNWqgryBeh0t0iFDuqxILhwGRGLcYjA=;
 b=joI1fazqHKS4pJsR1H6+JhA2aqaONi7eJ9joqwCrniulfH4QxvzuRmez174h+tfAf6
 +VkTablS8+6S2szyiexG7ZEsBlHwyL+v/YhkBnuersEbYP/YKK2GPbS5JqYSaSm0ryyf
 LyUY74Wm6vcf2HXiSeHRHySFG9iKOqHJ9oOm5oc1IQwsRTYs8JvvajSGn37StDh1PD9f
 OUZhHwFJZQ3ci2fLvHufPgIJ4rVyj6OROAzNmoj1s6o3buBg3KnEa64yEBbV1vGL53+R
 P1GAoO5uo2jsBrd1l4QeE3Gd7xfDZv07F/Xynhm63evlzRbJQo6SMJFs2ySGwOBBc2Ta
 HTRQ==
X-Gm-Message-State: AOJu0YxDAr83pKOk310DqFblLcOL2WiKPVAppgUaojFftCWP3V2TTEuD
 3ZBZEh+A+tTGviqFgjLw8Tx7spBavT5HbsbSYxxTyiBm2bekktqsrgS+Wxk6
X-Google-Smtp-Source: AGHT+IEs72umYVxzsCA0RGK8RLFpIs63psUo0VhPHEAP6jh/SPh9pXSts0t2PALbCJMTq0B22O7OAg==
X-Received: by 2002:a05:6512:39c7:b0:511:48f4:e748 with SMTP id
 k7-20020a05651239c700b0051148f4e748mr7911072lfu.69.1707408609945; 
 Thu, 08 Feb 2024 08:10:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVH24g5ydVr+0hq5EfwTwMiLrpY9GoLV/SYp6GRkpJqBzYWeP0gyQkfqRKnFqZuR/1FurvZnmYJ2RZr+W1UbI16DePUyTnF70EhvRdHtui+DJMmc7D5ttNBFeQ=
Received: from ?IPv6:::1?
 (p200300faaf1724007ccdd0ba9e70da1e.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:7ccd:d0ba:9e70:da1e])
 by smtp.gmail.com with ESMTPSA id
 je3-20020a05600c1f8300b004101bdae3a0sm2074781wmb.38.2024.02.08.08.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 08:10:09 -0800 (PST)
Date: Thu, 08 Feb 2024 16:10:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_5/8=5D_isa=3A_specify_ins?=
 =?US-ASCII?Q?tance=5Fsize_in_isa=5Fsuperio=5Ftype=5Finfo?=
In-Reply-To: <f53b1dc9-779a-4166-878e-42fd7889cc6f@linaro.org>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-6-pbonzini@redhat.com>
 <f53b1dc9-779a-4166-878e-42fd7889cc6f@linaro.org>
Message-ID: <8B3398D7-17DC-4EB5-83D3-A08A378E0A61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 7=2E Februar 2024 19:03:30 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 7/2/24 12:14, Paolo Bonzini wrote:
>> Right now all subclasses of TYPE_ISA_SUPERIO have to specify an instanc=
e_size,
>> because the ISASuperIODevice struct adds fields to ISADevice but the ty=
pe does
>> not include the increased instance size=2E  Failure to do so results in=
 an access
>> past the bounds of struct ISADevice as soon as isa_superio_realize is c=
alled=2E
>> Fix this by specifying the instance_size already in the superclass=2E
>>=20
>> Cc: Bernhard Beschow <shentey@gmail=2Ecom>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>> ---
>>   hw/isa/isa-superio=2Ec       | 2 +-
>>   hw/isa/smc37c669-superio=2Ec | 1 -
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>
>Oops, thanks!
>
>Fixes: 4c3119a6e3 ("hw/isa/superio: Factor out the parallel code from pc8=
7312=2Ec")
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Fixes a latent bug which thankfully isn't materialized at the moment=2E

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


