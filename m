Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2284606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RHz57zfA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fyTVWYz7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFBt-0002BE-M5; Tue, 20 Oct 2026 15:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFBh-00026z-VI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:07:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFBg-0006CY-2l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:07:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7knh3499176
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iWdRbHvuac/+aGjDcbqEsk6hnvKsK5WAfGIwb3coQ6o=; b=RHz57zfAgM1viSNJ
 GhCVYa9/dEFjozqWQ/Lf2e3xlMvmREUcWkNCqIXQ3s+4EPKOBODDWl2PZIHm7Da5
 orptx7NVrQlLryZrSYXy4JHcZHLnvtVZqOMNyuKyGbBHGY+jUwg7rJRCy7B9daXU
 CwxX0J3A9iVaqq1Dr6MdjhLv257CxQg5nXQ4bv/HSjwdNmpirc38Cbje0Ee7ZGBm
 vZmru+CY87DDCmCsIHcWnQnHDWDKU83eX0m3XauHs9SaKxpXistC2TT8WV4fdAr9
 0zpdwLIpp/tWRvXmOvqTAdpgvo67jXL72NshfXfTHlvJGV7GV+rETWI35Muaz6lS
 lZ0qWw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabg76y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:07:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so7813280eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523270; x=1793128070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iWdRbHvuac/+aGjDcbqEsk6hnvKsK5WAfGIwb3coQ6o=;
 b=fyTVWYz7mibuE6RL1Uz0lLVHegEHaur8UGX+IxkcBc03NvxBL4acBrzFBbyzs2GwD5
 TBaVPgjyAnE7F1ZeKrfGapp0QCqI41Cc4tP0AmL41DWq8KZJOi35WtzC+y13h1CEesrr
 hst7y9WIAnfJuML0a56JKji4oMBspm4RN/BBcDcWZchMg8J6zuY1exiUNcdmboaQNq3a
 3bSxtdRGACIP5rsRJHgz0rLg+GoQuqAFsGwrlfYbP6AUE6oXC9PCA74RCyAJLnS5aAXb
 ex5EKCpHV3Cs8yw5sfyfqAAWtHNJU3T/UD3LmZvmZ/MniTBynoRq9PS09EAOVFQMAeZA
 WH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523270; x=1793128070;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iWdRbHvuac/+aGjDcbqEsk6hnvKsK5WAfGIwb3coQ6o=;
 b=CepYIn59ABR24KCMyXQ0W1uKxxnOeV/4qnCWYpD8dscVLAcVWgy23/7nN2E4/iF107
 PRGsslwcG6XZvGqJNIoY4+Q+xGnUzRG4NNAOIi1MooifxZEuVwnSYdBuS6Wcy0NGzQ6B
 PrHiAqRBazvQNfG1Lc3kNutI+W/N4sHC2RsV9nqoq9kXhdrrTm8ouYgRSEf08lg9144s
 T5rggOfbrGO1kmm4BoAon+4ZsjSmQJOky2T0eFzj+ihKT67aHQzB40ts4B5KuFvVnswF
 7xxvTDRGUEdCiizCqp+3NBG5AQTg9DZZsz1MdqARhPWKtW/WEWJRSwDu5zabiqHD632/
 +sZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWnutrq9NdgDlR0OlqaWgdQOE1TOJSlFHdxsc7fLRXVhUlbJk+3sPG2Z7+x4Yl9Sd+D6xibedr8lue@nongnu.org
X-Gm-Message-State: AFq9FYLySJeIMgjpgh75hcOCl35w3PAXTxXkIaaGnWHjK+9/mbVssGbf
 yMZuz6k0ivGqln+ibN5YLNvXugyseIr3aagbatNu+G/U0vo6HkkMrLHay6fhJMLgjwzvTgtYI1R
 A1P0VMcX+YH/IT2y/Lktgwvc+RfYVgVrQ4e2Ts9xJfcdxqFMHFlfSlsA+qQ==
