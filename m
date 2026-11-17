Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D94606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=faKRj/R2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQaukBWj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMa1-0001AA-1v; Tue, 17 Nov 2026 12:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTMYy-0000z6-Bx
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:01:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTMYw-00058G-N0
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:01:44 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQuOA652066
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0h1GMlj4TjsfOKU+tCkP74bjZtrZeWDvlf3Qs0RXmTc=; b=faKRj/R2ZS/WjVXT
 esR4d1LFZLmg8al46FE0ele002KyaGG5y0gom4/q9SJMOFt2eLQABpEqxZKnW0Id
 zMk2tcyuR+q+TfaUp58a7EMObuehZ8Ygbzg/UWfDE2V+cP/F15Fp5gTEs4g/eVjE
 dmdHBSj09PtxsPy6/0uc2SI+BigHETOx8TDRaVHg7i3a/qZPVx2MQg58f1Dgk6qz
 CqY7dvpbBF9MVS3dkvnrv4EPrR1zjCPhKYM2GwFlLYrGgBpvrZxkmQBKoFPjzfSN
 u5bxtipILQ7XmIs64Ei8b4nAXeHsp+psHQUjGGnXiDhXEeWe2GwBfqviP5RGPTmz
 fe7iQg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gehawq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:01:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so77615eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794934896; x=1795539696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0h1GMlj4TjsfOKU+tCkP74bjZtrZeWDvlf3Qs0RXmTc=;
 b=dQaukBWjjGHrURwkU5W/H+TvwruoqXvxppTatlMTM3ujQf3DbB5vrJJylsCWott5sf
 ukHt2/3wIs47IlF5nKeQHD2daxswLAj+5wi6jCbhVcBceohHt7kwhfQ6ghBH02okA1Ah
 CkA1OkQjxKOUt353xL2V1yUan/8BB3GSQ8cK98/iUbF/HutLs1U11mfasEiVRvyf4ljI
 gLBS+ZcOIMa77Mbbjpvt/qwPf9DUZAIrJd0XuoFfrZHQupnuTnI6tX3PbcHH9Y/wQsVB
 tVr+Nvh04Qox8ACmvUBL92bhyIRSoiyCyKLTbAi7e+A1MM5LXAOM1joRUQjSmG3+bEKR
 fzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794934896; x=1795539696;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0h1GMlj4TjsfOKU+tCkP74bjZtrZeWDvlf3Qs0RXmTc=;
 b=J0R9jlKLOXwnThd1GlTB0exO09YkYcmzohJUPVK25t4zm5byzL4+cMRj5xo2WpBL7A
 u5Oo/8fg2bR62IgwWWO47yydiaaUdYwYPAKePDIBiYTVHWza5+weaG3yAsbTtvr5Zr+P
 z2X1V8Q0OKDmew5itDiONtWsHbO4oPKGVGyhaaGEkzZacw8Ib2lCE+ZioceW5aSmOMIv
 huhbsyGRmoYgsU88O+A3eRNN5KyfzJe8dlMzWz3/JApTay/AeaHiJjmQxq+oFo5VMY7Q
 QqFQdWwqH0GelhJHOpwXLA+hIwXtQh+Vg5yWiED0NZki45Mz8dW6r6IHboCwbtDq9sf6
 xhnA==
X-Gm-Message-State: APuU4Z8Om2Ib0FIazR/C+Rzcjp6NJDBhCzsm6BOdTpvkl15a0f9o1Sy+
 y/jgLPSkxq5K3MobgDNxxnZm8n1lXwl5klSZGkHF5JHuhFHuknYBtEKy1rtS07yz+yDoLHjDMlg
 Ac6o4D4ExaMRcnUn+Gg+zeUN2hOfBMENh2GZLo0Mt+2ZLuzZh7EFwHZ6IGA==
X-Gm-Gg: AYBFou1q3D24cQ1BzXzTWGEqm/10WKlnaj+N/Ynm9KvhtaiTh/bA631z6sPqMBwRnDR
 JINYCNhyhqI1zcOwHG2lGQz85atdU0ETgENLgw9OUdmTFV75faCsprBDZHozKeZYao82UICVOiJ
 XVD0UGAdyHvy1MEHENT7CjZQxBaPB9o8/HRogxUzqH5bKxdfQYmPW/1hH4Oh0QNFEvxnuKa5+L6
 d3ANlrtX3/3KxK5vD27wYumt6OoH7soyJGOl4KLvs/Joa33aVutVgTmVs8g1sGtEO6Wz9Rz0F1v
 BEdcpNKwUap6PKzlWVMeNQY2CI1Shz3KPW2EgFuFkEHFa6LnbgtlXzr5faRTbLJURVhpOZw6Jmz
 N1ZatnFsf9JY0h8Hh3Ar1LqA81TYsD4TeRavwaoMcMTthJ77G/9hWX7rCl3XbDSqeaCm1r2bVeL
 oJGkd8sycQGv08nYspw4wlWIi/OPa7PUdM7gbn53f+6WQ=
