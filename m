Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E803EC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvbw7-0004Ti-98; Sun, 16 Aug 2026 10:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvbvQ-0004N1-8l
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:33:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvbvN-0007VM-DF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:33:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkgmN4142832
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3HDSbiw8tbY5KIqeNkfRvaH7a9AIKkJr4VtI09fSd3g=; b=Lr64bsMzGCHVMec9
 BAMa9/HM5wnBjwkaslhVoOaKlfzp9Kyje3ohY00zwFA3FHKvESPLGGjpk7VYhM8r
 g7eWb+IT2BLCNbtUKK220R8GZf6erRq+cLeJ+MaTHFkAILLvvzNBpYseOQWJMS3c
 XdP5qZPriPxc3BvJEDtDNvFJwE31zue1KiQJYU4V2KQlArBg8CYHIxgxolJ/RwCL
 iolz6Ub1K7IQOpQzgiRu+MfVBcSSs/ZIHqEwyO4aq8Of9A4lSlZr9WpeOoalfsGL
 jeRuk08cqiQDeIRibsyb/07+qn2kfqvsgVfXmYqjPCbPBduwqv6zdhamr5gZ2f2Y
 YPMeKA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwkjs5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:33:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so269645185a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786890797; x=1787495597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3HDSbiw8tbY5KIqeNkfRvaH7a9AIKkJr4VtI09fSd3g=;
 b=dfJi6y2u+9mEeMYoWpVUueD3QgSDVJ6ryjuQUunTWPe7EPoltlyF39wFDthn3DrOwo
 0uXNGYykKLiRvapN4OVD7kbmRhIEBQkz8pPLicW0mooVX0SF0NOpgE5lBSHcSNz6eGag
 Tn3XYnmzcvKjX3jSpI3jf+pVv2C9cPciQJfopRa/emyz9CU6KKESVgrFOduqiHFxy5XX
 4AH53N2U8YxEphpRn1I74B0euXbmCEbhfNJBtvMoKdm/Ll6DA/eky3dIhTHVMS6LAbm4
 A+JdAlr51ZBrqRJ4H+BFmwO4XjpgmZQP/UkorIJ5E04veWV50J6E8LOcUxWlYfjttkB3
 IOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786890797; x=1787495597;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3HDSbiw8tbY5KIqeNkfRvaH7a9AIKkJr4VtI09fSd3g=;
 b=aHLpfzQkfReZyoLbTQmtthWu9aa3BXUlBPc8BjXsotR7Go9sjWXgmIlvc0cnqaRVhI
 oZdQ6XoLNXgxVPueA/HtKUHlLbH/ZvfC5j/FF3Wv53balovDPXduZv5RdSPlKDAE/Q9w
 81P0K8qtbKaC8ENiGFnvcAW2btcnpSs0MqKxuIkajgSUBeKiXd5xXV7PzsP5tkwGakmb
 2jIozf+B9qZ5Y5wC4E2G0sOo5QDYH4ogltDE29vvJJzCGlGDlaP/yJvlt+jus6J1atb6
 bO2mQkq+6rvy8k0zxbBBeEWZhfsbxriAP5Fte/lQQ/WBWzgsz0f61xj+c5pQ666ch/Nh
 ATzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJtzR1vI+yMNxPFiCHuKCnRutGeXts1p7VqcJaTWCjy8u/IQkmK63iFCe/aAcktBeToVUJDpcr12Y/@nongnu.org
X-Gm-Message-State: AOJu0YyxXOeQLqOhyX63TfHBEyPE92qWJY1o8Lq9g10JpImnMw0ooArz
 ObZSkpDK78kvWHSDV9eL8acxbvrmpmcCQzHrKcjqEh0MVorJ17rZ2BqiLgJqla0HQIH8b6wOAQE
 sDbg+VD/lZhy+hHOf6nrKQtzt5WW1evzBsP1dVeobOciAFjs+4jXT6rY6zA==
X-Gm-Gg: AR+sD1109JIssauxuVje0wFDuJKtluP1kjg/U0OjdDAr7LCYaWcjshVdqXV85c2xU+/
 GKe4B2HI5IADtat/vgxe9AkLxdV35E4dMuHoA6rBh6kcAeikPIn2Xtlj9ZLUMSoEUyPSWbwjjro
 zzUltL/UC3FHYc7sqLs/JZHuHBPvZ+VAlA76fSqGI20lsQas+5BWhqvruTk8vzjg57IwFBABokK
 ob9qoqrtK98dizDi7cZPU6SIne7uIlTv3iIFnQP/ozB99mHNdQiKTs+KSA4oyFs4Vc5TZdtbF32
 K/6IeHD3M/82ZoXH86VziouaEMv2c0BdhO884Bxa29XsDv+/yGI0UtsXJ3j0QO9MM0mUrJMruft
 XQgfgWfINutCreF6oDe6v70jgkgjXtw/8m8k=
