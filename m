Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9902CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wacZS-0005HN-73; Fri, 19 Jun 2026 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacZN-0005Gk-IQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:59:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacZE-0008Dp-R6
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:59:46 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JD9cki3005472
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /rptLxo4eREh2ocZNUqCVbv1QjGFQnWIxB+4ZY/g3tc=; b=kBitzik2E/bcpm0w
 rWw83jiRUbnKqpPFTBkrEDWLdwFYK9OlGaTYfNuPxXHEidPjoxuzVNlh0DOXFBYj
 6lpLPg7oePQk+HVKjSnqGCrAkGOuKuDrHzMsYBy9elsxMVsZII/KTADw7kbDoo+a
 1fW8p6xdf+hTygHjt85z/6Ky/JUy1va4oX7oDGAx/e19uzlJii8ydX7uGr2YYxuW
 KgOS3z5HDyJqgcW/CJ23jUsUFj4WkwXBpxBbcy1AjdWWB86TJUqnkf/elDbYk96M
 WX1ro0AxdbsODaXT7h85gTcQVpHYrKl1KafotyNzfcpjaUknHizcCpy40ND+WJ77
 HbQfvA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmyrcf25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:59:43 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137fe4a3640so3298082c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781888383; x=1782493183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/rptLxo4eREh2ocZNUqCVbv1QjGFQnWIxB+4ZY/g3tc=;
 b=MOCciDsyiBjJmbavZAZhq/lEUPuzF1gqFeVwCkhVjl9dGnOtmbJL5sBUIFvRw8sGAH
 eeRuNxF86xbSh4Z0N7QAu03extvQWdzoOfiWHfEkYrWJb5jvhsXCnWrqDDBBC7KdRbEz
 c3snLDKjCp4pODXwfjB4oVvR/80PqNSCwTt6dcobW0Wx8YNlPwQoX4irx3ujyb3d1R2D
 iBZY5K9LZIvJPAOMi18BXg5jqI6OX5gP/N17DwblXon3VC4q3/hM5XOjLyr/AyN9Ljlo
 ChFIfewl3w+vYC9JH3tdHNvHzgdMN9TGwzywXvjfNsFDFXInPBBR7VibtjFus1T1YS/W
 jnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781888383; x=1782493183;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/rptLxo4eREh2ocZNUqCVbv1QjGFQnWIxB+4ZY/g3tc=;
 b=O40FufpXNHDaF1pJaiI8HVPdIgwDYS9SdnVs6LNJE3YM5MGkFohNOyXEPCxYLmqdwV
 bU89nbFb/IDAcG1GMt9o/rOwtwBqhnPWkzNDWEpWRtsCWivPY8AyYA8c99X4g+2e2RgD
 Cvjzc7HrfMUKq+DFQUe5ZzqovGK7Tsa50jH47tNo1VP/fhdEi3wjXwZKpGuCHrkoXfrJ
 u1soD7AqtL8ONnm8WSUsmkfruJXbVIdLO3iBy/mRWX3Ed5BgZOu4X6isYera3Gl3Kink
 m5if8OkdLx7Mm/4p9Tebuao00H+bBWMqiiuGDc7BiJtYdjWqY6bfzhSv5uSd9Y8nW2a1
 uOfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FaRHvTjDeeqdyOS/gmQMNdd2n3jglXinHEulJe8E1HFuNz+nrUTkJTiZEBeDj8OWcRWbD4mNjao3r@nongnu.org
X-Gm-Message-State: AOJu0YyxL8j1/J0ADD/d+iHpGhcBpCa2/G08J+HQbQiuQywtZuq6X1pn
 bGJpt/u/tQQGh1Tk3oUyyWcfB36z+q/nf1DKwzQ2ckAoXjB00S6u3RypTqt02BthwgD/7n6ydbB
 PyIamnTfp/93hJKNax8SF8iNdLhr7nUjECOHl1u1xr/lBsEro9uSlLJN47A==
