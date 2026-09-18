Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AAFC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7RGQ-0002sv-Jh; Fri, 18 Sep 2026 01:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7RGO-0002rr-6X; Fri, 18 Sep 2026 01:35:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7RGM-00034f-JQ; Fri, 18 Sep 2026 01:35:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2VX0a3075100; Fri, 18 Sep 2026 05:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R/tObM
 dPnqcjYv9m92JnOMzj6RsGuL2UY9n+SnHqDwc=; b=JXt7f0+KyClDCd1f/Tx5Mv
 i7lvV1a+RdKyHaykukPAWiiQ/yE7gZzbeE4DyB305BuhcFSCkW0MnnjEOoQcPgeA
 W92TLumQhq9wB6L/yOpHZcUXslHd13R9Sp+VUlTNn0EUo0CI3Oxnns156bieMNy0
 PjzQMwvQolHWyE8dj8JhSvJOQRdBUPdl0eo/Yrdj4DHS//YhRvs+fVMv1aTx2SyP
 iDCS9usq49Ttw5WHcvLzB7dXRYZ0/h8j7UgvPwpcksfnkn3KLgUsxdygVXdC4Ra1
 QBanVKQKdTuSXDRdevAPP2g/w77vpH58yQHfvuIAxv9qcaRmQAIHVDWjMkJK2QWg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5edxd6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:35:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2Z6vO4128832; Fri, 18 Sep 2026 05:35:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fd0ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:35:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68I5Zlmw47055196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 05:35:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CBE420040;
 Fri, 18 Sep 2026 05:35:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DB9A20043;
 Fri, 18 Sep 2026 05:35:44 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Sep 2026 05:35:44 +0000 (GMT)
Message-ID: <0e473522-653e-4d61-8821-04c817525e38@linux.ibm.com>
Date: Fri, 18 Sep 2026 11:05:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-3-nnmlinux@linux.ibm.com>
 <09af11cb-e455-4a9a-83ce-e0ee037663e7@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <09af11cb-e455-4a9a-83ce-e0ee037663e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA3MiBTYWx0ZWRfX/E7SwTtB3/vh
 biWMmDbK7ETqMJ+l0++r0SwdKkLct3BmqEuTOv4ImtlBJc47wZSijI84WzQXSyn9fEHTp4SkPJD
 QR5h3UF2b5AsTOVnru4O1xUBA6HQGEtHmyY110H22ewQ3Vgn67ZubtrPbCT6eSUpVZvbQzHN0Ja
 7La7uCRdgbRKoYGc5PT9Xn6dKipNky8vWfstthr3zXE9I5ew/sEEnEP/ZaT4Th1s2pN3BXfvsej
 7NUaImIfZImXJuSfiKpAMGB5evZPdvt0IozPAsrbBVm368COM31flpUpHizM1vrHlK07s+weu3E
 TcwBDa1ZjCvZzgWn2ZJ5GdQqb4eQMlV6liJdxwZvreendqniLWxDLLAylW5RuFE083BDQW7pPYY
 o20du8CDFKgbIMdZ6nzG7IWmvCu7z82hzCCCL9P8dJ+SVOGxoQ5Usl3ckaMCdGI83XaQig3rXqv
 KT0xBFTT0aao58bPu6Q==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaccdb9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=kcPs2TLnwEEoCKfdxjwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Dq1FS_kFcQXOa7LlLvr_jKgAWh363bQS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA3MiBTYWx0ZWRfX0JMGUidcH9oQ
 SdqkqgPndLin4XAhlDWgVS2jArd8nYOb46GTLg6KCgr/pF4KiEPjeF/3EOemvqtN/eDP9wRunlC
 MJGOo2zPoByX1/kJEA4o2+kIvAGxpaw=
X-Proofpoint-GUID: TgzsSN03goNvrzsdBuXGGTFf41j0MdV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180072
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Nikhil,
Thank for valuable comments,

On 17/09/26 11:21 PM, Nikhil Kumar Singh wrote:
> 
> 
> On 01/09/26 23:11, Narayana Murty N wrote:
>> +    switch (type) {
>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
>> +        is_64bit = (type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64);
>> +        ret = spapr_errinjct_parse_ioa_bus_error(param_buf, is_64bit,
>> +                                                 &addr, &mask,
>> +                                                 &config_addr, &buid, 
>> &func);
>> +        if (ret != RTAS_OUT_SUCCESS) {
>> +            goto param_error_exit;
>> +        }
>> +        break;
>> +
>> +    case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
>> +    case RTAS_ERR_TYPE_CORRUPTED_PAGE:
>> +    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
>> +    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
>> +    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
>> +    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
>> +    case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
>> +    case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
>> +        spapr_errinjct_return_non_ioa_unsupported(rets);
>> +        return;
>> +
>> +    default:
>> +        goto param_error_exit;
>> +    }
> 
> Hi Narayana,
> 
> In Patch 1, you defined full suite of RTAS error types in enum 
> rtas_err_type. However, the switch (type) statement in 
> rtas_ibm_errinjct() only handles a subset of them. The omitted types 
> fall to the default case and jump to param_error_exit. But they are not 
> wrong params, they are just not supported by QEMU. This is just a nit, 
> as I can see in grep that both RTAS_OUT_PARAM_ERROR and 
> RTAS_OUT_NOT_SUPPORTED map to -3 value, but it would be good for code 
> clarity to explicitly route these valid-but-unimplemented types to the 
> unsupported path and not PARAM_ERROR, as this explicitly signals to 
> future readers that these are valid PAPR tokens lacking a QEMU 
> implementation, rather than invalid parameters.
> 
As I mentioned in the commit message the non-IOA errors has no way to
resolve the PE without buid or config_addr, but current VFIO ABI is not
allowing to forward it to host via VFIO. So we are returning it as
not supported. Next ABI revision or iommufd may include on need basis.

Regards,
Narayana Murty N

> Rest the patch looks good to me. My above mentioned concern is not a 
> blocker. Feel free to add my tag:
> 
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> 
> Thanks & Regards
> ~ Nikhil


