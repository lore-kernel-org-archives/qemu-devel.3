Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E540FC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E9D-000626-Ed; Mon, 14 Sep 2026 17:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E95-0005xv-Dp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:23:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E93-0004GM-5B
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:23:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYpJ02396729
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqjqT0B5yfaRiV+3Uco3XY/HVtcAHR49PAyCYesNBL4=; b=Y5kIj8wlQGwHwT9M
 x2l99msHOkXU/AOaUljRhkvxLzZExvOQ1yUMOfooVdnjJp5yZHL0lXDsl2+NYfny
 sskvTDizq8MUhW51f/LVULspHknzDFrS5IzF8uT+aZTpzE1afkDMgXyTYlg/pImf
 d437JUGWQRA8F5Bqj5ey4FwQ1P2sV+GLs170Xurlv3tt9FSGFW/TsCMEYCMw07dw
 HMexMj+pmbpv9CHi+Sxz5jA6y3CLAXeuLd0ku7q9oz/B6U7V9gSEFdgBosHxaGMs
 3XHEE7Bdqc31oygaQyj90bZfjxva8hbejwiW90dR+Iqil1DhOE5O4ZToN0+kzWNm
 dWqdWw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41rv80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:23:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4e0dd08f4so2603405a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789420999; x=1790025799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GqjqT0B5yfaRiV+3Uco3XY/HVtcAHR49PAyCYesNBL4=;
 b=ZbZbi/gkxAMt6AxqfTDIzftUFTYN1y4mx7Z+mKurRBcUKV7IomoJdrlzVfqHPeLUJb
 xW/CNTWpST7XKLjsoqA30u8fZt6p2j9+dVzmGkZLllZ9JNzMzpMWxl0O6jo1DVsIvL1L
 dneD4tIhOSSEzaDjCwIuYY3fbpMFwoCLiSV5de9HN7kBsTG8z58zL12TD65ngYUydGyx
 SYHX3mn1UPaggySfKMYviZ2ihIznstc7Eije/Kmuvrn+e+4h7ZGCzoq85BlmtOgNRViS
 1Rinxr6KVb321BAQeQCMhQIqQwog7hrK5kgGrMwVK0d9yzxerVE05+s+SWXI7k6EaAD3
 Fycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420999; x=1790025799;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqjqT0B5yfaRiV+3Uco3XY/HVtcAHR49PAyCYesNBL4=;
 b=LAvANGIncvaUwFBTkNFoa4E7aBKFGXjB7cAlm8dbcc4xe3hyzyz1IQqZsxYFpGLa4B
 4xBjmhAviclzU3yRM4HvB6ApM/mb0EJBQBVEuZQ2EtC7SELDxW8BgAXIfpITSgs5AJ4+
 FCl/E6q3+XkMMy5lUcmx2qnV4Dkyf0EkqjVUzjEQ4POcj11lyt0Ipe+DVeOL8dFFnldD
 LGR/5GQbog/AUZ51nCS8OYtFHNi3z+Py/OhH5WvKGvKQdZCSt8BcV61Ra8a7i0tEIxV5
 wJUnqK3aHIqRA1az/vzv7TayfJ8fEa/dzovcGUGsBRcgH5vtPlxbwG+OlRQWFk59fYih
 s4ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByjP2+8brb2TGKCn+jv5GcPWs3Qo/KWlYUOmdDB/OBI6q1Ib13iVIxZts4mzXl/421LRUeazIreFTO3@nongnu.org
X-Gm-Message-State: AFuF++nwelcGYYhjbzbjy8+0mKZd5HUWAdvdH23LQYehWF1P474NjwI1
 JUgHT547w+JfGZ/opECX3vbhHctXrDqbcCs2d6MPsRIfofkeNA/sGhAyCkIMZzweCZ8Wv7bYpCa
 eGYrW+bRlvsO1uOT4EVW5+rWdImt2nfsL+2K87h9Q4nsQMPa/fDccOVTHRw==
X-Gm-Gg: AYBFou2u0b8s+gT5gk0UFyiJ03sWP0AkyLjsTkC2ZEhIPMXTZSa21D/Sq0kHOqn23M3
 2/3j9T9PgdMnrZszzDB6UMdLfwtC65EyzNPZ9b6r9B2hyqnEhHU2jTBS9rK0ZY7Z18MSh8kJzDB
 Z+GVhLArkLuCPSu5Ey2khIzO1pK4SByj37FlLMlVQn063b/iMrLwyfKggXxa6tMX6M2jBOB9JNB
 oV4qZTTB2s/kKbsl+xzK3guxQajHHPPsFkXzu+wOKlQfx8vvCnCnb72RuKNezYTe/CRjfXnzN12
 lVBTCnQ+O9Dr3trjYPj56eUAsR1BUuSIN/eZTig7SIzLYW7Se8Lt5JVRYtK3RsitsBXloI1yxQD
 PtDAGsfBTt8eGZI3Snu6hjCie1OkhfbjWmpGXMmZrHobIAQ0WM8PiLzDLHqV3Aht/ocN4
X-Received: by 2002:a05:6a20:9f86:b0:3d0:6c90:5a33 with SMTP id
 adf61e73a8af0-3db4047a63dmr9385690637.4.1789420998969; 
 Mon, 14 Sep 2026 14:23:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f86:b0:3d0:6c90:5a33 with SMTP id
 adf61e73a8af0-3db4047a63dmr9385642637.4.1789420998574; 
 Mon, 14 Sep 2026 14:23:18 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm28195011eec.25.2026.09.14.14.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:23:18 -0700 (PDT)
Message-ID: <347b18bb-3c86-4179-bb19-31b8a5317919@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] tests/tcg/hexagon: add predicate register transfer
 test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-15-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-15-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX+/IN/K07mbku
 ASTbJ90Wy6VYoYxvPsdJbRV04LJsEAnS/pTH3znWRKKLCaYUX0hmQ2g9JqZoRMjzh+XedZNdosH
 S36Elv53daXEJ6qTZrtEWmYGzL8kROMLcq8vFa5lI6XrwHd0Ex5tWYyDzFKBWbalacd0jRdgQy5
 0VV81JYHSc+xQmrfj2TXba26JZAdgaAjjPqPPGQ2s3w/hITLeGdemGN5jmoCqBTleuT7A+l017a
 asP4YglzrXp4F57o5ssaWEX3QRa7DmAv5jpn3WVoOrEUdWbY/U7eJBSM9/7x+gF6T4nh1nGI8Il
 Y51zT+PxC1EIbfTXn5malCbj0uT1DJ4hIKZ447t6z0irOti3+JqR0XO6sAleDkkH4PdWKd0LYRF
 hjCt6gW5hg8wtMJJTe+5846xHxJmsFAMrF0CvyDRj666iOHWso5Jgv9QDYM4N+wpeWxTj+1kkDM
 OXmFZeAdd+xJ72i4Z6A==
X-Proofpoint-GUID: BFTVjqfX-KjnCliUiuK96Jx-AmW-GVYQ
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa865c7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=aKLeArQv_zRVU2Gg_uoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: BFTVjqfX-KjnCliUiuK96Jx-AmW-GVYQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX9+AYsLd5tJHk
 vJiD5zDB1yXBjqmzHrqs25frMM2ayw5NDM9qMgINha+oYR9Bnn9KMvZ8hKDXBKd/6fyxjwuyeg1
 oM20SQ5B2EVHK9Q38ft8qxNyfl54neY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
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
>  tests/tcg/hexagon/misc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

