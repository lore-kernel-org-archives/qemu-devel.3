Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED598CD5BA6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPK7c-0002rF-If; Tue, 19 May 2026 09:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wPK7V-0002qq-33
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:04:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wPK7T-0007L6-1m
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:04:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9iEux254021
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5kNCRQ8ghtxP14x7Wf3fN6kKBtbDPBSgr/JDZwYmwRM=; b=SuPkltUQ3+AI2msT
 leaVxgNR8uoGsIb2pSv0X9GuxFtjZTgHTGKYns/pyihkh9pS/YJ/u3/RVXu/IQgv
 LAWImy0DvT5s+ngPDYn9IQ4mDlyBSUJ3l9OvxpaUaBYvyTJUPlWx8+Qr9u23T2Zn
 p8K/BGuz9cwTPxSJftwX1Vg1f3fU6zyooPcow9S6aFdzH5DXvRbZMkxAM9/QSOIo
 sGv9pDunSU/WKGP0eDNqiVEs28Mw+TuPnQxLXEdBd1tfg50KhHsrlFqED58Tvk2Y
 4s3QdibNC8uD7jRPJUDG1Qt1uiUJtrWNPPSiKg/LM9oHFnD80E2pLbUtgPykLIgJ
 BtHE2A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8h87syh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:04:22 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6546ccc8989so1056884d50.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 06:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195861; cv=none;
 d=google.com; s=arc-20240605;
 b=UBtsXcYlTrezEnwkWKTIKfclc94aJtSabuNArsXmyMGVXnvkiLl2cKeQ4rT7vIbRZz
 pubHooWR03MupiSBTmZ1DQQ93Wy+3DiSOwAiLBYgXMar12qXPn34UAn2KFbLrN3VikBS
 GNEArIz3dPU5PElJh6XhgFtHaxROvmTkgSKV3eUFuZPvFrYVipHzuxmHxexybPUWapqh
 xagn4iheswniuCCRd/rgIv6ln5HZxk4v/jhL63Al2Pi58wnEN7sJhryBk/MWZd+19nsa
 w5PLry3klKqyZkW4Md23JLgTFKqCx8inkcZc0luLaL2JbIXoJNOcoOOEyeEUYoZnfEPi
 Ztig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5kNCRQ8ghtxP14x7Wf3fN6kKBtbDPBSgr/JDZwYmwRM=;
 fh=/t4OQDcQOw5Q+xwaXkOoWoUvxjtx2pxFeCZh/pYJrL4=;
 b=VtXEU3l9sQ54uJaFOOUfQHbmQafQ7kgI2F3/HFWWg0rsA7NB27aX0nr+USn9rYdh9M
 +4Nm7OjwVwHTjzSBiFgvsWOxZUslxGiPX7v+6O21L0B3+73cRzzcOXxGRb7yXf4UxFUB
 Re9pevu2SeIsI54Isy06hucCSOcAu2Vh90EPwDpcn5v9xvJRQ6AM7AM2ViV9bKSTYP5w
 oilmkO2naYsedoYq+Y93B1xbJEQhdeFEkHz9lOv7mOPad0UKsCTwCVhZFpQrFITltVyM
 yAklLZZk50swEmo1yxPDRDaM1nQSGmgZUCKwGy5QFQjKAQ25mWP+G1yupE7921yLpB3f
 soiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779195861; x=1779800661; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kNCRQ8ghtxP14x7Wf3fN6kKBtbDPBSgr/JDZwYmwRM=;
 b=PFtks5YphZG8Zu5jjI1aeCoTUMSNIOS830Nd7UlrH0NsHGx9RDcEgl/UOLx2mLDLhl
 3qJdVNVaJ2/8K2s30rNBiRnKEXHyVnKhJPaz9z8E/0fo2gB8fDrXZRNYifiIF2m3Hshj
 546HobdPqu3tna80yZNK5M2By5/h4luxcRhOHd6n6Nkev4sDoePftEZSVM5KmEoi40mp
 hcnOIMhHCA3pOyhCHS3+LVuYriepmFvma235Z4fg1wXyO9HK+un2XITyleRWHyJzSb8Z
 3v/2MbDlLzWk0Y1YE7OSmNqohbpuQaMBRSQyW8d9VPW4v1p7llGB+dyGoA5wIOIV3JMG
 m8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779195861; x=1779800661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5kNCRQ8ghtxP14x7Wf3fN6kKBtbDPBSgr/JDZwYmwRM=;
 b=hY5M5oPE8tXZKZ7n1nQOs167Bzf20S51ZeesQjTvl8bTUAQjEGlBK8cRa1RYbV6aub
 Su5P2cp9Ae4oiDRWB9CcSCFowMP6mXcZFwWQQ3otElpijR5abLAydHVZ7Top0DiaKOR7
 pOhO89+aSeFBErb5avedQQS6m/rGMauMPq5aqqzizX58XXiCXaE4oqkCjKc9qGq6MMqB
 ZIm+laK/j6/Nymg8Eo86mKKfvjVbUph+TKWygpi3Kx+/C5Jq7kknR7CzVIFLMGfm+43Q
 4hKT5BgcWydj4CkCsDVMbHLhmKpfhX8C3xjUeR2rIvNegZmmIkLKCIJ3nqRHMcuzgDAp
 bdkg==
