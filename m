Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B3C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZwW-0005Fn-27; Tue, 15 Sep 2026 16:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6ZwR-0005FM-B8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:39:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6ZwP-0006Uq-Ig
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:39:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItpGF638488
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KmN8E/6AHIcu3mC9vlElZT9UZiYkcdcyJJ0FLfNCRRc=; b=bcIQ7oSHPxBRVKjw
 CBeQpUutrZGW0z32kQ9BIuNmdn9NxsPYKmoO6G8DuROWk7GQ+UqBXmFKFCLJ0jWH
 95mlc/VKBLHw2YTyB6JXOzRGHA6U782JQX7SGQDkOpstOvjjhhsX2/BaORhRWxQf
 7GRxpORkvhF+4hRarCSS6X/ONQMdHOnmcFdMQdiYVDSa16bar8e1Un8kvooV4Yfv
 1GnnMI1MLKXgaMim1IPrrVUBqK+bIr3R+0+rwiZeCcCO4jlKNFOq/J+c/Lb7o6Kv
 NUinu6VQW74oKtQ4IOq70HECHajkobajTxizBF5VM+Y+wPfpIs4yClRwH5IOVUM7
 tt0iYw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtubew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:39:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so8362266a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789504783; x=1790109583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmN8E/6AHIcu3mC9vlElZT9UZiYkcdcyJJ0FLfNCRRc=;
 b=S11hx/oA805f4YD/wUJgev2qahgtW4KpbwH/MSNUHlzW0UjO3KT3nTmEcbaLzM/PrS
 4m5Ah4rh2BoagV7Ibf/hfO7dKafzJ/3yGckveWrGFfgR95ncfXeX71QM/5cmI+9S1I8P
 Tp37CDnGUTNdjgB5plwTrIAn6dPgAcWup5iUMgjk6zAyzAH94zPVzDTvx/63iAHIwh5m
 EH5BvMf5sIL3ClVlRfpnxZMPe0Rccz4OeDrrvDr+YH68SN1+A7/4cWl+impogTnGNm9i
 +BLiR/gU0THLsQSeFdbEyNcHr+JzKTgTj6JfW6YdOtYXu8kOXnZ71nTkUyHAjxdb0odm
 Qy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504783; x=1790109583;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmN8E/6AHIcu3mC9vlElZT9UZiYkcdcyJJ0FLfNCRRc=;
 b=NrNIk/sxOFDz5q5QzOnH1PU2e38op/CkzL4IaFMpzQojDbc/XfQgiqezGtp/sTLfox
 kVM0oL5HkExryzi6pqN9vrz/cZpB+EgJ/xGt3snHynlsRRd5yosIayr+Yt97W3ny6QR7
 JF24Z7bj2do9AxjNQJ9pYoWE3vJGpiZgHnnfM5/H9X8vHLv88BtDc3iYG7nS8Ht6xaME
 WjldGe405hL+XTi4JU0bW4jHnABAyRvsUF+ruKGpSKGTM8xVcdepF7Qh98zPeWS1DHxw
 S1mpUsFP34x1+FeUdOAQg+XUq7Z4brR+855oY05bj/PO3H1/cDVdEOEDBOEXaye3NDVp
 aNXw==
X-Gm-Message-State: AFuF++nyKxc2dcmjY5XAQInMo6/5mzrEjElCUfFnqXZvge/yaIIi0sES
 oD4dqRpZOdOgex3gWl6+JgMmYmpTK7be5hW9exh46hqXvIlVSbjvnaOuv2IaIWqAiIwUSyI8FZR
 r5J/RfWm+GVDwECRXmEIIVGRHOii8QV0L0ts0lqaaOjqPfGj14uIXWcO/Lw==
