Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B68BCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBQa-00077C-0P; Mon, 15 Jun 2026 13:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBQY-00076r-M8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:48:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBQX-0005pY-21
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:48:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhmso783393
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5BjdkrgJxOA6Z8Yjhch3aNzCmA+8Xq3Yu7e15g2uLa0=; b=C+FYd0awfOYWqcXO
 cqI0tc0N2y5AggpSsG3R7OtpNOzqxt46GpPh+hg7Ykt6Q4lhe5hZYDE+teAq0m+i
 5O1LnKElIltJsGsGoOAR8CbSHNCbPHKcG8wps3Cc4D9JQLzV7/fh2EKn+T1giX3M
 QUuTjpGSu6BW1dSH+FkxEeaCSwKJc5UgNTlkkDKJhuEdoUQhvqTqdseHjeTfiRb8
 ALOgF1NPRVCeprcijwum+7Y1SG4wZf2PhIsUp6IZoDQJnmsr9GNJHRyeEr/rT2K9
 SiNUrOuJR6p/JcMhdb/RPPiq9g64MYCLMU4IXR1A0JfvTHqP1qt+Wpc/AnogV+d2
 L4q+qg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx2322-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:48:47 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139553dd8acso3415914c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545726; x=1782150526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5BjdkrgJxOA6Z8Yjhch3aNzCmA+8Xq3Yu7e15g2uLa0=;
 b=itJO6aC29xI/10BlJNSqft3fIgJ+mffQT+T3dvCHCE6+K4aCWxo+O588+68R/8NbiE
 +S5JbJHZdx2sRPD6utIhBfxkdDoo9kPsdwF4K8rfOFYCyzaiKmfCW9Hib9GFbD2KHCy0
 eK8qvDNLq+z9hCyL9+H4m8bpcNLT7sNKjlNRA+5taREC7Ue5nYbaGMeBjMhQRslJgDde
 6jxRW3GYUOPTNeBFwaY8jr/zlO8OHv6Wd4zgc/xmfWQNXheMNMxnQ8XlMtT3wg1VsJ0w
 KtHNweAGVItOb1jUypieVq26b3A4LF9MNGQThpOEanbODB1KHLSafg0BKCj1KZWDsy+8
 HdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545726; x=1782150526;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5BjdkrgJxOA6Z8Yjhch3aNzCmA+8Xq3Yu7e15g2uLa0=;
 b=SYC0/+jd0lU5f5hH92psDQ3n4tPv93tQ4fdrdAS/QIwKBnwOTTwMEw3PMhQunV4kK7
 YNUa+JvTpeG3kWsuP+vq7lVVKpPjp5ogIYCYf78dRvl7btvmlI6iv+mMp+e6KcsgnEvr
 ladJs7k1XLVFdK7v0XaqFb1WFsKCjq9EnvKtsK00Pi9emK6SqC+7A6yPi5ueRiaR/urX
 ep0Wb/JplmM1hxY47bz90mr5atnu0KI7BF41Fvr8cmvD0u1jiK7XwuSHQ4WBNhTo1QNx
 fUGXuko7Iu6dV4fRjJm+ejaTiDNu+bN2cvQI3zGZLbcie9YBoljjHIjZMF2936JJITEH
 B4nQ==
X-Gm-Message-State: AOJu0YwPYUW6g/wf418GpaxjkjqeZWSBeyuO5NaWNQqVzFiv13Z7GJMI
 j78TJgq4fa09kC4CVDfBEgc3X4AsWI7DRWOwB4m6mjdpbkn4CtTL6EVILi4+K8H4+HHi2g3vCCz
 ZpI1sARlAHv7imVXwLnK2FNh2ujcJrJyhv9G7BB8Xvfypeap5Ypg8LCfZqJsk48Druw==
