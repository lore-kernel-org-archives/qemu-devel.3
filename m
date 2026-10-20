Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969F606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=klrIPnxY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DDWP+qS1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFCw-0002uD-7t; Tue, 20 Oct 2026 15:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFCg-0002rT-Qf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:08:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFCc-0006F0-LA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:08:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7k873461752
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U5/Exz03+n6fa8QLCNMpFRh1g/AtYjJpWuGIczdf1mk=; b=klrIPnxY8SEQ1p0o
 Sbd8Nl19QIZYl2lhHVdeCSmb10UmtZ7LPlshcHG1OEfklPC3PMj+gPWnlXDmpNNv
 pP8XUGMNazEyzQzABZbVQp7S2HP3CQYxG8a/ssH8nWNdNYsMQNthUMnW0arKeV8L
 w4j50DsP7wX/CHgT8Q/VBjaFBOieJ4qdlddOTNgzzaEyA7vefD+3Nwa2C//DW7RN
 M50sWAQwb9NkaN2ffSUwBmKgh2hyl3T1zkSkEy26RaGyjFiIADGEO2/WaeuCsAee
 bbvHzUFLDz5KzrP/trU4uDzNu11iicUL/jhvyEXhti6OX7oBvIihnC2w3H7Xhjy6
 91mM0w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4r7b6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:08:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so10042634eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523328; x=1793128128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U5/Exz03+n6fa8QLCNMpFRh1g/AtYjJpWuGIczdf1mk=;
 b=DDWP+qS1sWAo+i1yOaUvmqGorADWZmUSps+ijAQ5FfVB7zofoAmewmUuJhpv/Sgx6W
 n+83wwkQ8X5EvOzSd1WpONjXvuEITqg5wDM7sZZszizEiqn3MWKoazEGkxr07V122CCv
 m6cK+nQ47IP0a79CjEUhxe0KrrxdtPBC7i4yT4krJ9xlAzSOxtCM8VeqcDC68KmCJT7T
 96FUh2LgbSHI1r7PcGi9Em/UQc7gMl2I1WwUUTt06snASTZYWEQChQeEvCT/t72RvDbI
 49DVxna2VbAa1YF3cMtl6gG2LXfVIlNdw/18ZUphnTaGRrvJty2y4ShzSsIIBnSdZOCT
 Z8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523328; x=1793128128;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5/Exz03+n6fa8QLCNMpFRh1g/AtYjJpWuGIczdf1mk=;
 b=k2cgNSFr8lqeVbQxZ5krRXRv2j26TMJC9eJl646ONgWim/1AjYp2h8yFZGSJ9h8pV9
 SPbwClQW6L2NrwctyCQ2x1JMzOe5JN4DwLE+pf7AQQ32cyl7j2nXPGFjXsnRlrRjytOg
 EYPkKKgqZ3JKPM0A502ec997DL8qRO7lUDgNDh6Fng6O1gezxTPBiWlmZyF0hDfxudB0
 IblIkUusp9NaYdQvjNVwaYaQbgUzdFQSuy3ZChzKhL60N/Kl9M0/jLACeuN8YET9oHWL
 TNafBO2OEzxhhQSDOLQq8TKfGj3T9PbUvHcamQd8/Zav5rvH9d4Z7PwIlmxFtIDtjKC0
 xaOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXc65XX/annyT2efbgIetSeKbn/XPylZHvQDfrBpjPcvFZ3hhbmzKzX2GvKz+8VqzLkWRER8nj88ZZ@nongnu.org
X-Gm-Message-State: AFq9FYIoneQdBiolcvRxkGkbUxChmfoUtR6aFEoDHHZlyytciMOpKBxU
 g3gBpN0wU/vSOxk8qu6hxkEzaG4eVLR2ozslNnBBAXOfKyVuD+BB6fhZSiO+0oxmCcrtyvNsfv6
 bVejwnvxBolZO0Hf0w61LrDZw/nXlb7uUrrPdIZk5/WDRK8Gll6qdGDiQ7aZoX2ztaQ==
