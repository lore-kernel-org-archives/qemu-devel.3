Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00424C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTnu-0006PI-Bf; Thu, 02 Jul 2026 22:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTno-0006Ob-Pv
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:38:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTnk-0005q1-WF
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:38:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319MXf2243715
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 02:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ExrjSKnAyYxsm8xWRSJpMBaRySkHSsg9eseU8uSvCug=; b=mR2OCgAnJRAOJd3Q
 R2JnIGrnTllLh1v+QNDl7Ghse64L66IdvKk9V1r+hRWLl89pUBDPuFynLOVU/8eK
 b2w2uY+tpsATf598TF5aJ5SfsiF/ZAlfmDSMCoHSJmy3jy6xyCr3ujhdBi9FwVCO
 D0SDG5DarNG0MwEQ1ySK3gMFJcbKyJ5/NUayrgbpwJpUEQL2ulFCxTVzZA8zMlfR
 aDuep42B8DEpCeIcOk7zvVb5XyPzu853055DGGcmeJt9bAohd4hLcMOir74XeYVz
 V8SezfecTuz8heI3lDEq/eX219Abg4ZLTkp6dqGD4aRUyryE73vXSJDfrf8YrrPJ
 29j1EA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n943sta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:38:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so8623785a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783046326; x=1783651126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ExrjSKnAyYxsm8xWRSJpMBaRySkHSsg9eseU8uSvCug=;
 b=Z/HvUKiAdrGQKo9HzQZuk+e2/i81/42YKLgRA4XWiSPMep9C3JB7ZkJJWE37Gj8267
 hL2ENfUfW+k1XnX3ixK6sAAQzfxynWTnxbW++gG50zd+rt1/f4rBY9t5H1L5OEkEP0+I
 0+0yMjNaMTlan74Ji5ZaC5IulCZs2ORY/KMMjvVYmL5dk1HcvQzKtUpAZsJJutSTGdZW
 x7A+EcBwh5yiohQbpMnRnrASA5zDVJsZFloURY3yVsHElMoZIpxU0WsW3DwWw9quUUJX
 8bjmia6BNEPgOm2ZQcby32qnODXimJJO8dNPRqU7koM8V1qg6/UgivfLkUf3LRM5pVem
 C4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783046326; x=1783651126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExrjSKnAyYxsm8xWRSJpMBaRySkHSsg9eseU8uSvCug=;
 b=efnXyY4OQ2dF2VYcBb/KmEQlr52KptjZiZ0EsaM1sw06+5jzoD1Dm7LV9Ap8Tx2/F9
 XCh3GKA/4bCk3FA5kv5qwlp9o0F6MGudQ1cjxE/F8P5aCJ+DbPtrcJHcaBLMHmrOvz1f
 UHgRnHzpMOS8M+85ibgy62ZBAXQjtI8cJAFKB+HUx3y9n+sCQaQT7yBQWowPht0dIiTq
 CkceQvkXrbY2YZ6u5kC4E1sUh/x2xsOv/C9AO+Qg4jDUQJ8H8PBYVil8RaBMHPl58iVe
 jsIyC40f16/KuGTa1ytFlghbTfNd6RzMpHLfdaw/fHUfcn54nmqHtmvd+oPd56MHFI8o
 YQhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UIzrX0sEc+rAqx0F5OTDbEmAHwI7ok8Ykw1s9B7m6D3yN1bsmay3v8UmM9MCJhJ7zZ/6yCik7swb6@nongnu.org
X-Gm-Message-State: AOJu0YyV+iNtlTAMhixafx0bB9yLVIU55NW1fWQJhPfUAsxuKuORYnlK
 kzVj+Z9h90TVE7nDnw5XT4SA+yHqpftuTUTHM7NzQGoikcRvN74Srn+X9FNMzB8rjxdrX2rAaRD
 fFEJGfFLrUSmcrfoxjNVv8rweFSLPIF/BDk/V7e87wU147Xi30ppWo4/u5g==
X-Gm-Gg: AfdE7cnwTs/VMHhJRlsznOrxY4bf/pIjAsNsu989fX3LraFOdase9uexV0+vJROacbq
 eoT0C3hNYzoU+1MEP+h6/p/SbmpvdpwIEcZRrAbxSvJyO00r8K9U81x73xRbaVuZzmoy/cZD5cM
 +FH2BGL25kkl0L18XixFoOsriS9724IH9eK3z46GqbfQyzDEbjglHK8D9vQz5huSylPv9cwyBwo
 0AFbF+cB2O0aotq08DhwtADTOSVr3TlTfUFMan7XumXV6wp65ykUl7PQQWPweZ0z9NeB0h/Coqf
 KOZdpH4Jfc3OotcAj64/5rejJWQtsaYiUVH+LQfnBMljx7ii6uQh1lR1mH/oqHSvFfFnIyrdOlz
 0n/fSciL/tHvCJpx4X62+YCo5lMNLrhI76r5y67ufBdzVfud4K0DKHyF1uvhicw==
