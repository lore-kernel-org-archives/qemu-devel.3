Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480DC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmW2-0006nV-MY; Thu, 14 Mar 2024 10:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkmVx-0006mT-SD
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:57:02 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkmVv-0007Ah-Te
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:57:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a467739e1f0so63085066b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710428218; x=1711033018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2hzatiBoTg+dIRKPqDZQyDL99J0DoTyOFQorprLg8I=;
 b=AkBrCY9GoykOEaFVGojNe9/fl9T5XpyM2tBNACW/UyXd52J9jXdWdlGf4ZT4w35NYI
 nrISlSsZ6EIIwVxiiBQuIjCPWM65Wa8wNnlMG82vArCpQFNgojt88SrtaLb/9b4xmK5G
 D+2kgTDIFuDNp0yJai6y03ToQWo1ntwHGYeI4fZVlU38Qu+3inISGv0t99H0Lf1p26sm
 K2sw+gpY6OQD2DJoviAbubHJXykk1ePZ7kNuWzuu9SH5qRJtt7u9fLG8LvmznxwJ5EpZ
 oah+RYcresAWTiUyp79HFD3sd3trXvRGtBXi55iw6qkt8WWSDk2tHu6ezRXL8OGY+LCX
 a6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710428218; x=1711033018;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X2hzatiBoTg+dIRKPqDZQyDL99J0DoTyOFQorprLg8I=;
 b=hKUwIN8HgYpKKhFTbjDt+seXJhVlb7cewdJYOmKLGVoGAHf+tfI4C5omrbyY/cuy4Q
 777QlYp3f+p+vbwmA8a1r5mfqmGY3Ye4tK1XnyPvZP36mPCwexoSPt1rHJ3fOHm3pAFd
 j/rRzBFGVtNX2Wpf6Sho1pmLJKxXukOJUssLtn9npKinKszRi1InfVG2u7ftGaw9irsO
 oRm9PycN/5tpUcUOh0e2RrzeQ1NXcBXTB9fU9nWAvsumSTwAtZXXlW+fQbLLDyqoy//h
 IMjCTdIdOQK3YlxIEbQQbx/+lm0EgPrfC0v4Y08I7Ik7nC9z5QnBbNErE+29KlsmBacE
 0Ypw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrCjXVwcSLOqM6Wftxs1mRZamASt+EGlhv+QJFP+xr7R5e+RfbNbP+02KnthCAiJ8nvl+8FafRxl0XmAX2T6rFhA6czq8=
X-Gm-Message-State: AOJu0YzIjo5UcPM9yz9g41YA4cLgra2rUcGSpGg8FaEE6+89PdkyLegA
 wspV926l7ZqzCqQq4CUFaqdvNmbSkzVOlC/8T879AQfA/gmrgofWsfnxMN4oXI4=
X-Google-Smtp-Source: AGHT+IEK8TaTZ+bBVmdw6evvc1QcHRrd5sh5e/8RJmetbo4r7a5GK6uvGTNH5UlK/Zt+BvpYCh4uOg==
X-Received: by 2002:a17:906:e253:b0:a44:e722:db8f with SMTP id
 gq19-20020a170906e25300b00a44e722db8fmr136070ejb.41.1710428218201; 
 Thu, 14 Mar 2024 07:56:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u6-20020a1709063b8600b00a45f2dc6795sm782303ejf.137.2024.03.14.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 07:56:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DCF85F785;
 Thu, 14 Mar 2024 14:56:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 Brad Smith <brad@comstyle.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 3/4] tests/avocado: use OpenBSD 7.4 for sbsa-ref
In-Reply-To: <7da62f7f-3e87-470b-b089-1bfe5aa97555@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 14 Mar 2024 15:39:44
 +0100")
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
 <87bk7hggcz.fsf@draig.linaro.org>
 <7da62f7f-3e87-470b-b089-1bfe5aa97555@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Thu, 14 Mar 2024 14:56:57 +0000
