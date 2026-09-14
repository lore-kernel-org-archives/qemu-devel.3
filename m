Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46456C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Cah-0004iH-De; Mon, 14 Sep 2026 15:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Caf-0004i2-Qb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:43:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Cae-0006df-FM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:43:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYQ0O1903380
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tXn0zJ1+J+++YlCpFWfjatoxyKuHNdbdIxKArqoqLoE=; b=VSHs/T71Md7AjFcz
 CLrb/MirZ+Lq0eH1Aw5vLVgJw4r2LpzVlBojMCyGG6VBCLLt3TwZZnfPmhCO1b/B
 uoqFT4g6a/Czx1LY6KKhw06QW7B+0iU3zz7L7b1Q/hcjQc5eref2wk/zEIoihfcm
 a9j4PaAAPI38rWkJ9pCK/JlqZe8Z+Ma2Ln5tnyV5nQhIZaioaIlg6Jh1Jp9Q+Xz0
 QpCsqa8yaEZZYuU/X1jFiTtMcnEhAMvFEbYYbUiEhPJ3iNX3HEq2Epb6R1UBnIFy
 UEvSJb/dXqokLOs10ThT+u0iShRWhhysz7iGp1voFxhUA8JEOaahYclv+LHhIRkJ
 bRX61Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5trq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:43:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4c1fc9ceaso3004814a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789415022; x=1790019822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tXn0zJ1+J+++YlCpFWfjatoxyKuHNdbdIxKArqoqLoE=;
 b=eTyZ4fVDkn6GaUaPC2eFP9dEknjanMGSAIOlNu9C2plNYnX7NrjQO8ZtKAaeI4vBhL
 44R0sBFHWrH07hXnIsix0vEZP34kFKHWPBvebeQqsUSs9xaPeNvlCHyncsZyxJK1C5e1
 2bnL3Ij55oTot/FVtoC6kVdBcCGCHKr/qMIX8peaaI3ZgftIshbweHRX6+lAsi+0NygL
 OEq5GcAPaGMG/06d2Y9ZQqeGwHZM/XOuRsq/izJqQCsSiSaHuMgIc3jV/5M/6j2KQvP3
 FZyB0fJ6l9qgPHh92Wq+imJMFAwFiM97aSN2lJYEdGk5DBeRCCqHOw97vAAKK3cemFKJ
 +oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789415022; x=1790019822;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tXn0zJ1+J+++YlCpFWfjatoxyKuHNdbdIxKArqoqLoE=;
 b=n/NIihPGDYidXi2W6S+YAmXZu2jUPtGK1JG2jRBbAIZPnLbtA87jqSKlBONbdX3ojc
 8+sIKKAxBBaduzaJqIPLYmoT4MbEWBn7iB10UC/GnHfHd0JozmyhACf1YhGCYk6Xzapi
 sWBGaQbD09N9OJBMyfG2EPDSFEzbntxiEbMvk0mLvYvM1Jtj4sHzFL1krsWVOGmp3AKC
 LD+EsUcp104jcHE0T6bOL0leQXjRv2qvIyly6GxMwRDxC/ABhSxJVMpYdaxvCLhNPDUE
 qBKKcLaiJZLD8N4fc8SfMCd2APB2t+8ciPhiN0bcfmpPq9dDlEqLDoS8kec6flz32bhp
 O1gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIxVqEi0m4iIFlsAhNv8Y4KSd/cvwimjc7aqeiEjJ86AAQ0P95BBMF1PgHGanvWYlgJhl9xYvKb3AU@nongnu.org
X-Gm-Message-State: AFuF++ngW10wOvFU3qObzjc8bEmylZyNILU10345UlUanPTukfQ3YQUg
 y+W9uRi2EoUbFmmU000P4k4U7/soKxZuNDPmW4hGILWrFA1GBYby03O2Gp4C7Q4RRwmwAe2o84B
 E81y/EqbqUZMt71BFSr2Fh+8UcjMGJ+/eexdsmwD/hN9pi/RNy39S+pLw+w==
