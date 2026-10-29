Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VjCooSeQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NJSn/fUN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVmr-00049e-OD; Thu, 29 Oct 2026 15:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVmm-00049A-IP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVmk-0006fw-Ls
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:27:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXTc3234253
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OFVQ3GLliOkiAFTZfHpJJ49d0L8I8RxGp7vKX7cmb7M=; b=VjCooSeQzau+pLdz
 75hbP6fjrdf5GIRTR/dIMT/xUwmlHXtKwySiuZUNiS4o5xr7O/dNu/g6o2Y/anD2
 D1l3R/qJ/iRuKf1ApnoOs9kN9I9r4zzCyYXFIPk7dsl+P60xbiAQNMqvJrY2As1o
 U+5M8jW0YQyEqI0kNiWD+qIoFIRq1HrYHbqT7PyhMIjIiJDKxbhVUwHdT/uHPZUm
 6IqKqbotFzhQhzZAwtk62Qf5RqYHhhxNbYaO6B9ewaZhNzv76F2oVpUfgndq9vik
 UeH95qDUuYnbvgkCIBnK/A+iNWooV0ZdRHdMzQ0LgCFJmRDnVoTBtIaz4+IQzDiJ
 z+i1+g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2sch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:27:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so37210eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793302056; x=1793906856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OFVQ3GLliOkiAFTZfHpJJ49d0L8I8RxGp7vKX7cmb7M=;
 b=NJSn/fUNYg6qqhD45zmdzUTOJLOGWmgTyPyIHThPMJx1uqFlxgb0eotkYS25+EOJaZ
 d0L45Vu6KT651b3mQNELSQYpJebt3+QINZGBCFxZV5JAYvaYJ4vsap8IlVa24j5w0Zzu
 LIT2ASbK3/uSukqzyuQwkETUJ0RNfGLjfExeOfy3G3GkYbJKxxnicVMtpBWpdb/mszIl
 pnol3XKdKFwsdmSxVn2DsqDBXreeLxtwj5DUZodkvXZ9G7au9tM+WjcP5SzTBPGoF9W6
 XYAYBrHOVsLZ6eraxJK3JQ3AtkHn8VCGwftv5735rEVrRH4y2l1wPeSG4GpxvhyB5jjZ
 jY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302056; x=1793906856;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OFVQ3GLliOkiAFTZfHpJJ49d0L8I8RxGp7vKX7cmb7M=;
 b=UKLdk2vDF4re2Qh1U3w6+pFf/E60oWra/HRueu0tZ6LW7eno4A30C91dPOqaArI89h
 uTKxwLwtF1LOhMswPvNjX+mBP3IuCZ/4CPJUxufbQp2QrMBkhSElpXzbIJn+VWTfK5dh
 C9K6UbnMJdzFmgcuGGH9g3pB+bq+Xc5hnNTs8g3voPuiztVBc9gh5d3wbQAAlak3eKUT
 32tmhDI+09Jo9KLpyGMN4sfHW76CvUqZPa+f3cI/f7OXuoPxXB160Gp+jukWoJqTX6MJ
 sMpHuDp1jO83a0ZTy0SJ97C0sdJzzCYpP1lXvgSHuJDInL99FFoNnzX2feCv20USFXxS
 /61w==
X-Forwarded-Encrypted: i=1;
 AKwUvByVJR8NjOWvZaTLrrhhutgVPnQqXQVJ/sZXZh4BYfmHQEcDMX1FUjIbJE2Lt54YJccKimNEOF8VpkAA@nongnu.org
X-Gm-Message-State: AFq9FYJoxqMCzBBsRxScY/4eSOQRZbKHlXUcd9MW4BWVzOIlTWFqPlXr
 3Fm7JHBe+iZCe2caqDQEjdNwkb4mSWx6YggJSbtFsi532qlEDCijZiunwOLSu8zU5rsxgD7cRZ9
 sA5ShlQMe8i+ZNX1/7i0z8ptXmC/zdQ4Lm2Cabpr6b+oFt6nf5mcnvvxAQg==
X-Gm-Gg: AYBFou0pS8dyF6QJ8xaWdV4gADmUlGM8i86gElRhtuT/roZzLR+2A+heLBva7ATJqr7
 A+pf1GvmZeksWU0zmlU3r42o4C7jiXe6NFFrA/8Mx+OC20Q/a0Tj5K+7+VEJPocXybR6+h8KfcJ
 FcNZkW5KQoUyUxs/y6pzWRrnjc17J/xLLMx63G/skmiQWewVPfZIq4/IVx0J23cEPLOyHrgATzS
 Geg8dU69+ctIsjgz0w0i1CkxTJkDPy5ocjnR8ATxsmOuBWzlInpiqu9NxSAPZTBm8WCS8nWOyng
 YMR9LCb3p6QA5MkNHooUsqbgeFUURX0fZx4nYZyM//qIVYQK17Ex0dMaf9BfAE6gKgINxgkb4LD
 /Pk4F2sR1LLVypqTdold9p+dnCPy0OiPS70whBwMKcBaZeSaFEv3YypfIoEGNWqtmm+aVOA6wgP
 K77GwkikSK9ykySaRH2fjfb5J9HRX/Z+PCmJ1qeD2z2Kk=
