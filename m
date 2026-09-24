Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B79C98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 04:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9bVU-0002Kw-Uk; Thu, 24 Sep 2026 00:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bVO-0002Ke-OE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:56:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bVM-00084e-PH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:56:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O36rxm1953168
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dbDSAUWP9pG0nMh/bJj0hrpYSmaMlN1X3UEUxfUZAFA=; b=dLJGAUPi8E2ivzB6
 z9UXrSF/DANwRc0w0aeMTmeqQynJJUiTaLhnHxAOf4Zi/J5JHntCj9DgCDgsiofD
 WXS0UQ13G+swvvusVLA57czvKlobRo03hZXwYp0RzlWvxdUU1YMGdJzUlgndn7qN
 9bNLfBclgR6s4/j2nux6p4aWb2Ppx9y9Ls7RHIss42y3IiKBGL6phoRLf3hGpzto
 LakoPhfIO8Uv53zF+q4gVDOxPA2VEAwR3I3ZoiEwQoIFrHG6KeggfkE5T5ZPb2XB
 j0HRxreDSYQ0xBV1q1VW5ikdHZgkzBKAWqax/S0OzH85eQI0EJqtpsCJE71DUW2N
 aQfGFg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxua1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:56:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so92914885a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790225777; x=1790830577; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dbDSAUWP9pG0nMh/bJj0hrpYSmaMlN1X3UEUxfUZAFA=;
 b=i+7SgXvfl0qgDzNYp452S9MKy6hoLFshLk+vPblLylIwgX3xRtLvGGPFzrckRQoMox
 TMEUv5Wp0T2sAH/X6FhXD2kczP7vPCW2mrkiyjywxH2+3mtidjXBoQvA9Xqrt75+QYsL
 bV+7NGSqlkoQ/30LY4LucDJovJp6OOJRdUzhc8jTdQhmEvKlqzjbvYWrT92+sw+hsaAm
 uKFz83t9NTSKqnU6BNGTb2jVxiB8ymyxHpNpYeL4OdLrIiMey+7W8s9BDktYC+Fu4Xdh
 Bti7kBlHTBjeO/f+MA+xN1kI+BcN93BVHIXyaE0pa2otgvTjXPA+UH5nvlB43SYinr65
 1ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790225777; x=1790830577;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dbDSAUWP9pG0nMh/bJj0hrpYSmaMlN1X3UEUxfUZAFA=;
 b=osBZ97+Spe7NPeBwBv3O1OD7gTkKw9AYA70/ywRkUuuguF5GKts5fnAFE4b5KmLWTz
 d4y0lnyu+iTx3fGmbOyRQwvEDc08RcMi7PN1wBITNy3WKVVNqwKpLIRk2LCvYm68QZSh
 tXAmp41a8gsqmC53KDF8zMPLgTnpnfBEjdbuhVORzyjp2qfTIgZjuw3OZlwVoebj0lD7
 BLeujyWhCRnnRqTzQkrpxg6IvYAieg4+t2ARdreu3ZzbLwReYnTV+4BmXfGVRMTTqCCX
 TpEmw+Pk+5Q3Jaxmxe3TFMmON9B7VnTZ182UDEPOQCLjvL2J9bKp1ZACtLzmn0ZDsoHy
 2BSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIswIcpHPOTEc0Njyu1CdzTaRs0SXPdvtNYLlFzsByOeKxfho+mJz7wNkk1HdcVHnq1OCOF8jvHCdQ@nongnu.org
X-Gm-Message-State: AFuF++mZQgiFYSqwNc+u7DpxLog3M2Z4Qzb52hdkhly4ox8lPvFOynaF
 gZMVAJT8mw04yr6YqOJs4SAB8WWPzVVYAGx7BW02xQNvhb5dYD+ZVEhfxfsZnsUd+x5HvUXsWWz
 C5LIW1iQ+wFNwbVwDB+/3de0IjWA3AST6cnuyTsrn2KCEU6ljhfbYJuzELw==
X-Gm-Gg: AYBFou1fnN/okYqgDR4SLJKZC/3bhZn9gOD79hQ+qobxBUV9o0/fKBF18h+/fWzk5W8
 ptKORPbrE/kkB7pw81rVhtmJDln2tBLEICuXyyFG85KWXkewiMAPw0Vz8xQfczZgt1+LSeGHUUn
 JqRgeZ+9eYIeOxvLSAoVJc4sh7WZAxH/jE+eKf/cTlmB9MOBYuH7Eu9xE7fKheS4nP6e/+j4VXe
 1yMEr3FpkzoSTfC8yAean5T40T84WWZshPHu9eZwnINJwKR4unTXkzIMLSiX/iokLyBFZCyhfhR
 kOjT8lJoE+Q+/qhzFKqH2ZOuBQpUeYxEG7KbkFuBpjLPA5cVZWvpO7G3DssA7Vtv+VoyeM3t7st
 VCNKpT23SJINaynsKO9knoz16ihNnMZ4/+w==
