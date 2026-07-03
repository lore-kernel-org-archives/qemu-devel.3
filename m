Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CFBC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTpG-0007ti-GV; Thu, 02 Jul 2026 22:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTpA-0007oq-87
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:40:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTp6-0006NH-OK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:40:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319h6d2311499
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 02:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dZSV4k5GsFVRbIjTRwN5i7aHEaZjQo0vS2MQGQr4a1g=; b=OMpH2dx1y0boZbdF
 gKZNcZ3999pYtxNwPXWg5p4ZeT7C661Ip6hhegb79vVSakZEyisZ5UN90h7q68oU
 ddD5hJiXrG4rQ6lNd8Fkidf+ibsbxugvy3GLmZf2YaA6XGnz/3zjFaWp0jivR7iE
 u2dhC5lJWl8Jo2kKcexZPsMyJYpgWE+cGNQnehEAmtUdcOQhDI2/5RWpJUDPUQFZ
 kj9w2bkHCDSZqnt+iOTJ3F1DUDcJp1uB492fHpp9WhbREesvPLyzAy/eFdU1jgwU
 gHgxUn/EU/kmPKLVCrnfwPeAaZIOO8qKtEAzvvj0OUItisf03voKLJvEnuO/BxCX
 tQ6hFw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s252p6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:40:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e632390d2so18698985a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783046410; x=1783651210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dZSV4k5GsFVRbIjTRwN5i7aHEaZjQo0vS2MQGQr4a1g=;
 b=MwZEu7RjsmlkDWmUfrm8VeF1lE+rSgwZFzCQo04ylZORRM+3Q3QjWTw5M7WwzVvK+H
 o0vtY4KfNrkDpJwxmYboI8H38CkFohA/8Dxzxq5d8ofpfK+1Eop0/1I27CVWBO5jkfk/
 Azwg/4eRXjncFSjZDCV8q/5/XI1ScsEMV1Z+ke0nRET0JyksIHyHJcMLezZgYL2eMz8p
 6Q8kci82K4DoYEsbdH65MmcQMJ4NTKYofpY3zPz1QncGxxf3P0PXB9s1WadM8CenqTN/
 kun+c4ATdRUAMB6mERuAW7GsUAuVGk6rm08PhrCErtYaY+nmdurLSDYrLt/GmvkTZmzs
 cHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783046410; x=1783651210;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dZSV4k5GsFVRbIjTRwN5i7aHEaZjQo0vS2MQGQr4a1g=;
 b=TpjGCMvhF9amTTV49tB6PhZFfsvEuzJPU10HpQJRMTAEj1raKQC0k/sH2gkTnOYh7+
 TTHA+oZzmDsJwcmJZZBWRq5G6XThokafRqAzSH4TWkFikICjy5BXXPf+KIfh21al+ZYd
 nidccs1suBSTYzOJ01t3SvmnHOYjRcMGC9Q8Uby7HPeFt+xegHRsFSCTg5gfg3N1eECw
 eV9Nq8qq6CuHIIm64jLUDK1K1KpGQXoZzbSFgLuE0YmYpNxWS2O6jpSTtEi798yZBJBq
 QsLFBiW78D71lDtIrdRkpx6AFaP6goA+asl8flQxyeIS5uGN8hIE6qJxO5V3vGjio1oM
 HhvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+59nde6qn3vqLLSKrSZkVhtQMHFTUXiX2XjHjuJB5gVnXJW+qV9l7g/I89aWQqeMtvabqX238jNW0G@nongnu.org
X-Gm-Message-State: AOJu0YzL8SRMjS1AEFkPeOo8gg3FT1uPVJn/ntFIcVnh19xqYcueF49L
 44L4uluNoUsPQ/jBOt93iukBxbVbNrq1HO/ddKX+KNx8n6iRuWwUAOL7OuI2HbsW4z58p3ShmNq
 7LlYz8YgR4gn+PXEQZ1WfQ2JwMeREtb16M7QS+IjIzw9+lLEfuxUWn8XEUQ==