X-Received: by 2002:a05:7022:258a:b0:1b2:6cba:7f88 with SMTP id
 a92af1059eb24-1b543d52e76mr166825c88.44.1794934895943; 
 Tue, 17 Nov 2026 09:01:35 -0800 (PST)
X-Received: by 2002:a05:7022:258a:b0:1b2:6cba:7f88 with SMTP id
 a92af1059eb24-1b543d52e76mr166599c88.44.1794934890496; 
 Tue, 17 Nov 2026 09:01:30 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319e381sm42021356c88.12.2026.11.17.09.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 09:01:28 -0800 (PST)
Message-ID: <00c0e48d-4186-44de-a078-a69586201211@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 09:01:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker/dockerfiles/release: use full registry name
 for image
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>
References: <20261116232311.2761545-1-pierrick.bouvier@oss.qualcomm.com>
 <avwNg95uYe_vgWH5@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avwNg95uYe_vgWH5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CpK5D5DUsR2ISAzsbfGhfB9BOZ58sfPy
X-Authority-Analysis: v=2.4 cv=dLkzC+Zb c=1 sm=1 tr=0 ts=6afc8871 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=xJsHBwJBRiIF2je6l-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: CpK5D5DUsR2ISAzsbfGhfB9BOZ58sfPy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfXxyJn0ntp1z3i
 V0nu+djKG+x/jnCnscqLe7FF3GIICsHT/NjOBhXHisYGjEzdeFIu49x7+ohKmSHqRtG/KBoUMhP
 FOOVefNP/+WqBtDR1uKevMgvGF1UB3M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfX3L+74LQn/gaA
 DzyjZV13LcYUuYfua1f0HfiQUiXF//SQtNoFASVaUf+NWmVGdMpKC1kxFrqWm0H1kBBcUksPT8L
 qPG85jgF0Xv9tIta61FcURP2z3jTE66kyMZtoM2yKPA6eZUyBKlCwTL3jGPUEk+tvfyLLVm33yj
 z7H2uJWcqeCpgQlyP1ijlKPr1Gk2NYzzgE2e02xwJUB54j9JVpEW7//EocJA4JOp16H9+S/kqkn
 xH+r9s0LAwrjQFGjMUe28WS0cCOd7eHVyKECqG38tnvrjrNUqAW09f7v0K+RIiJ+5gWprXt9yos
 6IDIrSrAjhBc/JKLEWK45EbmJvd8FPQZZFJDh3mdA2sWs86+8RYWeZcQ/RItkVySScnMFq+lgqY
 wdj7dHBJ3hwflNHAZQLg7pCqtXoXQv8Ryqxr0ryqBNu4aV3rV116XJefFUJNhUk2ocd5d2H2cPZ
 i8laPKzDX0UoDkYoBdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170067
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

On 11/17/2026 12:17 AM, Daniel P. Berrangé wrote:
> On Mon, Nov 16, 2026 at 04:23:11PM -0700, Pierrick Bouvier wrote:
>> By default, podman does not have docker.io preconfigured as default
>> registry, so building fails.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/docker/dockerfiles/release.docker | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>> index ca6babde01e..a606eb5ee79 100644
>> --- a/tests/docker/dockerfiles/release.docker
>> +++ b/tests/docker/dockerfiles/release.docker
>> @@ -1,6 +1,6 @@
>>  ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>>  
>> -FROM ubuntu:$UBUNTU_VERSION AS build
>> +FROM docker.io/ubuntu:$UBUNTU_VERSION AS build
> 
> How about docker.io/library/ubuntu  to match our ubuntu2404.docker ?
>

Sounds good to me, it's the same image behind the hoods and it's more
consistent.

>>  
>>  # add deb-src for apt build-dep
>>  RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>> -- 
>> 2.47.3
>>
>>
> 
> With regards,
> Daniel