X-Received: by 2002:a05:620a:461e:b0:939:319f:d6e3 with SMTP id
 af79cd13be357-93c3661afe0mr110685485a.5.1790225776577; 
 Wed, 23 Sep 2026 21:56:16 -0700 (PDT)
X-Received: by 2002:a05:620a:461e:b0:939:319f:d6e3 with SMTP id
 af79cd13be357-93c3661afe0mr110682985a.5.1790225775993; 
 Wed, 23 Sep 2026 21:56:15 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688893a0sm11964134f8f.32.2026.09.23.21.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 21:56:15 -0700 (PDT)
Message-ID: <23393665-9085-4188-b646-ce1504751f3a@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 06:56:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] tests/lcitool/refresh: generate dockerfiles using
 --host-arch x86_64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com,
 alex.bennee@linaro.org
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
 <20260923185725.863311-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923185725.863311-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ufcDM7GsPVPcb4VDU_JNq2aOe0xMfflW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMSBTYWx0ZWRfX76q3PpFX4nVB
 NLN2ZonjIbsyTccsVkG+bI3dkNGK/xmhmmMfgBfRuJW+nvJurupCKTYaWinoirGBK5W1DE4E/rl
 X6Zzl2/eKkBDtUw6lEpUH6PbGFbF8t2NJBRyymHOL0x83xeArtKA5H333wJ7sAY2HclYQT3Pw4h
 jTA2cjXH/vOATEd0ByVqmlwl2aDpeibSSCcrDWgiByr+rbZmrinIPJONq08gyNqCh8p32G28px7
 u+lQkLbwz6RIltq2n1+kkOHCoQmR3TKqtffguyIRTr3ls0bqKjnOb1n710YkLyWOqqc7ySoiL+L
 /q4ob5a5yVIElePJFNEcNqu2vWpYWWyLMvLZiEblubIs91lZKjf7FbRvvQx0Y8mybrUHuSFAG59
 FdG0giBLhng5UTHeBVv1NcIByH/hwtGdYeTqYy8AUNil0HsNxE/pz/DvrNX1jXnZSHr0ECjRf3e
 I3kLtu909wfWnl15YJQ==
X-Proofpoint-GUID: ufcDM7GsPVPcb4VDU_JNq2aOe0xMfflW
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab4ad71 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=kD1aHXNoiUmW-fgF_RsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMSBTYWx0ZWRfX/d6bhp8dnaLy
 n0kF0fYxlIPpoyi7TJIpDXC+W1g2NYBdQx24VVnt9M41IU7JorjJx57kEVj4qdAsponQz37bVss
 5kseIRf7xfExuRo/0A2dESzrajx0t1A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240021
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/9/26 20:57, Pierrick Bouvier wrote:
> To ensure refresh output is consistent on any host architecture, we need
> to specify which host arch it's supposed to target.
> Indeed, by default, package list will depend on host architecture, which
> means that output will depend on which machine runs refresh command.
> For example, on aarch64 host, refresh removes libpmem-dev package since
> it's not available.
> 
> Also, update lcitool submodule: It now uses arch specific images by
> default. Thus we update all images at the same time.
> https://gitlab.com/libvirt/libvirt-ci/-/commit/f34cd57eb892259c26600187bc35cc4152f932cf
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/alpine.docker                | 2 +-
>   tests/docker/dockerfiles/centos9.docker               | 2 +-
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++--
>   tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++--
>   tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++--
>   tests/docker/dockerfiles/debian-riscv64-cross.docker  | 4 ++--
>   tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian.docker                | 4 ++--
>   tests/docker/dockerfiles/fedora-rust-nightly.docker   | 2 +-
>   tests/docker/dockerfiles/fedora-win64-cross.docker    | 2 +-
>   tests/docker/dockerfiles/fedora.docker                | 2 +-
>   tests/docker/dockerfiles/opensuse-leap.docker         | 2 +-
>   tests/docker/dockerfiles/ubuntu2404.docker            | 2 +-
>   tests/lcitool/libvirt-ci                              | 2 +-
>   tests/lcitool/refresh                                 | 2 +-
>   18 files changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