X-Gm-Gg: AfdE7ck6R0/1efIpt6Z+NNcAte/dzQjtz62OqteESvIuI+QxxQJbSUCHzhYgsadq8PW
 6CbV+fMm5E7qUoyi1k5s5kA2Qcji+msaz5M2mYSziIYP4nruNOPZeZyc+nyRzoLjlxtPycCrdCN
 r/3lIOyshUfZwxDkTGB1XSo/zzERfrkhSDjbwzus9yZZNEnQpbt4ZT5f98c5/0KTM/C8memPIU3
 LCCgbXcdqRhUPLNFfiNbdSIroz1hDlzd9mH007BNRNM0MbqGR/FChGxyEimAg9db7LMkG/ooByp
 5Zjvrz0VtOY0mqVb5RRStHbMEy2UlaZP1pBqud5b0pP4VanWPiujtvg5SUFNCPGDbq8HY9bbAzq
 zrGhDvkwQVf5XlEGSIWkwExm2aU3phP8KL777AXUKfQ71BVHPG5ZbZTs4/OcE5sQy1TkZn5zfa7
 7dxtc=
X-Received: by 2002:a05:7022:98d:b0:139:85c2:d7b1 with SMTP id
 a92af1059eb24-139a380ed56mr1760193c88.15.1781888382596; 
 Fri, 19 Jun 2026 09:59:42 -0700 (PDT)
X-Received: by 2002:a05:7022:98d:b0:139:85c2:d7b1 with SMTP id
 a92af1059eb24-139a380ed56mr1760181c88.15.1781888382113; 
 Fri, 19 Jun 2026 09:59:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a34bdc83sm2283596c88.8.2026.06.19.09.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 09:59:41 -0700 (PDT)
Message-ID: <6ad6a649-eef9-4c73-9872-095045ce70cb@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:59:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] gitlab: update bug template for sec issues & tool
 assistance
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Cleber Rosa <crosa@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
References: <20260619155657.944220-1-alex.bennee@linaro.org>
 <20260619155657.944220-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619155657.944220-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RZWgzVtv c=1 sm=1 tr=0 ts=6a35757f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3OaHR_JGh9pDv8ucrEYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OsazAosWlIcDXqrygjgSHMev7QQzkA4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2MSBTYWx0ZWRfX7wBEcsaZVktm
 chvwMGxBiBa4r7GePrWS1SNOq8/1k46SwG4vRJGLTRbwwLXIMsNyWLao80obsWJU2XIIbMc20Vp
 m9sB88Zl1DBQ0nPrdpFb1TASp114xrh2FbBZvMsRmoXFA7RG6cbL2htGBqM6/HfEzap5lQzvSz/
 KqyGqo+J9UFa4zDMak4PhvSXG3rcxT4WH9wUfZprJZwbrJtj8yEQLG0CBf+VcpnXt9hPz0G2drX
 rBEagRQajjJKKrPYovrlTr5SS9dCdqYYCSwFv4NYveX9tKLVZmkM3omCcXrS8pajlSPeWkyLmjh
 JAwxonTE/y7+9XncFAlVSMmPcTzLuHEE7PMNWu4UBq/Ws04bDLUJHiUizajudt31VSGjDCPokyk
 j6LwJLRHs9TnovFjGr0H17o96B3XWGu1LZ4eKp+8oYAljt4D0hvaO5fV7rNAmXaBvMPMxNFeZVO
 bxxWj3mEgZmH+o/RJlA==
X-Proofpoint-GUID: OsazAosWlIcDXqrygjgSHMev7QQzkA4B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2MSBTYWx0ZWRfXzZBw8Ds7170d
 RQ9qnmEjYvun2sSsZMUXdE57f9l1X/9a3lBmpNXzbtHqS2cVB2YOPZpeE/3xyS5RU11edpFjx2h
 AVxarvkxhRq3I+LNjq1mTwcLbPCiRL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190161
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 6/19/2026 8:56 AM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Warn that a security issue must have the "confidential" flag
> set and that any findings from automated tools must be validated
> before submission.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260619123632.1276476-1-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab/issue_templates/bug.md | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

