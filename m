Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63755F5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEt5e-0005Hn-VL; Mon, 20 Apr 2026 14:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEt5X-0005Dr-73
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:11:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEt5T-0006D0-UT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:11:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KF7cUU084729
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3d2wJ5GHNbAqidbl5cF4o3q9gcaM6BIs9D5IJz4Muuo=; b=dpqfF81OYLRe9M5c
 QTCzvL0nqwIropDKwiXRSl7Khs+abEojFbNabyJ3AyhFJywfuCG/i9yQLN77fPfG
 jyROLfBD9z8dmGeBAECu6b6rcZfmcOMejQ4iY1gcZHvreujs+2dnLgwVa9hBtK3S
 Zoo3hVOZ0giGXls5/qy6Vmfbhc8eOLF+icXi+SOLNtHI0zD3aKGMtxd3Y4ZZ4oPj
 TJnLmL6U9w+hC2drmqBoGrshuPyU/vcR6d+E99ZqQ2P+rBqNQczMW2doBV+/0SBb
 Ypas/44DZl0oKHuhKNasivnysxPH1bTW/dKg6w2BhtDlV2n8ZCWWL7fVABFWL/d6
 hK0iKw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81j0pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:11:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d93379001eso3744533eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776708669; x=1777313469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3d2wJ5GHNbAqidbl5cF4o3q9gcaM6BIs9D5IJz4Muuo=;
 b=UtMOdPwbdeYZZWM/p5vqFWSLPj4bDgL9FqKVMk8J1Hqdkypp7fSV1ZJaGGmvBI2g6a
 80pBSgtyzis8hvsGQgAgfWFGxpR904/L/tvr+nkBL54Rr9ZJ0QDeEsOr7T3tv4TBNLqd
 8s7MZNhUgY5AAEfLcBlAEQrI0FEGfNGgvJaigKr16gR8qc25uJUegoTWPci++MnERenP
 xGKf8hPkuidMEA1WntcO+i9EshTQQ2H1Sn3cX2YHh0v+BwE2iCZXs49EnGpKaCXae6Ji
 0W/dmTObO+Oq+GOB/ClSfKK//44o1hEAqxg0fL8n7R121wxcyp/NUsyyd9q9koJa5mel
 +3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708669; x=1777313469;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3d2wJ5GHNbAqidbl5cF4o3q9gcaM6BIs9D5IJz4Muuo=;
 b=jpbNV0Z8iyVRubFustpWbzy+usD77ge5y+0vcp2FOx8W/NueadbJKVu9L/MF4+7/XB
 YLVrW361gy8xEqY6oNtsuGyjIY2eQm62i2xAGzNZiWGjHUN9Pu+GS1FGbu8QCNlG678o
 Xv60dqov3Xu4cYYGNBQntJwiePgnz/M0aY4NWYr208qKCN9xTNe/5lwGzvW2kvudhj4k
 9IUv9+amGBXHmdnLpChf2p/m+H2EynYLnw7DJGkVEU4r5jlxe4CRgyTIW86jbBRMZDi3
 hh5DxG9hup6g/4bRa8NVW2kHxDl7keJD67SWqQtKhY8a4ViG3K6Wd9nbCphdf6y1MeIK
 82HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RIfWIR58/CzGNv24mpFDSU5YAROpp9JoecMG0l/5pyEKf4GbWmKbA3bkMwfWBQG252f0Pp7flmQD3@nongnu.org
X-Gm-Message-State: AOJu0YxxWPJi4pFjnan8wKOfO1lkJ+HhTmVxFABhvq0jXno0fS8kPzTQ
 PXu9vxunSYwDwguczGH4YWbFox2jw2BVnx7H9Hx8F1tmQRujzNLbcu5pCjtnk+rdOmy70ZdmVcB
 3KHckq3h6r95XHtp3uT8lbcdMkHgXS9GlTF+cddZAmFronetLqii9scq8XZPaJD6R9g==
X-Gm-Gg: AeBDietIY3GFNQt1J+Daf0nQx+h1LWPRexADfVegW+IxTjIM6GjTJusc/9OD+phuYRC
 2wW1oiXktGvS8Me+PyyEQDNEjHrjeM8r+oKHsJm9KtL4hKJkYPADsHkehLQY6BAow0ACDTORPvh
 e6QaCjRA0KQ3il7jAQVDMVKHDdo6pQm9a2Rmt0znvGmxOpLXhGXlv1tc5TBUS7wHQNlaHvZku19
 /vZUT+QELhy0jP9xzLFKaE4r8BTawM7b7e5py38zvjeWyRgoglVWWlJ4aAjN+LH21S801vhFVsD
 NH6JF+mwjthWqT17w5ryLZk6n+zd6C4slEUJieEkT/wAVY75TA2hVXX79JnIFaTSG3fNTkavnZ+
 J7XxymA7+oXlI/dYpIokjyArKIVDCItUSOsswsWMGNqEzh3tBr3qr5/bJ46Tq0WP1tqM+Fh/Dzf
 yCjF7mCkbQz7JO9LWftqC4nZNj
X-Received: by 2002:a05:7301:f0e:b0:2e6:ff79:e34c with SMTP id
 5a478bee46e88-2e6ff7a0431mr3602288eec.8.1776708668843; 
 Mon, 20 Apr 2026 11:11:08 -0700 (PDT)
X-Received: by 2002:a05:7301:f0e:b0:2e6:ff79:e34c with SMTP id
 5a478bee46e88-2e6ff7a0431mr3602261eec.8.1776708668278; 
 Mon, 20 Apr 2026 11:11:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a8018sm19147009eec.8.2026.04.20.11.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 11:11:07 -0700 (PDT)
Message-ID: <22ab462a-cabb-46e5-9243-5accaa599771@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/28] target/hexagon: Implement start/stop helpers,
 soft reset
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
 <20260408041953.1899532-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408041953.1899532-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NiBTYWx0ZWRfXx3U6U7jIJXAI
 22bFklfo0Rwg1F1wb/W5tCTK6E95EWdpf4OcLJ1NXHSraIZFErKVKW4LwThi1OgSyryJfy+bpBW
 /21mQWhQxBo2e0nygWRrQCCFiyZydoFVm2z48GGw5cjYCgAeurT/Y/E6M4itjR+itWpq8xgvnJz
 CndTC2ZOXopMp6MTxjSg/oymki1SCDFu+oYAkhJW/sZIH0y2Wou/8UEkvvyXY3YdffFub710SPt
 D1hkDH0hBvGiQ9Z9JC8NSJCPcs3He+lBVDT2uPHXkE5cOvOFOQwAg1AKU5Ci3ELRrtTD9VC6IcJ
 jI5OwTeww7J88ImtcF7IjkCN1Hny5+2ilaUirxndT3pZrlfhI2VTP/enVnR38HMou1eGiV8TSCh
 RJGKmhWfJ6eACxRwvU+g/MWb/qkT6G4W1PXD9BfZYtVVnDNQ2pHLtpjN4xhgPclUNF59c9uc2ge
 tOXd3+zM1svwYvzXuKQ==
X-Proofpoint-GUID: hsRKXa8408nV6lwoR5s5zo6MnyGEExIN
X-Proofpoint-ORIG-GUID: hsRKXa8408nV6lwoR5s5zo6MnyGEExIN
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e66c3e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=nJk9lEwaFBMXiXSc90QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200176
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

On 4/7/2026 9:19 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h       |  9 +++++++++
>   target/hexagon/cpu.c       | 28 ++++++++++++++++++++++++++--
>   target/hexagon/op_helper.c |  4 ++--
>   3 files changed, 37 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

