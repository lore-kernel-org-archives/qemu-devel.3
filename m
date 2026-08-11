Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B0C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrPj-00064x-MI; Tue, 11 Aug 2026 14:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wtrPe-00063X-KA; Tue, 11 Aug 2026 14:41:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wtrPd-0004NS-1v; Tue, 11 Aug 2026 14:41:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGWAOf4030562; Tue, 11 Aug 2026 18:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9VG7P+
 CQOguh05w45yRNPBURVeiRQ8LiSfTiMGRh4GE=; b=FZIPKkZ+DTNqG9Q+2Eq9OX
 rXp+xzp0OjGutqGBIsn5wmZz/rZLCWpD5ae5dbU7h0uMDFHDSq4BnXQcBIZUMetD
 NNgfcH1sGHIOiKIEAqFGnS+3507Ry0HtUBY29nozkLqEg5RIRa59pVH2x5Z3b4Wo
 +CbiIn1tyeiIP1Lhg2WiG3HqlCa/JN/QVopC3LjSH3l/8TvjHEPYMA9S3w3fJJe2
 0VUBKU2u8c9Q7a5+GrrDFcnxW1rkwI8Rdvo94Or7E2h1GOkujc53Xc3phLIM+5SO
 3JPtK/HC7yRLNnKWtA8rcX3f20sck8MUnM4tpjx8Soq+vBqTTfWzvWoAskii3JMQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23q6u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 18:41:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIQJfL004985;
 Tue, 11 Aug 2026 18:41:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w2cq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 18:41:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BIfDxM51839468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 18:41:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDDC558056;
 Tue, 11 Aug 2026 18:41:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B40458060;
 Tue, 11 Aug 2026 18:41:12 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 18:41:12 +0000 (GMT)
Message-ID: <1d4cf0e9-343a-4ff1-82bf-da62762e57ce@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:41:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] s390x/pci: Implement migration for emulated
 devices
To: Farhan Ali <alifm@linux.ibm.com>, Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-15-kshk@linux.ibm.com>
 <d4ee50cf-df97-48ee-9b5f-81de236b2451@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <d4ee50cf-df97-48ee-9b5f-81de236b2451@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b6ccb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pYRAxXQWIqJiDwhGll0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX5dEvcKuoqN4a
 ZDzwd6l54AjIV/SMOgzgtDQEVMICpik2DRaGkvEo+Xcn70wTpGJnIpW9RdrbcZ722IlELwPaC47
 jP4CgB/X0Y9m7YrBKtd2WsqEHleXLuB6tIzlm0xI96pCVtxeUH8p/g+p8HA4FWnBXCsxR+7oGCC
 FXXaWeaWhqyw9gOy93MyrW17yj1MeoXJIaG8g0VOxMaXyd3AORug+zEuWNGT5Tk91aAvdLzIMH0
 O4OWB8R0/oe0azqxUxEiD4mimp5/5kfXSEGh/vZpcHMP0cmPeatadti6XQqsAJoCeGS930bkcKG
 u+9KM1J276VftvovrwnswFwOUOIU/h0cWnWuxjly8FC4Aste/AwlLn9I2pEO/QYzaP77whlKAqc
 4WK8/q5Af615vY9caj2jRKp6TdWM2TfDzxvJffDYV8isUaYfXp29Fx8hY8/4VgTnLlaohL62aLI
 YXJrxNM7gnzYHzMsyIQ==
X-Proofpoint-ORIG-GUID: M3VytupeOvbgQbtPsvoXo_hVdeQZUbSO
X-Proofpoint-GUID: M3VytupeOvbgQbtPsvoXo_hVdeQZUbSO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXx2xWHsuozj0R
 Ri1I7jIuLwxi3DiBclxJvwaVSJFM30uoa4SWXs1vyy+OjpkPU7oVFcYDK2m72U67y/o+rGtmYm0
 NTtYZzB8cpGepS6JMxrbLV5ZqhJ+w+E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


>> +static void s390_clear_emul_dev_migration_blocker(S390PCIBusDevice
>> *pbdev,
>> +        S390pciState *s)
> 
> I don't think we need to pass the S390pciState here, as it's not used
> anymore. So we should remove it and update the callsites.
> 
> With this fixed
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

I haven't reviewed this version yet, but don't forget that you will also
need to move the fence to virtio-11.2


