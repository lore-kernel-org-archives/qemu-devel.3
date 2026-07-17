Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE53AC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 04:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkaGo-00005N-94; Fri, 17 Jul 2026 00:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkaGn-0008Vy-Cc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:33:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkaGl-0007sg-QQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:33:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H33jMT580787
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cf54BHhatHN5oOwzffckGbaTYD/xeDqzRErSotN+VrA=; b=f/KlZeds0S0MUr1Z
 9AcVhV1u6kRMT2GFNDfZUpTBFTqXKJgRwhd3NGXEwwKNlC+daoTCMb2m3dAAcU7k
 eEYxuY2QvB/xYuKfz4qhC60jhdDKJbA6uVEUnfwf2j4oWc7lmDU3U7N609wWmRAg
 VL6lMa/xjwBLzLIbe/xCK+7t+4r1lWducgirxtGF1eFPki6i3tUtPmnzFRlDl+FV
 JpRXjE7AxzzfYn06uhpSBKVV6vj0EoLmjNw6MUy2nBXVaW2viSE8mzCyW06GPqlT
 g9evytN4B/PaVhOoBzvdANBtl60RsMjxPnrUq5n2pJdwSsIY1Px50+XGfwVP7G5F
 /8b4Pg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffbqugb0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:33:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cce02cb769so52147715ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784262829; x=1784867629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cf54BHhatHN5oOwzffckGbaTYD/xeDqzRErSotN+VrA=;
 b=kVbqJ3enUEFQa43bf9iTyTrwj6aaeNhG2u/wKb4m3PK7VsCJ/LyhoVkHWKqSO/1au4
 pm8WzHsWyiJbzdUUGxlXrOlX+3DqRJA1ioYVYWVQvmQV+yunwes8+DfLYZqa0wQ9WOg7
 BJTn1iab23KYONcjo/F47wS73XS4XrnWgJUGCHiA7wMzrIyr89Li8vX5DOC7SpFOkmbO
 AwaLltysk67cAc0S+KAERVAF/gcyvZ+IrrBFLEhUmRLfIlI+v2xx5k4jtNNFxmScxjwk
 aecGlkZ6cPqFjbDf/QhjsIwKM+/p1rkTqVVit3VTOV4GeVNDIwpJUC6Grl+AJOGdIIPV
 bvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784262829; x=1784867629;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cf54BHhatHN5oOwzffckGbaTYD/xeDqzRErSotN+VrA=;
 b=lqOJu3gjU2joc3nmlrS7uv5hiWJBuMo9hIQTLzf1O4iM1dSNNeqte5uEHkKQaKJjmS
 JlM/M3c2ONuGW7DDph5R+Icuu4Ai2ZrYVUyPbQz/+4jsBCIVmCS9lX9Sza0Kl8cEm9gO
 5q9y86qT8tcvPXlzhcmUH1lEgM851Fb9R6L3fgM551qgkj13D9Uvy1m8ur8oIauQ51/D
 QYeG/9n/ADcGuPLwN5ogAJ2NwH63VzK2pNzg37L3OSxZDAcGq+yguNcnF96UWMRtFOez
 0Hc2aHBy5ak3SNzeOt9wyWyBSlU+OvS4g5z0EWc+jkBxNrK5vAu9ebNW80TM/Y8Jl1Ts
 5V7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+xU4j0d1V5yuar8gQMYb3lEKjKTCrz+zL/ehTLqfRvUSwP9F1lm1Z8tCkAvqo1pSn9HzTPrYbtcMc@nongnu.org
X-Gm-Message-State: AOJu0Yw5KZaJHPQGIGZYwYZbI16ctx2SsmdDJfSkWyvHXdlDzf7M7fF7
 VMc5vEWsVqgmNAIePaH6AxDjutuZQyB5ly81HuIy2uLHTwSyT3qtcPF/UUyIMplVRlFed3BE/Yk
 l69ceI7TI3+trOhPEbN21S3pJ0SkqlcuAmEPJ+h1MntJqKREhnrRnRrZdZg==
