Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88636CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUux-0004ma-Ow; Mon, 11 May 2026 13:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMUun-0004iA-Sl
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:59:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMUul-00043r-NV
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:59:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BHe5t51857314
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 17:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cJ/4GmqhDoBx1xn18nrQCJ9gYCcCuaJh9Bm2rUybRyA=; b=Nw5WCfmuEAO4+z/O
 wSJqQ0KeDs8Hzwy5pQnP05n1IbdhEawByyqEZ3+qXJbiOP/bh+53vdnQ2M/Sp6+7
 0CwOQYPdAZB7+FWrPTPaurnEWQTvIf0cWHPFvT/ThfwNfzrXFIpZqr+s3BPcf2Br
 yysSSuYpxDT64Gn8IswUVqHsNO12Yvqc7bcXvOfAqH5iuIbqrMJvP8eI0ibPchyg
 70S4EXaFBafHVGqZdBWAfFOBvF0sBe2XVlpdjeT00ac43nBGpTPoUIYjgxzAj1zo
 1wLj814UMktLz0t1zs3B09zmzk3obm/IO3E9N8BAsut8jpqBSdTbfKGI89GGDmzq
 qlzJvw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3kqb82m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 17:59:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so7360369eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778522372; x=1779127172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJ/4GmqhDoBx1xn18nrQCJ9gYCcCuaJh9Bm2rUybRyA=;
 b=hgP631aVHu4fo+UaCgDub/j9zy684jPv2jY3IqF/E3BB8VfRoGkTADFY+9KMr+hlvj
 IIjuA8JcqPWtMRmEWj3SldHDUMqr1Khih1t7WYrqEa/K3sqTRzZOVntwKYIuxJkZRKOH
 a0vY/cBnMFT8PQEefmpnmU5a/l1lj+OlcQd5qc/Gf39PZpEymwL91X0udVKZIpGSomEk
 Kuaif3/nmTq20pkwnUTl4gbolMUn+FHq302/AymSHLgrfxtAbAS2j61EklMMZvaXChhW
 FVXv0D7iwtIp1LMBv4++bHMZhD3zI/XGo4VxLNCn6UImnGfhlRZ8K41wNjCa2U9rIvbL
 Qb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522372; x=1779127172;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ/4GmqhDoBx1xn18nrQCJ9gYCcCuaJh9Bm2rUybRyA=;
 b=ImlonESy40aJQg2C0KNkTN2MGO/ZgdZf6kyz5CpoIFmGvBvWdngIEqFIE2bBp5wOzw
 c7K8ub19l6W+unbbE1F3Mu1V0UT0QCWghVlNq9boZJF+cWJp7AGDmcVThuRKip0WkfO3
 11lYn0cNbgWnuDITX6xsRCL0cGDLr1aAW4gYA5w7iUeIN6mwHN9vh8TFxTZm5BWWQ0KH
 Zz3r3FOggYy28OFq/cXXy7TWTy5qwitUArPAPsaYxdnA6puP32u7rFZVQgZcgQce8h63
 0bd2Gl9cwT03yfu1ev/YOcF882gYTyTXMoj00db9GskkLsA8T7ah4O2teL5e7Z1IGh8V
 CPXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U85NGnHVS4q/6ER1aHxJ1rwb5ZtT2QMnHUiQ1HSGMY6uaNcPB2wV/Hsq+xSxI4ML1Xa2+V6u07pKU@nongnu.org
X-Gm-Message-State: AOJu0YyEvf+uQbAqDAnFvHCfWYsVQFdcPJqmIP4U0YXUKDKjySQKydLg
 APxCPFgFNQBq9g+cLf40N9MC0XUMlqUcIYi2NGdt66P25pkOugnUFwrg0DJEtPCjN9K01KDcyd5
 8KYR7Uc6VHgnWggRHPZGnur3stw4xSqKWA5Upsmjpo+/N9Hue2y5ijc+z5Q==
