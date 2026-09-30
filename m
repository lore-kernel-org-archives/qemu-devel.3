Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A298CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxx9-0001DZ-Ta; Wed, 30 Sep 2026 13:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxww-0001Ba-BH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:18:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxwt-0006Zf-57
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:18:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE04CK2970762
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0B/svRjfGQYL9HDa7djfpKhodpNOeQzj1e9+Hre0Ayk=; b=IOnkNt3gCD0raDo3
 +0E8Mnf4rfb1EVQnkHQeupAf3m+GiyENqkfjbdFPvXXHyUeljb4+1Ed/WXx+eeza
 RjrUzhWLU4VQ455jgH+iCdbMFymPlW/uKed9FcxjabnzBaXH6RRh/mF9OawJWb1w
 lT8KwB5gjHLsSBVv9X4RtClrO/w8FzQtWZizNLIuX7jM554qZnZXSeeDFIGxBOqY
 ObYyZ1GdvGn0eb1DXMpNl+o9p9LzJvBfKrsYYx3MFtrYjbY/Sd2PJ7s5YmH2me+9
 WDY7jG+phzbyzW1xotyDJvvtxPD9rFNcNVh3FCAvwGlfotiQrz7gB3INRNks1+h1
 yVyScQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhem3ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:18:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ca6095cceso138850385a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790788710; x=1791393510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0B/svRjfGQYL9HDa7djfpKhodpNOeQzj1e9+Hre0Ayk=;
 b=CCpeExe2OogpkS0qTXftP7/LV5d4wkr2tWj2SYupYTAEdFHqnJGHIFLvmldzo5Tr4x
 tjMoVQpzKQSJceZpg94BzuflfU7nJlQcWSXDMhyncTl1NgYcQlyzdM3cbB8SqKoQmKOb
 OhIXg3j30yC0BBetCnoNCgeNgXzbHuCq1cvdBjxLpjtBVWkBc1u4jVxz+XaGzb1DYMu9
 GiB6cSRZXkDExVj4fyuFO2SRWIde9Ad1PnG8vImNO5NTn4xk/vTFLGPyvbTzHcvg+jLQ
 W8Hfr6fGTDM0ZPhOWQWgiq0Mf/VuUqzHvl8M4q5KgmkgizyR2cmLbfBJKMMpC25hfsmO
 5C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788710; x=1791393510;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0B/svRjfGQYL9HDa7djfpKhodpNOeQzj1e9+Hre0Ayk=;
 b=onGi704X4g7z/XcO8FQZHkL9Ykq3nKq1V045KNVEGwcfokC/DV352Kgb449IMI0TPz
 P4NHJuaIG8Q+7QWPsuoo70dJnzMAxjW+AiXetT7ewQENO5k3GJrKWrhoQInvDsRSg+zm
 NxfWyv7mqN6IAjhC76bJWI+iYNAg+BiYyxkTvU5SsGl8HKA5VZ9iQR2bWaSbBSxnestT
 ALHrVkDQpjpIe6557M0ABSAho7CAVxq7z7jXMBa5nhA4qZ9MZBH3EcH6ErVeDiPixoPb
 QTsM5HKlLiLmNRDRq7dzNuLSN4aeqeRRpzpkk3I+hVlCQYGokcIkeUnvhkKXvAUdXGC6
 jvcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/aWDJQebjEi+qgPKBcGehUDCQoGS1wsjd40XurHhu6XSi5VYIiZRnJm6/lC4Oz+LOjHQncvfKTq7F@nongnu.org
X-Gm-Message-State: AFuF++l8xzUsEqhfwNqC9wMbgW/Bx/shEXaGFEkvJ3HgKy5R+WADgCDJ
 ule+OVI3Bj/0DbMQ+YIeOXRPVjx+GeNKObbqBa+dzN31SrQ0r+b2oUHz794flqRgvdMEZJNV9Kd
 X1u/wavUIWP2J1PFddQT53rWfdhzESNG1v09SL31QXdiHCiLiQinb5vwALA==
