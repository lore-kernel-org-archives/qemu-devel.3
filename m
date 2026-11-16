Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h3ncggNF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aAfXFSmB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT487-00052s-8J; Mon, 16 Nov 2026 16:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47v-0004z7-QH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47u-0003Oq-AY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:35 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJem8D2727626
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ynj8HQ28eNPd4SVx44lpviuZ18Si8GhKKrvrwW7o3Xg=; b=h3ncggNFHyVTq0yc
 zuIGL/VsvwLlX+vCFQhe0JJ2IAFC3hs/Cei5HGOk7XXeAQR/ncdVAumGhAQ8fOug
 pX4kipiEzweCXcIsCAWcpOWi7ULhtXpIMoz313N7rppYnhRIjO1kMsjll3dBUgNU
 i2SmbCOk1P1gD4PrzfiX1I4WU3jt3VGJTFj3wn1eiwY0rT8Gjco3BH6xK7SjzxjU
 DN74R1vMmxD9nMmCkb4tpkxQYV2yQi7APU3AHPAUt4MD+OUeckZUx8aB1L5VbaJk
 6VU3vCJT1UAlU5mVjwPRLjpK7nIxiBAAn1HNIwSySBjPTlSPIT3XRy7lkjSQHX0z
 L6iFsA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regfuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so3950159eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864032; x=1795468832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ynj8HQ28eNPd4SVx44lpviuZ18Si8GhKKrvrwW7o3Xg=;
 b=aAfXFSmBv1TNk/RXvd2Wk346Mml0dfP1yVRrtS9nOu5oAKVNub+R4PLn4x6jejPFjQ
 csEFDjy4wRNvaPziO92o2L0AARrXMi2svgtMlg3bM2seMHcO7v/Qw8Ja+PKcfC7Ftqbp
 2AAI5RrdvCSIeKxA4MIok1LU9oyK8eHHtsAvceB+kEFn5ULvBkoOlOg6L7q4Tyv7U6dk
 qbmByO2OBOSPuVUrqOaaquD2cvHltqMwXi5rfXXl4kFc13jp6WpHyuzekwEPIKcS2vjK
 SlB7uTg4YqxAyjZnpRpU6ih3C5aB2oRALQJV9LXjAaE3ONTZnqCEuT395W08mI3XAsWI
 3Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864032; x=1795468832;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ynj8HQ28eNPd4SVx44lpviuZ18Si8GhKKrvrwW7o3Xg=;
 b=ikVMdK95WRJnGhrZoIE70MRH2q3YABKtH1nFzLuWHrUvIsJ8CpPC2u8URfqWcP1QGi
 CtV0RoGcqmDRfp2/QysVZ8Y0SBjysLE2NGzdHjIEXA2N5Hh/4+fM1NDXDPwzwcPCq0p0
 adLVbdGsl4f1swDy9WbcduGB1voRgFTBBNXPETCoCblWqmurWUWe2aXIqTEOkNXB/kN1
 gUQDnSMB7KValOo+Xzq/cMCKmiFidqVcGcF9POlSVem8sfsj1ugvyaPaZYgraR3hIgnk
 VIC1g9V479Zmx9pach0GRqLSKRzgsDqmuMpUiv/kBetXFw8SlPq8tHNjX/prllEsreWp
 57MA==
X-Forwarded-Encrypted: i=1;
 AL+hErEWv0B5x0gKJKtcQnwhnYt5iQfqIOlxaqGdamOWhp4lCU90iG7F4NcqTeGQcctURon57LMw8Xc/0luZ@nongnu.org
X-Gm-Message-State: APuU4Z/XvYqXi158lATZCe9NhERqcKdqM/Bs2k0XPLpjr41+8qvX71uU
 9366TtAiF2wQonz43wx70WLIWXZp7haMb34RBhdIx4PybZgQtmElKP+nUp3l0W3Ekz4VL0k3Lqq
 4z90NsDI26EfHjGWBdkQgq1UcyFSVuq3CmPMGECl2d14pkL6+JRhV0edBCw==