X-Gm-Gg: Acq92OFuVv1x3TYQfXTMKoDYA/ISDmODe8nfLHlRs58hY0pTDxo411eHR4bNz2TMG48
 SKL94TQprJkgDSENISCw+/CCom2OpwJONnMCIGHD9tVOA1zfO/lbOl9bXPxRFw7hidnTek8S0Op
 oqAM/Ow2Z2yaqEtl5xtQZ0IVurW/SFbGWxH5Ob6b643uDbUpG5eBEmXNR4Pk70r/ePoty2lZsLZ
 +FSiyFwHAU8kbu8O29zFrQwb+oVTABGKjyzR5gST1Oa7JP8g6Xhfgo0kMbZle66YE5h77jQF50S
 uq+jNmcBdMbL4kXDwz/j/SEaDWSMPJ15HKhTLz3QJDCes1mO0rRZUarkpxpOB7DKb05jSniitvE
 M87+OMPSaDt+5Wq5Tr3otB0/qza2v2WtPVVP4aO0tZtcQhpiOQsRS1uzJb1HyeD6QWdn6z6em5l
 d9l3FNoL5ganRqRhDxvHTp9ru3
X-Received: by 2002:a05:7022:388a:b0:132:5d96:39d4 with SMTP id
 a92af1059eb24-1325d963a32mr8827240c88.42.1778522371675; 
 Mon, 11 May 2026 10:59:31 -0700 (PDT)
X-Received: by 2002:a05:7022:388a:b0:132:5d96:39d4 with SMTP id
 a92af1059eb24-1325d963a32mr8827209c88.42.1778522371074; 
 Mon, 11 May 2026 10:59:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm19437598c88.11.2026.05.11.10.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 10:59:30 -0700 (PDT)
Message-ID: <49384318-3050-46fd-af06-4b5c0a14699b@oss.qualcomm.com>
Date: Mon, 11 May 2026 10:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h7QFnjqUxjGwVnDSvFYV70ydAU3BwmWy
X-Authority-Analysis: v=2.4 cv=LOJWhpW9 c=1 sm=1 tr=0 ts=6a021904 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=AlK-u2zkgHcvNUKW-4MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5MSBTYWx0ZWRfX5WcduwKfO2Az
 tOnnCL76nr8OcAt110rRK/XnRGGu7YDQlg/b/5cSA+sKSd15Un599G3fdMSkjMhxoLDXYU6ZGsM
 WXm0Xm/nff5cS39GvJodso9HGPFcsAubOrgALOGiexjeYNjOWX1P9ypKiuWFTHdJzEC+xf0Y3oi
 pITPG5tRqQeoZJ9fA4m1wiz5Z3JQBiJHEtJNXta6MtutrY6v/kPOD+KoNaazsffmB7KmrBAtqOd
 eZ+CnKScgBgUU9SEawn5reVUdkdmC8e4WfsB7MOQRKRNGrG8BjmAU7Le9voPPamqMgPf0/9zm+h
 J3cQw/cipMJltJsS7yJeWdp6kpwff8WA3YS+SRGpidBMkXG//08ofG9S5YnwWQQmpC4xiOuykr2
 labqmd9QVlMXSPkWO1cd2iNSbIHFEaWMaTB23OJkBP8p0GuFvmEOajsMhdP73xfHrbBByAcp0LN
 jqbyeCQV11GBC+JNlVA==
X-Proofpoint-GUID: h7QFnjqUxjGwVnDSvFYV70ydAU3BwmWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110191
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

On 5/11/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
> On 11/5/26 17:48, Cédric Le Goater wrote:
>> Hello,
>>
>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>> Introduce a source set common to system / user. Start it
>>> with the files built in both sets: 'cpu_models_user.c'
>>> and 'gdbstub.c' No logical change intended.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>
>> This change introduced a regression with PCI passthrough which
>> stopped working. Guest kernel reports :
>>
>>    [    0.156501] zpci: PCI is not supported because CPU facilities 69
>> or 71 are not available
>>
>> and other devices (ap, ccw) are impacted too I think.
> 
> Is it something we could test with the mainstream CI, or does this
> requires specific hardware?
>

It could be tested with a tcg arm vm + nested VM with PCI passthrough.
However, the problem is that you need to cross-compile QEMU in CI to
test current version to launch the nested VM.
This would imply to have a "standard" target environment (like debian
with X,Y,Z deps preinstalled) which CI does not have at the moment.

So in practice, it's hard to test it.

>>
>>> ---
>>>   target/s390x/meson.build | 25 +++++++++++++------------
>>>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> 


