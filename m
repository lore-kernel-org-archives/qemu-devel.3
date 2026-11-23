Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157E606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NwsDHatP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wt654U/2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXyv-0006TM-0E; Mon, 23 Nov 2026 12:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXyk-0006Rp-TE
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:37:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXyj-0000K3-25
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:37:22 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGswO846532
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dBTTZ4n952LfrDw2B1O/kgLoM6aJTFjmkeXGT0ToU+A=; b=NwsDHatPOEe9Yr9e
 yiIUDKptrJTj4Kn23PgkF+J9zz2qTOge+HiE2TfWYNKVSpyLwd6Wkt/RboHfeo7D
 KF5sZJcPVijzjoQMRxC/jZ/NbKvPRkC9P0lKMPRg9hfnle4zc1M/rRO5XjtTi92F
 OaBuai72mi6hfJ0uWXoqBlizfr7K0G9YpXhDH6cL1bj7JaIh9SWFFTLlkl5UxiDV
 hvfTpnGWyrQVUdnWeIaGoWSf3eZXySytY422ISyzxrJyN0PhP7zYbHTEah17+gs7
 ePdyRTTSuszsKwuW91HRBcocNO1oHdDN6XVu0u9qpjC9TDtZzGzD4WxGLdtXOsJ7
 c1be1A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g742mg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:37:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b18165dc53so4090013a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795455434; x=1796060234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dBTTZ4n952LfrDw2B1O/kgLoM6aJTFjmkeXGT0ToU+A=;
 b=Wt654U/2wfQiAKEgj546OKDdSI6fNNe79GpS9qC/AtwMhJu7xt0Xx0PO/Pt/7L9b9n
 56tKbhfyAKiCkfa5zVf8Wut+e3lFhL4kbjbbj9Mv3pIHoxRCz8SkJEmEGuXEb0ASxzy4
 BlwKUBzsQvY6DarIDvVFfzEjAzoTQGiCT+2UCT4eeQr+93s6M7rSccUAXLTUFHO9ctXb
 qlciuRJ+kaR/ZjU+xyxw4Mo1N+IuYr2nnzTTebw9oJ4S6fcdTIj/Zu6uv3vhlddXFPoL
 yqQNgjG+pWLnYe6fK4BScCBaitiyCMGXYJhDevcMA+e2wKXCprXjSeTWGMh/T7HVzVop
 aUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455434; x=1796060234;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dBTTZ4n952LfrDw2B1O/kgLoM6aJTFjmkeXGT0ToU+A=;
 b=VLtYRXB55qJ+fRNEr/Y9auhYBIrfSL3s79SzP/sTaOMD1KWJtwI2e7gVjpnN9knG6s
 mOucg8ULTd2T1AC4/p8jbXvNy2ij9izXYQWZz6vfIhYOm6VzpMc7zxsXG+uR0R7oGB7A
 H1tgUBGh0RIMrJev5U1JVUbC2GwTLsUeSZIbDhllDhgw5EDvkb7VAvJ8j74U0zcrHqpX
 +FItTf2o6hcIjfu0R4BOUNecKjyLdwQMfGTRf4HVMFEaSBJOePUukFUUomsEEbIMGWcF
 PLibIsNPMtR+VmKEYzDKQs944sL43Zq1SIGFG1nEkjGprq89dVK+eNAtOKDTNB5iTsW1
 XA2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFRHBqElCD0UmljCw0MlH/EZxoEjTtAY735Y6OqmJzkIBpXFUs7087DVf5PaRfBh4SJx3m3wPZsR7O6@nongnu.org
X-Gm-Message-State: APuU4Z9Lk8uzjTdGlK4XZPZHVfTbKfvZuvPYStg+ZzvIv2Uloz16f5Ar
 6H2fWSEzCrVsoYIVrC2LoA5ZEiChScghnrYYG2Kf9wq0BEWKwVuXjYOsIq03TOFhDfvwPOF2Uhj
 8IRurCE2h1JiW+Qe7XZY1o55f5vFCpM/+466fXpEMBxOyFhMznwikdcmR7A==