X-Gm-Gg: AZFdTZfty9bbHtX492EW1+ldIiVJhEhrxzd4rGZHtFn5i0dFU/dbVwFktbkamaPIWLF
 UHksaj680MfY9FCjoKRHO0ydBO1aAQpZgRYYIvDDhvtBkdDozPh6l0d7n6+ZjkCxrN3zhHd+qKf
 alofGSVK7jmzcOziRCWDeNt6Pl1Uv+OekMDkFejwR54OOA3SYW8wXqOL1WUihe+gtXYICpE/hkk
 WULi04/f/xCqeXvVR3OOlfrA4DJSjwOUofzlGSPVmHSWyHskIj7+hR3GX0+k0gm5phYQlSbwKrB
 RRd0RGaoCSfvuSGIAIfDL4TvvOtfi1lrwMr/z/Evp4tz76f9vrOm6rmiKVYt7AvTOY+5F1sWNVr
 +Ggxw5tNORN6qFImHo0audvwd3xV3g54LligtETkILCYkYsTnUyGKHc2cBVmub4fZ8/SQ0IgeA8
 j4/BlxJxlDGajDX9A/5eismrMOuYedaanKqfuJ4DsKG/k=
X-Received: by 2002:a05:7301:628e:b0:37b:e01b:9f15 with SMTP id
 5a478bee46e88-37be01b9f58mr6510767eec.24.1794864031929; 
 Mon, 16 Nov 2026 13:20:31 -0800 (PST)
X-Received: by 2002:a05:7301:628e:b0:37b:e01b:9f15 with SMTP id
 5a478bee46e88-37be01b9f58mr6510743eec.24.1794864031369; 
 Mon, 16 Nov 2026 13:20:31 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm35450830eec.22.2026.11.16.13.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:31 -0800 (PST)
Message-ID: <7ee46ec7-7c81-49f2-b71b-0ea2e874a167@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:20:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/48] hw/xtensa: rename the 'virt' machine to
 'xtensa-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-29-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-29-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX7TrWTTcb8for
 aX80x87RUBLGylNOdCCiCpRGpSLjKAurF8tORDDF09O/fUzONmYhVQlnRNDcCidJnWonkV1SQzf
 Y4A8a/fpAHzJ0HihWXIkfMV4gAgqlrA=
X-Proofpoint-ORIG-GUID: 7xzQN9KudzYzpisBJ3Xdypp5Ii6-8vii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX9BLF/5HPIFQX
 Rr05CtceFw4SmATXD2+bXpM8mdqLnBoeMH1wiCryKpQfIxYoqs4m0q+RQqDE5FK2cRXfBJSAQHC
 zoi4dG7Ak1xBrBfO9yCop+yAAa/FDG17m0CsRTuVNG0F+B+25D71NicowTbY/GLN0z5LD91sqgc
 y4PmKUZ3qnvm9cRkU+mI3FurO5G+OYlNQEDaAniWJfSUm+m1mT3+Q/pZH8CjZOMFHiND854znql
 8LxbAv9iWr0Zu0th2TZu74N7yw1pSi+euO+On/MDLr/X9oCxsRb42x6odac5GWOmho41/AAVgrU
 tvJy7XxqRJHlpBF6oi/pH07rUnMlm28H+HMotoHyBYoqXbxYfRHdhjCLJXzUBhW/mTXroaVeve6
 RewOIXByBKD7KvuslHbls5sP9HowoYMaf+22vaCWdQKNNgZ/RSD+361UJ5BzCSEDRmcg/Biu5gc
 xMO8rvjW+yzKPDi9knw==
X-Proofpoint-GUID: 7xzQN9KudzYzpisBJ3Xdypp5Ii6-8vii
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb73a0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vX_OHtA2jq_LGBKDobQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This introduces a globally unique QOM typename 'xtensa-virt' for
> the virt machine type.
> 
> An alias is added to resolve existing convenience name 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/xtensa/virt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