Message-ID: <87ttl8g8ue.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 14/3/24 13:14, Alex Benn=C3=A9e wrote:
>> Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:
>>=20
>>> 7.4 was released in October 2023, time to update before 7.3 gets droppe=
d.
>>>
>>> Disabled tests for 'max' cpu as OpenBSD fails there.
>>>
>>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>> ---
>>>   tests/avocado/machine_aarch64_sbsaref.py | 47 +++++++++++++++++++++++=
---------
>>>   1 file changed, 34 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/m=
achine_aarch64_sbsaref.py
>>> index 259225f15f..0e52dc5854 100644
>>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>>> @@ -159,14 +159,14 @@ def test_sbsaref_alpine_linux_max(self):
>>>       # This tests the whole boot chain from EFI to Userspace
>>>       # We only boot a whole OS for the current top level CPU and GIC
>>>       # Other test profiles should use more minimal boots
>>> -    def boot_openbsd73(self, cpu):
>>> +    def boot_openbsd(self, cpu):
>>>           self.fetch_firmware()
>>>             img_url =3D (
>>> -            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.=
img"
>>> +            "https://cdn.openbsd.org/pub/OpenBSD/7.4/arm64/miniroot74.=
img"
>>>           )
>>>   -        img_hash =3D
>>> "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
>>> +        img_hash =3D "7b08b2ce081cff6408d183f7152ddcfd2779912104866e4f=
df6ae2d864b51142"
>>>           img_path =3D self.fetch_asset(img_url, algorithm=3D"sha256", =
asset_hash=3Dimg_hash)
>>>             self.vm.set_console()
>>> @@ -180,23 +180,44 @@ def boot_openbsd73(self, cpu):
>>>           self.vm.launch()
>>>           wait_for_console_pattern(self,
>>>                                    "Welcome to the OpenBSD/arm64"
>>> -                                 " 7.3 installation program.")
>>> +                                 " 7.4 installation program.")
>>>   -    def test_sbsaref_openbsd73_cortex_a57(self):
>>> +    def test_sbsaref_openbsd_cortex_a57(self):
>>>           """
>>>           :avocado: tags=3Dcpu:cortex-a57
>>> +        :avocado: tags=3Dos:openbsd
>>>           """
>>> -        self.boot_openbsd73("cortex-a57")
>>> +        self.boot_openbsd("cortex-a57")
>>>   -    def test_sbsaref_openbsd73_neoverse_n1(self):
>>> +    def test_sbsaref_openbsd_neoverse_n1(self):
>>>           """
>>>           :avocado: tags=3Dcpu:neoverse-n1
>>> +        :avocado: tags=3Dos:openbsd
>>>           """
>>> -        self.boot_openbsd73("neoverse-n1")
>>> +        self.boot_openbsd("neoverse-n1")
>>>   -    def test_sbsaref_openbsd73_max(self):
>>> -        """
>>> -        :avocado: tags=3Dcpu:max
>>> -        """
>>> -        self.boot_openbsd73("max")
>>> +# OpenBSD 7.4 does not boot on current max cpu.
>>> +#
>>> +#   def test_sbsaref_openbsd_max_pauth_off(self):
>>> +#       """
>>> +#       :avocado: tags=3Dcpu:max
>>> +#       :avocado: tags=3Dos:openbsd
>>> +#       """
>>> +#       self.boot_openbsd("max,pauth=3Doff")
>> If we are not going to delete the entries then at least use a @skip
>> instead of commenting. Maybe:
>>    @skip("Potential un-diagnosed upstream bug?")
>
> Daniel or Peter suggested to open a GitLab issue and use
>
>     @skip("https://gitlab.com/qemu-project/qemu/-/issues/xyz")
>
> to track progress.

That's a good idea. Are you going to respin?

>
>> but it would be nice to figure out exactly where is breaks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

