Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60C6CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYEO-0001UO-Pb; Wed, 07 Oct 2026 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYEM-0001Tb-WD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:27:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYEL-0003S3-L7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:27:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JNsMv1146308
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 20:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rAQAjUKjEn5izqfqSW5vgeKY5VbCOuoaS/Qgj2sWGKQ=; b=KC2zk2W1BVd9fI6K
 Qb5U6/PwAdTLFurwmj1MWKeAPpSb4i3lUdKYI9ZQpKmFjoB08LzYxS5wHbH8T4As
 tjYDXXSNhgakgJJdvyTSrVK+61jxS1e0jL2E+IBxN+8rY5SEIgNNi06YjDNb5ek1
 lv3GWZ6jp8GWgVk+Jsj7ZbBBcxJ1WwtIHA3Bn6xgCoJOaORwNLtZ6+M4VyrIl2+6
 rhe5xLuAFWLtWdZOrRbBByaByGZd/SUWn1nf+/2qwBkzj7Wtn3GA7M52iLHsx/JQ
 7vx5O34euyIzrdlvvqnyhNWYWjXzpccI6YECC61OZFKjKXElmPneA6aWtPC6vDR0
 tsmyKQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvru2q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:27:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151ba226e1bso6530013c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791404831; x=1792009631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rAQAjUKjEn5izqfqSW5vgeKY5VbCOuoaS/Qgj2sWGKQ=;
 b=M+IgOCZZyPxSL03ibrOlEY9QhZbSoB+85rAeN064MuDB4ER49PB44o5d0tmaSzyQfe
 +55hyQexEKCYJeHB3g9vpoKbzHIYag48D4DdskX7xjsif92o3SlNLvJQeVApvWwcTxJN
 TEzFGOaovey7f66a+0pGwUlBb470VpKPTqzOOwh1IOBLwROITXa1VxGSI2UGff/G+gS+
 HIxTJtdKpHKnDctodkO4iaglKaIww3YXKfk8soPIV+cY8fOx/3DwOYHiKAjqXqIgWvuG
 ZlWxQhkSAx52ical8rHiL4zdqofpfoJbEZrduPY+Wik1TX8KRIyo6cJu9NSawLOO7rL+
 E6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404831; x=1792009631;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rAQAjUKjEn5izqfqSW5vgeKY5VbCOuoaS/Qgj2sWGKQ=;
 b=WklDZ8jO6JshiqbgWS9zl3BdiNr0dlWYydc3ddqW6cZrDWGORZJlskDrzd/FanmxQa
 /isiwO0MINtoqR1Uewh4w9YV7msn8Bzmu7xM8HNU+DeK2UTwpmoh4OqlXmmdu3ng17sc
 NUcvetW+3Q+akm00EZz+33nv5qqNKc2smjhYMrWEl24d2pQgh2BIUuKJIWhZI1/LqSFT
 vbuD8j8apNvOzIt43pHODWC7t0pIErIBakPE+G30eN2Xotgg4ZBMgnbnhzFitixg9VuR
 e+JeKUHNTvplNhuYfODwWzpIcTQsOvC8CSqivUe9Z/Ne/J8QTFJb5mMjSfXQvDR8HbrU
 pY0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsu1KvpNxtRapGsKtOynyBDamcEys88MtKQpHmG2D0TEsPBQIncOdS3qUVjhWnmOyIyHyaCzYPYSly@nongnu.org
X-Gm-Message-State: AFuF++l38VyN1Ah2KDw7G4esnZfXfcQz4yPBAiAYmliXeli24Rl/u6u3
 d4Nnw02GCvadiXxwK3+XDZZiAbpQsfkEMqfGH4Q5o+yVN/Do6cTAscv211O/DhYWmX7AI4Aho3a
 8SJdXlg18LICc3C9CKUXNzbLNk9cJ29rIx21QFLczxUeKHx/rO/ugqRWSjQ==
