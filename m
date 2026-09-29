Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA66ECA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfLt-0004a6-2n; Tue, 29 Sep 2026 17:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfLm-0004NB-5q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:26:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfLj-00041O-TT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:26:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THdP4c858071
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wELkSGHBeh2iQh0PcjxejN7TO2TQo8A7zYvO7A4dSso=; b=gmudnl0s+ul3kbFg
 V4ZGZrehVQKprpGqKmF0KoQliVj6WifexeXQsAl7GnuHavbUs4NTCJSSAU1M8NMW
 KMuogO7dwYKEd6SdscvsYaiW8buU8v09aQb6CjQXEIsX+jERwiA+gwciMRLH6lnn
 ibjrRG0EO7DRc51zGg83ofmP/HEOzLhC/13gRO4nB9Sg9FB6MCn0tIh3tGEbO2wT
 i3r53tXmUgjIGSIwufqUeXY3xPDgAafNMY3SQqc/PMhQYi32CZ85Vuwd77Vc8JiW
 AM1f/d5SMa6aioqAJc+VeNobu78XYWSHgoM2dQB7SVS8u83iXWM8Ok4BB5CGuLXY
 XgGKww==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0kqeq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:26:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3282d5302ffso2212388eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717214; x=1791322014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wELkSGHBeh2iQh0PcjxejN7TO2TQo8A7zYvO7A4dSso=;
 b=VbkQW3yiD/mw34J9AqmJ9fObSkHrB4Zpu7O9D643NY2J6PUKgIE2gLEEugA8pEW0LN
 Rju0Gjxe79y6LLpne34E1biIjagRBzQT0txs0YtJvLTmwXOnSaGGs2OkW6lHJRSxIyvT
 l00OchXD6LI4qDLd02tCTdoRuuiwVZPSXpoe50ooRl7QdrGzhPB7GkoUNaSEdKedc4P9
 8SuqoWPWZ1gMrD+9jIcsCC7vNubchvjs84BjZgvh0TDrPXfV0SVhWZIsjmlI5fNMG+km
 1iUMaBuGdL8j13ryrlusJbcvT2gLDEKfC8xSwDykWVEGNsAns5vCbVzorkKUKNCdWAc8
 b0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717214; x=1791322014;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wELkSGHBeh2iQh0PcjxejN7TO2TQo8A7zYvO7A4dSso=;
 b=2k6XZ9ug7YTIYKHSYK/xXlX2AiYpPojsGlaPXaYdv/gJxTDqz35MrsiReF2HMip1BI
 6RftCDICCwoa+BDFCY5FYyDUf4SMbDn83B4d6ijMFTVDwWujbNWft8GLOK+PfKLxmeZk
 OSDKCfsz05ysQwc2OdRQdwJT/dMaXVQzZKBE8NwU7fdyNobcPGxpjCmWkdWitcgIOvYf
 ldNSZaM0/f8+wrHtRXfvr2UGqIyOEHkib1TAmRY8pKiUdQBKDlUss5Fe7Ui9Lveja195
 v5f5le5z+p1WGb2GUD2BSh0+EhfbXZh6flqXv+WqkHl1lY4NbbmSZ9rPK3DDUQnXBCE8
 N1sg==
X-Gm-Message-State: AFq9FYJgg5DlLKHjAFWhIsYZ5guXjUNyV7GX9p+swR6ZY9l8uHgHhjzm
 kB/Z6TyRFX/aQbShV0DDZnB+S/Z2zCw80nGK5SEO5Q9/NR+LQEzuYJuptgaMeS0g1xmR+BHms3X
 MQ2HUz0evV9H6TD02A9LSJJBT8Wd78+xIZ4jcFpLM0bJk8PEXZrtz5Y44rs3nQmPOaQ==
