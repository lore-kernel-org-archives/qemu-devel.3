Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571C6CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWJ9-00088g-U9; Fri, 02 Oct 2026 01:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWJ7-00088K-QO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 01:59:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWJ5-0002EC-Tw
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 01:59:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6925jCiR911663
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 05:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kfPzDCBfi73ipu2PZKtV57VPClv9ctHdwGyFkwUuZFs=; b=P3Q+dDdEpuXRsJ1b
 VJlVw+9cUKDszKpf4rKn/zC6zsVnkNEhbKYqNtyR3Dz0tUCd0zjbbJ6me4KcfuPG
 gYNimpDIxg3MCzRvl0FMsEW8QUgGs02RIOCnJJZMUeNCdhX803RwN/lqTvWoitPn
 qhKhNkpLjXi3KW0N9EycHcBOVLSWwyHeuJNKkzSdmjdyC7XECvDFR7yACjl2ZSPZ
 tdEpxd+skUJbGSxld8F70X4drOhUFJccIrUPbyj7MvKRbqATQdPq/WEiwg9t/gH1
 RXMzYEIxzEUii2fN+q/IBWUuQs5KrNWPPpOxWU8OAE1jGrco9tT59FjfiRuVEyUY
 qODGGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh124j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 05:59:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so368048085a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790920782; x=1791525582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kfPzDCBfi73ipu2PZKtV57VPClv9ctHdwGyFkwUuZFs=;
 b=dqp9lCe9GmCSzN1VXkYgB6RMFMeh8q4NIz0XL7SPb78ZD16TFRlUUmPnpPrmARsSFn
 JFPXeNUiC7JcPSu8L9EBxAHpooY7fs+Qi4By7uHMdI+Oc6AwxeN0h0NFjfFoHoLMIte7
 Ti+EITxmK4fnPCfwIcjYLRmlPkNacnC7y0xowxEzxNPEeGLUjMwjGZ3CAvJ8yc6ik57f
 xTf84E+dFUlcFZwX/3Y4vDEzM0+o4abFIhgehYiZE1deon+vdP+6+zrlyZOqQkZJeY33
 cg3ItUKaDoY6GxpxlPHS/bQYt/DQ08i25ixeG4HMKxc29MNtgW4w9u0X7PodtHjKafs7
 z/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790920782; x=1791525582;
 h=content-transfer-encoding:content-type:in-reply-to:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kfPzDCBfi73ipu2PZKtV57VPClv9ctHdwGyFkwUuZFs=;
 b=rQ/+/xRrUCAbE+IiyTCnBwiJLiaShXotDdywkminAdg5zNE0YpSoxlXui1kR5RgfGw
 h43QslcNEv8cAEcU5W+y+xSaldQLXoKfqUmOoUtZOmmTJALKH05REQMFcYxKUS2ND/DV
 B3N8EB4r77H2aAaojuqJAMu9jsnChLSsA4n6XMOKCmb9hcgRLMIPj1u6clICT0cfpvmQ
 Pkq1S83mmnHiTYQk8mjA4U0spTZYq9zfx/+YfUwxP0U8x3uhhJH8T1DWT7MrLBsJNPU+
 7BEmhqS2OlbsxuZNJvoVJJh/A2OFHwENrGVg2x92eoKFuQu5eB4qebfZFYn5HLx1tXLq
 aPNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI+XOkmAnkTqkk+tD5IuGEJLoT2wb9q2GJmErvITFrgxg2dApAdBE3fmoNEiV+Pvok4f4WWRxpf8AO@nongnu.org
X-Gm-Message-State: AFuF++lkjx1v7XUnIVFEebfnmqVdDBbbgIQ8eAg27Rk7QQdEoMJTH6vc
 pp7hwXlQQuPsmHAWyLENVMtHiVdP1j+0lCurS/8c4P44TUpDipXjqwHkKjwq9FGFH6Qfed8b+wo
 hnc7Q6xeKnl0XgTLgAyOoOSfjogLExUPx3TSPJOoamUIHfccBCxugb467wA==
X-Gm-Gg: AYBFou2dNDUWw65o1baZ1oaHZQqk225mZ7vwMfItn4mCrUsN3VVIIKtrlVoNwjLOluF
 MJaLJyr8zT9l6XxGCnEXPRfQTKQO6z9wNrboydruGl/K3w5xMBbaatuJgm7jMf4Ts9pJLMhOivW
 hoUWmSMSbuicK3w90yvNCYe/SbFJyy9K3UJpnxpC7ciGkcFcgEUDhLbS4hjhVBbGRd38MCoOZv6
 Jjz6wPOP5BVpGy+V+L6D+uUEsvhTHda6DKxmbH8e7b4IlDnl+RznXDwmntBzUL340iIBwEldmT/
 +oHMhew5saih1MRObm1GrfkpRcPCzRjhesXWTbwtANDa0HxoFyFa4YQU1QyNgnOeo/LZURWuAjO
 5wHiRf9a1I74jBEYMR4NuzXPETaRF/lvlqg==
