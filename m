Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CECE7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 16:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT1GX-0002PZ-5z; Wed, 01 Jan 2025 11:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tT1GU-0002PG-9W
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 11:08:10 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tT1GR-00059N-Mq
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 11:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735747680; x=1736352480; i=deller@gmx.de;
 bh=OowPyfUfMZvb+VA34h2RAGUmFQQwGNxXCgnHzAScMYE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=afQZQm0IYwy6udW6MqSTG2hdinRsQWeRKqlc2xZNMAQ3P21b10i0idmer/mTLzCc
 /VeMaPR9BgkbHuwIUjtszFAgkHyoIHCtJm3mWBgZ8MyF+yxRMeLqOcXn5QtjeQAlK
 pPP0vOHVK0PCq7fXd6rltElVsSc5xS0xvNqqdaLogsJNSy38gx21SXa3C4YjInJgN
 3EIhU6blBwA1t1VzX4yGXSLGUrvBSys7pXsjwmHdIRHpP5q1otIkMD1qhjnI+BbvW
 RjrKen2/xO0aCxrhfnkq195X3kiPUZ+OXBv7HnOPN+K0tFxxTqApE7+DCAIBD4oa6
 dsTuf/tUUPz+itXqPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1u0RTf1tFb-00hcyd; Wed, 01
 Jan 2025 17:08:00 +0100
Message-ID: <f88d51dd-25e6-4038-81f4-4633e16cdec7@gmx.de>
Date: Wed, 1 Jan 2025 17:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] tests: Add functional tests for HPPA machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
 <20241231190620.24442-2-philmd@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241231190620.24442-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dDNfohKJ0O8BSiZgfdwIh/LhzQJHboHINK7EH5GRH43h1iocgAo
 eeshg/OFT7PB1g+Vs8KJv3lRFLgc9tdSrTjRLQSu/J7gALo8SS8A87gb7VVIUE2QpAH1z2n
 U1Cv2C98l/dYEU4OdC64UvDd988Y9Nl3EkIaao9hXm1C14ohNbtxFZfG3ewEFbHW1ANHTo/
 HhVEs3E2mjIUUsftrVdxQ==
UI-OutboundReport: notjunk:1;M01:P0:6lDVvl9v+dQ=;x18m1wJxmyeMeeF/8ltS16kHxOq
 uw5RuyU80hoKl+5jgIuS4HX6B4zrJNbLyLcu/iUAxhOVwHngX8DPcsc7WXagp37GrpTrgZSlS
 vXE9XZExvHnawvwe2E6iFEH4nhJrz6mGfRBCoSlW93MVvQ2vwdISK+dhNpHM+/pCA/7u8E5aK
 FYcG7/pGhc5PmqKLQATsECS7V09fzAnKrW/Yi8P2RSVA1bCqlJHR8fJ2kPiXDla0ZWCuNnrGx
 3KobTgnfoi27uOPx5AUTE1HUCMQIiqKIwO8njmZCruvt/GuJiqWZRB8ky0/D61lPKocX2lEih
 IcF0QlkF36H/uACM4RG8FIrwA8zqR19oNJ+2OhYmPQ5TyeUJVALwQrgv7HZxGOs8Hsdla4snz
 e+Wu5xn53qGdd7W8X/OToq+5JoGTHQEtZeHqZnlsmRF1P49maN86R9hwrnDAxEWuacvPqaN+7
 KQrefWULZGCAXCD0c3UCF6vt1u86vIwrBoF9sHt4VkKaSzUoQyoywypaVBglf6G2Remwngzn4
 V0m5hUUjDTmWWXfvr4e84RRgZSAaSbQhjaSMUNf5mEKnbm60XudbZ1wj6IAJzbaaD3lrVmL10
 DG5hv+OeT/oNR9IcD064wzngQP8lQENgeULij5ngLiHd5xirZl11qt68+Ywq67bY1NyEviqAC
 rslaqOVeZRqigQXlJzWVqH21GBxPV1jwhjaSjf24tRQnckwxRMnTWAtArErriFvSmywIHve0b
 220hE10lbYxI18HvGKArxK2/kH/Sz96lxtGYPvjZV0oYO5GNtV50+JL+9Gi8bUuyLtOASgQil
 ktmaTpLnkL5IHlm8E7SCU9hpCfXV6NRA/xFeENyfEaqoHh1cNb2ddhbcaal1MlTy8rtu2WlPh
 rGsLWtXDaiUZTqCCGDTF9w9bwV7TVmFoYP9CiCiNUkUU73AfcjTE3q7COfVmJV27nnxzl95JY
 PBeAu/r+FVxrGTYys48k/Uft/qNdFU5t0Ok96WwiqRTGUJtkfPSDC+4w5KNDVM46G2E6K1tKz
 dS4Cp/DUrqMF28/xoZVQU0mgYbGaSdzANJ3IBwWMWSnZPO64cheEX6U1wOuJw9HusFlMSvvCN
 TA36X/o5/2ZroBfcemafYwFaMl+NuA
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/31/24 20:06, Philippe Mathieu-Daud=C3=A9 wrote:
> Add quick firmware boot tests (less than 1sec) for the
> B160L (32-bit) and C3700 (64-bit) HPPA machines:
>
>    $ make check-functional-hppa
>    1/4 qemu:func-quick+func-hppa / func-hppa-empty_cpu_model OK 0.13s 1 =
subtests passed
>    2/4 qemu:func-quick+func-hppa / func-hppa-version         OK 0.14s 1 =
subtests passed
>    3/4 qemu:func-quick+func-hppa / func-hppa-info_usernet    OK 0.22s 1 =
subtests passed
>    4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 2 =
subtests passed
>
> Suggested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>