X-Gm-Gg: AYBFou1XflcZuw8Am5h8Z4UFEH8eHzK4uBWNZgoCSrVpQWT7HZL2A5UXrNLylRQ0O4l
 sbBsrKYNPFsIonx2/pMgg6PJB1a3v5XETufpDFBf17Lgvt1Ro+NVeg94iznpTKqVUEnF6ejKlQv
 hpSkG7JfuoGbAgtlIhvnBh2qaGUMH7gfRoyVj+YYP4l/QZsDFIMdqY2HBoDlghYLRsdCSKoJTMU
 NcpsTPZojzXmo7cNb+42CFcrvk+vybpLYk0BPXY/ZdIdRhFw141H9TpWudNVSbyAIQQnE6xyUzf
 SMigeOzuV1cl0fCJowwFCk6unAi0YSx3p148zfyWVvmW52l+0F8NnWRcEzhvoZIlOKcLzUrB07K
 vXpsxChQGYZLRCABRk6Y5jJWSDAU2+FxLexkuSXbRhpqnmzKrCPKjnMSkjoJmQ/0uwCOrEw==
X-Received: by 2002:a05:7022:7f04:b0:14c:d53:3933 with SMTP id
 a92af1059eb24-14c9e6771a4mr634631c88.19.1790717213700; 
 Tue, 29 Sep 2026 14:26:53 -0700 (PDT)
X-Received: by 2002:a05:7022:7f04:b0:14c:d53:3933 with SMTP id
 a92af1059eb24-14c9e6771a4mr634597c88.19.1790717213114; 
 Tue, 29 Sep 2026 14:26:53 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14c634f07e9sm1489243c88.6.2026.09.29.14.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 14:26:51 -0700 (PDT)
Message-ID: <4ea561b4-b760-47f0-85d0-27b2f493bad4@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] tcg/tests: integrate rest of mips tests
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX+xZs5du+pTi7
 4zAuwBoP2ZQz9c6FbSf13VWjUcwHYvp6h6oIMw6bTADHc/oiQM2OK6YjiXn/f8bUwO8FgfI42pO
 jm1EXfBwWwDVU8LsqxZGZsH8Ny/LVaE=
X-Proofpoint-ORIG-GUID: n04gOGAtoyWYE12CsEUDuHDzvu3b6HDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX6GBuRjP+4GlE
 5KlDki1mQUToRFV6US6GECvxIQr2OkNg8WRd+q3pqDiDJP59UqkvZBpfzkOcjSrs6iHQ65zQ+zU
 6GpoFOA4dYzLu33rQK0HH8ZM0PuBRVtfU30hMWJSGg1KCQQK0bOmfkGER3lceDwpiQRO9XH07cJ
 zszO/fI/ZZK/cTnvYF5DUdYrBOw55KFdkeZsrgdd0Xh/HCfwHm/ap7XNw4Ip/K5jpnLu1sVgg3p
 du1bRams3Fzx1qRdQb749XOaliQ9Tn5W3sECyMw7Xb+AmWyCa59dOs9UKeYGmCu9lLuXoWEcVlJ
 iw1GuaM3Oe1IscB/pniaO8hOJm5qA6jrMSc5ZCU7a7Wt08eoT22E+nCGUCDPR/9++MHXEMwkCgQ
 x96VCyw53UjT0LUhBhQDjJVFXYFqY2nXrzIzLYDlKOM6dRyhuIn0JLpijJjHdpQIVJOgnbHmsFn
 PrwfOXtRQGctlTAzXbg==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abc2d1e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UVR_YQ6KdhVbkBLYn-wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: n04gOGAtoyWYE12CsEUDuHDzvu3b6HDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

On 9/29/2026 12:39 AM, Pierrick Bouvier wrote:
> This series integrates tests from tests/tcg/mips/user/, and also adds
> multiarch tests for mipsel target.
> 
> v2
> --
> - add all tests from tests/tcg/mips/user/isa
> - move octeon test to mips64 folder
> - add mips64r6 tests (and fix them)
> - add README for r5900 tests that we can't run
> 
> v1
> --
> - add tests from tests/tcg/mips/user/ase/dsp
>

sent v3, adding the last remaining tests (msa tests):
https://lore.kernel.org/qemu-devel/20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

