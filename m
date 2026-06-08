Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC24CCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdJZ-0007iB-Op; Mon, 08 Jun 2026 12:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdJO-0007fb-O7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:58:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdJK-0001Hl-UI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:58:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFk5c4017477
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zAIlVzgPknttdusWlyrgVyWpg1W4OyCtMvc7io/hDWw=; b=LpNNNayxJayk77i/
 /4HXk/Pye37nK9CebqnzYEt9K+/pYS4CKAa+l0kU1pgqCw6h3NyXTiA7FcjZFKTU
 H1w4lxmDVubGlvAC82laTeS8wctNWbJHYu3pvzXmLzkG19/xDBN59Cp4AWbmemKg
 J6xFy9xbdxoHVgdCUFNwGmejGp84oeIUG3Q/oG20FT6KKTgEhbOxd1PJ2LTrBphm
 Vz8R8Xcn3vwtZTC7HNFLi7neEcfWY6mzmkIa2EPFLqsI21ceKMISIDnQXgK7eDoV
 GL64QvnhqVnrq9mEmQKctCq5oJ61xfjJOCIykg2scZD3/LQcebPSgDebtoBV7Ziq
 h98+CA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8hy06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:58:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30762d67a64so6439721eec.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780937927; x=1781542727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zAIlVzgPknttdusWlyrgVyWpg1W4OyCtMvc7io/hDWw=;
 b=keCn/Z8S2uoI4BZMg59l1vGSSiUoDs3IGc9/yaG4iza8BRcW2tpeRgY22J2/OXncD1
 lkvHD0R/OyF8x+XOrUk/dBl+NdXonnhhZ06DeLbwjQ3gQLeZru2HzvHbHkeBWh9QXy6m
 kEMtjvbKbryt80yGB7urZ7NeWG1i0r2KY/uxvac5ec1vRttvTMeExqeYhYZszyEELkeH
 QmiuUvEpAVEtyIFF8UbzxCdBu7ciRXA+cSiE3QcFlte2Qc0hWdJWow9RStWHA+T1+65T
 q58wLavVabnHf3OkZMzlSQ8Obw+Nu2mlEOQ3muYS5OzFQEfUMcgvFirmJTwEwi4QXpEn
 52kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937927; x=1781542727;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAIlVzgPknttdusWlyrgVyWpg1W4OyCtMvc7io/hDWw=;
 b=Up+Ov7F8T3vZ+g/CJKo1BOfVr8fbAQi/LNNbPMucbbC/ZFrA6l4ZvMV+4t4U0NtsFI
 uFBuZ3Q89WPG/9P6c9rmLa3n9ns7DuWosUSW4HmrriAcKxZvfRiUgZhMqnwr1fyR9jke
 nnBeNVpEcp9HDTC6iUj8z4yI9X2aawsla4OleSCuHUkYntfvGV/oNGLsd2XIbZ7QolEI
 +AZrE1xOOIe3otQJeZQaCkgPBMVw3WnFqwC86+a1f67dOS2zKD8TR8VWJnNXVIYgVL46
 snGijTj/vvzOWT7N6k7kelrO7+YjST7S82doPrM7gkRHlLNVY4Ug17017EkYEO4oCZqI
 Xt2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xfUsBZYsLzQnP12DzuzBEsa3+mphmZOSnhU2qETLr2jcVwPS9d2/bALcgSkZiQSwc7HHUaPrnofWM@nongnu.org
X-Gm-Message-State: AOJu0YxrvZ6WBuAZQx2i8c5Vh7ylgfV2nI5cl5IenE2uZ/NkdrVidOqi
 xZGbvkKTgnNuY/JZQTaUDFbmBz8n8/P/kOJ/SwRfPyJeTqLCNt4GHFr9JfM5lFQlLSBMwYwmaoG
 Q8D6WNNfz4zQcRnbpwQ9UMYIC6+eOqnoE05m1/h2T8q6+H2ChtNzOgGQKFQ==