X-Gm-Gg: AZFdTZcrzWe+JOqy3C4CQF95EN8kC3c4XmaCJc/bal2yHsL3jtBtnDA6tH8jqE4+PeK
 UBL7seJwQE5dZRpzHX6vu3jPy3SUewNUN8Ma6TYt2fCUR5gkf/bcuiPV3TS0cvjP2NQ4Fde62/z
 ndA9Te0v8qRrh57OO3AwaFR5EqEmHpck9tHi/+7hdihPEs8OQi0FiUHk3/qNVt1LfwVinu6dEHC
 JWjObqOqt5U7GXYRXjOU7uZCZynYeFGpGMI/D/Ukjg+bvbDv8bbKkwJDmuD9hCP6a//AC7N+Jq7
 t/HclV8/I508d+vTqMFFTw1UcAcma5jL7Qf9qn7TWQmV4ZmVjBcd4a/hAlZ8+WhLULY60AwVRvQ
 UkM0rRpk2gD8rC3evPWab7unACW00O0XngW6FowW2lhll0w8shhdNi63yrZIZGMlCKPeZpBDkU/
 17LEDGwcaSuuRoOBQj2NjKLN6yKeiCo4FQZA6Doqa3ib8=
X-Received: by 2002:a17:90b:4483:b0:3b4:1877:8d30 with SMTP id
 98e67ed59e1d1-3b41cb4fd23mr10978793a91.62.1795455434356; 
 Mon, 23 Nov 2026 09:37:14 -0800 (PST)
X-Received: by 2002:a17:90b:4483:b0:3b4:1877:8d30 with SMTP id
 98e67ed59e1d1-3b41cb4fd23mr10978773a91.62.1795455433930; 
 Mon, 23 Nov 2026 09:37:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41adcfe23sm18835980a91.15.2026.11.23.09.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:37:13 -0800 (PST)
Message-ID: <fea3ba89-b832-47cd-90d6-5e4c98c56029@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:37:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 12/12] hw/hexagon: version the virt machine
 type
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-13-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-13-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6G79X5hP2fteX3apKarIRKDZUw_L9LZP
X-Proofpoint-ORIG-GUID: 6G79X5hP2fteX3apKarIRKDZUw_L9LZP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX/XmEocWdSO4Y
 AKkCUgP+qUcS9gcjMgNELg+HAL7HuzRiQNaOiykZVc1ThqH4OSnXaApTm0NXUzMQWr8DbpmvYPG
 oPRv+dbp8APZMJqPdZrmVR/VUa60Kl0=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b0479cf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6jMAm11TZ2pA2caXCv8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfXyb72sHoBdJR/
 ugqqOmQX68dBP9Tt84vYaYKZdM0dhln5BxeqAhkGgHEH/iOMxfln8+gOUtkMYfX1xZdFWfQy9PF
 XJK+PPy/ddi/u5b7/ZINTAC96uA6joWwAH34wChbC6d8udCZM8imn5MWYL5/UdVufAFgimvqwqo
 0QLLCzxH7sMWYAK0+X5PPyfyyY9U+nLfTWdIRx9NGytTZg8ybNBW4AzGVLEr//BHugLECOr+Way
 ypY5nD05a1A5rL7u/1r7mkwUKg3cRWHOS/iSo7ocsT+m1uWkB3+038NIrpVXHR1XI4voVQYTCfS
 dpkP5Z3p/5Au7gBDcmG5FDFZqYepVm8MsS/u7gFyLExfGfT9arIW5IaQm3ep92tC3/gIKxLo2xq
 24lqXBG1z0zDJo6MfQ0xIaudN7o6gFt1H640pdSS39vdgdkvplC5AVrp+2Gfo5k3Ql+2bgqRQX6
 VaEU1vBNJ/J5+00whrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230070
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

On 11/20/2026 10:20 AM, Brian Cain wrote:
> Make the existing virt type abstract and add virt-11.2 as its only
> concrete type, aliased as "virt".
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/machines.rst |  3 +++
>  hw/hexagon/virt.c                | 37 ++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 

Introducing this mean we'll provide backward compatibility for any
future release, which is a huge one promise. Are we ready for this yet?

Regards,
Pierrick

