Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D567CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBQMJ-0004ZA-Ou; Tue, 29 Sep 2026 01:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBQMC-0004Y7-8n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:26:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBQM8-0001bS-RZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:26:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47IfO3391345
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jpd8CBJugfETkbR85ahF7Wd1aLx5DAhy1NA0fIAAcBk=; b=g7H8i+HE1/gIMjnt
 9n8xuvpbpUwtSh27XrPTvN659ZsSrb9LKN2vOOTJR3CkxizUcrnDs/iMRyMmK6SQ
 qp4ND+CGmscV7T/tDd41lXoTAT7WLXM/u30aNraCgmAIyM3WME9evsDtaZqpec+O
 2DxaEPKs81xebpxZNsFRSPJfZvmtWP6AdcGKLxdOEVXbF0mQd5P2ZcOX0syWV98z
 niY4QdXommEl1Gzp9+qVxE7P48heH2Ol4Ux2FZERjsMqmz4ZcwKHAjZKeClRoJ/j
 u/8A71cTF4C9fUflVulcjUbwxqRvMWNqaNPzdM+ZMA1G/CjAU9QDsudn/VN6xDK3
 UinDYg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkh2tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:26:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so781854885a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 22:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790659579; x=1791264379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpd8CBJugfETkbR85ahF7Wd1aLx5DAhy1NA0fIAAcBk=;
 b=ken2vv3akGRYY1DGbzLwwhHC0GUlObpNyGim1rCbNL8Dz3G2l/JpCk62yHLcjoZOX7
 /EhAUqrniED5ShkmiCfEVyPVdAOlw51d8cmakc/bojUDW66TbeABfrgMAeZrl4UU+uCH
 1VlMZ2t0f6zlKDjHgQIsNmbsFRuGVfXoGz7wipzyR0T428v4MDLMFcgCy2k79deKxEgf
 7kZFdoAMzalzJKQM0R+cGuF3E7wCNdpF3YwSbRkbjCOCJuE4pQHDwv5EBplKwmqbcs6M
 oxG0WI1dHJIUN+TopVPORUAXjHOMFr3nuf7A9xACYb9Wgq7YTuflzXBjdR0QGbH7hzlh
 vg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790659579; x=1791264379;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpd8CBJugfETkbR85ahF7Wd1aLx5DAhy1NA0fIAAcBk=;
 b=AkGQcgim2ugBK/13c/TMCRfUJhJtWUwIGaJqye4n8vrBFh8Jv2NhOEfvWd0gxkj1yQ
 JYd3JlQjzUmBXx+vdy1Fp0vrRw6h1mhX+zwSCCI149e27zvw8CyKg+0VGFVZIEyduDCE
 dcCDabgQilf7vxnuhOxe5A5fAMsSrCfrRa6NyohnyaTXnS1FKqoaieOGFaE7APR8YThr
 iYkVLqmO2qfUzzDRUj2yjpm1eHqWa9V6sC3vzsb5KWk1yN4AOTA8gcOj6uNRIUXDhBFA
 7ipVojg85n2GO2na9/0orgDSxQnxNS9zlcOQD3KDWof0YnStwTpzwV6HIAdmFLzGIHyL
 RaDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRTRgiRXYkiqVbBKzcEI3xb+lyzhsWbZl+gTswZv3nivWTEN5o/IJw1MxeuHr+iEWi9znzceRMrfws@nongnu.org
X-Gm-Message-State: AFuF++mse3BGL1xJuCKts/nYSjWlNimtOcKKRfogjefX9MR3bmp6CUUh
 gx5eCATGp1/db/MUTAJkSTsQykCSAulAImEOXN25jtVBRyExuwvqYvoQia/VcehCJFp/UAEfrvg
 xL7jlo739MORgZxkrcjo9GRPvkWa/tufWw1FDhfNBmg2SMpuwXSlgDlMxSw==