X-Gm-Gg: Acq92OHlvt2QzvOCYnh4HoHhMfvS7d8CJkynImEzABfeS4ObxW5pvE5cGoVa3c8Z/Jo
 4QDqnwQ/PWfUen/2mrWWH2wGxue3+ejBGcy5uCoWSZ9Ko4cYryis55RJaUWHappB/5PPv+br3s/
 5eh6bzQTJsBKF/xfo9vgSsp18Oh68OPVuUiJV8Zxs765lgLYvc/ahiwyxEyA09n4kJNmdX67QBp
 dRNdzfy4T2j1EXxBp3GrQdtqpbqegNWNaevuGCgVMOj0/Flf/b61+dxcJjF0D6rMS5z4vourYGy
 ZMmi2dmeqclT7NVSeiQwAumCNAUztllp8paw8+DcT+44o9PH7teNTLhRt+mI1aP4vEqSIWhWPNK
 2z06I/C86Ri9yYM31JvmkZXG828VVqQ8LMjiPdDQo+FmZL3EUpYs3KOkLXRypwf5TMDH18bMJk3
 0ZDpBXkgUB0bbtHeAw60Xqn/++
X-Received: by 2002:a05:693c:37c8:b0:304:5a9c:644c with SMTP id
 5a478bee46e88-3077b3cf48emr9489576eec.15.1780937927466; 
 Mon, 08 Jun 2026 09:58:47 -0700 (PDT)
X-Received: by 2002:a05:693c:37c8:b0:304:5a9c:644c with SMTP id
 5a478bee46e88-3077b3cf48emr9489537eec.15.1780937926871; 
 Mon, 08 Jun 2026 09:58:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm24809015eec.11.2026.06.08.09.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:58:46 -0700 (PDT)
Message-ID: <9d9538f3-1533-48ec-bfc1-9382737c9083@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] docs: update mention to ubuntu2204
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
 <20260604215148.3769627-4-pierrick.bouvier@oss.qualcomm.com>
 <2630897b-acb2-4638-bb96-388075c05063@mailo.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2630897b-acb2-4638-bb96-388075c05063@mailo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MSBTYWx0ZWRfXx7trVAZtLq7C
 IuCzOgQkpBEDsdkFhgsCD3Df9B9DeT4tDpdZHq0v/sJvwtJapw1nXrcZrM0u/yEcNFwS6Gyt6Yq
 KBNbM2TeSQxLRHsJ/85kKhA1Dr0ESTN404b9+0f3BkjBYaOrfGLr1xH/2BRGAERPp4PwSoWTVb7
 9P63wqSUXdc58ouLAcrcvDNnVUIw03hsvN3KqdKgzz5I2eMhBAA4Qo1iILQ6ZyIZ/Ln7A7DyYh7
 DugdSH0h6sYddOJcjLqK4GQpWN9jRG/2DOv+rDLwIJhXiI97XRQAHSXJMuHfurCsBDimzDMlmBQ
 rqCV4Y+kI5xsWGvvhML3upRAqI8dVhNqZdc2wwaxz5MMOidVGR7Y5Kj/sEqtEXfxG/tgBYl/XrO
 DrjxcxDRCTSWJ85sAowdcHZ6xc4LREfF/1QBjQoc2Mfm0ibGFkZqaqEBE25+V4jssmgg6AI1oqN
 xSuBThZyDxqHQWYHrUw==
X-Proofpoint-ORIG-GUID: MByago_kQO15NlUBjgzbRH3M6UDOA0v8
X-Proofpoint-GUID: MByago_kQO15NlUBjgzbRH3M6UDOA0v8
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a26f4c8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=UKLiqp-8KJTb_O4c6h4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080161
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

On 6/4/2026 11:15 PM, Philippe Mathieu-Daudé wrote:
> On 4/6/26 23:51, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   docs/devel/testing/main.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Squash with following?
>

It's different from CI, since this one is only doc. So I would prefer to
keep that apart from yaml part.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> 


