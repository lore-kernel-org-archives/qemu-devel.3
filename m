Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FEDCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRBX-00084g-3j; Wed, 24 Jun 2026 13:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRBV-00084Q-9N
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:14:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRBT-0007Ag-Ha
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:14:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfJ4a3212213
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mG1RUsIFC0mynp5wL2ZQweud6oz4UfjuDxE2qX2MUn4=; b=LGDZqRck/HjcQcrQ
 CxzOhMkjlxLD3BVz6apqblwDBg1GeD3AXg6ipS6EpKimcR+MiLuPTXPNS+UG5t49
 +AnsnG06J/IcgCDarNJMPkyGbIadqUjFeLoFymh/Er00VhnmJNF0cgpLoJ/GXeov
 Ve5IjfQuiiCzUxdtNeIOiDHG0IydL+69uz0PVqlUiFuTS6PF9xYw6jOjFXEav65B
 Pzk+ee/t2FrPR/zL3gA3xKsmqotmLoALyL9fi7Kkv94IfYzS4edDDtER8O3I31vC
 EU9OARRZdgXh2+GddQ2119mgVIO6gjsQrPAFVQcYESfSdJ8dmjTP+Xx/TatkqqIu
 YP4vTg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d451sbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:14:40 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6751db2792dso476560137.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782321280; x=1782926080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mG1RUsIFC0mynp5wL2ZQweud6oz4UfjuDxE2qX2MUn4=;
 b=gZhVH2EAaBRO7s9TnVWDlsA157jSgjMLReP6BkYWhCTe8qmjnN3x8+N9gC6pVVbscA
 LLKRQb8t3xkQDtedjXUJRi7LO2JTCVuJQl81lNxSKk9ddm1SqrwVnzQG96w7Yfrx51WW
 vQ3Uf/izmmRE5/Ihi7n/xN1Gw8hOnWmyXsxmZn06mltkDyKswOCKJ/5E+N0CgxKVg/EZ
 u6mGC5TYchRs+zmF9z1sr1512X6hnKo7HOWtogcxrnd1H43cj0vgEoNC2Z21wpvLwC+y
 ROhML/rNTICOglD2lFMdiePaUgv5FoM8uERQjgLQZKkRQ9mnoyzboVo7scNvvDJHnsl9
 7EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321280; x=1782926080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mG1RUsIFC0mynp5wL2ZQweud6oz4UfjuDxE2qX2MUn4=;
 b=GG8tLYtRqgC1KJvEivmTYXsGaM7q/JDvuVC9RTe4IGwRQ9TDC2gfH4KO1XAadxAptF
 pICAw772lUp1lMU9YbeIdknUkaItnpLuNqG0P0qmu9bSlmtgvx+calw7AKpgrLHY1PZ1
 sYYAzdYnD3yXQiGsK232BRooGQyXL9qCiC6aCLvLzgeyA1Q2rdR/JT6h30wknbelvIpT
 x9MroEfZaKupPUrEtNwTvMIdbgN/wmNSl4TGqpCrcM7HMwBYlrHZXdRnx5YlwBkSEjU0
 ppG5lAWANBfKmKe5w7bNyHzl60LOXb4aZ4Nja+g5Nf5ier3DMu/mnzwcSecH/Z5gg/bC
 tZGQ==
X-Gm-Message-State: AOJu0YzsYAOteR6ovv9s6fyA1IQnQVTjkOTBgXYZuwv7jqbyLRMN3QnM
 OlA78DAUa7YZxU2lhzGgw9mmZ0AcVzZmGa62uCjPTVc0FunERpoAuBL7FAPgrRV9qUVRzMHsl2e
 24RZnAwphZEaBg6uqxNDx1hmNcMZgbG44OEYUlffno1jLxKrOfhGQuXnfUA==
X-Gm-Gg: AfdE7cmEUzHter0VmAR68zZgGFNxAZRXs5N3J8N9hnhvYTNcsjU4c+e+NkrdQumvMUB
 gRRPM8C1bPcnG9evrEHHgUDWdntYvbFBB+SZmM3g6QCb26uOwulH77J0HeF/g1D1P4umQlUQgjx
 tq6Iz2GgsPTUFG9KAcGXLDGCO3ZTBaOXjao6TOFZK2ZLFmrEqqDXJfd3gS1PWcU28KxNLZ9iN7J
 +QMTxXLh/tmgwN+VJkCbob5+RlDAWubl1anIYnUOyzUi4EbZuDM806pUYTqZVOvy98S5fuVCSZp
 92S8w7wpo8r4PZsh0TM5xtapJxa5/6ufc2W89dxggpqGqLHmORfI7AYK6QVsmSwFkQ825gd505W
 JWtcItcO/wTVGcu2PfiGR1QhU2Hjz3YWa2X0ifcgbDSgmgN2dqKxStOoCKltSYA==
