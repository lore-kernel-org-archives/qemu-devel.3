Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA62C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MpU-0000M9-EF; Fri, 04 Sep 2026 01:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2MpS-0000Lu-2f
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:51:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2MpQ-0005HN-6T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:51:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684444e61297917
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 05:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 73EwPHtcF+EZxhl9spfVjV40Tw/F9DF5bl1hUJ0IHw8=; b=c5SUijH4uB45SxIz
 2svS8ME5/NMF8RHHq4M4LK4zy8ccsICD64FRiXkNqyZxsNbtYjDfaF1lmGl/udzr
 T+5AaAECdIGjI08lpJKHkIj9PZZhOHpeb6Ust15uLQVfQLQaiItsh+tguoWVmTn2
 rXhAYCb+9unsHMnZXFnuf03UhpMUaTLrz0A8TfT9FtZYckrcwuwT+CZCntalxWrS
 Yg4RMDLHk8iedl7E/I4qfJfXS7n+HGbhKYLUne8JsQiQcTkF1E9frS3xSviKkZbH
 3N8eG6G2H50cWXAynvIuNJ05o0Oqj2HGAnWTC2n0i6WLH7Ks6uvnOrH0W+y+ukoW
 YhZ/8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqrb8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:51:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so858341a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788501065; x=1789105865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=73EwPHtcF+EZxhl9spfVjV40Tw/F9DF5bl1hUJ0IHw8=;
 b=BfH2MtRVkoLsTaAzL/A+uEtnXIE7DZvf5Hd1ESQjgveVhUpiq4ZkfDARaC5bVUExj9
 g1NNpZiVYdC9aCADFkAQbfcLMKl9VNlXLV+z711RVRoIP8MieL6FBrTfpn6xAiZlsMB3
 jpdT+szwuWgAaz8T7BFx2j8JVkJey5+TjIWMr/HyA14U3X12Gj9I18zLAyejbFMypanW
 zfNVW/SyiX7CY/DaJAbeMLrAfiwkQ9/RhwgTLcGm1IrB1eAYbJm1rN11gGNKblOkNrKj
 7wXvPANb3PKbEbYW2HdkMMaz/Y4J8/BkR2kds9bK/v3+wpYvqQ95Evqb7ZPeGKXVbaSY
 Dfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788501065; x=1789105865;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=73EwPHtcF+EZxhl9spfVjV40Tw/F9DF5bl1hUJ0IHw8=;
 b=GCBgdDevcjWFVFoU5PP0lfDqxhGsXQ/9dlryYN23rqHBYuX0PKXKz/Xkx9jjMFJUsu
 DiiZYhNebkFaGiatmYWoLAllsp6iWxnYKEIskIOXb4H+AxvDAT8PvAJPQmjgb9gJXMQN
 H7eU2TXQJ56rrnaqmCV5RKg2AtjTXGjprdZMmsMqwGIH5b9vmWlW7idTh+YE7njGLOkY
 AOwJquvq9m23vpscFVY32W4KtBgkmK/XQnQiiROK6rNpRvujSYY5ScEd0roNdsF49eR1
 w+K5hJEj/9GwPbxFQ/3BpFA54DULAerWmiS4TFG1Ji3mnQKGxRSrw4moGfknz4wYURMx
 kizQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcC92emMxynRkAVYtYbukMCuCsBnJfoOohdQ2kdDJKTSKmPyfItA2Mpf1ekKBLtO3TegdYrb8ek517@nongnu.org
X-Gm-Message-State: AFuF++n/4c3GF0bto5e9qbwQ7zDW0X9W3ElHDfalehMlStjiyXgWl/AU
 X1PyL7EQ9ngGBDPnUkl72FFjyhQmMn2gZj5Zw1uoIpxwW63erD0bep1gkzF/lanLhRQe1xH5v5v
 piiKh7aPmXU6zvE2amx43y98Mke15i2Pq0fOXBZ76FbNLXEaqJeWtTOfHhlrr7OTtIw==
