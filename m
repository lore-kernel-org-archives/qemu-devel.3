Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE8CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLUp-0001uM-KW; Tue, 19 May 2026 10:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUa-0001h7-Uc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUZ-0004hd-KH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JA38JW1393051
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OAk4CukzMY+EOjIBhKWnIkIulvC+X2KR/Iv4AlJeEGc=; b=pnZIPSdVr/oheU9Y
 WcTIMk1NY1H9ZqPALQPO8kRn4/OcHbLVe2u+fqnVzpEGSpGgxevIsZI0Wxd09HF0
 2YKYSIh3/DftiD8TNdkK1nY/CG+iWKUed7phcDkdZB8KI+hHGycgsxaOsxdeptdH
 LrUxB/D3VMhaqaqnAqGlRcTu3U+IVSUpuc5NiYzKR3pS1QPYOl1pvHokawgY+Ej2
 /JPrlGwiyPqF2rLglDzMQd15iQpdDYDr4asJabO83lFCy0W8WLtvoNyd+jlshQg2
 ubsvjS5AYu01oXOPlpYVmDhv7fBEh4XPC7Rocb6DEVayzP/gmt3zSKmn+RD7RGWM
 ffAOxg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ns4929u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2efc342ef15so4891339eec.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201137; x=1779805937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OAk4CukzMY+EOjIBhKWnIkIulvC+X2KR/Iv4AlJeEGc=;
 b=RPY1/fuHzgde6rfwNf1qtaoSjTLFnbmvAWtNFWki4yecx+31pyb7y9jQ7vLTe4JAVb
 mCZdXjPw985sJGIz/pxGLwNrJBNBpPBT5DO9O5QUJE+LFMKw6COowqwdvKVLhcf7KVU6
 rxoPMhO8nDKy9kMtoHCdFQVsVp1PpV5zSeEoL/+LiHSXUAyZ1rky0lsGdr64QX4Gw1fS
 UgV7JG3ADvEYahwpNu5DyGrgdA4VHIfNe6CMbrn6apBbYwe3XCsY6Ivj57ttqVuhS76H
 1Uy3cP+gYBzvecnQNcV1DsbdCNnBe8TxMiZkg3saBV6nYfgyH1iFOcf2geVj31L4S3Rk
 9/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201137; x=1779805937;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OAk4CukzMY+EOjIBhKWnIkIulvC+X2KR/Iv4AlJeEGc=;
 b=oyGa1sUn7PI2tNUecNVzs6IAR4E7NVE/ISsMCjDgZmyMOCmhsXLSrxGGFeHUjxE07P
 Xydrs8lYw0Wrl7gfIKulpyVk1Qb75o6KrEzyljuUYffYQU1OqiLBJldZOdF7HVa2B+Os
 swiWI9DGvYk3xTfx6YAfQUJZlgkTWLuWQpXbU/B1083EvIcFwTTa3uhHH45wr2EOsP6Q
 Y2WzReTSttiQgZ5Q12MtT+1hBAK+JhbWqSvBXAVaDWypLstWZknIGluYhozkF35gU4xq
 E7k05dG7L8BIsufMNEcITYVYzhA8IXxW3J0iBPS2oekf2CELq0VHWYIdWwN37+iiBh1P
 YTyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ89zk90FqqOCs4FIyoIWLSxZ3fBo6CsWbs/BlkBnSKW7tbPVj6TNnYex42pGdOVp1zpMxVvkrE2x96e@nongnu.org
X-Gm-Message-State: AOJu0Yy/KUnkPrVRmpsfJOtR1KxFHq1YpKndvdcHUPXbQpY3vF/eAtsE
 VN5QLc5T+9f0F0NCDU7FwKLEqj9ay/ocb0kH91pVfc64nd/Y1G9gUbxjQPRwqXMwzmEx+aFmebo
 /Fbm7nRTPMclXZ4n1zdD+5vVP7iaxlWc+7LankiE/AKY8AMgsRfgNHqsVOg==
X-Gm-Gg: Acq92OH8Gi9K5CPeK5IvBufWvihaKOe46SJ8ULzKN8vIThfgp3Rkyp4SnY75GDd+pGo
 tysm1VrwtFThPPxS4hqXQEDhrTAyHIggCD2IFPr367IPlqeA2bd2djZvP23Ef30oWBI116E2a+5
 b4a9yN06dnpi668j634Nq64lWnFQ7bTFq5qE9mtekEKmekJtl/ek83yUZnaMvpLZYJqZdiFqvAA
 HECtDJo/pmJpNhzNgYGijrDjurgdhxKLPg1QZxpYS+1hqiO4fVLah73zetgKtqnP08hgP1CXAkF
 9C3QncKVrOJsLPdTKY+0URfBKGRngejnqPGMQVrwkfzv1CCWcMMDIZzodWPd/zPIKOW/H0EcNC2
 ZapL3Up6BeoBDRdkx431q7S1+nfvTYJhWVWku4FQBpi1BJNWAklMkX84Dmrje/Rn4IQ==
X-Received: by 2002:a05:7300:a984:b0:2f4:3a9c:819c with SMTP id
 5a478bee46e88-303986aac3bmr7241043eec.25.1779201137458; 
 Tue, 19 May 2026 07:32:17 -0700 (PDT)
X-Received: by 2002:a05:7300:a984:b0:2f4:3a9c:819c with SMTP id
 5a478bee46e88-303986aac3bmr7241020eec.25.1779201136929; 
 Tue, 19 May 2026 07:32:16 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc464sm17370488eec.14.2026.05.19.07.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:32:16 -0700 (PDT)
Message-ID: <71915ea2-8794-4135-92b0-819e53d1e57f@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:32:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] MAINTAINERS: Cover debian-tricore-cross.docker with
 TriCore section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfXyLtNjwIDkUCl
 3MahRfb2cF8cTElxzacwzqSAJ8vNn+mc9LfsWDxMtzD3Hor/NAnII9qbi43VqhUcQkscze7/fzz
 N/842+BeSN5eQEdWVcIXvFCQKMy18p4yWws5BK1wcHVJiJjnxk6F/rHExX3BmaQfTbhvKe1+0VB
 4LV7LL5BduiC8wWtleeGpF7PaHVPDm2Nnia4aAQbRFDpTGB+xDcYMUTUIZ2W5Amg0NkodGNjyys
 26QTPJaQdKdgyMuQXYSiViNA9gCXgsTMv7tQG9rcKtk6jBV9A89mS7PgWpaagTD39PHMMOUXovE
 tIpUm7ZVTqQH6C7/O6Km9ECQbIU7UkrFk/hnlOAkevTpdKTVpdedQKq+Sid4tnWBnPSOUk/YWNe
 4x1CZq3LuH7bSPnjyH5xcS1OQTW1rux1+diD0/T25v1fZCzXiBpnfkPXPKznz1ABJiPxj5SsFch
 CYuhIaFtnC7PQkTyHkg==
X-Authority-Analysis: v=2.4 cv=F6dnsKhN c=1 sm=1 tr=0 ts=6a0c7472 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=AnGCCdWX-xtCvwzGIjIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OtGS-68oIGAA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dVPeCMzsBfj42KtmFoKWGLqtF-N_YIJ_
X-Proofpoint-ORIG-GUID: dVPeCMzsBfj42KtmFoKWGLqtF-N_YIJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190143
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

On 5/18/2026 5:22 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

