Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31A5C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfkqw-0007PU-Te; Fri, 03 Jul 2026 16:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfkqv-0007Od-5C
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 16:51:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfkqt-0001PX-Nh
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 16:51:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPONu1005346
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 20:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qQKdqllXVGL1/6Q9AIZ6gYBRgsnjea/46bn0eA8JvRg=; b=c1Gp/ivHvO8H5Oce
 dACfV7RavWU7A3dUInD3Gu0RcSt8K/BpAmP0BNt6K78xMOJ7MyHdbXe+ZVrAEFfj
 Cq8q+s8BpXUmOZUsb4ahEQHg7JGke4EKS85aaROMtfjoPxMBfbB9DOT1vngkZl5j
 gp1cLAHFRY9KMl/8FhE8S3a2rhnsgr0TODXqvXIDbwptO7m3eiTBN1cS2DIel3ZP
 z71ZW3tmZZDNzBHOgEDD7sjegNZF0K8UsQp9ALrmrPeoHeuNlFx8Q8pkQgpKbfMB
 gX+cCJtVyRsRKUfzS3C/8/5f2HNk7XLR0PQslBJ3AAuUZ3N0pfSNBa2k9Zt5eXYg
 LxBJKQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eycmvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 20:51:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f113592bf3so14835476d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783111869; x=1783716669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qQKdqllXVGL1/6Q9AIZ6gYBRgsnjea/46bn0eA8JvRg=;
 b=ZXVL2RZy6nQ10QRveXjNvZeVaT6oMg+5ccM2jEir/K/kCPw7RaGlF50YMwhNUOlj0G
 Qfae/ibFIBKzbpa1yXkWe6j/0sGJOfU/Fbe2h/xq7/90/VXCQ1gO8HFMWmMeITUFcAG4
 49Bx531069mZYk0wXcohMAn3phTVKkUbw3ULE5jKwleQAEgvN+3WMJ+8kul4r51G1R0T
 OiIIKzyOEL1Zpt95duHy33DE8NTFUgPd9xcw3uvET2ydro4bnoDpWzdQnmPAIckx6N4I
 Y/hQSoiSzHdswNdLNVAuhD/TU5Xd9H6YSGCD4QIjIAzBAqEmaVNWnGDM1Pkd8v+4Jytt
 5Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111869; x=1783716669;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQKdqllXVGL1/6Q9AIZ6gYBRgsnjea/46bn0eA8JvRg=;
 b=iSQeZCWlD3T05pJsz5mjKFDuSJap0NM/IZ/DW68UwrnhDy2t7BEEOXpzgjmw4bdJiB
 g/VnnSW6svCSp1GyhOMhCjq6fGQS/a/WRIYOeyl844X0kv5vypeArfkYufwtd8jTCI9D
 75+8bnRfwXhbHxtNrr7o8CDi9kFBXE7TaMqvOmxcNIOvk6VNtWAJb+OCt7/PLF/pQ+CZ
 E+4cPjO/k/qC3lagQ63by34dJ2E4NZc3RI9oEu8y203roEpVTRoksuZvc6ygKOLQIgM6
 cbxGz9Kyxh6tGfQwHpOml9AjRzIvQ0x9veXi8DlCPVyKOAKXFmu3ZMgQYi2A4pBZC2x4
 RVCg==
X-Gm-Message-State: AOJu0YwcjhpifHfQHbiQsIbKZhwG4JewA0L09VI8dTapmgZJhrtrEoqv
 TPsGBtHjDxbJbO2FH5bAZ5rP1QG1fjeJCZ35lMcCCAWw6CUbhIe5kou+L2NGVIGxZIGOrANFFvk
 xDXvzVdc1PXS8LVvl0n/N1cpMJzi4MA3oocXiFA4jWODBJCPp9hTd8fegGA==
