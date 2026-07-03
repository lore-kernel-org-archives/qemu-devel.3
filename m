Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E74C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfUIB-00070Q-RP; Thu, 02 Jul 2026 23:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfUIA-00070B-IB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:10:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfUI6-0005xJ-JW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:10:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6632rZpf2633473
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 03:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4Y23W8xs/BGVitTuP83Bdm7xTIXD/fv5Rp4sk9E/ijU=; b=nERKnjnX/2uBG3OE
 Sdhm8rgX0l4CbpCS433lMoD2Vt6DlZYJw1rH6yUxaB4PwVs89NcvRt3CDJpLW6fa
 DhRnbGaBIuoJ2ZqLGVSW/o1hThJV0gBKUeHKZi1DeOFmaspcer5MAPiOGPTZKLit
 0bo4fyaa5K5BjgHZjQLKwJoRKiLbUsvidMWTe9FcjO42bpdLTi1JBJHo66reF/zd
 +BMw50/s3lORaA0ivMZ1NiKcbPL2mgoHiSCUkx5gKhPMKOTNct5b5rtwOe/a5riK
 cu2d3nc3hYv/yFB09LFHVft+3Y7MRplGdllaHdwqWeunj0hudCry0Za2MCj2ERwn
 GrcnOQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnj7gc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:10:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e538afe65so12289185a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783048207; x=1783653007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Y23W8xs/BGVitTuP83Bdm7xTIXD/fv5Rp4sk9E/ijU=;
 b=axqHreKJgF7FJZtV2eCj+e2kt7pzXmla7pIDGJZcQqqoLE82t4zz4wOnIKNpl71FVU
 ZvpIGlCRZGAGvUWSnXU6CKvYA3mTh5sevMb4tSPcFre0flOA/BMxHLpA6wZ8qr8e+630
 ZYra0grfAMp26kT1R68NpwRQ2L4rqvAPU3wlhCG0ZJ6Q6tRo6jK0WZvlinmZ/OcuPPSp
 r2fx4So9GMi4AeBKsQCYrqD3BRbpXFQvfC/rZuceu9H7RiXMuWJ1PbQwxoTpWgJkg7/8
 fXO+xUExZXfRTU+RkT/H5+2un2giFPvJ0frS7/YKz+JcOjqeqbjhFxMvpSWCgJphM//W
 QBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783048207; x=1783653007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Y23W8xs/BGVitTuP83Bdm7xTIXD/fv5Rp4sk9E/ijU=;
 b=M+gw0CcV5yL5lV8TI+UOW17axcKgCLgGIiQVWvgMtw60N7RDEHR5XuUO/ae40jJcjp
 AP8zZzDxeWrqp7ANzzEkoul95Ppn1LVSS4R4apZKO1Nh6CCTLqSWto3U+Z0fsy8srmHo
 eYNTuI/fyMZu8yDtW7J+uQf+SyXQwnDnzjZIbIUQpAVeOD4yWjrC5AM04Beu437GLL+v
 ikTP5tcfHgPiIuBbOB1PMFTyTAEqqaSFhvF++aM7JVneevCMbm7xg/nt0JhnE+IZTI8U
 fBFD5QmpITZizPB+Bgiqwh+SCnv2x3kWlFFdGkh7COkG7fyN036BQ/tj3klDIhiNcpyD
 ztZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8s8jVJs4JM+cwq8Ry/B9OQBKjrPC6AGcsVyVu7SuGnG/ILW43yTC8OSC2UMRvYuXntCSXwNlTQQz8m@nongnu.org
X-Gm-Message-State: AOJu0YzWQrvySMkH4eg+rM8IWRw5JaLky8clAQWuZdITHeFnAQJWmibE
 yheCB64OF6tbC8QPT+rEz3beUY7TrpLED8Ma0gVGbwTwcGXRE3eL4iyg1evco4MQmDskWyrHpTz
 HZsTgtE2BtR7mLhNUgTjlZL7zKEKg660fA8Kyd+b43wI35OM7meReGuF6ew==
