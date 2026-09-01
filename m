Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09964C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KWz-0006BD-Ce; Tue, 01 Sep 2026 05:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1KWx-00069e-Tl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:11:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1KWw-00011N-FV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:11:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179Lip1709609
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 liET7VlXAaJMypwOWE3rZTmvtv8D0JCY1IBRxnul5t0=; b=StQ7NfkKMJA1epFr
 QknOqfgw1ddWxeIP3G0Qch8kVT6L3OnBtA4SQQJBpwLBXPpzYeEG4Sgxy3pqN8oi
 DFsrW18+LFQMLhPI3Eq+/PUx9/tBWT/j4q2A7qMd/FJSv/4VEQuDd+ulE53nozs8
 XNIhRLav0ZIVEeBLl68Ku+Jh9aGK+cbAWhnDP3+L3LYr1tDqQqGQmv35DD/BoNBl
 NBtftKFJQ5MQcIevs5feWtE0G4DDof3e9AnxBheuBIzWHmdd/iq3gdETw2dx2f92
 MhXt7yMgjWA2rc+4ganbjz1PyoVC6r8dgdc+sRDHYJIFawQsMX/rnSxKOfP4U0oq
 Cia21A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp8fsfhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:11:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9375d92d8cdso825655985a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788253901; x=1788858701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=liET7VlXAaJMypwOWE3rZTmvtv8D0JCY1IBRxnul5t0=;
 b=GMIhNK/bOCJ6Z13ua/kqK+XnJABpQDw3Ajl8QxnN9L9rNkeleP0uqyeAvMppfQJNBe
 9ukRVdSnMasjDTKfuvfydqt/6DxAwNbaK66BULbz3qtJ7wqzUU/h+4CTYJ8sWJmp5RvQ
 0Rqplqh7JqLcc2MfDaUMxdbo0jAEinPtc9OFwL4ZgWZqwLrdjTVWkP6R8zSP9iAoiWS8
 DXsXhiihP/WejXx/4Jyfp+2w1jnSMRveUgk0YSl2KkYZEujsTqCZbEMRQ7w6E06GUH5J
 YaIxggdzUZeyPg/L20gUeuGJLMiQ4PPB0b4AxYEYPeuaPwqq9cE0D9AbC4c/dUWXrrkg
 esbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253901; x=1788858701;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=liET7VlXAaJMypwOWE3rZTmvtv8D0JCY1IBRxnul5t0=;
 b=P32yTngI8KOmSLx24YjKPQ/RFSg45BJceHW/bT2RZrZJ8n7WoKuYrIgixjCMttZJGL
 F6mUccCP6ecoRfvz7Rr/GoL/m8eUWI0roHHZcLTtYtuxaG8Gqy+cHr6q8pggsHubpJ3+
 2yCWo0QzSlpKXAJlKDaloLrV/9/RUQHE4ug5zhJxfz1nYIRIzcxrFZItaWnAvaXx0Tdv
 o8/E0+937Lu4PN5YnytUIqqLbJEi9q0djM0MUPngQv9vyIn8qKBcKqgBeZOdHSbRYyD6
 RUbG3PobxmcWdpkkLotrFIzMjTtsKeInoAtBUYa9AitFLiipIlAshc3BUVXCZbuqg9g5
 5RmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvlpvwoWm/pvgYtnvc5BrHvAq8y8FWPVqBQ6l6DAGxVEIRjO2/eEkVuZEUvV1n0d24o5zkq6CryjHc@nongnu.org
X-Gm-Message-State: AFuF++nLOB7mg5Wd9R1NTdZp3aD3QFs9TioA32h+Tx5/EBVAkZR3CjGx
 rn65FOkxnrz3cKUOg36RdsM+yqwip/xapNXOTACQjHQEFCLcJkv+Ay5Cgc1qgnuO6emmg70SHkV
 vGQNVMvT3x7FKxsONfUACWl3TbD5bJcOGyA1QyeR4Rrckrwd8QyNoAXbdVg==