X-Gm-Gg: AfdE7cnXCij8NkFnKhxhXar63NRUQF/CVY1gv2N6lra0KSbNy7zxn9ROx6MO0t4p4tQ
 JiSUNGj0J4Iw+VNq8K12qS+aW1VzArPDI91QOhDg+SBXp94cpBoRan5UpTbj6+pieozLaKqRz5d
 FcVJEmy6soMqOUTjTOsk7DgYdzVljXxxFugd0SR4xk/Cur/b4ga6xQq2QADq2Ptg9Chfsyu336h
 9c6oHsLISyTJ7UGeyWs1BSRiNzBRBsgjjyoi7ZTwipGJ6xOTdFvp45/wNE4P9U1ksfp8knzN2sZ
 i9d15lCpugQDfXF0OP5L4sDaLFLZoL/0ozVTnmPNQidX5u87Vntue4y3UkKsuTfj0BSP5Q85f1N
 NA6azBSWIsirIRzeA2AEgpiszW/X4qLzsg4BK4/LkkoIZxlbi1hElmhd+2UZvmg==
X-Received: by 2002:a05:620a:6848:b0:92e:7a2e:fff2 with SMTP id
 af79cd13be357-92e7b377113mr1048714885a.48.1783046410375; 
 Thu, 02 Jul 2026 19:40:10 -0700 (PDT)
X-Received: by 2002:a05:620a:6848:b0:92e:7a2e:fff2 with SMTP id
 af79cd13be357-92e7b377113mr1048712885a.48.1783046409926; 
 Thu, 02 Jul 2026 19:40:09 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe616f5sm111759425e9.1.2026.07.02.19.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 19:40:09 -0700 (PDT)
Message-ID: <5f85e2c5-f45c-4add-9500-09dd360df7e9@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 04:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 20/33] pc-bios/s390-ccw: Refactor zipl_run()
Content-Language: en-US
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, pierrick.bouvier@oss.qualcomm.com,
 jdaley@linux.ibm.com
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-21-zycai@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703022933.1805010-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a47210a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=c25KGEIOmd4htE9sZooA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Z8EesH6JP83ClKKXmDNCj1ahOdkOMRm2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyNCBTYWx0ZWRfX+ykla1qa4Xla
 +Q6n0aOyMX/KdNp4KDc9QffeHhK2WqDW7Cubj6iB4x4pp8mHkDAhK57ZCfuL4hAE1ivcnOTnJ48
 JYh6CSgmy3mmdM5LVyBMhj/7jLSlq3NeAaqEC6UBZL3zn9kIJH5WzYZKzlyzBfTRj/GOBznxod7
 0DTJPvL+kV0hGzo7opzmXlrTuEQCvObiLmmpDW734w0/hHtgMUg2JlCXCUeomlo/Ra7tjuXXdtu
 oAoQBE5YH9wBnGUjh+R2MIC0NXjZF4hfhGVZkyuM/yLDwCvBakyp/7YHA1pg6gRrK9D3NrsH4RF
 I2+aejoX/JMrj2cE+E0DhYMG1mRZmrc1yyxW7gtEjDOoSAxtHSzJxGKup5fentDD8A7uym/0vcG
 odJzL1FVG4iXc6E//qI5ztXNG8Y41xWP7xsWqKc6VyILJhVZAYyhAyjvsYdnnQbDRkTk3Nzpv7M
 L8nQdyNcZsSR/xxQ/tg==
X-Proofpoint-GUID: Z8EesH6JP83ClKKXmDNCj1ahOdkOMRm2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyNCBTYWx0ZWRfXwiXBSrKJnoPa
 AnFFMTJNO2MhfXOpsD9RyJf0g8goSABHU39/29wtRIQWH5n9JThrVYVhROfX4IwauF3ykjx7Mi8
 W+6Yo+YOjoNpz7EGqptnFBr5OXT0QNs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 3/7/26 04:29, Zhuoying Cai wrote:
> Refactor to enhance readability before enabling secure IPL in later
> patches.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 51 ++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 420ee32eff..b9ba004cfc 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -674,12 +674,42 @@ static int zipl_load_segment(ComponentEntry *entry)
>       return 0;
>   }
>   
> +static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)

"const uint8_t *tmp_sec", otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +{
> +    ComponentEntry *entry = *entry_ptr;
> +
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +
> +        /* Secure boot is off, so we skip signature entries */
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            entry++;
> +            continue;
> +        }
> +
> +        if (zipl_load_segment(entry)) {
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    *entry_ptr = entry;
> +    return 0;
> +}


