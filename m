Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DEC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgywH-0002Eb-2g; Tue, 07 Jul 2026 02:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgywF-0002E6-H7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:05:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgywE-0007H4-4P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:05:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66748dBV2585197
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FPIW61/cO0Dpkh5SI8hVbO3UJVS8WHNYdYuhsnqeHPk=; b=WcpODZodShq+r31w
 P8MuAkShCY6zQm+lY3fQeM078dk+XI2pzOGnbGahHZf8xaqA9zp161js5WeGKiq6
 30p6hDdh7et/Ca1mzZ4KBdHV4RX5tsUcz7GsPpQn1iZ5wIsGYJ1CvXCftBntVQjt
 aXXs0BYhzyin0wna7ddJmjq61upK1X/sSY0EV+s6cm6XBSX/2EZs5qAd7aT8fLR8
 QmpqAaxILAHvsRWB7sEs8bBore26NTJ/rJiXb7eY9dWI6iDdtToVYQ1TvEjs5e1g
 mIl85D6aDP6m6W1mQfnI2XE6Wjtv916BeJtw1k1QjVRmaGXcu+0S6aAfJzVIxBi4
 KfpstA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t158d7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:05:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so47032211cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783404344; x=1784009144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPIW61/cO0Dpkh5SI8hVbO3UJVS8WHNYdYuhsnqeHPk=;
 b=XBATdDpipNSDgzjeCWTdFgu0xl3MHPQW0bd2eA/q1EgYBHHBZFv6cpwHzv7vrd4QUY
 61hnYrgaff7c94qdWhcr19oEiCiL28d40Pf18z+Dw3WSgj1LdrdPmPZxzMMJLtLA3tM5
 UkU8niW/GZORz9etsaMAvumu1dj0qWYfFXAOygg3wtj9YdwByC2oISuY80iI3AUR4e5g
 HdYqsWtFFcT5c3GIyqurAExNDu6nhu/s8lEbER+3DmkiolTja0tCQNncS2hKyv9Gvu7w
 WdkXCW9K6O9UJ7Ji0WpR2e//OB1/qpa/Vtbo/ss0Db6oxyh4gI45AJFDwPg2HbznWhdX
 nbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783404344; x=1784009144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPIW61/cO0Dpkh5SI8hVbO3UJVS8WHNYdYuhsnqeHPk=;
 b=bcoHTpdUuDCwv12yNjkWhEZnZLCoQcuH1xVhOrAiKA45Whf1Dly++Wmvvgtqqj8rny
 77J9xExVRUl5qDqSSlpnrsAmAF2qVvZbxQ6nApTftvyIDC0LhZ5YiYXQ8NKEvYKjikGH
 p+AQAoi+aNQJcEvtj2K5+cafMk5tdf6MuiaX+HQ1UwkmkdgjN1+azYk82U3KAe+O1ryZ
 kSkbN6JnLN+6KhubWpX3VFiUMTN3XLImQfM7s0P13guJmthANY4sOGdOrRZElwo81u5s
 raq/7ZF7HwPquX9g5mHhX4Y+WHFHfauGzKR+C+vEwdrt/3YLw1zLgONvNRjmZzacsT3k
 pfRQ==
X-Gm-Message-State: AOJu0Yw5BNNXiz9QpQ/nCeTIMsJKhNvf7XpgmzWfX0DP6OwGjP3g0R81
 r7Sq5cnjotTmdsZVdxN8LgEH+JEGMh7fYDzsPqllzrB1++CxEgvEFOVfDI66JQ1GGvIPauVQHs3
 Ynmzpphjhj1lgqVzjNldwRLPvA5i0pqG52+hTs/cGAs84EYTEfyTqZE2hIw==
X-Gm-Gg: AfdE7cnCQCxRWHxTsy4uPprxxk6DVj1U/mAaCOkkR5S5ydQmqxdGwj8+AVa2k13/bxO
 fhOBifVEADKnT+B//lGsYk8pVCNE9pBtuLWyxb23hzgz2y7R5HvjmvDFCsyN/ulYU/RA6sU+zR8
 Fdc9/sRJpMxc7W2LyxUQ76o+mvSQBLJIdPLVsuWjuW6FC8k4PE0e0hRSO/+PR1O/XaVm9dOnOjK
 yXAi5Nl18FhqhZz+6T9O2qB3+Ipp6GLKwwekv3beVhxZGHi8wT46+EclHd4UXBElWoNhnYWWOrR
 91AByRkUw9dbVJqNuIJlPjE1pKLdNUrjxjEGlzJvrQJtkIYLs3tyfHqsQn3x7Wb8yDW0Ela511q
 /ogXX4jMsELGRqZO6eXm22pWH1pf0uZj6RhC24AkcjM4r2gjavYjVrBhKpRr8/g==
X-Received: by 2002:a05:622a:548:b0:517:8011:3a4d with SMTP id
 d75a77b69052e-51c747bda6amr43252061cf.20.1783404343935; 
 Mon, 06 Jul 2026 23:05:43 -0700 (PDT)
X-Received: by 2002:a05:622a:548:b0:517:8011:3a4d with SMTP id
 d75a77b69052e-51c747bda6amr43251681cf.20.1783404343486; 
 Mon, 06 Jul 2026 23:05:43 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6da9sm30108007f8f.12.2026.07.06.23.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:05:42 -0700 (PDT)
Message-ID: <4ab0c28e-2feb-4f3f-8d28-4b04a7b8291b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390x/sclp: reject invalid write event data headers
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-2-borntraeger@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706091909.864405-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sUaGF-FYeZSxQU7R2dztp_1SKnAfAdcd
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4c9738 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: sUaGF-FYeZSxQU7R2dztp_1SKnAfAdcd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX0TDV6bn26RB5
 22BtYUqxcr/87ScrhqnzxOIqGp/aWyt6UKEqBKz9EVztn2kaszfQConeOnUC03Jl89r0+GJk+BH
 j9OJ+5k6Xi/TfR+pcpyRu7MVpCt7Ab4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX2CSCxmN6y7Z5
 7UFKfvDqxh/Q0trH/W7EiwaKwnvnYlG315Ou5rg6Z/j7wwOH2A6VBztREFty9Nbe6b0l3RAmaPp
 dIOwvvmaQyklUbtD27Co4efkoffCXC63tcmItnAUYxR+aix4b6NbpgmJzIYpK3JvZXGnRBPExM6
 +59U+jyNv8m6XCUTOHqb+5cx2zZ8UNFiVuI+QGdEjuWCt9lWG5OsosvXEgmscCC0z4CGsj/rw8m
 5hx2zxmaC7jkHICxOXffu9oYFTAzOYa4gL4AcKK+RcuwACG3onCAILdZ6NAmg20t03QqbvPeE+9
 M2OQ9B31ipugt5wi8Kq+c/RaCyF3LdgSjJ8oclnago23wK3TvLI7DmHkRNu1KDJxBlCrGMZBOBe
 hrlq6nN5R422kqifgHS/csmv9KijQI3kH8WIPACEeeW0EvAcUpZSMPTpl9V/gWsVStyf2JKKdfE
 cxkU03n658Tu32Ie/2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070054
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

On 6/7/26 11:19, Christian Borntraeger wrote:
> If a guest submits an sccb with a tiny header length but a large number
> of event mask entries, the write_event_mask handler will
> 1. return the wrong RC (ok instead of error)
> 2. write to memory after the allocated sccb in qemu host memory.
> 
> Add the necessary checks.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   hw/s390x/event-facility.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