X-Received: by 2002:a05:6102:5110:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-72fd816357cmr4919460137.28.1782321279698; 
 Wed, 24 Jun 2026 10:14:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5110:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-72fd816357cmr4919441137.28.1782321279235; 
 Wed, 24 Jun 2026 10:14:39 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9f240c3dsm5857305f8f.35.2026.06.24.10.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:14:38 -0700 (PDT)
Message-ID: <3fd7f80c-3a1e-49f6-b4f0-ed49e0691a74@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/35] accel/mshv: Add vCPU creation and execution loop
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-17-pbonzini@redhat.com>
 <CAFEAcA--=G3j=jDXvT-Afzk=Hbo_3y_6S6CwJRJynzN+ueydBQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA--=G3j=jDXvT-Afzk=Hbo_3y_6S6CwJRJynzN+ueydBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX92R47LUityE4
 IvO8QvFiy8L1FMNLkOlrf8M4QSBh3QMD8x2DgiifJ6mAGpO37PYIenBwNA1K3JBapL6JN6f7PfQ
 OUwfe9v0cHiNgKQ6g/kBokTpujclymE=
X-Proofpoint-GUID: SRLoeqDFDRxkVQDZLZJLSz4Pls1BTLyW
X-Authority-Analysis: v=2.4 cv=Ar7eGu9P c=1 sm=1 tr=0 ts=6a3c1080 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=lyaCTujlmcEqyUMKJsgA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: SRLoeqDFDRxkVQDZLZJLSz4Pls1BTLyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX2VEbPd5EWNgv
 oqn5HN7ZJCt6P4jZEVaco/qQqG28r0pL384+9LImips7f81hfOPFybavvx6BlbOFIx9WCBJMpkw
 FKzeutAF46MnwNom4bymogC97FKQSkKLE6QWUVAU2gpgUqKyPXXmWjnzQp51rvj8utI3R6pJhr3
 vND33szAUtbFUqITScVt2J0lPGTBboPE0sJ0ndyyEUbiWYa3y3ZTe1t0+iDcbx8mTG5gjeqQV7Z
 gBCC/ks0/YwIIu79PIrHpJtzNHqGS9/dJiHlCuCUVPiAH4lvMwGi8kTDAdifQ3xf5fmkvFLAqRe
 kj7+/AebbiJrKpeUnRV0GmwvulozDG5mbZJwickCNre++G45cThtFckk9W48WIZeU2uWRNkMPu7
 JH9a24t/OIk5/T1petBf4iVAL2a9gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 21/10/25 17:48, Peter Maydell wrote:
> On Thu, 9 Oct 2025 at 08:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>>
>> Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
>> Register the MSHV CPU execution loop loop with the QEMU accelerator
>> framework to enable guest code execution.
>>
>> The target/i386 functionality is still mostly stubbed out and will be
>> populated in a later commit in this series.
>>
>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20250916164847.77883-11-magnuskulke@linux.microsoft.com
>> [Fix g_free/g_clear_pointer confusion; rename qemu_wait_io_event;
>>   mshv.h/mshv_int.h split. - Paolo]
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> 
> 
> Hi; Coverity points out a problem with this code (CID 1641400):
> 
>>   static void mshv_start_vcpu_thread(CPUState *cpu)
>>   {
>> -    error_report("unimplemented");
>> -    abort();
>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
> 
> Here we create an array, which we don't initialize...
> 
>> +
>> +    cpu->thread = g_malloc0(sizeof(QemuThread));
>> +    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
>> +
>> +    qemu_cond_init(cpu->halt_cond);

These 3 fields are already initialized in cpu_common_initfn()
from hw/core/cpu-common.c.

>> +
>> +    trace_mshv_start_vcpu_thread(thread_name, cpu->cpu_index);
> 
> ...and here we tell the trace event to print the uninitialized
> array as a string, which will print garbage...
> 
>> +    qemu_thread_create(cpu->thread, thread_name, mshv_vcpu_thread, cpu,
>> +                       QEMU_THREAD_JOINABLE);
> 
> ...and we pass the uninitialized array to qemu_thread_create() too.
> 
> Something needs to init the array here :-)

This was fixed by 2cd3c1d35a0 ("accel/mshv: initialize thread name").

> 
>> +}
> 
> thanks
> -- PMM
> 