X-Gm-Gg: AYBFou2FVH0gEFXINM7JEbYOCOL9SNtMBp+tn/MBa6LWTRLgnILL7/oh6msXKh9k+JU
 O9zolSiI5IaWL5s67Z/uNymXNLQb3c13XHrnV+QH6p09ht6zeF/xC1TfdW6uXOnlLjuSxF1AIyL
 RABg/ExgDFi2VFwVRyUcd1U6pwx+n/OYci4TTvWAQJ6p+bxVu7T2MOk/fyBZGu+oO2wJ2X/bGKr
 0bnPP//tls9pLlvVq6FNrDxvFp0lhRmmf22m497NPMYumcaZ/rVIXyPTiW/s6eINATDlWA2/KDM
 YuJF8H5+SlTd41uAUnBaGkgg5l2fF8iOr8HMGXNfWCKqIzhaJpF4vc+dSXttFP73p9IkIqRrVkm
 0sZmsnCPQJXYsliyfoLQyeHloDaSnN+Di2A==
X-Received: by 2002:a05:620a:1a24:b0:93a:17c8:a1e7 with SMTP id
 af79cd13be357-93ca983de00mr367086685a.44.1790788709409; 
 Wed, 30 Sep 2026 10:18:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:93a:17c8:a1e7 with SMTP id
 af79cd13be357-93ca983de00mr367078485a.44.1790788708686; 
 Wed, 30 Sep 2026 10:18:28 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eba0d3csm4992075e9.6.2026.09.30.10.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 10:18:27 -0700 (PDT)
Message-ID: <5c687bdb-9a3a-41ba-97f7-8ff8592e0eb2@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 19:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] gdbstub: set feature->base_reg for dynamic features
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <20260911-query-reg-v1-3-0c04f0c02cf3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260911-query-reg-v1-3-0c04f0c02cf3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OwsofSW-Sn7UwOZ4vsOV-YNaUrUn1-h2
X-Proofpoint-ORIG-GUID: OwsofSW-Sn7UwOZ4vsOV-YNaUrUn1-h2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX7gIDdk3vYIsG
 vcOR2L3K1IROtwhR+AZ2mGG67cfPTWd71n0Lc5EM8pPNowJ8iTlmeUzv7XRIlrOS3POH1UAFiZc
 SZRYSiYXo0iFI88LFvHcgEh0Dl4NWPY02bjnoLN0XDluX+hXLexRlAydpLpwpu6S+uonXd4ZOji
 PsaYe+ftXTNmHlbVVK+XBpLafoRLERVAghK++2nzGL6385fzRvINBVRZQ1oKN+lvCMzZ8I5v+Gs
 cggL86qExK9rOraFOFezfcQ1ra2w0W/B+xW31YHVuT5iCKreN6iillygDnB+ATyrfb/ni7FKQga
 N+saby45tama2kPMCdRTfYOm4Nw86d5zTKg7uEMvWH/ljFv/98LwPimM16DtZSp+UDvaxcExFTh
 fjJs0H89OHtMkUTWSMYqqq2pXyQZndX7mGYpDlMujt76Jnc4s329wIkqq4KY/y5R3fgZcfOkvsN
 5KwboEuZs6A/PcnaD2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX9XVEQrUhjlOG
 9cQtPX3moTpq2H59ySje7GvYwnZpZXfsUwa8QoVDGvyQ7D4pIBAP2zMiAXfaH/SMRnoyQZAkCwL
 puIvagQCCV1GlZamt5JcXed3rS9vc4w=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abd4466 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068
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

On 11/9/26 14:27, Marc-AndrÃ© Lureau wrote:
> gdb_feature_builder_end() never propagated builder->base_reg into
> feature->base_reg, leaving it at 0 for all dynamically-built features.
> This made the trace log at gdb_get_register_list() report an incorrect
> base_reg for dynamic features.
> 
> GDBRegisterState::base_reg was correctly set, so this doesn't fix
> an actual issue.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   gdbstub/gdbstub.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

