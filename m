Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14F606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZH8hk9NP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FphJyTt2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3bp-0006E0-9b; Mon, 16 Nov 2026 15:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3bJ-00066i-9v
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:46:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3bB-0005pW-97
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:46:51 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfHlx3505002
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eAZv6+KLvlsMfhH/g3nEV6K+z8JIEjZP6npJCfrP7Bc=; b=ZH8hk9NP3B8H7mZb
 rUsovdb7qNRMAW299eYwLPaueev1GYLevijWvoygQIdxQk6VKl4P/+dVaEWTdHux
 eGvF4kiRoMctcyK//FfeZO1NvkL8z1ZAUs8MP3ukOUULSvlgFQuPiuetxHC3d4m4
 6Xfvxpxoa2Zmdet5PAJwzJuayZamZMBkUIhmo+3HuBjYlRguZaDm+PYxW+gDXsTq
 PBrR3VZGxd7zmEtPTO9PUvjW5YsFOr5oJL5Z3yiuEm1lnyLBA/aB67iY7pPbLhwc
 LjC37BNrXJnTsXamLvXFqnuwSCuGX3f9FMH9CVvN2FCKLjFJK/8JtyN7usE9xeOM
 zCoS9w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038m9mt1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:46:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so4905703eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862002; x=1795466802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eAZv6+KLvlsMfhH/g3nEV6K+z8JIEjZP6npJCfrP7Bc=;
 b=FphJyTt2li0wQ8jjhmbX19A1Om3uHzb1JSgx+IOX3T+ccbvJyo/ydrU6IpdxHbI49g
 OpGDl+rOI/bsheRvBDRHIiMX698tmLtC+/qJXzCqtWVzDbXc1pFH/lH4fZxMHNs49Sch
 qfZ1NjkpWPzibNPiatcJ27JWlMAUjFA9scqknyx3dHMjAlYUSn4TRSmmxdpWmPl2qxAT
 IavNudUQs9mygooW/93TobWLTmlUMCzhe3IxE1GBgosZ1mVlI2y2m6m3jLPXqSQrAHg/
 XLuoJu1O9kY/mQXzU7UCJ6R9r2tDysUIqohSUmSV5rGuuYY79AodfL8CWf6roia0y5xG
 3+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862002; x=1795466802;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eAZv6+KLvlsMfhH/g3nEV6K+z8JIEjZP6npJCfrP7Bc=;
 b=BErgB/ScFZEY1EbQ+OZPagoc77KHDOq2SP2xicK8eQlyzbLg0gRXteRARELqbUr4x1
 FK/ZoL5SNHXNmAjdMpdUcKRVRyW6cMrCzuXLJBAelmPFoIWvrrRlGgCwz7ZBjBdlGPyI
 y3C+9GkpS6UqEVvMW2R8cFqrhpNOb/2TPOVUwOme+WfUD1QcpanO213VBnyZltxxpSCQ
 WRtZBWkFgQ1mummuqk2GcqB9fv9LkZ08eii4ehBLYA9aVa2pbDIhi6nA41R9wKB0qXhS
 Aq13deEcglcOybtP64CwJ6xy11gY0NnoNGjgf2qu05Tp4GO1R5h/gDd9Ba/NctuwOUNj
 UjsA==
X-Forwarded-Encrypted: i=1;
 AL+hErEZLnITIU/oM+egqqP+KslnbC0v/upwBfcJ136zoZoMU8qbo+0ISdayoN6+WCqTFt61S6xSTzd9pkH2@nongnu.org
X-Gm-Message-State: APuU4Z+uvx12A7BkiIx/6Ne7r4VQQFFn8nnYQuKLqYZ6EVARVEQrIjhn
 iJ4pkYGZLf+jpSbZMQt/WfSLd7rQ4PbM+mhZdtewnJZ3Ypjkkpgph02BVsU/UrTZGkyksUps73B
 vA/BS4VCeSgnqnThGWlwCszraoAr+wHb8UQOBol76LlN/uJA6avj/Grt9Qg==
