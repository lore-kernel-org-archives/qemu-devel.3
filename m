Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BADCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vByiU-0006oy-8U; Thu, 23 Oct 2025 13:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vByiQ-0006nm-Kx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:03:06 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vByiO-0006TT-SY
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:03:06 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3e234fcd4bso199552766b.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761238983; x=1761843783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRFOS9vWQLsIf7YSp0CpPuUhihCN5JPDMh7Wa4ZB3VY=;
 b=TJMn7PwBuqoI/19eDQZ/lDfqtCxbmcsrV5YmTW6yP1BrIaw/8dmkWutnn/K64H95gS
 qO4HbhnxHCAzXmfkzlzqd8d6JuJGZINJjeGC6UVCfm1AFg25IQna4m+RJD5utgzCzpjc
 OH7NbAfEo4tlyiIT2Jf/MKeLd4I+VNPUqj/Nm0ZORAxuymlYZtkLGDbgnc8HSnepH6XS
 N83zQiMVFb4D3+qtHB0dM1ig0l7gWs4EyRRTH7Eor21nAni/z+TIaJ4BaolJ0Ydl5Ofd
 7Te5BSOt6kSQtQ61pitnJNv5jlHldGQhaLfYSeXzGStXv3NN/wEg73gNlY8mYZmeddsH
 8KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761238983; x=1761843783;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRFOS9vWQLsIf7YSp0CpPuUhihCN5JPDMh7Wa4ZB3VY=;
 b=QRF+NBcSr/K6Cs+B2Cg+tg8lm02Glc6tAKRT7gde8SdfEGSs0BNyyOztcefUmaJzEa
 RSyp/+Xcww5Gl9XlvI7FwJB8WfKEtQf29jrY/6jgtalkPuE3pt8TAHJG1pZPn/Rfy/dH
 0FwkpXmfKSJJOV5xmg6OcbcVdyXn5gC5Lpdxf+PXomRAdGTUIhjBDUIDguH79h4ybsR+
 SJjqXQdSLQkUcGTTxxBCccdyDi9W+dRW6hBCckGb4DZTNLYyo/AHcZeu/kwOnkfmaWPs
 yxc+PC5K5D6ux/qXanNleaJO2d+gHibQ4fL+cIlz7F9rxqKdOj3ReKkr9RXzo+cbLfdg
 JEeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVcZAclBeUO6ZfFgac2m3lHz/14jlNKrW7LhdurGSQb1+c5xlor20HqYSPQjfTjmuEzXUsHBYeEKOH@nongnu.org
X-Gm-Message-State: AOJu0YwEwyNGfboD7GqpXMlR9VgZKCsNsc5eDCkbHlzh0upo/PdzKqwA
 1aDGKNRThm3R24NzsVZAHtmepYFZ0JiY7WNJae0+MK6RmBN1RCjft1Sm
X-Gm-Gg: ASbGncuyzK/uImyjqST1rKPCe1TZ1RtaV1cwUQC0HRGTR+RXL95Mv1vQxtB6z6SiDR+
 M3C0WzHF1Xeyu+ZMJXl4JbSyws9qME36WloEKpro2rf3FOVHHPkZD3YED2DAdP2anY89rKBClIV
 2AN7PGIwM2q5fptj2VlZ4LnAbTtVMR71Eyx9cNm1MPjxuQEjyI0d0C+xruM2rJJeBxTeOhA/MHO
 Sg79R3UL8u6sz5jTG/D5DNEoRm7rT7g8OoeBqUBWMurmEd319eaAokxWvpmK70Pkbx4cEGasqsm
 eaOH2mB+1GeRS6w7IDCJwcpouFY1pOegC5zZtDMQy5bFsUhOQO27kevT02Oi18AmfPAO2QEGkpz
 lKl3E7FM2z2aWHSSw/d2JUvvEtOzipHycVzjnxKWTeqwVLdicA5ZZLge2vP4WxxkIkCtjQARY+/
 56k+pj3QZKFN6QJ8vOfhVYRdvpJInr6wnbRWkZCQXnpvI=
X-Google-Smtp-Source: AGHT+IFoCA0ZxzVDg1+ILaAZKVQzRMksVjUmfnL1RLSWuIAUgydiwvg/IRa3z+n8QNHpG8feaoY6fg==
X-Received: by 2002:a17:907:d93:b0:b32:2b60:f13 with SMTP id
 a640c23a62f3a-b6473f42d62mr3091022766b.54.1761238982590; 
 Thu, 23 Oct 2025 10:03:02 -0700 (PDT)
Received: from ehlo.thunderbird.net (ip-109-41-114-163.web.vodafone.de.
 [109.41.114.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d511d012bsm311143066b.7.2025.10.23.10.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 10:02:59 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:02:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
CC: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_24/24=5D_whpx=3A_apic=3A_use_non-deprec?=
 =?US-ASCII?Q?ated_APIs_to_control_interrupt_controller_state?=
In-Reply-To: <0C41CA0E-C523-4C00-AD07-71F6A7890C0E@gmail.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-25-mohamed@unpredictable.fr>
 <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
 <6982BC4E-1F59-47AD-B6E6-9FFF4212C627@gmail.com>
 <60cd413d-d901-4da7-acb6-c9d47a198c9c@linaro.org>
 <0C41CA0E-C523-4C00-AD07-71F6A7890C0E@gmail.com>
Message-ID: <4F98A2AD-02A7-4A7F-91B8-269E9EC8E5B1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 23=2E Oktober 2025 09:23:58 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 23=2E Oktober 2025 06:33:18 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>>On 20/10/25 12:27, Bernhard Beschow wrote:
>>>=20
>>>=20
>>> Am 16=2E Oktober 2025 17:15:42 UTC schrieb Pierrick Bouvier <pierrick=
=2Ebouvier@linaro=2Eorg>:
>>>> On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
>>>>> WHvGetVirtualProcessorInterruptControllerState2 and
>>>>> WHvSetVirtualProcessorInterruptControllerState2 are
>>>>> deprecated since Windows 10 version 2004=2E
>>>>>=20
>>>>> Use the non-deprecated WHvGetVirtualProcessorState and
>>>>> WHvSetVirtualProcessorState when available=2E
>>>>>=20
>>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>>>>> ---
>>>>>    include/system/whpx-internal=2Eh |  9 +++++++
>>>>>    target/i386/whpx/whpx-apic=2Ec   | 46 +++++++++++++++++++++++++--=
-------
>>>>>    2 files changed, 43 insertions(+), 12 deletions(-)
>>>>=20
>>>> Reviewed-by: Pierrick Bouvier <pierrick=2Ebouvier@linaro=2Eorg>
>>>=20
>>> Couldn't we merge this patch already until the rest of the series is f=
igured out?
>>
>>OK if you provide your Tested-by tag (:
>
>Oh, I did for an older version of the series w/o this patch: <https://lor=
e=2Ekernel=2Eorg/qemu-devel/5758AEBA-9E33-4DCA-9B08-0AF91FD03B0E@gmail=2Eco=
m/>
>
>I'll retest=2E

Unfortunately I get:

WHvSetVirtualProcessorInterruptControllerState failed: c0350005

and the VM terminates=2E Reverting the patch resolves the problem=2E

Best regards,
Bernhard

