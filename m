Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9ECC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJuW-0002yp-BP; Fri, 10 Jul 2026 18:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJuU-0002yS-Ru
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:41:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJuT-0007ks-38
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:41:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3QGW1713121
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +VykxOjpKUESwX5mK14Zkpi5oId/tfu52vObmXEpReo=; b=csg2r+MA7qudFq3l
 Xrt80xGAjGijM0EPkhId0+QkqeISLZjhf6oLsVSRZ+Zx3OKVS8TApwevlQ18XdiY
 nj+Uu/D+tzwu3blnvEDWBmjj9yVzOnKk1chGocs+nQhFCqGJUqOxeOF5MGjbSDcH
 OAbaDlbHQc9pG4envzPZyHRxcS1uohtYoP5rODLTK0sslf0BmZSb/NIhful1ui+h
 S+Li2j6nM08fO82tr/EHvVqBuRhzws9OG/e0sSsM88O44Fxuv/2RF/45k4eAKCzr
 Ix46XFfmuENPg/311z66NPLFURs/UScOa+34t0/yI3ryIC4x5i4LvHVPg2K023HT
 n01gqA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339se1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:41:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a236220so15010141cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783723286; x=1784328086; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+VykxOjpKUESwX5mK14Zkpi5oId/tfu52vObmXEpReo=;
 b=VJMzL3uCzlM/oB8EH5Vi3FpWJkNKE7CulF28Q1zvEb0CllVhOSWEvgJ0Zg/rkjGk6s
 VjZB2C/TjLJS2i6p2i5vUTXuK1cg5NCtZjo4iW4f4xhp4Y6vI35oZFIwdHs2fxAHXAIw
 3a4Hu7LAN8E6m6X6lKl697nTsb0plVVi3RLT2rg5sysgQ0nhB2UPmVB9B5J6DmJqvz1p
 yfjHUVKWBnYfMJ7ocs9idVKu8gxU784lP+JscIreUvHh8EaujFT4N4pttzbqbxI1EB4j
 rrz+TDlDhPdFxn4v0pIkuY4TN572vnsqy8BN1e0k+/UnpR/ztMI5Nbku633Jcp4bBqIj
 bnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783723286; x=1784328086;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+VykxOjpKUESwX5mK14Zkpi5oId/tfu52vObmXEpReo=;
 b=I1BkCu/x3aM//ln+y+VeNjZKqxSD/r81ee2COQqVAlLZ4dmyozw3G3DG47+jq75fwh
 J16e/CFKRw8HdVM4sXpQbsWjW1Q6PfnGGiuehi8hw8KtVj2zb8sdXFIg8mQeCKzF15Hd
 M/azjJPgFyIl9GRYMT9ruClq1Nd1whosbIYWxj1RhMNMm+Y8/tHDaM14DrhLUDHGTXO9
 +jT3lpzirEjAVUF4oPrxNWYSyA07ilC0Fop8j6YPDqhDd4D8Qg9TdbtcTSlG34v+W56g
 yLU1jQf2ZOkwi/+jqQaFRy1KD5O0ExL7gIgZfO9JdJwOPrj77404oLLqfWBxxk+/6hH2
 xlmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPgm128siOZrGNtDyPj8Fcs+A+X3FSKQSEHRoYGcDJtMfQNO3ZdPsEa/bataNH9HZwN+5f90Khu9zF@nongnu.org
X-Gm-Message-State: AOJu0Yxd06std9jbEaJq7dicVqgQ7EAsGJ6nrcOxYcLAErNBjUIlepQq
 vBl/dEO74QdyjYsp/W41pZWk7lCRMDpOtLxEEoyyaDmAsf/y+qsoqpWVWW7NVVkof4mr99YXc8g
 rb6BDpLf0fXRbseHbou1mc352FAltuTqYWIdA+gXloEsNJQ7j1upljNu7pg==