X-Gm-Gg: AYBFou1uLG8BhUPR+VnKK36PPbMIq3Hn6HeUALygl8/UifP4gXuV8AUDbmKggMhqNN/
 QIci5fqFeZPe3ttxpyUimcofMDVuwUDiwEEXPowKBtRbX4TGb+KPJQLiD+lHIyukoISs9mfq66N
 ZXAvvpWzzWzHBdzmLNFJxyKkiQqVc4wiagk+V9n3kcanydm+STgfBjZRx0U0bCmfI1oGVrA01Sw
 xqEzFWIBPbTPX2WqDkfSP5yIeH06q0JneAtv3VClMYdOeMgV+PPHtJp27fSOd+b4FXmR9J35/O6
 MDo0YWkPxR4Xa6HDzUcCsJg8qobRyi089QyQoRgw+iQ6mh+WdBe61t0ZCd49vS4X1vLGcxlzYWZ
 WR82Zx6HjjqpZnSKvKyZwexxEC4c20nz/Qsa9Adbhc05LriWsI/vli8oBpsh2N6AToF47
X-Received: by 2002:a05:6a20:72a6:b0:3bf:b84c:2984 with SMTP id
 adf61e73a8af0-3db4046c3a2mr7919604637.11.1789415022461; 
 Mon, 14 Sep 2026 12:43:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a6:b0:3bf:b84c:2984 with SMTP id
 adf61e73a8af0-3db4046c3a2mr7919555637.11.1789415021950; 
 Mon, 14 Sep 2026 12:43:41 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b345a4sm25790224c88.5.2026.09.14.12.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:43:41 -0700 (PDT)
Message-ID: <4a63572b-1f96-4491-834f-22b2451422d1@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:43:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] tests/tcg/hexagon: add FP classification,
 conversion, and fixup tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX7xRjkgMKLqWf
 u2azeq4Y99t1qv2UvvoglFW/0wYMrS/i0fkvSkZY65OaCMCsgBJMswR9lBnwzAxvW4Woje4T8b1
 rI7ZO7B8pPEA3Dp+yM08tJHx40bJSF0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX9p4w0DrtI6ra
 fkvD9IH6iyRgGUl+W3emfldLDZxz+gLPRQxVOys493lNsbH+xgEerkYOWnvHqxq93u9KASmMbMK
 RFw/jQI4PS3apIt3zUKLtUDAlOvxp4use+XIxit6+aj3Jkm4WuE1IoJfZz1d3gR/Acli0/XYwjj
 Wr+wGODS5RTTY17wOL9JmHSTKUuckOWL/h+0EjnPDTwzW40b6Kx/IGgE6a/kMckJj/q0A8IKHq+
 PF7JlNPTJXKtOsqTqQqlagI74UOm9MJJ+ZnVhdSOlkoFbEmewexR8MDkyRDruazuY6i/M62A5KO
 1EwopWPH0RVgV359ljKIGJNfIjLx/9wXI/oZb1vDOku0OokrUyjHIGV/TUD6Sx3g2uEIm42jQrJ
 BR6V8tNqIrkYDI6VP5FqMYnsf7QhPGbs6l18+k4a/LOqupD2SlNqfFLH/mSoWCiz31vLaLcU3/+
 BfuwHAc9DyWUP1zVAFw==
X-Proofpoint-GUID: E7v9Ky-ibVBORazuoB5bzt_wyH_gZF7W
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa84e6f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FOmVdtavdZwRbD3YePgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: E7v9Ky-ibVBORazuoB5bzt_wyH_gZF7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140280
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Add sfclass/dfclass FP classification tests, unsigned-to-double
> conversions, and dfmpyfix denormal fixup tests.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/fpstuff.c | 175 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