X-Gm-Gg: AYBFou29ilC1kdDjB2bQjCURpteNHtlhb/1O02VxId7ZZTVMYuhsYAozW01vMYk7DUW
 P9oKJ9zI7OBMqlr90PkXJoUeSvkmyUvHf4RMe625zdA/E22i2ai8g+PJRH4mpNXvNBGSY4GeHMX
 Hlz5rmO+i2vOyN5Ok14zL+Fr86nt5XiREFevF7/jD1M1qiEEZtnZ7DLVZsWe8gOO1d8C3r8ZBGf
 oFTy2T9ii7GPw/epZXEoaDPa5y6/2DPHwWz5J4L/kbnXaUVIDlhhCT44HEf8MTgMIjnoHnXtf1+
 aeJBV4GjQ8QL7GDWZCzpbpMKrN7hvBGK+oea0LV9T0LO2rNCvKQunxNlk595z4XEqB5JzDEzTQy
 JNPb/jkXOOmefo8z7wY6PQyeYkCPqFH9UFSgu+cVJgkt2oUDIK3GG5LT9U/Hnwl90cDqipw==
X-Received: by 2002:a05:7301:5808:b0:360:34e4:39d2 with SMTP id
 5a478bee46e88-3674d44a645mr281819eec.10.1792523328055; 
 Tue, 20 Oct 2026 12:08:48 -0700 (PDT)
X-Received: by 2002:a05:7301:5808:b0:360:34e4:39d2 with SMTP id
 5a478bee46e88-3674d44a645mr281715eec.10.1792523326988; 
 Tue, 20 Oct 2026 12:08:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198e2d6sm495482eec.22.2026.10.20.12.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:08:46 -0700 (PDT)
Message-ID: <d43ba7d4-b0b6-491c-9fe1-1325f705ff5f@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:08:45 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/27] target/microblaze: Implement and register
 CPUClass::exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-13-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-13-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KTwq_Fu8JlhvaXJXAFQAgI7wPZvSIvPS
X-Proofpoint-GUID: KTwq_Fu8JlhvaXJXAFQAgI7wPZvSIvPS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX8+WnFGC9x8wM
 MHI3CU+S2VqNKhiB4ClqyvWwqn03nUP54oF/K4h7LuAuXrph99I0VKJEo0TnOVzr2mf5JZcXvhR
 8qDmofULY4/7KJCmPX65V4hrrztkh9M=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7bc40 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=v_jT29diQcjgkX0hOLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX0YGrfvS1zwPR
 pfemYuPvfb0QTncXH3lOcwRhJU6xn9AO7Jf4aIy6W+MVNB3fwGA6ja2MoJo6lHkEm3gFRKVaRkZ
 ZNn9QxXr6alktB4uc6kVwG/+J4CH77v39SVWW2LpQRuTkgvQVMYhJ7f1bmxTop8VTMhvmNvcIij
 KGE1lTaVFtBYb++lfQmpiWKEtYmdgmVqxbsaG2ZbOPsJqbbIcqM7q76/a3rp2LP0rNFMjFSqjk8
 RDrOSncq9IgyFW4fvWc1E0w9f2KNBHw1spECloVe6CJolJqYVQME6YvPQQmz6eFs/Behtl4lc2z
 ADL1fdIZkSmdObZguaII5uMTTZxH/xqXNltu77BEIaRGVdF+caO0fm+ksRo9iHqX5NllnXL1qfL
 xqGb5LcFSd/XKXLV7DtgauK0KWH3vaPbHGBzqM/f9BXiO+o27UqgG2uzsCLDFIp/miwN9oK2PPs
 IBfUVLrVaEMPFOPOgOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Implement microblaze_exception_name() and register it as the
> CPUClass::exception_name() handler, so the common exception
> logging can resolve MicroBlaze exception codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/microblaze/cpu.h |  2 ++
>  target/microblaze/cpu.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