X-Gm-Gg: AR+sD12YP+xCJ50CdqXpYjhQQJ8KCDh/UteKH5j+FiWLkFLj3JVnhML+wd0cX2AY2wG
 BchaXfUh/j62rs3K/LFiY3FT17gIgi2SZvGqnKeLHwouuyQIoMglznwLZpw8CR2MwAiwa3m9Pbz
 yGE+Vh8W34b4lwyYH9zrF157cgVh9AtmoEMsAPKHhzxamZ5mWrVyiTme/Q8hsMZ5AB5x504lXyC
 1GnEjdgo4+f3JIiC4qbbeHrgT17vtz8KVTjbQjdKf1lnrHCF6YKHBiwUR9wmqOGRWfzVEr1HI1p
 /4hk3Hz1z8bZ0eXJZHa6QhyZYyOrusHQ/KBE00bzzi4pRGOWJPbnnx3C4dsurCqCVEAVV9tMAlQ
 lDHvZriVijTQ95gsK95ssDTqtD11tZTE4WQ==
X-Received: by 2002:a05:620a:2895:b0:930:a64c:1556 with SMTP id
 af79cd13be357-939138ffff1mr541792685a.25.1788253896340; 
 Tue, 01 Sep 2026 02:11:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2895:b0:930:a64c:1556 with SMTP id
 af79cd13be357-939138ffff1mr541786485a.25.1788253895783; 
 Tue, 01 Sep 2026 02:11:35 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d788dfsm3316027f8f.30.2026.09.01.02.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 02:11:35 -0700 (PDT)
Message-ID: <199b78f4-566f-455e-b3cb-3a572482c91b@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP
 from object prop to class prop
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
 <20260828150313.1883999-7-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828150313.1883999-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VWFCT-SZHMKsBhPHJLeN1Ly0EHF0rW5J
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX0N7LvA9AIODR
 Rlrdfn3M1JdVKKps/LuhRVqbPZWCbvZ9XERTWUCHas8HuHF0EwlserLz1bWzfIAFt7oWJ92E2Us
 88vZ1VA86TiQaQm4m9aw3WMRVXLE9ls=
X-Proofpoint-ORIG-GUID: VWFCT-SZHMKsBhPHJLeN1Ly0EHF0rW5J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX69R0xLjnmVPq
 LVGJaEB0KannJ1Jn8h2bn8g5WkMCPsT/Tn3QpvFi0KHTtQeluyoV24p9TDvbRIRCXS6DdDQxMoR
 Dnl4kCRWBjsIUUVE1OUBcbQdRekfqOPbOULBSQ++FjSRoxDPOdFveTI3b/CM9B9EUHFF7ZUzziV
 QiiiLfE8Q2XcywbZPXARo20gwBghINUtRWH6AmQE1sWlIWMZbEo1VrgSLhPfwAIA0l3QMbXUpgS
 nDl4OsuiFh9v2IahJPHWLxxA+q6hJ5dEoBV/02ejbsTdWxiRxqhlx80efLc+szBt/JAGvo6+JkY
 D57Yj3BArl3rV/ZMEpVg3nl3kNFhQaHtda+OxiXl0huXCBx0fN0bYaRcZeyLxAvYl+jhatSVVd2
 filliXUgZeHX1NgEGinzg1QkQU1F6UlksRGYSvif0y57aEiGjCSBSw+raJfDUjFt1TWLgieMWeh
 5mwCz1tWRZJifzgqvOA==
X-Authority-Analysis: v=2.4 cv=BPWDalQG c=1 sm=1 tr=0 ts=6a9696cd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010081
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

On 28/8/26 17:02, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/pc.c      | 5 +++++
>   hw/i386/pc_piix.c | 5 -----
>   hw/i386/pc_q35.c  | 5 -----
>   3 files changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