X-Received: by 2002:a05:620a:28c8:b0:92e:6533:26eb with SMTP id
 af79cd13be357-92e7b003d45mr1011179485a.6.1783046325549; 
 Thu, 02 Jul 2026 19:38:45 -0700 (PDT)
X-Received: by 2002:a05:620a:28c8:b0:92e:6533:26eb with SMTP id
 af79cd13be357-92e7b003d45mr1011174885a.6.1783046324802; 
 Thu, 02 Jul 2026 19:38:44 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a15sm13798189f8f.14.2026.07.02.19.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 19:38:44 -0700 (PDT)
Message-ID: <a381b13b-1e80-40a5-a5b0-a30831dd045b@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 04:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 21/33] pc-bios/s390-ccw: Rework zipl_load_segment
 function
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
 <20260703022933.1805010-22-zycai@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703022933.1805010-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyNCBTYWx0ZWRfX80m/Ga64pj0t
 pYNNaTlUuTMCxUWikRZMUYz0c/jL7MhmV5c8aq52TXoUCiAb2wmzfzYh39GQYXg62b53sgEGqlh
 p1clUxDm5Pm3qzJvGy1OM4/CvRnTedTUMpZtNdsFgJL1sZE6uM3JLxBz9lgDbIun6p9mbLRvsfW
 CHPDkvWYgwjuTc651CqWSnzLeUAq6f28YoHYkHuQKzRAHVPbhU+4VzPfVnX7Cgn7wA7joMo/ITq
 usXHyCpPIHCkdOWguryxLT9SqG2RxwiFWeCzjMGubOlZJIBwdMZcFsrxnDnm5D5J/5I3w30dv/E
 bVqBbIcs5diPbvI27tqNoFLnXzP6zNSUyZjwyKNpeyRlHI69lHBQhIT6pIUet5lZZzqU1mel1jn
 OYZV6w15w0OiUGPkM6QP+r+rvow57/dvzytueZzPKUrgZ3OmzvpyAu6G2NSk91X28kyBGCrcrCi
 SHFeShzGdZhbg4UKPCA==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4720b6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=3p6IwGvMUfKUjqShROcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 0bDvNv0UWdBQ-a_CoH_DhnMH7LjV2HEc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyNCBTYWx0ZWRfX0NBoiMGPf7Y1
 df5qIZE4fCkuMCg4SRKws6cxZ/EBHCxMceua2GEc/3zn/tghS1OfjpA/d2XFjRQlx59nX3h9hZF
 Poyg1nd8Hd0LWXoVG+PVcsexz3+HXY4=
X-Proofpoint-GUID: 0bDvNv0UWdBQ-a_CoH_DhnMH7LjV2HEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030024
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

Hi,

On 3/7/26 04:29, Zhuoying Cai wrote:
> Change zipl_load_segment() to accept explicit blockno and address
> parameters instead of ComponentEntry pointer and return segment length.
> 
> Modify this function to allow the caller to specify a memory address
> where segment data should be loaded into.
> 
> seg_len variable is necessary to store the calculated segment length and
> is used during signature verification. Return the length on success, or
> a negative return code on failure.
> 
> Remove static qualifier and add function declaration to bootmap.h to
> make it accessible to other modules.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 18 ++++++++++--------
>   pc-bios/s390-ccw/bootmap.h |  2 ++
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index b9ba004cfc..b19981feb1 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -613,19 +613,19 @@ static int ipl_eckd(void)
>    * IPL a SCSI disk
>    */
>   
> -static int zipl_load_segment(ComponentEntry *entry)
> +/*
> + * Returns: length of the segment on success,
> + *          negative value on error.
> + */
> +int zipl_load_segment(block_number_t blockno, uint64_t address)
>   {


> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 95943441d3..8d61ac383c 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -113,6 +113,8 @@ typedef struct ScsiMbr {
>       ScsiBlockPtr pt;   /* block pointer to program table */
>   } __attribute__ ((packed)) ScsiMbr;
>   

Isn't it better to document the declaration rather than the
definition?

> +int zipl_load_segment(block_number_t blockno, uint64_t address);
> +
>   #define ZIPL_MAGIC              "zIPL"
>   #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
>   #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */


