Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12CAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whptD-00082b-Ga; Thu, 09 Jul 2026 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whptC-00082K-2l
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:38:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whptA-0001To-3k
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:38:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Dw2Cj2063297
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 14:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t0vt0IpxdmQLlLHWsraDoNLJxuWv/SQG14WLuuPNofY=; b=a2T4HNSngAKvUORq
 lNhyNvw5Hc1mHkgnJ/OZDQTZVjURK6Lwef1zR7BZDSe8czeQjzQLy2tXRpb+heSy
 pOf0H3HmTjE57YXUb/myNaN9P/ocvyENetMo0FqcD8uAA2q+hmddQU/BpuNy+jww
 XJXAir1ImMt+g+YRqU+LokQ+maThrVoKxKE6OBPb4MNnwEYhOAK0xPDtn5mojTAZ
 Z/A9vMG9sPiYjbRIkN8CMTOAopwJqSUuYfzl/YKEjgtJNS3/Dub22Yx0yJD4szig
 p0eSpskdTmvWL+F0Zj10msjhyOrnwV6MNrM6C2OmAg4OS/9BPrq9jXreZBzc4SU8
 llyIHw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vvdpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:38:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0e702df8so12570761cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783607884; x=1784212684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t0vt0IpxdmQLlLHWsraDoNLJxuWv/SQG14WLuuPNofY=;
 b=WDvKAbzimmKNJ709C3uHrj62zz+wp/Yt+k8IPrCIGpR9pjjKFXbyUqpZ+3wBL0hSV4
 kop19RXvn8aFNjF5uP7UXTG+5LOOXwxs0Ps0NcUVC4VFX/1r/IWiqHVGE97xA8zJQx4m
 DqfZcM8Rgp15xcONluH1FQ49f+TZ2kcoCOzxBKFVrSa7AeeaCQJbHq3GZocn16L5ivAM
 gSBLXztt8zQVHWRy7lXBf3eg/Y5Rz/IeL8kewvt2O5nNPvOrXXOv9GYmtEvWkl8mbiu2
 NlFoc06/YZ4SnKtjDeZirvjiWaO6pbD7uMM5sb4qCgfSNj/ningy4rYDEm972/tDcSB+
 CcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607884; x=1784212684;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t0vt0IpxdmQLlLHWsraDoNLJxuWv/SQG14WLuuPNofY=;
 b=UjoL5FDQ+0JYRixLKLclCDZ80rDggUvHqewzM0KOqwVHJKScdE2hLgnq7qKCI9RWyZ
 5/T7QmYhmfI49sdDCgq4b3/qnqeVDItY/2bLO2zUzhX6Ko7/BRpIhzquWBtf9U4cO7xo
 5882b/83APofjT3w+YUvbYlZ7S/xWYcvW2J2dCoE9Ya8AxvCwiGoQ2DB7nSkXp/xaOUK
 KGGP2RJIquu/f89JjEyKv5PpJn1+h7Q9SdRszHJHqyDYntkpK7hK4Dc1Y0wt5n0m7YV/
 9AVtmL5tHO7UToXRV0hesnZCccPXfNEdL5nIx1saW3+J4sQ4cPRTw37h6chn2EFY8k52
 Qf9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYH+KFtpo3xaUR9q4z5CtA9q0MYz9Lc/hre/qQNl+bW+j6GIZuMzO0ET5WlkEvc/2zyg4/wi3BN9Ap@nongnu.org
X-Gm-Message-State: AOJu0Yz6f2wcS/MIicnguQnaYFSlNf1k4VcGLuPvPqnaoaTRqV+QSf0K
 dwY1ULNc6SB49TRaAajxcUgDJTq7njK2GNJyqCLN8ZaqnSHCqpRMxl5nDGokhYi18tAqDxEMO3f
 iNKLKMDzOKnE9c58ZXE959365Az2rxS8ARINJlIQ7WRRoIi/b6ACN+4mqRg==
X-Gm-Gg: AfdE7ckspAMnPhym7qJFXV2R6RHKDdQBFPgl7wXKf9SwM2PO0rXhwNO15D3iRTn/xaG
 FNI0e2GHDJwT7qrqduxDeX+nI9WH6IbXkBcB5QBHy5Oo0wB27oAOTKcsrN/Adk1L+jqBLCQ0Z0z
 YpmKsVTSYJdz80exG4FlBmH/mQKXUh2H9lCPFjO5/QR/dRcvaVL/GXJdysXEpsVApmRarfGSoOz
 NPwMq+mjari9Io7fjkVx7MH6dfYNRhBDXy0S/j1B3DDwqxudnc/jdWT6j1TI+nsHsB4XEcjI03j
 f2KEjr+z0UIVgR7GwfiUXOvwRF5QXonOUGb5NLiL1deYY35k/irx2/IlioH+5tjE9ab3anoWFhI
 VDwpvH16DIDVabbYToTsqZROrvOAzsNhgb/sMi9EstUN2KTKNKsRjBe3HJpSNXw==
X-Received: by 2002:ac8:5ad6:0:b0:517:7b6c:445b with SMTP id
 d75a77b69052e-51c8b2dbfa0mr92311321cf.20.1783607884170; 
 Thu, 09 Jul 2026 07:38:04 -0700 (PDT)
X-Received: by 2002:ac8:5ad6:0:b0:517:7b6c:445b with SMTP id
 d75a77b69052e-51c8b2dbfa0mr92310761cf.20.1783607883476; 
 Thu, 09 Jul 2026 07:38:03 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm52787352f8f.22.2026.07.09.07.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:38:02 -0700 (PDT)
Message-ID: <7c843730-3b1e-4c26-a567-af0bb2e3d747@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 16:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260706161716.29488-1-bin.meng@processmission.com>
 <30d89c41-c290-4eee-8e38-df1924e26281@oss.qualcomm.com>
 <57f674f1-3587-433a-9962-ca0ed0b37f4c@oss.qualcomm.com>
 <CAKmqyKN8zR0Q_BzRv1fp_Knx3kKEEiKKD-AvWsR6G9qwttG_mw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAKmqyKN8zR0Q_BzRv1fp_Knx3kKEEiKKD-AvWsR6G9qwttG_mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: phlJyUXUwexDPiFOS7tgLydtF69OGIiW
X-Proofpoint-ORIG-GUID: phlJyUXUwexDPiFOS7tgLydtF69OGIiW
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4fb24e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=S56xvJB5AAAA:8
 a=JF9118EUAAAA:8 a=She8_dmg9geX4Irrky8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=MH9Ivq0PDQRhlrFuIVvX:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NCBTYWx0ZWRfX5Z++IP7r9/t6
 56BlSOqH4W6M6Q0YjaRnv72aQO1ky8jeCH9bpHx09nVq9+3PwNtB5+qPQMhyPXY4w1iutq1U8uP
 Ff3jyV/I7llXdVo+Lc/jFjPkX+6X5hwIUvAlydcMXpEf+KOcyXIec8eSHDPZQmzAj/jQbwMvf9z
 v0MDbtfZQTt9yBCc7HKCGC2wz44Zderk7ecrYo2OQYFKuc7ZwRzgjjp7LDv4RSSQv7YAWUTuv/R
 Dwg4kRO6puJKxULStCrEYD9FJPVCvP4Q1xCvR8xD4ukLyapWcJeU5dJ6mYjkkYDZ3DUrU6yWARe
 zHhUxTr/cE4tTExon/IpiW0ty9Srsg9+U/vHWzH4qO1ow5ekBndTAU7Rh4eYBhElC1w2YpTSddX
 yjZ7FTgNDor9eHCJMBAm4AUVHUkJuHlYq5Hm7zBuBqyNkRyVqnTpNxn5t6isuFvc2cLp9wHGC88
 rRCOqkrHlf3+kFHuRjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NCBTYWx0ZWRfXwXzwZfwrjtic
 gB93fU0bPyWMw7eaxYIN2dAM8RE260NWJuW7CVC80TYmbz4IkEfwtWI8kTx7fF21hB+iYgKTZrw
 PEZ11Y9Zq70MSDmUd++r5yvY/xubZ3c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090144
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