X-Gm-Message-State: AOJu0YzcM06kihCghYT8DmlrrgW3UahjHn0UiJdAaN3UaG58fNvCGMuk
 bcIl+uT+03l35sMY4Tuz6fpgCxSDlkEjsJkNHX6wkF/PhU/ebWuchFOWoqkIrnCd3mue4hUoEyh
 /KYcpu7GPh63IxD7dmczOJyF22pLpIceAZMvZOFUGsFZdCcxwNK0uWasB8u7wdfoW+cBq3o+paX
 jb8av5n/1hKEiS7wG+Nv+YMuNhtrinqdVb
X-Gm-Gg: Acq92OEPcR7kFwu5OapnkIZi5w6o0w2dYDRCHiCWwfUG/Js/7SToKLL6eaYttXTb+lW
 ycSb4TbtsaNeoLRX5SQUGKtvvrZqjlb2N4Tm22jOE5oOEQi9Z+9aEFd4Es9IaK97zxjRnkulApg
 oRa54fA5oSk9Kyu6hRuWz+rUOtKnDetS+4tgDmF9eSHbDO4W7LXj7H+0bejqOgQ0kdMVCWpAD3b
 t9Rg/9p
X-Received: by 2002:a05:690e:1285:b0:65c:2738:c6a6 with SMTP id
 956f58d0204a3-65e226b7b93mr18401812d50.15.1779195861395; 
 Tue, 19 May 2026 06:04:21 -0700 (PDT)
X-Received: by 2002:a05:690e:1285:b0:65c:2738:c6a6 with SMTP id
 956f58d0204a3-65e226b7b93mr18401740d50.15.1779195860809; Tue, 19 May 2026
 06:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-7-philmd@linaro.org>
In-Reply-To: <20260518102222.80735-7-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 19 May 2026 08:04:04 -0500
X-Gm-Features: AVHnY4L93E96V3cOBK18m9zCbOWbO3Q2b972le20FrAyxoiPz94bwRf7S_LjK04
Message-ID: <CAEqNhNbz5C3yPEMBk3mLB1OwMXMGWtZw2pCTc5cnK2Ck26A_RA@mail.gmail.com>
Subject: Re: [PATCH 6/7] docker: Remove LegacyKeyValueFormat warnings in
 non-generated files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 21I7QVeKwDGKygAsh-k76_iWh_8Oorqp