X-Gm-Gg: AfdE7clKe13kzxwd7YE9rGyj0hPR4CTIfqDujNJtUOa3GYwVhknGc2WrVF4GilDI47g
 Eom2sBkcInXs3joBNCD3KPo+HIgrhtI/9/29VAvEZv1jFKTFe0N8Lwz306WoWyMAYnkC0fC/kE8
 6qFimzQ/NXmFUI0/SwMpwRwCWlmEgMo0kD4AU8WAz4eCRwk9OUzSviumCOtkmYe7hFJw36wtPRo
 n3510O55YPITjWpwyr7x/fbMaqjcR4zy4vfCkvTflZmHBkIP/65q9nVEqZFp6DuBMiy/oX5EJs1
 aS/9/3CpTtoKGbUyVbibA+B/pKpG4Ngf2lnpHgbYaK1Lcde7/C4rqz+cJU5xXaC9oFhQX36wt9I
 Vuw6V3yYyzhcc2vYLNZqnpWZJW2gqI0tpxQDLqqVCCcI4HDNAo+r3RzF2CsNtfA==
X-Received: by 2002:a05:620a:2851:b0:92e:52df:3523 with SMTP id
 af79cd13be357-92e781dc83emr1137917385a.8.1783048206961; 
 Thu, 02 Jul 2026 20:10:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2851:b0:92e:52df:3523 with SMTP id
 af79cd13be357-92e781dc83emr1137914285a.8.1783048206461; 
 Thu, 02 Jul 2026 20:10:06 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb01sm14042627f8f.1.2026.07.02.20.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 20:10:05 -0700 (PDT)
Message-ID: <d4a4c873-0c7f-4de3-98f7-882f74bfe151@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 05:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/24] target/riscv: move valid_vm_* satp arrays to
 cpu.c
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-13-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-13-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Oz8U-snkx_o_MpjgIP-5ZtaxaarOlnQW
X-Proofpoint-ORIG-GUID: Oz8U-snkx_o_MpjgIP-5ZtaxaarOlnQW
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a47280f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=msv8zyevykmUk-OaVhAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyNyBTYWx0ZWRfXwcGKDdkLOlSD
 RYEoe55r2pvd/EVFLEwRAlYrFDGxFYyDuQd4ZOajqwYpbCCBA3jfXTNwNxZC3GsvBR5D+MXDBnD
 rJga8sK8tc+eKdGufSHOGZz3lMW0noU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyNyBTYWx0ZWRfX5XogQE2/xRXD
 SK+NqxyG2EfZPBdFzHArvT7M4UwXnQiILm275cWbJ2TUwzw1wTj4fLB/5kPOvO5aWdsQ68LJ1gP
 /HX0vLRfYVrTuAUsmYt3xxszN0McCRR5ScVZH7e/z8XTpx67Nc5BBy3Q3zhgPVDDLYkBwMV+5Yj
 U0R2MRQFXFgUsU6FHhdQLLle1aHM7Ddd+TRnob2zMeH9ImAj3zMqR2laUyfKSNkMxvyKOxeiSlJ
 fM3yAkR1ZPx6dPfo3cXiHE2ZM9EfseMSlEfzvAW/MRfFiD92XDwe5A3gbmIGCDNGifKZpAJMwmP
 kDzTZwmDUxWCXSM1kBNf9dHtagNmVchMccZC4Yqa0rUNJRVpxkm5qR1reZgGZQA4BveDry4MJk4
 kquq9nxQwrZNxwl2ESYqdezVRcU5rqfmtM+HAo9c2VDQPFvT1xMvOi2eaetbWfqdamt2DJpdb37
 0Ua5N/NJu2c94AkG6aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030027
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

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> These arrays are used internally in tcg/csr.c and in cpu.c in the satp
> options logic, which is common for both KVM and TCG.
> 
> Move it to cpu.c to allow KVM to keep using it in --disable-tcg builds.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c     | 13 +++++++++++++
>   target/riscv/cpu.h     |  2 --
>   target/riscv/tcg/csr.c | 12 ------------
>   target/riscv/tcg/csr.h |  3 +++
>   4 files changed, 16 insertions(+), 14 deletions(-)

Preferrably before patch #2 "target/riscv: move TCG only files to tcg
subdir" if not too much trouble:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


