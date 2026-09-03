Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DFFC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24at-00073K-Cr; Thu, 03 Sep 2026 06:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ar-00072p-Lu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:22:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24aq-0002Cl-7x
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:22:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHApn212400
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FLkmTnTJNnJ1pqU8C8sWBAXKc9hssqfQEsnbZ9luEXw=; b=IvVTj6Ih0S9mAKio
 pRgUe/p5XG2lGuXfGCW8fisU6D3GvLjhlV+jH9M0t95P9Br4anXbjFSOMnHjnu6C
 KJJjnmqEzeVGK/L/hPLM7waCp2FEYR1Ivpoj4arL0d4hKJxiVQlTxeA5k1SI30KC
 PUHrHYSnqrerGi2lh+nPKb5Zm58VJSVoQrmjI02hSaljnaMKC3cjTEadJ6Ogl9W/
 THd2CjJX/8Yw2pyLkVJQvtpRJ5Pt+rkQgEA6itEg2iDF6XVaiCc0YSo6RdZv4JFP
 gpY+VrqPogYsCtPxpCCUXbBuZN+dqMp9ndCYnB8O9bArZGgxvZIawRb1b73xhFz6
 CP68Ng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhdvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:22:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9394ad7f64aso425164385a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788430970; x=1789035770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FLkmTnTJNnJ1pqU8C8sWBAXKc9hssqfQEsnbZ9luEXw=;
 b=AJqgIF6NIOUFKJ0j2Ro+e9DhJnOZtQpPDM8iZ9YKZsaxX0hFynZTwMSku17xiqXMrV
 m4grVVx0ZqGr4+lZD5cflELeOa6zl6Lj6wUIi+k+D0Jw2DFkDUjOuZvPpPK8zUkvl5dr
 EG6UoLa2eJxWmKhXHuD6t/F54/CB/KrY8b7veaY5DLRokQY9pywL87h+EJoQ7b+GH2+y
 cCemDmjCvKhtmjs2KaRYVtpFNYH3ue50EF+3UtAX3XUofK3vANI0DuqSuEmKDgMzHqks
 yZEAnrSVBaLDKAeLMcHKqscumkjx5aQ4W6C49C+fC8Q8/gM4+RLPpCa4N7jpwMVWXPCB
 q25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788430970; x=1789035770;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLkmTnTJNnJ1pqU8C8sWBAXKc9hssqfQEsnbZ9luEXw=;
 b=PBvY0eTtqU765bQLKa03/2axta48exzJXSpFo7uhtZ5R75x6uezI54uPl9eJTIQCTg
 29wfBiJmx4ruchmoLtmbRjpD4ODZzJX+qNrCIbaATIpmn/ZM7hQLGnsfS1G3iixs0eJg
 w5zW76DQQYgp4h6vRRE4wfJJ7EK0wBEZUi31DssDsxVopWwQhF88O2RtiRoJktiVPV6T
 RqrUgHTXYtU2VpZIFkO5d3ECZGYaD1lWF/mZBXD9flC5LGUAcXKKUVs2SPKQ3VzxVle8
 sOxbzlQxQ8mUcZEFzOwg/OhmJ7m6BXo8yMOrzVnB/en48cFeYavuZ3EaeyUTZyzdUNNm
 DZHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6lVGuC6acYiI8AA4OeBJG7/rSIvJvPvgjNXhdhehBESbgdwvE1jN3GVP5656v1zjFLXlNIDsK4Pmm@nongnu.org
X-Gm-Message-State: AFuF++ladi1OoSAN3OaiEWGQe0OTtrjDKbC6rsh2ohpVy5bbRW5Wembh
 M82docAetBe4EQn3yEL60mcQQsRCja32s8f8ywchpqEMTaD6fSEWb00ite/GVirP/4KZCyO/zNp
 Db/2ygwgh29edWfKZk8pw6uBm4S95bApsv+hfN5JDmMZFlQB4dqRfZjmeREVb16PEGA==
X-Gm-Gg: AYBFou0MgTqwufIXKk00I65gRNyvrPijTEp72EDoIOIz35IDKjorboiTSIHpbEgfWmQ
 LIDJHLIzVvk47AV+GAJ8UU7O/zSBr5eTR70ZO9K6rFewxKBPlRnEBDbAkxLersYuOld+CzgXsKb
 ByBCT9z9JpRymLVEhQs9bZqLmtaTuYmp+Y43XX2g/zUorm4tHJFed08ABh+9oC/q0htr/aBLPG/
 r9uWT+RUUPIimSYR2U37mjE46M6j2nZJCy/4+fqbrIhcI/7e4+qEdnJ5RlvMG83sOxyxYOGiY3X
 1Oljn6nM3CuDm8DPtE3xi4N8e+cKoms90pRbhqQCfiOiMIznYjnHRx3TTLEqdUFkvsx3a2hZ+rL
 Y13B51OrQ9WORWHkY7h7g41qRUSJkQfqpaw==
X-Received: by 2002:a05:620a:458d:b0:939:2670:befd with SMTP id
 af79cd13be357-93960ef5137mr1121038585a.26.1788430969993; 
 Thu, 03 Sep 2026 03:22:49 -0700 (PDT)
X-Received: by 2002:a05:620a:458d:b0:939:2670:befd with SMTP id
 af79cd13be357-93960ef5137mr1121036285a.26.1788430969637; 
 Thu, 03 Sep 2026 03:22:49 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea468sm13472933f8f.26.2026.09.03.03.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:22:48 -0700 (PDT)
Message-ID: <21a9aac1-9d8f-4ea3-9481-e30c4e227543@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] system: improve -mon deprecation warning
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260902104753.1756783-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260902104753.1756783-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX+CHg8rZtuFPY
 91Ercr15x3F9l1hEEIR0jS8wWUs+h542cw+jIyxoBHpziervRaCrjcaWZ2yoiMlRdoAT/52AFQp
 qtIZcQVPYgpDvvvEO4LCfBccDlixge5IDlAVZOPD2LaIOmXxor8hGHHLwqTLLT9AAZY+EGBbwEv
 AnnYlRy174BS/ROEbVnAbhze1xoCsYFetnNsFsJwa0MuhVAsJ9Yr0AGNclcjg7rD9WJOSO57EKh
 gfm4duVGgz4SKNZ2e2eP14S1pyd0Tytsw67pfC9w1aL6vR77awW1UagW3FwYEQHcO9AFd+rL3/B
 x6SJUsI1ITqfE0KJko7AFXeWKseYmLA99AfLaeTI+bPr/gmkksM14utm7qFDW7hK7DIuHPdtQZy
 KblTvR8xrdxthOHHDB5JT4QqEfm4S+w3RcTu7xzUukIbxv2uja+tGWjBBlAhlETS0kaHKDhgavk
 xVUqPtUdJQyYWkGNM7g==
X-Proofpoint-ORIG-GUID: SQIyToOo1HuzCDMKppqg1rnDDYqPsFFN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX6UUpzFwrIKxg
 CvZtnv/LbrM+THbx+i8D3VoWsoj3PxWcBVYCN9Z3S12Wz20nYQMPTZm9v/vLHZr19NpIJeyffDM
 mrQMak9tglt2rsboIP0pB5hLrn2EcnM=
X-Proofpoint-GUID: SQIyToOo1HuzCDMKppqg1rnDDYqPsFFN
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994a7a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=37_ryM90h0hU_yZE2KgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030089
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

On 2/9/26 12:47, Daniel P. BerrangÃ© wrote:
> Expand the text a bit to make the new syntax more explicit and point
> users to the man page for further info.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   system/vl.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Patch queued, thanks.

