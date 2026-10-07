Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EDCA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESiv-00055x-OD; Wed, 07 Oct 2026 10:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEShy-0004rM-82
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:33:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEShu-00019R-WF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:33:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVKR94178576
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DNmLk7iPxMJQ3J1zLrOFMKJgTurnjn4dqgVEiHaqasI=; b=o3sgeGjW66EB6s3i
 Zhlf+/b8YofpXvKHecU51Q+On2aVKJDGSLjcDQmfm4CBKbHvHbtYH2QVCmIU7lfM
 8g0CQAaDn8fHoevWOuSl+OuMjXU2kZQrRrJmH6h0ZFckEcL5OSfegZSjlePWP0AQ
 7hwqk787OQyh+QS1+UvP+xeYvRUV5BqJuczaRK+9Iku/saGScbN6965HvoRI95v/
 OqXPWW+jPySLO/1/iW1Qncfo3HSG7dZ23yXWZo9mtjInkvBw6vAoJ65RMmtW7uYo
 kAlocdQ+mXjBHOhbsKLSdTDVl7a5cZYCd+8Md6he8zPB4aLe7XruIoBRUt0OzId7
 7IPOmQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c60akue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:33:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso4984588eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383601; x=1791988401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DNmLk7iPxMJQ3J1zLrOFMKJgTurnjn4dqgVEiHaqasI=;
 b=gI7jPgzyeuEGSmgi7GmMHRSbFZO+JVDmlgGWvZitCslDm1ha4r7UKO1brKn0PLHjnn
 4s3BFwdm5B5ABVu4YE81/uiwLZ/QjKPlYZk01SexpsSwTVT62dj1wkDI8AXco6L5ddsW
 KTtml9lRNPO1ClsOEV1A/3vYIomsstMvSnZkolENdTtSUd+CNc3pN579faKpnqSQPxRb
 94PNNHardtUPBe5VieYt9l2gkM9GqYumuLM2NTtaGoq0htraR5UD/KupbYyUDWm5qUyk
 T2qrvvV+VUV5AxXThfX64+ydI3m3oFIA6jBoqNRo/5k7p34dSCIelQp4hkYY+eKMkgUC
 3NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383601; x=1791988401;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DNmLk7iPxMJQ3J1zLrOFMKJgTurnjn4dqgVEiHaqasI=;
 b=V0Fcc9T29Hv/Fjsij7KWnHps7JCVRqTAEuHc58U9www+irUbTZ2gB7GbDolz5z6KEE
 NusTWHosucg9DlDKRj4paStFFbl+74/3rVGopP8KW8JdGvCaz1uOF53VI4bIer1OGRwd
 IGGSO7WyPNhLp3vDqCs6Ddu5FMUScqIvPM2Uo5fSK9Q2uy5MoaskZ3RnJImP4Ioft3dm
 CSMsOlGNFZ4yzhNNRUc7TYkvYsDNsHA/hURGAo1nS/xrIf6gB5K9wM1373AWTdEVpEoF
 bsFVbZBu+8VW9kPgKZl80K18EP0xokl/w7nGy3ksSufRgus/pZE27cqjx1v5Xpb3bgC+
 TSPA==
X-Forwarded-Encrypted: i=1;
 AKwUvByszlBqRN/ifBsYyueRvBDIRAWt36t4fsyKqLScHZA5hGXvMLPRxsatpVUiLDFAQU7EFhQUqmIo1t54@nongnu.org
X-Gm-Message-State: AFq9FYJ8Sij0bquatF2nIVWzadQL2vCADhGl5Z1xMss8FdfG5QOlcep4
 SyvRxHHYNtZU+OWa/BvG21dlrA1bgnb5ggGiafVI3HXiAkdJymj+9KDyrIFkhqE8bBWGZApcUdy
 h2STaXiP8KyJhOKdPs+B9nsy3wVeaI8EkglK9/TLzgC4Tt4SqqB7PWY/XMQ==
