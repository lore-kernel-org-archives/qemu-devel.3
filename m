Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9967606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y3ryEues;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F0yPLKiq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzeF-0006uz-I7; Thu, 22 Oct 2026 16:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzeD-0006ub-T4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:44:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzeC-0000qA-72
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:44:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHBNg3741650
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eBEKfmZRDhlq8Y49pCHVPMYTSYoUPTvliYVtdrrvHOQ=; b=Y3ryEuesn34OeogN
 O5Glr9y6OCjXEeONpBugJLJKMemj4Jgy1cSuZzZAAnrv5ueLb1NOSkTP1609LprF
 jKtA5eqIWj2Yf6ZJkAgFEi8vCt8wIMmRBuChwKWSFZA2uElYunMjsSaiSjy9VR7F
 DfY6LSGjCkMl0zPXnpxHxYA6MXb9sJ2gcMnyJKJ0AypgpXty6umsKso/3+gPntp/
 hAEWlPteY0qh0rR7cHuC2gtixSerxMrlSt2tC9HR/tqzcQ4IlLlJ/TPxLpAIYWi/
 7espNHtQapTDz0xZDCqvLhk4rnwCJukPrasWuJQHLPy3uE8tGvlMN0HB7QyBNqGt
 qLy+zw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0g3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:44:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so672888eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792701862; x=1793306662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eBEKfmZRDhlq8Y49pCHVPMYTSYoUPTvliYVtdrrvHOQ=;
 b=F0yPLKiqSge3bVCO0EOy2wj0LXXO8Pk0lNi+4jc5TiC7OVpbtm2KIwqTgDR+TsOoXx
 /NUSEBEfo8qX0HnWvuB585iVajlkda8+3sy0cQYTJSMVfQCtdO+T3I2YQwg6Hum9Hor7
 PF1w3S1eMO6c9+7uf4ArpAN6qElEei9iKGu+lRtU4MN/EGagjQmkfjbiuWk5NpCwfuXI
 6IqOgwHKcHa2/YXSkyQBj6aIPvJUl79yuPzPRc26wVYR1MT2MJQDGoQNxaDGumPnUJKB
 8guakFyXaZFJLeQSFnfFaNE4Rz2UGyV1ELESgH52nEjjfW3JoGuIgwI3Vpgv56Cbr/Wp
 y4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701862; x=1793306662;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBEKfmZRDhlq8Y49pCHVPMYTSYoUPTvliYVtdrrvHOQ=;
 b=e+MlJfJDrDocDcBOpiCcBxn1Ng/kgH+X3cUa64IGML8Ac7+GxNP08f6V3rxA8LSpUA
 JB4uIopJ+FWn8XA8umtvxdY06qc3KUv7qj5Iick7x3HAFGkvR7KG/bc2LdpFGNV7l+0r
 QYRQdUKc8jdTo0abK6P7KjVGSzKUuZSxsiRqPmZpXU7krHwhQRE0DNvVRGimhjNlxzsR
 f2RvCWpvMX5dzOFlsov68kDInvOWF9B2vLyqGlJOq/SF7bHh+dp88/sPePN1ORCbAbi0
 DdKWiphFubND+14DvB0sYexiEyGr+8HXmbL3Z00I0fxKwMpttN3c1/v8gBkiOs1hcrHG
 KVUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTuTnRlHpirB0glplvCpuIWr6lZe0UijvKS9C9hGeSayU1337luri6f66ehORBXYx9YU4iKr4odcll@nongnu.org
X-Gm-Message-State: AFq9FYI/twMJQ4G5FZ+lpyzLPbzWibFnvIFkNpc4r1wfhyN3QZQdbsJG
 8xGjJmxSk4AfW5NTvH6g1oo2Ptbw3iFdPz1ggAIDqEs8kKCcwsny2rSx+KTsbkbxSuFYB4V5izg
 viE2OFbuiDOaGkAJmXQoZFPb0OtaPX1ayrGvhiYJ2TwG7XYT5T1E5zGTX7g==