X-Gm-Gg: AfdE7clYyRmThPz1nYSt8xWqueG3hA2bCqlkUxDQz22kjVhpRr2bdvB+RwZG/HJdDFj
 Lp2x/y2Sx7kQq5UMA621wtur0IfUxUY5nOYDN2IV+tCuzvHOP/Op3O832PH9dVrUn+ucLZg98/c
 xHJ49v6VwMGI2Dzi3ubz/Wvn9T+JdmlPFtPb3U6sOtIgB3a3NnRXPyfuoMPJ23DYMYRmRITOY+p
 vqy3ehI4aOWQjc7pXmq6EL345Sh+MFyTm4kB9zg7B5BrKwTqa9Kge9xhWIFr7nkIl/0NX1QQq6v
 Z8NElmJonAJgW4ZVXPV+YiBcjuxJJ1I76E8gigvmsg5SVguuM71LLTUnDxOhAXcJ/Sc+Dgkmg8z
 V+doFdkDvSW6vNZYmP2vx797/EpUPdlS2LB9C6iXn/28yWsEA9B+cmf2aWQ+WZw==
X-Received: by 2002:a05:622a:1b93:b0:51c:10aa:9bb with SMTP id
 d75a77b69052e-51cbf1d288dmr8554031cf.38.1783723286334; 
 Fri, 10 Jul 2026 15:41:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1b93:b0:51c:10aa:9bb with SMTP id
 d75a77b69052e-51cbf1d288dmr8553851cf.38.1783723285917; 
 Fri, 10 Jul 2026 15:41:25 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm64714023f8f.26.2026.07.10.15.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:41:24 -0700 (PDT)
Message-ID: <645dd4b2-6a05-4dca-8962-98e325966ae6@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/98] tests/tcg/meson.build: introduce cc_dockerfile
 and cc_docker_host_arch
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-29-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-29-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfXzH8owcrhmovX
 RWE2su1S62eN1FwDkQNtyEuiJmJY4A3LzAjEJvKglYPYCTw6fdtZa3WC0MBi9gC5C0f2DzILzRW
 kg5I1DdgQkIjfuJGITaHzE1vYgQK6Tg=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a517517 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: JNHs4e86sbnpr5hu08--2r9olDTXenYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX+4tdhnOfJNlL
 ibdUfaqV227+8iYI0MP0LHHB+FtBWYyOFWf1p7Ju4iT8yirbVR4XWf24wY/fU6ID/EfBqaUZd7s
 h/Hhi6EHR9miaCjDAuavO1O+7TtEregGc83tdLy4Ao+mBl8tTrAU/G5yxkYwDjRNGRy/SaJkH46
 Y7xU1bBLG4iRLaDFVjlOHxaE8qr86t+mDxnlYLDomuHxZMGJo2JTWAtdKRSVaQ0d3ShSTnEqH2y
 E/ka3Hw+gvpNwE5M5PWa2Z1My12Rk7N+psozC9QFNr3x80wTz+tZoHyZ9d08WQBnNi2RV1sPL+/
 E8hc1JypLsQw60iT7F7gXvq4gfY/Tz5NDF7ZO7f4OuBp+DYbtVLGeFl/xc+VYuveUyO7QNN0Uky
 pbj6SpgdWD4nE2rW1xWyEMMo8cVJF+BzM/6fueGVmT7MnFD5cNcSz2DiRSrvkIN3ENZIhoi6Jdn
 RDr4Hyml4TBl0F9aKzA==
X-Proofpoint-GUID: JNHs4e86sbnpr5hu08--2r9olDTXenYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100226
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

On 10/7/26 23:42, Pierrick Bouvier wrote:
> We allow target to declare a dockerfile containing required cc. We reuse
> tests/docker/docker.py, and correctly set dependencies for tests on
> original dockerfile.
> 
> We specify list of hosts for which image can be built and contains
> required cc, using cc_docker_host_arch.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 61 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 57 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

