Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A7606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R1hBvV4x;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eYJevFm3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNmr-0004jn-8N; Fri, 06 Nov 2026 12:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNmn-0004jL-1r
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:31:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNml-0004fa-A9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:31:32 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F04nl3184983
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eMbABF0xW7pL0eZa/r6G/Tmk5z1DMtloGSAye/pihnE=; b=R1hBvV4x2UxA92Dr
 5GXE29Bp4lsIm2nxrWXckOGO6Tg0pItPYx4K2Ug42KMd307mJkw+hjZLhXC19BYc
 r3lwaebPE3mp4Fra3slmL4m5kat5wM94Km3PPw8XWW+6Jro7T9psTPrTAiCqIUk+
 Z+v4FJrY3SwhWe8afLw4kiWjomIBT2xjt860eD66CQ2RSzMM+LVoVusyxTE3Bdcc
 /6Z7z7qkfCoMPnc4Cqlnc2ia9W9UlxyqoCWxUjzF0LVApN3CKPtYxAZ6giMqrAxV
 LhXGHaIp5E6hKeMtgm5S8rMB31TPMDFyGemzKdiDhviEueQj2Dw42jrgWK2FOyKf
 g2FqrA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pabutn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:31:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so1722786eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793986288; x=1794591088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eMbABF0xW7pL0eZa/r6G/Tmk5z1DMtloGSAye/pihnE=;
 b=eYJevFm32mJgBkIQECumNv2ylT0XjeT+thh3Tp2y0JLK8+QuJD9VGew1AqPsf54z4K
 x6j/a41yM5XnMQUvYxrA+B4SwT0dRJkvO/eH2vVVOCrlw1Tix7rThpiLR04pBa7/e65S
 ph5JDpfUJX9lfQAwDAdbcbbwDyssC2mcMFBpW1SvV3dcUQ3eKfmIcblEBM2OzjoFgvax
 cLtuBGdWES2QQnPHGPfZ4/JCWyTmIHkv3EuofYFSVYuYRsdkar9V829brP3nZ+dMr7Ge
 Wx8U0D17W2Hv3NtTHmyaKaHUVHEY/f4tX+Rs+wGhVXSuqIKz2XY57Ox6d8LKHCMCUBh/
 Kekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986288; x=1794591088;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eMbABF0xW7pL0eZa/r6G/Tmk5z1DMtloGSAye/pihnE=;
 b=2OXgR8KI0YOvyE1gchS35geWmmOsvIlvZSF+pz/Ql4S4CvLXORX9oRaSY9HfEL7oG7
 blKn4dTSHAPl9PZLFlm9JBhkq2CU4OnGfhszFg/iGoyg7Z+3QirV839H0Vmh8U7fXsZJ
 oMBGpowv5K5cEpq8ECozF3/go6WB1H3gn+73BZFKWYfkI4AXYFZAAxRbYIBUo3OeukWS
 yTwhm7nloqe+ooVX5iEb/axuMcljnEimv1Oiy2yuQEMsJSxDFHkwkEjjb82FvRcN2awj
 UEqchtxWhVAhztq+G3UJay3iwl5T1py8jOhX70rpCK8ZeSipUGH34d9idk/XkLHU0Umv
 iE8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSRWCXa4oRWJ1a1vZ2Vpfffay6NFDlqwmdooruVXG8A4toIRT4hNVj+YtDsQ+qzKjhbvkeZ8sZjrL1@nongnu.org
X-Gm-Message-State: APuU4Z+YNOZwEuMG+r0BmTTzpB4fImrZ/XrBuptGsEj1A3kF7Rsfvt8x
 05XlJ2LEajnqf/o94TguLysuEXEW1licJpLV7pgLERH9W4UTqTO6PjZ9uBWgQfcJfCTYl2dy4NW
 +IYdfG1Q4GbgOOk0W5yWvfx8QvHe9Sn61wJyWVeZCqwc88NjKx4NkMPWNZg==
X-Gm-Gg: AYBFou1SkTEHwi0Kpq/+gS9yr19K7jspWcTfxUSjQcKa6tR/q3hv8I4PksaotCpS/2p
 ktSgFmcPgM7rh74lHztDwOTjiZSyySTdiSStQt3yHF3/5hbzBE7oVJjJmLo8Tjxn/2sonirQbct
 EDylLR14JUUPQqB6L5M/CO4zaig0Qfc1BdAvy6alDj5geTAy7JXpQKeStJg6091LiK8EiaXfLUO
 seniI2gnb1Y4Pp3eLEHcp+lkMqlwDoUZuBifXzQBoiD6DPiArgOxAYRFj1dTsIs8WudKcY7BVr+
 uIocpRLOiWjGkag6U71HrD64zA0LqWfQEu3PBnHdjnyGkY+FdTXr6SpQu7Bncaek5d6RxFbDAXb
 +dk2HnnwE0Zv8eJ4EdXc0Y1Tnh4sTUdijIjinbj3eFhkAk00GaJv/QxvbKu3n7d/ybhNsR50xAr
 7GnWAeuc5uk8y7VYGD8EXWqvW3Vzik7zho6tuVG/QaGg==
X-Received: by 2002:a05:7022:6990:b0:191:3c:aae7 with SMTP id
 a92af1059eb24-1b25d350129mr5468414c88.26.1793986288141; 
 Fri, 06 Nov 2026 09:31:28 -0800 (PST)
X-Received: by 2002:a05:7022:6990:b0:191:3c:aae7 with SMTP id
 a92af1059eb24-1b25d350129mr5468383c88.26.1793986287570; 
 Fri, 06 Nov 2026 09:31:27 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e407cd1sm7776582c88.3.2026.11.06.09.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:31:26 -0800 (PST)
Message-ID: <d46c89d6-ef69-4dc5-8955-bef940074291@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:31:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2] docs/devel/testing: iotests check script
 should be run via 'run'
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261106170158.3858169-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106170158.3858169-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: obIS3-Lt3m4iXwMOtc59rkhnHfTjCZZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OSBTYWx0ZWRfX+6AL6BiwGCsQ
 +UGcBgWWCAa8pyItqN7SLaZE5eyzfVFCSwu4izMkaGu+d2fY0S0YHpvL4liL0+VTjGxYQEGBAZ0
 YjL6j1GQgKN1DWlDoHN9niB9SZbrPRZUthEaTATIKR1q+RaLkgkTzy4SlyIZj1FuS6sObapmGQ1
 qDNv6cQ9C9lOCOpmizGKMAmKk7f2BP7vuqeuKXUUZNdfvo1hxuqjmqpyt1S2SrqMqew8M+3nteu
 B9rF4YSRwl8zZmHCqGolCa7fqekASnClzD+szRbfoH8FN0boxx/nyt8kPmfL+KCobTcfUwnffIl
 a1pQFQTS2g2w8vm6p58p0kFesv34xAQrGNjoYECOdvqfhCPTa3jOl+4zicOctGHeeFdx6tA1Yrm
 ba06PXhnDZsrFg+W/JEyL/Uttq2pUvZLg9z6kl60nY2cau+EWZchld0yYldiL1oWdWcVhGbMrNB
 a2j/S7xMuHnDKv+J7GQ==
X-Proofpoint-ORIG-GUID: obIS3-Lt3m4iXwMOtc59rkhnHfTjCZZy
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aee0ef1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BmsjMDX5KXyjp2eRX-sA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OSBTYWx0ZWRfX9nomFsnFsAi6
 Oa9s4x1j4GQ+17NO4NDtyxVo14eY9HyAQWsjgdNZdilQkntShf+WPNM+tfvRY0k8vbHAbla5nM3
 hzFoFnoeuyzlcmyBU1fe8iTdaZWKmUU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060069
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 9:01 AM, Peter Maydell wrote:
> The iotests section of the testing documentation suggests directly
> running the "./check" script.  However if you do this then the
> script complains:
> 
> WARNING: iotests is being run from outside of the configure-time python virtual environment
> [...]
> Please use the meson run script:
>         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
> 
> Update the documentation to match this.  While we are here,
> standardize on "run from the root of the build tree", which is how we
> generally document running things under "run" (e.g.  the functional
> tests), since the iotests don't have a dependency on their current
> working directory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: Use "./run ./tests-qemu-iotests/check", for consistency
> with other uses of the run script
> ---
>  docs/devel/testing/main.rst | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