X-Received: by 2002:a05:620a:7087:b0:93b:d79e:18ff with SMTP id
 af79cd13be357-93cf19fbceamr285012785a.66.1790920781930; 
 Thu, 01 Oct 2026 22:59:41 -0700 (PDT)
X-Received: by 2002:a05:620a:7087:b0:93b:d79e:18ff with SMTP id
 af79cd13be357-93cf19fbceamr285010685a.66.1790920781436; 
 Thu, 01 Oct 2026 22:59:41 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02770e8f2sm45789225e9.6.2026.10.01.22.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 22:59:40 -0700 (PDT)
Message-ID: <661b07f7-2f85-43ee-8dbc-5e71400b8a16@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 07:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] mac99: Boot OpenBSD/macppc
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
References: <20261001230058.11465-1-kirill@korins.ky>
 <5622c432-c2f2-4f1d-a8dd-c5c12ce91890@oss.qualcomm.com>
In-Reply-To: <5622c432-c2f2-4f1d-a8dd-c5c12ce91890@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMyBTYWx0ZWRfX0CjBLdmbXs38
 lu8V0swieU2War4fxU/X4SUbgkWfuyIqCUd+GM6UPppRqyAFs/tS/Nc2luea98Rnf2VI11uOaR6
 b7/wH5aARROf7edB0in70KxeIOAlwrQ=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abf484e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=s4g3o2Fa_C1p9C2-3wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMyBTYWx0ZWRfX6oh5nkIuy06Y
 jR3ZlwQPH9JvE0sZnzdpc3Y0Fpd1k3AvgSy1p0Zm676Xtm6SujEzeJ91URCViohAlA7TkNb42hG
 4iX81fvniKVqTwqH6bjdYoWywetjmAJ68VBOuHextLdYbSxBmQJDVgdy/lv3GpfAkUztcN7V39I
 9YMcIeLQz7jHPMk3baq8AbKVruGlgidYycTkNWaF2j0cjS1sL0wdWNaA+Ty5KRe3/401WJV3lFe
 4wFMUX4xsFjQIjm5bl2sX+kg4hSvNNQksjbQtFj44I0qO/z6jMXXKnIJ8wzCLi1ppIGGNhSGNpX
 XVVJfwQPOaf8Knbc1Xl1gKVP7SoROVQ062kwZCHOODPiZvfz1ym1elOVvfY5iJZHxrcAgxsJCWa
 nsC+E+UYtjwmeMUXLZT+IixwYrAeTGm+pvfqW4TM0OxKnZyEMAKvC71w5F+nyqr4lJ+8V3fO2pI
 NpBSr5MvsnrvpmpTmoA==
X-Proofpoint-GUID: v7i02voRf0W2LTYy_52jnntn8J_I9Fxz
X-Proofpoint-ORIG-GUID: v7i02voRf0W2LTYy_52jnntn8J_I9Fxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020023
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

On 2/10/26 06:49, Philippe Mathieu-DaudÃ© wrote:
> Hi Kirill,
> 
> On 2/10/26 00:58, Kirill A. Korinsky wrote:
>> Greetings,
>>
>> This is the third version of patch series to boot OpenBSD/macppc.
>>
>> OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
>> reassert an interrupt still masked by CTPR; the edge triggered
>> decrementer does not raise on zero; successful CUDA ADB replies omit the
>> original command; and the fixed CUDA shift register delay can stretch
>> packet delivery past the guest timeout on hosts with coarse timers.
>>
>> This series corrects these four behaviours and adds a functional test
>> which boots the official OpenBSD 7.9 macppc CD to the installer prompt.
> 
> Can you add your testing as a functional test? As a follow-up
> patch, not blocking this series. (See examples in tests/functional/ppc/).

I didn't receive the last patch but can see on the mailing list that
<20261001230058.11465-6-kirill@korins.ky> does exactly that :)

(the usual cover letter list of patch + diff stat would have be helpful)

> 
> IIUC this series will be merged via the ppc tree, is that right?
> 
> Regards,
> 
> Phil.
> 