X-Gm-Gg: AYBFou2Z9hUPKBMjydggZp3tEOrZiQpVH7/Hs045PvW9k0jDgE6r+EXdm9HoKIrEn4B
 aCvATCO9JpyYrMfuKVEDoT1MWKIpwD6M353Mck4wR9sBCAiXVuOwqVWdyrJ1A88YGjmrdDsSw++
 1zhTTRqxSRDFF4RfgB7xYHqgzC/LbceT/yCtGjZJaYj9ebVoqYBmBUpst3Th/RdNSEV3LOpIrMJ
 0Hvc1ZT8Rke2RKfMlr+x/o4qNM21cAYQoB3fe4gspDnyuH3yuqXf12TjdJODQ/YTt9UuiVd6GwW
 W/HRSNOJ2HV6MK0SEfWFWi2BHNYqS1m+oQROp7wy10k/qYqX18XGixZ3F49+l+/DYAnBl1U/Bx5
 O8YznI+/WN6z8IGUt15sHKQ0Xv8p6EzrXMhffkDKJX/bn+rc7IM7l3G6t31MtRClDSuOoTw==
X-Received: by 2002:a05:701b:424b:20b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-16208ebdf3emr3699758c88.47.1791404831193; 
 Wed, 07 Oct 2026 13:27:11 -0700 (PDT)
X-Received: by 2002:a05:701b:424b:20b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-16208ebdf3emr3699712c88.47.1791404830418; 
 Wed, 07 Oct 2026 13:27:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1615f1ac8c5sm15257082c88.2.2026.10.07.13.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:27:10 -0700 (PDT)
Message-ID: <9a8dbc3c-0e95-4e90-8258-46ab97e36f54@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:27:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target-info: rename target-info-impl.h to
 target-info-def.h
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-4-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007115253.328-4-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac6ab20 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=q9Cd_0kJNfd5aEMf_B4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 5Zymtmv0Gr6qaAzCE7ejD9voNaWIffuo
X-Proofpoint-GUID: 5Zymtmv0Gr6qaAzCE7ejD9voNaWIffuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX2nURdst4iQ36
 Gf0r4u8my7S5JsJjQFyaedMLW2kl9TVQJcb+tAsUYhfiM5HMJlFmhjlETnol8Ey0xJPKwf4gXmj
 lkZZSKRSrQhq8ow589d5RfixAzu5GyzWdo8BySNrWm67mLaPtUU+uqnObhSN+m32dmqnWHoUw33
 vQFMXa7vK6S92Chq9s2wYMNW+YbjG8AxXDMx7l1K20LkK70dN9DZ4Hv7ZvCjNaf6YFKiO5wJvUP
 wO2tnq0rycfZlGFyecQS0cXTXOxRjsYo+q37CWgGQo8nucIQlcm5GSagL/F0rQQNA4WxTxz8iCd
 uO1kbCEdH/F1qPeXnVp81y/HXnfEv9Qwf+F4h3W7lujllH8+a4HaJslzBkWtlAnk9FfpmJ4wPfE
 GmA2azVrg1FXIrDeL7D3ASBMVN+gU0Nu4a+1h8HDNBKm0nBsFjMlZ8SPw/mbzjJcu7gu60JNcfw
 H6d9PolS+4HePZ5px9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX9dPjfOqFS/d9
 RJtyu8MKfXg3DugNADg7jDe/Ml1U7bakBURLXnmubltOFuQUeFEpYczAC/9S0oS1gzg2h/wPzKT
 7ib0iu10iUrojYHXFVA9um/ZsPCYGnY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070081
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

On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> Rename the TargetInfo structure header and its include guard.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/{target-info-impl.h => target-info-def.h} | 4 ++--
>  include/qemu/target-info-qom.h                         | 2 +-
>  page-vary-common.c                                     | 2 +-
>  page-vary-system.c                                     | 2 +-
>  target-info-def.c                                      | 2 +-
>  target-info-qom.c                                      | 2 +-
>  target-info.c                                          | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
>  rename include/qemu/{target-info-impl.h => target-info-def.h} (94%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