X-Gm-Gg: AfdE7cm++wHHnkXkrhmdW7/n9QejqQxrlf3FLkDJUKOJFuFRoe7WhjHFSWGl4pEnzFB
 GE4IIRVX4AvExznPORIyHllEcu8G6O6WSpzaBv0L9zi80Pg0a1iXFiDDkXBojMQwaR24GfSvypr
 WFJpkQOAMvO2Wqigs+bca83ok2Rl/iRc8eT/JtIY7DmuGWeex6ESYBQHc4bz7lQgdZRmLMWwgET
 ZCb2fYFwEqqCZaYlEiwKtfMTEVgtAM0YYWheltqk3vAqqFoTngwDUenBCHVvuNz6PpdYqbHK7Cc
 NsXxV0kHqpGOH4f0CKmWmR2nZwz0Cvy0JzxnQnkLXE32TFUVockoZgP0zFJlhlVUKtl7liqTPbW
 3Rl74Cpk3OUgig6VjEPRHuu+f/qqKZQiXa08pZQWPUNPC
X-Received: by 2002:a05:6214:5990:b0:8f3:e0ce:6119 with SMTP id
 6a1803df08f44-8f74a41fccbmr12714846d6.21.1783111869039; 
 Fri, 03 Jul 2026 13:51:09 -0700 (PDT)
X-Received: by 2002:a05:6214:5990:b0:8f3:e0ce:6119 with SMTP id
 6a1803df08f44-8f74a41fccbmr12714416d6.21.1783111868642; 
 Fri, 03 Jul 2026 13:51:08 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4724bab15sm62991286d6.43.2026.07.03.13.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 13:51:07 -0700 (PDT)
Message-ID: <35f0175c-712a-459f-ac37-6264c8b35622@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 17:51:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] tests/functional/riscv64: add riscv-server-ref TPM
 selftest
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
 <CACPK8XcDX+x3MFLG+XRJVTrocVugoRio06DUsOLJPLA4D4MqnQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACPK8XcDX+x3MFLG+XRJVTrocVugoRio06DUsOLJPLA4D4MqnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIxMCBTYWx0ZWRfX3fA5BwhUCG8S
 iLC917qY2dZc0dASCjazQP+Bk0C7cjHjjfz8FHMsFWEW+mgiigCJeK02aNdhaC9B2UTbf5KRn4x
 t+1LYRbS19EO/3XG4dosDRM9diWVdZZBSwdF0/BnRkuacfYSPUiEPGJAqqVYya5TNXZTBKlcD+h
 Tw7k2AoZwL9a6FRxbBlVzwRUlj4c+dw9tnbBCIaosw9N29jhWAWnX/vTwyswVm9IcqjbmKVz+hR
 54k7lN/Mgrpv1VZtXyqc0NFVoonnUUGw6yXhfNHFiVTzpABqXfC9GghIfZkl3xyhCCjcsXDcXyn
 3XTLQRerOBE6zW9++6IslP0qpHpmXL9KudGjWBv/x/naPmxVHTEXBXOtXNKzGp0vZC1torQlmj5
 s2/A1/aWE0XVSxMjZvqTDCy+fiGcL4vykhnduTPQgHedcjLq6BmBdl/zEMuAQ2UAoian3NsuZ0N
 H4YAkx6rBhkp+xeopdA==
X-Proofpoint-GUID: hhIhTFzhuVmX8VDotaq5JULH3CJvtHnd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIxMCBTYWx0ZWRfX5hIHNFB0/JG/
 FrPMwGRQHvjBCcg6l/wG8Ky1Uh/9J1EeYsMC7TC40YBAH1H4V/lji1SBPqLhPabuR0Ogv9SblPs
 4agYOz4vcRT2P2hUDx87DIVm6Xia2Po=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a4820bd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9RM9ceTOgqm5Tjxv2ZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: hhIhTFzhuVmX8VDotaq5JULH3CJvtHnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030210
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 7/1/2026 2:31 AM, Joel Stanley wrote:
> On Thu, 11 Jun 2026 at 07:11, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> Add a TPM specific selftest for the riscv-server-ref board.  The test
>> will be skipped if there's no 'swtpm' in the host.
>>
>> The test has been basically cloned from our Aspeed ast2600 friends.
>> Shoutout to monsieur Cédric Le Goater for the code.
> 
> *cough*


Guess there's more people to shoutout in v9 :)


Daniel

> 
>   > commit c3d58a7a26ffbf2ac54ed6d7a3a83f2a7af7159b
>   > Author: Joel Stanley <joel@jms.id.au>
>   > Date:   Tue Mar 28 22:38:44 2023
>   >
>   >    tests/avocado/aspeed: Add TPM TIS I2C test
> 
> :D
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>