X-Gm-Gg: AYBFou1pgx7vucgrEveBQXvjEjVqmvDKJT/KajeNN2Rjsp7Q2fiKdSGsGOrHhZaauKb
 fB7l9irKBMbc7QJnP5OPwK51kXFbZ/EvYGng82im2/BOe95ZwnMlVEODIG/QQjCC4k0hF+r1sZo
 y4htUUD7rWIwCkTfVCDzMyiwREm+4pqvsjD4m1N+6f+gkoKkFwBkqZ/DRtZqGD4z9AuHBJ4Vq3i
 HLkBeZIj3RobldRwk3TQ3dPW1JS15BudU8fymLVTEhT5/oyr50EHI+26ZnasK5yLdym3o1gPEDX
 T6F788TB21+GuWkxip2032b9je2g1Bguhs8EvgP5Gk+UrJ0SBT1lNnQtNC+KfuEdC4QLv4JrNro
 xsiozCFL0pmBxofDMYHNwod8KfuqY1MbEOGP92LePsUu29dqzQQhwcTXgz/lsfiO1/Raj
X-Received: by 2002:a17:90b:1a8f:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39e1e42497cmr105442a91.16.1789504782867; 
 Tue, 15 Sep 2026 13:39:42 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8f:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39e1e42497cmr105419a91.16.1789504782475; 
 Tue, 15 Sep 2026 13:39:42 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb19f8cesm90898eec.2.2026.09.15.13.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 13:39:41 -0700 (PDT)
Message-ID: <ed82dbb0-71e0-48c6-ba55-3fec6cbfea58@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:39:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Fix building outside of the source tree
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260915110855.491985-1-iii@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915110855.491985-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Xf3ojk_mvVWE0WpWnE2Eb54_K5AMrjf1
X-Proofpoint-GUID: Xf3ojk_mvVWE0WpWnE2Eb54_K5AMrjf1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMwMiBTYWx0ZWRfXz5e9OnNj8hJa
 m6WXW/GEeq7jrEzz3LG+r+/JmpW15JyTEi6vb/9lwlO+3i2Ik+5veKSph2NoEUKvJ18ldNfFDAt
 3RCgtDmZKxOtc0G0GazhP+NbclLn3CM=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa9ad0f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=a7JDMwMIIuHuGS-EBEYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMwMiBTYWx0ZWRfX+gGUszyyv9C0
 koKc1o1f4VY2o9GgPYsKkULovfKHEHVaiIE2iKnDHC4ChKEUhDYCBQKDv9LyZ+eni2b0OoUMvc1
 cnpeEUWHqQiyCoUFhws25jaxBYjEBWSvV1pXEa86qzdFzZ1qXELUcs9WuxVAAmB0KLu8GTvy1dd
 vNpr2ixRfmKeilSe+RRrLKNtG5GD/c8HGNSmEcaq4713lKBnOj1U7hJLCYf7S0srFmKxVXAq+mQ
 MsehoeKlFqqx1noy2EOKrOiAODfRuOm519R9kToOlrNL8T1vfzviLYHw2AzFwkg5wCHO51RkKfT
 OT4ZbbM5iFWzrmcCkG6uU8PGgol9moy4ywW0S4rPDGftS+7dWmkDYjtE8ZkHubEh86Y3aMsyb0e
 CUE5RUWpwKcIXZQ5Bz+5F0wb0rw3jiHf1xVmLp/UYhxtphzLbXOJZmXnQ2WEESKlQZ2Z5cCrUNK
 KyxYN5N9oOw/17G5S9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150302
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/15/2026 4:08 AM, Ilya Leoshkevich wrote:
> Running TCG tests from a build directory that is outside of the source
> tree fails with:
> 
>     [...]/qemu/tests/tcg/multiarch/libs/float_helpers.c:228:1: fatal error: opening dependency file tests/tcg/s390x-linux-user-float_convs.d: No such file or directory
> 
> This is because the build directory is not mounted into the container.
> Add this mount. Do not bother with preventing overlapping mounts, they
> are harmless.
> 
> Fixes: 27939ad414ca ("tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Good catch, thanks.
Note: in case we need to add :z flag to mount for SELinux, this will
have to be done here also.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