X-Gm-Gg: AYBFou2NNtq9SjTJPl1D0sAF1ASj3pGTF9L2uOMYDPFIiFB2E8PgZF+mDA7z2XYA24+
 Rw/DNiq1veK8gRQHTFNlhbVjncIV9AEgiWas/dxd9sYZMMVqFrKXPI5yKvhnEtVvO5mjaHXhYTa
 gZoRhEvGM0zfCZikXLyTLVKqQRd4m7SoXZrmfoTsqNbTLn+SBbZHSzZMnR9k3iB14Mrlm37S8uS
 cNyeYFITb4d8rOBUJbrcbKeboMDZkkFSLdSOdzB+hUDup8/uqNMChGoQOXcP97xRrcGza9B5sW9
 EJOKb5oxgmIOjKV9zt1x9yeEaj0uqnx2mZ9z7HImJcjiQRCSOzE1QwcEduGzHCsV0EYH5jBcvJl
 kacL0eH5Yk/WPbqVcjMlG4PZgpHjSm2Gpug==
X-Received: by 2002:a05:620a:4623:b0:93c:29b3:3525 with SMTP id
 af79cd13be357-93c43ca0058mr2531052085a.36.1790659578861; 
 Mon, 28 Sep 2026 22:26:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:93c:29b3:3525 with SMTP id
 af79cd13be357-93c43ca0058mr2531048985a.36.1790659578421; 
 Mon, 28 Sep 2026 22:26:18 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm47919265e9.4.2026.09.28.22.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 22:26:17 -0700 (PDT)
Message-ID: <0c156b42-3476-4ac3-bd29-f4e878108f0c@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 07:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] target/rx: name guest trap numbers RX_EXCP_*
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Glenn Miles <milesg@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
References: <20260928052051.251-1-luoyonggang@gmail.com>
 <20260928052051.251-5-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260928052051.251-5-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMSBTYWx0ZWRfX3e2QctbyGcMr
 kD63i34psTovwxugp2cZyljEb2zSRXWC1jnzcglGITB3mk6FX0k4NfZSopTlNEn8HKx+H5BbVjl
 eUE546ShURxX+qdNikE8AqTjmw5GMFt/mGCH31RbLp+XOMPzebd8NUZ16n7t76/CIaobf9d/ydV
 g8ZoRFKdiy70q0dUe6lKjC1TEBLi6nclejo+VW6uzs8EmTqLmCQudhsPScOnlqngzVmoYquDo4H
 k/aftt6pRpZMk7vZC5RFX8b+6ywfN5B9uzhCwlzNrRxk0iOeNnqcxyL+wM07e+Sk8oXSxvZP/7X
 mgaMWqcqIqN/WHg+opUBEzNhm2yQNMMcVzKEoGvftteHN+tWz4Essfbi/d4N9ZNbORxMByvbDqC
 SxUpvo6LdXFrsT3SblnE5LIds8skLFcOC5rowv0fmeTiXa7iweilU9MRQt43h+ZuSOs2qhVv6UD
 NsuBhZJu7fennERs0zQ==
X-Proofpoint-GUID: stJIgLk6kYdPytzV0btSPP2C19yYU66Z
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abb4bfb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=T3N3I3ExGkZWRGUW1XMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: stJIgLk6kYdPytzV0btSPP2C19yYU66Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMSBTYWx0ZWRfX3iDAJ8P92+Qb
 DBqDqot8OvCwcV4bM55m/P6pyjnBvRpyBL2xuh+lCtdxaoUuBNHnvgNdRGUCFQD2wCdTJLJWFAY
 pmeSxmX2jxSN/SnuyVdkRryRrqOB2pE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290021
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

On 28/9/26 07:20, Yonggang Luo wrote:
> Add RX_EXCP_* in cpu.h for the guest trap numbers stored in
> cs->exception_index.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/rx/cpu.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> index 64ba48a7329..521e494172e 100644
> --- a/target/rx/cpu.h
> +++ b/target/rx/cpu.h
> @@ -71,6 +71,16 @@ enum {
>       NUM_REGS = 16,
>   };
>   
> +/* Guest trap numbers. */
> +enum {
> +    RX_EXCP_PRIVILEGE_VIOLATION = 20,
> +    RX_EXCP_ACCESS = 21,
> +    RX_EXCP_ILLEGAL_INSTRUCTION = 23,
> +    RX_EXCP_FPU = 25,
> +    RX_EXCP_NMI = 30,
> +    RX_EXCP_INT = 0x100,
> +};

Thanks for splitting in a previous patch, but we want to
add the definitions and replace the magic values at the
same time (i.e. the changes in rx_cpu_do_interrupt() in
the next patch go here), but also s/21/RX_EXCP_ACCESS/ in
update_fpsw, etc...).

