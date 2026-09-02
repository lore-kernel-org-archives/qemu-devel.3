Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F0EC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1oxL-0004gG-SX; Wed, 02 Sep 2026 13:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1oxH-0004fr-Rz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:41:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1oxG-0002Ak-5Q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:40:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HOm5v2666759
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 17:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VUKhnQS2RGVD4xK2jp7kYDP8tntHXNgp5IBCwtQU5r8=; b=iIEoLlPbY9kT1oQ9
 IdyVX1ydJJdQJOnJxT7bRaopGecXYsdgFyz8BUO8jzEiwBqpt8RgSuWGMhCThY11
 Gup8bJwYapuvzAicbW0eP5CSnUAD2waZujM1jwm1LnHA/yuS64wad0sUicp8J+yw
 FzW7L3XBi5prtQRYQBaDGtGO3Kfi6QXZOp7etvVmfwl3gnsV+t1iU/7V/BFp8urB
 7Zkgd7hWF4FHiT39Xovlgny22RrV9ehUx6zy2sVt9g6BKGxnCxDt8pm155PEdV73
 KrzXe1drfBlN188gSlTsU0s+AVYBLl2qX2lTKSG4NiYxsvMk5u4e3T0i+6TuUZyK
 IXlqiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy25m9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 17:40:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939694871aaso106272785a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788370848; x=1788975648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VUKhnQS2RGVD4xK2jp7kYDP8tntHXNgp5IBCwtQU5r8=;
 b=fgO7AuADOpFti0xmQRzkI+B8kA62T8wpIe9znB2ZKpCBml3REhHOQ3c+xKiy4VqbTi
 Ror0LDDDlGmNAa1AXpsR+3wL24b6nk+qouM912sZBU03kKs20/VRTYv+Je0KIwWcjfPp
 H789iy1Rr8jtLVJPZ5WzsUjeMyGQ0ramjE5LWXp1skfmRU22dVihYLKu3/iDUBf2ryj0
 FED/5jxwtvZW+vSZN92T+/3bR8WG5D8qCDxHyF5ndQqQEep+chh5a4gfU5xS8esmrQzu
 sGO+R+xwRY3ScAo8IJJKckV7jEOqUWNxjJeIPUmO73DmchCmgT/ypnVMFdeyIV05FgL1
 c5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788370848; x=1788975648;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VUKhnQS2RGVD4xK2jp7kYDP8tntHXNgp5IBCwtQU5r8=;
 b=XEK0pG5Qm+Cpp6MHuT+HCBFEct3+BKrVkPaeEfSaaSXGhTmKrz7sbFJbl1kekdpYoD
 Q13ua+FdOskZg5O161attDSZ3HsAcNN8oXUp/jA0IGoY7Tl0ApbW3FJzl2b1f+WU/Lft
 hnIOf22OLIcaDyykui7wORPfUrWEWit1mgOfjYB+IjLmOwsPsx0EtxP/58OIVD/I/vDx
 ICuT85sUDDHEPzo9V94rNoi00YfT3O8euSAnCDzC4hDAwDRcpQl+cFIvJORHTDch18LB
 1je7bsha+Ay3EDAakTsVSYIpGigYAB/ZX/vo5T1xdGV/cMxy+HuQwjNLsBNdZOwX3u9C
 PycQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuErX89GBuMrTgVcap21OF3kQXNHI1Bo8vbT+10mpmSAQB0LBN6PNhSlFYa78axKeTedzLE1x/Ucsr@nongnu.org
X-Gm-Message-State: AFuF++nNp3PnrM7q6brQDfDruQ5Iksvk4gCeJgCPVX2+hJ4VjC3HGzzr
 SipIbGboeiPbMAcKoaM/KUTIi8ZwAp7vRrlgMjTGjZi9qJHEYMl8jc1ls9AAXPYhWOWyhppihOQ
 utuLnjw+gR4spWGDAI26sLBYo8+2mH3D96PuzQzTQHpxZPswylPdVqwqQZxNJ8XUcqw==