X-Gm-Gg: AYBFou2MucEPR9445NZfnI2rlqrETy4o8Kah8434PhtYNLiMMaaNvsMLBeD+qmiiUSE
 KIcT/K1ipyuP6Rkkwey7iBir7hilgXwIpeI+jGO2aeNQTmmhC1mqFM8C+V2E0GivVerZjbknCgO
 GyZOvt8OaQYSxtlZ68N/vVRqvDq5M7EZo2kbwmhI0lJ/0cfC5aia3ySUVNd4koxtdxgp3icGs2Y
 IrV6fAemVx61zfYgMA8mjMBqYC94wO46dSxPQDRGzCUziXa09mndAU0Wcm6X6cTmPkbH+AgCMsE
 S1KgyjEtv2LYnIy2GWdRoO7J0hArPhDpiT3Mwf7GBDx61C/ZkvhkbdxC9v6YUHAG3FO3b1TjJ+0
 aUb3Rku5CIVpdwf1Di4hiOB3pHRL31otQgysXjTwmWaebPlEY4j4PsGUQLLLaycMxcI+HzLPf7g
 UH+oJrPfasBbkFN0kFYRAbuc3v4GIfr4xO3sE2KvSpTzQ=
X-Received: by 2002:a05:701b:2084:10b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-1b50310a7ccmr11431136c88.41.1794862002485; 
 Mon, 16 Nov 2026 12:46:42 -0800 (PST)
X-Received: by 2002:a05:701b:2084:10b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-1b50310a7ccmr11431094c88.41.1794862001722; 
 Mon, 16 Nov 2026 12:46:41 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031bc518sm32650774c88.15.2026.11.16.12.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:46:41 -0800 (PST)
Message-ID: <ca8a6fcb-0b5e-4745-b5c2-99fb6770a62a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:46:39 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/48] hw: tweak approach to setting alias in machine
 macros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-6-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX24dX5H+WnV0q
 3dW/X9cuoeyCnvNP1kqxuoQ5EJitq8rUK/FLCFABGrsXjK49Tw7jSW2zpZpRS1R3R5NeG8kEXpB
 wSJKHaSVGycZX2OWGPZlnWxZoI/LiJa/qPhCH5OWutY35Quj/PxeK3kWg+avElPXLRLfhCi+WM/
 pydIBRSNScNW8IcktYd4RpSap4pzqa2JKCleMwvJvkNJppbtQZ69d7onuF6VTGLYNDmUH0LGjMA
 oYPXMO6X7UlLOf2ZozKsQMxfbOwJhZGg5RcFSyjt1GbiS/IDQMjvZNMtV+hTh1XVBbphcwgytZq
 8itABcDkTBjPtI8TJmw0pBOmt7ayGhAOkIYu3Vk2X8RLmCQ9QpbxY6WpaU9CBxoNU/psCvjbRXF
 2rbSQ0miaRZ2EVBgzeVegKLNPExd3Qi546IDP9kDJkn+7nE7IVjQ6SF4bc0j8Br5Cu/tik96kNj
 Ok7huhuqT6adUwoLnWg==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb6bb3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=iTnJXdYPNMCbwHCpx8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: gWJ3wj30JIIkL8MSYFleNmjHOe_w_fbA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXysHaqLGRLivX
 K7BoNbhZv+cXIRRgiqNrjMgoHGKk5oaqD4PMCB2B6Y46JXXusAxiJlNfmNXRYHAGllNrDwB+cRh
 R0acG7azAlcpUxB0H+hzTF00uivxHas=
X-Proofpoint-GUID: gWJ3wj30JIIkL8MSYFleNmjHOe_w_fbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Currently the pattern for DEFINE_MACHINE macros is to
> pass a boolean "latest" flag as a macro parameter, which
> is then used in a test. For example
> 
>         ...
>         if (latest) {
>             mc->alias = "s390-ccw-virtio";
>             mc->is_default = true;
>         }
> 
> On the surface this looks fine, but this is actually taking a
> build time static characteristic of the machine type and turning
> it into a runtime tunable that only ever has a single code path.
> ie the macro code expands to:
> 
>         if (true) {
>             mc->alias = "s390-ccw-virtio";
>             mc->is_default = true;
>         }
> 
> or
> 
>         if (false) {
>             mc->alias = "s390-ccw-virtio";
>             mc->is_default = true;
>         }
> 
> The compiler should optimize out the condition, but we can do
> do this explicitly by passing the desired extra initializers
> to the macro directly.
> 

Has it been measured? It looks like a very premature optimization to
remove one if that is absolutely not on any hot path.

> This makes the macro definition a bit more verbose, but it will
> facilitate forthcoming changes that require more complex
> initialization to be added to the class initializer methods.
>

As mentioned on another thread, the DEFINE_* macros seems to create more
problems than they solve, and we would gain clarity by simply accepting
the extra lines of boilerplate.

We could have exception of course (especially for machines defined in a
single file), but for global macros available in multiple files, our
life would be much more easier without all this.

Just my 2 cents.

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Regards,
Pierrick