X-Gm-Gg: AYBFou1/cDqsh5Xc7ym/uyn9480zg/EMBR35xU0up4XU/KcSBzS8EDSCSVS0M8Zak76
 jR4zlQs/zjHq4t68tj8AWC5McZbC+9L8whocGetTjaGCV0LhCjCKm5G7QEqMHsqaCE6TDxv2/yC
 q4scUfkAagbP5gDYgvkx51QQuW0/WgCGX+UwTYUkmqyEBTfo+qOUk42+lvx29mdy9pL6fm2pm4T
 y2srJDNkLvpLfr0DVMwNrgIhmmUEZzHJ97QXJe36+slUlGw5X1nHg/YQQantaQOkbFywO5TmhoX
 qBu+aYEw/diiNpWpsq010qV7Fjjpxjck/ckE81jnWIWY/MN1M6V9mUAKafe+5pG7LvM039Kas9b
 +7lOpbLxoDGJSDwmWF/YFDj4Nfoes03THRfF+LXHI6PZtHD1kCJ8H1gg=
X-Received: by 2002:a17:90a:ec88:b0:398:d286:344d with SMTP id
 98e67ed59e1d1-39b2627396cmr6051899a91.22.1788501064724; 
 Thu, 03 Sep 2026 22:51:04 -0700 (PDT)
X-Received: by 2002:a17:90a:ec88:b0:398:d286:344d with SMTP id
 98e67ed59e1d1-39b2627396cmr6051834a91.22.1788501064266; 
 Thu, 03 Sep 2026 22:51:04 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c3a526sm8829849a91.10.2026.09.03.22.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 22:51:03 -0700 (PDT)
Message-ID: <e644d92e-8488-4e0d-b180-ccc35a448cef@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 22:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] tests/tcg/hexagon: check the two HVX predicate
 build paths agree
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
 <20260904012233.3607547-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260904012233.3607547-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1MiBTYWx0ZWRfX0qXoz7717eP4
 Ry0LoYaGgjeWqPmqFbG84z7f8VgbMR7CdSzh5d8TvLwl3GBlHJ8jzGhM6+JJnX/WUhvq3r1k9BB
 aM/xQ0Fdt0zjMSLks9U8RUxQdKb71vs=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9a5c49 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9mi-9uxVX9xl3ZHO2CsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1MiBTYWx0ZWRfX3t5PQQIQRAnZ
 HTBxYUJ8CmTqntw80WcRXvTVH+yhsShYjq4fnpobcz0l7jMXEF4E2+SBfbQQqqMZBBz5YOxyCP6
 zKx3aG2abidbU2Zo/r0ANLfeLT2U7qUzvdSmoX/dOKiqxDfrPwhDcM58oD/3oGb4GTK2RtBc+Jc
 /1ciJAlXGV6BNh8uYApNIJH8+EHVME7e5v9y68RAaRzkSzrNhf90iRu28edYEcFDNupDhhMHTHy
 3EpJr/2UmjzhsRJMnrRlDgl1J/VoriwXIbdcMtD9VP6yIO3N3Qzy7tTIDZjoeZPw/L3HCRJ13IL
 Gd2XfXaDMCdWIWDmmDQq8nxnVSk9drwGim4njphhz4SZ0oiB1OR5B6o/liIsi9I6Y021z3wig4x
 vXlDYbdAuyWTVQ7MWrvM9vrRwci9mHE/3jP3/0rz11kWlDFLzozT0IviZt0nj5gBpe83hdaH+DZ
 v4QdfqRDWOkFdGQIy/g==
X-Proofpoint-ORIG-GUID: MiU2PLmXT-9SIwpcymWebhuJKCDngTGB
X-Proofpoint-GUID: MiU2PLmXT-9SIwpcymWebhuJKCDngTGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040052
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

On 9/3/26 6:22 PM, Brian Cain wrote:
> A Q reg can be built by a vector compare or by vand(Vu, Rt), and
> those reach the predicate register through independent code paths. Check
> that both select the same byte lanes, so a byte-order mistake in either
> one is caught.
> 
> The input alternates every eight lanes: a flatter pattern
> stays unchanged when predicate bytes are permuted and hides the bug.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/tcg/hexagon/hvx_misc.c | 45 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