X-Gm-Gg: AfdE7clbMV4H30gkkbKX2BR3YWqWdTTqJtJiZL9UhfdF88J6Y35/cP+kqEIso9gMIma
 gp6OmQX2gmFFMxohMd1aYl/DcskJYiDTaNUoOfqWBuILgLCkx1KyLw3q538+CvxpDJgzFCI0TEA
 mxr/Q0v/cL7Qrbd/khE/zy0eiYHQYv3ymztTYcg8GUlNfd2I5Zw2dCUB/Ntgk64RgFpNse5wwhq
 as+uTe9WevUva1dUKqtUBJ076ot+H0fFm6/cH7QAC91HMxm3kMJeVC/QCJpbO91UxVyzmY+mW8Y
 VH7HHHGg6MwI3y6eVs5UcE8ZFZZplG06DcQPiIVoEraL3U9QOPqppPkljBbkRQt59o0Qz/ChfI+
 cpU0DTf8zA8xKd5qsKRgaXWV/TzB6KO+G4b0Ta/PGauUQRE0Cgz8EM18=
X-Received: by 2002:a17:903:2383:b0:2c9:97a7:f544 with SMTP id
 d9443c01a7336-2cf34a18cefmr10876105ad.42.1784262829133; 
 Thu, 16 Jul 2026 21:33:49 -0700 (PDT)
X-Received: by 2002:a17:903:2383:b0:2c9:97a7:f544 with SMTP id
 d9443c01a7336-2cf34a18cefmr10875935ad.42.1784262828678; 
 Thu, 16 Jul 2026 21:33:48 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf344f8c27sm3456785ad.34.2026.07.16.21.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 21:33:48 -0700 (PDT)
Message-ID: <79189100-debf-4799-8e4b-d7a00ddc0ecb@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 21:33:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: build hexagon-softmmu to enable functional test
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u_3IdBE6vbZdfNC1wU_z3-W5UVwcJntW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA0MSBTYWx0ZWRfX8ZIR1anJOQQg
 p80qt86NCr9AokKhTuT93NTiqW06qVJAsKCIu04Wk1Xba03XZHmfjdS67q71bZWYmu8w0qRdMUu
 DrUMKm49Vo/6jfqzWVmuXArvU1WqQaf4x6HHT4MR6P+fpZGnK/6GDjpadK5tKgmL8SLPfBIfYk5
 qSJL3h3C4BCsAPGziQApCakcxar4IX0kH807wIMzCZDshgty8U6PxPA+EIxUAS39BQJaynAm297
 dH2asjSo0JeGSDrOlT9jvyVJ3ejyZ44sRjZwoEsu9zvL7kgqHe81y+72InphfF+RhpeFJ3GEOqA
 azSzZVlJoR5ryuWGHnZLaRHi1wKVhzHkzUS4heAPZylNXTmpaI1HFk2hnHJcQ4fXiT8IRVYAxqk
 QK8uPlFfEe8uIy3Jx9eYM/aDb3Vzvpntdl87uSVHj0A3/a/Ayq5GmfW/yTxEuzeogQaER/menbr
 cZnmDbuWqkA6jXfDsSw==
X-Authority-Analysis: v=2.4 cv=NZ3WEWD4 c=1 sm=1 tr=0 ts=6a59b0ad cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=qbVTx35NfVmC8YQ4Tz8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: u_3IdBE6vbZdfNC1wU_z3-W5UVwcJntW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA0MSBTYWx0ZWRfX+71N7bMV7gSg
 hQ5WTUf11xlwEj/ZCp0t7x+rFMb06P0I+3QyFhKAaNWbcjXWWdravkJRrUmvaO9+NNBOgDT0zrK
 d5H05sifVN9deZZAWmmlTkgxjhkaQO4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170041
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

On 7/16/26 9:19 PM, Brian Cain wrote:
> Add hexagon-softmmu to build-system-debian's target list so that the
> existing functional-system-debian job picks up hexagon functional
> test.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Fixed my reviewed-by tag.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

