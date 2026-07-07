Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE50CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wguHm-0000mf-7w; Mon, 06 Jul 2026 21:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wguHk-0000mM-0B
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 21:07:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wguHi-00028B-Bd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 21:07:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEFVK1639584
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 01:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 njK1sbOGVR7m2TGLMIvgvFiXZsH6UhArBDFALHsIF6U=; b=PkVOC4LIuSENEEQT
 7iynpA/AbFgtX5UO7QG67w7g07/aquOlPur/SG1zsZ8YpJiFUJmalP96XuSBHxxQ
 Hgtgn33b+iyV1KkMunO63LaMNGmFPw2mco/H/4rL7Oq1VJXe6b5qd5f71pMCnzhH
 dxLvYdnV8ang8cd2IJTLAmbBTjxMUODqyA4oYpf8tRALN9q8OcKmItFP0YfMhFYb
 jGzUczzWOMNF6TuF01yROn/k+xMJV4EDEExL8oDBBtCXv8P0Qe1y2Tg5HIpWEVUD
 KAt3bLR+kVyYDYQUNCNu+96DI1QX5voss9E+6bl7cuOhrky31i6fyjFalBieWL5b
 b+KMsQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r3fdm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:07:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef8249f871so42388726d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 18:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783386454; x=1783991254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njK1sbOGVR7m2TGLMIvgvFiXZsH6UhArBDFALHsIF6U=;
 b=TNEbLC3mEdU+5JML6zNjijDPzqboMJxF4FwlL/5Fy2LG7kiTp14VEnH2adHpT+XETo
 zLEnH5i1FNJPp4Vkb2udZIEqdortoouqSM+f2SQY67ESMswGYVDaso3bODpFWUPWW4+4
 an5FHt43vrlkYItM6HRlJu6f+7agv55Ccnl3N7N7D3Y1k/a/gEOPeIs3WO9ZlmUOo5Xc
 71ye2uVMxY2S5aMdYlGPG8/0us7NXCuHxo1d0nFx7sQyzR8IbRfhzSo3ii5FMQnAl4SE
 u8CiaP+SLdO670CWb4+MT8ZLjtsa947+kjMIQql4snapwgFZZBBvy99Hf8L9+1OMkdFO
 P5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783386454; x=1783991254;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=njK1sbOGVR7m2TGLMIvgvFiXZsH6UhArBDFALHsIF6U=;
 b=UGdVFwwVdGuOrJW7/fml5ht8zU1+9+rnhv2aB2DfzP+4093qsHjWmO6hxTOKu5gAeQ
 +IYVRWRJuFSl6PpQby/4sIV/ZAfvnx2icAsRc1af4jRQRWJsy3YiX8iTaHkBk/8r7tlc
 x2H4NgIaSnW3g1xcEkEtXr3pm/ZHHNZ2SAZLiYdjY5LWLZ1rYJriNWdovPauQpgl9xPQ
 y/OP2zILhZNZiUhOmmqousL4eOMAImlYrXKqOtl3CAfEoRTXMyu+TYgwUIS5aU6s3yfD
 l9aaeyOc96CwnZRpuPSE9juj5F16CqRIXvJ1NelG2p2EQfkVo7l1Oyd5QBlHyDoSaBQK
 CkDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/QJuBT1PB40VDZIcuiciO25qfayJu7iaG9rVLszC2lPYNjkq8Tht0iEFVrdJb77P1w02qKUg53sPu@nongnu.org
X-Gm-Message-State: AOJu0YzHyQEsrdxUgPROAgAXO292zCFpK9QwtpkKg/VeQO+xsjZWMBoL
 oQ9KqY2vwspzPNyDlxPWdskIX9R3HbCHMv7NDLJQX1tFU5uFZFzAxq+rLMWFY6cXcGotwLPRoxs
 ob+0M7B3jGPta3BglJ8wY16Y/60tbjWVm3XdMBDJ11vfmGVltW1T0DvBsNw==
X-Gm-Gg: AfdE7cnGVOW8oenJNajXPVbxqtQGpjCjVqU1vkMzO8k44/93q7FaoTaYUJxi+NK27B+
 WTbl1qGXefTLVIZNpriC7XAhBxCM07A+3VU5O9yut49mTV34TGeCQwWGDkx3/VHPi5LYi6+EBNv
 n4/LrJvd5PKMjIVRYVpys2XuGI2N/LwwqJJZYFK5R3orL+6yLhgdj5DTr3oGQDcV6fViSQ1eb9M
 BzmXoURjm1nvrdnleHLEYNfK7etR5Vuijr5OFc0JyBk1WBiJZqB6J0U2jxM7PBbAb+2di++rIXv
 8OO0p+LSaaxX5kUQVTr5Y+GxsXmm1QgB3qAnGSJ9jSolU7haNLYuBlyo6+RL0ku/fWU6RdrN8xu
 bydsOrNRedvj1g9HrYTP5HsXeK0UVPEvhdSUblkWIbnLF
X-Received: by 2002:a05:620a:44c8:b0:92e:c116:bf0a with SMTP id
 af79cd13be357-92ec116c46fmr61098185a.83.1783386453843; 
 Mon, 06 Jul 2026 18:07:33 -0700 (PDT)