X-Received: by 2002:a05:620a:318c:b0:92a:bbf6:717e with SMTP id
 af79cd13be357-936d2399727mr1820415285a.34.1786890797214; 
 Sun, 16 Aug 2026 07:33:17 -0700 (PDT)
X-Received: by 2002:a05:620a:318c:b0:92a:bbf6:717e with SMTP id
 af79cd13be357-936d2399727mr1820408285a.34.1786890796776; 
 Sun, 16 Aug 2026 07:33:16 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f1fff25sm40286001f8f.3.2026.08.16.07.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 07:33:15 -0700 (PDT)
Message-ID: <f36cd135-4e58-4929-8491-40d4c2c5a82a@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 16:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 00/15] qdev: Clarify and enforce the device
 realization lifecycle
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <b8ea980a-dff4-44ef-83ee-6cc1402a313a@oss.qualcomm.com>
In-Reply-To: <b8ea980a-dff4-44ef-83ee-6cc1402a313a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2gCpxgn2wGSDm5ErDr0U3-J-c0-0UPjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExNiBTYWx0ZWRfX5K+BPIvdiJPD
 7IIxYtdGA50ZqPDXBenucNiy9+CHXSWO8WiqEs3/8YH87UJIHO2dXC5A2Ge9krDAeFQa3+VhszE
 zVyLf3wEX7XL2Bv5IPXaO/Bi4I4Y1JiqVylv8IwtS4ASCI3tjQqngCEMxZ8EmCK+QvhNZ6XEIle
 m7YBHOR88Zwpg2Ns7+5XK98vZz/zpHUWJPb/0+7J+kcNzJ0SlcTB04TRNyA3YlSKUnHXORrfEPj
 IOv+CyDVXfeyLjAsUi+DDfKeQm0xjsi0apI8bmyI8T+d/6QwtDPmstbr+OIkk1sz4no202mP6Iv
 jmQnJ33lDZib6jZisnut8Bq6QZ3iXXjvL4Npp9hKXlkHiYeSxNVGvYbXxlkdYC4PXy/Y+Fabjif
 8py9xsxSPzZU2tD3dcrlVN5PtHecWe0wXE7lcZ/XLpmbdV0+MIUIhfbi/5+MhOZtWc2oIPcnc9V
 d5gJdpfJFP9EY/lSWfw==
X-Proofpoint-GUID: 2gCpxgn2wGSDm5ErDr0U3-J-c0-0UPjF
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a81ca2e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=3Hgab9GNqnbXk1otUC4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExNiBTYWx0ZWRfX6D6U7fQVTrkP
 Ybk9YDKMo0vm2lgpYn/cgaFkwgbSZxwW7jUMyWKLHpNZuRKoMB7KDDVddiKZ4FFbceBz6QiZ9xM
 CcHmVaLsvu/Sx3G7rb5/ZZszdwQaodg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 15/8/26 15:59, Philippe Mathieu-DaudÃ© wrote:
> On 21/7/26 10:16, Akihiko Odaki wrote:
> 
>> ---
>> Akihiko Odaki (15):
>>        qdev: Clarify instantiation and realization
>>        qdev: Make qdev_is_realized() take a const DeviceState *
>>        hw/hyperv/balloon: Use qdev_is_realized()
>>        hw/intc/apic: Use qdev_is_realized()
>>        hw/mem/memory-device: Use qdev_is_realized()
>>        hw/mem/pc-dimm: Use qdev_is_realized()
>>        hw/nvram: Use qdev_is_realized()
>>        hw/ppc/pnv_xscom: Use qdev_is_realized()
>>        hw/vfio: Use qdev_is_realized()
>>        hw/virtio/virtio-mem: Use qdev_is_realized()
>>        hw/virtio/virtio-qmp: Use qdev_is_realized()
>>        target/i386/cpu: Use qdev_is_realized()
>>        target/s390x: Use qdev_is_realized()
>>        hw/qdev: Parent device before setting parent bus
> 
> First 14 non-controvesial patches queued.

I'm dropping the 1st patch which isn't reviewed.

> Waiting for Igor or
> Michael to comment on the last one.
> 
>>        hw/qdev: Prevent devices from being realized more than once
> 