X-Gm-Gg: Acq92OEczvtEt1Y7ny6yD49jMseK/1k9hlbn/+pK9j37JaldZJ/ly5KVC4RDpVu/RWt
 053bYB4k1sHjk0w0jRYMgfxSJF53+D/LvDisNbdVGp636kSImO3kfd8du8ieaIBiJbOGkN07sdV
 cS08U/c8Ranb3OUPh+yDuKwq6NkVZ/kkZoh1TjQ0YW2zZXeN4Oq7HsEASOkDdafaKQhpEddeO8F
 iW0l7fis0/XQYKg/U1m4OTPStuwaKThdClUC4SstIfdfFQvrJxKzwlUHE2aQYrIu7UKizX1+bXC
 EgEfF9n/3Xfmdki9EmatrswBrXLEt8MMNoa4YPfPyxy1JQCit8edx1zKFK7GJVWOShIKsjrsvGh
 cu/wG/fqRDfnk3Dn8s+DsgdAUtCgv9d9GwVdY0iPxtDahEVzGZpNOW7YDSo+XIx6QiOGBklL4TN
 zXDLiw9J9ZCaEipw==
X-Received: by 2002:a05:7300:a54c:b0:304:d456:fca4 with SMTP id
 5a478bee46e88-30ba5ec02abmr156648eec.21.1781545726522; 
 Mon, 15 Jun 2026 10:48:46 -0700 (PDT)
X-Received: by 2002:a05:7300:a54c:b0:304:d456:fca4 with SMTP id
 5a478bee46e88-30ba5ec02abmr156615eec.21.1781545726030; 
 Mon, 15 Jun 2026 10:48:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e920243sm15841339eec.18.2026.06.15.10.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:48:45 -0700 (PDT)
Message-ID: <88c2d3fa-548d-4ce7-9244-a7646c315d9f@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:48:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] docs: update mention to ubuntu2204
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
 <20260610192222.2709135-4-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610192222.2709135-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4GRxheemrnNFJeobeIUtjTqQHnZmTa4B
X-Proofpoint-GUID: 4GRxheemrnNFJeobeIUtjTqQHnZmTa4B
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a303aff cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=r7oqL4V5NfvAbcI8S8gA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX6V+fTXr9HVMR
 D9xGSYuxIZq5+JBvgRQfDyoG8JjL/1FGrqhJyJ74ZD8xYcOc6sGMYXyUYqTUPx8y3FOHXQitnIy
 YagR6OWGBptGFwa/Et9NmSKzDnN3hB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX5f5FKgNYTEDY
 X1pyv7Im+mvIpV/TcSoC7oAvvCBEtHP7UaUM3RXVIEhM2FZ1k5uwNSsbGkun1dZlIHMkSl5ickD
 qbzfn94fz6Qhy4sgOUng5nxQuvxXjLet9letuH99nY7YSNMEYZ4y1SS1CR7OfP/DHkeZNDR33Uh
 JgFM7EZVwyeX8jhvxbDMyYbv4ke8fFFg2wwMkHL/lOHJb667SofagqwndBV7/6B//8knlykd2iH
 2Sm0jFBSpyDuvnSZd/g20Or40sWYU5hIVL15DHDD+5XI5vN2Ny9rxcONxL/Ii/4jSXz6LCPGwoR
 PbfYtHognSlUX78Q227YYs6bbbeKGDtUy8BAhOgZHU8rqA8DzBldscGfttSPb8UX7/6bmszKygp
 /ZUJlPxxvVEZZXk6Kp6IpXoaaBJ76CDqMGiHgFXTqAvWsGmBCeokZrsRZa6HD7Neo5pUTwtldju
 NcQSpIoHVm3kSE4UrvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150189
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

On 6/10/2026 12:22 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  docs/devel/testing/main.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 3408b5836dc..c6821a36d99 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -711,13 +711,13 @@ https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
>  
>  Thread Sanitizer in Docker
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> -TSan is currently supported in the ubuntu2204 docker.
> +TSan is currently supported in all our host docker images (for instance, ubuntu2404).
>  
>  The test-tsan test will build using TSan and then run make check.
>  
>  .. code::
>  
> -  make docker-test-tsan@ubuntu2204
> +  make docker-test-tsan@ubuntu2404
>  
>  TSan warnings under docker are placed in files located at build/tsan/.
>  

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