X-Gm-Gg: AYBFou2j29G6p3KWdZoOdEBc1FUcYzeLvPt6vsv0MpxWIheBgL2ImmRLQFp7zoR7RKq
 PdEI++ZdHHmpy4kBjn4tLIdTjpdc2Z4eGIFCbg+F+1vwdFllOrZp3mF/v7etb9UTr571BMTBmRx
 nbE6r8kG5qkLMb8OU05yFKjxfiFzPnRx1uBGr8hxjFLDCoEvu8tUFC37j3ojb9v5hu41kySUcmB
 ShhsStEHozxYMPIID//SXRFwgyGixZSWClOTxz6wq/jBKaHXh0Gqcqg5Eh0PsIUEs335vFxvFLQ
 fLcxJ0BH1ExysEH7W5NsXGQmivH2IXk5Ac99TqP+dHzi54cdZxvRvbPCarfvw3hQtuV7L9YhXpw
 9JSxW+3rusnMyK9hQPP41GSNe9/0ZRMPMc2fnqOxPAohC5l2fS+1DJVZp1to1B9A4GFyxDA==
X-Received: by 2002:a05:7300:4f1b:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-369d97e838amr313668eec.26.1792701861385; 
 Thu, 22 Oct 2026 13:44:21 -0700 (PDT)
X-Received: by 2002:a05:7300:4f1b:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-369d97e838amr313584eec.26.1792701860617; 
 Thu, 22 Oct 2026 13:44:20 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c145ddsm407428eec.1.2026.10.22.13.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:44:20 -0700 (PDT)
Message-ID: <035966b0-1999-40dd-9c85-abc313a93d80@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:44:17 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/18] MAINTAINERS: cover x86 GDB XML files
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-5-7ad902b9a7cf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-query-reg-v3-5-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MiBTYWx0ZWRfX8gnBozGTrkkO
 QuVlcJQMw0UBoiT75Xer7Hrmwf0fWyE+CBRhGCzxQOcB5fnDsCw8AJBt0MgwduTMrCaEauqd5k0
 VuKMKRlSf5sMiA9C0GoWCC6U9j6EXCIH8bw70wWxbHTxI4Wq8Gj2baCOZTCB+rnz4PjXkjTxEFw
 y9M3fh3lBSu9UnzzqkTAJAZvVBepl+wm4fHcqgKKz4OFkF4URDRgOkuzWESpWbE9FbjFt3jHuiy
 VsmVpm0jXXaPQbZdg8cUQucYupukTvDqIcX38i+e3p3YSvOdOVB9dQdxJBaCBhpwM+y7a8+JesG
 gy8sbRnxbE0mblS+J5UI/+J9QNzqjkPR7bsJKqfmcTk1rLMGw1HrhxO0tg1g+ehFwxCsjowcUX1
 6ZvJv42sGLAULD+xC9jUNhvKW7hxkNc8LfFMoVVgAB92ja+9XSQU5Wblqo7nwiNUS0CwXWi5qFo
 /pizQ3LBzdK395xDVNA==
X-Proofpoint-GUID: 2tCSauFeyjDVfYTJPvd0waWqWCSzcXmL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MiBTYWx0ZWRfX04Y51nY72QQ9
 +f7eI6Wzm6flWTHrPsrTdG11Q/b6RQVcHWqDjORHuU8Sx1H/HgdMRch/u3YnSfLIoLJnEwDlsmg
 FntnZusZ5U6LKfo/4Ejm9DpTWtiLS7A=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada75a6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WhzuZZbzbfkQEceezbMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 2tCSauFeyjDVfYTJPvd0waWqWCSzcXmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 3:56 AM, Marc-André Lureau wrote:
> Add entries so changes to these files are routed to the X86
> maintainers.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