X-Received: by 2002:a05:7301:e101:b0:36a:1c46:2766 with SMTP id
 5a478bee46e88-36a42217ec1mr413193eec.3.1793302055743; 
 Thu, 29 Oct 2026 12:27:35 -0700 (PDT)
X-Received: by 2002:a05:7301:e101:b0:36a:1c46:2766 with SMTP id
 5a478bee46e88-36a42217ec1mr413171eec.3.1793302055166; 
 Thu, 29 Oct 2026 12:27:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429000f8sm689637eec.13.2026.10.29.12.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:27:34 -0700 (PDT)
Message-ID: <474cb441-7d8e-4bc0-933d-8cae08e98aeb@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:27:33 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tests/docker: Add the mips32r6el toolchain
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
 <20261029174434.27985-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029174434.27985-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX9CX4FSp6zIES
 Moj0aZaNiitI+88ZcKwD6IOatXDQI5TRbokuXomuikjRMKEES7xI7QslbI88OBB3G8KnGissPB1
 CGFsZoRme2jB57GJM22eQQAvOdBxBSg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX4jh4QjttHZWs
 e+00wI4DfCnlsBnlgPBXGrr8aTTt4qi/nXIQ6autJdZW3MMO2hotRcxhMW7cidqa0/tWjVQqvYC
 VP/823/wXw7chj0u4SWILhTDYbdPKlzKhzgFgpCfQBXn5QTONIz/ZGsj4A4NMQq6JogQzbOK5gP
 76aMzyu/4fjmwPSqgwN6GD+QcJxf4MUIr6EupQjT+3297V8KiSWgfN0ysLCsfvUYbeMIR69k/xv
 1WfUIASjDsLPA9y7hjiRpF1uTVi8DgUfVmfOCjkD04d+kbXHch4Gq8b9vvW7bBTdfRzA2StH/Yv
 KZmYhwjam+HEWZxwgsSFOMN302CDvZVFKZz6SjJkUFYht6WLSmkhj7Fkq+8dCrKheoODXXmY3Qz
 /DRMMcn5HEN54bhpm+GjSu9vdEqgbhfjsYPNhCasPdty9DbOe57DiL3+VCz02S898CY8s4IXgHr
 dOG9K4WSGWmjbUzKXzA==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae39e28 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=KSt7nhjVyLijS4epEe4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: REneOT1vL6PP7-rN4i5EuzR8AjAdnnQy
X-Proofpoint-ORIG-GUID: REneOT1vL6PP7-rN4i5EuzR8AjAdnnQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
> Similarly to commit eaba84a5e1c9 ("tests/docker/debian-all-test:
> add mips32r5 toolchain"), add the Bootlin mips32r6el glibc
> toolchain, renaming its mipsel-* binaries as mips32r6el-*.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  .../docker/dockerfiles/debian-all-test-cross.docker | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> index eefc03c49a4f..d0e59df84ebc 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -129,6 +129,19 @@ RUN apt update && \
>    rename 's/mipsel/mips32r5el/' mipsel*
>  ENV PATH="$PATH:/opt/mips32r5el/bin"
>  
> +# download mips32r6el toolchain from bootlin, and rename binaries who are simply
> +# named mipsel-linux-gnu-*
> +RUN apt update && \
> +  mkdir -p /opt/mips32r6el/ && \
> +  cd /opt/mips32r6el/ && \
> +  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r6el/tarballs/mips32r6el--glibc--stable-2026.08-1.tar.xz && \
> +  tar xvf *.tar.xz && \
> +  rm *.tar.xz && \
> +  mv mips32r6el--glibc--stable-2026.08-1/* . && \
> +  cd bin && \
> +  rename 's/mipsel/mips32r6el/' mipsel*
> +ENV PATH="$PATH:/opt/mips32r6el/bin"
> +
>  ENV QEMU_CONFIGURE_OPTS=--disable-docs
>  ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
>  # As a final step configure the user (if env is defined)

Would package mipsisa32r6el-linux-gnu (and companion libc) from debian
work instead of this one?

I added mips32r5 toolchain from bootlin because there were no matching
packages in debian, but I think it's better supported for mips32r6.

Regards,
Pierrick

