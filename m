Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C65C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E8r-0005t2-EW; Mon, 14 Sep 2026 17:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E8o-0005sq-Pv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:23:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E8m-0004BY-Tv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:23:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYRh11012887
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vofKRfHfek1sgNUHZpe3DBHsktpm+us4Ojwoc04Lwug=; b=io6qY6qthfyNNIf3
 mQ3D1/BrLJSj2DTx5tDulnXCT5Pym37am6COOa1Fc7hBSChrCLeup7FdNGkU1t4H
 PDznxAFbXrMmWUFN1xi5QCJgQf6W1xWSQXU1MJzdOopleaM2yCLkRTWHBfhcZJxw
 LV92dAksCDfruPTO7a/kjdgfHwt1+8pQhP1N/+cQuN/QD93rZZkgxb/bkxkYh724
 luuggidrZMDKo516sh2C+5oPDXC8TR7+yAEsmaHnI630JkBhtPB/WjOCqvqyFW5G
 ndgW3r1f4NSPpJ7aDZIvDkRoFiC7wZQ57VVXUgVwrsxJheYOOsCaZPNoCNqSW6iT
 7ffRRA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuqanw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:23:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so3569321a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789420983; x=1790025783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vofKRfHfek1sgNUHZpe3DBHsktpm+us4Ojwoc04Lwug=;
 b=QrtnRC+fGq/b279eGsIQwaQ3GPkd9IMhoPayS+JI0s6CQRCO8WafLXjy/MJFxcYH78
 s3rEYH6WWE7o/fcn1d6WsbGR0M4mmLE22HmV0p/Mfc6wFXaNOhqxT4nDYMaHcbt9u6pU
 iZTZyFWbcwB3S56mdVygQ8TwxiSrcNw0eEAjIfiGLwaxXH0oU6lW7YJZaAWwEYwRkcUQ
 lYiWTkDsFp3zYBwFEcX+M9lnTsyJb3ILbDMZ1qVmWzKq0tuAiCAMdXnO6/gjvQ7vk8TX
 cVIUeGUsLbA3N/m+OTJd1xC7gOFzanyQZnq0QbYt8tqgA54TsEmZISddLvU9eU3m43oA
 MOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420983; x=1790025783;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vofKRfHfek1sgNUHZpe3DBHsktpm+us4Ojwoc04Lwug=;
 b=x3vkkcLqI8sAMAmRxMXRitCuBOEIVR2ASExmseY43AUpQiKgI3Pd4rRSznaT6niEIN
 e9GgE1B8lS2aMKz6UVjyBg99EORI/iFlvWlzdPYBX5zFlOPEGWHu70KdJIDdehiS2Wds
 DveSlto7fo69s3PZL5qyx9vPnIN7nvznFWJnHcKP/WcA6EuQW4Xm3LML+cF6RjKHRHup
 6PmkI1p8qivJe1zRdIqyWa8L3n0h7VBV+1cWusQegOwrFNxcazWFzJOdTyl+g/38JB+r
 q05ARo2tsfIMFk/VPN0yE7TMDSKqjDmBtUl1Zuyb9R6Vzzu6nMOnAY9523YLf2pxuCmY
 5Fgg==
X-Forwarded-Encrypted: i=1;
 AKwUvByuLknTVIvgIpgbcaSTvkUyDyi9BK1LgBfwZ2UsN7Gi34DAbYuXyVm4qvVtwGgncuzHGYRnqrMWJlE6@nongnu.org
X-Gm-Message-State: AFuF++kkvKFST6/hCYpAosql9V7AZ89N1ji2Szv9XbVO8BPpPo+KZQQR
 V8Ac8hx21wvOZ7ByCRiJGRdAVsBoFqLIISQxtCCRCmnCnwH1F5itCQXHbgd8uqlllOY8C84J16E
 EI2+VpZV9PxJd7aieHa5QSEpOOxjQBzwtO3+tOl0KoxMX6la1Y87CSLSqSA==
X-Gm-Gg: AYBFou3VY8rfoKhK6IUdetcjIYXssUBn9y/DUHzS1dILxlz7AVyePe0Lgu2kYEpnGdr
 HYDjA6VWmdQx1pKzqeJ8fRb7PLxFYgywV4UUv+6r5Oosj2E6lSuU+sI8Nm5WoFz79retLfmGFbF
 qda9cqgwmsu97wqS6Vbj/mC75kO1QnLyXw0Ea9FZDq2fLJAwIhvv3QGXbnHkshn9dZYCqVhgtJS
 a08oyg//QOSyd5o7zNeUGpa3Xg7jTD31L7rVczCyrBobytins6P98wb1Qb1ksxOx66eGRq/MoxM
 xZ3T6PZ/7aqNnBc5Cq48+wpNc9k8emvkKmEiVf4JyS21eUN2DSPqn52lfY7mTAx6unUlyK3UnOQ
 ukCgGZQoise85kBoX81+RA17cjiAj1129ztqw4SqWFIFZUbSpSd0qTATOW+Sj8pQJd8Po
X-Received: by 2002:a05:6a21:3397:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3db4048a6a6mr10568419637.7.1789420982516; 
 Mon, 14 Sep 2026 14:23:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:3397:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3db4048a6a6mr10568348637.7.1789420982050; 
 Mon, 14 Sep 2026 14:23:02 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b347e6sm25401847c88.4.2026.09.14.14.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:23:01 -0700 (PDT)
Message-ID: <6d3d596a-d233-4d2b-8563-7e6337a89545@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] tests/tcg/hexagon: add unconditional
 store-immediate tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-14-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-14-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX/IUiFTpVKGMk
 tBTEYQKJEeKGQgaOKocxlywVQnJtAtwowv/1FhKjJV8IY+qmrciwjhpJyHI2RryuRR/3lav+rJv
 MT24FpeBkh8C+wp4GycJITqPiIlahtbS1+EBJospXzTvw8PGzLe4WRp3tyMTN4KVvY8Ypg++OmI
 t46Z3/ziUpT3XMLslkYRQe5bdQgYvINjO9pBekwk3Decnx+TIWClNyxzCWTb7ZF5FJQEI3ME8cn
 mzvalAtL2xKuNgF/MHL4bbIBWAKdAdZx5lANZBhqu4eW0QxcN+H1k0ymsfG0SLgxOwAxtdO5eXk
 +3MSCKntXKUDelSUIKS3KPpTAlb9sTZrrNrL0t6L8LB7Qu65/ITiaXW8ym/XayHQRLGLn+JQDv6
 woolEHLAEr4JDnTWGtMjOFZH7VIQkhwD7q3AGsmW8bsRIYnBXOGoe3MflKFig5lbQFzm8tWPy+Y
 5DF0dXPzrbV2jwp4OzA==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa865b7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=oMkgt3vIR8_PSPne15kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: XrjeeQ-93l_vN_5-pm-6DJaa9AIywOrx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX4Edmy9lRe1VK
 Ucj0TesEo79/EjB09OwX+GJPBXQU7Enkohhag8RJjzNux6D2jaS1npJKR0qVbnaHlGIPi+KuEJk
 xlOOHm8eY/xawkuodO2wLjpQC+hyQwM=
X-Proofpoint-GUID: XrjeeQ-93l_vN_5-pm-6DJaa9AIywOrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140305
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/misc.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

