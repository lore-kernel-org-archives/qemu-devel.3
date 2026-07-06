Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8069C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdYd-000321-Pm; Mon, 06 Jul 2026 03:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdYB-0002sJ-7G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:15:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdY9-0005jV-MX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:15:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641cmu3470529
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gi1Fij25IF/BxMQiriyDCprMGPns3iZg0M4nzWB6P7c=; b=jGx+dCZlxrXAtNCC
 vXg+2PBP25iGhfwPMxI6q0lQN2WeWW6hQAk4AT4bS4M0WlTYsRWfMg59uTvPsPtO
 eEvjeRla/ReP07fhvAE8YKz/2ZUWIMr0bin9JxDuHY80xMbtrOqYDx5a7TSfr5cW
 lvZllBOp92bzhGul3uKY3VdBOaopU05zBP/G2vGojgRKwgNM5A7HFvf25C6h58F/
 Ev2IAD/a+BtyhKPDuzUXj0r0n6JliwpkpLzCMIAwCLZbu/I+2HqKJnodT+HyjwC4
 GO5YdGpjOmm7bYajGeXqOXqWL7bb6ytcd7pQ0ExlWyTCuUIhJyY7fNMX7vyltHZP
 x1eCyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txemv29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:15:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e632390d2so517076985a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783322127; x=1783926927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gi1Fij25IF/BxMQiriyDCprMGPns3iZg0M4nzWB6P7c=;
 b=OwxxC10sc5up5FKtMEtBY6eQ89bYn0zAuMtdvBDTZEeNv2f09j7aJTymFISUxnPizx
 2qw0aSa5V+5nqtGoxtZtzyMUjSHKQ5BvADCoXPaifKli4Z2I2HOIXgLZ+4cYhfGegW6W
 iPDXItW/t8PTkpAAGW3wb9kvuf4smRm6JVXV6WQ9PyY8Ytu5eQkx697fecfEm1l+Ypqo
 J3WVSIrAJSMUvsitPkiJGyS9/KEqP+dfUP7EyBs5QWA58/bCyp5j4P++qWIN2OMyQsZg
 30SvdAxj57daP0N6KUFs5lBtXGCC9hNU6vc/KAKh1TeBv3jABF4Rt4MXHnUp4OUP/wyW
 qb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783322127; x=1783926927;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gi1Fij25IF/BxMQiriyDCprMGPns3iZg0M4nzWB6P7c=;
 b=C7JZ1FnolwJbQtjwdOWif3ufVUdN2EKbvT8xPdY4DTrAg2AG8PTKYtOo0CZ6r33HxS
 6C883oS/eQ5Ct/ezJeBxhgJ7cNgffvAmL1OqhaHYVspD4kpSfjIT3YpBpHGItEb7IgNO
 gQEbQr9KrvEssVZ+/4XrJI2fEelR8nVUOWhzr9rdU8l6VKZ1cBXkK5TjV/3k7ZulQHDK
 31JmESeRBP2DsV3H2wHbyoxMfYxFtFG3m8uZOytgkhqMMvMxwnyuBFi17A85qGZSKBKW
 pgLxjmCIa1y2nqQXdFBLvF5oIO75edFW+04CLpYxZD2ZkSjQaSOP8sOElh/a6nlmVJyu
 TRrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqi4wUsbGok3qcc5M10vUCCOq+3g3L9BDbgaw9r2cFyIGdqjvhpzeNcKwkBSXcJN11RUK+6nv7QuHwu@nongnu.org
X-Gm-Message-State: AOJu0YxjLzEA3tUxEhjfeePB1PQmEdLa/GL0Dq2vnRG2BKp4Wu7JihHT
 F8TF8z7j66YZpwp3hmqA2o2M0S24RUgnU/tcdSJNRLLwsMURwwZqXUTcT+HyJ+kgrrCgkru2YR/
 EKpAznRg0C1LQJTiK6iPR5qAnEHQYSjE0TbRZtwFhKF4e3Y/zFT+Mj/+JOg==
X-Gm-Gg: AfdE7cmOuONRV3Wnul6aRhFdezAJ74i5kkQUQBCzS8GAXR+zglpmm9b6KWrNlOUNvsv
 2Ld41FnOre7iQxtFHH0BcLmImEuPtRqpa8CRdr2XzH3thzabBv0K5ELVdHkobzW/DZGiP99Qxjn
 Gkr401wxUOEVqRwhN9COLfk1x0m1757nI+MGxPTHF/ciYpivgBzHVg2qOst+E+KnWBswiNKsPTj
 tWNae6uG12POnFmWgqb1BVofUeIpCs4XqfSiGTeybBKUbl3vIps3LyUAn3xxnwf8g7HcbDRoNAx
 QaqacIN89ermzrKx5AR9kxC+UfWCFM85ZCraX0I718KKv6CGuG7YhSrQCp4o519tbBKXal3F2w+
 zUxaKrTebLMtlgPhXvy3s0MXA3j1oGixnSV0cft7SBZ1a58Ta0SuJcQwmXu18HA==
X-Received: by 2002:a05:620a:45a5:b0:92e:71bb:d1ac with SMTP id
 af79cd13be357-92e9a34e02emr1235094785a.19.1783322126822; 
 Mon, 06 Jul 2026 00:15:26 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:92e:71bb:d1ac with SMTP id
 af79cd13be357-92e9a34e02emr1235091785a.19.1783322126401; 
 Mon, 06 Jul 2026 00:15:26 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b60f5e1asm658250666b.27.2026.07.06.00.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:15:25 -0700 (PDT)
Message-ID: <1306c52d-f4d2-4277-a190-ab452c089df0@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] hw/rtc/mc146818rtc.c: convert date from object prop
 to class prop
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-6-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703090814.2993188-6-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfXyEgVmsc7g418
 052h3lMKfticxk56NrwWExJi+Tp3/8LXgAhvMFwYt178EP9gTg8CGkwAADh54NEyhJMw+9Z0KsV
 cnc1eumEUNoYdAPyFL6WkuB4lF71vAo=
X-Proofpoint-GUID: E_dqZwqbnBMn-cny3DOIKBOS5XZ4K-cB
X-Proofpoint-ORIG-GUID: E_dqZwqbnBMn-cny3DOIKBOS5XZ4K-cB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX7LtjqDFhu87S
 9MwYQayuTWwvtm53f95/k8pWzIgMtWk0Cni5ukqAjxCjNx2zC8T+yxlSQLk8DPvdM8+T6PFSrid
 PEEcZOMaEuzhRMrbIkoMK20AiDgQ4iQqlCyd11GAm7s9QO0ATQ6aqcJYmjH0N5ver/N4VHayfFc
 a9yOPHu4lCa9QgegA9jd8pVcnbSmDMJyBJUdun0bnuYF50X2i48u92PNKbf+VKgI8QstK4Xe0tV
 MknxGQSzCkbKBDxMDD/4ip5TM4eAi/T5PvVMTqFS1HXJOMCq6XHIzdCwCPF4cv26uigYS43+MM0
 938gFd+spwT2HiMRKjpgP8H9xvwEBbwKVX7PbEkg/dOBrokRR8JXdbaTrXNpljHzhHHeC19o1hY
 tB1FbidcpFzrTUFegjfy4rxZeUav5ryzgaWgOO4SdylEZI5ZoIdz57PkmJ6wKb5UYzglCz3hyyJ
 WpZFrpDepBnPG6MpsGg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b560f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060071
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

On 3/7/26 11:07, Mark Cave-Ayland wrote:
> This is to allow it to be the target of a class alias property.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/rtc/mc146818rtc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

