Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA05CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGYvP-0004sC-Sc; Tue, 13 Oct 2026 05:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGYvG-0004rt-Mo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:35:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGYvF-0005NI-0C
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:35:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so16149895e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791884147; x=1792488947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hsEmK5wgFsciDI2KPObHs0eU1Tx1h/DH+LzyFsLLmsw=;
 b=rAjC8aCvqIjbEubZ0qh6xnb6nabpEqhQLTavhL9mtKP5S+NZ7WOwdREaabKM9b/saU
 /qYK5SAjA/wIK+jwcjDOTf9Geww5M+159Dv2J8BH3mP/DQK//VBZtvt1YjNSN7JIkY9Q
 VKeIK6NUZdcwtzviQf6u7ooT4GLabHFhPfAlgxiS3U5JOqD44Y2Jfkmn0wKuJlgnSWEf
 MqBGlU6CecUoapXNr/nk+PyF3nUDjgFkGuDfPxfe8OJ0s5XyOSibC+lozgnDTyI3JQ4O
 pYxHSFPwU3fq1F8bpHljr8UXQAFma68Ag2L0FohItVCDTbIyY7trM2mkS7VsFwIPUyVo
 VcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791884147; x=1792488947;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hsEmK5wgFsciDI2KPObHs0eU1Tx1h/DH+LzyFsLLmsw=;
 b=2Tj6YrrQNCxAYkqlv16tUMLhLb5R/YiJc83l3dz9DNNnlvwb3UmKJRA8G89GIoY6Qi
 zEKyRzn4UUrBYwDXcSEJYyb1ScH8WkiqzgKSIdacc3b9MiLevx4GG03zPD9e+w+/IjUS
 cWcXdCOME3Gf9smVDR6ShttCnlSuA8myeP3Wkwh27dwqAjtFaLeVTGgv4G0x6i/GoKvy
 xP+wlcgbp+nb7zvznwDzEp3YaadwKulPdeaWCUlLdAMncQPzqOchwZqKpW3zjgrQYGvN
 xxDstFDBhe8076d06Jsb+pIytFgeEwarqQ+t4CF1kdaFAyGIzK/i+RN21E6vRsgpWres
 dr0A==
X-Gm-Message-State: AFq9FYK/nOzjWQfPV4Sh5hgbV3/MyFqdgikC8PHVNAsDt+TfXo1R3R4f
 qaxtoijjGH8rytHLWbgjsUIy7SxBaBL7rt1BE+9FdbGA5W9p2aXz6X6aDOD6X64VSBk=
X-Gm-Gg: AYBFou3WtI0fVOIQwSR3lJkF1bixMBNtQeQl87xtUIxN3UK7jUm434k6gN4+UBggGZL
 yfPWRRlJ23ItP8aYprjihkBNejlHhZ9BmtL7S8EGEijIDJ5wfJyIzI0DGLNDzPKAjlSWfs5S86p
 29bVvIzwCrneAgVGlRWZ/I54x3ychv6/6jT1Lzt1qruBlCOWZ0sZbeGTx5GuKRy/HlnYCjII17J
 t5RmFuIB7hYWDOMpcj5eIQxEEF3g69/3WmxVp/p+8XhK4S6tkopWXw1m5wKCTmjVRVGK3Y6PHBw
 aKc63hsyl3kXQ1KuT7kwZJUEjQVDw3J51psnYxtRInvAjZON/jKgP4n7R2vaa5DSHiqKDtIecAY
 7vjECxSoKL+nWI5gFCjXgINzyBN7s5kvoIU8NooZFbxsm8sBsKOmPenmitlcaJTlknPg0Gs6JPM
 FZMc16t0zSGTbrODbrk9TihpP6oKm4nEvs65w9PDw5cOAvM3CPV1arWa8GLuBhFRrLaw1A9A==
X-Received: by 2002:a05:600c:19d0:b0:4a1:a39b:e75b with SMTP id
 5b1f17b1804b1-4a1a39beac5mr77086655e9.21.1791884147078; 
 Tue, 13 Oct 2026 02:35:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bbbdd75sm272123375e9.1.2026.10.13.02.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:35:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 23F7E5F8E5;
 Tue, 13 Oct 2026 10:35:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Zhao Liu <zhao1.liu@intel.com>,  Kyle Evans
 <kevans@freebsd.org>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Brad Smith <brad@comstyle.com>,
 Ani Sinha <anisinha@redhat.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,  Keith
 Busch <kbusch@kernel.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  John Snow <jsnow@redhat.com>,  Eric
 Farman <farman@linux.ibm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Anders Roxell
 <anders.roxell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Warner Losh <imp@bsdimp.com>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>,  Klaus Jensen <its@irrelevant.dk>,  Song
 Gao <gaosong@loongson.cn>,  qemu-s390x@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 06/16] tests/functional: update x86_64 tuxrun images
In-Reply-To: <as3mM9XesjzPA0o4@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 13 Oct 2026 09:05:07 +0100")
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-7-alex.bennee@linaro.org>
 <as3mM9XesjzPA0o4@redhat.com>
User-Agent: mu4e 1.14.4-pre6; emacs 30.1
Date: Tue, 13 Oct 2026 10:35:45 +0100
Message-ID: <87cxtegcy6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 12, 2026 at 06:03:20PM +0100, Alex Benn=C3=A9e wrote:
>> We now split the fetching of the buildroot image from the kernel
>> itself. This is because we will want to access additional metadata in
>> future tests.
>
> This commit message appears unrelated to the patch content or subject
> line.

The kernel is now coming from: https://storage.tuxboot.com/kernels/6.18.54/
instead of part of the buildroot build in https://storage.tuxboot.com/build=
root/20260924/x86_64/

>
>>=20
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-ID: <20260930164649.433573-10-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/functional/x86_64/test_tuxrun.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x=
86_64/test_tuxrun.py
>> index 729f6447d05..026b373accb 100755
>> --- a/tests/functional/x86_64/test_tuxrun.py
>> +++ b/tests/functional/x86_64/test_tuxrun.py
>> @@ -17,11 +17,11 @@
>>  class TuxRunX86Test(TuxRunBaselineTest):
>>=20=20
>>      ASSET_X86_64_KERNEL =3D Asset(
>> -        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
>> -        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5ae=
f8')
>> +        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
>> +        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac665855=
2b')
>>      ASSET_X86_64_ROOTFS =3D Asset(
>> -        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.e=
xt4.zst',
>> -        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a7=
51')
>> +        'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.e=
xt4.zst',
>> +        '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e2=
7c')
>>=20=20
>>      def test_x86_64(self):
>>          self.require_accelerator("tcg")
>> --=20
>> 2.47.3
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

