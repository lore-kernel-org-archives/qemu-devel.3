Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB3DC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wti2h-0002s1-5E; Tue, 11 Aug 2026 04:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wti2f-0002ra-Tb
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:41:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wti2e-0000tU-7x
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:41:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B72C8E4156910
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QOjE99QaVf2ApzERG5pZhYdZUP29q603ACzNN+1kTPw=; b=kIbDzCrsKmcNM5Se
 csjpMrAHZ/BLoMyaLBdht9GoLj15y5+89oetVAjdINsFAlV0sn+4MY/TEKP/mLHy
 TBXhmy2qvpDOa2MIRhU5YL487/X8Ch5CTD5xkbYAQQrFa/4VIKUz50NL6KDIJnj7
 FhnVR7ygkApeMXvE8xdBN7Q2XBYWgEoMw79MysLBcdBpSP8d2+geKntaEfWt4xCl
 vO479/+DlN8G79hMB2KXvi//C/vG9pOIlSWMXoVNOPAIVcAajV4bXnE4XhpMqdan
 +aR+Gt93jDgnNB3rrcEzi7dO/bDv+MGTiMJLDi2JUfiVqpEAtKvQGitgYbDs3vmy
 7wfVcw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyhp8kjs7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:40:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so269966985a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786437656; x=1787042456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QOjE99QaVf2ApzERG5pZhYdZUP29q603ACzNN+1kTPw=;
 b=LHYM4/1GZIPA+YCUkwV5guu/USnqXqgkvgBdtekkgaZXqSDJZ9zahpoq4yEsZY7YGH
 /HeydIlxNi8bSbGTlqpmqvz1PX5Yg4EX2rRlzcDokTo7y4vVzGDbyf5QsHgK5fPvp32L
 aqrUM4D0njJVJ3O2u1tx2HEGQv1tduPa4LBkOs7n93Lx3jd0/hkNTHoiIEvlWKQB1dDb
 RwjpVp+PuyJNnghIE2pe9B06hWJjnb2b1T3MgnInZjszqFS3z0Fg/UYw1cmcyIsPqVFZ
 2kqG+0UQ1x2obD7hMv41o+E4cUzY74zdV7W0Ifs4fr8LVZcqovPK+hHdc+ikKzdnsZht
 DjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437656; x=1787042456;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QOjE99QaVf2ApzERG5pZhYdZUP29q603ACzNN+1kTPw=;
 b=KTlYfmAGCTG+C00MvGSXHWczLJaU9XeIN1nZtElz/DyOUdeMMZtAKt4R1Gt9RAbAX0
 zGS6Hzw+YaCPB5q2wU8Nm8pBlPqZE3cb6FNyj6gvO3i7KzI1WRB2dPi5+nlqCHPXl4bZ
 ZKMwuYsktPY0U1hv83T17GOFKV5xP7VyVMqyQGICjFd5uCsthHXiY23l96Quga8z6Mv/
 WjxzyrM++87LoTu7tVI6F2zygwqXkwt11jAAK2TZIH6D5LJB3dvtSEIKZBrmwtcezJqh
 tj28TOpVvwXq3npZqDN7wHsCYx8vRQNOuEvA41FpnJjnvWcUxgIM2u9WIAq27Xhnf9hG
 hOCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFLfoGxMWauBaOgcU3bFcGLtfeNUh2YD7r9MdX81x1FiKjoMCr+hyGLhVoWRWtgAy9mnEhiQfxUr6S@nongnu.org
X-Gm-Message-State: AOJu0Yynupvr1jM27mNFxj2Fe/G3ARIupMowHuonxQO7Tphs+qPE3xqS
 Qz3l48wiRxChI33M8f26Y5vq+ZckzQTpleRxAuD4R5EP77n/HpxUMdXwZ8n9VPdme8/EpNbfBwX
 mcBlweN7Wt769g9d/79LzaQ/OKc0Jykf9nVDu4uRq+NVARYhQ1j2RMPHyFg==
X-Gm-Gg: AR+sD13p+X6KZ0bAxNqjrgT09O+JnAqh1+UF58Z9CyaY+iS85pm5wpRWVLGwUMNvbJJ
 iSO94fSrVMn2VFfRZTB5oMwRE1Gddvl0vnMpIYUyehrVQixdefKx2ZIL1qDG0WJMnMSe4T6wUP7
 4AKsFYKCdw2NsM+3mHYunzZrUCrAZnVfQwH8BrL5s9iF7R5bBF0c12b1IpQXW2T2D9gl/hlidPF
 9Raxf9hpFg+GiDr50QF3UDG+65GJ2dLoOuneo9tCzNgPspG8xQ06FH3XKVoN4Cpsv077wW3Lk/R
 k+YQHcakR3guNsskwNMfrBGA0ZGRO8QZN/nbhMWGCWww7EWR8llH//tOmR8Tv/ByzNf5IihDWme
 /OJkW20kOr7vQPuNxu4KATVrZxJBVYlE2Jtc=