X-Received: by 2002:a05:620a:44c8:b0:92e:c116:bf0a with SMTP id
 af79cd13be357-92ec116c46fmr61094485a.83.1783386453258; 
 Mon, 06 Jul 2026 18:07:33 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ba7e62sm1075120785a.13.2026.07.06.18.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 18:07:32 -0700 (PDT)
Message-ID: <57f674f1-3587-433a-9962-ca0ed0b37f4c@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 22:07:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260706161716.29488-1-bin.meng@processmission.com>
 <30d89c41-c290-4eee-8e38-df1924e26281@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <30d89c41-c290-4eee-8e38-df1924e26281@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAwNyBTYWx0ZWRfXxyZGySGgheVX
 El/PV5CICq+D291It498yCtephfAS7sYGKTLynvvRmpQX5eKSGot/wfmOCzCBK3o0Odf+qbB9hV
 IGc6PoJZBZ3dvKg/7InD8rv+zKVO0dcg4LKRCUXQytxZ5Oe8oACFG7WTev6iR31wVkkVPtS6Yy5
 lfkznOjiygc3YmrFk6O6tMD2sfv7sOy+FLIVmMC7ir6Fjspk+dRZqux+7A2Myv9Y1KplHhkFL9O
 x029/8egFZRMQKVp7GIPOAwHJEi+VnQzYcB2pSMyLzbK4lxezIhPjVgoFZ/CQqxkgQzIdLaNb1A
 WY8kaV8vqATOq4xx1++gxkb6hawoqG4OMglGe4grMt0a+yBJC2WXYUH9809v+KwGCyHis6LvLHv
 y2DuNRCbGpVP8foE1q8fogE6S7LoTRY9mM4ETB39JR7hzdijtaQzPMl26LTY2AMGfvUOK8BSFeX
 y0myqnMYtzqFV9DHNYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAwNyBTYWx0ZWRfX0m6AKl4YZki7
 fV52nOA7oPU9LvQzdQLD7DxlhuOVdXHnrVZSCS8kA0vrb2aKdn8QjPJZgYyAcD5l3DEYYxDM8Q1
 gv48QGoh/pLS6+ik+hcSF5jUdwKoDR4=
X-Proofpoint-GUID: 31ReSQFW_Ztcq4BXStNwqtYKcpbvuXb7
X-Proofpoint-ORIG-GUID: 31ReSQFW_Ztcq4BXStNwqtYKcpbvuXb7
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c5156 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=XZq0DVb9exJvLu23xBoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/6/2026 6:08 PM, Pierrick Bouvier wrote:
> On 7/6/2026 9:17 AM, Bin Meng wrote:
>> The OpenSBI firmware build job follows the same pattern as the EDK2 job
>> [1] that was removed earlier [2]: it exists to produce firmware binaries
>> from CI artifacts, but those outputs are not consumed by the tree.
>>
>> Remove the job definition and its project include to avoid maintaining
>> bitrotting container and firmware build logic.
>>
>> [1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries")
>> [2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries")
>>
>> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>>
>> ---
>>
>>   MAINTAINERS                     |  2 -
>>   .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
>>   .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
>>   .gitlab-ci.d/qemu-project.yml   |  1 -
>>   4 files changed, 125 deletions(-)
>>   delete mode 100644 .gitlab-ci.d/opensbi.yml
>>   delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile
>>
> 
> All good on my side, but let's check with official maintainer and
> reviewer for this file to make sure it's ok.
> 
> @Alistair, @Daniel, are you ok with this removal?

Checking the git log for opensbi.yml this is the most recent commit:

commit 83aa1baa069c8f77aa9f7d9adfdeb11d90bdf78d
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Mon Mar 4 13:16:50 2024 -0500

     gitlab-ci: add manual job to run Coverity

     Add a job that can be run, either manually or on a schedule, to upload
     a build to Coverity Scan.  The job uses the run-coverity-scan script
     in multiple phases of check, download tools and upload, in order to
     avoid both wasting time (skip everything if you are above the upload
     quota) and avoid filling the log with the progress of downloading
     the tools.

     The job is intended to run on a scheduled pipeline run, and scheduled
     runs will not get any other job.  It requires two variables to be in
     GitLab CI, COVERITY_TOKEN and COVERITY_EMAIL.  Those are already set up
     in qemu-project's configuration as protected and masked variables.


I'm not sure what's the actual impact of removing the OpenSBI job would have with
this Coverity usage.  Maybe we don't really care about Coverity downloading and using
opensbi for whatever Coverity must do and we can remove the job anyway.  I would like
to hear from Alistair and the others about the possible impact first though.


Also, this opensbi job has been around since 2020 and Phil's commit that removed
the EDK2 job is dated 2023.  I'd think that Phil would remove this opensbi job along
the EDK2 job if the criteria was the same, and yet this job is still here.  Maybe
there's some lore behind it ... Phil, do you remember this stuff?


Thanks,
Daniel



> 
> Regards,
> Pierrick


