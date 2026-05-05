Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83825CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHvo-0006pV-9U; Tue, 05 May 2026 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wKHvb-0006oE-Oi
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:43:20 -0400
Received: from 10.mo533.mail-out.ovh.net ([46.105.72.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wKHvZ-0002Fh-K1
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:43:19 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g92pf6qrtz5yH1;
 Tue,  5 May 2026 15:43:06 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <danielhb413@gmail.com>; Tue,  5 May 2026 15:43:06 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.239])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g92pf61bQz20dX; Tue,  5 May 2026 15:43:06 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 709F512E34CD;
 Tue,  5 May 2026 15:43:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0079da4aaeb-d162-4ba9-8995-70bc303858b7,
 F941626865CDF094C07CA72CB1D26A64869E1350) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <82129a94-3351-497f-b9e6-1d736ba7e848@kaod.org>
Date: Tue, 5 May 2026 17:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "hw/ppc: Deprecate 405 CPUs"
To: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260505144621.1308457-1-milesg@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260505144621.1308457-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 1155736256623324367
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGr8Bk1vPcwbsxmHrpj8RNDU8eWJe6KJnGTx/ppJPF5VV6eGcutXkCLDo/8gfojPHWo3qWPKwPWGMia0P6o1Fd5e2E4uDefB+b/O7nlMX0oKuj5YAEiWra5SDNdBumfKtqW/9NG2xcHL1e8l6wnBZbnbJY027bdGkL6Ry6+txWjKKKcgEhxRi4kX9pzBLmMk1qxKzNCLBEepFNB2uz74hQcufV0SWRq8ipewcPDS1mEQNTJFVrggNEYMidoJabNOIFE7gvqmYN3e+W6VutZHTjEj9B/sgV/Io+KR0josJ94IwD/XkwBjcYdY9O3WbFJPSB25tVo6CPVoJkEmmC33pt5NWbI0grysUXMZpWrD6OV4chEHTb742K/ay/QcMYA+MDrFcyVskcVy7HC9jzX/Aa6yfwPJ7VV88HQdH+dC11rkQhZ+z+i01T+7jaAnNm+zWHf0kvaoYm1rCm+XXNi7J7wEkUkz1r0EwSTh7n3OOZwnrFcXceMGUA5sclUjDAUZiy2mjLcLvgMt6OQxprOD6Z9tw8uREy+R45y2Nikgfoht70SeSOYof57jlZG8GJXVTUrAIJJPeg/67pRlD2uDY9zsGpdBogAdzjzBYm26fp6dUsQihgPMcxhM/X9kKzfdNV5q7PJ4ZbuAFROmWb47YwuWzeEkP+4Ix2ys+MSpQN9+A
DKIM-Signature: a=rsa-sha256; bh=783MW7YOn3JYH02YRKzkcfk87v8kYmFMEbxWR5JQuZ0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777995787; v=1;
 b=jD0H/R2V+W8u9lrIE7QkiJpnF7f2V9Ler/tMoP0M1fwiT3Rd3N9kR3E+OGaWRHnhRLLe/7n9
 PMHFQHImETh13MEtLlfzA6oO/9gDGGN6pOiFN9mj2YcKgQ6ReNGPqijGGmaoMO7rYtQljKfftZQ
 vN56xgazSsYLnIEwcaU3iw0B/T+yu6zuLgO8/IToJ+pxc+vAK2MDf4u3tm4ldfNfEzrdJ34qxJI
 J8JnmF3IpiMrNS3l/nL5M33yauseOmmz6mWhCdFjxdwnYu6tB7102QqTa0VoEecS6y3f7jNhLMv
 QOg7IIxrc7MBwp25NMdWiJiz9KyezEQWBriaR9xL793qw==
Received-SPF: pass client-ip=46.105.72.194; envelope-from=clg@kaod.org;
 helo=10.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/26 16:46, Glenn Miles wrote:
> This reverts commit 52f0b59ec6b780f2a3e162d5862b90b406fa4697.
> 
> The PowerPC 405 CPU is used by the PPE42 CPU which was added to
> QEMU v10.2.  The PPE42 CPU is basically a stripped down version
> of the PowerPC 405 CPU and is used by the Power9, Power10, and
> Power11 CPUs as an embedded processor to handle various tasks.
> Also, IBM has plans to use the PowerPC 405 CPU model within a
> year to model the On Chip Controller (OCC), which has an embedded
> PPC405 CPU.  

Ah ! That would be a great extension of the PowerNV machines.
It should be feasible now since it's all PPC.

One day, an Aspeed machine might well find its place on the
same board too.

Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> Therefore, this patch removes the PowerPC 405 CPU
> from the deprecated list.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> 
> ---
>   docs/about/deprecated.rst | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 10de10dc23..3639000af2 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -209,15 +209,6 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
>   but for consistency these will get removed in a future release, too.
>   Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
>   
> -PPC 405 CPUs (since 10.0)
> -'''''''''''''''''''''''''
> -
> -The PPC 405 CPU has no known users and the ``ref405ep`` machine was
> -removed in QEMU 10.0. Since the IBM POWER [8-11] processors uses an
> -embedded 405 for power management (OCC) and other internal tasks, it
> -is theoretically possible to use QEMU to model them. Let's keep the
> -CPU implementation for a while before removing all support.
> -
>   Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   