X-Proofpoint-ORIG-GUID: 21I7QVeKwDGKygAsh-k76_iWh_8Oorqp
X-Authority-Analysis: v=2.4 cv=a9sAM0SF c=1 sm=1 tr=0 ts=6a0c5fd6 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=n6MYwUk4AAAA:8 a=ovJmrJClAAAA:8 a=tz06iiwTAAAA:20
 a=JbSHvUmmAAAA:20 a=YbdBfhNLAAAA:20 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=20KFwNOVAAAA:8 a=Cw7ZgxbQYzW7hkfcqRsA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22 a=brTEhlvMp4NY0_u118I2:22 a=cvBusfyB2V15izCimMoJ:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEyOSBTYWx0ZWRfX771sk0Gkecoi
 2bOkFAdeIrX71JRZ+uk8nKdoNPH/07bHILJosjJssYuhxTbZJUIgarURHnZqZud/keT15y1+buE
 +cXRzuD/J8Inf1JSkf4x2c/tHO+5tOLWfjHq+70baSrWZ28sEgUTmMCsecgVkGFLli42uV/QqXm
 V6gd9aRFr+utAOHeVWynWG+j69HcuMo9fcXAxdGRCw936Wg5TCRBdsvsPJbzzfem24oogH4pMeS
 w7Uf9ZnwfIYEEQuke8jyPk4lj/+5Vf7QwjStaGS0eJ0w1cnYD4QDNJ+5N2+XXVT4eqk1PqTqMO3
 Bd3gz2eoktXAlvxVgfgKRWs9wijKs0TJ+qG9RgwkiDqEyidPkYp45CXk+yJB/Sj2GPHgawpc1ME
 l2EPLmNuwcBDWaUS7BOW5kwIBmtrtuZsegn3JjbGqO98rq2ASHsa/y54tVkiTHMQmN4flgenzky
 sFHY3qDCPqFe955PVSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, May 18, 2026 at 5:23=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Manually update Dockerfiles to not use legacy 'ENV key value' format:
> https://docs.docker.com/reference/build-checks/legacy-key-value-format/
>
> This removes warnings when building / using the containers:
>
>  - LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of lega=
cy "ENV key value" format (line 98)
>  - LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of lega=
cy "ENV key value" format (line 64)
>  - LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of lega=
cy "ENV key value" format (line 97)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  .../docker/dockerfiles/debian-hexagon-cross.docker | 14 +++++++-------
>  .../dockerfiles/debian-loongarch-cross.docker      | 10 +++++-----
>  .../docker/dockerfiles/debian-tricore-cross.docker |  6 +++---
>  .../docker/dockerfiles/debian-xtensa-cross.docker  |  8 ++++----
>  tests/docker/dockerfiles/python.docker             |  5 +++--
>  scripts/coverity-scan/coverity-scan.docker         | 12 ++++++------
>  6 files changed, 28 insertions(+), 27 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests=
/docker/dockerfiles/debian-hexagon-cross.docker
> index 91d4b71ac95..3c94f040b81 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -39,15 +39,15 @@ RUN apt-get update && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
>      dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --=
show > /packages.txt
>
> -ENV TOOLCHAIN_INSTALL /opt
> -ENV TOOLCHAIN_RELEASE 12.Dec.2023
> -ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-un=
known-linux-musl"
> -ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-too=
lchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
> -ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
> +ENV TOOLCHAIN_INSTALL=3D/opt
> +ENV TOOLCHAIN_RELEASE=3D12.Dec.2023
> +ENV TOOLCHAIN_BASENAME=3Dclang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-u=
nknown-linux-musl
> +ENV TOOLCHAIN_URL=3Dhttps://codelinaro.jfrog.io/artifactory/codelinaro-t=
oolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
> +ENV CCACHE_WRAPPERSDIR=3D/usr/libexec/ccache-wrappers

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
> -ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-g=
nu/bin
> -ENV MAKE /usr/bin/make
> +ENV PATH=3D$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux=
-gnu/bin
> +ENV MAKE=3D/usr/bin/make
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tes=
ts/docker/dockerfiles/debian-loongarch-cross.docker
> index 55b3dbe4510..d2ba07972ce 100644
> --- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
> +++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
> @@ -40,12 +40,12 @@ RUN apt-get update && \
>  RUN curl -#SL https://github.com/loongson/build-tools/releases/download/=
2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
>      | tar -xJC /opt
>
> -ENV PATH $PATH:/opt/cross-tools/bin
> -ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-un=
known-linux-gnu/lib:$LD_LIBRARY_PATH
> +ENV PATH=3D$PATH:/opt/cross-tools/bin
> +ENV LD_LIBRARY_PATH=3D/opt/cross-tools/lib:/opt/cross-tools/loongarch64-=
unknown-linux-gnu/lib:$LD_LIBRARY_PATH
>
> -ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
> -ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
> -ENV MAKE /usr/bin/make
> +ENV QEMU_CONFIGURE_OPTS=3D"--disable-docs --disable-tools"
> +ENV DEF_TARGET_LIST=3Dloongarch64-linux-user,loongarch64-softmmu
> +ENV MAKE=3D/usr/bin/make
>
>  # As a final step configure the user (if env is defined)
>  ARG USER
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests=
/docker/dockerfiles/debian-tricore-cross.docker
> index fd797dc7ee4..9e7ff321677 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -40,9 +40,9 @@ RUN curl -#SL https://github.com/bkoppelmann/package_94=
0/releases/download/trico
>      | tar -xzC /usr/local/
>
>  # This image can only build a very minimal QEMU as well as the tests
> -ENV DEF_TARGET_LIST tricore-softmmu
> -ENV QEMU_CONFIGURE_OPTS --disable-user --disable-tools --disable-fdt
> -ENV MAKE /usr/bin/make
> +ENV DEF_TARGET_LIST=3Dtricore-softmmu
> +ENV QEMU_CONFIGURE_OPTS=3D"--disable-user --disable-tools --disable-fdt"
> +ENV MAKE=3D/usr/bin/make
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/=
docker/dockerfiles/debian-xtensa-cross.docker
> index ef63e44e2ef..d9130fc3378 100644
> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> @@ -19,16 +19,16 @@ RUN apt-get update && \
>          python3-minimal && \
>      dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --=
show > /packages.txt
>
> -ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
> -ENV TOOLCHAIN_RELEASE 2020.07
> +ENV CPU_LIST=3D"dc232b dc233c de233_fpu dsp3400"
> +ENV TOOLCHAIN_RELEASE=3D2020.07
>
>  RUN for cpu in $CPU_LIST; do \
>          curl -#SL http://github.com/foss-xtensa/toolchain/releases/downl=
oad/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
>          | tar -xzC /opt; \
>      done
>
> -ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLC=
HAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu=
-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
> -ENV MAKE /usr/bin/make
> +ENV PATH=3D$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOO=
LCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_f=
pu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
> +ENV MAKE=3D/usr/bin/make
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/docker=
files/python.docker
> index 59e70a02484..79c554a2d87 100644
> --- a/tests/docker/dockerfiles/python.docker
> +++ b/tests/docker/dockerfiles/python.docker
> @@ -4,7 +4,7 @@ FROM fedora:latest
>  MAINTAINER John Snow <jsnow@redhat.com>
>
>  # Please keep this list sorted alphabetically
> -ENV PACKAGES \
> +ENV PACKAGES=3D"\
>      gcc \
>      make \
>      python3 \
> @@ -15,7 +15,8 @@ ENV PACKAGES \
>      python3.11 \
>      python3.12 \
>      python3.13 \
> -    python3.9
> +    python3.9 \
> +    "
>
>  RUN dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverit=
y-scan/coverity-scan.docker
> index a349578526d..bb9db40f27a 100644
> --- a/scripts/coverity-scan/coverity-scan.docker
> +++ b/scripts/coverity-scan/coverity-scan.docker
> @@ -153,12 +153,12 @@ exec "$@"' > /usr/bin/nosync && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
>
> -ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
> -ENV LANG "en_US.UTF-8"
> -ENV MAKE "/usr/bin/make"
> -ENV NINJA "/usr/bin/ninja"
> -ENV PYTHON "/usr/bin/python3"
> -ENV QEMU_CONFIGURE_OPTS --meson=3Dinternal
> +ENV CCACHE_WRAPPERSDIR=3D/usr/libexec/ccache-wrappers
> +ENV LANG=3Den_US.UTF-8
> +ENV MAKE=3D/usr/bin/make
> +ENV NINJA=3D/usr/bin/ninja
> +ENV PYTHON=3D/usr/bin/python3
> +ENV QEMU_CONFIGURE_OPTS=3D--meson=3Dinternal
>
>  RUN dnf install -y curl wget
>  ENV COVERITY_TOOL_BASE=3D/coverity-tools
> --
> 2.53.0
>