On 9/7/26 07:07, Alistair Francis wrote:
> On Tue, Jul 7, 2026 at 11:08 AM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 7/6/2026 6:08 PM, Pierrick Bouvier wrote:
>>> On 7/6/2026 9:17 AM, Bin Meng wrote:
>>>> The OpenSBI firmware build job follows the same pattern as the EDK2 job
>>>> [1] that was removed earlier [2]: it exists to produce firmware binaries
>>>> from CI artifacts, but those outputs are not consumed by the tree.
>>>>
>>>> Remove the job definition and its project include to avoid maintaining
>>>> bitrotting container and firmware build logic.
>>>>
>>>> [1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries")
>>>> [2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries")
>>>>
>>>> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>>>>
>>>> ---
>>>>
>>>>    MAINTAINERS                     |  2 -
>>>>    .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
>>>>    .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
>>>>    .gitlab-ci.d/qemu-project.yml   |  1 -
>>>>    4 files changed, 125 deletions(-)
>>>>    delete mode 100644 .gitlab-ci.d/opensbi.yml
>>>>    delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile
>>>>
>>>
>>> All good on my side, but let's check with official maintainer and
>>> reviewer for this file to make sure it's ok.
>>>
>>> @Alistair, @Daniel, are you ok with this removal?
>>
>> Checking the git log for opensbi.yml this is the most recent commit:
>>
>> commit 83aa1baa069c8f77aa9f7d9adfdeb11d90bdf78d
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Mon Mar 4 13:16:50 2024 -0500
>>
>>       gitlab-ci: add manual job to run Coverity
>>
>>       Add a job that can be run, either manually or on a schedule, to upload
>>       a build to Coverity Scan.  The job uses the run-coverity-scan script
>>       in multiple phases of check, download tools and upload, in order to
>>       avoid both wasting time (skip everything if you are above the upload
>>       quota) and avoid filling the log with the progress of downloading
>>       the tools.
>>
>>       The job is intended to run on a scheduled pipeline run, and scheduled
>>       runs will not get any other job.  It requires two variables to be in
>>       GitLab CI, COVERITY_TOKEN and COVERITY_EMAIL.  Those are already set up
>>       in qemu-project's configuration as protected and masked variables.
>>
>>
>> I'm not sure what's the actual impact of removing the OpenSBI job would have with
>> this Coverity usage.  Maybe we don't really care about Coverity downloading and using
>> opensbi for whatever Coverity must do and we can remove the job anyway.  I would like
>> to hear from Alistair and the others about the possible impact first though.
> 
> I don't have any insight. I didn't even realise we were doing this as
> part of the CI.
> 
>>
>>
>> Also, this opensbi job has been around since 2020 and Phil's commit that removed
>> the EDK2 job is dated 2023.  I'd think that Phil would remove this opensbi job along
>> the EDK2 job if the criteria was the same, and yet this job is still here.  Maybe
>> there's some lore behind it ... Phil, do you remember this stuff?
> 
> Phil reviewed this change, and the commit that removed EDK2 support says:
> 
> commit 690ceb71936f9037f6e11580709e26b62d83c17c
> Author: Philippe Mathieu-Daudé <philmd@mailo.com>
> Date:   Fri Mar 10 14:32:47 2023 +0100
> 
>     gitlab-ci: Remove job building EDK2 firmware binaries
> 
>     When we introduced this Gitlab-CI job in commit 71920809ce
>     ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries"),
>     the naive plan was to have reproducible binaries by downloading
>     what this job would build, testing it and eventually committing
>     it. With retrospective, nothing happened 3 years later and this
>     job is just bitrotting:
> 
> 
> So I think we are ok to remove this:

Yes, thanks you!

> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Alistair
> 