X-Gm-Gg: AR+sD10vScOhtn2TVPu5Kmvsqs2IiUccOIJKFOOeay1M9ZMfRNMB/5vasfTOUgFbG3Z
 5t6PrFOmzOOpNBzsHeHkGPlu9GUkErGcAAPFh3Y5z1j3EGcTYcKptLYTE9vOs+f2CpTJkNl+l8h
 p41aVBNZjK5UzWg1regEjA9Wzrd2Hrh3kitP7P13nY7RJ8dvR7hRb1fyKHwNuOJudEkusK8N3XQ
 pHKnHt7qrZqk16P/Dpk0R/pGrXVbGmwJNbCRg1oiELjnw2L7zeEzRuvSLwF2JR8pKYpEEBCE5Du
 DuxUAV8LAJfdmt+1A3bNHszq2B9sLpJWvFd4kJmfbUHYxoyhVYuhJxPp5+C6tEfsRmhwSMNmT97
 XKcTf8k5aoLFbVeOn54lV/Xzywtr+2CBaFA==
X-Received: by 2002:a05:620a:6cc5:b0:939:6de8:43e0 with SMTP id
 af79cd13be357-9396de845c4mr109915485a.45.1788370848486; 
 Wed, 02 Sep 2026 10:40:48 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc5:b0:939:6de8:43e0 with SMTP id
 af79cd13be357-9396de845c4mr109910485a.45.1788370847974; 
 Wed, 02 Sep 2026 10:40:47 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f914bsm8131495e9.3.2026.09.02.10.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 10:40:46 -0700 (PDT)
Message-ID: <50077e0f-a4b4-444d-9143-43cfb5e5c905@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 19:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] qom/object: add is_available callback to TypeInfo
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-2-pierrick.bouvier@oss.qualcomm.com>
 <537f54ad-a5b7-4f61-b1a8-0167e0fe1e92@oss.qualcomm.com>
In-Reply-To: <537f54ad-a5b7-4f61-b1a8-0167e0fe1e92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a985fa7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3pRxJKtOURVcV9jeFnIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: znDhaRQyRTtQRQMFvaChW0ozQs2qHkqt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1NSBTYWx0ZWRfX/xUHj6pFBsJC
 +ytivGar2wPeRcNmw4J3dS/VueBhxGF671hCWH9fHGfj0mjY2Ab6n6FYpfhg8abiRYgieCQuxnA
 I0aQ4SNkjjtAoQJT6xt74QBOSUj/9eA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1NSBTYWx0ZWRfX6ywDVQUKiuDF
 BeZBtBRMDxXhxrMAgKrEhVDWvvzwWaXDehLGOw3QOmgpIY/FOCT/oQ7z0yDKZPSnZhe6xmf6tH/
 wMpsZKRGnGIEsJw7iHdQTLO4FC1hELfBihnHtHmD7gVfVPkohbKFGNfqtPLrpXng/F7lSUjZ3sW
 xE+T/irma3B1pA9ejdIyX78PPMNyX48rJBf0PsLYf49Z9qn/voOhjnUd4f2W7xjWCIBfmu2TWxO
 uUdHoFN31+u+Pt+u9CuLvvel7c9WlAFezzgHhwv5H6U3UxKZW3Cvlp/RSIemppkXWtFce4+CulJ
 xOTZNu50JOG9BQHeKZOOr1L69dKU1RxDjg6P/KaU1Bafd+436NDx7Z0JnWca2o9f2pP8+maxf/X
 p8sskix22xXReEh7vk6aiu6lMJ5k752lYrYCDng5UjbYamiPQ7e/Z7kiZ95HyjnbtuMlk2FSXNf
 UF7c8803il2eqi2cm/Q==
X-Proofpoint-ORIG-GUID: znDhaRQyRTtQRQMFvaChW0ozQs2qHkqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2/9/26 17:53, Philippe Mathieu-DaudÃ© wrote:
> On 1/9/26 22:20, Pierrick Bouvier wrote:
>> When removing target specific sections (#ifdef TARGET_X), we started
>> exposing types for different targets in the same file.
>>
>> Previously, we implemented a filter based on interfaces, but it
>> proved to be too cumbersome, requiring duplication across architectures.
>> To simplify it, we add a new callback, is_available, to TypeInfo, that
>> will replace the existing filtering mechanism.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qom/object.h | 3 +++
>>   qom/object.c         | 4 ++++
>>   rust/qom/src/qom.rs  | 1 +
>>   3 files changed, 8 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

and per 
https://lore.kernel.org/qemu-devel/5bcfffef-d125-4392-9825-81edb3a5acc8@linaro.org/:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