X-Gm-Gg: AYBFou2SvuZhUl/ZonST88kStLxbfPaIeve+DDH0UeP4Fx0+OoST/oJAESwRi1Rawpc
 Nh7Dq8uJRAxUAjU2HLl++zdonVuTVWIoBOcrwKRxBZuze7UqQe0n+xeoRVRT359a+oQ4OxYyfbF
 OjZRJypZKIDO08ay+b+rD4PqhNjiJ4YLUsugVJe9Cbny+YEpsmoIxT118hCdGIB1oE2FHI+uHBM
 8GbTYWOW1Z11ynwziiiW3LPTStzDFkmSWGr51Qk1biIsUDeK3hK5OXOfxPWi0pZFR9kx3qaxEjk
 9sm1zROr8vlxcl1hRJ1e8MtWY0RmRLfsSzI02DBsXQgm/wqhYLP3Y0SC9P3OkyCSUuiTQAYVHky
 FTCPdOHhommxJJtgClaIS0J4UzQsh+sidWyfOSU6f3klAaYUhGpMjlZvxjmbqv64zzO3DyQ==
X-Received: by 2002:a05:7300:8353:b0:351:853:54a4 with SMTP id
 5a478bee46e88-3515dea1eb8mr2552520eec.33.1791383600459; 
 Wed, 07 Oct 2026 07:33:20 -0700 (PDT)
X-Received: by 2002:a05:7300:8353:b0:351:853:54a4 with SMTP id
 5a478bee46e88-3515dea1eb8mr2552490eec.33.1791383599906; 
 Wed, 07 Oct 2026 07:33:19 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af155b5sm7137896eec.12.2026.10.07.07.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:33:19 -0700 (PDT)
Message-ID: <cf69aab1-2145-4aba-9c7e-8b28d0f86d14@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace: add support for Hexagon
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 121M0XXhK_H0sMMULKufOSjdVgEyLfMu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX632RojkBV5Cn
 fH8R+0nbaMJE4ZpqF89ENwlDhd3h62avZnuRtpqVAh5lQI3U3EY5+SMnjI09tfpBsQUc/3xfEvV
 MQ274cKRLGLp9WhimnZljENTHgN8UpI=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac65831 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=68vf8JSPsFfWP5gPmcIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 121M0XXhK_H0sMMULKufOSjdVgEyLfMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX8rMRctJbr41+
 1DR/BDwwFQ3sNjZhg3VV928F52x8MvnD7koXnx9ZgXtbZAVddd6rf3Lrj5ScKEhd58lMr7dZzZ7
 HMNgwiJfBmu8U3HOKGxRQ8JoeEuWllblO9q6yvK9KinJsJKecU+DK1FqnbJsYCe9MlIerTHii77
 m5M0Xdye3ESbaTkaHGefdRbf7dQ8Veo3bTadY2W007+6eXbQxDMAAE8Lo3yZyns2Cdd0fmrkwkd
 3I4gOm+j95oEKVL66Vnxc1D6Q4BEptb1t3j9kYAQ708nD6E8rU82fWurPdcCxAov+1WCeT5xCwz
 uNVy0AmhLaUU3fzBuMPZQeSX/gdg5JpDZo6lvshVKGdyi8DzNGspoeNg8qbCyoE3mEtZGne80IX
 hR1xSe1IzUGdjzdoDN+LSqvrG5aauK3hzDfD9q2p5CelZs7VqMWgSnfqTrvtuGXo+AYjrWiLTBN
 G3Y0vktPfLrZjmiSlug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070057
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

On 9/30/2026 10:55 AM, Brian Cain wrote:
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/about/emulation.rst  |   2 +-
>  contrib/plugins/uftrace.c | 130 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 1 deletion(-)
> 

This was merged into master (f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c).
Thank you for your contribution!

Regards,
Pierrick