X-Received: by 2002:a05:622a:5790:b0:51b:efbb:fbc with SMTP id
 d75a77b69052e-52d586396cemr12206961cf.33.1786437656091; 
 Tue, 11 Aug 2026 01:40:56 -0700 (PDT)
X-Received: by 2002:a05:622a:5790:b0:51b:efbb:fbc with SMTP id
 d75a77b69052e-52d586396cemr12206781cf.33.1786437655692; 
 Tue, 11 Aug 2026 01:40:55 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a72cec5sm2660411f8f.36.2026.08.11.01.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:40:54 -0700 (PDT)
Message-ID: <52edd360-8901-4c45-9231-ac0b88d60905@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/39] Make HMP optional (and later standalone)
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <ab1837fa-3e1b-48a9-a2d7-70cef35f1ed4@oss.qualcomm.com>
 <anrYLgyzGTVze_8n@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <anrYLgyzGTVze_8n@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX0LZfZSf8wVi2
 IPQDhCJjdOKhNPkrpEJ45y8Gexs2tzhb+u8lKQHEdMpStbkpBCnyceeGkHVoW19BXItiLAbsier
 DapK1HLmPJCXkj9PdMd7lNmQg6dVgrs=
X-Proofpoint-GUID: K1JoAkrYB4UG1ulj8Apr-7-VkodmXwRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX6Q7RneIIrFpy
 42vHBA3kvehynDjjOAVLBqhQl+O4RR2CeQtLEOVX8Z6CN/udOMXt38cha71ueHd5ROlnDuRFbts
 JRwF2xmfIYgV0nptDIq7Trf5kZdE8HVvPmuSpUZTcz3D5lLOFt/zcLa1kFw9iXE0SY9O4FhDIBo
 pUcD+/6MFa5EzH5lcStxDZlVJVQ1BHKivknl4AXQZUu4LRKDUciBDLSMHkYQySD4RvdF45yuyBn
 8GJ5WGYtmYdDS2WSpRQ27kPjT/edzjmX3VfWjlboJlCTPWD2QxW26EQdwQntvqkga4DocebMuKb
 UqUFXAaI3Xs1l7Lj1edq0qsmsGNVO6b/KUTjMceUi6uTJ7RufPu/ei7FRLUkgg+nfA81TgQQ1tw
 ZGhjFBnRO5uieQTtZAwQUPpg0c5UaQiZQ61DBc6sX0En3SFpm/zaF7rUbyZ4X7LY9cqFFt86akP
 5JaWKZqGHwjJw/Kg8KQ==
X-Authority-Analysis: v=2.4 cv=RM+D2Yi+ c=1 sm=1 tr=0 ts=6a7ae019 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=8V-8KF-zHGsoUC-A0u8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: K1JoAkrYB4UG1ulj8Apr-7-VkodmXwRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/8/26 10:07, Daniel P. BerrangÃ© wrote:
> On Mon, Aug 10, 2026 at 11:49:08PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Marc-André,
>>
>> On 25/6/26 23:19, Marc-AndrÃ© Lureau wrote:
>>> Hi,
>>>
>>> This series makes HMP compile-time optional via --disable-hmp. The
>>> resulting binary speaks only QMP - reducing the attack surface, binary
>>> size and enforcing a separation between machine-readable interface and
>>> interactive debugging console.
>>>
>>> QMP offers almost all the functionality HMP could provide, so a separate
>>> standalone "HMP-like" console could be implemented on top of it.
>>
>> I'm in favor of the overall goal, but am reluctant to the amount of
>> CONFIG_HMP #ifdef'ry added. During the last years we changed our style
>> to link unreachable stubs, allowing easier code maintenance. Are we OK
>> to deviate in this case?
> 
> IMHO the right long term solution is for every HMP command impl to be
> moved into a separate file - many are already in separate files, just
> need to finish the job. Then the condition just becomes a meson.build
> rule instead of an #ifdef for everything except some code in monitor/
> directory. Until that's done, I think the #ifdef's are bearable as
> is.

We know the precedents of the QEMU project, "just need to finish the
job", as long as nobody commit to, well describes our usual half-way
unfinished conversions.

Again I'm not opposing to this series. At least we have a consensus
of what we expect at the end (long-term).