X-Gm-Gg: AYBFou2DHACxfeot04Ko6HvBadio0XRTqRCnSvrgnwdGJ4ygGl8hu8edwTq9esGW7yG
 qdKSI2RQW0nwffYOA8FPwrGnRHYEDUzQBNhe8ugqdm5OWZGRC2zE+Ndl99JGvuVxRBoEKLt8eI4
 nWZjGXJl5PrVu+pcoWkTCgBonWc+xfGav7ZKsuJEjsX2fndMwmbbrWwGs3nQ46hniBQngCkbYEX
 7OyrT/xad28xaheeNpJz3ebGd9Oiy0eZ9NVjtRE04asDGKBafYWOcVEQxFuQ3eHzRnve/OIHFli
 jJ8Lr/pxQ+p6MbIQ/JuEDkNM+qDjhgLjKnNA3/GNj7RrGtvZlBg1cEXUKDiQ3LZbaEBSspH9Iy7
 sT6p7Rn4d2W94BDraJOkZhi0UKIuNF/kuXDxw9Ddk1LayIjU9BJOune3l0PylQAa3kRNuWA==
X-Received: by 2002:a05:7301:4390:b0:366:4c26:2968 with SMTP id
 5a478bee46e88-3674db4d01cmr215898eec.26.1792523269453; 
 Tue, 20 Oct 2026 12:07:49 -0700 (PDT)
X-Received: by 2002:a05:7301:4390:b0:366:4c26:2968 with SMTP id
 5a478bee46e88-3674db4d01cmr215867eec.26.1792523268871; 
 Tue, 20 Oct 2026 12:07:48 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673e24933csm596462eec.1.2026.10.20.12.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:07:48 -0700 (PDT)
Message-ID: <c64c02e5-d05f-4aef-a929-a16ec83e07df@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:07:47 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/27] target/i386: Replace magic value by proper
 EXCP0E_PAGE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-9-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX3H/ezE9w6ITj
 wwP4+fx4S+VnIAy7KEuqDl2TwEXnPO+5Ry9BAG6ljeBhhaUWENHhKdM5rQxDoQrK1sz/yT+gl9y
 s0j+nIFUm21zoU46IO1QG6hQWxbECas=
X-Proofpoint-ORIG-GUID: i5V3Pvr_lXwKlpwRv-P9vP_abvzOo5vK
X-Proofpoint-GUID: i5V3Pvr_lXwKlpwRv-P9vP_abvzOo5vK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX2IdSVn39pAbH
 WUJHPKuBiij4Ms8E85JvddxvAspFZ/XbV0eIWj1cVfoZe1VHTD9CqNObK87zA25FIIoqnnr7E48
 vubXUgtNq1Pk1uTFxTaf8yz3tMUqHpMGqm9Y/g8EzuvU2iAChvLYQ2++fiJcSNrSCQGFGsbho0b
 131lv3ohIn6vrKXTpBeg8RTQygSHiYGaf63mTbHk6qCEFZrukerEqKIhokwQW2W3CsPEmCTjM1G
 Lkx8S3G6G8ejKrFVeACF7k4vjD20hwiRkqJK/skXYzZn+5xDctSbnCSdcBuYYMxnbTXD5+JNZc7
 W4imrsU85Sayb31tpGRd73g1TArPwrPMPoUmccHmENnT2WFW1BJKGq/xQPNjisOdj0K/BrCeGQh
 9cOePNqjHHJz6DoASfVRFxZzjvnTloagtFGqBwCngMjyd3Fd9Cv6V5HTfKjZhAEwxQPPD0q2rxz
 EybbK4L8hCMvxAPCdmA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7bc06 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pciGpJx_betghHEDYDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> No functional change: EXCP0E_PAGE is the 0x0e page-fault vector.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/i386/tcg/seg_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 6d424349a58..138d2384b18 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -1215,7 +1215,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
>                       env->segs[R_CS].selector, env->eip,
>                       (int)env->segs[R_CS].base + env->eip,
>                       env->segs[R_SS].selector, env->regs[R_ESP]);
> -            if (intno == 0x0e) {
> +            if (intno == EXCP0E_PAGE) {
>                  qemu_log(" CR2=" TARGET_FMT_lx, env->cr[2]);
>              } else {
>                  qemu_log(" env->regs[R_EAX]=" TARGET_FMT_lx, env->regs[R_EAX]);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


